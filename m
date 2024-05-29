Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8715B99C
	for <git@vger.kernel.org>; Wed, 29 May 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961936; cv=none; b=ptGHid1WVnfo1gnkMpf8/A/uXgkI/LVYRUw8LYhiZb0PU/jGXhcU7PD/PnN1IlUvE43SFVzXT9MyOIuzyhXS3lHpyJhByRA8PW9zRXr7hZNmeVVZIw8A8NHBFpzGLoDcDv9/YLrjvFUhuUEVw1PMbTpy4iK21/iHFbvZmoiMcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961936; c=relaxed/simple;
	bh=E/GGWQU+j/Tc1Q2gKvmWk67rrMTRMYAA+e/btZpOTFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLv6X2deHvF7iIQqeN+AN2Y3RcWEeoIBYCCTyB/ukl2snHk+68tf/uOUwjHN7FV39JtGd3qE8u2kkZ2JlkFnIhhioKbtgwtgZMh1yRh3W9O2VMq8q/6iWAiDy+B2eUBzOFj2YDExRhaqHxrq4x7Ar97Z7F7VEz6exWZcp4/l7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p1PZk4b0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGpe/CQh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p1PZk4b0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGpe/CQh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E65B611400B7;
	Wed, 29 May 2024 01:52:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 01:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716961933; x=1717048333; bh=f3QBYRbE82
	UCWophT8UhflYzL2onbp4Auf3q1cSJ+JM=; b=p1PZk4b0lBUdnZXe1ijsrvjBiN
	iuzwFqWJRDXWMq8Nk3zilMquXucIpdS/DPEhk9Bs37o19vq0JpeJxrXkgApUlEaF
	EFkCgIKaL14esVcg8S3RojVe5QJFxgMIvWnOp6iImo9afaU3FCJ+nMY67XQoGmlc
	Y2N4b6P8iv5k0luTZiwpquqBOnxh+uDSQaPOMBCGbytyBDLJ1zzAk+gT5WkuC6NI
	Xj+Zv8PrNbGFfH21zh6LvRXUbNSspKQCGhbnd3np/mMhKSgJnxxYgF65CwkLv8x0
	xF+sbJVrNVBYwticwsmsF5Con4QRkFk3tujrRNYr3IhKVjls8GQ8WmVq726Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716961933; x=1717048333; bh=f3QBYRbE82UCWophT8UhflYzL2on
	bp4Auf3q1cSJ+JM=; b=IGpe/CQhHL9goDAUS9Et7Qwx30XLMq49C/4GOmww0D6W
	wSViAb0leD4E8w0dIsvCSZCgcvhl04g0KopsthAAtcqHG8r6zjTLsfPLkTg2tiu3
	ltwm0ugzUqVeZC7QU9rnH40s5lZAqzYjz3vok+aMYHhqbg0C+UpJeZjV9YttHRWE
	vVCU4ZPcYiEX92ZL6Ibk+fLiarRTr3g8hys9p2vISxC0VhNqVO0V5FZRXvf5pY/B
	al5WEnjhCbNboXXidzj0aKy64s1F9MsWRKbOj4jgvpQ1jfBz66p5Zi8Pn2XV2TEb
	mjvfHhPvSo7zOlEcWBObu05hm/EskwUo12D0ViEGzQ==
X-ME-Sender: <xms:jcJWZvvdMcfzoXYHD8Ss5-Lq3fCIkP8axjWXSmKSvJKpLrlyfaTN6w>
    <xme:jcJWZgciBTMRBzT8GlOTw9WHJoD_edMvDVJX9dlhbgsEegDkwLNIhnW-gSryXQC5e
    a7jzmvQNpwofp7a5A>
X-ME-Received: <xmr:jcJWZiwflr2TSEOQfBSF8KSr-Vu8a4OHwk6pLczpJ9fMs5HhST8pOVnHI6FrkXJAdSWgZmFqyMkp-XNLQsupWCAlpyTJekOxv0uTz3YWbu2Q8htN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jcJWZuM5YMLwGg9H37_Tkj3w28XN5j7L4smhd7RwGbsL1LwcWHhIQg>
    <xmx:jcJWZv9bgqq5v7kvoUPomtXoSDuAIICSni1WuldtoS8zZnPtMXNvxQ>
    <xmx:jcJWZuXhIirqQw5ol9fzhaGkTP4XH5XGIRbX9fy6nMIHcMUIyoBUvQ>
    <xmx:jcJWZgd-h49Wt9kMj-0u3sMzo24yUnoJ6NlHC46EGusxuFMCAtGehg>
    <xmx:jcJWZvy3jlgEwpPMZNzRijtYxGCYgROAQVS7WlaQjT4J78iXD1vYAPiM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 01:52:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e38e584d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 05:51:57 +0000 (UTC)
Date: Wed, 29 May 2024 07:52:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration logic
Message-ID: <ZlbCiVsIwmqEFESo@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
 <ZlXIBrs5Q91r_-qU@tanuki>
 <xmqqikyx6ew9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NwvPaGp+k4g3ltFT"
Content-Disposition: inline
In-Reply-To: <xmqqikyx6ew9.fsf@gitster.g>


--NwvPaGp+k4g3ltFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:10:46AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> +int fetch_pack_fsck_objects(void)
> >> +{
> >> +	fetch_pack_setup();
> >> +
> >> +	return fetch_fsck_objects >=3D 0
> >> +	       ? fetch_fsck_objects
> >> +	       : transfer_fsck_objects >=3D 0
> >> +	       ? transfer_fsck_objects
> >> +	       : 0;
> >> +}
> >
> > ... can we maybe rewrite it to something more customary here? The
> > following is way easier to read, at least for me.
> >
> > 	int fetch_pack_fsck_objects(void)
> > 	{
> > 		fetch_pack_setup();
> > 		if (fetch_fsck_objects >=3D 0 ||
> > 		    transfer_fsck_objects >=3D 0)
> > 			return 1;
> > 		return 0;
> > 	}
>=20
> But do they mean the same thing?  In a repository where
>=20
>     [fetch] fsckobjects =3D no
>=20
> is set, no matter what transfer.fsckobjects says (or left unspecified),
> we want to return "no, we are not doing fsck".

Oh, of course they don't. This here would be a faithful conversion:

	int fetch_pack_fsck_objects(void)
	{
		fetch_pack_setup();
		if (fetch_fsck_objects >=3D 0)
			return fetch_fsck_objects;
		if (transfer_fsck_objects >=3D 0)
			return transfer_fsck_objects;
		return 0;
	}

Still easier to read in my opinion.

Patrick

--NwvPaGp+k4g3ltFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWwogACgkQVbJhu7ck
PpRzRQ/+N6nzLYsYLIwBzwnH98bXMTn5SYD6AxJ5z9YQ95ygrLumNsxuJS9RC2Se
1lcQPZdus+dhk1oB+aX6kqeR7+3sGFgMfltI9vmeoTnlItGeqUIWR87di4DSQyI2
psqD9G+2aZORlRt9F24cAAuBG9NomnR/PWzxPMhLdBzEU/NUTw/lExR+QtCLjdB7
pdKceaZE6rW3gn7ItPVvaG5LCnV9CoMdoB0oEgqfGtzORZRh6t1AUVgBptnaP+OA
mRUWMlSx1AxjJKV9lCIvwfHmeo8spVhHRP6KA84a6YIg08kcUROSTAi97hM5jkKQ
063rvtkYkP35mh+2qJxKsl0j4FIcYYgvKCLQ6P+FxffTDLWjRlOmzfWBzCRPK2qr
qUw4YEw436VPVpwajb5n2Xzmiwc8ggbtNx7cw9MMUIbr1yB3/WNagc1qIzNiPHjZ
Yxea1B/aymKQYbqQ70UJx7gjQCRGPifKBlFsv6D5DQZ2HuIMUhVvD7SqRYzPpWHQ
B+Is/tgGyYeXg+80qUvFJoYPkL5gjVeNKKY9T3NlW9tvg70T0dQ6pL8ZVPmORH98
reioXa+teEwhW6wfW+q1IRQCk7Z4i33x2k7ikdro4PjcUgBlQQ2tolTjOcPkNa8d
wSXzZEf5WFQx6DqLF8vCWsDkNRTW+ywlLYedu/SpDUEoLbZBN9E=
=UueM
-----END PGP SIGNATURE-----

--NwvPaGp+k4g3ltFT--
