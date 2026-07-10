Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0D30FF2A
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653068; cv=none; b=u9zbZG34E8Cxs8IqcILdWijfnz41tAWI/rOwlAG53v20JmNSIaHuTcbfND4XCznW9M2dTn+dqNL8I5oYtHZLZ5YUqLa0iaWVFSi7VwySK2PU2KGPKiitWL1bnmOD8l7XCItIcFGNGTs5i1sYbEp6+cEkyA/4Dtt/N3S1MeNblLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653068; c=relaxed/simple;
	bh=PWPG0huTeuo7kEqIXeg7vQmnWfaZ8Gq9GHkliRKaboo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHm1ZxqqVLGJookp50lzyyi+36pllP8HUmjFdybDL1f2azNOmyBdj8X2dO0Hr7on9V+6/3KS4VGfUDU7EUrZCfSVDKxypXbfSEXv2uxeVcBvjdJN48fFP6dTc1debQguDeKLMeGnLGOaLo7Y3cOmJ9EctCkPz/XFEGM4z1gS6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KZzp2b84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faJnC4V3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZzp2b84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faJnC4V3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50E2B7A00D4;
	Thu,  9 Jul 2026 23:11:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 23:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783653066; x=1783739466; bh=PCXEZdbC6T
	p/zjy+fy8hVfo2j9Mhm29ax1DWBTG1CIM=; b=KZzp2b84ZNxphTvXOaQ/3hrBJ0
	pQ0qwB2xTm8K/MmzjMpJxFQrvPiyVsT7l5tl6LRF0q1vXjRpT7CWmeTBn6oKGVkI
	A8V0Y3UV26YplG9CRRWdR8nXRzwonIRAJJybxEzgM+0EvBTcSHIfmSHT4qAweOfS
	YycKtKAjl4I0lzRz5SfGkjO59jiZ8re4KA/AbSgjMrAn+dlgLQbg9SQHlbYY27mV
	zvUQ8OCtv8SLJOtrRAFQko7Ox0RGCkQow+p6kNVWsfc+gfoqLL4uAidLZ1ryxyzW
	qxvn++n3nJV8qNjYdawnicqTpLtQvWqQ5nEwUmMZ4l3VKEbafFUVa/H+Ms5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783653066; x=1783739466; bh=PCXEZdbC6Tp/zjy+fy8hVfo2j9Mhm29ax1D
	WBTG1CIM=; b=faJnC4V3NPJ1MRfwvlxeRChHdfbeAZf6Jr6DyWY7AjBHCyFiSF0
	HKfqUlHoEMm/shCGUsdjOW3yyJ1bIC6aT3RIlfrjO/yFTmlsexDL0Md4L7YIHN3v
	K4+fMmANp28uGjQHG4fSQtxM5YP3yEnbAx2KghLp+DYMAlYU+9AsY1f1y0b+Tgla
	ZsSJzdBw9rL3J/M0MQaGnvv6qb2HYt5af0/aeI7unSQPt9QJb1L6r2/2yrYwLYzc
	aS35pMoGckfaZuzbq4dCIAbKNzyhq6i0q7yj4BlWoSNEme5LZgfpfR9GmgxMA7Hm
	LskKsQOcUkFLWYHjiYqL4vqd6Zj4LshWBZw==
X-ME-Sender: <xms:ymJQahqbiEHfyYaq0Icl_LWxaKNgnAA5LPGsOBTZ-aafPWmal5iPPQ>
    <xme:ymJQaqomqo3pqtNg_tfnHar_EA-A9Qp_cqRKTJIFH78skQWc2NQV3gBomdlIgVwk4
    yhxj1IB9WdHd9JfYqYW0PnR7_v3v3okHblXdZvw8kZQdYo9oNhUPQ>
X-ME-Received: <xmr:ymJQajNA0a68TESiWCP0xXXLZBPWTlxFqHUAocXsnWbAdRqbfyKVAdQxGk9OaY6zgD5p6J0n_Zqb0yOewGPW88qfdzTjYsChv-3Fz1s>
X-ME-Proxy-Cause: dmFkZTGQoz0xqwSEdZMt6kNEgq4CGdR7DamQTWd6R3IxYDCw090RtDqoNA7HnrHiI39ZT7
    mtf/P8+vqJIXB3sdVcvRZ6YgpiVqhqDIh88dmDqM9HZIxBp/fvf0i4ZTHAfLr+0vPis2sx
    ctAVIytFoMFPPdc+nEC1SNjgNMsBpW6TAc08meo1ulnQBqXetKC0+AsVMJU6G8DATHDxzc
    ExlHDf03y408OogqKLxvH/revi+3c65xnp5lAnktS50ZgLN4INou//Ovmc7tYllYIO0O3R
    WobxAR9ItoXmEA7q1pA1+aMiaZuifNKQ7pMBGwQwKkyn8LmOl/56WEoOTSEZHnIZdn8jI7
    TDSAyDiwoXHCOgVvywWAieD1qpTJ03ZgnxF+fDRW6nzEOj9nmta25Vi+sGIK4THOLkeeDC
    w4QLSSJlmNLNXPkaIzRw+PRQrTmT7YAEiVeUQ64e5DVK2mQCZyhBUKpdWcvCzdIP1aRpRw
    DyoBxYcHdkXPvv8kUN+Wz955N4mcB/XaTHzHgJsjlpaur3B11l7GLMNt3K2OMEIV69qq/t
    wG6F6W4LqbpcS7b/EDCd87lqJxaUw1oNkqdvzMYh+mPRZGlQ28mtOB/yXh/RLnGgaBfPci
    bQGbR2OTCyuADLmEvflkqq3rWWxzMN0yP5QIuZtA7v8sWTvbxcdO+DaH4mKw
X-ME-Proxy: <xmx:ymJQarw16rAo1dobpactHUpAj9z1WGJcYp48vBaWugfvgyj0fZBaPw>
    <xmx:ymJQasv-kP7OQjPmsEwOLpwneqN1M3Li6mMsJoGWhVUWfEibZc7ndQ>
    <xmx:ymJQak4sYeTCN1VTYcR7qIRgfd8pdqcUOvd0NPrFFUFrY07-fNJ48g>
    <xmx:ymJQarQEAY9rPELOYeA1mNmvqv3VTKlR8J9_cMiuKpyXceaKRnRl0w>
    <xmx:ymJQaol_zoWzxDKVP6rdWaZm0SDSBMHSCocPyQUSPe8GsbF99SHnseYO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:11:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/11] diff: handle NULL return from repo_get_commit_tree()
In-Reply-To: <4fdba0542b3d643affe32ec35f27fdbabccf54d0.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:29 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<4fdba0542b3d643affe32ec35f27fdbabccf54d0.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:11:04 -0700
Message-ID: <xmqqldbjh73r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/diff.c b/builtin/diff.c
> index 4b46e394ce..18b1083e98 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -579,9 +579,13 @@ int cmd_diff(int argc,
>  		obj = deref_tag(the_repository, obj, NULL, 0);
>  		if (!obj)
>  			die(_("invalid object '%s' given."), name);
> -		if (obj->type == OBJ_COMMIT)
> -			obj = &repo_get_commit_tree(the_repository,
> -						    ((struct commit *)obj))->object;
> +		if (obj->type == OBJ_COMMIT) {
> +			struct tree *tree = repo_get_commit_tree(
> +				the_repository, (struct commit *)obj);
> +			if (!tree)
> +				die(_("unable to read tree object for commit '%s'"), name);
> +			obj = &tree->object;
> +		}

Obviously correct.

>  		if (obj->type == OBJ_TREE) {
>  			if (sdiff.skip && bitmap_get(sdiff.skip, i))
