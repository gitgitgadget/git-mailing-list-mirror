Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759A3E9286
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264900; cv=none; b=XAOwA/+y093FqUDF3NtDFbuhOtMvq1ufBziHikb0VU7mT5xF2IwzNJ6dkjI9Ke8zjW0btmjKeVXrtt9s3OC2Be+dLxdLD2MHEGvZe+SELDQPt/cTJSh/ioRa+wp/UxE39XRtpdLRTviIOxyVJsqHIu7S0mAlftmrfm6Di84+Py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264900; c=relaxed/simple;
	bh=uWw92xQBkYAe2j+xwVw/n+4SslLBq5jWFO4ujGVaxjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKFkfZ+DK/dAnGc8M0jSsCOe28AQDDv9k7CkhjXrjWyDRJaEc/Hss4e1J2Wou86nklsj1LSLlidugPr68qQrIn3ermPHrGxYbYliPAFc7xj7BF7H2+TvWm2gYRdTLn1ySg7mhM7c5XLOHjacsHA7CfOh9Xi5etaC3f9u/pPh/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VnllnsBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GL1NtlMi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VnllnsBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GL1NtlMi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FDF9EC01B0;
	Fri, 12 Jun 2026 07:48:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 12 Jun 2026 07:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781264897; x=1781351297; bh=3nYSLGmGjT
	C86Dc24UG+ncqJ6tLEHiHkJTZl8rTtZfE=; b=VnllnsBFRPhsxdHbwKAX/OQv3W
	Dscd/TCV8nVmgjsIG37CjJqCWYCJUg/v48zesUyLcfNyfgVEQo1croQ5/lnQARdh
	4YTCrXagCUFbuet+3O/2astgK3WfzVaRvUoda32i8VSM0DLee4MSzsV1nj0sNaWI
	U4xlrQKFShdq3ruzNvTiCH3NijMcGG+okDOfl0a5LqBDQTPkDo44VO2Iy9Wjb8o5
	3xR5S8b8sIFi77KNA3Itc7YHNFE/qgXnqBKwTXK0Ekc3s28DA875qhfGLn2SNP/g
	WIGiQnAFNEtrjXXDSYkXAiGJebPENK+m+c/IxkPO+BnUmvyKxWJmu0+gcXwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781264897; x=1781351297; bh=3nYSLGmGjTC86Dc24UG+ncqJ6tLEHiHkJTZ
	l8rTtZfE=; b=GL1NtlMiOoFvdiwSK2EDhGJ1pEljCSuAugJ3BbkW4gEDvDRKdIe
	biut+K5YTiG99qTGiDPMyRMBqcJax2Tq5BUdQoNeeyWl4q/WlHPuUmQjkHnvLIjQ
	binZsPYySG2ICzH6apvQlB6ePGJ2duUBVWUC32BXwS9ujdVokdFFrXjnwQVwBRDO
	T/AL3S/46lq0gyMXo+W4MqdCQnYIVbq9Bb5sbgKpN1cut6rATP+yGuuVUBe2ZNsa
	EsT44AWybFMyoh7syemNBpod8GxQOQ45QalvZ9Z+wmbbCw3wNouCZHtnwqFWRvxY
	YDIhIi0vPeA6+Cl8vCQb/QuoHCe3gPItG5g==
X-ME-Sender: <xms:AfIrarXAZhfk6UGocJOZPboWBTxPRJq0KGHIzNTGCd3XNy2SLJW4RA>
    <xme:AfIranTsL9wsnbdgQB6EHCLKgHwXRXq3np9mo5LjXvtmkMAriThSf4sHjQdvc8341
    BXShOM966BIYa36syx1JJU0wTvPV2jH4b1AwtTf5avTq85HxRMRmQ>
X-ME-Received: <xmr:AfIrahNAi6o7fQL5sh3jL3Fnf1jQahfeQJvGMSWnMbdzcWNxCZG1kNyxmSkGuBKtCBsVkDEA70279sLWfJLQJ5qzru_L4YXsuh7kJjJbLnA>
X-ME-Proxy-Cause: dmFkZTEOPX04lX1S7PB0RDXIEGasaTl+oegHsCFMd6B6AA2KUlnU+DBldFfNpOVD9CKrL5
    iHUZcEu0szX9yk56S1Oj8wKSnLmWXXWwEPvr3sZaMJ8uFP+MUZIfi53pdIXVCwbdzcYeTv
    kOKkxNk0sHUbxuMO1M2YW8jRp/QHsRtOT7NDeJY6T1N912elITinpJfWmovI23BKW4hcSO
    RdQgqdZ1Cmq+c23v+4iFpfWXpMN19+WAJhlAewxfvMpfhSgnwAGzoF16jManiwyKDEE2+E
    0HIVO1VesxAZ9TphEgqe5hIUx2JWTt7X++36yLbUFPUyjHxndyBaoOveQU3zBsECe43Ud5
    Ev6DMu6/jFs0Pt8i4Brh0dqwswZQ70Q2MetORsuQ3GK/YE+WQe1Eop7hWoLngte9N8qukS
    P+/TwIOCeu3du/2TKQStKEYZdG69QSIMjgN0fGtUnbaaGyDPflbgM/dZSA0cfwKpaTZlii
    ZTk+tmwl34b/ta/c5pty6qLB7XHnroawtDASrwlIzfDDoK5EMYueORacBnBY7/vd5XdTji
    pRIohhuZxbI0NWJ2Ve2itk8l/feii+3OzgzZc8IoBsCnw7gYFE6RjHxJADTm20IW5nOWnO
    /DTZNCIUfXD5cWpLnYDuHRtmRoO4jRzuy/GINNleUVZKBU41g0tbyUkk5csA
X-ME-Proxy: <xmx:AfIratTJTCgGLFbCARuZGQOLwYJkz0r-Y8fk1iDNF-0DKC-Kxh0Cqw>
    <xmx:AfIrang27HM7zOJLhwDEGbPgIz3nsrEhc1hg05rCmrfZ7eOKeqyNbg>
    <xmx:AfIrau8fU2qWq1z1bfXVrUreJQk-7__oIcGE7ZR2A8IsoAGH2hWhVw>
    <xmx:AfIramHJcbSwCI_4HX4dHY_xm5mD15ijlHEk3kONNOSkozDU-XpHiA>
    <xmx:AfIrakIaKtsEijadiF8zbKKTLi2U5WfXGgv-LnthPXAe_eHnnRIGCMT9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 07:48:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7366db9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 11:48:14 +0000 (UTC)
Date: Fri, 12 Jun 2026 13:48:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] ref-filter: restore prefix-scoped iteration
Message-ID: <aivx-7VOKE_TC50R@pks.im>
References: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
 <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com>

On Wed, Jun 10, 2026 at 05:29:49AM -0700, Tamir Duberstein wrote:
> dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> 2025-07-15) changed branch, remote-tracking branch, and tag enumeration
> from constructing an iterator with the namespace prefix to constructing
> an unscoped iterator and seeking to the prefix.
> 
> The files backend constructs its loose-ref iterator with cache priming
> enabled. cache_ref_iterator_begin() immediately applies the construction
> prefix through cache_ref_iterator_set_prefix(), reading loose refs
> beneath it before packed refs are opened. An empty prefix therefore
> reads every loose ref, and a later seek cannot undo that I/O.
> 
> For these single-kind filters, construct the iterator with the namespace
> prefix when start_after is not set. Keep the existing unscoped
> construction for start_after, whose seek position may differ from the
> namespace prefix.
> 
> With 10,000 unrelated loose refs, the p6300 tests improve as follows:
> 
>                          before   after
>   branch                  2.74 s   0.11 s
>   branch --remotes        2.81 s   0.12 s
>   tag                     3.01 s   0.11 s
> 
> Link: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
> Link: https://lore.kernel.org/git/xmqqikjq7s16.fsf@gitster.g/
> Link: https://lore.kernel.org/r/CAOLa=ZRHKNNymXGk31YgECjUmF9nZ8GsPUdQb7aKBH5DKMz7=w@mail.gmail.com

I honestly have no idea what you want to say with these links, as they
seem to just link to random reviews mails when the above mentioned
commit was reviewed. In general, we typically try to embed references
like this into the explanation, like:

    In [1], we discussed... and this is relevant because of ...

    [1]: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/

Just dropping the links as-is without much of an explanation isn't
helpful.

> diff --git a/ref-filter.c b/ref-filter.c
> index 1da4c0e60d..9b04e3af85 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3316,15 +3316,14 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
>  
>  	if (prefix) {
>  		struct ref_iterator *iter;
> +		struct ref_store *store = get_main_ref_store(the_repository);
>  
> -		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
> -					       "", NULL, 0, 0);
> -
> -		if (filter->start_after)
> +		if (filter->start_after) {
> +			iter = refs_ref_iterator_begin(store, "", NULL, 0, 0);
>  			ret = start_ref_iterator_after(iter, filter->start_after);
> -		else
> -			ret = ref_iterator_seek(iter, prefix,
> -						REF_ITERATOR_SEEK_SET_PREFIX);
> +		} else {
> +			iter = refs_ref_iterator_begin(store, prefix, NULL, 0, 0);
> +		}
>  
>  		if (!ret)
>  			ret = do_for_each_ref_iterator(iter, fn, cb_data);

The patch itself seems sensible to me.

> diff --git a/t/perf/p6300-for-each-ref.sh b/t/perf/p6300-for-each-ref.sh
> index fa7289c752..ed9c1c6a19 100755
> --- a/t/perf/p6300-for-each-ref.sh
> +++ b/t/perf/p6300-for-each-ref.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='performance of for-each-ref'
> +test_description='performance of ref-filter users'
>  . ./perf-lib.sh
>  
>  test_perf_fresh_repo
> @@ -84,4 +84,41 @@ test_expect_success 'pack refs' '
>  '
>  run_tests "packed"
>  
> +test_expect_success REFFILES 'setup many unrelated loose refs' '
> +	git init scoped &&
> +	test_commit -C scoped --no-tag base &&
> +	test_seq $ref_count_per_type |
> +		sed "s,.*,update refs/custom/unrelated_& HEAD," |
> +		git -C scoped update-ref --stdin &&
> +	git -C scoped update-ref refs/remotes/origin/main HEAD &&
> +	git -C scoped update-ref refs/tags/only HEAD
> +'

I've already called this out before on other patches, but the REFFILES
prerequisite just doesn't make any sense here as this test logic is
generic.

Patrick
