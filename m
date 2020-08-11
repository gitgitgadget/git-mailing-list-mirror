Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE70C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48F220756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MpeDsSht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgHKPuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgHKPuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 11:50:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA8C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:50:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so12093932qkf.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22tyaIwEo4M64bzqtvOxyD+jmQTztDlb6apKMiG2SwE=;
        b=MpeDsSht/mfHfDZlmCg8mERmzTXisxKF7LIJcn+a11W2n1C5jhfQuZDicxml/4Y2Zo
         EgLR4pR/7FolkLVoD/yGfqX/mzcZlsZoT4AQG14Xz1UmlcSlU5LwcAFboLDVX5PBoIPr
         1vNocEG9MyLpZcKQqfSpuZvz1RJiMz5NCzveJizZme+hMhbjxTv6jz5fE4YEcdP4ELI6
         RX1lwSe3kmaT628TIpORbh64H5ZgpWG5hYq7eZa08UF9Y8vm+ZRMmK0O0HC9WDzKvNBF
         kmqh/80nUL5i4PXiDnOsmSYQPWogEcYweZpunsPu343/G2HzwEjWh6h4qzpW6O0UrRfg
         zEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22tyaIwEo4M64bzqtvOxyD+jmQTztDlb6apKMiG2SwE=;
        b=c6qxRofCTNyXC/Ja3qWD9sql5fgpTO0Y3SUhCJjQxx6MmiJ9C0YQSrTfZYMzSSLvHJ
         QYb8GGo4EemOXz+VenHRS62SjwDEV1Is4J+PDqFYnqgGt/jwu43fkAaqcx8825tdt9g7
         E71QExIgC5V08AyL8XfJ/Sk4O5WnwenjvcE3fn38Y/QOpecgPKmd7I9MRjXbPbOh9FLQ
         aEzRkyEwU9fCVwsmIJzmIgWmzKQ0pYC4AfrsfNz1tfVTBfTVRJOLTjHZosIbqmtLXFks
         /5Ft0xt8jRLC/6JtBEmVplIkJIBvGu4nsaySV3UfMg2WAItRjHpADqZ7irKrcdjZafRk
         UWsA==
X-Gm-Message-State: AOAM533y9rWLB77CWDE+HnDMjYhzmGeM2GyqdsfdD00ukmOnZAoy7dHB
        X4/OkVTJmJ5w1AHRKzj36TiyJg==
X-Google-Smtp-Source: ABdhPJzOUbPxDqtYp3GmNDo6ODvBKEV1S6wHYCWEa0poFguk3W9BvAbCpK1KqZm3MTUG7TAO3c557w==
X-Received: by 2002:a05:620a:1105:: with SMTP id o5mr1787156qkk.434.1597161015173;
        Tue, 11 Aug 2020 08:50:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id j72sm17659617qke.20.2020.08.11.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:50:14 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:50:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] multi-pack-index: repack batches below --batch-size
Message-ID: <20200811155013.GF19871@syl.lan>
References: <pull.698.git.1597159818457.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.698.git.1597159818457.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 03:30:18PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The --batch-size=<size> option of 'git multi-pack-index repack' is
> intended to limit the amount of work done by the repack. In the case of
> a large repository, this command should repack a number of small
> pack-files but leave the large pack-files alone. Most often, the
> repository has one large pack-file from a 'git clone' operation and
> number of smaller pack-files from incremental 'git fetch' operations.
>
> The issue with '--batch-size' is that it also _prevents_ the repack from
> happening if the expected size of the resulting pack-file is too small.
> This was intended as a way to avoid frequent churn of small pack-files,
> but it has mostly caused confusion when a repository is of "medium"
> size. That is, not enormous like the Windows OS repository, but also not
> so small that this incremental repack isn't valuable.
>
> The solution presented here is to collect pack-files for repack if their
> expected size is smaller than the batch-size parameter until either the
> total expected size exceeds the batch-size or all pack-files are
> considered. If there are at least two pack-files, then these are
> combined to a new pack-file whose size should not be too much larger
> than the batch-size.
>
> This new strategy should succeed in keeping the number of pack-files
> small in these "medium" size repositories. The concern about churn is
> likely not interesting, as the real control over that is the frequency
> in which the repack command is run.

OK. This '--batch-size' parameter is a little magical to me, but the
behavior you are describing seems sane. I think that your assessment of
the down-side is reasonable, too.

Looks fine to me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     multi-pack-index: repack batches below --batch-size
>
>     As reported [1], the 'git multi-pack-index repack' command has some
>     unexpected behavior due to the nature of "expected size" for un-thinned
>     fetch packs and the fact that the batch size requires the total size to
>     be at least as large as that batch-size. By removing this minimum size
>     restriction, we will repack more frequently and prevent this "many
>     pack-file" problems.
>
>     [1]
>     https://lore.kernel.org/git/6FA8F54A-C92D-497B-895F-AC6E8287AACD@gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-698%2Fderrickstolee%2Fmidx-repack-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-698/derrickstolee/midx-repack-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/698
>
>  Documentation/git-multi-pack-index.txt | 11 ++++++-----
>  midx.c                                 |  2 +-
>  t/t5319-multi-pack-index.sh            | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index 0c6619493c..eb0caa0439 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -51,11 +51,12 @@ repack::
>  	multi-pack-index, then divide by the total number of objects in
>  	the pack and multiply by the pack size. We select packs with
>  	expected size below the batch size until the set of packs have
> -	total expected size at least the batch size. If the total size
> -	does not reach the batch size, then do nothing. If a new pack-
> -	file is created, rewrite the multi-pack-index to reference the
> -	new pack-file. A later run of 'git multi-pack-index expire' will
> -	delete the pack-files that were part of this batch.
> +	total expected size at least the batch size, or all pack-files
> +	are considered. If only one pack-file is selected, then do
> +	nothing. If a new pack-file is created, rewrite the
> +	multi-pack-index to reference the new pack-file. A later run of
> +	'git multi-pack-index expire' will delete the pack-files that
> +	were part of this batch.
>  +
>  If `repack.packKeptObjects` is `false`, then any pack-files with an
>  associated `.keep` file will not be selected for the batch to repack.
> diff --git a/midx.c b/midx.c
> index 6d1584ca51..38690b46c9 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1371,7 +1371,7 @@ static int fill_included_packs_batch(struct repository *r,
>
>  	free(pack_info);
>
> -	if (total_size < batch_size || packs_to_repack < 2)
> +	if (packs_to_repack < 2)
>  		return 1;
>
>  	return 0;
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 7214cab36c..b05190f500 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -643,6 +643,7 @@ test_expect_success 'expire respects .keep files' '
>  '
>
>  test_expect_success 'repack --batch-size=0 repacks everything' '
> +	cp -r dup dup2 &&
>  	(
>  		cd dup &&
>  		rm .git/objects/pack/*.keep &&
> @@ -662,4 +663,21 @@ test_expect_success 'repack --batch-size=0 repacks everything' '
>  	)
>  '
>
> +test_expect_success 'repack --batch-size=<large> repacks everything' '
> +	(
> +		cd dup2 &&
> +		rm .git/objects/pack/*.keep &&
> +		ls .git/objects/pack/*idx >idx-list &&
> +		test_line_count = 2 idx-list &&
> +		git multi-pack-index repack --batch-size=2000000 &&
> +		ls .git/objects/pack/*idx >idx-list &&
> +		test_line_count = 3 idx-list &&
> +		test-tool read-midx .git/objects | grep idx >midx-list &&
> +		test_line_count = 3 midx-list &&
> +		git multi-pack-index expire &&
> +		ls -al .git/objects/pack/*idx >idx-list &&
> +		test_line_count = 1 idx-list
> +	)
> +'
> +
>  test_done
>
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
> --
> gitgitgadget
Thanks,
Taylor
