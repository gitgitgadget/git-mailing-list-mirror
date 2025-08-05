Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F72737FA
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398236; cv=none; b=HmZdJYqpwZPoifoPVqQAkmPMEX40NZRfnMSIW+tw+G/6FqnkJDw3KEkK/LSrtP+Ke8n7CiI+hAqDZiHymLAHXatk/Mnyy7xeYtof0AEoCEoX77dmCnbq9biczhFkGtT19lA3+A6oUjeOLGR1nABe7kfKAL4SAkcN5+/yB7j0zgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398236; c=relaxed/simple;
	bh=JKvCYwobUHlvbt9phJjvlKWeFS/JovvLW2xSFqqWN54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT5CTxIO4OWWHHD+tJO9FZX0tm7lsAWMofk8miauZUNYTGAioNeK68AKY+YxgzqD6offUO0YBfJQmNFhAP6Jiv3b3IRStlhWC/7SvXbjvyH5QvyNHlkOh5etSGhy9H+Wqa1ISCeoIQ/Uyn6DYq7rkqeS2hZi/CJA5PuZXSNL5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cWCyLhfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtyJV8ch; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cWCyLhfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtyJV8ch"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D18FEEC01FB;
	Tue,  5 Aug 2025 08:50:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 05 Aug 2025 08:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754398233; x=1754484633; bh=9WKY+Pqt5A
	le5jVzWxLvdcVGqx5kdvIdXh0i1LUz6lY=; b=cWCyLhfrO6sBTLBK2Z/Is4z9Yc
	1ZM4O1z9ZnwN5r7a6VtPmeLZceolszhUzg8Lh4WS8FDv/dM2DwWaMXDvm6uhIf8G
	xEwSRmxE3HxVlMui5rrnib+4Ech/H/jaP+qUfhVZVdizNI8Io0zvC2I+SrFBPZEg
	iEYUUTQM3DKRWWt/0nFJrR6dcZ0indAiGO1EK8HukLgEY+lAOFHTqJ6RvjXiPKLO
	lfLTFJMrVIioV8zhBxqijxt+DEFV0qnBGjBm8tzuRqpPprV3Qn8HL8WJR+bZrlXw
	9gDHqQiPDRoVV5z5dMKfE88BPvH15YO8VDnoWceJmiBPa8ESwq7yOB1h68Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754398233; x=1754484633; bh=9WKY+Pqt5Ale5jVzWxLvdcVGqx5kdvIdXh0
	i1LUz6lY=; b=EtyJV8chSae6jNLHSIBbIKvZ0QnEo5F5GtrVTDUhkBnaG9zlqmg
	XY+lBusrUkh2bGkg25h2l51uQ8k79+FzUWeo0lPr0LVvALT9vF9EWQAmoBc0iMNS
	oWWd+jp+mnqL0dN+ghp6kOonF4EwN/Jg+xbE82y5dXhn3f84u4i14OzU0uTsKqpU
	8d/El6yR6sRYqdXcsevxeBS5HTY4g+zOtbaMNAFVzcNPYO3hacqsRAdSeTprqfDZ
	Er2e8DzXJMgzFOnc4q2nLDoI0CUEwGkhSWGyXgBzkU0BUp3hJvi3YesTUSQYt/aW
	9LSzPkpKoapOQT+XzX1Aw2yCKJPHkJMg5ng==
X-ME-Sender: <xms:Gf6RaO2NClh_MaR_40aboz9qgKhJMOJWbb4RA7RuF9otFU65bdXfxQ>
    <xme:Gf6RaOczm7AWTRN3hhZfxvCmZcA7HgOefIBwbJdscQYlYOUeGH0yqm6eI_RbyIaqp
    KP5jVVLePu3UQrF2A>
X-ME-Received: <xmr:Gf6RaOMaraa_Sxi16yuGqcXmFXwZEsDUttUYG7NSPz2zkK3nhF3-ASrYVZjGuKwKz1dTXiUEW4rsoxVA87txXbMQrAoODa77UAT8oOg7eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhi
    rhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrg
    hgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:Gf6RaKXN4LSrfZWaKa2rKMXQltP2J4xQ9wISJPRQhDYOwECqGjElcw>
    <xmx:Gf6RaOzdB2mDllRRKX197_pGIVFGkbYojl1OlCGEGMr8zalwhacDzQ>
    <xmx:Gf6RaJ9HxpCmM2POnNpUGdsadkdad6WIv1MG7zQ-L6VaiXEUC6sODA>
    <xmx:Gf6RaL_e0RNOEe8Qf8BlOe8z6TnTjdYSx0IKJ0-qHZU9xSbWzVS4tQ>
    <xmx:Gf6RaFGPiJkrvjsilWLpoLQtFEj_vfvAFAMCTNcmFX0H-DHABXSwg4pb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 08:50:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1fe91425 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 12:50:31 +0000 (UTC)
Date: Tue, 5 Aug 2025 14:50:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v7 4/5] repo: add the field layout.shallow
Message-ID: <aJH-FNHi5zaogs_k@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-5-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801131111.8115-5-lucasseikioshiro@gmail.com>

On Fri, Aug 01, 2025 at 10:11:09AM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 2d51bfa195..56c3a4027f 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 6c555e90c3..6706cb4c44 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -68,4 +78,5 @@ test_expect_success 'output is returned correctly when two keys are requested' '
>  	git init --ref-format=files two-keys &&
>  	git -C two-keys repo info layout.bare references.format
>  '
> +
>  test_done

Ah, you add the newline back in over here. You should move this fix into
the preceding commit.

Patrick
