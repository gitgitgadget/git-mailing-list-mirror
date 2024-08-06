Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B3F4FA
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929571; cv=none; b=ATP1VrPfFucMJRRjeG9qQ8L0zS9mSHaVdP86OoCb/YcsjogVIBBN9dYldXMoPIRrMoAGUOpj028KKqBW7wwl05v4zM3/5yy+E0icDYmIoZkkJAy5CGn2EzCrYKejCSrgY/8gpveN8G1lSJXOqIw2GNgZvgqlHGr4fWLCLYi1Zp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929571; c=relaxed/simple;
	bh=CHMhmjdtQ9I6Gn6uTfQoLu4fTQ3IvsotyxB3sU+/MfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDMZU1ETXMBeUMiILxUBZpej/fK1qBhSOV7h90KyCocsV4GANFewiJsYposSo3zkgJojEFJfFlA+6Oen/47ZBrSYctNODEZkqxg2QChirKxsddVK67T+jmFsa8kH9oY7T67HF+xR5qgIIl7899pA265fH9hS0gTuuxmz8o6WL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NaD9WIIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJroPItK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NaD9WIIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJroPItK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 74E31138FC1D;
	Tue,  6 Aug 2024 03:32:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Aug 2024 03:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722929568; x=1723015968; bh=75BrE4C3Zv
	aCNpaIr28SDD5cWSjemo7werTwrp4wCUY=; b=NaD9WIIEc3kYOC4mzSgBhkywlK
	8DrHnBD75wZs7u22fNj/TZiwFUN0eYCfRM7jZcllzOPH4/uoG1+okHvXJI7vclcf
	zniXvE6TH8T1XLXtwESVZz5VMl/kd17Rm7QSH+lzQnby+wA0K42M/6JE3melKXKg
	F4VnuFk29Ons7qpeWkyAzPFVDVxun44P7T0VB0C98qr9OjaBs4M53Y0BQkuLovtJ
	zhxxR5why44c1u1kPRMHKsD1vKvCrEiJaM7TjN4THFwT/bAw0MVnujFmxPBAjqXk
	9mVHqmf9JDZHKUzVxMswKecqAzTWW59TkF44+EUH1APJaxbElMLdortabrZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722929568; x=1723015968; bh=75BrE4C3ZvaCNpaIr28SDD5cWSje
	mo7werTwrp4wCUY=; b=rJroPItKgmo7ZskBszza8KmfLa2JkrMhqTCH/jHT48MA
	9/fYBLRtR6I+BFxHQu92239N/sR8FZ2Csf9mmkE5Spi2L7KJnJFX+GX3PL6+fvhU
	690qV1xdQmmsrsUL5J2KIuHyM4oICRNSxi/FXmRkEXCRW8THOqiWnSq+3EBklRkQ
	6L6wer6SGfHgapluaNWOJ+5blbEZBla2yIbOzLG+xxBFFPK9SUUxjNIPiWqa6MwD
	ahFu3we5iiJ22ZiN/BN3mKxxiKIqTJRzKOuSAoF3MbiG392OUqAXQq9KD1fLxbHp
	pA5iKTIfZbQp7uZoj1q6QTc54+ke+pQjWqCWGfSrYg==
X-ME-Sender: <xms:oNGxZtzmnOOT-h9_w-GRD4KglecaPpAdeBJkA-LmE-uQCBr-5mOlOQ>
    <xme:oNGxZtQP_sMoHxkf0wAjRqx0mU5IfDrKMNteJC1weZuoiL7Juz9Y0eARIye-tdYtP
    qGxi681okGQiL0sCA>
X-ME-Received: <xmr:oNGxZnWNNRw06FRsoAxBYCdb244hPaR7c4Yh57OTkNpROM4Re1V4qhDXNGPvnNJMcVCG4RZEMTMAFCi1PcziXRYrHmQMEQ1JFZuEJIwmePNB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:oNGxZvjEo0LPO6OOSsOGg19jKHjn-mL6Jg-P4kDkhjvz4nOyMBuavA>
    <xmx:oNGxZvBxlWP0XB22IGoyewyZBDIEZXKa1fn6K51Wu_uteV5Rd9h1qQ>
    <xmx:oNGxZoK_JVXRVvPsLgyiq6ImeG5zUbsyN50uIPz4M5WARaNC2fypAw>
    <xmx:oNGxZuDnluW3PBo1oFA_JjBzeH60911jofeu98vqY8fUBYt2A0oeOA>
    <xmx:oNGxZh27wcurGD1Bt6au3vtGcXf7oD9iYnJ79hiWo7lpae7TM5i_eAK_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 03:32:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a21e59d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 07:32:43 +0000 (UTC)
Date: Tue, 6 Aug 2024 09:32:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 0/9] ref consistency check infra setup
Message-ID: <ZrHRm-qaZu6BKPoZ@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76UC4M+OFYEfupUt"
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>


--76UC4M+OFYEfupUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 12:43:22AM +0800, shejialuo wrote:
> Hi All:
>=20
> This version handles the following problems:
>=20
> 1. Patrick advices that I should not use `va_copy` in the changed
> `report` function. Actually this is a mistake, this version avoids
> redundant `ap` copy.
> 2. Patrick advices I should rebase [v14 05/11] into [v14 04/11]. I
> follow this advice in this version.
> 3. Patrick advices that we should put [v14 06/11] before we introduce
> ref-related operations. This version reorders the commit sequence. It's
> a minor change.
> 4. Patrick suggests at current we should not add `git refs verify`
> command into "git-fsck(1)". This is because we should disable this new
> check by default for the users. Many users use "git-fsck(1)" in their dai=
ly
> workflow. We should not be aggressive. However, if we provide this
> mechanism in this series, we will again make more complexity. So this
> version drop patch [v14 09/11]. Also because of dropping, change the
> test file to use "git refs verify" command instead of "git fsck"
> command.
> 5. Patrick suggests that we should use `ends_with` instead of
> `strip_suffix`, fix.
>=20
> There is another important problem this patch solves:
>=20
> At v13, Junio has suggested that the `files_fsck_refs_fn` should be
> adapted to Patrick's change. Actually, I made a bad design before. I
> should always pass the `ref_store` structure. So I change it to
>=20
>   -typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
>   -				  const char *gitdir,
>   +typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>   +				  struct fsck_options *o,
>             const char *refs_check_dir,
>             struct dir_iterator *iter);
>=20
> `gitdir` could be got by using `ref_store` parameter. By using
> `ref_store` parameter, we provide extensibility here. If something else
> change, we merely need to change "files_fsck_refs_fn" prototype.
>=20
> Because I drop one patch and rebase one patch. I provide the `interdiff`
> for reviewers to make the life easier.
>=20
> Due to the deadline of the GSoC, I will speed up the review feedback
> process.

I've got another small set of nits, almost not worth addressing. I was a
bit torn whether to send them or not as the series is in a good shape
already, in my opinion. But let's maybe wait one or two more days for
additional feedback, and then (hopefully) reroll this a final time.

Thanks for all your work!

Patrick

--76UC4M+OFYEfupUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax0ZoACgkQVbJhu7ck
PpQNZA/+KnBj3iwYUIaxBLvU0cFvJXfC68LYEqxMNexvXrX2Obvkah4VeigSwHi7
Tj0gtN+q1oTnvNcuGu67rnYb/BDJDdsuXwkdu3clTW7YuqvCA3+7R4i6x3BG0tFO
HzQwukA8MZtQV09L+Gg88F4J8Uw/qMTg0lH1/+zo7wprzwPUEBhtBEdymk+zAcmK
eB/hP5/gWjx5GGxu7/q8TPMdIanXgb7/VVElm8AmoCf7gcz90Ay6C2zkt+HNb6za
nB3W276v/Mw1cLCV+yfnaaLo6fnbDEq26K6bzjrOctVf1v65CTsKqjRHu9VEt4GQ
CDbCE6iz5vvBJF4PEWNeWlNtxI71WzxIeLsS6EfVzi6me/mc5m2vdXpe+Ed85MFc
exUj0OBeMaShGeNUmZQot/X+l3UZIC/USXFt9LouirbKGXx7e+PZLoWGhCUj/rxq
D2VjD7Ni3Y/MavzUdiu+c+Wk7Yx7E5vm3h8ImN9k6q8+7WC0+5+JCMUfL2d4nugn
uRTU8ke3s9EYCjOEFMlqD6ybnFtNFvFk/3lXscAeca09LItepbDPuhnvEYU7juU8
w/t15aNUQF5f4Ni4fhbQf50pP5d868B1bt4GMCvV0pB6jONr2cwr0g/Z9A6WzWgz
ut8ybjzo5+V1ZIhSwDePm7w9sVBhhjuRH5zZ3JyzAeKrLh2WKoM=
=w4/H
-----END PGP SIGNATURE-----

--76UC4M+OFYEfupUt--
