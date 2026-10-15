Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4E49E157
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047361; cv=none; b=irfSs9WIVKiInR4Q0M3+zR6XKshvCrS1dzaCjjb6MLP+a6A5JoL0ut69Eq+AVX1iclTN670ngLbmb9xhyOzmI5hgUiAfsPB8DmxKomJ+d1FcZkk2pDVe7NHHPSZWxZpM1FaBK1wn5tDVa+UkYkkCJxSweQ3BcE3MHTyu1Fq+iGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047361; c=relaxed/simple;
	bh=V9Z7Gxi6v1gAfZ6ea5/Q0aARItl0evFvyE9rW1TKRLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSFy0bnsDaRwQ3VTmO7t8Iy1pnfh2A77T3p4rwe4z/MmPUBMJwOdTWmrG4E/a01XafCq07xGAnan2lnP3zQFN8Ga5ZHdd/zEoJR7GA7kl30B/h90JuGQRZhtUltR39YQThcwkHZ0gnmhFRVNRRGRYm1qghfN8mUvMfFX2UfNpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F86Onc4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LBkTZHh4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F86Onc4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBkTZHh4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D704D7A015E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:55:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 02:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792047352; x=1792133752; bh=MUUT+yFzZV
	8shtjxwL6yKvLePDgMyPxTpXDwgmDf6mI=; b=F86Onc4UazxW6PK11swT/scCzn
	vCtjvTwtYKk1ZhH9VrVef+Sg6pbnDDHYzBzw2vL9ITtEOORgMwsCbOOvu9+vvBlJ
	h15A5SQ5t9jPKMrPE9y/DtZu+jY4EyRfFCxQSkEjSCDYFVGyyE1A62hvusZbspKG
	u5CK7vNwP01qfiCdKmk5Uhc5h4o6J8Zp/tMVTomG2QS7yGF7WEZ6h6DmfOilJqhD
	qUanF6pgX9EwOy7zlc2QPmYYv+XCLFVzcuH7Ec/amtXQL7vBfR/iLXONJ8Hbb1Jf
	cTnRPeGX4sMW6Lae8gIdOs8iMgmnbQXm1+xxlllLtqteRDvwQ8meJxewmucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792047352; x=1792133752; bh=MUUT+yFzZV8shtjxwL6yKvLePDgMyPxTpXD
	wgmDf6mI=; b=LBkTZHh4DAfSHff4Q8k4mIGHGncVIfGapRcTgPHYXPYLQF1WXLU
	KtIzF0XtRg+RSKDWkCDl7zxvuyHjpiNAqpupfO/a6AJJFadnGKqx115E3/w3m/GY
	+/K5cPDp99DBwd7UdcCTedLvK+k4tOdTNzMhmA0dxfD6oTabz7W2m7p6Cszf4Kq8
	mufZJGp0z9leiDS9Yvwx/aNCE86EFzD8fIwOiRWMLbHdpM/BsQVQhzgwG7PqfOib
	zAudggBz9Yyj1ZYew+LPszZMU91cbKzmMoTLXwMNAASAYqBzT0pZLArCTTfok0xm
	hvT7leeA5GcuCwhgTwvT/8d31f4/7BS6KVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047352; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:h/dZpXxNoF+9HQs5E8caZBpqvQjP09S/9/IJFZVU3D5NDwq
	GPZ9g/Av6kOd68MSAsjacgr3b70GfKnq2RlsICsKA16uDqlH/5vGUqu4pV7MXhwM
	ZJbDl41XW7EvIrXzZ4S7SeCxvEe4LeMcm2NrUqKMX/QflNPqU30mrCiYIHbYWLvB
	5GBHYHJ62awhdbltiliCDoUg4n/xDYpLftszJ1gTGp8bcY2ycCgpI/lSNuXMSRx4
	acIOV2DpC9qAf4a8FgGLH6dXeA88hzeCsN/Gxo2eM/rJ4tXb/YkXqCAwZNu5lFfv
	VSEiujjgpn2zyQcbeOmz/2AWwJ6QVCxRfBD13Rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RZDfBfeCJZjkokM3cQx71mDjO523jEPKD6TdO1C04Ik=:V9Z7Gxi6v1gAfZ6ea5/Q0aARItl0evFvyE9rW1TKRLw=;
X-ME-Sender: <xms:-HjQapPI8VPi5vIWWKtrJhykRQCH9j82hHDhsLpPQ_zVQaYjDQ8uBQ>
    <xme:-HjQajZwfAt5HdaF1QlpCrNv_ccl0fbDawrpDFieHc_DFmz4_7BJB0N7qExy6mHnN
    zBhxgBQow3-M-oRXociy9fiIDyiRSqxc8DxgIvLx-hdE5mWhO-9j1c>
X-ME-Received: <xmr:-HjQalpTEisplowJvlUupP4DYV47nOFhZpanFnBoRd0k0rvq3SgE5ZYch62fGrqbj-kJfIA>
X-ME-Proxy-Cause: dmFkZTGCaI+9vszqq7PsXJlDqnjG2KgY6aHgBkg9+/r8Wip7UnB70qswzRu9NL6bdamAkr
    UKC2T2ACjmHXbDsrpfdQsotbw5kKNACBHBKELLHSeLkiXjvRErtOkzezkpdnzW9jxgfODL
    4KZARb+uQSSBCxiKE9pOQ7Z7Tisauq44+0r57nu/CXl4HnMIeY5vKDqnN27WT4+epbACK1
    AL9YT3mcXVrUxULNtyansdtLUOX26O3qwdnwd9NAb01gYCZhX4UQyD3TGTPF87ohXwqzpl
    hbfb8jgZIJHrAIxSiH3Rf4aYZHXRzf9CwoZUSGp3lM6A+5tRiyd5vjb1mbna6R/+Go1Bfp
    DQ8iIojKZrPQqYEg6fglk/GiQEZyeuznmV+33iggPAhWC0a5mWK5uXpcAdOiQkA7xX3+P7
    QZyOW6vUV7GCLloJ0oPMfaMnMnsQ368dz8FQ3rHGxTzZKIedhh3q5WhjLfLcU76Db0/7NF
    /XmMgEFllqx1cshngIBspvAENo90hzeovxbPNeheg0exoBIYeHQfcrXA1Spk7vxU+lt1cN
    WnZvkN33GfpFZqWdAKno1JotWVLPm+lVSdYDmzrya0zyVM85bJul9J516Jk81SxJXYY2F5
    ImWCNTqj5qOS/Zne/3YXWc8yKm4EGk29nUN3FCVITOhmKNa9UGtaMtDpuMrg
X-ME-Proxy: <xmx:-HjQavbccplrS4064KFmSfT7gMPmT3hihC1c9Mc009zlkdsiZddbXg>
    <xmx:-HjQalSUlvlx7Sr8bMeg00Isd-Jfv5p9sbEmqiwQcN68f7Tn8pP1bw>
    <xmx:-HjQau4gYi6ViSkc6jEMqOGClNaJ_tLc3mtY0X7N3CvtpxyET-cu3w>
    <xmx:-HjQaizjmBbxflwX5qxIM8rJ2POoSeF102EmsZ8T-LihuJ_BBd9dyA>
    <xmx:-HjQakoIvW9yRKkBGw40bNPIJrlAdmfYJLwSx_8Gu_wfy3ae18rJxhFf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:55:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1062d28c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:55:51 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:55:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 3/4] connected: add transfer.connectivityCheck config
 and rev-list flag
Message-ID: <atB49SAaLKS3lfGE@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
 <cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>

On Mon, Oct 12, 2026 at 12:07:56PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Add the transfer.connectivityCheck configuration option, accepting
> "full" (default) and "incremental".  When set to "incremental",
> check_connected() passes --verify-trees-incremental to its rev-list
> subprocess.
> 
> The rev-list flag is accepted but has no effect yet; the incremental
> verification will be implemented in the next commit.

I think this step is a tiny bit awkward. My suggestion was rather aiming
to introduce the configuration option, but initially only accept "full"
for the current behaviour. The "--verify-trees-incremental" flag could
then be implemented in the next commit, and the final commit would then
tie all of this together by introducing the "incremental" value.

Patrick
