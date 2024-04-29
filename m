Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A468614C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413969; cv=none; b=SNM508Qg6EfTN6YmF96rWV1JQd/11D1lBSJsxMTLPHT5Qwsy9Do1leObg4JioXlj++50tqyzly5JaXBPc27/Yr303ZqZlUer0HjsdeZwxp3rlJJYeagozFhPBVgNN7cvfVgw44Zpote1U2X7DmhcLXAvQWcVm6X9AJ4atVxbF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413969; c=relaxed/simple;
	bh=AcBeZ0uoCAgP9hgr92ztrlV21681wIGhjdnmJXwdPlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG+AFlhJLHKu0lGb47/kjKpVqx5Fg+ZNDBqNFEISiX8YRbXnJhe957hWcHC9ZubkR9ynoJkZjV1jmq+9A7lZt8Wbf2+HQUgG+qL0sQRqabcuLJy/VeJc/qkpE2LoRy1mcDMt5+LLwojXQL2eYkmJovRUjKPAzAqjr284MguNT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QxbbfX4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nj6vUP61; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QxbbfX4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nj6vUP61"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id E4749180013C;
	Mon, 29 Apr 2024 14:06:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 14:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714413964; x=1714500364; bh=4CE6Dqx8lu
	OB8ASGtT+n1PfyOkmS029QeVsUKnClsyg=; b=QxbbfX4bhEOKAENLuZ0IXCCVYh
	Cajhh8Ms9oowYHlRGgYOj4rcjUslZRWMA8qmp+Ns0qiQAHOPyqLN9pEGPhQ7xt+2
	CMgAHx3sa/vwh5zhy33jKxA1KokggqusnEMVc1CnVkrFxzTBNAwH9YmLmEyAsQA6
	uMUnhH57Z+cuIUDwZf6bGvlUGeRM1zr6reG4MdffTCtfbmNliJEQvnqvilmSiW5l
	UYVXsuDHF8C2ZINBnmEFJFvvF2O+yaTCdEjuEEpygXecym+ANG1miTlEgRaO41T6
	CsO8lPtwTH53aqQjehWtouxZCPh4ZF68ksS75PupEdfEeGrVYqiNmDQFdi2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714413964; x=1714500364; bh=4CE6Dqx8luOB8ASGtT+n1PfyOkmS
	029QeVsUKnClsyg=; b=Nj6vUP61+iwcrN9nIjdjGUPTBA/R/9TGzdNRc7tzQIVi
	AkbOqoaOPt4PYK/UYo6L3MZFL8KvHN36ijxNrEhbIfF0NKIGuHhHIoeSH0vSMpZe
	x4Jjx3anRoqegVlU79QdNYh5WWK1ednj8CtHrncXF2e2marNLvEiHAJAYxcCOyhO
	p2rP1Mo5cRqcPEXO4Ze/lOG8JKjVhO01i6T7+lXd2wLNOOflp3Ag2dH+T/7zjPRT
	dewnHUWxLeBstFXeq3+IL3iZdAR75S7ClQAdBSmlv8Cx5TY7vWMH2qxR4Vu8YXKQ
	YTpY5CSA2R47x4QCPhpjOaSdLxXpxkFt19GjXV8jEQ==
X-ME-Sender: <xms:jOEvZjKtnor865b5_sJyc8KB2qzL3WNTfOyEYmwTvEdVPjjm1fbOBQ>
    <xme:jOEvZnLGOOOVp9NCJhC2ItqWomnDz4SOBIfIoaiuJ6vfnSookM-By6MnBX0Kd3fgz
    rrS56sRDbnGf7z_5A>
X-ME-Received: <xmr:jOEvZrtC74XoSThXj07XHgk9lknqAEQHBq-h3yzj8KyjAsIhGrzWaKfKwkMOs0tOHtewVkYA7qbYFwHHlC_jN9rCOv6FL6Bly3GuQcUKXghhs9TU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffelffegueevkeelgeetvddtfeehve
    fhhfegteegleduledukeekfefhtdehfeeunecuffhomhgrihhnpehpkhhsrdhimhdpihht
    vghrrghtvgdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jOEvZsbXGvB84r6nUCTDz2A6R1d9X1NH_5QaSc1ei8x9R1kSt4cMjg>
    <xmx:jOEvZqaHFTR8ugn7GlEjHLe4nHm9uRTW1P5ZXN4YfrvG5eHn7PC10g>
    <xmx:jOEvZgCC-AaHbVnKkSLkxch_Cwn_oItlCQf9yG71Y9RumHSzGrrpEQ>
    <xmx:jOEvZobrOIe7ElbS3LIuGGVRtT-DWUhlS0-iGpcuyFbN6lv0dyarWQ>
    <xmx:jOEvZpmjz4fkK1h1i6vBchXxEyJSvg31b65v0scu46ohSUf9qNXEALLc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 14:06:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fd5ddbd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 18:05:40 +0000 (UTC)
Date: Mon, 29 Apr 2024 20:05:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #10; Mon, 29)
Message-ID: <Zi_hhpoXHrCz2kcf@tanuki>
References: <xmqqplu8ulra.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKT4GLi9evsl/ni2"
Content-Disposition: inline
In-Reply-To: <xmqqplu8ulra.fsf@gitster.g>


--bKT4GLi9evsl/ni2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:22:33AM -0700, Junio C Hamano wrote:
> * ps/the-index-is-no-more (2024-04-18) 6 commits
>  - repository: drop `initialize_the_repository()`
>  - repository: drop `the_index` variable
>  - builtin/clone: stop using `the_index`
>  - repository: initialize index in `repo_init()`
>  - builtin: stop using `the_index`
>  - t/helper: stop using `the_index`
>=20
>  The singleton index_state instance "the_index" has been eliminated
>  by always instantiating "the_repository" and replacing references
>  to "the_index"  with references to its .index member.
>=20
>  Will merge to 'next'?
>  source: <cover.1713442061.git.ps@pks.im>

I'd be happy to see it gone as one more step towards less global state.
It may be debatable whether the index should really be contained in
`struct repository`, but even if we ultimately decide that it is not,
dropping `the_index` would be a necessary step into that direction
anyway.

So yeah, I'd be happy to see `the_index` gone. From thereon we can
continue to iterate.

> * ps/reftable-write-optim (2024-04-08) 11 commits
>  - reftable/block: reuse compressed array
>  - reftable/block: reuse zstream when writing log blocks
>  - reftable/writer: reset `last_key` instead of releasing it
>  - reftable/writer: unify releasing memory
>  - reftable/writer: refactorings for `writer_flush_nonempty_block()`
>  - reftable/writer: refactorings for `writer_add_record()`
>  - refs/reftable: don't recompute committer ident
>  - reftable: remove name checks
>  - refs/reftable: skip duplicate name checks
>  - refs/reftable: perform explicit D/F check when writing symrefs
>  - refs/reftable: fix D/F conflict error message on ref copy
>=20
>  Code to write out reftable has seen some optimization and
>  simplification.
>=20
>  Will merge to 'next'?
>  source: <cover.1712578837.git.ps@pks.im>

This series has seen reviews and I don't have any remaining things to
address here, so I think it's ready to go.

Patrick

--bKT4GLi9evsl/ni2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYv4YAACgkQVbJhu7ck
PpR+XQ//VKXkH5mN484WGRq+huH+QnpIa5mfKsIlyPf2sd8Mc7S9ocPDw4xcPAl8
vtB9yfV9Nw96c50Rl7fCcIIyIHhd3wGQDrrE90XWlITbj+T0QVnsFKhy0/TG8KZE
no8dxPq3ObWFelbDnwXfX1AKLmmrBK+9SWWfGrt9UhtyX3Hr3bGBYTJoYWO2Umta
JmAxnqr+QS1lQdDCaRTVvJSgIEKUW5T01m1EI5URyxJokCWQA9l96bLUTZF5/qKb
TQ8wRXRIWYvJPVozpVZFPunO+5Kdr+nkjKyVNwVEhdqjmbZthT09Xp653Zqy5U3j
SZu6AasSTSoQVDP/DFaLE/qu0VJ5Sud5noCiqsERItAt47eatWbNs59i8Vu8u9/9
xNqDTdwi4deXGdfoAqHa/yAvqzlToDBvM3/NHAxhnkk58c+ifShxCsv6KgRDK4EF
kCA/WiUKRX2mzzRtBQnOWlJ3LsJ2CN5dahnvdTC9esWjUhsRPg5YhNbdNFCyOp3d
F1/UvIC5kXSidGxcm9kMWjp3SfJrsoCfTWruA9fe5w/dUtEjDBjQUe53T0hJLWTv
5qC9BQDeQkolYzlSJUKKKbpGA6Q4UPnzkGQaUfs9C3bR97dN4IpKtIzUBaCXsswm
H2h3qgHUKJe46n3ORXlA/txoOK68qo9stjt068wQsX1c9N09Izo=
=hy+i
-----END PGP SIGNATURE-----

--bKT4GLi9evsl/ni2--
