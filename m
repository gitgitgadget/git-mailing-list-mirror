Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD978C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLCFim (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 00:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLCFik (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 00:38:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AC4E6A4
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 21:38:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10164518pjs.4
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 21:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbKANhiDHoRvuYsyhc2A+nnMAlfMzfKgJUIVlxkimI0=;
        b=McLciAU3lWNMWcQ/gxtdm+atmG95ixP1vpDYNbENl6nFVXxsEddztPTvCDmDlRKmqG
         RjDkdUWYcpv5+Rrb8H1AAz3M4L9EKVk9VtQxSr9mp8BB6SlIET9rY94opb87txpoyw/g
         ofeHcZScgAGu0OxXMWWMGrN23/V0zNhiss6mHk32dA2LwVtHukIs1NNrue38BEOYjRvD
         24PI24VZ09rLl6H7ZtdrpVBl83bU/DlKvAaizbzB5H1qoIX0pmzeIk7uC6oz1JpMRx47
         pOhYKZ+JmUn39LlXLrisTg16tM7jilSe+2lQN9UYX0ZNK6KhLhiGBFfVX9YBoWOFVbXG
         Izlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbKANhiDHoRvuYsyhc2A+nnMAlfMzfKgJUIVlxkimI0=;
        b=rqj4mffNLCWFUCydYcBohIcqxUwz4sQ+E/6p0/cA4bW9FjBPBTDkzIzzCJrR7uNy7f
         6FF9PqmGyOTi8Lgaz+r7Wvhly0i1dymAv5ttM/BrKkL2dcpzOrhROv0nwhuuDf4DfO9o
         vxE8/dDYxes6Mu6g+wmzAojxUoAh3K3jpfsNNH2zqElPqKLoeBCUJZjJsN4BGsLSsAnC
         DFhm276CELlDr4Nt4AzSOTwJnVtQr7DT03pQF53+PuTTg31kZ2775dol5OY2L8P8sI3L
         FgzBBRGvHdISQMqMQrxEbovpCPkdt0u7O83PaSH6/9mODw4dWsp9ZqotxtqTUKdFJjVB
         EW/g==
X-Gm-Message-State: ANoB5pkC3WtmGCvM6RyI7NI6W7xi9U85BIKBNDjzcXUq87dTLEwksHLj
        vtoXADJ0ZM/B+QrwCGsR0UROzG8+uJJzl0ic4NM=
X-Google-Smtp-Source: AA0mqf7lUz1VXBJvngtSc77SLtlZLK583yHYdf0R5PzIJLg7j625rb9B7jWIb89clSg5RoFFraPn843ehvvxVT5wfH0=
X-Received: by 2002:a17:90a:5d81:b0:212:cf2e:2b0b with SMTP id
 t1-20020a17090a5d8100b00212cf2e2b0bmr85012995pji.169.1670045919263; Fri, 02
 Dec 2022 21:38:39 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
 <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <patch-v5-11.15-a5dd4fa1d00-20221202T110947Z-avarab@gmail.com>
In-Reply-To: <patch-v5-11.15-a5dd4fa1d00-20221202T110947Z-avarab@gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Sat, 3 Dec 2022 00:38:28 -0500
Message-ID: <CAPig+cTQu6E4-sLac_WEMJ6NMWCVDenOj1iNdfPib_WociXhXQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] cmake: support GIT_TEST_OPTS, abstract away
 WIN32 defaults
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> +       message(STATUS "Using Windowns-specific default test options: ${G=
IT_TEST_OPTS}")

s/Windowns/Windows/
