Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C11C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DF660EE6
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhG2Cea (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhG2Ce3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 22:34:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C19C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:34:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gn26so7919348ejc.3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iDfq+YsEi5Y1YejiRC2ZKLrXm/sf1oVHZwbrqGemZM=;
        b=q8pKwZ6ipPIaB1IJmoOIN11UAty8gxQfEKSqb7HNHa3vqRgRaVJju6013ZvlXiTYfq
         Ul/wFNCZtPLpDMNX5k9y2HBnJckiNTbF7g+GAvhUqSsDx7B14VGrJahbkfcc9058LQVm
         8akGJh3NsUhrzHYEPkQeAC+50UscRAPmSNSP6riTcCKz/gHFc2q/1glEFaX/bDbTB2SV
         tkaUqgSLD1HMELX/9Yhz5h2123k83uOt6ATwNddn+gBCz5uXrlFeF4nv+8LKm2oKbteX
         6wIjENK22Wq2pcx7unsgZBL1hOe2aVjcqsQkOuNlcJyHbN2A3Ix7D+zBjGtdHnbdEdWn
         ShQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iDfq+YsEi5Y1YejiRC2ZKLrXm/sf1oVHZwbrqGemZM=;
        b=V07xZRcN7ACK9LgP7X8rxCvmxm3NdFUVSDmvnGxCG8GAqnYNtRHqeU2YcjO+WQ+VEU
         jDpVteyO5ByS9r3+QwcbisB9x4xxk/KS/15z/4h8n5UazwxGkSAOYEB23gErTNdjRoza
         3Ys3fsMfETOmYmrMyAWNaEzmgHK8nk3lIDxz+0ZdIbdtkb2WQfjhfTVYTAvjeHSle0Tk
         kKs51ZGsBYwVAIerutirwO164IIc+6dMV/ALEVHRgNsN0lAYWnYUpw4R6joJos3If1+s
         GnWai7wMe/Z5f/8mq4k2AhU54yi87M7H855V18q5DpC14I+B65c0+S6r9fcfsOfhO+id
         NW5Q==
X-Gm-Message-State: AOAM532JRTWc9NXd/mf5dyBnszTjBe6OO8edhHQo9U1NffNgPjPy+JN8
        M0zZRRl5B9dtRKLihCleVnUruTqifGJ5LI+EHp4=
X-Google-Smtp-Source: ABdhPJywZfUvw5XxkuDegLwdQ1ZYHwDrKHU+1PJpzxCnpoJEiAGn79/YPnVacZT7qQbKMgNRgUvij5s7FU2xj+bAfcs=
X-Received: by 2002:a17:907:75f6:: with SMTP id jz22mr2430214ejc.216.1627526064756;
 Wed, 28 Jul 2021 19:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
 <xmqq4kcgkjhk.fsf@gitster.g> <xmqq7dhbehwl.fsf@gitster.g> <CAP8UFD26AXTYPvSzBD1x6hSvK5SNbM0F5BPX5bLEbxUZa2dAUg@mail.gmail.com>
 <xmqq8s1qbdcr.fsf@gitster.g> <xmqq4kcebc5l.fsf_-_@gitster.g>
In-Reply-To: <xmqq4kcebc5l.fsf_-_@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Jul 2021 04:34:13 +0200
Message-ID: <CAP8UFD2Qp-yBP1-YNFx9UG89J3QcLinY99edjtXPo=SqR21-9Q@mail.gmail.com>
Subject: Re: Re* [PATCH] Fix git-bisect when show-branch is configured to run
 with pager
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Oded S via GitGitGadget <gitgitgadget@gmail.com>,
        Oded S <oded@istraresearch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I'll fix the missing 'a' in the log message, but the "res"
> simplification is probably better done as a separate patch on top.

Ok.

> How does this look?
>
> ---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
> Subject: [PATCH] bisect: simplify return code from bisect_checkout()

[...]

This LGTM, thanks!
