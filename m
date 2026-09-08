Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912153358A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880019; cv=none; b=Mq1W2ifkcyphaB4Sw4LZIj5T1GpOWrk4wkCDUIs1HV1bCBZtPCXVAY6vmcN4wAm4Q8k1gL4LmlWKpFFD3JYHn5BcRSRj22ECDsJp6/m4227uAgpd5PUjZ+2LKKXa1SlMmJRNnkM+l7BKOeB1/c+bdeNvPPUOZyM6RVnInLQYKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880019; c=relaxed/simple;
	bh=zuAcg8ggnwoFbayLEd1xFsjEtp/ONeLCReGgEkXnalc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igIEOWv076sXWnRGM/nJMFifYEp3CB5I1gIRwpJ9d6ykp5YqCw2twOrNTQXo5lsjZGdsdmxARpag+8w4bEpNx3BzffVf/F1IKSij6PcXUYsDcyhQysf9FX27IZbKAULm4LKcXJRKgr5QydKolZ04K/W1+IMR00OI3tioT6K0pUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=b1YvqGRx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="b1YvqGRx"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90f9f8553e0so57822946d6.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1788880004; x=1789484804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GbMjOruTyVWfmO4MbX9rg6omC8TnSqU4uq00T6uEvGs=;
        b=b1YvqGRxYK5k9a2VAfx9Gl4WScSVptkyPq6+HJukc+Jd1knjjaB1BGTWr4aGEpNA4y
         pyAaIj6cEB7sluJTpvEmdgdVPBGHsWK7UGZ07BhwBiR+oYhfRep44+JHKstB/FSNpnUS
         V+upoendMrVym5hPpFN0GU1PH7q1weBNdVFzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880004; x=1789484804;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbMjOruTyVWfmO4MbX9rg6omC8TnSqU4uq00T6uEvGs=;
        b=lhN0yAD+pJXq0nzzo8XG9v9N9oTD8pgJ5omK6utKw8+0GmhvX0hPkmR+y9D1K/FQcc
         RBCM0mtSYl5dCMIfE8wGY6c68oMy4YlmY6GGN4caUV1Fw34bBT/9TkgMNOh5t7EFVimk
         MIRuSjc2S3b/YTiRR0bp1hnrRhLMS4Pz9ZDnb77ZiRxwgg9+sqKjtI11/W3yRlfHam8L
         QOmgSeeol3nH8FmTjk/cCRL44+6khCCRiX48DQYEg7UzUnib9x8JjhcDy9Ouv03lNDb7
         I73BPYiSfaiELyMJd8h83RbvMUiNuEytG+OeCmAWPqUg+NtJuoiovBXnyAKfE504ybqj
         oayA==
X-Gm-Message-State: AFuF++ngnwoLxa8jTf1Ch0MeC4fcpZmrhkTodcCYjn2XLxglBdJGhr9r
	wxbCmk0ZCmewHns1fip5zxibeqBK7nBfqQV9wlUg0SyMhIrs+g7ghyoORmtWlkzdd22yH8qlQYL
	Ghi0LUnEaLg==
X-Gm-Gg: AYBFou0oZ9W0SDI0Yd7tXKFEpEE5oBGbuSklI4Kn+VUkcwaM/CwczOAywfumGkXGUDy
	CoFcwNhtGRejoLkwq+S9fEYQDqlt+RHoisYnkyL5/I93sIBvSolJ288kelSxQGzOOV56Ne2nUij
	EHmJozNVzJT57gpGiUc4z3rgBLhOaPDU8V50R+KnxaQezcgaerb30SdZhx6aSJNUip1yDZceC2K
	sEE8/eUsW0HFvNITLn2VUbH6t2EkrZDVWHB0qtkWMM21VnAHfNtcOIrzNy1kLavMoJvfeCL1j9m
	r0dTjjUu/5Cl35gAvB3HKTfUVrXPV+1aRPye2ws7Ypvk79Tqrk3ix/mGEN/GfeL05dHViS9z4xX
	BpZPIPMDGYqO4NXomSW7nfWv0ysk5vYdKNuercX1oW9iDDIZC4LAdbbUJiJxVBFul5TM3tpKCEI
	MQCxaUTuU/MEMni2kICM4V5dgfr3hn6uVUOs1cZ/+x75ibxYvXQmc7OwwdOFHUQs40fzTlR7xp+
	09YEZTN5HYbGcHBMYRlLbyu7Div89k6qlP3Q2gU3UmZdfV48rZG8atj
X-Received: by 2002:ac8:5891:0:b0:530:45ab:4d75 with SMTP id d75a77b69052e-530549ef2a6mr328385031cf.42.1788880003869;
        Tue, 08 Sep 2026 08:06:43 -0700 (PDT)
Received: from com-79390 ([40.76.104.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541ba2d2sm117405871cf.22.2026.09.08.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:06:43 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:06:36 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Pia Park <pia@pierre.co>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] midx-write: skip writes with no object entries
Message-ID: <aqAkfGZtLJ97nG1m@com-79390>
References: <ap-KYtsDXXwbBzDM@com-79390>
 <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>

On Tue, Sep 08, 2026 at 12:10:16AM -0700, Pia Park wrote:
> Return success silently. Empty-object writes already return 0, including
> when --bitmap warns, so preserve that exit status for existing callers
> while omitting the warning and empty MIDX.

I think that this is OK, and it matches the behavior of other builtins,
e.g., running "git repack -d" twice in a row such that the second
invocation has no objects to pack. However, I think that if we want to
make this case return successfully when no objects are present, we
should apply the same treatment to the case where no packs are present.

But I want to make sure that others are on the same page. I would be
curious to hear Stolee's (CC'd) opinion on whether returning silent
success in both cases makes sense.

> diff --git a/midx-write.c b/midx-write.c
> index 8537102254..3038bbfad2 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1617,9 +1617,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	}
>
>  	if (!ctx.entries_nr) {
> -		if (opts->flags & MIDX_WRITE_BITMAP)
> -			warning(_("refusing to write multi-pack .bitmap without any objects"));
> -		opts->flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
> +		result = 0;
> +		goto cleanup;

Looks good, though let's make sure others agree that this is the right
approach. If they do, I'd recommend changing the no packs case to also
return zero either in a small preparatory patch.

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 68143cb5b7..c239a87d10 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -54,6 +54,41 @@ test_expect_success "don't write midx with no packs" '
>  	test_path_is_missing pack/multi-pack-index
>  '
>
> +test_expect_success 'skip non-incremental MIDX with no objects' '
> +	git init --bare empty.git &&
> +	(
> +		cd empty.git &&
> +		git pack-objects objects/pack/pack </dev/null &&
> +		ls objects/pack >files.expect &&

I think it's fine to drop files.expect and files.actual here. Testing
that the MIDX write does nothing should be sufficient here.

> +
> +		for bitmap in "" --bitmap
> +		do
> +			git multi-pack-index write $bitmap >out 2>&1 &&
> +			test_must_be_empty out &&

I think it's fine to write "git multi-pack-index write $bitmap" without
the redirection, so that this is:

    for opt in "" --bitmap
    do
        git multi-pack-index write $opt &&
        test_path_is_missing $objdir/pack/multi-pack-index || return 1
    done &&


> +		git multi-pack-index write --incremental --bitmap &&
> +		test_dir_is_empty objects/pack/multi-pack-index.d &&

I was going to ask whether we wanted to test this case with and without
the "--bitmap" option as well, and likewise recommend that tthis test go
in t5334 instead. But such a pair of tests already exists in t5334, so I
think we can safely drop this hunk.

> +		echo blob | git hash-object -w --stdin >in &&
> +		git pack-objects objects/pack/pack <in &&
> +		git multi-pack-index write --incremental --bitmap &&
> +		test_line_count = 1 objects/pack/multi-pack-index.d/multi-pack-index-chain &&
> +		git multi-pack-index verify &&
> +
> +		echo another | git hash-object -w --stdin >in &&
> +		git pack-objects objects/pack/pack <in &&
> +		git multi-pack-index write --bitmap &&
> +		test_path_is_file objects/pack/multi-pack-index &&
> +		midx="$(midx_checksum objects)" &&
> +		test_path_is_file objects/pack/multi-pack-index-$midx.bitmap &&
> +		git multi-pack-index verify

These two blocks are testing normal MIDX operations that are well
covered elsewhere in the test suite. I think we can drop these safely.

> +	)
> +'
> +
>  test_expect_success SHA1 'warn if a midx contains no oid' '
>  	cp "$TEST_DIRECTORY"/t5319/no-objects.midx $objdir/pack/multi-pack-index &&
>  	test_must_fail git multi-pack-index verify &&
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 86beab1dae..490008d1d7 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -305,7 +305,7 @@ test_midx_bitmap_cases () {
>  		)
>  	'
>
> -	test_expect_success 'no .bitmap is written without any objects' '
> +	test_expect_success 'no MIDX or .bitmap is written without any objects' '
>  		rm -fr repo &&
>  		git init repo &&
>  		test_when_finished "rm -fr repo" &&
> @@ -318,13 +318,14 @@ test_midx_bitmap_cases () {
>  			pack-$empty.idx
>  			EOF
>
> +			ls $objdir/pack >files.expect &&

Similar comments here. It should be fine to drop the assertion on
files.expect, along with the content out stdout.

>  			git multi-pack-index write --bitmap --stdin-packs \
> -				<packs 2>err &&
> +				<packs >out 2>&1 &&
>
> -			test_grep "bitmap without any objects" err &&
> -
> -			test_path_is_file $midx &&
> -			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
> +			test_must_be_empty out &&
> +			test_path_is_missing $midx &&
> +			ls $objdir/pack >files.actual &&
> +			test_cmp files.expect files.actual
>  		)
>  	'
>
> diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
> index f0b82b5f65..fbcc19feeb 100755
> --- a/t/t5334-incremental-multi-pack-index.sh
> +++ b/t/t5334-incremental-multi-pack-index.sh
> @@ -195,4 +195,79 @@ test_expect_success 'non-incremental write with existing incremental chain' '
>  	)
>  '
>
> +test_expect_success 'skip initial MIDX layer with no objects' '
> +	git init empty &&
> +	(
> +		cd empty &&
> +		git config maintenance.auto false &&
> +		git pack-objects $packdir/pack </dev/null &&
> +
> +		for bitmap in --bitmap --no-bitmap
> +		do
> +			git multi-pack-index write --incremental "$bitmap" >out 2>&1 &&
> +			test_must_be_empty out &&

Same comment about asserting the contents of stdout here as well. I am a
little confused by this test, though, since there are no packs present
in "empty". Shouldn't we be hitting the "no pack files to index" error
here?

> +			test_dir_is_empty "$midxdir" || return 1
> +		done &&
> +
> +		write_midx_layer &&
> +		test_line_count = 1 "$midx_chain" &&
> +		git multi-pack-index verify

We can drop this last block as well.

> +	)
> +'
> +
> +test_expect_success 'skip MIDX layer with empty pack' '

Perhaps s/skip/& intermediate/ to distinguish from the previous test?

> +	git init empty-pack &&
> +	(
> +		cd empty-pack &&
> +		git config maintenance.auto false &&
> +		write_midx_layer &&
> +
> +		git pack-objects $packdir/pack </dev/null &&
> +		cp "$midx_chain" chain.expect &&
> +		ls "$packdir" "$midxdir" >files.expect &&

I think testing that the MIDX chain file is unmodified makes sense, but
no need to test the content of $packdir and $midxdir itself. If there is
a reason to test those as well, please ensure to sort them first before
comparison.

> +
> +		for bitmap in --bitmap --no-bitmap
> +		do
> +			git multi-pack-index write --incremental "$bitmap" >out 2>&1 &&
> +			test_must_be_empty out &&

Same comment as above.

> +			test_cmp chain.expect "$midx_chain" &&
> +			ls "$packdir" "$midxdir" >files.actual &&
> +			test_cmp files.expect files.actual || return 1
> +		done &&
> +
> +		write_midx_layer &&
> +		test_line_count = 2 "$midx_chain" &&
> +		git multi-pack-index verify &&
> +		git rev-list --test-bitmap 2.2

Likewise.

> +	)
> +'
> +
> +test_expect_success 'skip MIDX layer with duplicate pack' '

Same comments as above, though otherwise this test looks good.

Thanks,
Taylor
