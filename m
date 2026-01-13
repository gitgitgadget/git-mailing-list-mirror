Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFA2405ED
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311401; cv=none; b=IFYJxeN2uSkRzekUQif/LrTOAu8/hOt8XBXgh5BmC1i33v852uBaX0epwks809Rq5hvWPuVrZefw2LRkifHWVspb+V3+65GG2ikuSoThz0ikm/FjvpUpwVr26Uw3Q6vAFgHVnCmsWaNnxwuhQ/t+Kk4IJyl9A3Pf15hWBGFix+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311401; c=relaxed/simple;
	bh=ZacUSoNhrGXMbCT2uXn1jTW916+k2H3SJ/h3SZowFk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1jceDqYO9ceisSaogFfqOQnH1DWqRpKLZG6I/e/x0hZ6drWGl7lVXQmhLZZxJaxgsSbLMQbkHmBrdCutA2kvIJ1iq4LizIYscjyjO/1S6awb/BNWK4MGbRVEgITITwfZ6Ch0cCv8MMr9VkfxFct6hrQNtwIByH7alhVAbNjXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BxjKg8uQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYn/nRee; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BxjKg8uQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYn/nRee"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 98CAF1D00061;
	Tue, 13 Jan 2026 08:36:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Jan 2026 08:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768311398; x=1768397798; bh=yud8GVKlc0
	//XmjzkRn6wIftcdsMKs8VwinufDOt6io=; b=BxjKg8uQz8VVuyH8j1CFZVprs6
	DV6r5nIYHVmK2x2lMt7OaC/AkF7ORy0TIVjbWNF6bf9mcmoipxS2Wvk0DLye1FRe
	bSQibNISyaRyQU8r57HvCbsD4++Yb5RZNCAenQzRIHWhjc5bWVGZPzqVzMUaKv3W
	x2Aobg6wnLt0KqJssORvCkvrzBwCbvtX/oUV0vLOWqeFpUbFXdiMasHSWHrtFZ68
	2s1xUEo3tNIPrbjYPb97lhBTgA2ICbWOs1VO6wsA9MABj+DbdHfVHNIlpNFRRARq
	RnYU8dbjuVsKtWgbW8vd2rA6Ol+UT2NjJ2M7nErrLFmBfTOcvR5xVoFp2o6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768311398; x=1768397798; bh=yud8GVKlc0//XmjzkRn6wIftcdsMKs8Vwin
	ufDOt6io=; b=gYn/nReeel/KrkrhgQ8gBLGisfVuoMnZAClN/sLVoM0TfrBLk1d
	UFle0bMmYpkMsUVj0kW+lrlKsbx57FGb1u2JiYGfmF2Y9tc9mN8J4Cmfp9tQii9J
	5G6Je63quRtUPchCGe4Zza0P7sUQBugV52ZCItUHUK8kJc2YDpmq+gRoruEdWj9q
	XyIQcMo0duW/8lbF/LChyczmbudiJvOrs95KwBuNj6CREHlepROQoeDhlaxiDW8G
	6x+2xdh6ogr1NQ7iBv+TyOfWEDzojfDmsYYhIUC6NRKVsy1vs3T5kB6aw21zUXQO
	RDxuhf/Q1PqWwkgGmEdOeWMOYW6KnFm3ang==
X-ME-Sender: <xms:ZkpmaYGC-wiJ5V6nZ6lZshppLa0kJaGjFG2_6IL8XfOJ_9_EmK32-w>
    <xme:ZkpmaVC4s-57eGCiNnJbirjdXQW0zm-z-cJthTGqG89N2PBKlHIYENk27M7jBLVNa
    SkqYCYFeo-qEXRNXOCv_efzkLovrAoBTm9YY8L5BEfYYeOU1Vu-pI4>
X-ME-Received: <xmr:Zkpmab-0oKy4aYEBimWi40bxTA5k8BbKLFXcBFafNW6Mnop4Sw3JIgrm5S-QIWrYVeGOfXWmvbA0pqE6UzI820ZOXnXsycMgbcQXKTp2Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgusegrphgrtghhvgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZkpmaRD_0QgJrFGeI6peCCi8DXLvdpqXLZEnFyeMz94HPy90Muobpg>
    <xmx:ZkpmaQTJx9VhTLk56dDBR5EANAn7wvQG4C-iUcIVbN2KSF1B761-bg>
    <xmx:ZkpmaYtNitsFut0qYD1b3VQ8zUUS8udFsSQ-Og7uaFAFjv4-80DzrQ>
    <xmx:Zkpmac1cus9AU9poCyZryuvxgIF_XI32ofNiIbIy3tMWVclHtNPxEA>
    <xmx:ZkpmaSpaQbOi3vbnZjs14zajPrfWHg7JgyRPbyVuweZYfwJ5_d99UAJf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 08:36:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 625a91ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 13:36:35 +0000 (UTC)
Date: Tue, 13 Jan 2026 14:36:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
Message-ID: <aWZKYAxhavFc1ZaH@pks.im>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113115633.230479-1-adrian.ratiu@collabora.com>

On Tue, Jan 13, 2026 at 01:56:33PM +0200, Adrian Ratiu wrote:
> The last batch of hooks converted to the hook.[ch] API introduced
> a regression because pick_next_hook() always sets stdout_to_stderr
> for its child processes.
> 
> Pre-push is the only hook API user which requires stdout_to_stderr
> to be 0, so it can be argued that pre-push needs fixing, however
> this will likely break many pre-push hooks, so it's better to allow
> it to be 0, i.e. to match the previous behavior.

Okay. Do you happen to know whether we've got test coverage for those
other hooks? Would be great to verify whether changing
`stodut_to_stderr` to default-disabled causes at least one test to fail
for every hook we've got.

> We can introduce an extension for the breaking change of all hooks
> sending stdout to stderr, however this just fixes the regression.

Is it really necessary to change this though? I wouldn't really want to
go there without a good reason.

> diff --git a/transport.c b/transport.c
> index 6d0f02be5d..8f0e5987ab 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1372,6 +1372,7 @@ static int run_pre_push_hook(struct transport *transport,
>  
>  	opt.feed_pipe = pre_push_hook_feed_stdin;
>  	opt.feed_pipe_cb_data = &data;
> +	opt.stdout_to_stderr = 0;
>  
>  	ret = run_hooks_opt(the_repository, "pre-push", &opt);

The fact that this was able to sneak in without anybody noticing shows
that we have a test gap. Can we maybe have a test that verifies that the
hook output goes to the correct standard stream?

Thanks!

Patrick
