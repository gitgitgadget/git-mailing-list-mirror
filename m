Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2116B3B7
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324277; cv=none; b=jUmsQeX5pkriCvCvqZtm9VvYUwHKkLxDOYNsCvrE8HZImQtEbw7bgtkv3X9CoiM/yJVZWRbONbzsvj4EZshpTWX2dsQlZxg3Ww1cK5EB44ybYE1BWNr6SgQ5zar2rK7bUCx2epMollOXJpD1SQGUwCTFjYUaP3Rt6IMQ0XyMxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324277; c=relaxed/simple;
	bh=QcsBtmnzLgugl8V3EWXrFSOZ396uz7zoxaXlCNraEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmNSN1J/hENtzOZ6c8Mf0xRILCS8TY4acFFmgUIfgRXPEWoW1IDze+CzmgJo5laeptWLjK+nvACDobSJ5VzQQK2yFPYGkCfEbzDv3Bi//8hi0DSc/vcVPU5JpKkbyGqBno7Hfezxxq40yTePOPY+1DIJlrf+clwTTBQce2KgNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H3hPiibG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cgjDksNj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H3hPiibG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgjDksNj"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3C0F1138079D;
	Tue, 30 Jul 2024 03:24:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 03:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722324274; x=1722410674; bh=FsMrbLRZ6+
	P841hZ1xX1eBSz3rhqz198w4DZP2+SJGw=; b=H3hPiibGHRswU1pStSeJwyT00i
	jWdz7k0gyNULTrtNJ3/gztECxoGE0lGD0fcoUJTAVNIT4SGzwbhoZzzHhw634zmz
	J/RWXAnB1HFJyupR/vm88iUjLoUvF/Gsft+zcv9sV6F+y29GmTYb1glwaHqFshNp
	1f0sxpT9N/KyZQPANBz13NFpDKfCIwLCfDtXC+KXJuioXN63hxxI47veeuW3/0Fq
	VTy1zo8qY7EMUtPQ1xc6EOoc8YgJ5YWk1pCVuPRuZRI7kInSVIY57/b1+tNI6Rti
	oH7lzOYqD92/EAnGX2j641OTrtVTZ/IB+fplhfytEhHRaw+F5D7H/P/tFSBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722324274; x=1722410674; bh=FsMrbLRZ6+P841hZ1xX1eBSz3rhq
	z198w4DZP2+SJGw=; b=cgjDksNjlM8VHM2scQ3AuRoCglpFyPfzX+zaCdUFkW7o
	R53Nv8WeSLASbjVfqtmIFo92Tn9TkekeXW6qTABCXerOP8Bp6YztbrQ15U9yEfTV
	qYfVsd/tc2JNwarvs2s3VjUbGYgmF1XCfX1rbkKDyQWTZZA7ij8iJ/viMGqk/xqA
	OvB+x7P1kwiCL9aZ9X2Tvsa18pp/apsKvaljmd84s/Hp1t8qV1vDXUnoH8CwsEtO
	XAaZWRe6lmMkExdX9yrUJUwsGiJH5Sz6LoWxgnFrHznsP32Wa+49Qp4CrkqroM8Y
	oKMSukOyTI8npfevZC6fQMnjrd708Kg5zdqXTHt1ZA==
X-ME-Sender: <xms:MpWoZnGmONumx1v3auxGE4-pHSlGTFlU_dlV4GNvaSvW-8YWqUGcaA>
    <xme:MpWoZkWAyvIpbkN3GrhW5EaFs1Ylai0R5cUR0-E-50RFc5RKzJc0uJpqXY7j_Ab4v
    TSnQ6_5SsEFhMkwSA>
X-ME-Received: <xmr:MpWoZpLzclzMysT3hr03Kbqrw_Td9NNJ6NDVP5jMfnoMAR6CDTynH718es5PjXdKq1g4uTkrEh4LaDr9hIklagjBXGAZoIUSUlhMo-pVem5QLMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedt
X-ME-Proxy: <xmx:MpWoZlFNQg8fDz28DiPlhj_OS8ooiKo9ydFDtTMggA4JfBxaNRHfOw>
    <xmx:MpWoZtV1odHnK90H1qwmnRx6h5IL5HMH1fyGHE8h6UmX5dQaThhFaQ>
    <xmx:MpWoZgMm3ygkNw66E2ZRRlnqgKuHxBL1Liudl2YCCnhMQfcWKXFHnw>
    <xmx:MpWoZs1yi_rr325VRnNUuoHD_T0g0-zM8_U8SnuhfAfBE1E4KhOU1w>
    <xmx:MpWoZjyu2Sd8R_0H97OywDGrZCtkMlAQfTuucckniL_sUtk-NWxT5jTq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 03:24:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2587c0b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 07:23:04 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:24:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/5] Documentation: some coding guideline updates
Message-ID: <cover.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7uFPh7fhbOQmwpnW"
Content-Disposition: inline
In-Reply-To: <cover.1721818488.git.ps@pks.im>


--7uFPh7fhbOQmwpnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to improve our
coding guidelines such that we arrive at a more consistent coding style.

Changes compared to v1:

  - Fix clang-format to use a single space to indent preprocessor
    directives instead of using tabs. Thus, this series is now built
    with kn/ci-clang-format at 1b8f306612 (ci/style-check: add
    `RemoveBracesLLVM` in CI job, 2024-07-23) merged into v2.46.0.

  - Adapt the coding guidelines accordingly to also only use a single
    space for indentation of nested preprocessor directives.

  - Adopt a proposal by Junio to more clearly spell out the relationship
    between a subsystem `S`, `struct S` and its functions `S_<verb>()`.

  - Document `S_clear()`-style functions. I have adopted the proposal by
    Junio hear, where `clear =3D release + init` with the restriction that
    `S_init()` must not allocate any resources.

  - Add another patch on top that makes variable initializers consistent
    in our coding guidelines. Our style is to add spaces between the
    curly brace and the initializers (`struct foo bar =3D { something };`).

I think I captured everything that came out of the discussion, but
please let me know in case I misinterpreted or forgot anything.

Thanks!

Patrick

Patrick Steinhardt (5):
  clang-format: fix indentation width for preprocessor directives
  Documentation: clarify indentation style for C preprocessor directives
  Documentation: document naming schema for structs and their functions
  Documentation: document idiomatic function names
  Documentation: consistently use spaces inside initializers

 .clang-format                  |  6 +++--
 Documentation/CodingGuidelines | 48 +++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 3 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  c33ad700d6 clang-format: fix indentation width for pre=
processor directives
1:  64e0b44993 ! 2:  e3baf01234 Documentation: clarify indentation style fo=
r C preprocessor directives
    @@ Metadata
      ## Commit message ##
         Documentation: clarify indentation style for C preprocessor direct=
ives
    =20
    -    There has recently been some discussion around how C preprocessor
    -    directives shall be indented [1]. This discussion was settled towa=
rds
    -    indenting after the hash by two spaces [2]. Document it as such.
    -
    -    [1]: https://lore.kernel.org/all/xmqqwmmm1bw6.fsf@gitster.g/
    -    [2]: https://lore.kernel.org/all/20240708092317.267915-2-karthik.1=
88@gmail.com/
    +    In the preceding commit, we have settled on using a single space p=
er
    +    nesting level to indent preprocessor directives. Clarify our coding
    +    guidelines accordingly.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/CodingGuidelines: For C programs:
       - We use tabs to indent, and interpret tabs as taking up to
         8 spaces.
     =20
    -+ - Nested C preprocessor directives are indented after the hash by two
    -+   spaces per nesting level.
    ++ - Nested C preprocessor directives are indented after the hash by one
    ++   space per nesting level.
     +
     +	#if FOO
    -+	#  include <foo.h>
    -+	#  if BAR
    -+	#    include <bar.h>
    -+	#  endif
    ++	# include <foo.h>
    ++	# if BAR
    ++	#  include <bar.h>
    ++	# endif
     +	#endif
     +
       - We try to keep to at most 80 characters per line.
2:  7f07bf1f3b ! 3:  25f73b970d Documentation: document naming schema for s=
truct-related functions
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    Documentation: document naming schema for struct-related functions
    +    Documentation: document naming schema for structs and their functi=
ons
    =20
         We nowadays have a proper mishmash of struct-related functions tha=
t are
         called `<verb>_<struct>` (e.g. `clear_prio_queue()`) versus functi=
ons
    @@ Documentation/CodingGuidelines: For C programs:
         use your own debugger and arguments. Example: `GIT_DEBUGGER=3D"ddd=
 --gdb"
         ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
     =20
    -+ - Functions that operate on a specific structure and which are used =
by
    -+   other subsystems shall be named after the structure. The function
    -+   name should start with the name of the structure followed by a ver=
b.
    -+   E.g.
    ++ - The primary data structure that a subsystem 'S' deals with is call=
ed
    ++   `struct S`. Functions that operate on `struct S` are named
    ++   `S_<verb>()` and should generally receive a pointer to `struct S` =
as
    ++   first parameter. E.g.
     +
     +	struct strbuf;
     +
3:  5e1de3c315 ! 4:  d4ce00303f Documentation: document difference between =
release and free
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    Documentation: document difference between release and free
    +    Documentation: document idiomatic function names
    =20
         We semi-regularly have discussions around whether a function shall=
 be
    -    named `release()` or `free()`. For most of the part we use these t=
wo
    -    terminologies quite consistently though:
    -
    -      - `release()` only frees internal state of a structure, whereas =
the
    -        structure itself is not free'd.
    -
    -      - `free()` frees both internal state and the structure itself.
    +    named `S_release()`, `S_clear()` or `S_free()`. Indeed, it may not=
 be
    +    obvious which of these is preferable as we never really defined wh=
at
    +    each of these variants means exactly.
    =20
         Carve out a space where we can add idiomatic names for common func=
tions
    -    in our coding guidelines. This space can get extended in the futur=
e when
    -    we feel the need to document more idiomatic names.
    +    in our coding guidelines and define each of those functions. Like =
this,
    +    we can get to a shared understanding of their respective semantics=
 and
    +    can easily point towards our style guide in future discussions suc=
h that
    +    our codebase becomes more consistent over time.
    +
    +    Note that the intent is not to rename all functions which violate =
these
    +    semantics right away. Rather, the intent is to slowly converge tow=
ards a
    +    common style over time.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/CodingGuidelines: For C programs:
      	void reset_strbuf(struct strbuf *buf);
     =20
     + - There are several common idiomatic names for functions performing
    -+   specific tasks on structures:
    ++   specific tasks on a structure `S`:
     +
    -+    - `<struct>_init()` initializes a structure without allocating the
    ++    - `S_init()` initializes a structure without allocating the
     +      structure itself.
     +
    -+    - `<struct>_release()` releases a structure's contents without
    -+      freeing the structure.
    ++    - `S_release()` releases a structure's contents without freeing t=
he
    ++      structure.
    ++
    ++    - `S_clear()` is equivalent to `S_release()` followed by `S_init(=
)`
    ++      such that the structure is directly usable after clearing it. W=
hen
    ++      `S_clear()` is provided, `S_init()` shall not allocate resources
    ++      that need to be released again.
     +
    -+    - `<struct>_free()` releases a structure's contents and frees the
    ++    - `S_free()` releases a structure's contents and frees the
     +      structure.
     +
      For Perl programs:
-:  ---------- > 5:  8789323ac7 Documentation: consistently use spaces insi=
de initializers

--=20
2.46.0.dirty


--7uFPh7fhbOQmwpnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaolSwACgkQVbJhu7ck
PpRnRQ/7BSy2vAUjNK6vX62ylJn0udin0pFwV5XyVkWJRnsVFFsGXlO8OXmLo/qy
wtGt1n8jBr8HB3w8JXBy0W5dkyACZyjqTW9SM3G6Aky+1+/KSaoukVAlGl5ybX4a
TEXRnpf+M8Orr+9u372OnGyZiWV+mrlct27vNllW9QQ9lMqfiwJCFDCoSf6XXcZY
/i6cXOk/LTb5GqK/poXNF3yGNoxyrMr+Fk/Kaw29fyr91gBAK6jv3+Gt7ljZN2d+
ZMC63Q09/0q2vLfyiuzhWD3cer3G8w+UsLsAoJIS+Jlsq7EzZBW774qOg/80rXF5
x8snYWYPLOurZTMAPeAZ/B1qVoHry5sz0Ke4RpRaKz8D056hFKmJ7njBrxQOSHfJ
ljDOaJh7VPiymE9hcGwxBvuvs2wDq3+073wggHGxN1eDL41cFTQGUr+rUw4MRj53
ZJaMpe7u0WORUAIFsF257pVOguJxDL2gSY+JdfUcLSRJuQAE1XbI0vzVIiN5+PWN
DLIWNVlhMeqNQ+c7T8wUl7wJPykZPPgab9PuoMLo4VcdRPAvT3lm20egOqtUm5Cm
Ulsfh2mKhBXhTExDFUSW9w4d2yPeCShFpdSxi0jDFt5yJ8uvDXcQGx4c9TTcSPTV
4Ph6vLbT0nfpnXYhUnnd/jr9wznGbqqjo2wOOprrHwcclO5crK0=
=LDnp
-----END PGP SIGNATURE-----

--7uFPh7fhbOQmwpnW--
