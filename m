Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE51C9B81
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786101; cv=none; b=VHOf7+75lnSt8+rWm+LjyFZkk2PP6nsHairhpoByu6sdBSUETTz8vSwXLEXIYpxzi2P4ahUevwBh1totyO5LhavV/gXVZ6iOMeRRFGK8SjN5FhiymqnAL7qY/eTuyl908WcjzkN9ISsA0P6HF9EvKG9d0QYFTWkXge4mx7pepiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786101; c=relaxed/simple;
	bh=B6x0F7Pu5ybVp/wr7+EFIgcy9QD8ROx1/qHN/Mzpuok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=selMCKBAr/wJeR/j4ibitn7phz37gIab207ZYsuaUK45/xGtPJClFOFNwZxkaUirKoHK1o0Dwy/xuKw0WSQv+w5vd79S1WNR5coWflvitO436Gi1xkd2qLn7TMXj8cDB/JQT+M0qpgPUG8uRRXsl7m63gVWNItxr9buPqxVoh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RZCB8Na0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/iCxs2B; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RZCB8Na0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/iCxs2B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A1FC13804D1;
	Tue,  5 Nov 2024 00:54:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 00:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730786097; x=1730872497; bh=THXHFdkLcl
	uu01IYGm/2NGbTVGQxdhA/OcfmOswG1NY=; b=RZCB8Na0+0N8jCR8Dr/9kYP5Hq
	IxAKFpSk/LBrQilES++eihvcMspwDksJzTbANxsLwo/Kx4eI6/gYuMgn2jsFYJvZ
	Yv4vdwBfpQXuJLTla5o6QVFEybX8Vx06tePfDL8HKxXgFxXjocrflbNx7RpnCveK
	a/EpRJJElXWDbq944nBkXGvKt30hx2C+tnoNcK7l8/PtBcHVLT88iZYr2YQft2Fq
	gKnffb6bUoQKFMjs28WtNXKL5B+ighMgAoWSH+Qt8UwhlNyJF2ClwlMyDPUKQTHf
	cYuHH4P7Migxy5/iHAZEIz6GXVziOF9NyYOOXngI3dUzyD/lCeurklFG8q7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730786097; x=1730872497; bh=THXHFdkLcluu01IYGm/2NGbTVGQxdhA/Ocf
	mOswG1NY=; b=a/iCxs2B3QuqhCXV8KRrjiPZXLS1lLSuUtB/OFcO+r7jUgQJVNH
	ddi9st3sv9H9jL0GS35len41BR4jQJGLStos8vocnw1cHunLM7SFk2vbG6sRZVx3
	/k6qtYPC6DO35CkKtphEnYVS92pPWgYCLpC0UW4c4jLvCpUMcuz3b0EWnD1aogWB
	A0sRgqQQFUV6j8jD4dbQuktCLXY7gaCV04zNlIfag+MK0t9Swb4+TMtPyhHfd++k
	Sfzl54DHKA7tFMHdnOWQD9nsqo7XjPu/i+dTuS5Dct0zV7PYg6WMq/F+TKuHGMGi
	nccb4G1nrokPS8wmHLIUwHEnQo6y309kW5g==
X-ME-Sender: <xms:MLMpZ2A33xC44HvQ8ypgnKhbIgtQq6Cn395dJUlJBsOGMjs6qVVgBw>
    <xme:MLMpZwjwQE9qneqdCAkBdAw--apadUAhPbdab6Kcw0DmAMKtioqgXhBPbE0BE7SiS
    k4WpxzAOGD-TMho7A>
X-ME-Received: <xmr:MLMpZ5m7DUUUDsL2XLltzkcJ1f7kav-P9I4nW6uMG9ktFQjnlSp4gT4kETZj-Hf6wagh95QrIt4eLEKDiSYWQv8izpRIKpLb-5naM4l0m4YSqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:MLMpZ0zCU6FpNTv2NEJWtcRL2zuXznn8sAVX2ucyx2hdA1PImGcVJg>
    <xmx:MLMpZ7TGjTNSMiE0unbXq8em8p52H_HobJ1-GpGsDHU3W1up6oofoQ>
    <xmx:MLMpZ_buuRr2QtKSmRz9ysL86ynIWLNtk2L-nnj-sTSoAFXndluLEw>
    <xmx:MLMpZ0RUQX8iuZ7mOU1HoDaIGn3BHH4OkQ4YTmzatVC3ur-g4-6ENg>
    <xmx:MbMpZ5Onh7n8x-0HgYWom1zjxp80ndDxkTGORSTWu8j4_QCxUJo2WBMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 00:54:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44b7b2ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 05:54:32 +0000 (UTC)
Date: Tue, 5 Nov 2024 06:54:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 10/22] trailer: fix leaking trailer values
Message-ID: <ZymzIZpQV8FHKpVI@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <e3ffd59123f23f53c0bee930ef7602acf2d800c2.1729502824.git.ps@pks.im>
 <wh227vmiokssq532pqfefzxlbt6ylonwza3sxumgohpwuojxbv@k2ujsz5upvop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wh227vmiokssq532pqfefzxlbt6ylonwza3sxumgohpwuojxbv@k2ujsz5upvop>

On Mon, Nov 04, 2024 at 04:25:38PM -0600, Justin Tobler wrote:
> On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> > Fix leaking trailer values when replacing the value with a command or
> > when the token value is empty.
> > 
> > This leak is exposed by t7513, but plugging it does not make the whole
> > test suite pass.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  trailer.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/trailer.c b/trailer.c
> > index 682d74505bf..f1eca6d5d15 100644
> > --- a/trailer.c
> > +++ b/trailer.c
> > @@ -249,17 +249,23 @@ static char *apply_command(struct conf_info *conf, const char *arg)
> >  static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
> >  {
> >  	if (arg_tok->conf.command || arg_tok->conf.cmd) {
> > -		const char *arg;
> > +		char *value_to_free = NULL;
> > +		char *arg;
> > +
> >  		if (arg_tok->value && arg_tok->value[0]) {
> > -			arg = arg_tok->value;
> > +			arg = (char *)arg_tok->value;
> 
> Naive question, is this cast not redundant? From looking at `struct
> arg_item`, `value` already looks to be this type.

Indeed it is, good catch!

Patrick
