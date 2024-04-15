Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177424A06
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165797; cv=none; b=spy3nKmWg8xr7i8eVnhvEsp7W3zefLDvA0zJzxvciRWytUFd3ZLcFmCOEXtsv4rk4l1Ihh4MbGLRdAyy3nkIKGJpo/YurQXUYcIEAbLLXgP309JuCcbrMeYkA0YGfdotEPFPKTrnfxkm9xFgyNbtIiHBRlBBD09/3/XHg+D+CsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165797; c=relaxed/simple;
	bh=9xtAQBknX+5iZpK/TWi/otvbT5tA+77tClxgvi0H/qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4LbIgKLu+3p60E1r/QWkmK5kbF8GDbQCkk59etnifkDscjGp1pLeLfGdA3zSbO8HR0wgcRwKqvLErkGXCPFKvBAw80yEiD/R+KnaxHp9mEbTWVfLJN28cviwp3PZtzNp84euYCzk2FBpQ6wmkWiM65ViSKIqvRh3wvLZl43B34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQaIGcOB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxGgSABp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQaIGcOB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxGgSABp"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D27B13803E7;
	Mon, 15 Apr 2024 03:23:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 Apr 2024 03:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713165795; x=1713252195; bh=jjtwSvYnpK
	/iWz2myYgX7NkX+jdJw2krxhdeqBPKMmA=; b=NQaIGcOBmVCXosCTJGR/VWn3fG
	5JkrrfQYWP8VY6Zj3+h4dROPAjqtOnoh1T4cr72R8JBng4El1EFI6qEl9JzkkplN
	xH4Te+WQeF4jZJDvv8PD2PYiV/nAhR0Fb7UbJ19YmRT5U2xjQl0HTFNzRVAAj4lj
	BRk+7KV5RRjKmFCqcegjIEYoi7l1aOTg4m6geAKHJgpdPkN+K4T1GLGtGp4fxshy
	f2Eff6h1YsRmvJdtq0hgquppoudeJ8PT2RLBRF/SgJpcFnEPN8+as4hq1uZiAivS
	j4af3UuvS7KIcoVMoUA5FhxysjvJZI/qsfVgtlMi29YfFczNkKYgPrwXjPbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713165795; x=1713252195; bh=jjtwSvYnpK/iWz2myYgX7NkX+jdJ
	w2krxhdeqBPKMmA=; b=hxGgSABpMfflNhj16vZyHcSY9o+dZXIXcj4epdai6j6r
	r/VZFzCByjHF4kc733HOATDGEYwEmbnCmpijnnAhjhemeaETK9sAa3Lmux277Hss
	kMVwZbHpUdsVxe9jgkQ9PAw/OHOxQG79Vu2mKKaMdC3oLP2cXvL2YQYB2VhXFOHa
	WZAMiYHiDEwgRSrO0b25k76wxJxjwl2drJdUXUVRFqexB8sHVyi31TEw1SeWXI4z
	/EV9kwX2pOcFQHGJ7fVRrJybc3aN6irAP25Nr3f77qo7UxpfpWK/UDmMSOTS7ghe
	mg5iIXUIwhC50LflnRXiD6pS/qeOIGY2j/mcpmf/Zg==
X-ME-Sender: <xms:49UcZr6EB2migk5Me6nTUgf4BRW0XOlLf2-2v0BmqfHxKouDjMwlMw>
    <xme:49UcZg5VlOQsqJTVKs7J1BeEXM24G_6qJ3XyAjRsbuepfwABkg9zyHCaOs8qHX85C
    1sZntnAtAE5A5IRJw>
X-ME-Received: <xmr:49UcZicj2xtkSb4yq1Kl_Qb0P-GJrisp8pk_hOnDyM9I0Pe6ziryj0NtFGOqJs6PbXe-sGf5Y8nphSd_UyL19B5TryeNz1Ftw34xeuwd7VJ_VnBrRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:49UcZsJtujyb9t4cvEaWeuxBBL1XLfn3lWL3QqF1-sX-L6quuQ_V6g>
    <xmx:49UcZvLLGAGR63mz2ltpz9MvDkvravsfFWkhsIdqk-1bw8o1oH2cNQ>
    <xmx:49UcZlzeyB6fsarQ7ZxqUxOqP3cFdVff_0E_-LJ5Upkam-uYE5zVcQ>
    <xmx:49UcZrLmusp7RZSgi_xemU_Xg88are9zkFwMFl2Hh8Z7QkS4GwA4zQ>
    <xmx:49UcZmWlog_Q7ZKUJID-YdLrg9ZnULcN1B43XznhqvxXJeUzcEfo8OSn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 03:23:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9c89636c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 07:22:54 +0000 (UTC)
Date: Mon, 15 Apr 2024 09:23:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #05; Fri, 12)
Message-ID: <ZhzV38Ga1Lg99bUF@tanuki>
References: <xmqqfrvqhwlg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BpT/0zIwK1qemavP"
Content-Disposition: inline
In-Reply-To: <xmqqfrvqhwlg.fsf@gitster.g>


--BpT/0zIwK1qemavP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 06:36:59PM -0700, Junio C Hamano wrote:
> * ta/fast-import-parse-path-fix (2024-04-12) 8 commits
>  - fast-import: make comments more precise
>  - fast-import: forbid escaped NUL in paths
>  - fast-import: document C-style escapes for paths
>  - fast-import: improve documentation for path quoting
>  - fast-import: remove dead strbuf
>  - fast-import: allow unquoted empty path for root
>  - fast-import: directly use strbufs for paths
>  - fast-import: tighten path unquoting
>=20
>  The way "git fast-import" handles paths described in its input has
>  been tightened up and more clearly documented.
>=20
>  Will merge to 'next'?
>  source: <cover.1712907684.git.thalia@archibald.dev>

Yeah, I think the series is good to be merged now.

> * ps/reftable-block-iteration-optim (2024-03-27) 9 commits
>  - reftable/block: reuse `zstream` state on inflation
>  - reftable/block: open-code call to `uncompress2()`
>  - reftable/block: reuse uncompressed blocks
>  - reftable/reader: iterate to next block in place
>  - reftable/block: move ownership of block reader into `struct table_iter`
>  - reftable/block: introduce `block_reader_release()`
>  - reftable/block: better grouping of functions
>  - reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
>  - reftable/block: rename `block_reader_start()`
>=20
>  The code to iterate over reftable blocks has seen some optimization
>  to reduce memory allocation and deallocation.
>=20
>  Needs review.
>  source: <cover.1711519925.git.ps@pks.im>

This series received two favorable reviews [1][2]. Justin pointed out
one typo in a commit message that can be fixed like this:=20

 1:  eb487557a8 =3D  1:  eb487557a8 reftable/block: rename `block_reader_st=
art()`
 2:  d0b318b8ee =3D  2:  d0b318b8ee reftable/block: merge `block_iter_seek(=
)` and `block_reader_seek()`
 3:  c3f928d1e9 =3D  3:  c3f928d1e9 reftable/block: better grouping of func=
tions
 4:  35f1bf5072 =3D  4:  35f1bf5072 reftable/block: introduce `block_reader=
_release()`
 5:  e8e8bbae62 =3D  5:  e8e8bbae62 reftable/block: move ownership of block=
 reader into `struct table_iter`
 6:  685f0a40bc =3D  6:  685f0a40bc reftable/reader: iterate to next block =
in place
 7:  a7906a3383 =3D  7:  a7906a3383 reftable/block: reuse uncompressed bloc=
ks
 8:  6635c7b986 =3D  8:  6635c7b986 reftable/block: open-code call to `unco=
mpress2()`
 9:  587b5601c0 =3D  9:  587b5601c0 reftable/block: reuse `zstream` state o=
n inflation
10:  cc5ff0d598 ! 10:  935860c567 reftable/block: avoid copying block itera=
tors on seek
    @@ Commit message
         When seeking a reftable record in a block we need to position the
         iterator _before_ the sought-after record so that the next call to
         `block_iter_next()` would yield that record. To achieve this, the =
loop
    -    that performs the linear needs to restore the previous position on=
ce it
    +    that performs the linear seeks to restore the previous position on=
ce it
         has found the record.
    =20
         This is done by advancing two `block_iter`s: one to check whether =
the

I don't really feel like it is worth it to reroll the whole series just
to fix this one typo, but can do so if preferred by you. Just let me
know.

Thanks!

Patrick

[1]: <vab3mzg3meohikmfl5v57uxj6w7w2odrx7cvhmoto7am2bl2yt@6l4salel4ko5>
[2]: <CAOLa=3DZRxQPnPxM+sZtuL-a5DVJL8Xx+D7t2d4cLoPT-hLaK_UA@mail.gmail.com>

--BpT/0zIwK1qemavP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYc1d4ACgkQVbJhu7ck
PpTELg//f4R/SMd9dIeYlELF30lYFudbLx4MEI1+pI7I7mrmlFLYo9JR4qn1mMTU
VyFFtFxD0CNAvrYMMN2Oz/YRQrLpLqQvmeE/3KU2xXPvHHnfK9n1/0sImNndEpFs
2MOLZIK173ihdlG/9PzCL0haOyf1kp6T+JKVWVzd9sM3czpyBNRSq93kkTr+9z3r
CH15S5kkS3q42PoR8RxzcCV0tcdxYEJ8Qkr4sO6gViDR7uIXO0CP75iVwLaRpjsr
Cr4emegUvVF/SENA3YEk9DmsIcIQ15NfA/9FPtrX3WkLp8jz1jiBUuN5/a+A/Ewc
JURoLWJDEOnDauKaEvnWwHHuhGP4xVlHn5s0zqx196VBWtwREcMkiHJT4XYMTxqB
M9AGgCmrnIfqKevDqGuFYetIzLBQ4HEDl/wnWgelsySHhaZkR5IwYAPB1t+ZyV9S
GAEGNzSXRyoQ3Yyt+cCr9QcqasjrDkp/cFGiP2I7nHimcWChWn1geR1Q6L2ElfuF
wW7iUFBaRsq7qzBLZUs9GauSuwOvyYdIKZAsCVeDGxyn1bJdB3ZUtaG+q5r3UPTB
RY663zA6l0V279bfPyHgjEICR+/ZJrxG0+0SJGQElhGyUG+XQ+9Xy0Gw2sIgXlgy
Ee2rXm8lSkLxTdm3NrHN3ILuQ5I71/+/8tSwoHrRXRCV9BRTCuY=
=Po7o
-----END PGP SIGNATURE-----

--BpT/0zIwK1qemavP--
