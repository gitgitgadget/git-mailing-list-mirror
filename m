Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0DDC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiBPQvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:51:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiBPQvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:51:53 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DD1262E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:51:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so599657eje.10
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PXY7D14Tdsl+fRMXgj7SSQMa5vwgKpAmhIYC9dmgcLM=;
        b=lAR4gqM5yJ+rC6jVyC99tf6r8iwO+fFQb+TTAihv9SWXy31AkfSyl7J/uTWNwYcKip
         VJdH4nOkPVODYu6ebjQbx3aarE7Tg7tRszGpmfryL60a7/khQml4TeyQbqGIP+Ew4nri
         Kw64Wc75loD0KLhwloHpn06qnahFqbzouQPbFesPwj7qhPEkZL9pohjtB9Grd22zaZ9+
         5bWnLuto8Kqy1miWPV44QZTMNhFd4P72QV5oqmmDsGDGR2Bpd57VILaIIkRest+C0flE
         GjSHPdq/vgC6sX+K7GBk4+6udUEWBMtNFFK6pPPoCbjPSBTlTJhEMA2Jw9hO2qxgB5ai
         C1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PXY7D14Tdsl+fRMXgj7SSQMa5vwgKpAmhIYC9dmgcLM=;
        b=n7w47yaRzIJ2/6tA0en9oV0O5xq+E9KJQi4axY57d/phEKgZRO+Jq7pTIvfB3psrPQ
         THM5MDaaAbZuwX6cfxLFOVkFsrvxsS3WCgKkhEfD1TYQmFyWLtdCSLD9dLt/TTRtFaum
         LfgJiARD0nKz2C6F3oeH1UZ73FMF+KtU1BS3Fr2laAOfOLVUmJuXJGfvSIddXQhzSt+W
         zf8iRH8n3ZNjfJ4fQFvT9AH5dWRbAUFNCAu6EmMxCJneUdVS1XxgP1NJbKDwXhw950Ej
         MfP+wJBui5pVefDFhtzyEsgh277VikWvDEH1QlMM1JH1FMFLvj34ZfR2LoIsne71k/kZ
         8/3A==
X-Gm-Message-State: AOAM530YFDO2QmxObVaYlCU+q1wc2N3imQQJcKrF7/EFz49UlsloWWId
        mPYSDEt6hczLQbtX32xoPlQuDUOtBio/laBsaq1/BZsRKdE=
X-Google-Smtp-Source: ABdhPJzQS05S46IEAlQBbHXFcP422u5nl6ACjVIlBVaNsWyPKZIYyeBNphA/DgiRrS/eBk6oU+x3DtplEVYjX4k5zcg=
X-Received: by 2002:a17:907:11c1:b0:6cf:723b:37af with SMTP id
 va1-20020a17090711c100b006cf723b37afmr3079601ejb.476.1645030298698; Wed, 16
 Feb 2022 08:51:38 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com> <patch-2.2-7f320062419-20220216T105250Z-avarab@gmail.com>
In-Reply-To: <patch-2.2-7f320062419-20220216T105250Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:51:27 -0800
Message-ID: <CABPp-BEyTnfEANPii-33y0g3fQgkRY8Bz3zaXScN__Ad7z4n1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff.[ch]: have diff_free() free options->parseopts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 7:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The "struct option" added in 4a288478394 (diff.c: prepare to use
> parse_options() for parsing, 2019-01-27) would be free'd in the case
> of diff_setup_done() being called.
>
> But not all codepaths that allocate it reach that,
> e.g. "t6427-diff3-conflict-markers.sh" will now free memory that it
> didn't free before. By using FREE_AND_NULL() here (which
> diff_setup_done() also does) we ensure that we free the memory, and
> that we won't have double-free's.
>
> Before this running:
>
>     ./t6427-diff3-conflict-markers.sh -vixd --run=3D7
>
> Would report:
>
>     SUMMARY: LeakSanitizer: 7823 byte(s) leaked in 6 allocation(s).
>
> But now we'll report:
>
>     SUMMARY: LeakSanitizer: 703 byte(s) leaked in 5 allocation(s).
>
> I.e. the largest leak in that particular test has now been addressed.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  diff.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/diff.c b/diff.c
> index 0aef3db6e10..fb8bc8aadbf 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6346,6 +6346,7 @@ void diff_free(struct diff_options *options)
>         diff_free_file(options);
>         diff_free_ignore_regex(options);
>         clear_pathspec(&options->pathspec);
> +       FREE_AND_NULL(options->parseopts);
>  }
>
>  void diff_flush(struct diff_options *options)
> --
> 2.35.1.1028.g2d2d4be19de

Makes sense.
