Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD20C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiF0Vx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiF0Vx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:53:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03BD55BA
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:53:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k20so8377878qkj.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qSYvhGEH0+ta7asDFlsnbp5N1MeuoVWPBHJNAluuHhs=;
        b=DJd9PmOyBEC5ttEtqJiXmq2GBKsDbmZVQsgzR6NNR6xXtMD2WFhkIdC5XNEjWY3p4O
         cccZHXXtPwDsmZ4xtdLeZqmd2vkXYwFIse9bLDWoZcrlyESrslCU9mTMtj0eNvBwXD3h
         ih7sfM0MA2Y/ss4Hb7iwh/Fgy1LcN3khqQAWgMEMLJ+W4Kp/D/FD4EQ6Xen72oFAHVBL
         c4EDec7e7vX9/coIWQ1Ib+Am0IehyKZJ4d/Pos95RQmSmTTeR0slBRFkxlW9W1GqbCG+
         KrsyV9C5HQvHax3bXc+ChltXhaC2WSXefuNvc0DxcWJjJjGp3X1kZXqGYLWa2sHVwX0K
         j6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qSYvhGEH0+ta7asDFlsnbp5N1MeuoVWPBHJNAluuHhs=;
        b=G/kLgV8wJlfnAR3lU+QCIygt3WkNpbE8S8h1VSm1fRgAl4LDN3XQHH+mXRmHg6wFdd
         gS6j6o5MhYtD0F45S3+eRZOSrhinM3t0rE7OsA4gJVb8AG9e6+6FiVKWP0PX2pSMwFDe
         9MfdMe2AR0cLG4IHQwbLxYins1K25w5ssfU/4m4sUTL+YYMT+Y9NDiYlUV0hVEYBUdNp
         eKSyVuKfuhVRlz6XaaIcFKxWxsDRog29BBpr+N8ll87o+WXRtl2UZ0q7eowxdjPi9aqv
         J15enYxNVCwGCkyR0H7xuufmaLtJm/W7jNsaGtVcRMdIhzPELEAsWQ5RKwztW7qp+hxu
         NYHw==
X-Gm-Message-State: AJIora9UQCOVJgCoatsXEdgD6FzeW//di3JJriTk8k6N/5dBXCaccLQn
        gXA8tbpp+hEBGJhH4wrQsEHB/A==
X-Google-Smtp-Source: AGRyM1shBBQF46kmszKpxf+SSaxwwUAL2YgF8j2k0l8b2kHs88XMy6dpLz6XVlRmopTQihZv4kD9vg==
X-Received: by 2002:a05:620a:248b:b0:6af:504d:c1e0 with SMTP id i11-20020a05620a248b00b006af504dc1e0mr698497qkn.750.1656366804777;
        Mon, 27 Jun 2022 14:53:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a0c4d00b006a71398f06fsm9809628qki.32.2022.06.27.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:53:24 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:53:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 5/6] bitmap-lookup-table: add performance tests for
 lookup table
Message-ID: <Yrom04Go0tCAZWT8@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <96c0041688f6139c17611203f98274988ced25ab.1656249018.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96c0041688f6139c17611203f98274988ced25ab.1656249018.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2022 at 01:10:16PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Add performance tests to verify the performance of lookup table.
>
> Lookup table makes Git run faster in most of the cases. Below is the
> result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
> gives similar result. The repository used in the test is linux kernel.
>
> Test                                                      this tree
> --------------------------------------------------------------------------
> 5310.4: repack to disk (lookup=false)                   295.94(250.45+15.24)
> 5310.5: simulated clone                                 12.52(5.07+1.40)
> 5310.6: simulated fetch                                 1.89(2.94+0.24)
> 5310.7: pack to file (bitmap)                           41.39(20.33+7.20)
> 5310.8: rev-list (commits)                              0.98(0.59+0.12)
> 5310.9: rev-list (objects)                              3.40(3.27+0.10)
> 5310.10: rev-list with tag negated via --not		0.07(0.02+0.04)
>          --all (objects)
> 5310.11: rev-list with negative tag (objects)           0.23(0.16+0.06)
> 5310.12: rev-list count with blob:none                  0.26(0.18+0.07)
> 5310.13: rev-list count with blob:limit=1k              6.45(5.94+0.37)
> 5310.14: rev-list count with tree:0                     0.26(0.18+0.07)
> 5310.15: simulated partial clone                        4.99(3.19+0.45)
> 5310.19: repack to disk (lookup=true)                   269.67(174.70+21.33)
> 5310.20: simulated clone                                11.03(5.07+1.11)
> 5310.21: simulated fetch                                0.79(0.79+0.17)
> 5310.22: pack to file (bitmap)                          43.03(20.28+7.43)
> 5310.23: rev-list (commits)                             0.86(0.54+0.09)
> 5310.24: rev-list (objects)                             3.35(3.26+0.07)
> 5310.25: rev-list with tag negated via --not		0.05(0.00+0.03)
> 	 --all (objects)
> 5310.26: rev-list with negative tag (objects)           0.22(0.16+0.05)
> 5310.27: rev-list count with blob:none                  0.22(0.16+0.05)
> 5310.28: rev-list count with blob:limit=1k              6.45(5.87+0.31)
> 5310.29: rev-list count with tree:0                     0.22(0.16+0.05)
> 5310.30: simulated partial clone                        5.17(3.12+0.48)
>
> Test 4-15 are tested without using lookup table. Same tests are
> repeated in 16-30 (using lookup table).
>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  t/perf/p5310-pack-bitmaps.sh       | 77 ++++++++++++++-----------
>  t/perf/p5326-multi-pack-bitmaps.sh | 93 ++++++++++++++++--------------
>  2 files changed, 94 insertions(+), 76 deletions(-)
>
> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> index 7ad4f237bc3..6ff42bdd391 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -16,39 +16,48 @@ test_expect_success 'setup bitmap config' '
>  	git config pack.writebitmaps true
>  '
>
> -# we need to create the tag up front such that it is covered by the repack and
> -# thus by generated bitmaps.
> -test_expect_success 'create tags' '
> -	git tag --message="tag pointing to HEAD" perf-tag HEAD
> -'
> -
> -test_perf 'repack to disk' '
> -	git repack -ad
> -'
> -
> -test_full_bitmap
> -
> -test_expect_success 'create partial bitmap state' '
> -	# pick a commit to represent the repo tip in the past
> -	cutoff=$(git rev-list HEAD~100 -1) &&
> -	orig_tip=$(git rev-parse HEAD) &&
> -
> -	# now kill off all of the refs and pretend we had
> -	# just the one tip
> -	rm -rf .git/logs .git/refs/* .git/packed-refs &&
> -	git update-ref HEAD $cutoff &&
> -
> -	# and then repack, which will leave us with a nice
> -	# big bitmap pack of the "old" history, and all of
> -	# the new history will be loose, as if it had been pushed
> -	# up incrementally and exploded via unpack-objects
> -	git repack -Ad &&
> -
> -	# and now restore our original tip, as if the pushes
> -	# had happened
> -	git update-ref HEAD $orig_tip
> -'
> -
> -test_partial_bitmap
> +test_bitmap () {
> +    local enabled="$1"
> +
> +	# we need to create the tag up front such that it is covered by the repack and
> +	# thus by generated bitmaps.
> +	test_expect_success 'create tags' '
> +		git tag --message="tag pointing to HEAD" perf-tag HEAD
> +	'

I think this "create tags" step can happen outside of the test_bitmap()
function, since it should only need to be done once, right?

> +	test_expect_success "use lookup table: $enabled" '
> +		git config pack.writeBitmapLookupTable '"$enabled"'
> +	'
> +
> +	test_perf "repack to disk (lookup=$enabled)" '
> +		git repack -ad
> +	'

And I think these two tests could be combined, since this could just
become:

    git -c pack.writeBitmapLookupTable "$enabled" repack -ad

right?

> +	test_full_bitmap
> +
> +    test_expect_success "create partial bitmap state (lookup=$enabled)" '

There is some funky spacing going on here, at least in my email client.
Could you double check that tabs are used consistently here?

Thanks,
Taylor
