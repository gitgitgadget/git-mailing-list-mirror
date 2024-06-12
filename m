Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1916D4F0
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179407; cv=none; b=IjsRkKosiIbL5CRVIZPZy7zkt1lfGKr+M8ChHYAK8MCs+eB9txAh8PXjgVRme5clFxaT5RH/2wzKdjSzyUw34EjMRP10ITUwU2vxCl7MAharMUzMJmllen1cq2uOetcGPQVANaLpEWSXzfqwEkyJYQiDLvBGf99syWTAhxG4FMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179407; c=relaxed/simple;
	bh=i6Fdd6MmCbLwb0kKSW/toki2M6Oy0ovrg6k/pvTtX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIhHLea9XwM6oPNDewksDL+CUyK7eLRzN+PKVtseND9FNtRRcVuUxf0cbl2yFNdYgH0Z2E2hlNLMEI5GWpQxFrr89xrjHQNc6EMdRB8CPowUSnCYva2Xr2enEK2MWl69Q2aOpwiZCYMispJmQsf13nNLNIItIrWuvc7r0e7NsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJ6GUOwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFfdZjvK; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJ6GUOwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFfdZjvK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A654B13800FC;
	Wed, 12 Jun 2024 04:03:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 04:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718179404; x=1718265804; bh=UObNUVW+Rc
	3kNAk88M7quQqmBmpdRrIHX1I31ZyOUN8=; b=cJ6GUOwAd4W2zWr0jrz2ByHpYL
	r/PQxz+nTyxm/GukypDJvHDOuh8vUxl45WeqF9Kx9TmaKXh+a8Dob4F8B/nzKOW3
	WfCC7q6j+PB8VVqJ6uZN09eJCwPDX0JNqLG2rFQeTC9nORnf2NS9Jkkfd0iT0w5q
	rpbhVyN4RXC11h4XynJdhgEjf9NqkMbGx+Syvb05j3ZA+83Jl/gruHSZ+W3Ognk9
	K80guVc1uIhLW4zS4oKiqu9KO8APp8oIqbUb3iAgziC33vsxo6KS4v2TU1o5bKDQ
	ctrX3kWJYuNj6NZfL+M4BcGJSh7q+EA8EFVLcghp+AQJv+xsfil0CkIZorNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718179404; x=1718265804; bh=UObNUVW+Rc3kNAk88M7quQqmBmpd
	RrIHX1I31ZyOUN8=; b=hFfdZjvK5GixvGdSh7ioaPzZmKznlrOMjOUTXEvBVPcd
	skVUY6RyLffi6b09F4QLtHan5tP0kSmwjRaVePjWlf2J8lzoKl/Lc9NOeE7lIJPA
	dcDGbLnUCfEIBr+WFjA+ix6uJZ+89WqotJZNKsYfPIK7ChUn55JyBA+bYZIdJGLN
	c9NQSokUN6iQcEAka0nkqFLcac3mFzL0dD1NwAtThFzjL4ekS5h2AnXqzR99ZBPB
	rewmvUIJ0o1aK9qlD5/OpCOBDcpgWkexHmGx2n3+g4IH2pBGMoWpKsNi+inbjpOG
	DoYljiFpaDR2eRuo6QLE+cxLhE+WCMOJritNQvNBvQ==
X-ME-Sender: <xms:TFZpZiaxI7GpOECWhBqE_q47PFK_NXaXWHtOocVFyTxlC6a3UwusLA>
    <xme:TFZpZlatWAh9Jt_68_LClFDoy7UCdB3ZXy5R1_e5grXae_nfp68Mj15X2H4OF0Qx1
    7YCodo86BeAHbJBHg>
X-ME-Received: <xmr:TFZpZs9pJZC53Bs2eXl2Euw6xbAcuOMLiu723Xa438TctYXUsrSoQIa4MV-0w13BlzqbSTUMZUkr7jcS4O5_oIrOcKGyH1sf_RyStP9lmArH7ezYv3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TFZpZkpztU4NuwE9cQgGHKqUejmqXnomVqf9_CDzRx-XRZCAP8tCBw>
    <xmx:TFZpZtpWUjkIkO407dX6blJM3nynTiVsT_sdvofPCnkiB4-O6ahwvQ>
    <xmx:TFZpZiRz9f_Zp-sT5nyB3n3ace6Q9FopwzL2-_ikt4e-Lm_QKc84pA>
    <xmx:TFZpZtrvwVCWsilZcLakTfTLcHvVP9lQHeLeHIVn8HRC9MkYguHXKg>
    <xmx:TFZpZkWZA1fPuMOFFmeHu42qtzTsKd7YJnHYh1wIE82cxX1c3rJ50PO3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 04:03:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 89d97b31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 08:03:10 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:03:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] config: fix segfault when parsing "core.abbrev"
 without repo
Message-ID: <cover.1718178996.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U0Lf6wpKQPjcorXP"
Content-Disposition: inline
In-Reply-To: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>


--U0Lf6wpKQPjcorXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that fixes a segfault when
parsing "core.abbrev" without a repository.

Changes compared to v1:

  - Stop truncating the abbreviation length to the upper boundary
    completely. It's unnecessary, complicates the code and makes us
    dependent on `the_repository`.

  - Adapt `parse_opt_abbrev_cb()` to also stop truncating such that the
    behaviour of "core.abbrev" and `--abbrev` is the same.

  - Extend test coverage a bit.

Thanks!

Patrick

Patrick Steinhardt (3):
  config: fix segfault when parsing "core.abbrev" without repo
  parse-options-cb: stop clamping "--abbrev=3D" to hash length
  object-name: don't try to abbreviate to lengths greater than hexsz

 config.c           |  4 ++--
 object-name.c      |  2 +-
 parse-options-cb.c |  2 --
 t/t4202-log.sh     | 24 ++++++++++++++++++++++++
 t/t5601-clone.sh   |  7 +++++++
 5 files changed, 34 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  7ded51bbce ! 1:  b48c50dd92 config: fix segfault when parsing "core.abb=
rev" without repo
    @@ Commit message
         `the_hash_algo` outside of Git repositories.
    =20
         Fix both of these issues by not making it an error anymore when the
    -    given length exceeds the hash length. Instead, if we have a reposi=
tory,
    -    then we truncate the length to the maximum length of `the_hash_alg=
o`.
    -    Otherwise, we simply leave the abbreviated length intact and store=
 it
    -    as-is. This is equivalent to the logic in `parse_opt_abbrev_cb()` =
and is
    -    handled just fine by `repo_find_unique_abbrev_r()`. In practice, we
    -    should never even end up using `default_abbrev` without a reposito=
ry
    -    anyway given that abbreviating object IDs to unique prefixes requi=
res us
    -    to have access to an object database.
    +    given length exceeds the hash length. Instead, leave the abbreviat=
ed
    +    length intact. `repo_find_unique_abbrev_r()` handles this just fine
    +    except for a performance penalty which we will fix in a subsequent
    +    commit.
    =20
         Reported-by: Kyle Lippincott <spectral@google.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ config.c: static int git_default_core_config(const char *var, const =
char *value,
      			default_abbrev =3D -1;
      		else if (!git_parse_maybe_bool_text(value))
     -			default_abbrev =3D the_hash_algo->hexsz;
    -+			default_abbrev =3D startup_info->have_repository ?
    -+				the_hash_algo->hexsz : GIT_MAX_HEXSZ;
    ++			default_abbrev =3D GIT_MAX_HEXSZ;
      		else {
      			int abbrev =3D git_config_int(var, value, ctx->kvi);
     -			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
     +			if (abbrev < minimum_abbrev)
      				return error(_("abbrev length out of range: %d"), abbrev);
    -+			else if (startup_info->have_repository && abbrev > the_hash_algo->=
hexsz)
    -+				abbrev =3D the_hash_algo->hexsz;
      			default_abbrev =3D abbrev;
      		}
    - 		return 0;
    =20
      ## t/t4202-log.sh ##
     @@ t/t4202-log.sh: test_expect_success 'log.abbrevCommit configuration=
' '
      	test_cmp expect.whatchanged.full actual
      '
     =20
    -+test_expect_success 'log.abbrevCommit with --abbrev=3D9000' '
    ++test_expect_success '--abbrev-commit with core.abbrev=3Dfalse' '
     +	git log --no-abbrev >expect &&
    -+	git log --abbrev-commit --abbrev=3D9000 >actual &&
    ++	git -c core.abbrev=3Dfalse log --abbrev-commit >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success '--abbrev-commit with core.abbrev=3D9000' '
    ++	git log --no-abbrev >expect &&
    ++	git -c core.abbrev=3D9000 log --abbrev-commit >actual &&
     +	test_cmp expect actual
     +'
     +
-:  ---------- > 2:  92860256a6 parse-options-cb: stop clamping "--abbrev=
=3D" to hash length
2:  31c0405f85 =3D 3:  0ccb8d8efa object-name: don't try to abbreviate to l=
engths greater than hexsz
--=20
2.45.2.457.g8d94cfb545.dirty


--U0Lf6wpKQPjcorXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpVkUACgkQVbJhu7ck
PpSpDA/8CpaOn8G2NGf2Qy8hDc9jbDATF7jR5MSHTAKBpEVbeVNCMKTMRFRnepbP
6zP9riIABjKSjWiGTfkkWoW6w27VTajgDjnWcT8NM5jTDkFWu4spcfKokyHsI4kR
NTo6QzQjcSl0Nc7/lhpI8jWRBxj85ZiyFKKTzF8zEg+FHAjMo1VeJlS9SdM0RQlP
kLdsLqJ9MSYo+aYL/dgSq2RLx37e93WBjXKqSg00iUljxp9yDKssZuCUIYz+dRJZ
iQGB2dW1gS4skh21QDv5XjkPxBp1dkpF9i8pmiylSj/zpVaD5r0WVDyJUeaKy55n
sa6Rv3/Rdd+UdvYf5SPosr0giYBYGJSPQJSBOWTZ2AAgT+YiPQV5zQrzEujnJljI
QfZJAZGQCNra9c30u3ueyqHSuTENc5ecSNG2PZh5v27yYBrQWkNWJwHKLIZaz6yr
IXtcaEIeZioEQRBGlTJm0Jzmfoq+8TnK7pPZbXMdXDXFQ6R/3PmIpQtA6FhSkc5X
2Avoufrz7lDkupDc85nH5NwPbYJCPqPrytxacwF+nzYDtkFgwnxSy6LSVM3Nux5L
xMDzTtocE0zM7IGnGR/edS0UTmOhazSrLuRXc3wbROfBewwRo2xdozX9X4GhkREn
gfRP/QtLtiZoQOzYLZoeyq+89VQp38rWg2spBt0CW1eYlzYOWfo=
=nsgP
-----END PGP SIGNATURE-----

--U0Lf6wpKQPjcorXP--
