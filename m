Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630E45023
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609620; cv=none; b=jOeDM6RT8OY9a7hM3Io2HGtqYz+upLnhgm6a/Iu/PNRnn7Ul/Haug1OBwuikQ4Kv+13gCvO9f64Krj+MnCsnHltm/1PlZEBK4D6g2SE2pMlfHyuo1PlO69J9iEx1rXw6lz9cBZa9fQWCl0nsHlV5+2DST721FfE1rk/xjOfH6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609620; c=relaxed/simple;
	bh=EJec1MUH8dmbuzlUibqGfp7upys+8UIg8rVCyUoY9Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKBY37HDqMylhNpK5h79wrK8Q/vghGJCVxeoEot1U8d2BlQVQjbSckjj4SaadKFo8bUSjj1v4DbFm9Unu1ayShFQfATCU52LNq5/TAjkTK/3aLub2CGjvtp7+VJrWWhIw6GwYq3n2Ofl/LhuYCs78BU3Rvomd3CYegb+vzp9kYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ke9ic8mu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uw6tb72J; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ke9ic8mu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uw6tb72J"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2086811402C4;
	Tue, 26 Nov 2024 03:26:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 Nov 2024 03:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732609618; x=1732696018; bh=EJec1MUH8d
	mbuzlUibqGfp7upys+8UIg8rVCyUoY9Ws=; b=Ke9ic8muvEmeY+zpezHTm00cDc
	2+WWu2zWYW91AREXHJeJ4tbfU9QNTm9E1OmLWAKnaOuKI0aC+v7GcBGMZGaKft9f
	8zQ71fCsVdlXWA9qNfNvb8SeghGXFhB2UW34EupX4/4bsMN2ERtDObwBImNm5SKa
	egw9+vlLsXglnpaGd5qltOSG3ALW8Lt8lNu4k0g0dnrfpfXA1iSxxXbuN0XDGw1o
	0RB8xv+RHUcgNBUq56IgmaQ04fzUWOWcAg6UPMDe61eFCOFlAUrC1rs49+dr2g4O
	rIUtH+uZ1gyRjGEqZWyZ98RQyE8w+muCrSRavstEgMQLp524S6dVyvGMaSfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732609618; x=1732696018; bh=EJec1MUH8dmbuzlUibqGfp7upys+8UIg8rV
	CyUoY9Ws=; b=uw6tb72JvWPv6UCaN+pSwtrUHb0eRWjeYMlGVlUlprqE16ENeo4
	DrOFI3DD/Z4Y0b7cnSs6mJMkC2zGjHTsEKjbCvPHtl/j+zK+4/GOicztC6NUIiQY
	4pX2CgasJ+1YhrYR3CQtKiOTADgZGWjpGCty9Y0wG5TQA9r0BM7z+CyvvrVdckRe
	9xCmemAZYl+oeXPtoK7N71bPzPihgll1k4qp83bx8BOOnnS63czU/7qOFG+Wdape
	H9Vpu6u0IYQuvK3vZ4VLNQR46+5GuWk87wbKfKTLf+7K1E6kKcE5gOKIlwBiAGxa
	5/M5Ot6WvVEYDinXuoLJrSuBNYTPatlhyeQ==
X-ME-Sender: <xms:UYZFZ5AuWOjtxSS_35DIu6zX_xTB7bBH3DrhheT8yaBV-53hrgIyAA>
    <xme:UYZFZ3hPFzyIwuUgAypvJC7Bm_HUmqz7XpEM32Zml6ZHKkc8GEj6CH753MnSuJtay
    vd6BS_efY-LXp3pGw>
X-ME-Received: <xmr:UYZFZ0n-UtGS_kZcLCv4jZw_ODPJp7dNZbVc4xyspO6TA9cw7rfTeth50Bq80aTN1kOW2NLZIB933aXHVEjo5F8uzk13WktC2BOXbGjYkWUQsJye>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UYZFZzxH-64etjOQeMu1-vd818V1UJ0kCE0NlMsp7_I3i4sZbbwv7A>
    <xmx:UYZFZ-QAkTJU0qFqPPmjpGE1nYnIZwrgtG_r2twSA2ReRZm-kNqpYw>
    <xmx:UYZFZ2bVoNkSqGNqib5oLSaHU7hEn4d5emQQwIE6lZFK8YHm0pa8iA>
    <xmx:UYZFZ_QR2snoP9-ZdkkqZYOmFvXr38Gcv2PRb_0Vyb6ESKHOMN8P2w>
    <xmx:UoZFZ_-uoEh--HkFwNN8W-9uqWfU6f9HRrIbxLN9wyvnswPTxTcmsbsM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:26:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2d33c98f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 08:25:53 +0000 (UTC)
Date: Tue, 26 Nov 2024 09:26:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/7] p5313: add size comparison test
Message-ID: <Z0WGQw6jSw3uhlh4@pks.im>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:05AM +0000, Derrick Stolee via GitGitGadget wrote:
> These tests demonstrate that it is important to be careful about which
> cases are best for using the --full-name-hash option.

Is it possible to give general guidelines in our documentation that
guides the end user for when to use the option and when not to use it?
And if the answer is yes, is it possible for us to figure out at runtime
what the current scenario is via some heuristics and enable the option
automatically in a subset of cases?

Patrick
