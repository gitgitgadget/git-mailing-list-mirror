Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E030FC03
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540549; cv=none; b=CDXIVLm2kcy/GRQnrWjp8Y+/iuPWyqRbchuEUDOJ8FRHleUe2Z0k87sr27DDwbc5vI3/4muHbIZRTbVArm88d84WLXLP0M3I4EgTDoqOos1aDWl6gw6K+lL95y3WMvx7tCVhr9OAFuJtN28J5oREb1GqtAkL7oSwInPWBM3fuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540549; c=relaxed/simple;
	bh=8WNEujM+RBPIO4wujmh52M1HVQ5eBqZFHQA0r0MOY/4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fTgzm6wC8kNPUUgUraIX22oNqNgZFqwUkVOt7qP/3ePhneXFxn9tb9xLNcMt3aUVKMNaQUZudMPS2Oa5g49jsCBlxR9jcGYR9FQT3ZXgFFmsUeLLZSXS+QYtv10aULXoJfLPevHkFVsL75ratULuiqgBFkYpQjw5jxTsPSpkLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bgs9qkjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jF4ayjxF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bgs9qkjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jF4ayjxF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 808017A0228;
	Wed, 10 Sep 2025 17:42:26 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 17:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757540546;
	 x=1757626946; bh=bhJhFb6YmlKSG20zBI2C2LV/trDXmUDTUuRScK+55F8=; b=
	bgs9qkjCnU8sLXafnL/xRzgiuJTzbjHDdnxB6hDVs9EFnijK8+i8sP4ulxMN/2EO
	md+QqdWbNrkyYj/N0F6EA6N/FQKI/QNWeNvp6UkdSYgfgTVrrKbPsN8vu2X+5YkC
	aBW/BdDpKXyYUoy4FJKxt1/HzimwZnwiYt7J21EuG7FikZnWWSSFyqBXlJ8h3uFD
	weIsDImyQrWqPY30nxNgK94WvnH0j30iu2ocJ+3IE7O3N50L6RX0Mq7YQYhNNEzW
	J0vUjyvlArSS4rATMnPTK9KZC9aTSLADMVvA7508OadfgixZZQNVTMXhBmh74rrw
	Ffe37aZSlqsNGLvVjFr0Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757540546; x=
	1757626946; bh=bhJhFb6YmlKSG20zBI2C2LV/trDXmUDTUuRScK+55F8=; b=j
	F4ayjxFTOinVGqXpxFatVEkUDRc//WwSi1wNOX+UKAzV5jcAM0OE68S7dDtk0x5Z
	t9PPQxN7im2ipalC1Qm1evEcjfuX1zflrYMJXDoAwRnYEHYqIi7KhmYyLwdn4rZx
	rRcLu/o0b/1ijhQvnEsY+m53QwTK3zZRI4OGogxSvYXCVTLvU88AAu5IVUlMSkvn
	p+iOe2ygYuG+rWRshZfV9lgqyE0F73IflJ6fnubFmOstJnbnmA6f0xzbLg6AdPaU
	96LdE1GWWviXR6hnsFBw8YHZqalXxxRfhTa+wzdM4g8SDV+uLHK9xpvJpY7H6jC6
	0aKHcTdFSFtQdDIG78lQw==
X-ME-Sender: <xms:wfDBaFV3Y5xJpjhgUds7P7qdV56olVARktjXFEQRJ0-LbiTpVzXshGs>
    <xme:wfDBaFlJ4vNyMVQG2_arO9pKNFCyMZr4tgsXMRUz2ryzJeGSWvg91fCuK2Yl0Il-U
    _My6iInfBiPlpMFEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggssedvheeisghithdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgr
    nhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsrghmsehgvghnthhoohdr
    ohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegv
    iigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wfDBaIdsHml8SatYlJipUwiU0jYskMsK3zvuKMQ0MJIz4GvIosOJKA>
    <xmx:wfDBaCGKlFAS4GsXHtIRnp1FkbFYuVc9QzFCYL6XfRCZPjgdBrIqfQ>
    <xmx:wfDBaI7Vd2sZWAjY-1G8dCGVoIjjFUsJuK5GJRhQ5tTyyG5REzv0Yw>
    <xmx:wfDBaFsJHYPnDNny0BL6VWF6jg9bRAfYWIIoCEXIjFwyDXto-rXBIA>
    <xmx:wvDBaM9IGLfGg3aVyAm69qkKtwVpACw-vLqHnrgJqfGwImZbOxph2oLS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E3FD1EA006B; Wed, 10 Sep 2025 17:42:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3EHoYSPFnJR
Date: Wed, 10 Sep 2025 23:42:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Christian Brabandt" <cb@256bit.org>,
 "Collin Funk" <collin.funk1@gmail.com>,
 "Eli Schwartz" <eschwartz@gentoo.org>, "Elijah Newren" <newren@gmail.com>,
 "Ezekiel Newren" <ezekielnewren@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Pierre-Emmanuel Patry" <pierre-emmanuel.patry@embecosm.com>,
 "Sam James" <sam@gentoo.org>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <53a9efd2-52d7-4520-81eb-2129ccfd26d4@app.fastmail.com>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming mandatory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025, at 17:35, Patrick Steinhardt wrote:
> Over the last couple of years the appetite for bringin Rust into the

s/bringin/bringing/

https://lore.kernel.org/git/CAPig+cThyuo7=3DA2f7_XkE_TZmSRc5i=3DEFgZOw_p=
Kgu+Ckgx70w@mail.gmail.com/

>[snip]
> ---
>  Documentation/BreakingChanges.adoc | 36 +++++++++++++++++++++++++++++=
+++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.adoc
> b/Documentation/BreakingChanges.adoc
> index f8d2eba061..3550e9fc27 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,42 @@ A prerequisite for this change is that the
> ecosystem is ready to support the
>  "reftable" format. Most importantly, alternative implementations of
> Git like
>  JGit, libgit2 and Gitoxide need to support it.
>
> +* Git will require Rust as a mandatory part of the build process.
> While Git
> +  already started to adopt Rust in Git 2.52, all parts written in Rust
> are
> +  optional for the time being. This includes:
> ++
> +  ** Subsystems that have an alternative implementation in Rust to te=
st
> +     interoperability between our C and Rust codebase.
> +  ** Newly written features that are not mission critical for a fully
> functional
> +     Git client.
> ++
> +These changes are meant as test balloons to allow distributors of Git
> to prepare
> +for Rust becoming a mandatory part of the build process. There will be
> multiple
> +milestones for the introduction of Rust:
> ++
> +1. Initially, with Git 2.52, support for Rust will be auto-detected by
> Meson and
> +   disabled in our Makefile so that the project can sort out the
> initial
> +   infrastructure.
> +2. In Git 2.53, both build systems will default-enable support for
> Rust.
> +   Consequently, builds will break by default if Rust is not available
> on the
> +   build host. The use of Rust can still be explicitly disabled via
> build
> +   flags.
> +3. In Git 3.0, the build options will be removed and support for Rust
> is
> +   mandatory.
> ++

Some minutiae: the HTML output is like

    3. In Git 3.0, ...

       You can explicitly ...

But it seems from the text that the paragraph after (3) should go back
to the previous level:

    3. In ...

    You ...

You=E2=80=99ll need to put these three list items in an `--` in order to=
 get the
latter.  Or that=E2=80=99s one option (that I tried).

> +You can explicitly ask both Meson and our Makefile-based system to
> enable Rust
> +by saying `meson configure -Drust=3Denabled` and `make
> WITH_RUST=3DYesPlease`,
> +respectively.
>[snip]
