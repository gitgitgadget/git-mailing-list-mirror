Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376320298D
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178771; cv=none; b=QG2D7pAcXsGZxmzlnfy2Icxbcb7z2mRx8E8UBcVxL0nrbFFHH1t2ODUe+aMEzIz6vLFrSbdt7Nje5/5bLx9an6Dm022j+nOMntjZX3uzWPY/kvdYW6EfFXZZeTT/QGr1XM664kEij3U8SmacJ+1xyoVKAdnkGni2dOgg85qA824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178771; c=relaxed/simple;
	bh=AKrAcYenESTJcf3tX6r2iip8q8QChGL8KAN6laYvPLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSy8ksmnUOGpkJjiDTH05m0IRwiZxMOPCNSSnQAEXFF66bCwCkj0K0Hk7lj78ULnTOzeAWphDMlDvi65x+tcSRImL526gH34arCZzoPWCVtU12+i8t3s6T2b2V4MVGGF1ZKERr4BH1eC+N0IWG0G9BfPhQAxdi6zBBCrOHs7Xk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OlOWE5WT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aX/6Y4EA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OlOWE5WT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aX/6Y4EA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B407C7A01B8;
	Mon,  8 Dec 2025 02:26:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Dec 2025 02:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765178767; x=1765265167; bh=opN+JH/sGB
	lOOFOGGHyAOanu34o0B8ykhxGo0/1ZSgc=; b=OlOWE5WTaXUUEzt+9Vu+tfMrTK
	mCKxNZpnJ9QbHDzH+cdNTDOmdY3Qkd9/1vHlBYDzQX6/m+jDX8F3CK+ScEY9LsVn
	LVy7c8yXMkoefa+Oc9IwKwxz4RYKWqTI2gHgI7cBJAffbOdeBjo2F9GFME+zwomb
	kDVdW+aToLmSS38YuPZFPwE0akSK6QUaFW7UDN31jfeS8hmUtPUdAyAn4+ogUvz/
	3Iyen6pu7NqMKo3HnQU+lI9x5xdzMCy107XZFIv4Q3SoH5DnptY7YcR9NwNzbRUp
	RskHVB532r/hKxh3UZUm5gD2wIWL0GSoj5Hr9X/fpHZYt4Zei11eWQaRweWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765178767; x=1765265167; bh=opN+JH/sGBlOOFOGGHyAOanu34o0B8ykhxG
	o0/1ZSgc=; b=aX/6Y4EAuWoY4U1qz8S9ivAuWX+cve5NMsyJq+0pzVWwynePyiQ
	SziDqiygg3J1ODZDj4EdMDj5OUbyBWGejvBMBB9Qc6zbwq5ieTXS3nVcEg42NA2w
	COHqql34MFxgaSSSkXa1rez2OCM0teshCNi1qrjTQAIVHnbPL/8+O/VPebo5Op77
	GwEYzzddQuJ/OnPV47oNbzbhyfbij6gTwUhW4d38MBe6h5qSYajLp7cOsKxFaSG+
	vSjzABae+DBBdlFghdszlQp+3Io92Q4rt0t1nn1cErHPkYwAtiObc4ZHABnY0RvI
	Ikvgs6HNydx1qkdxiKyhWLOAqIVYN7Ll1eA==
X-ME-Sender: <xms:j302aQ49SlGtywbDQRP1O5I1BNa4mNpzC_v8Zdeeq6lXG4KLMrbXbQ>
    <xme:j302aX4y8pTtTr_h9PIgHYIgNsMsXdTsiIBi37NFT7WyN3kNPKO0EmhsQWU_mQLO-
    UvEJgcn7qQwvvxtRd3f2mPoTXr-4aZdZPsveIgrj5LEdMXKbiQi-Q>
X-ME-Received: <xmr:j302adGp7QhR_O-R02aKLmsJtkSv-vX5BUeemevFf0vyiHVO-miVzLj1cfXoMJSOEC8SoN6pou1UFgY7ylvUz6--KvYi7zYWW8JlhpLb4IY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepgfdtfefhhffftdeuheefleetieevueettefgle
    ejveeuffelkeduvefgueeltdffnecuffhomhgrihhnpehhthhtphdqsggrtghkvghnugdq
    tghonhhtvghnthdqlhgvnhhgthhhrdhshhdphhhtthhpqdgruhhthhdrshhhpdhhthhtph
    dqphhrohighidrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j302aQRdSUbM_CEuu_S1b8IIA5fv8r7h3ESwmUSWApcOqH_TRWn1WQ>
    <xmx:j302aWuwRPgKS1wpJn4o7GmrqZDScpGFhKzAtNYGFfvZzyw-QH199A>
    <xmx:j302afwq-3WaO343mLEER6s7AVvCRPD8wKfvA_XJR9sEn1lwyw-wgQ>
    <xmx:j302aQ5odOi42HkYiDa-JwUqrZBJfBo_2BIAl19bWk4Odoy3dSL7kA>
    <xmx:j302aUTqePszQOtPiIOwscGElrwNpsta-VVCRu0ReV-XE_fuw32FLuzv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 02:26:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5665a8ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 07:26:04 +0000 (UTC)
Date: Mon, 8 Dec 2025 08:26:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: plug protocol capability leak
Message-ID: <aTZ9iMPKLAfd-GSt@pks.im>
References: <xmqqfr9mnbu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr9mnbu9.fsf@gitster.g>

On Sun, Dec 07, 2025 at 01:40:46PM +0900, Junio C Hamano wrote:
> When pushing to a set of remotes using a nickname for the group, the
> client initializes the connection to each remote, talks to the
> remote and reads and parses capabilities line, and holds the
> capabilities in a file-scope static variable server_capabilities_v1.
> 
> There are a few other such file-scope static variables, and these
> connections cannot be parallelized until they are refactored to a
> structure that keeps track of active connections.
> 
> Which is *not* the theme of this patch ;-)
> 
> For a single connection, the server_capabilities_v1 variable is
> initialized to NULL (at the program initialization), populated when
> we talk to the other side, used to look up capabilities of the other
> sdie possible multiple times, and the memory is held by the variable

s/sdie/side/

> diff --git a/connect.c b/connect.c
> index 8352b71faf..c6f76e3082 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -240,6 +240,8 @@ static void process_capabilities(struct packet_reader *reader, size_t *linelen)
>  	size_t nul_location = strlen(line);
>  	if (nul_location == *linelen)
>  		return;
> +
> +	free(server_capabilities_v1);
>  	server_capabilities_v1 = xstrdup(line + nul_location + 1);
>  	*linelen = nul_location;

This looks obviously correct.

> diff --git a/t/meson.build b/t/meson.build
> index d3d0be2822..459c52a489 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -690,6 +690,7 @@ integration_tests = [
>    't5562-http-backend-content-length.sh',
>    't5563-simple-http-auth.sh',
>    't5564-http-proxy.sh',
> +  't5565-push-multiple.sh',
>    't5570-git-daemon.sh',
>    't5571-pre-push-hook.sh',
>    't5572-pull-submodule.sh',
> diff --git a/t/t5565-push-multiple.sh b/t/t5565-push-multiple.sh
> new file mode 100755
> index 0000000000..7e93668566
> --- /dev/null
> +++ b/t/t5565-push-multiple.sh

Nit: we have several tests in t5505 that are related to push groups, so
we might want to add this new test over there. I don't care too much
though, so please feel free to ignore this nit.

Thanks!

Patrick
