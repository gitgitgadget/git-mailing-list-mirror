Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0E1E517
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387460; cv=none; b=ilMXuqBTk35H5tdH8Bi56QHo89PAlY0kc0p7WAlTH1MW6pmtqj3+IgJdvgon7c2PeX0i2A+IFKtuzvSnvooG0UDJ9XolVk9YPoecj0hlCY9++Ai+w6QR67Fm+7Zc8kFFeVJAc8dExlZNBc0tleMqSY/yPq5u+4PGTpsTQ3OjH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387460; c=relaxed/simple;
	bh=gL2dfkG5QcS4bIcxsWsWuRby/4Ts14+8G0eRrKTF1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbwztfRwv1Vfwjv8579Yz++cnmHhkVukdM59oU1t1o59D/jtjQV/UacQNVQuxrYR4nBhaKKfRf763YoHECI1QYybYHnpm2Z/x5Z55iNZqvFCpKUTMwTSInT48n060IgDci4BB+66JID3ag8ck1h5JwwmpSEpMBMkrth9dWS7M94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hHyZ4dYF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muvaaDlm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hHyZ4dYF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muvaaDlm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E9C63138071F;
	Thu,  5 Dec 2024 03:30:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 03:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733387456; x=1733473856; bh=ujUSCHKzZY
	mnLH4NmksYEC5ckwpb/ST+R5rNucX7WZw=; b=hHyZ4dYFOG3PF6zD3cgEe+1Djy
	gmapzJLEfEfoUyOV/9VK6fviMg7HBxr8HwFoiPuNXKGlQxeJW4KD+IHBO3e6BieL
	c7vqwy9NdBrYaGtS6pZYdeiOyjcwEJRc6QKiKgZSsdwYa6e8mR1rTsOP/COYcZeT
	mbupHbhS/5/a1g02MZxHBd2A5X8PpfSMKQZWPF2PXFZCAG9Hr1Bm7F2ZtdCJSP/R
	17hRomoVxUtoCcM0nOPmvovwcd0DKf/+/h6fsYRiBAnRFQ07ftgjdzvsd0rJNiMS
	G1B61mUv7ru6eGX41R7O4VIq+FAnTJouvS6pxSBHzk79ztx2Z7vTC0v6VE5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733387456; x=1733473856; bh=ujUSCHKzZYmnLH4NmksYEC5ckwpb/ST+R5r
	NucX7WZw=; b=muvaaDlmlcQ4IKKFE0dt4QapfWik8L0aChMJQBLbPkK3Tt6RN0H
	ziXO2j5cI1YptTTDcg+3Cbr47acgK9Y1FJValdfBHmkBm03mdaX+WOGvBxTjH+dJ
	cHtPa0rndMfYoGcDwy+qdf/msqjUGljS37KIZ3vDe/gqoFQ1QEwD+J/4+QY462rW
	0eibJSxEZoRr6j/V3md/nKFZvo1wXPG5DjfyXY8errDPieDw75o5cvpr0b4gHLiU
	ajYku62og9ebN3vaPXYUlx+DmlYJ43l4EuQNqhUmuMXMRFzSWJzJL9uazGKnVADQ
	QAb/m5gX3ap7qeYTpQs3Jeg6KEnNl6P+ntg==
X-ME-Sender: <xms:wGRRZ8dd2JjhjVb7-CsJZaJ9X2HcnGJq3jWszpBQM4ONl8YO4DCj8Q>
    <xme:wGRRZ-PTysWlG-8H3SdqLzua99YXrSsa-Wc3OOXQSsQamL4Ck7tz8Ys6teAdY_FBr
    5Nh82Kng9ziughVcw>
X-ME-Received: <xmr:wGRRZ9iBXpiEU-i7Tl0Ufhhsb8Zib6zoYRukdaSvfyhTwx7I1VADr6K73AexlrFc-C-M4wnL7WuMdw53B4VM2_cHP8eDa116uN9_v1Pl4OEHVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvggs
    rgdrfigrlhihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguih
    hnrghnugihrdgtohhmpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wGRRZx_F6BC2y4PcYPRdjTJtlaaTDepYyCn1K2UYUcSgPx0O9Q9ASg>
    <xmx:wGRRZ4uMDSsOf4kI052xK8QQqtJ4PlDB9mH_-6TmOosa7S3zbCQFyg>
    <xmx:wGRRZ4FVFBxrMASmxJrb2_PUPKHRmVV9RGsuz55tu75pR2WuKCoehw>
    <xmx:wGRRZ3PfA11RFCuwCFkZ1rg_Tw4EtSU0xL2JpPWMzfCOYThsCqKEfg>
    <xmx:wGRRZ8jCREllc4-qvWoWcgj92H2a75vkpPer9brUSeRaHg4Nj0tOQFAQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 03:30:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27f9f31e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 08:29:31 +0000 (UTC)
Date: Thu, 5 Dec 2024 09:30:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Heba Waly <heba.waly@gmail.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] advice: suggest using subcommand "git config set"
Message-ID: <Z1FkrsQ5tkz1pFUz@pks.im>
References: <20241204130928.1059851-1-bence@ferdinandy.com>
 <fsqe37ibvarrsjugc4r2cairndr37cmyc64jneaqzhkq4qiiqd@6rskou37aqat>
 <D63MDD4V1FLQ.SL5FXZ9YS8J6@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D63MDD4V1FLQ.SL5FXZ9YS8J6@ferdinandy.com>

On Thu, Dec 05, 2024 at 09:21:32AM +0100, Bence Ferdinandy wrote:
> On Wed Dec 04, 2024 at 18:19, Justin Tobler <jltobler@gmail.com> wrote:
> > On 24/12/04 02:08PM, Bence Ferdinandy wrote:
> > There does appear to be other instances where the the advice turn off
> > instructions are open-coded and thus retain the prior format. This does
> > result in some inconsistency, which may not be a big deal, but maybe it
> > would make sense to also adjust those sites as part of this series as
> > also. Otherwise the changes in this patch look correct.
> 
> Fair point. Grepping the .c files yielded three more instances, I'll change
> those as well.

Yeah. Overall I think it is fine to do an iterative transition to the
new interface. `git config set` is not going to be the only instance
that needs changes, but I very much assume that we will have suggestions
and warnings all over the place that may recommend other modes of the
command like the equivalent of `git config get`. But these don't have to
all happen in the same commit, or even the same patch series, from my
point of view.

Thanks for working on this!

Patrick
