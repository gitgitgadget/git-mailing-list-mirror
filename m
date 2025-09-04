Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5332505A5
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011819; cv=none; b=KpEi2iFZrh1w+HBK2SNFpbbzRWoI7mEUDlTjclYLc/ki6q/PepL791ivDSS3m0MnYwagzEwAcVgX03O/1bSH+MT2xZRHfaej2uXTCezZ6M+iT6ZQ15qLnWTdEXRY01QGL65BX2rVk71zlT+dx0X39pFUC5yEgKllPxgdGfaIMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011819; c=relaxed/simple;
	bh=O+rPJqutO/Dg8XvYO6ZdprEmnLDYAwtwS8HvxuTukRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGLq8W1KmzNCRYcgxAsrZBa4Hi4xkQllZRClJG/eoxcDh+35iqxMfs9GsvNiWZBEQ2Mi/aFHbN/3laRSOIGfYQlMt0bXgaY6cbL8GCmH7PyhhfoiU8RS2oTuhYGGfrf+NlB8MwZQkKKU9qUkf8E2uoc4+HwQmyp+8wHMdaU6UWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hZwJgOLu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlWXDGj0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZwJgOLu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlWXDGj0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F47B1D0045B;
	Thu,  4 Sep 2025 14:50:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 14:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757011816; x=1757098216; bh=kx8Q/6Lv53
	N0MDMK4i1982pmR76n9nQAu4hhmeut40s=; b=hZwJgOLu17XOkjZDrEFBQ4izKA
	jTvnUiJGxjLmWecS3x1TiDAzC57JUrfUZGLW9k2Evaj6yHZEZsw7ATGkRnd+VeTm
	o7nLbZi8j3Y/DIMCPsEN1zj+5yFH9+z/TV6y36QaK8+1rl9hpJPwzjP3ddGF+tgB
	UW29gmzD85NcC4oTnl0GDb46Cb3iWmpiDtZphO82EdbrHjdiZCRdccclX3HSaTfP
	1Ct0zSXiz/gn8e2+0rfG7cv66mpn6KfAu9dLBUdIPA7KhHMOcQitiNMtE3AMulbn
	HdMUmKXAI2OitFZei0G0vlP2PLCoQ5cpAZAXz0mVo5pJyOIODdX2ohoCE8dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757011816; x=1757098216; bh=kx8Q/6Lv53N0MDMK4i1982pmR76n9nQAu4h
	hmeut40s=; b=ZlWXDGj0KVYJYy9YldKEQOwlrp9IkhLP6eSiaJ3OL8JYVByrqPB
	ea0BHS8i5pBykezCR2ONgt4B4vCMdccChvxsmoEe2aKBAJmMOef8xZVZlvwj2qND
	UOL5paZuPl5dgz1k8Ax2Uo0ZUOui/X4/lENNoer4Og+i6akeXjYblP59Xkugb+47
	R7BdXqzJd3xU9gOrz5F6Lpdq8Ecy5/lOzSG9j09w5GGx+3tv/6Nt3Xuk/FyxCJNq
	A97nuKSSOpriNg6+76M5xnump+wGDXyqi72E28fIfFENATHi7yRZnDu+HAzvg+i2
	OYz1E7JupRKqmNQ6/bheYd5st5NbFbOzjEw==
X-ME-Sender: <xms:Z9-5aECpXkgZWtuYSxf_axeCuUliGKCeUkyEgE5-NGcDE-AgdZcT-g>
    <xme:Z9-5aHIAQcTfLY-kxPcl3MlV09Jacp_k-7XQrRZG9kgoSF1MwMbSQB-BLKQvpM8DQ
    c5zQqksv9FBkEX1Nw>
X-ME-Received: <xmr:Z9-5aCtsvZFK0yDJ4qgJSnaixp9tXsariv61NLCbCAdxzWdYvYfuBwVwDCNTiNjiXc7Lb_5KIED-pOOUn0ZNqU1Hd9uJ6AvPBTseK9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhht
    ihhvihhsrdhmvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Z9-5aPW6JFnPzE-QzVYyZPZeu2pf_P0xB2SZ9HjE6z3tl_NHnDS1BA>
    <xmx:Z9-5aNIXK3hM7vble7PTHAj2eIBQVs3mqSQOLmb_7SjUTWRBv6e14A>
    <xmx:Z9-5aE9YqQd1KOUQsXXzjR5p4j05iozsACfxDpG2cMGFM_u1b3vPcA>
    <xmx:Z9-5aLPRyzLOnvaCcs39ss3kbkktJ5kfwsDw8tdRuxTsgo297P9HdQ>
    <xmx:aN-5aNwDYIVqNPJe1bp2HCNKh4sGJM3DxyaNJOFx8RlwkMI-O-6LhxW5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 14:50:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal
 Rust library
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
	(Patrick Steinhardt's message of "Thu, 04 Sep 2025 16:26:43 +0200")
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
Date: Thu, 04 Sep 2025 11:50:14 -0700
Message-ID: <xmqqzfba6oih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Add the infrastructure into Meson to build an internal Rust library.

I am a bit surprised that Meson needs to learn Rust now.  How have
you been dealing with contrib/libgit-{sys,rs}?

> Building the Rust parts of Git are for now entirely optional, as they
> are mostly intended as a test balloon for both Git developers, but also
> for distributors of Git. So for now, they may contain:
>
>   - New features that are not mission critical to Git and that users can
>     easily live without.
>
>   - Alternative implementations of small subsystems.
>
> If these test balloons are successful, we will eventually make Rust a
> mandatory dependency for our build process in Git 3.0.
>
> The availability of a Rust toolchain will be auto-detected by Meson at
> setup time. This behaviour can be tweaked via the `-Drust=` feature
> toggle.
>
> Next to the linkable Rust library, also wire up tests that can be
> executed via `meson test`. This allows us to use the native unit testing
> capabilities of Rust.

OK.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build       | 16 +++++++++++++++-
>  meson_options.txt |  2 ++
>  src/lib.rs        |  0
>  src/meson.build   | 12 ++++++++++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
