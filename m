Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C362EEE7E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289442; cv=none; b=j0r7DTsvsA3N0FBid5ke6kbS+2S3ekkYXU2H98L+w39C2amEIZyCaMHqzk/yrzcbbVyQfinFN3v7acELmfGsScRTkrGeCqBp6MGC05uKK7UWI2eCuuT86vW7YCYHmpeqT+NmBUux97Hm04nUczGgxye3TxKm/jkZWSUflXL+48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289442; c=relaxed/simple;
	bh=JaFl17obraDhT1FGjKgwf7f05gpEA9U5XqlSRbcMVLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APFSx8Pw2Yr2rANsmyyMZk7u6JWtRhNX5GV76jXwj3U+4VKXw9SDkWhv3iCvDztU+ZojOXAULNAeWiSbIcvHJEW6ZLGnbWCh5s6RKpTWiYCmfhSQGRWYAugiAYolGbquNg4gIxrRlE6Ma/DEKBqVmEwam3G41hk/r2y2/+jZ9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ozuL2QyM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rsG44yco; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ozuL2QyM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rsG44yco"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CC44F1D000D2
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:23:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 08:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791289439; x=1791375839; bh=mDOHj6Sw9y
	Ohpg0MmVi6OPYupemJQ9WGJBs8SirCiAs=; b=ozuL2QyMhX9g5+ubFHog1RofI5
	zFmJx/jXJA4ljGvpa8pe3X3bkda1JDGELVfzTah64q5RQ2kJ8TJ1g1lavpNjrmpq
	8qmQa2pHsI1dw6aFgISrjrqpoMuchqb35cCOt7CVXGMg8zDY4iRGaWelG0OF2sIf
	6vsoH67vtbWT4UWlAbjkvACrhAGcuNdtapzDC3WANRMC1UP6vYZIdWmrWgeDQc8p
	slZwnXf8m2WjN7d696PedeCCKSazGQmFt3oQT6fFRqWXwhWG0UCzqoTokwT494XI
	v1EGbcq+0neCscGUEY578Pz35JRnbFOom3v1xUV8I8Mimj6nq6OuINXBQ1dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791289439; x=1791375839; bh=mDOHj6Sw9yOhpg0MmVi6OPYupemJQ9WGJBs
	8SirCiAs=; b=rsG44ycovDTChKATvUsj2dEzMfSJKIYluJhiBpHMiGO+2qaqUty
	0CNjUW0jfVrelEcRXIehLLXr2GOGEZ2Aj9krcnAentGPVBRAXzSnYZYJv9u82hRn
	obLad4E2DR/gwpxtyRvHvUsmWvWkttv/ESCW4R5wtl0gOKXgSHE4t17hHq5q+EeL
	EjJM2sU3/Tpn8Weu1zmVynksBClubI2l0DnbQH360YREZCb7rFX69DtI8nW9HGqx
	OU0FFfKDOX/3aX48x47f6Pgd/okwRfdkVaYBTcLxn2JME9ie18p/upB5oUSZFLaf
	z5hArS1l43Ut+G831EYjUm6gx6TcH0ybeCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791289439; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BMkDhkZugxVJxJREJqdQuyVRD7B2PwNAN9NOVz5SQizXVih
	v1BvbfEN3dnMR+M3X/MQMn2iCkJtafsuFgcisWtTDQ5Jw3D0/nChImkglYAlLn8p
	+IYqH/25ft7DnXU7sOi3qAIwYV1CkC3uzxIqarBjfgd6sITy9NIOSMFZM4AYq79j
	8JH2lnlVPv2XdCGXmaoyCvAbqk4gNs/z+QN6AobheEt5iTJYOpjHvjkmsNzDzdve
	tD3WAMrcYY2NeoItX6dC646+rSUXPUyzydirbpC/EM5w50Cvd3cAAXYw/zKJ+4oW
	LLmIkV9Bh7uZH9ikdPivnnqAAIeL3A+9BMsPU+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ySCrVWYnIBRzFpTrs9PPGju727bh4SR6NydvivlfEJ8=:JaFl17obraDhT1FGjKgwf7f05gpEA9U5XqlSRbcMVLA=;
X-ME-Sender: <xms:X-jEatiEvompMchvVWjv6FYUoyNd8yQ6a5czdwUfngC-XNXRWPBPjQ>
    <xme:X-jEaoA_LHHH4O_8r904YrvhBGcZACIsuKa5Qo6zk1Ca0zHdHddkACx6BxDrobyco
    xbD6X6Oy_IUjXeJ_i6vlv8waXpTJkaQukIFO-kUP5SBe8r0IPX0Q3E>
X-ME-Received: <xmr:X-jEaqv_LK_AvKPzaCnYUMaw_k1P-AbICG3c6ei8yU5Q-37oFGAcJECKn24xuJWj7qS4Og>
X-ME-Proxy-Cause: dmFkZTFQz55Ihd09OKZcu9fNFJLomD4+Q7GT0cGLXReMV/uQcYlfZW3bbV4SvsyyCZFcO+
    e5drco242Aogj8m080Rm6pjC1DkJfy13ocXaHLvLSBR87lyrMFE402N3V4OwvPIEFYAtX8
    UD0dEQAAOtdFnUL7QD4bRzHRL96qi0bf2BB9OJJDE3aAf1jpSw6pYPzuI2AfWoBV8Zm2K5
    18wqf3V2+HcjqPxwjrqLyoLacww7vks7yqgwskZb8bRWLOMHlufhvYZhflNBy78fVKlc9w
    imfyNoc2oy7ogolYzINTs0JP2sboPGTS0tL2FDsO7Z4SmUJ/5ek/AC9KWSB38SWHn8XjZV
    2R6Vzx7Un+WSQBi6hYdwqJkw95+xIDUf29gu6CRR1zPaHStMinFx9saHOdDWN3ab9DdVgF
    mPrO9txAGkzYJPXHn7LWfUkLR3efDne21DUfrGAFG0KQqLWc2ijf3YZZxuaAYU3gMUK209
    G8t4uByGQ112ThtNz23ymz8tMczCkGUL9BIOfR0qPU995e+MP0BdateEpzKEdpxU9AInT4
    V647dzSTh67YIr92B7y9EDtX1ct4DviKXbZiNxz5URMBHfn/i245Z7I/Dl2pO8RthEVrR/
    9TtIYeHpl6DWLTyizsXZg2+shOsNcuo8Lv1fLTt80wRJgF4kGkGLjw2ElO0g
X-ME-Proxy: <xmx:X-jEatbGWiddf4lV_UBlp_SElLwi-9v9DKBpiU3YmgNdjkExaEsJNg>
    <xmx:X-jEatVqWRtitssbySfn700d47Xoo5lELoUGiQHCWn2x9Gm7FqgARQ>
    <xmx:X-jEah7GAcs-jIPqoYrvDMV9-MgPDX4kD5yUL0d_wEumK-KqyhZOMQ>
    <xmx:X-jEaogB_YoY9jL0_PCMRgdpKnGj9hU7U9iXctj72z9XxuAAuZDCbA>
    <xmx:X-jEalQNKEGkYEzs5iB9Ei0LQQ8S9Qz1kgEo-mwkMYfOcu0vEkAe39kh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:23:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91512a4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 12:23:57 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:23:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0450: use test_path_is_file and test_path_is_missing
Message-ID: <asToW_aXYGCg0xuv@pks.im>
References: <20261006101458.604775-1-dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006101458.604775-1-dilsheddilu123@gmail.com>

On Tue, Oct 06, 2026 at 03:44:58PM +0530, Muhammed Dilshad A wrote:
> Replace raw 'test -f' and '! test -f' assertions with the test helper
> functions 'test_path_is_file' and 'test_path_is_missing' to provide
> diagnostic output when an assertion fails.
> 
> Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>

Good commit message, pinpointing exactly why we even bother to do this
change.

> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index 55c0fb3cb7..a2da2b0192 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -116,13 +116,13 @@ do
>  	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
>  	then
>  		test_expect_success "$builtin appropriately marked as not having .adoc" '
> -			! test -f "$adoc"
> +			test_path_is_missing "$adoc"
>  		'
>  	else
>  		test_set_prereq "$preq"
>  
>  		test_expect_success "$builtin appropriately marked as having .adoc" '
> -			test -f "$adoc"
> +			test_path_is_file "$adoc"
>  		'
>  	fi

And the change looks obviously good to me, as well. Thanks!

Patrick
