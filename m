Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A85A0FA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640677; cv=none; b=TZbRT4P5LjOkcACgDEkQA3BLnYC++0MhHv9HwLLjHKNT97B8aXdsA98q1AirTQD6mXVoXkdpnrPTichKnb4LO+K2DglEf3LXml3+aGPBpGDsXVCj8qDbCKSMWv2QJfuI7nIF/fE/XEijmynu9Vr1jDnbAI0n6j8eGfs71AzzyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640677; c=relaxed/simple;
	bh=cHpSou5pKckEZybgL5zP397wqR4AvIxtj+HjsyFbNq0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY2hNl26RxU7ITmVhlcBfmRzTVDeqDclioTeyXOvq845K8UkYcxwXIzWZQL5YeFFmwWa3Gvh9pHuo8KHPET2iXU1e8O0zPfRHqahjjw3EFuzgB8nY1VzQVNdj4Rza3f8GqE+BNtFcUr6SKsf2zbkGQx0D/PW1jQl/KcVue0Oww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pd6AvJ/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjKzpPy0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pd6AvJ/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjKzpPy0"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BA8E71140194
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:11:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 05 Mar 2024 07:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640674; x=1709727074; bh=5IV2LBbuEC
	NyFOBU2SBRcqaZ09QXLZIajQ3RWhuxd/s=; b=Pd6AvJ/CY/OBS7/JkDvfa2mZI/
	RBU/WIxZxYNKEzmtSGC9QKor79XWHlLHyLc0Q+tST+4OX5sn+07VlOfeDmAsXedY
	fcPdEHkEUUEUHf42Ili7QXpQXuXUroe78W4ixwJSUNaPBzlsBUXVo/BizzG3R16e
	0nbN/4/NHUi4zj3AsNbB+JV1ksrCsCXWaWRSVa89XtWKS8+kTFZ0F5kBABEUBViR
	lI1wQ3khjiKj7EvLV+1snSbZwbYaOtqZniwxOl0yzC504bxV7WWfyoFGmIiXDrrT
	6jfpO9/tEP5pMEbfjyNI79B6NMuCQOZ7t5nbYzXIWZOCN7I+/aPkXoSnY4Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640674; x=1709727074; bh=5IV2LBbuECNyFOBU2SBRcqaZ09QX
	LZIajQ3RWhuxd/s=; b=QjKzpPy031BCOJVv+xJYhnqfMeCsG+Sk19sIqk1ypG7Z
	PCxLzUmSntgvQ20PPlfu6FM6T+04WGt4vExy1YM++X/zIr0ju0xeVYD+bQmU5BHI
	inllF738C1KntTPS69LSx72Mg3g0Cvi6YPlv7iKj97+n2NrZ4NFCS5GLL414Xw9Z
	W4gYLDcQEh464IbJViboC6ZxsiMGg7PPfH+jGgMiIjBT+OI2vZQ9hzSdH1FGuNzf
	c0yOGTEsVkoehH4oXHqmTLNQxf/kDOh0sjmhGoLFqWIDsEfpn00XgPfdxM2l3JI2
	VfdrROwG+8FNzGN/JlP3On70CGWcDXf3oXqx/eFrkQ==
X-ME-Sender: <xms:4gvnZSOI3NBGqr9adoJ-BzFy7CP0elLnhbVK3YsF-Dw_94G8lNoGyA>
    <xme:4gvnZQ-FbzIBXhbiTA-WCF4CXyEcu6qOUumeSJJ63CWSNmW2hTB5f1DltHHd27g1p
    Vc-Ka5kfX2xQ47_QQ>
X-ME-Received: <xmr:4gvnZZR5O07m3yo2Y3aj9JWFJZysR_MgNGz6a_6mI_3h1wlxq-zO0Ybh8bZwf52yDHI4FKLs7NEFcZCxK2GvCMNu_6JGJKOULnbEuAJzbKWc29E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedthedtleeuiedtgeejtdfgueettefgffeghe
    efheeukeduvdegiefhvdeikeevteenucffohhmrghinhepuhhpuggrthgvrdgvmhgrihhl
    pdhuphgurghtvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4gvnZSso4W8Fz7-mISAr1MfZdSW6swujpRN5mO_4BcT_uVG3VhZ0hw>
    <xmx:4gvnZaeA3HqgiDEXJLpBZiZPRJ2UMXjT4wub0xzAVMTmY6U52GVolg>
    <xmx:4gvnZW1tU1iCVzt641epgPdsgxjwCtfSsXch2CN2YqIXoP1AJue73g>
    <xmx:4gvnZeHthuJv1_TksT6U-VAjV1QDqxAGlOVMU_spx3fGWr2q2dhZLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:11:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0da93bf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:46 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:11:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] reftable/record: reuse message when decoding log records
Message-ID: <b71be7c8ce59c00c638486dfb2cb1c7866e195cd.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eSr2zMi33yJJlMjk"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--eSr2zMi33yJJlMjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as the preceding commit we can allocate log messages as needed when
decoding log records, thus further reducing the number of allocations.
Before:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 3,068,488 allocs, 3,068,366 frees, 307,122,961 byte=
s allocated

After:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 2,068,487 allocs, 2,068,365 frees, 305,122,946 byte=
s allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c          | 5 +++--
 reftable/reftable-record.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 82780b2d06..7c86877586 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -871,6 +871,7 @@ static int reftable_log_record_decode(void *rec, struct=
 strbuf key,
 		switch (r->value_type) {
 		case REFTABLE_LOG_UPDATE:
 			FREE_AND_NULL(r->value.update.message);
+			r->value.update.message_cap =3D 0;
 			FREE_AND_NULL(r->value.update.email);
 			FREE_AND_NULL(r->value.update.name);
 			break;
@@ -943,8 +944,8 @@ static int reftable_log_record_decode(void *rec, struct=
 strbuf key,
 		goto done;
 	string_view_consume(&in, n);
=20
-	r->value.update.message =3D
-		reftable_realloc(r->value.update.message, dest.len + 1);
+	REFTABLE_ALLOC_GROW(r->value.update.message, dest.len + 1,
+			    r->value.update.message_cap);
 	memcpy(r->value.update.message, dest.buf, dest.len);
 	r->value.update.message[dest.len] =3D 0;
=20
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index d28f38175c..2a2943cd13 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -96,6 +96,7 @@ struct reftable_log_record {
 			uint64_t time;
 			int16_t tz_offset;
 			char *message;
+			size_t message_cap;
 		} update;
 	} value;
 };
--=20
2.44.0


--eSr2zMi33yJJlMjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC98ACgkQVbJhu7ck
PpTcEg/7B7FopWed08/WTFqSYKwKGPz3x1X66yhgbvU5fxa32BK90C3F5aibWw46
EbJRwqV907bmx6TWLaEl7xtdGci22l3uWsJBVWCKXV/3FTzzs8h6afi28JgQ9bMx
KPuHVMyx1iz5USKzGG9Lgo6O0c3rqEp39UsDuLm1UPaOwEulqDFbzW5O102944+s
79zaadFTS3Esz5v1RnR30dcTqHpOG9yOeSWaGK48qVaV3VwwjWiJivFd2icEcJNG
cEPemGwtlUVs24upyFoKVt2DG9UyQJZd86OGC0F+LxRhPR3HI2gjcfNg7yBnYOnZ
iRvi4YBT0bkyaNvDPOtgsh5Csh0vLq1ufMg0xYf1XumNUEk+8tAMhn9JzYjF9bz9
x7/Z5wnoibBKgvTpCF493F3wu+Oh3Q9YDxyr/HxMfQL73Psv0xpkmXLB2GZSkn54
XDDV2NaXRZchNYpsFblBF3MLzjVnLGx5AbZYLKW75ULFBgVJn04uqFkm+E9K1UmN
gkOa3/F13Nxep6rLIt1re3IJoYvjuxfg3ECNG6o6bnlxTOSclP/Z6uZcVxFeHmZS
BS1I/9FQwYnUlrZb+i/b9aaoutLwJjQYbVLhaOBZGx/OSyM9ErBPSy6Y7wj05JXm
nHVF0T/lj4H6X0kh33Y6knG4St7sQ5dCZrjZ5HnuVyFb0cOKnPk=
=0cDd
-----END PGP SIGNATURE-----

--eSr2zMi33yJJlMjk--
