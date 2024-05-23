Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92D28EC
	for <git@vger.kernel.org>; Thu, 23 May 2024 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442296; cv=none; b=iDKMQG13sPfBvkY2gtyTG61US5xXDmYfl7G1VwbQLA4g1PfnT7e/hqE5HF5d9Kvz452+LzXNk0vgVxfOeo7ZedEi6tQRSSU54XDpP5yhFD1+AaOtc65RNxt7mESz3S9G1+V1m/qWI5/nd52+dTxjsCeybb9aMscMrHsrNkqy3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442296; c=relaxed/simple;
	bh=yyv6kVmDNwMvdkXXE5lk1/tKBBEW75JVpZ9mMbzj+Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot8V2fYOr82tImJEqknAIRUP7OdKDWPKhBUSl+rJp+MwNMrzdGGhvkV7fvyy7oz8+1AdheqyvfSUygfrZeHkFJVUCjTQpQy3XDEYtwxFkuHT0DaY6jfCH0qCtwywZc9VFNIfPKud12BZfWttkTZr4Qsy5VktUyov+eOLntE1srs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ni7feKms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pXeD8qrt; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ni7feKms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pXeD8qrt"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9AE371C0019F;
	Thu, 23 May 2024 01:31:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 May 2024 01:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716442293; x=1716528693; bh=KPg/FHMzmt
	zoQeKFtJcbFfQ+hjk8qS/qEgaZSAzOcko=; b=Ni7feKmsaqsJBy4y6Lu0eDqDw8
	RxWvyWuXZBHYv0NWuoLvx1r8VEGBw9cpbLc4KUdW1Y9EBBBuWOpAKVJ+AyLu9CrN
	w+Lt0KSfpHNlrhUlMslwQjJVOhG6YMWMnYibHUaiDXc3h0QAmWVp71EqlHYqsJWb
	CdEabaoobuRoYHATlD/OWAbjxiun2e+Czob9hUK0uM8Agxb7QjWXTCahuw1uSPbN
	w+j71L9joLwK7L9JRfX15gcbEQX2Q5GMs7Tbhb+jIgTBzCWVehR7aHHP1kg/1vzV
	h1gsLYLpdxt+QVmShkrnVQ9LAyf+xF42XY1mFyxXMxrSBrKVSAEQCyXducIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716442293; x=1716528693; bh=KPg/FHMzmtzoQeKFtJcbFfQ+hjk8
	qS/qEgaZSAzOcko=; b=pXeD8qrtErxWyiAZX5Sm7/QI7R5nzP/w02MPsDbEeVwy
	j9cDHgURb0BWVswmc8+wFTfoKXlk+idaRrKbDxDlWCyk4g8F3Qp1dt5hv7kGFCdO
	2VjFCwjLIiEQPSQJsyBATQ5MBlhyPITNeOLs8qmb+cDBh3Rop+BY30261Cofdpfc
	t0YLPLBdNYA5QUhGMekvI6/lRT+mKww/JifxR6/E2lmqawag2ykScfY4bs6hCE6l
	RDH/wsNxxORGzjX2oRlEx/5tLUOLXdFIYsihWWvJi4rGQr0wjQOKzg5w5bn8y0zO
	u98aHukTRUzWoujdPec4hQh0LaHbTFIZjmedVMzN2A==
X-ME-Sender: <xms:tNROZjlXMs89tCFsGj9zmBPRuNeEkBhaTNZjlljiRzcwHuzabj7G5w>
    <xme:tNROZm11TpHlxPcPEz_qhp8BNSDQY2ElFGoZ-gPSEjZFXEicvEnSzWiNrfU2AR35a
    3HVwZnB5E3Me0UPtA>
X-ME-Received: <xmr:tNROZppFxBmm6RLQGDqS55ufBNOdJJy_MF_bneo7wBHrQ0C6msazrfXaH8nVODaK_O6yZklJ2GwhfVHe5M-K9AU3NUzKMzQw5Uuat8xWtglfymQS_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:tNROZrlq9Uma666lI2_aPywY-7OAkfWtaEAzfAtl3nPmJNYDtAkePg>
    <xmx:tNROZh1rMAhIPqdNkEQDTAEpId1Cmf8W77W-5vp4kEuRUiUfmwVMbA>
    <xmx:tNROZqtFfGLOR7UA0bqHVPfV78tRrzUiROLWIF3ABdmDY3MDNo_VJw>
    <xmx:tNROZlXdwovLDEMhfkijwfVapApOgbveqjFIsOaU5DGKrtdQFshnyw>
    <xmx:tdROZp8uv1hkxWDHooyxZ2R7g6U9LixyxH92u5cbBikS2oYAZKtP1gXB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 01:31:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 094e6484 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 May 2024 05:31:24 +0000 (UTC)
Date: Thu, 23 May 2024 07:31:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4] add-patch: enforce only one-letter response to prompts
Message-ID: <Zk7UsJjhY_FV2z8C@tanuki>
References: <xmqqr0dvb1sh.fsf_-_@gitster.g>
 <xmqqh6eqiwgf.fsf@gitster.g>
 <xmqqikz56a6o.fsf_-_@gitster.g>
 <xmqqh6ep1pwz.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nY7TXuosn63zAIwC"
Content-Disposition: inline
In-Reply-To: <xmqqh6ep1pwz.fsf_-_@gitster.g>


--nY7TXuosn63zAIwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 02:45:48PM -0700, Junio C Hamano wrote:
> In a "git add -p" session, especially when we are not using the
> single-key mode, we may see 'qa' as a response to a prompt
>=20
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
>=20
> and then just do the 'q' thing (i.e. quit the session), ignoring
> everything other than the first byte.
>=20
> If 'q' and 'a' are next to each other on the user's keyboard, there
> is a plausible chance that we see 'qa' when the user who wanted to
> say 'a' fat-fingered and we ended up doing the 'q' thing instead.
>=20
> As we didn't think of a good reason during the review discussion why
> we want to accept excess letters only to ignore them, it appears to
> be a safe change to simply reject input that is longer than just one
> byte.
>=20
> The two exceptions are the 'g' command that takes a hunk number, and
> the '/' command that takes a regular expression.  They have to be
> accompanied by their operands (this makes me wonder how users who
> set the interactive.singlekey configuration feed these operands---it
> turns out that we notice there is no operand and give them another
> chance to type the operand separately, without using single key
> input this time), so we accept a string that is more than one byte
> long.
>=20
> Keep the "use only the first byte, downcased" behaviour when we ask
> yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
> 'n' are not close to each other.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This version looks good to me, thanks!

> ---
>  * Hopefully the final iteration.  The differences are:
>=20
>    - The end-user facing "here is what is wrong with your input"
>      message is given with err() to be consistent with other such
>      messages.
>=20
>    - I gave up basing this on v2.44.0, as it is a new feature that
>      does not have to be merged down to older maintenance tracks.
>      This is now based on 80dbfac2 (Merge branch
>      'rj/add-p-typo-reaction', 2024-05-08), which is before v2.45.1
>      but has modern enough t3701 and add-patch.c:err() sends its
>      output to the standard output stream.
>=20
>    - The tests for 'g' and '/' to check both the stuck and the split
>      forms have been updated for the more recent prompt that
>      includes 'p'.
>=20
>    - The test for multi-key sequence expects the err() output on the
>      standard output stream.
>=20
>    As an experiment, this message has the range-diff at the end, not
>    before the primary part of the patch text.  I think this format
>    should be easier to read for reviewers.

Huh, interesting. I do like that format better indeed. You did that
manually instead of using `--range-diff`, right?

Patrick

--nY7TXuosn63zAIwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO1K8ACgkQVbJhu7ck
PpSzGRAApp7VoA4a2HupXKfW0pP4g5EeH0+pOQfUEwiF0tYA1JZ3BbOqm56vdyw4
ajq4YRQZNvPDk1L6pAbGhT2VskIavFswuq3DDExhsNKm3lLVv/egpQ9xCgmWJ666
Rh4/WpHkLKwwxGLJxxW+qi8cA737lc+XNeLBNzJkVqeOgY433a3QMPAzhp/RJkDt
n68saZByAJMTIKaH1xkljuGvs7v4Q+DKGj39eS0ShF//gGQTUfkR3crmfQ84ZpF5
k+urE4xJ5FSVG52k1WnPbo4oPIjykUezMjcLKQMkBg0q4PSQjC2SxaQxwj7JyIEX
JNSzgJOXPhxSTXKEQySE9pfPSdUtSfHBDwwwQn5OmJlSwDstF2SXvF074L/ozzVS
bQFSIL/lLyyXxgZg31KFCS1Sd2CoWp6dN9wrvij68wYIQZKckpC+5Kr1LHndFO08
bF5JLXyM7wLJ6IsJJkHU4cSEq1ZVZAsipAWxhAVnlJDuuVwurCLS2eLhPfQBEozD
xoGdTLkSEfIIK6yOEQI2HiX/6a8LiRu7EB+gnI/lvSA3NteDIt/OdnrsS9XlYgh0
fczARY0gxXUfXxKVrJRInXjnramVChicA31ajG1C2iiNTn2bMQFNCRMhp1CJO22E
i8SPJGmAaAU5P/7kn7va4ZvgnZ72vqSbHh5AAbpfvKMdSuXlqm4=
=xpnn
-----END PGP SIGNATURE-----

--nY7TXuosn63zAIwC--
