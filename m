Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEB9C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D3E613D8
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhGAMmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbhGAMl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 08:41:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD98C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 05:39:28 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g3so5358651iok.12
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=79VlZXTLbj21vebxiVwGB6kDIRPodqYLNHdvdLj7o1U=;
        b=n0SQs7wTWqWZZr6iZcA1AO+ngAnotGhaEJm0PFUZHeH64AqVTpB7CrN3apTVEXZU3r
         Jb5VOyOk2O5cqWvjJXH/4NIbjYQ13AQuTb2FToDCyTXnZLNpa6gmjCOB9nwneTlTjilO
         iFtj5zFHz8kJyM4HvcQgtbM8a/LxsvBEfgt+skM2/+yUd9M944vsaFZ+fo90cTFUNxKf
         L+dmyw55jroia+UMdplM1xhZWhoFotAAr1OKPWPced/O12eiyeKNQonhXLru8JhdcJRO
         VgJoc/rLIkrqg0S15jVlm35ZTykMfUP2IGYwelGCEyMOAeIjL7OuMj/aIZWqw3MAgmLv
         Qjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=79VlZXTLbj21vebxiVwGB6kDIRPodqYLNHdvdLj7o1U=;
        b=XhxU3HnT7AdoSnBLs9KVUsWKDE1MKQM+Uf++AEsKSK+MO251YJnqkJHJle+ysqdSRl
         N4J5J4ehR11d08rITFuy/Uw2f9VVomCb9yvpLyKCvzzgu9FtKFlcmaCpESnvN0u/YqOx
         Zo+Lab+q4Tupap4PJkSOMUS/xr/lW7YWU/7Ir1LyFC8fJ08JmOiF+eOElvVMb8VcCYy3
         B+z9HI31/JgCySe0y5keBds61F/jSNYozq/q6CQK2jIFHAY77MIstZyuMv8E34E0QcAT
         55w+CcuXIRt9FAAJqtkFFmE7XVkh1tKXq4AwUfSLG+CUGNiAzdc6vGJCTAhxUS2ywYW5
         WUKA==
X-Gm-Message-State: AOAM530lhJK/UswKzHxzA5EF32ATbmQ0SKzFD224iOIZe5l4TDGAemkB
        Mle3nLWwEWxQTbuYMK06EFUUzGX1nJKawKP0//NcXboVujScoCk7
X-Google-Smtp-Source: ABdhPJxtmiIeE6DpZwFTdrnnpNJXoZENRF1jbGKbuEHw67yaAwSp+fyUu9/Lji34Fag6OW0TqvZOFavIaBEfMceyBqU=
X-Received: by 2002:a02:cc04:: with SMTP id n4mr13415176jap.50.1625143167554;
 Thu, 01 Jul 2021 05:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
 <pull.980.v6.git.1624797350.gitgitgadget@gmail.com> <xmqqbl7nt3fh.fsf@gitster.g>
In-Reply-To: <xmqqbl7nt3fh.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 1 Jul 2021 20:39:18 +0800
Message-ID: <CAOLTT8S=qeg8QBhMU0fCc600n-qzJBT9P9LvhSVZaXpvsr0__Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] [GSOC][RFC] cat-file: reuse ref-filter logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This patch series make cat-file reuse ref-filter logic.
>
> Unfortunately this seems to interact with your own
> zh/cat-file-batch-fix rather badly.
>

Well, it's because I didn't base this patch on it.
That should be easy to achieve.

By the way,  I think patches before "[GSOC] ref-filter: add %(rest) atom"
should belong to "zh/ref-filter-raw-data", and patches after that should be=
long
to "zh/cat-file-batch-refactor".

Thanks.
--
ZheNing Hu
