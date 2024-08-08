Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C9181D00
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095500; cv=none; b=X/nVMiYhR6FSSpehFcPYVHTlKhRRenwcZSWnolBVa9eYvj14DFE9zrYwobbQAttMDD1SDrS5TaMRkw3TsHsq4RGU8Zz9xprcp/rQlNh+ZAsHP6x1MvK4KH9psUdpHY77y8GrXRdJh+wCdHO9FecwiFiEVTe+i9JZYg7sJcVmmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095500; c=relaxed/simple;
	bh=yYheCj658JUNiAmvjGSyOaFJfI49oqp2r6Nf7Bk7990=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+ua12B4min9FiP97v3usAOk2OGRwX+oJAa7cuVcEtGN8X3JGJFWbdL+fwr0Pb8pVScXNgAJoji2SkYVtRyZ1som70CdSExWONmsoL+bUy6eBQz6RtP2d/Z+gu2/iUHqmwwkmkFHEGf3Ve7XrPdaP6hkYlIJEfaBOaJa5OtkFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hIiC+ltl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5CNayzf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hIiC+ltl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5CNayzf"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 54850138FC99;
	Thu,  8 Aug 2024 01:38:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 01:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095496; x=1723181896; bh=OH0i2yh2SS
	MX8bUI4Ot405TTI3ZWdTWxnxA9My8x5hU=; b=hIiC+ltlPQEpMsqfOYkV/Ry9Ck
	cKgBqijEUKLEZ5fWGCcjckeEPsGTmJEAlTlW0uF72lQQTt8HgRqWEPOeZJ8pIVXm
	eH/lzZ+xRO8f8ZbwmXDz0gbUAfUGnBa4pghlKGY2PvIcTgGm59rp0adGPtB/xg7s
	cU8g+quOTO9Ev1UlYmPsacFE6DfdkQ/OwlADLnbTOjQ+vVLPW2zy8ddYjxjFO8vG
	0+0JKK0zSS6olU1+sBdMu/Nh8Zjaf8rCYK1JxfKDHk8WtgCRMBJC9nFakZQ8ChVQ
	xH5JeJhG/ExItlvb0BW+CarH4sqmJWZydbm9Z912VB4atOesvbkA9m1kia0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095496; x=1723181896; bh=OH0i2yh2SSMX8bUI4Ot405TTI3ZW
	dTWxnxA9My8x5hU=; b=d5CNayzfG4mYMlyemzriE8XG/Fh7SCdL4NRLPEJTH0PL
	qmkT+0ujb0CSLajSJYkVRyd2KXipBp7TwXftLQTdGLBuF4hNOrrm9izMEnjhne7d
	VvjYLgMZzBQitBtek5AgmwLgPlC6m+hrP8OfOoD+r4s8z5gQS8w23oyMw0KiY1nT
	63Qmx9p035Y3rxTk04jxLf0nsD77oaL82UU+ic7cnPhhlwGDtI2dNBYn+wlIMBrG
	TruCCq1vyT7MmRrsX8ANtyow65eQj+gQnOT4cgFAbjBbTiomvmHldVYl1MpkUx+t
	xiWONqpsrILQZzsauISll2w8+htod+gx3vvRlqgODg==
X-ME-Sender: <xms:yFm0Zj0ow1e26wgQ_r4M_HSsEIsAH6DnE5ngpY2eoUGT0zg27NgY8Q>
    <xme:yFm0ZiEMcfoGW89v5F4Sm6iNFkUwJVUjPYXKKz8SWYc8SNQu_y9MXS7poSlpYf9-Z
    ReafMj6JMZvPy9S4w>
X-ME-Received: <xmr:yFm0Zj4o1PYfzHFDwH-tniON7GZD4nig3svkVFZEp2oMyQXEfA6eUhYGeMdM2HIAk6CdznBUAm_N6Yo7ZR4Tl-MxmL8IFwSV9YWfztBoQIIwdvXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrshgs
    vggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:yFm0Zo1CiNaJqjm2MrXdofUrr4YzIvu21BoPVychDS7zdqtAR3N5rg>
    <xmx:yFm0ZmHIDqCrp1fozbrnlPSz-Lxra14z-aSyixdHBr8FJQb9nqeZXw>
    <xmx:yFm0Zp8Tpca0h1cugERXv82JNAFw3ztx3Jm2LP3MDzGHzIFuTyM8-Q>
    <xmx:yFm0ZjnGG0_wAv-_yUoUpc5cC-d7PDtg0NCCOsp3Mtmu5uUAby00Mw>
    <xmx:yFm0Zkac9QeG5YTBN0wHhKZIJQqz-0786jQHeoypGWD-ZTMziaOx3y1K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7bd5603 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:08 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 1/7] t: do not pass GIT_TEST_OPTS to unit tests with
 prove
Message-ID: <78a9cc116253c8c638cc430bd0a842805105648b.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l0IdGngaV0kzEjUR"
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>


--l0IdGngaV0kzEjUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When using the prove target, we append GIT_TEST_OPTS to the arguments
that we execute each of the tests with. This doesn't only include the
intended test scripts, but also ends up passing the arguments to our
unit tests. This is unintentional though as they do not even know to
interpret those arguments, and is inconsistent with how we execute unit
tests without prove.

This isn't much of an issue because our current set of unit tests mostly
ignore their arguments anyway. With the introduction of clar-based unit
tests this is about to become an issue though, as these do parse their
command line argument to alter behaviour.

Prepare for this by passing GIT_TEST_OPTS to "run-test.sh" via an
environment variable. Like this, we can conditionally forward it to our
test scripts, only.
---
 t/Makefile    | 3 ++-
 t/run-test.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 4c30e7c06f..d2212de0b7 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -68,7 +68,8 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
=20
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) TEST_SHE=
LL_PATH=3D'$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE=
_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"
+	@$(CHAINLINTSUPPRESS) TEST_OPTIONS=3D'$(GIT_TEST_OPTS)' TEST_SHELL_PATH=
=3D'$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) =
$(T) $(UNIT_TESTS)
 	$(MAKE) clean-except-prove-cache
=20
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
index 13c353b91b..63328ac630 100755
--- a/t/run-test.sh
+++ b/t/run-test.sh
@@ -10,7 +10,7 @@ case "$1" in
 		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
 		exit 1
 	fi
-	exec "${TEST_SHELL_PATH}" "$@"
+	exec "${TEST_SHELL_PATH}" "$@" ${TEST_OPTIONS}
 	;;
 *)
 	exec "$@"
--=20
2.46.0.dirty


--l0IdGngaV0kzEjUR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0WcMACgkQVbJhu7ck
PpRp+g/+JSf9s4/G4SByvAhjPbPK+uqxM5NsGsTfJWwYJ0biUBI2IMftWgENIIdF
Py1kd8OykDVpVC1GZuwlJAb35KSOi+Skd8ti2Kq39UvnJSV8ovbM0TutDzyIxbdO
vcyxDIVpa1bAe9sfxwrORJemX2uReSLxAx2O6wdwrmO+/xuRmUSqv0knmtSDAaCB
a+E/SpUmGqF6TjXawmzoB3Jef4jAJO7WWfe7/HUb5jj7K4aJhSaGQ6Hzfitgw1UL
IJHplVotzbxgfSlxgw/YuIw8faHTUvMXETsLmHbbNY5nl9vu/n/vQHDoBkOo0Cx5
ovd1jC/zTLiXjaGMHaKU9bvcFdNWmivEfL9qYhCRLuDJ5xmlz0Fo+Y7fDnVNMBLT
Z3lw39hR1s9LBlNHQ3KG86Hhe+4BLQffIITdYQKEWMvIdMrvWVwyfonSTDI27b+c
rIRDSq1/cHBs42nAHQarM2zZPiCibjRKc8g7f80XhlTdXklWOw7aHC/VhDvxK8hW
DOiSB4UtuRkt86R9I7Eod69PrVTdzHreAjjxVuoIDbvFPShpucHHLPXSI24A8fJx
Q8LzYHNzXK/yLD3tOhu7srq58Q2Or8cFjlvYjV8O7AmZtvztlbW1EP7gygXpzPRs
b/IEyQY50CF8GORgD3E7ITCw/7uSF7zHxQMcfYlW70nBdIjXbwc=
=9mV2
-----END PGP SIGNATURE-----

--l0IdGngaV0kzEjUR--
