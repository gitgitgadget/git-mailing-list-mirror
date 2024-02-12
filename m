Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178A6FAD
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720712; cv=none; b=fOAb+5KtfGOUakkJFQuFouCadU4PRX9plfkZwT/9wtB+tAnGxJCgnwAQryYVfTE1oK0sDsrIDdsEy/y1xbY+VCDg8+BlSV3v5BLPZ2DZ6P2ehn16foiNINYxwD3VI/K6a1WxWwXyOchNYjmVSQLcWDEiipY760xEanzJmc6MdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720712; c=relaxed/simple;
	bh=1pghuh9/d8Iz8QpETohOdmA92/5DEfN2BD5lBA86t+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyNNXtXYPUhRsnqdst/x7pg2hLmKjegsi1Qziorbw/Bo8sQC7l3T0vV7qpNpNa7Kw+xw/dY2ItkOolbCGu/WL7jnzYtofaGY2msfdc7DlnI3/YKbZxv3btiAdI/da40LcvrPpFPOy/FufLZl+KR36pzbYxDeyGQ7qMMbVRCfN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DnL8+H3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eE0RMBRc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DnL8+H3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eE0RMBRc"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ADB171140087;
	Mon, 12 Feb 2024 01:51:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 12 Feb 2024 01:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707720707; x=1707807107; bh=fQCbIaC02k
	gBb9slCEbh6yIT531SQ+NLNrB4eH/HGzM=; b=DnL8+H3Zy84nT6vRIk47sk78RV
	Cl3gcr6yt5IsC/g9++TjXepwEOzV6v6dP8co1MxjympBXfohMRE21UQOqvRYPRW4
	PWiwrt0e3hI4xQwiEcsmU2X/TCo2oM7nd+X9MLUNK7QCD0AVTZu7Ic3odyL6lJl/
	O3Q+18OcNe6D7eSdjHaGkn+/noujWHWy9CCHXesunFMpEXB4wHQ3AB/hsJgYGUTd
	WAXgm6SL4D97ctTN+7vAUAb9qn1uHsvTOgJfGupsWm64kjypc4Q74t6OnWzEL+UA
	DEQIUteNZaaklMLFMcKRJOxeH3LjxcTqIUj2cMEiCvehArf2I7BcmuQQUWsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707720707; x=1707807107; bh=fQCbIaC02kgBb9slCEbh6yIT531S
	Q+NLNrB4eH/HGzM=; b=eE0RMBRcPy8wXKV0IJYwJZQ3GrX1SmVPEn1AGjEkHp7e
	IZvoVqG5m7kdZVnZ9QzEmO1rzPO8f5QUcJN/0F7KYTQAFxX60go6ZlX3qpusa0LZ
	Yw130bx9fUIGqYTM7LGA7A0D2WliVmDU6YAFjC47R+fRXYIaHVjj8V+qMfFdP+c4
	x97IwO8LLVD/4iwjNanH5B9RuLKviZkTa0Cv5loYIGJDjt0aIuUMD/u7vSTi3vLT
	fhtKGJVQB8BhDHdjmVvMT2sjeX6S8XdWCg8Xbs4P5CcPVumXYw3YUUPCdK6/tidi
	TmfOCQVsyEXmdpX5kKVPg/DUzmz18wofEY3H6+ButQ==
X-ME-Sender: <xms:AsDJZRszNoTJ9lu_liQpjgLHmYVaXB1lad2ADNWUZ41i11bEXALitg>
    <xme:AsDJZacg2MuRFQcKPgBS2ElEaSZcRhcsyVgMjXvFBgL_EodXYUWLpUfLuWWjRAlbc
    5ynxlv7B71oqZAVSA>
X-ME-Received: <xmr:AsDJZUxJsNtgkmgGHV-lTpOZhE6sS02bkljshmVnQGO2nTaU5-odfzLT9ufUlPn_brD76jIAcapZRrxXHPdAkym3RY8CSKdKngY15j2FpZrBoro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:AsDJZYPp3KqfiQxd7hRSv15DSmBui4pVwjkZKKbFNowCVhsRjpZFuQ>
    <xmx:AsDJZR_j4lRdNVetbqbMRYGaJAef7D-ZQt9Zt8jUoTDOA8yYeq_e5w>
    <xmx:AsDJZYUqI8CHCzVxpFMVbJs16-EILzuEHWXTzvcM5nwo52W4yUCSGw>
    <xmx:A8DJZUmTQujaSoU9aChpfIa8IfnXZ5A382PayJxtR208fvNjerQHUA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 01:51:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c2cadc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 06:47:56 +0000 (UTC)
Date: Mon, 12 Feb 2024 07:51:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Message-ID: <Zcm__DROE3hKsfRX@tanuki>
References: <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
 <xmqq1q9ocje3.fsf@gitster.g>
 <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
 <ZcSVx4slikt4xB3D@tanuki>
 <xmqq7cjeq43t.fsf@gitster.g>
 <ZcUOP_rWUwymhe5c@ncase>
 <xmqq34u2onaj.fsf@gitster.g>
 <ZcXddvQzlt6j7T7L@tanuki>
 <xmqq8r3timnr.fsf@gitster.g>
 <CAOLa=ZS3y=K6SCEoC7hZSi7vhAT1-W4fAzPb3rYaBbGcqO5Cyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TlW8wPx5jqF+EdRR"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS3y=K6SCEoC7hZSi7vhAT1-W4fAzPb3rYaBbGcqO5Cyw@mail.gmail.com>


--TlW8wPx5jqF+EdRR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 06:27:39PM +0000, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Patrick Steinhardt <ps@pks.im> writes:
> >> Depending on the answer, I think we can go one of two ways:
> >>
> >>   - Accept the diverging behaviour and add `--include-all-refs`. The
> >>     "files" backend does a best effort and only includes root refs, the
> >>     "reftable" backend lists all refs.
> >>
> >>   - Double down on the fact that refs must either be pseudo refs or
> >>     start with "refs/" and treat any ref that doesn't fit this bill as
> >>     corrupted. The consequence here would be that we instead go with
> >>     `--include-root-refs` that can be implemented the same for both
> >>     backends. In addition, we add checks to git-fsck(1) to surface and
> >>     flag refs with bogus names for the "reftable" backend.
> >>
> >> While I seem to have convinced you that `--include-all-refs` might not
> >> be a bad idea after all, you have convinced me by now that the second
> >> option would be preferable. I'd be okay with either of these options as
> >> both of them address the issue at hand.
> >
> > For now my tentative preference is the latter.  If ref/head/foo is
> > an end-user mistake with one backend, it is cleaner if it is
> > considered a mistake with other backends.
> >
> > Doesn't our ref enumeration/iteration API have "include broken ones
> > as well" bit?  I wonder if this issue becomes easier to solve by
> > (re|ab)using that bit.
>=20
> I'll then go ahead with point 2 then.
>=20
> I'll modify my patch series for now to fit in and will follow up "checks
> to git-fsck(1) to surface and flag refs with bogus names for the
> "reftable" backend" in a follow up series.

Thanks. Note that the fsck checks are also proposed as one of the GSoC
projects where you're listed as a mentor. Might be worth it to hold back
until we know whether any student wants to work on it.

Patrick

--TlW8wPx5jqF+EdRR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJv/cACgkQVbJhu7ck
PpQAVA//a5HIZT+qLpMe4YKNAC4o1UYGXHE4Y1HL91KhPPvzumzO0hdG8Hl3amUH
7Qf3ofGnrasJbDXaJB/cdmJirJYnq2I78QK8vON0toanjaseG4cHAa7n3hgL/p1J
G1VCOzPwA0xV9PbVf1Bw1N+kVIWRXd9jjudP5ikx8oW+jYEO8UJPbFodAJK81DWp
EwS8EH77g/B7uUEytgRx3ScI1ppn/DM1EKW5FlLeKU3ZJ/9Prceom+1nJeh/Nh/g
S66NEJOQ7sLxMjzx4yAVaHHBSjFLldCVtyR7XRnOWC6rFZeu5Hm92kOj6I103+ay
988ofQqwYhPGBmVeLDEfpSBlEnFxMj78r4kWD7NWNEaqFsVMCYNnTqc2RrKQvJYu
cV7WOraNLiVTzeDV4TV2ue5sHozzlNWtuUl2ti3uScPhjVwBzbmIMcegSKc1lRsX
p81bvyzDzXlbJ+q3xZRH2koJpHMTCXD1J7fIuFq8QA7MXM9p2U+M9GI9K8lE+Xtj
9+04Bd3z21SuY9Ip/Iuqs9HKGjgZrXVk44kIcLc0WLT5gOuyNZEmYgPeqCrV/66m
hoWkxv/BScUp8gh4TRkaBpMTC6sPKo7fWsWjx0euqF+XOFZuiMmHN8CJukx4k/6R
JluUSLgT7uFk/bE5Ju1BYxz9iXHiVLmHicQh5gSvONfPkpRKYK4=
=9cfB
-----END PGP SIGNATURE-----

--TlW8wPx5jqF+EdRR--
