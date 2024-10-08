Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A81DED5B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391060; cv=none; b=bwGFci23vPHR3R5OCGnJA69n1ZBdrE5XMNXgpCTbY7mHcMVclybbi0Gpnwa52nxB32ZteyRPFbGHF9xWJaKkp8Hp07Uwpd00QvUS8GE+ilhsDzwZxjSEsfVsfDfrBJvvanSI0A/blfPHDZ+HG6K34z7y8dSqmYYKJDv/50LIh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391060; c=relaxed/simple;
	bh=qWRCEa5OyiQ7k+GJTHSqjHCMOYfaD4PTzpjypgljIOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSv8AnUs7EuNtBxbt4raHLrjUs4Efh3Y/rRF0D9k7wh1BTVRZVUNVvH69IBvHxZnsay6iKwiqbmsk4pP6tquSfwdLWSqmk9RQY7Ib9L6AcCOfchOr8WzdLkk9Lb5PGe0OzPir1OhYlLNHBcaHGJWHUC5TQaHYM8ebvSSPIl7mSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VJVoOwdG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3MWNM+l; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VJVoOwdG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3MWNM+l"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B31E81380667;
	Tue,  8 Oct 2024 08:37:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 08 Oct 2024 08:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728391057; x=1728477457; bh=eL7AvfThzA
	Iy539pZh4kmsaiyzl0Td9CZSxI8wJ3Il0=; b=VJVoOwdGIpNec6v0Y0+DHB7koF
	s98DQns3ckbVnMSWVPCoAegiSO0i+kmVjLPuw84a8RsqyESmkwtFudBy4jtjQpo2
	VXqxFqcm0zIF4KazEzR2lzNBKF+JdDp9ff+DUznSa/x7e5OYfVGxJWuEvUcTdGxs
	Kwjgkujwga6Oh9oahhMBZNuWQSt1KuqGjD3Gllat0nSZgNhiLNnhpZ706Jn0vViV
	FktKNOVX8MykEaOQKOEzrnXpvRxYYUYwQYYOQUFyrA6nRIAedBsgSWszLeuKJLMH
	9VASV3rFfDEfE4+SrZGjsopxTnMdlrvxyh5SIFH23qDuYsSzkwm1MIS6Xglg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728391057; x=1728477457; bh=eL7AvfThzAIy539pZh4kmsaiyzl0
	Td9CZSxI8wJ3Il0=; b=K3MWNM+lzgYUKm3A0vEqiXhKwH4PW43mJN5nM5MwG2Vt
	NI3A0yo7RCys8iWqcSjkjijo+oZqn4ZX6Mp4rSCORF9VBx5AqFBjJMf9hPFWyvik
	o38+60WrdnR/jtmaK28bem2tsnSw7Bt8oIfjhrpwz6K9+2vxqJpaepPxC5sp1DNb
	LUTqvB4TtFWpKqVRpS2wlJly+1yPbSMsE/lKtxQcEsWrTlqzDsmc7W1kNNl5GvAM
	dL+jfyoGIx5tmxHjs5lp3ldjCxtlfdDuz2678pG/N9qwdioxJOXhlO18LQohdXDh
	hDvnJ9kXPckhg40QuEqxKHHUpUnDwko47c6Crm3EFw==
X-ME-Sender: <xms:kScFZ7OsYeCGAD_nQDsGvZHwlvE0QQtaayWpeUAoxEC-NFewdYezdw>
    <xme:kScFZ192uQG6z7qpQd7dDVsuVrK3Qavjvbyhesl9E-NgMZbE4PJxdek00vjIhS5Jr
    Av_5XeOJk5_XkRafw>
X-ME-Received: <xmr:kScFZ6QYRdU0q7HaG9P7iKnGBre0U0gelEoMy940Q2ZQ2MVaSr6jKeM9hvHaQKhFv_G_1o5m1-xfQzJdKz8pFAQWxt82Z-0U1zsWXt6fxCngXBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhoshhhihhhvghinhhrihgthhhssehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kScFZ_tBoha6WGuFuEdLgp7w3MCqhRJGuimE6G1o4aZ_yJGnCuaPYg>
    <xmx:kScFZzdeBSTYhdLmP8smA08vT3g8Z9JuhuNKAZfbSGlij8Rj52YqUw>
    <xmx:kScFZ70jiTZ0844vNS1nmO24oMthkjqw0eaIjrLOpES4VIdQyOQ6pQ>
    <xmx:kScFZ_-WWbnoOH5Asv8FB5j1wHpheKR-Llpr1sxI3DCezK0S8Edz6A>
    <xmx:kScFZ0pb831hn3cxf1GzvMtUJ_KEKR8jtCZ6hPtmCF5h-mdZRn4xk_8M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 08:37:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d1231e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 12:36:34 +0000 (UTC)
Date: Tue, 8 Oct 2024 14:37:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Heinrichs <joshiheinrichs@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-config.1: remove value from positional args in
 unset usage
Message-ID: <ZwUnhPbpwtA1MM34@pks.im>
References: <20241008040749.69801-1-joshiheinrichs@gmail.com>
 <20241008040749.69801-2-joshiheinrichs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008040749.69801-2-joshiheinrichs@gmail.com>

On Mon, Oct 07, 2024 at 10:07:49PM -0600, Josh Heinrichs wrote:
> A single positional argument appears to be enforcecd at
> builtin/config.c:993. Values need to be provided via --value.

Good catch!

Two comments regarding the commit message:

  - You are missing the Signed-off-by tag.

  - Our commit messages are typically structured such that they first
    give an observation of the issue and why it is an issue, followed by
    a proposed solution and imperative instructions for the code to
    become so.

So something like the following:

  The synopsis for the `git config unset` command mentions two
  positional arguments `<name>` and `<value>`. While the first
  positional argument is indeed correct, the second one is not. Instead,
  users are expected to pass in the value via the `--value=<value>`
  option.

  Remove the positional argument. The `--value=<value>` option is
  already documented correctly, so this is all we need to do to fix up
  the documentation.

Other than that the change looks good to me, thanks!

Patrick
