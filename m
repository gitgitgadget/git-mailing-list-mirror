Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BF391835
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901992; cv=none; b=BlTfAapOLJOQrH6D9u+sHyNPAAVvW81VUFCaYN+LshfcWsrSN2UKuxIhJIyLhLxX8ZoBYFluAMFQhuI90gSQItWLpDYNQErbk7qqiyZ28Idsg1GT/XdbV7+l4srqGUUo+EPVJ+IZrm4DfTQCUDwSDiHqZWP2rtLTJS0KKBrfuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901992; c=relaxed/simple;
	bh=MPEWliKbyOKqLHkaY0rn7YdkjjAqBos84nHTIBLJvPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwthvrj+asEBYY369r/XR6ahi98xvG8fvhjWyjo315uccsn3sUgMDRs7RDlPHRWRAsZUOkzBcVLfNcF6s805AiDwdUdCblfdGlQ913H9K/jwWEYUM+xwqu1VbxzCVgSvmTQAD71p0tgJdUEIBhrT0k4RGNmKj+bWng+xMZk51fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQ4IYZWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcAusfcJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQ4IYZWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcAusfcJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B07E7A00E2;
	Mon,  8 Jun 2026 02:59:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 02:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780901990; x=1780988390; bh=DPdw1tG3Pt
	NR9H2EcTfDUpil0hWLku/zbubbdIOVX0s=; b=aQ4IYZWhntlivcD9PbIWbLnbrP
	az7Uvrw7GvBs2GI4jTix6zX14WVaATJSPbI71zq5e3U8shkMlqIlbA1UCq3H5FP1
	EHJVSlECo0D1f33MgjiieWRL3pJtt+t6uXt9C8P2UyJnhj6Syx06uZzsV4Zquiu8
	WXF7YD4cIDwKFzCsA+5UsHOr9oxrVXqeL6cNuFiqRU86PxCzb9OBlVhiJ3oFQ9PP
	tFHFTEGt/qUXUxlmVvdj+fuHkfm4qcxV6j1sYfIGvUp0038XuzNUSeOD4HN0cOES
	vSGN64Kpx5RyQcAcdoTLjt5xPkmWwkaw4SyD3nkPRGutsKpqRtdfoHMHQrag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780901990; x=1780988390; bh=DPdw1tG3PtNR9H2EcTfDUpil0hWLku/zbub
	bdIOVX0s=; b=OcAusfcJHWVA3+/Usgqh2r6uCCptW2q/Om6nKU8+HwNRtUjb1ee
	AUWVZkieCmm1DuTUP38LuJxrBJIeTiODDLLTzZcNAbq/zBn3Nd8OiwdOWNspL06B
	a0U7wqBmRPfR/6xygwhkgfgKN0KZzDLvGnRjaPJJNUUwqfhMbH5mzfcgVJ2L+IKH
	eXqZ7yv0JcozsKJWhPkxJQrT8DFMpK2yLB+4jx1LN15oQuLmCn5ItGUa1pE9IJ7c
	yNFknnVUCQSzAL/HXzkXvjReEirrMgihf7va67qxETmn+QP1oj76Nsakkrpr0ATN
	LycL8+n0ktOomxsgtoqE/Y8vn/71jaAlcaw==
X-ME-Sender: <xms:ZWgmavrWeTjwNAuRQ3HI7KTTKFJte-sgyat_nTt6RSUPcLPdbrwxMA>
    <xme:ZWgmaggLqpjOZLZoFRQKaLae1S5oFLEqnUjP_OvDRQ4pqhUWG9TpppAK_AZhCRLxr
    PNVsLJcOW8DvIdJz4YFHgseCfbjotEpClHCMpljwoV_mIDujSvxFg>
X-ME-Received: <xmr:ZWgmakh1woQ3gcZ5iIEY89UMPvafgyHRWS91oPQbsMjYHGupGrMDdJkc3Hi0C_lzK6ThvUqs2elxCsvDs1TIzTeBHcvQzVRebARvPo1D-w>
X-ME-Proxy-Cause: dmFkZTFS/IAhXtTKIbG30R40FSPq8VtzI3noMWAuVAAteMlxpfGlThelaKkgh7itdx/wvg
    6upe5bgh95CaHyL1vT16gPwY9nPET2Bx4Cfh9v5GBShD5s6KfN7lfFXrSvEKe1z0apDl2X
    ovFIHQ3mOW2pYWX/qa4ck8LXuHY7K6En2nZSPy+iJSLY/wftNbnvi23L/CRLHQvbwIdnlV
    L9aPdA+8gV4rTKQjGhODGmj+Jaj2IorA51wWDQg1S6Z7R/pIOsWGcRNtc+SGgGrU8aIwJp
    vQqyixEVrF3omMpliCumwA77B5rgRpEDK9mJyYoipe201fePmiN1fKUcKkIV2leAMjmlG+
    ZNiP2re4E6Givpo+lbIX++zUWA/pLJ2O8k6hSJ4DLGBmmjeSwhc0Mi+tpxDHUKd0myZEno
    FNfwpXglK6c7ikFc6zrsgmR6Aa96DKESETzDNzuePMHZ3fNHRxYmFZC50Ow0JkbSIuT6Kv
    d6cMtR1EHzrsMRBisFWBJIMM9mIEswBPGm8UoDqPsajVa9XHHtOutvlTPw1igY4LdU1jte
    x98UrMVPpR/6jyHj4SRoai0Due/ud8gTv2eaUXepEye1uq9Xdq8EGtY9UqzWdgf+gmcNTu
    LQSEDJh8MyN/MISM2T/71MViGiem9Io8vMDVR895dRJfiBJRwrEoKKh42EnQ
X-ME-Proxy: <xmx:ZWgmaujJK1AhfmLqD3QvajqBfe0sIx7G-GR6Y5a1buPLxOz9qQFgTw>
    <xmx:ZWgmasIkAQFsIBIxO2PVk7RZjQkF1EORvHviQoC-VnYqhZba2puQuw>
    <xmx:ZWgmalFMV5diky7l8_T7_rqKPd2LyHe_V3E8om8kfnAPtkY3bM-o9Q>
    <xmx:ZWgmaoSMoc3RxxPDJ3BdHxx3kcfSJnPW_0pj3hMnBTMKJEsh98n4ww>
    <xmx:ZmgmaoIN7XyEOMNAArjp2qGEkvpXJ2U1xco65mc0gOfZpYL4ApAzeFch>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:59:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77e1c10e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:59:47 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:59:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] describe: limit default ref iteration to tags
Message-ID: <aiZoYE8koq1UKlWq@pks.im>
References: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com>

On Sun, Jun 07, 2026 at 04:51:53PM -0400, Tamir Duberstein wrote:
> Unless --all is given, get_name() rejects every ref outside refs/tags/.
> The rejection happens only after the ref backend has enumerated the ref,
> so repositories with many other refs spend most of a simple describe
> invocation visiting refs which cannot affect its result.

Right. The relevant block is this one:

	if (skip_prefix(ref->name, "refs/tags/", &path_to_match)) {
		is_tag = 1;
	} else if (all) {
		if ((exclude_patterns.nr || patterns.nr) &&
		    !skip_prefix(ref->name, "refs/heads/", &path_to_match) &&
		    !skip_prefix(ref->name, "refs/remotes/", &path_to_match)) {
			/* Only accept reference of known type if there are match/exclude patterns */
			return 0;
		}
	} else {
		/* Reject anything outside refs/tags/ unless --all */
		return 0;
	}

So we really only use tags unless "--all" is given.

> Commit 8a5a1884e9 (Avoid accessing non-tag refs in git-describe unless
> --all is requested, 2008-02-24) moved this rejection before object
> lookup, but left iteration unscoped. Pass the existing refs/tags/
> restriction to the iterator unless --all is given so the backend can
> avoid unrelated refs.
> 
> On a checkout with 124,357 refs, of which 330 were tags, I ran the
> following command with the parent and patched binaries:
> 
>     hyperfine --warmup 3 --runs 15 \
>         'git describe --always --long --abbrev=40 HEAD'
> 
> The results were:
> 
>              parent       this commit
>   elapsed    196.2 ms      63.3 ms
>   user        69.5 ms      48.0 ms
>   system     123.0 ms      12.0 ms

It's a bit curious that you don't post the hyperfine(1) results as-is
here.

> The wall-time standard deviations were 13.2 ms and 2.6 ms, respectively,
> for a 3.10x speedup.

Makes sense that this would result in a sizeable speedup, depending of
course on the shape of the existing refs in the repository.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 1c47d7c0b7..3532c8ff22 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -740,6 +740,9 @@ int cmd_describe(int argc,
>  		return ret;
>  	}
>  
> +	if (!all)
> +		for_each_ref_opts.prefix = "refs/tags/";
> +
>  	hashmap_init(&names, commit_name_neq, NULL, 0);
>  	refs_for_each_ref_ext(get_main_ref_store(the_repository),
>  			      get_name, NULL, &for_each_ref_opts);

Another performance optimization that we could do here is to wire up the
exclude patterns via `for_each_ref_opts.exclude_patterns`. But that's
outside the scope of this patch series, and also much less likely to
help many use cases out there.

> diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
> index 069f91ce49..dfcaf59e90 100755
> --- a/t/perf/p6100-describe.sh
> +++ b/t/perf/p6100-describe.sh
> @@ -5,6 +5,12 @@ test_description='performance of git-describe'
>  
>  test_perf_default_repo
>  
> +test_lazy_prereq PERF_REFFILES '
> +	test "$(git rev-parse --show-ref-format)" = files
> +'
> +
> +ref_count=10000

Let's not declare this variable outside of tests.

> @@ -27,4 +33,18 @@ test_perf 'describe HEAD with one tag' '
>  	git describe --match=new HEAD
>  '
>  
> +test_expect_success PERF_REFFILES 'set up many unrelated refs' '
> +	git tag -m tip tip HEAD &&
> +	for i in $(test_seq $ref_count)
> +	do
> +		printf "create refs/heads/describe-perf/%05d HEAD\n" $i ||
> +		return 1
> +	done >instructions &&
> +	git update-ref --stdin <instructions
> +'

Why is this limited to the "files" backend, only? The logic should work
for both backends as-is.

Thanks!

Patrick
