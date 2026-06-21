Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B002D3725
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782083867; cv=none; b=PlzDeKnI2QdA8yk6lzCofLaK9Rb6kog61flgOnoa4khzj6WZICSZkrDBRwBhFR44TkQSJYBlTlXZtJ9jLZ1bLHvEvEzAp0cw5N51JnPjQzpNNfktG3X+g1DFEifv8cBVedS8YglKUiHNk/bZ8DApGYhUn7hyQGw6wXUsTzAG7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782083867; c=relaxed/simple;
	bh=UkSFCkWwFgB/GLc1R366cRYCgDyVTF60LNjxCGMS0Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQjC4uIkSscEc6X67n6E+j0D8shb8y8S7X7fh98lZ+Sr8L6Ct8tx/ojI94b7shS697J6qI9FoVTtZzbqqAokyhvK2RjKVp8bg6g95EadTXcJ8d4K0AGNbVeViQw/zqGJVE5fOF3sSb+ZSkZp4A+WTirtMT3RCVQdJ/eEItNwl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tyq0CpsB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPoGjkOQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tyq0CpsB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPoGjkOQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04A5514001E5;
	Sun, 21 Jun 2026 19:17:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 21 Jun 2026 19:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782083865; x=1782170265; bh=fSszHKx6Fo
	uqjrPEpmFnpnOW8zpsKxWJXjgoBFe0Bo8=; b=Tyq0CpsBnMPGy2rgsKtKGLibjI
	KIJsh/Lp4MQlCmB0u4etV4j97BrCPvoWURSkcKtVMDooAIVu+qXojK+I54GjXRiT
	GuYFALmpI1DR119B/HDcRYeAdWvkVq8kmX/B2voDieT3UwFtuZ5JqiLQKiPSjLhu
	6kfJwkFxPPiNWfxrcVn2qWfqFKMMKxbK4pv45kJQrewopi8779KjYZceunCMXJLX
	9Fm/DsE866Bqxv4AEvwF61wzlE3RIEefXM5OgHYTs3tYYOgLRjqqZGm1srhKMnRj
	G3p5DFgnWdxsepO46X1gFbGVxp+gU82y7kUXMJHtpw2REWjiAfbGg8ZEyYMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782083865; x=1782170265; bh=fSszHKx6FouqjrPEpmFnpnOW8zpsKxWJXjg
	oBFe0Bo8=; b=WPoGjkOQb5/Qn1C7IkkjDfpvs5YzLIrM+AaXmVzN0eFJd/CfaCP
	19zzJgLn63LdWamScPojBv/wCP5/7ttBQVPK4pblk5g4BFYAIOAJ/YfRXe2tfufX
	+/hRbUU/fOOXkp/6tOrxeCl5WKXmI66Dkt6Vq1eQqG18eg1qvBCEJzdT2xikoU6p
	CDSMuGmx2+MzGw/Hva8+0A0bUKQI/q96IFkM7GvCZFft3EXBm13OVme0evZNPaO/
	/y7Mqw5az59X2+TDknthg6TvUClvzkBexkus4mghlTCc9ekQA/KtCWZfRhEjhtr2
	tJbI5apQcRYjNPLLsin+QvysKPa9ZSdCzYQ==
X-ME-Sender: <xms:GHE4ahfhOyNZL6IbVb722EzmA3oD8p5nnlxTx_KeeiNo2cjKJHnCCQ>
    <xme:GHE4apyO161g3FSLvx4LhXeCuaxo6S-yV8PUtEJcVDwy_QREgLgi77IZ1pWp4bfXW
    sNUgiYdS2aj04eT3P6zJHQD9JPnTeqhy2jPq3OE42pjpcPmq3Mc0H8>
X-ME-Received: <xmr:GHE4anHu10f1oFQL9lt4Vfm988ipWx5TwOIw1-8pfJJ7DnxaZfOrGvbkt46sPw-ElFgNlEh75J1Oicd0XXJlKG1HGzTokA95WwRPp7w>
X-ME-Proxy-Cause: dmFkZTFhPqvaExEU3Kpjjva/6oZhhBEDV+fA/c8bCA4Lk6Vs3hWWMe/MQDoGGBQSDrmw9K
    6/D7DXRxzOz63ooHbPjl028GbPYiP0dlly24vht3iucRm6zLJw2V8tpJaluwI592qSv0+n
    +y2918+KYRtiY6MYMAeaHziM3s0zOp28ymfoJogI4vOMgoHh0RwXCmeNFtb6uKxJadfkTb
    dyTyf/ekOEy9wREp/EO0EwuOpGyoDxG5mXpZ0gadcc4b6ZkoL8HFe900cBexn3pTiamBg+
    6ij3CcRateLXuZ4DduW8d8qc9/Y2g6sK+1ay0AtguEaO/cWUlGdVxsaoMiX+Je7IhWoviq
    tNJOQrYG33B9NpnR9lidu+8zIWTy+PD6v8/zUuevFKZPZYE1Zo/NSog5tXqNRxWigCSPQB
    PVuJ7DRvlo9aTw9DnDPlmfup6grNxpFuAouum0yMa7bXQYh++ea9jw8f0JihHD9Kk1M4Dd
    igIc+mbuhiVMp8obM8jYPIVn8QiJzu0eNUNTGD1+VFWdI1Nn9ahfx+NceR7v/MkdnGagyP
    nMdMxlIsSDeMGs3quiz21XbVoxcr2oBT1loBWElKo2gUdbD8LjYnCVTRHUIeyrl+3oD7qJ
    7ICauHfmCdSFaUNiXlGGJCt/KpZ9OmraJFP+1ItPwCkHXi+3sEgl/2/szhTg
X-ME-Proxy: <xmx:GHE4atxBlxLIv-tB8w4oKJ7RlWJmU_fvIRSm10zL0wGMxXDt6J1CDA>
    <xmx:GHE4aosA-ZzS2cEye4wFdewyM2OLdFvlfTstf9Rdp451W8eDYH75aA>
    <xmx:GHE4aq0wkR7skkmKmYIwHxk8SvQBFyPNRm0qI8bKRa2pKjabrl0CXw>
    <xmx:GHE4aj8ONna2DJ77WwPbQ8KnVz7C1SiJEzXgaEFUMPf1HdnP40KrFw>
    <xmx:GXE4anMME-QDgE8dIRL3WeL7RV2OmJkYxeLTuXJ4trk_HsVnSzsonm3L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 19:17:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <20260621212805.GB2297179@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 Jun 2026 17:28:05 -0400")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
	<CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
	<xmqqa4sog1e9.fsf@gitster.g>
	<20260621172432.GA2206349@coredump.intra.peff.net>
	<20260621174518.GB2206349@coredump.intra.peff.net>
	<xmqqfr2f7iay.fsf@gitster.g>
	<20260621212805.GB2297179@coredump.intra.peff.net>
Date: Sun, 21 Jun 2026 16:17:43 -0700
Message-ID: <xmqqa4sn5vqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But at the point that we are comparing nanoseconds, I don't think we
> even need to bother with the delay. It takes maybe 5 seconds to write
> out all of the linux.git files and then the final index. So ~20% of
> those files will have the same timestamp as the index. With nanosecond
> resolution, we'd expect that to drop by an order of a billion. Even if
> we get unlucky and have a single file with the same timestamp, that is
> not so bad.
>
> The code to do the nanosecond compare is already there! But it's gated
> on USE_NSEC. So this (plus a bonus debugging trace ;) ):
> ...
>  	if (!changed && is_racy_timestamp(istate, ce)) {
> +		warning("%s is racy", ce->name);
>  		if (assume_racy_is_modified)
>  			changed |= DATA_CHANGED;
>  		else
>...
> makes the problem go away. I'm not sure if I'm missing some case where
> we could be bitten by the problem that led to making USE_NSEC
> conditional, though.

That's cute.
