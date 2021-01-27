Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA614C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0A920724
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhA0Gug (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhA0DHt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:07:49 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6FC061574
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:07:07 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id n7so530366qkc.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iN7cbPuKZj6B9kfcGpoWqnUChgcLuBfa1Q6taHVLsnA=;
        b=d9/m7S6i17lAKAuE/TPaocGxJ2PGgUn6KeedOWYZDz9N2MVSc0ZD0ZOQo0T72MCB/R
         tFQEr2P9MfLhdc31/WSVMpwt+SqtuyFEO9zPeZBXJpseE8cQBmBCOrycb0LjRCvnJgwq
         I2lmeux5+71Wat4KjKkTXvk6SBhDQJzxkknCW7iPvkPdq9Thzu+nuNx/wvbB1JjRKk4j
         vQpp1YIp8/e0fsJujwJMg7l6c0aaxhqiexpVPNscNw1a+4ezf63Fpl/G8jfgGKscSiaM
         bzPS6N5H5RmzVQPoC/R/anDfVgbbwZUnRf90FDGcl+rcrGotUuUOcgdQ7rVcJ6kut7xE
         HpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iN7cbPuKZj6B9kfcGpoWqnUChgcLuBfa1Q6taHVLsnA=;
        b=CSo7pa7VhaIBoue4FmuD7j/cTHd23M3pLMa14/s58ECOdS1ZiJ4Lsi8dIuEMn21nRJ
         N9TZeu2dOtpc+1Ecs/QnfxRT+LbfmzHggT6VEj5vcgNAsEJNV411/Lz/ayDF3SSLlOx2
         TbV8gcfmFOt9xuz9hjq+cAGfngIN9Vl+r6EijnLk9QXm8hMtPgmyfX7RXwxq/xOVB+2O
         xotceeViH6Q1XD3e8StvQUpX0KOJG57R3GTC38/ZxGdVbpIMslLc6w5M0JbnIJAu4VLb
         BYIHynJYGWeq/HwnW0VfcIS+VB2y4aO/pUNRIongb7QIYwYdRho6u++tksrPBOh5P7bN
         2GMg==
X-Gm-Message-State: AOAM533YX1xhEzcEpcApeXxzejlrjM6zt35daEZc//vIAS5hRYIxsOOA
        tuze/AIRjGFlBfF+Tg5olv2RnrW/YVmShw==
X-Google-Smtp-Source: ABdhPJwOLiKAQU4uVJKBe+PuFF9dPxpWVZJ6uXsS2Ji1djjrA8R1XS8WlM3WoG4m5KEArTPApcSl+g==
X-Received: by 2002:a37:90c5:: with SMTP id s188mr9184527qkd.128.1611716826387;
        Tue, 26 Jan 2021 19:07:06 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id t68sm391630qkd.35.2021.01.26.19.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 19:07:05 -0800 (PST)
Date:   Tue, 26 Jan 2021 22:06:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 14/17] midx: use chunk-format read API
Message-ID: <YBDY0Me2QMcUMD2e@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <cb145e0e32afed99b9bfa822c76f48bee18885ba.1611676886.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb145e0e32afed99b9bfa822c76f48bee18885ba.1611676886.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 04:01:23PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Instead of parsing the table of contents directly, use the chunk-format
> API methods read_table_of_contents() and pair_chunk(). In particular, we
> can use the return value of pair_chunk() to generate an error when a
> required chunk is missing.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c                      | 103 ++++++++++++++++++++----------------
>  t/t5319-multi-pack-index.sh |   6 +--
>  2 files changed, 60 insertions(+), 49 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 0bfd2d802b6..dd019c00795 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -54,6 +54,51 @@ static char *get_midx_filename(const char *object_dir)
>  	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>  }
>
> +static int midx_read_pack_names(const unsigned char *chunk_start,
> +				size_t chunk_size, void *data)
> +{
> +	struct multi_pack_index *m = (struct multi_pack_index *)data;
> +	m->chunk_pack_names = chunk_start;
> +	return 0;
> +}

There are a lot of these callbacks that just assign some 'void **' to
point at chunk_start.

Maybe a good use of the "pair_chunk" name would be something like:

    int pair_chunk(struct chunkfile *cf, uint32_t id, const unsigned char **p);

which does the same as what you wrote here. So instead of what you
wrote, you could instead:

    pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names);

This would be in addition to the richer callback-style function which
allows the caller greater flexibility (e.g., for the Bloom filter
related readers in the commit-graph code).

Thanks,
Taylor
