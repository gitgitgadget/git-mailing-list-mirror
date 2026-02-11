Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42C3358B8
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812001; cv=none; b=oGrZ1oUBYEeN7hf/gutF91UL3lKOaccikJsPqJY3ZjKV5JGQ3mBoXW+lJ+0jdEsBckeOx4NUbfpHttG3dZDTjgmL6/9OGzIIvHFT3TX+C57TQ+SNgmwXejIUo0TSvw5uy/kdpn6Zcq0yUHy+RFrdR1ZAmjSDdImNpGJJS3h6/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812001; c=relaxed/simple;
	bh=tIEm6dHmzTZGNCJqOpV1XzRMKXf3uKEh0cOLpc0zH8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsREAkNQ4HkB9y/CVBtlCNxOD17o82EWYkjjbaTgeELmpYFdEH0GdU1QT+i9DIKSGyDA/UJrBN8eJTrUqTuuzZrjWls/SmirDoM7Hr5XbfpKZYZRsq+T4m/llksjjf0hyfXAQaWXlzYft0+bVEOd2KdOmDyq5APHpyeJoWIBkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1xzk2I2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=us0PGLiP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1xzk2I2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="us0PGLiP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D17C71D0009A;
	Wed, 11 Feb 2026 07:13:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 07:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770811997; x=1770898397; bh=tIEm6dHmzT
	ZGNCJqOpV1XzRMKXf3uKEh0cOLpc0zH8g=; b=Y1xzk2I2bhq3He6GPHHc6gp5St
	Gsg1W278BCF9+XmITKfFnEHM9H8yYaEcOVYkKxBa2vZpdG1x23TvJ3okLdCjP9nT
	yAtgT63lWFDgBnPUvC2ZV6vV9q+h3YFZviIbdG7F0s0sfyL6TqilxtMseYqcqKjJ
	QD8BViDMwUzQdjvNbwzOBkWdiYRsPoV3VnPwZrt5CoWFYHqsFFp4FbnaaMrsMpH6
	xU11JCIrDvB2vGnR7bVdG27Nj0hcYUv9s6Oe7S4fM2zlyyZTNd2QlXE3mCNZcm6J
	Are8jyIo1Oz0YeByB4VSRTcXFd4ov6mDtiri8/X/8YuoBkk0k1iyx72AqowQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770811997; x=1770898397; bh=tIEm6dHmzTZGNCJqOpV1XzRMKXf3uKEh0cO
	Lpc0zH8g=; b=us0PGLiPGfgFxEMgQGJs/8AT1mC1byUEYrQxRJjwpskC1sBpDyP
	kYyVr/4c25BPfp6tiRKpT+EG+osUVmxKJnfLteuKqqEfK5qq+9swBwhVDJXYFAlC
	ZSbA5V3iUNosaj50J+jQb60kNdGqDBSs3O4c0HlhdMc6MK/udHZmyUJXM6Y102OF
	91hXPyjiB+n7w62jI3NVz3SjqxtTVKducHZL1vzOlF8bJ0mVVKou2YXATyTIicwf
	AiRjYAmp8G20J80nuG8RdjkTHXLKvl5sHKi9UzAyItlNHx+dOBPkd1tXrKvTBx4E
	m+6swP0BSxGU/5+rJgqz4NPS8lH1ENPGm0g==
X-ME-Sender: <xms:XXKMaUrL7jsSmUw-lf4Oo-_6IuDYY938arsF_6ssRtMlXFQEBw3tfw>
    <xme:XXKMaZsF8jG3of7lktvLYJR1B2lo9dKJJEWleY2FpiKEIJgTiCzGs0vGJSiqd2jZU
    F8BiPN92iM50dKg6CrV4wSt19ah64kVCmsO1FQ5-6-nRlSE2dNz>
X-ME-Received: <xmr:XXKMafZiht357mxYyZH-OUZhdCD3XOTZo6aUrS72PX2XD6GInUldQQICU3ij9AqKj-rFfyMnyLZ71FXdykJwMQVYu8E4_78D-g1ch0oYAfaH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XXKMaYZE0hIDJKfAN1mJOiilwXjAnDI26wmH7nhNYJDDtYwZzg634Q>
    <xmx:XXKMaYkf3nT1egYowmZv9-BNSHX6Lmo2KP4XkP5CsTa_z6JgxCOPuw>
    <xmx:XXKMaT2B7BNAeN7Fp7bgFcq7bxO6bCuzN8Yq9v6nPWKdd23SSCgz5Q>
    <xmx:XXKMaY0lz4SXm2ctvGu4SDvEXivRM2u4cKZOcFBJke21DcDMRdkZWg>
    <xmx:XXKMaXiOd1pEAFnd8_FHFAiFEQRODhPF0l8TjDqszPMrlD1kEv_xd-rg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 07:13:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd0ddd49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 12:13:14 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:13:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/5] [RFC] Make 'git config list --type=' parse and
 filter types
Message-ID: <aYxyV1P4QUPmBzeZ@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>

On Tue, Feb 10, 2026 at 04:42:54AM +0000, Derrick Stolee via GitGitGadget wrote:
> This is marked as an RFC because I need to add some more tests and because
> this is a behavior change! If there are any tools currently passing the
> --type=<X> argument to git config list then they will have a change of
> behavior with this series. It's an easy workaround: drop the --type argument
> or add --no-type to go back to the previous behavior.

I think this is not a huge problem. It simply reads like a bug to me
that the command accepts the option, but doesn't honor it. Sure, it can
lead to different behaviour, but I think that's acceptable.

Patrick
