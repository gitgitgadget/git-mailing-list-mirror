Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D9285060
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138739; cv=none; b=QszO9/xPsz6r/bMj+yLffCxoOotuPFJpGwB2JfPiZu5x1evamM4GW4bgV59QvRs8h2oEizN+p4H1ns4fqVVguhoO/A+ZUc8Rc09QIWrCgGS/fVO2Ar8rQfTZC3Edpe7RjlPzDuCF+yKNznjxOynNf4Vf/HouxEbVEr8NxlKIpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138739; c=relaxed/simple;
	bh=3owoxhhCFemtRRnr58Ifm0owH3/z6XwPhlHagUmrpLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpJ/J7rAXVBbc5/jsZQ6tpy3A0mEdF4oQ24uIogUUHrTwYKutOz4CIkgV9pfrz8lRaijqJWUfUrsmlSa714FMPh60YoNgGOQJIQM4NT91YOFYLZAAYroI2/alF6+18i2LAN0xT90H1s7jLyeOhelccO0TjoyYxoD7gpnVqgyVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dkYA/ezB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BEvHYDc8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dkYA/ezB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BEvHYDc8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AA5541D00111;
	Wed, 19 Aug 2026 07:25:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 07:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787138737; x=1787225137; bh=120hQhp1Zr
	RREbs1fnO6/47qAjsXCWVNvcza2ewA6XI=; b=dkYA/ezBLHm3LRmYnICDnS4Xm4
	28PMuRTdU+jLeVwDRzopiTIklliQKBNUEBnBBQ8cgwP3Cm7X0RgjtmsURaA4V1Hd
	NMjSa2IwU3X7ygbzLIR3aUg+tDb7B8tOKCpFS8QS5GDE/iaRDl0hBTNbHFNDewtl
	HrngeoANIHQCDqgUvl8f3B2rM/dwrqQ9rKUOvU+r8Wz+no8jAAuwp0oSey6PO+SB
	seRA9l63mWqQipkO0AthdQjnu/7nJPQyRm4uGsukGM+/NapkZ8X5uWXPK9BfH+Bu
	dPx55eSr5gr7tVBhvhDSEllc1tgtHwRjmPmFF20GMAGjENV0BsTIG+V5UEIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787138737; x=1787225137; bh=120hQhp1ZrRREbs1fnO6/47qAjsXCWVNvcz
	a2ewA6XI=; b=BEvHYDc88cyWYDByD2atQF6DkH9nPMyL+jc4ZYthOPgdhIjoaqq
	guIKTo4LMT7/BbNtCkfRGRY/rwwiL2/fjrSyZC9VFUFIK0JmhjOZQi9RHVmQP9Sf
	EIwn1DfyqdrvikfQIU2zQlrNiNpPpnUj4KMvrB9TvNCHAXumgPIytqy0l3xl7HCC
	B8+cuzmCys1I8l3WtoINMFJv3Sgqb75+GoGPusjXFg2VqeqTSMJMP0pEzY3cWza5
	pBLZ1CK3cq9ElY4Q9FVZZlU1fpXiQoKQtNBnQ8KkwcH7/t4WesWYB8jt3adCoelG
	0QI7jsyBv1VfRTrKtp9/4wOz61JN+nkjIIA==
X-ME-Sender: <xms:sZKFaqK70NTxkNqt7no6RWBr71bz4pSsHEDUQ1xFkh_0wfoxdbsccw>
    <xme:sZKFaplnnUxKCToy6ip7IhuTnIAuJy8fBeekrnNhnobigtygtgHR5_OgbbeA62DLE
    NcsNWkMufZ8UAF_5TtGO8GcShR6wXw5nCWR-KXLqcrRUsvpcMGi>
X-ME-Received: <xmr:sZKFaoGaom0MsXV3uU056zfLRo4u3fbJWCJTGtH8ZGI2rABt_Rm1zZEyzQbqC1hfDPrBCT8SbvO2Tbx0Y21M9MqVhpGDkQDfnelDm78S>
X-ME-Proxy-Cause: dmFkZTFptVYzvbRKkrofg19NlvmZi07HBos1ebaMNq+4CnyI1kbYdXeIgJJFhYAgr0HtXo
    G2HPjhTTms0osvZ9oQZ6HwrdBbjePhkv7kH2bKc+qjSKv/pibiTw3zjT4ewB/ZJYXucTnM
    84UcBy3N8ASqCgoxGtCaJ8/35pl+IMk/16DTsMLV069M9X2CctO9ZLbUU847QAPntMoBE/
    GVG+llZN/65/d9dUOFSZ/WSGaoFoplKn9WEQ6LNYiGm/Q+AQ7y+U7DiVSmqP9GjW4bQ7kk
    9SyKG1PhMjtsLobEnNBuT2r5TZIkQMr1/A3AT3i8DCuUiCnzF+dEzoR73jmxoZEzTa7xjs
    g+yp7LepKM0Zgk3TCUgXZITh/GlJODlS0AYVi/nZMOmJ1iOY8i78roFsXtP2RKrWK+2rm6
    1fTTFL8Yl21xjTofI6QCi0TQ144a1haBnvnUev1Vf4RPUIEfPskiETskK+7BRCbv76Kaf1
    lRF3TwDMdDQD4A6EI5XbDGmeV6qPKpS/3WiFqkVpkiuwuO04xiwEBQcawOCdBS6ApkYLJZ
    Bq46u+56ZhV5Bn6ebi50VTQOutIoBVMua7FytX1KwJVLHFLmGiYJsXu9w+4SMPWf9U4nP4
    spb/jKW369rWnBsxQgNrmMLWJ0m2hTeK9buvGV3TaQXSOadLounqFYaZpNCQ
X-ME-Proxy: <xmx:sZKFapEywvrAh-B_Xuje0_G1BDWDKUThLr98V-RdIfThV8WKbmQ4Fg>
    <xmx:sZKFalNJKwTiv_igsYx-uuMhZWe6q5NyArnvLyOuVMA1NH_IQP2l6A>
    <xmx:sZKFaoFLZEep5-RLiL1w5RCoeIkEUi6OSTbO1iAsIf6TQzPl9jmDrg>
    <xmx:sZKFasMVSWj3-QL4hdTFDkzVdz0Hf-tg_ylCbJ7Mwh1uzjP9pVtPwg>
    <xmx:sZKFanBRaGJhDMr4qrQqZPrA2zuR5upgfWUUUgVYcGPYyDHI_bE4qML9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 07:25:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1cbe1f66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 11:25:34 +0000 (UTC)
Date: Wed, 19 Aug 2026 13:25:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH] t1401: test symbolic-ref exit codes on a non-symbolic ref
Message-ID: <aoWSqYvANg5AmuCi@pks.im>
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>

On Thu, Aug 13, 2026 at 09:12:33PM +0000, Nikolaus Schuetz via GitGitGadget wrote:
> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
> 
> git-symbolic-ref(1) documents that reading a name that is not a
> symbolic ref exits with a non-zero status, and that --quiet does so
> silently rather than printing a diagnostic.  This was not tested.

Out of curiosity, what made you address these gaps in particular? Is
there any motivation, or are you just picking random things to work on?

> Check that querying a non-symbolic ref exits 128 with the usual
> "is not a symbolic ref" message, and that --quiet instead exits 1
> with no output.

This is testing the status quo, but what I think would be good to
research in this context is why the error codes are different in the
first place. I personally find that quite a bit puzzling, as my
expectation would be that "--quiet" really only impacts whether we print
anything or not. That it also changes the error code is weird.

> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index a2a7e94716..602db6d080 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -38,6 +38,16 @@ test_expect_success 'symbolic-ref refuses bare sha1' '
>  
>  reset_to_sane
>  
> +test_expect_success 'symbolic-ref reports a non-symbolic ref with exit code 128' '
> +	test_expect_code 128 git symbolic-ref refs/heads/foo 2>err &&
> +	test_grep "is not a symbolic ref" err
> +'
> +
> +test_expect_success 'symbolic-ref -q is silent and exits 1 on a non-symbolic ref' '
> +	test_expect_code 1 git symbolic-ref -q refs/heads/foo 2>err &&
> +	test_must_be_empty err
> +'

Do we also want to verify that stdout is empty in both cases?

Thanks!

Patrick
