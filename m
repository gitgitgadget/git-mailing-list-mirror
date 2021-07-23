Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CAAC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB30060EBD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGWI3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGWI3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:29:16 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F77C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:09:50 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id n15so274761uao.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsX2qs2CnwdnZq2Q3PN6gELGuZIuISWXtbB+ROA26SM=;
        b=LXKE+vFYV7ibW4Pv2dDB2mmN0NdIHSQ36d4TSmO12QjBvKodM08gh/R2TkGyZumDfE
         tFWzGgrH4bFvZkobhga4/DQrTviSQRMceL7re9KCAHDzQa0Bc1k0b4p+vN4edOh0fhGR
         ysOckBjTZs3N3QR26oB4wbWiA4DExVRZ+tSY9ZFKOL1ugcBJ4oN+EVhrdEcjI+7BU3o4
         9Ih/eMwvyasNJ70MvlialIWHnrAmXMBgoaicv8Kx64PHuBOwP10ywsmxZunI6QTmRjV9
         8MznTiVs2c6UWAWXWN4OxOemmxalwxiAJf0x+hykiV+kh8YJ3b6WReP6FYc7f90gbWwR
         nUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsX2qs2CnwdnZq2Q3PN6gELGuZIuISWXtbB+ROA26SM=;
        b=ZPoX3wTzDZjjRixO3WIFKcPFT0zuftG7nP1jml5z1FwFvjH6e0/4ATKSEzBuPzmlZM
         eW7gC+5J8M1uhY+b3HxNoF+33Ty1AmSM9WvdHYZWehDsqsDnLhp5df5bmLYdIwJvmc7K
         XN5X6kC9L5ozEGkFsA9iV1d288A3EF9T68IVmpWU5F5U0JqljueKurC/2zdQVvHR9Y2A
         qPNGkLyfeYz/C8rZ0P1CiFxSr8sOJxQRaE/HpHmavCeQVM3vQy71Ibr6EG+J6LZAtJVW
         JWhoxGEOUGopP/T84H+qWaYgKN1w33Otc3hVuoUdo5wIWUvVTvkXKW/f4neaCV6oTmAz
         YVcA==
X-Gm-Message-State: AOAM530VxD4ym7K0AXmKvelSIDBNkXqIOAsmmeKtS4DHnP43mVgzgepK
        s3YzqUq2imHL2wPCMjPNXmPl8pNX3xg312AcSYw=
X-Google-Smtp-Source: ABdhPJySctsvNHnb4RvE+XbV6I81ekFdlu/nl7PndTEXJKxiNV7iL8QqftaRtb6hKDPeKhKCHzK5yF/5/L7LAMu7y3k=
X-Received: by 2002:ab0:35e7:: with SMTP id w7mr3329507uau.86.1627031389583;
 Fri, 23 Jul 2021 02:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com> <75eb2f6740eb5845afcb7d31956cc5b3e3957f97.1626939557.git.gitgitgadget@gmail.com>
In-Reply-To: <75eb2f6740eb5845afcb7d31956cc5b3e3957f97.1626939557.git.gitgitgadget@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Jul 2021 02:09:40 -0700
Message-ID: <CA+P7+xr7GCZCk44e_CSYFDr_ow3-BBMUfP5t6=cErFBES4N8+Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] [GSOC] ref-filter: add %(rest) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 12:40 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to let "cat-file --batch=%(rest)" use the ref-filter
> interface, add %(rest) atom for ref-filter. Introduce the
> reject_atom() to reject the atom %(rest) for "git for-each-ref",
> "git branch", "git tag" and "git verify-tag".
>

To a reader intimately familiar with cat-file, %(rest) might be
obvious.. but it would help the commit message read more easily if
there was a short explanation of what %(rest) did. It is not obvious
just from the name to me.

Thanks,
Jake
