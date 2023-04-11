Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E326C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDKHr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDKHr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:47:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4101FE2
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:47:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r27so9291009lfe.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681199271; x=1683791271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fAfy0VHqttNffHbMy3EUwkAlfWU0MExMAwtKri4N6I=;
        b=XeGi0LlpzyNbfQMrPTy8X7/9PontZrIC+U6HbVkSp0a5JyZa2pssfyxIs6qm4kPFgI
         QtWZ5sP4Xow9n9IZ761SGkkdXnLYw7A5G5N34Wwom9gGjtdwh/aIK3Fg06VD3mOsVOLk
         dZ2abxLCOQ2dOi9LZr+Xos/4kHBBy2RyvWX8pQGacX5QGuaT1Rw6LSEIMKbRgpNFTudm
         9dFescSELHJk+4ujh8V9/iTlqPZIrljWJgZbEPLTF3Le9+4P6FVPUPi+20K+PxF2NQqZ
         1eFaT3J5g5IhekbKcKkXkuy48NAh7TNa3tHA4JbpwyF6PNvJYyq/XFyg6RMIht7VjYe+
         EdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681199271; x=1683791271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fAfy0VHqttNffHbMy3EUwkAlfWU0MExMAwtKri4N6I=;
        b=rSsezZ/WGjWIInqtKhtt2zk4NJXwHzJnTS5qYVYmKuGAt3E26UmTxWgneKwOIQMkgQ
         6zNBHhRGxANvWP/R0D01x+ZYqr8l4UVqTNIMIwC26AMH+4MC3vfIrxgMES/lKyxlnxuv
         NFdY7+AAnw+ED5wPtfWe9UP+LyOD7ug6SRnKqiEZ62IKNQZaaWqzQ1jZGLosc4Fx1mZ6
         ukZv806hKrTYYs0IwhGzb/7JkmrnZ34UxN+QGin1XufiiKB4xYGF53hCrSpm1jfXjriF
         Qb+/XHa4NkHpW5cGX50Yq1QnQUqC6TpwuRda7RmKGqpw7A9WwNbX3N0TGUSNXK1P4Ryw
         C2dw==
X-Gm-Message-State: AAQBX9ewRMebYhE94e/JGlJ6L1K87SmSC44pFaxOee1zwADjjekmfQqe
        lAkgT/k02Njkorad0rHenwwzSnWaGRRMSQ/9OHM=
X-Google-Smtp-Source: AKy350boFPrSXeskUnnPgveZMlSCQgwaOVmKnKHSk2ef6SEsQnU+XG5jLplBFd6kcvaTmjjKlyt//VoJGu/x7wPKgwE=
X-Received: by 2002:ac2:4569:0:b0:4e9:22ff:948d with SMTP id
 k9-20020ac24569000000b004e922ff948dmr3803387lfm.7.1681199271064; Tue, 11 Apr
 2023 00:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com> <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Apr 2023 00:47:38 -0700
Message-ID: <CABPp-BGQj9bRXEXumsERXsZ_Pwgc4v=4QiThXgK8UgGwJVYo4A@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Header cleanups (splitting up cache.h)
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 8:01=E2=80=AFPM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Changes since v2:
>
>  * Dropped patch 21 (Calvin is making more thorough changes to strbuf.[ch=
]
>    in his series which will obsolete this patch and dropping it makes it
>    easier to deconflict.)
>  * Added Calvin's Acked-by to all the other patches.

Sorry for the horrible threading.  Gitgitgadget ran into some kind of
snafu and only sent the first five patches.  Attempts to force
gitgitgadget to resend were unsuccessful and Dscho is off right now,
so I decided to try re-sending with git-send-email, and it ended up
treating patches 7-23 as a response to patch 6.

:-(
