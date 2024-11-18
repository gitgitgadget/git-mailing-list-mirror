Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98081B808
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915652; cv=none; b=sJ7onpgL0mqH61HuCJB2byegIiwSEuV2vA3l1HkrnQG04ZsqWRt5ggf18018hz89/NOQIJpWWGu6IAx5h32d2TUfVdyMMX5MI0gXb+ZZJ5+Uj/qRt9fJK8Nay1F9OLCOlvQQXhPxK4VXFLO57p5PaiYNljDca+JVLqMN6NorQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915652; c=relaxed/simple;
	bh=fp9aCQyqFLaYH43eqMVhTBSwEIvz3OSfVnRMqaruKxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzQoG3YE5h4dU/MUHbTlCNSDBp8Fw637Mmqc5cy+CZtumy1TCdFCjwGHCvAZmXb1r0lQ5hZ+vZJgobCRTXmflv4AMyvcTpp2g/Pqm/O69JVhev81Z9DiDjZTLr5Kb9zCiey33USqM3/ozBCWewGhJwkrsQv38lAkzAPtrYZiI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UlE0A06E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8vK+9VP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UlE0A06E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8vK+9VP"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B25532540146;
	Mon, 18 Nov 2024 02:40:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 18 Nov 2024 02:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731915649; x=1732002049; bh=gHlKXro9Im
	Vcxkg5TwhAYv1pS3gd/oStvgosa8GLR/A=; b=UlE0A06E2yGLMVTeKjrKgtjYMU
	n+X7sWVEUzehzkeUQJ++Upy3ZSZ/BrQulNpgjFiy96w42BIoKYH5ccnIC6cQCrsX
	g6d2Xm2LBL2dVyzlcWVoQKvmrW0MwB5M+3iCglyD6tKPIWKcGFrobBYZh0tTTMNM
	jcKFahAhK1f5KoL6eHyLyDIjmh84txy8z0T0aQZ4TUTGdujLUfJ0vPRnzj/cxBkE
	aAb4OoMJ9EhgVG2h58yfceaB+otkODP7AB/rTIgfIlh3GCkBm5sYM7me1O9S8/jA
	HxtKItV9+O7aJUSm2A/OJw8/RY56T+/Tbt+wtBSdOp2/hysi67S0AU3lNMwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731915649; x=1732002049; bh=gHlKXro9ImVcxkg5TwhAYv1pS3gd/oStvgo
	sa8GLR/A=; b=A8vK+9VPUVoVgMkDHSX74CJWWXZk8AyvTFxuB4ytrbwc6XVJETb
	QBOoRlqJ8Q9wEsWOzeJ7Wbl3uVTYbJWjgUw96DuzT/Vq2QhtZeawCBPvPueQMpY8
	d4TX6gvpU/FTeSG1QJSQnd9qxIRSSUdwKaFcquvk92DaoCK7gTfG2xdf+WVfQ70O
	vFqJl8wVD5k+xQbrV4lNkJgGzUqpwqEQJSseOuOgehUy1WD3g8fx54tvfLIfKSK2
	q2HXyc0tzKF6FWjZA0OS0qyY6vLGsgJGJa1Fy/dMpww5nenUPKzx4f0g/ZCJw2LR
	lTiLzQV93UYY+Y7WUSkEGSARbRlxNYtVYZA==
X-ME-Sender: <xms:ge86ZxVZaA9QseTxc3LZZFJ0H0au3S1s4QJOKq-MngoWEqbItsNtrw>
    <xme:ge86ZxnoyOz6vpRwvUuYrqZqTQ9t2IKSFXWBUic6OBm8GfDppisMl_HweUDZes4yF
    Ayy4tV84JTu0xjCRg>
X-ME-Received: <xmr:ge86Z9agfe5dhyJdwsJwSROY9rNzfBJHMHLYwYROUA8vjQ6O7KdnXVlMxUPIGWp1GXYmmUN-7GNr3yoNqnD8LvDCgypMv9z6xHd8EaZN2L235O8R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehsrghmse
    hgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:ge86Z0UrKYiHTASHChEYZOja3c4Nc_QNove0udTxITRXUfna078WLg>
    <xmx:ge86Z7kuR-wcFw_FFOHU54Y4RdBPDMcqpNIABzbb-aBnAIvmTcW8Wg>
    <xmx:ge86Zxe3u4-On_5GAqJPN6SHrU4BXgHbulEf75IO9dvRUIwKYGzf0w>
    <xmx:ge86Z1EwPQezq7HrN5hLmVswM2ideJ2WguDzWiS1GcHAweoisb8CBg>
    <xmx:ge86Z0AYjI88bCgokcPZKyni4qi2UEvBltkG14YIesGJymwOU9ub_Eon>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 02:40:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d1bd341 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 07:40:00 +0000 (UTC)
Date: Mon, 18 Nov 2024 08:40:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Sam James <sam@gentoo.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 5/5] object-file: inline empty tree and blob literals
Message-ID: <Zzrvdhl6m04QMBNo@pks.im>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
 <20241117091423.GE3409496@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117091423.GE3409496@coredump.intra.peff.net>

On Sun, Nov 17, 2024 at 04:14:23AM -0500, Jeff King wrote:
>  static const struct object_id empty_tree_oid = {
> -	.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
> +	.hash ={

There's a missing space here.

Patrick
