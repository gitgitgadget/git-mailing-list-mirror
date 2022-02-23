Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B86C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbiBWRX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiBWRX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:23:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2838BE2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:22:58 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 195so15106209iou.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2Wu1nl944PdsLcFYorQ2SOy9pjuQ0+99XI7okbR99k=;
        b=KnalxUBvBtwRuenKfsT1rFIB4UsoidmIG0FOrhSZ5GpXPFfNx+/th9FXSP1RtGgQE5
         +iT+CM0mlhhhYbnKlanuo81qmW5GqOBHG/D8gKo89acEsStiKxZGN4DUyRBGi01P1jl9
         qwS+9vgVLk2Ax3De5bVQXMDcpHAgLdgq3pZSzHykB0TR1QBoxP4va7YZEXr3jCuhGN/c
         Ln2Othiob/zKs1vy7zNWZx0Hs/1l2cZWoRxm9S/7wp359cgMrxQQSG5kYxxsx9uR8enT
         zK8Du0awytGDziF5l6NrEHykcE09RYNCXQqV5DWBP79t+siamcDmNPYCj5HG64QGa5A+
         LxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2Wu1nl944PdsLcFYorQ2SOy9pjuQ0+99XI7okbR99k=;
        b=iGCsgt7i1vV4MIs0ABitmWtAYzOaD7ner5FFM+J6tJq3fwT6ZDYdbD1vpTtDpir1ly
         3l+0CAJTgBVSDR9dkNkuv6cP0kgMH6PGbPUaRxAO7YyiQ5NG6+9Dtnmxpb1iwEp/qF8q
         eTf2K5d782QtqQUKy8qYhgWjTCH2+nIDP9xtgiv7h+HWitE3qd4VcCjp0YqyHmvJVN0z
         cu6UjX5Gm3A6Trq+Lw757jmedIZ2M01sZrO7LaJ9xn/X5dn6tWWYDVq8gNLU9Y3VXM6S
         BsvyC1svGe6QuuWggnmXV7pMftp4vEN+uxkXJ6VO6YzsHOQEFMKpMPP7bl84TJDCYenX
         3/OA==
X-Gm-Message-State: AOAM532lUikTOuFkS0fDu4kwubor407crUkxSk+uDFcHmct3e7S81mxp
        sobcNb10WzzPkxsJ+Y5/phuabVQbolzHNMYs
X-Google-Smtp-Source: ABdhPJzCbRAeDWH2oGqEKiWyLKFlTRDWmxeijbQ2h2ve7+8qihtYhc9b+xqDIrLsxCtrXLdsAxLA3Q==
X-Received: by 2002:a02:1dc3:0:b0:308:5a65:6af0 with SMTP id 186-20020a021dc3000000b003085a656af0mr555784jaj.119.1645636977561;
        Wed, 23 Feb 2022 09:22:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b6sm122642ilo.57.2022.02.23.09.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:22:57 -0800 (PST)
Date:   Wed, 23 Feb 2022 12:22:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH 2/2] t5302: confirm that large packs mention limit
Message-ID: <YhZtcEqczAFES+hQ@nand.local>
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
 <43990408a10d65058d872f13ea9619e85de7081d.1645632193.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43990408a10d65058d872f13ea9619e85de7081d.1645632193.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 04:03:13PM +0000, Matt Cooper via GitGitGadget wrote:
> From: Matt Cooper <vtbassmatt@gmail.com>
>
> When a pack can't be processed because it's too large, we report the
> exact nature of the breach. This test ensures that the error message has
> a human-readable size included.
>
> Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Helped-by: Derrick Stolee <derrickstolee@github.com>

Ah, one small note here: typically we try to keep commit trailers in
reverse-chronological order, with the most recent thing at the bottom.
That doesn't really matter for the Helped-by's, but keeping your s-o-b
at the bottom indicates that you signed off on the result of your patch
after Stolee and I gave some suggestions.

It's not a huge deal, and I'm sure we have plenty of examples of
slightly out-of-order commit trailers throughout our history. Personally
I don't consider it worth rerolling, but perhaps something to keep in
mind for future contributions :-).

> ---
>  t/t5302-pack-index.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index 8ee67df38f6..b0095ab41d3 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -284,4 +284,12 @@ test_expect_success 'index-pack -v --stdin produces progress for both phases' '
>  	test_i18ngrep "Resolving deltas" err
>  '
>
> +test_expect_success 'too-large packs report the breach' '
> +	pack=$(git pack-objects --all pack </dev/null) &&
> +	sz="$(test_file_size pack-$pack.pack)" &&
> +	test "$sz" -gt 20 &&
> +	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
> +	grep "maximum allowed size (20 bytes)" err
> +'

This grep is inconsistent with the rest of t5302 (which uses the
now-outdated test_i18ngrep). The choice to deviate from the norm of this
test script in favor of the general guidance against using test_i18ngrep
is intentional AFAIK.

Thanks,
Taylor
