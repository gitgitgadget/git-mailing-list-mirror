Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554FE148848
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347814; cv=none; b=Y2M/RZPUAjcRAVGDvoD6XVOGyHTsS9V0BUpQtPhNTf7dSIjASI+s9K87Fr0uDQg8sgzu7mWwMHbEIehBa1qABmjHhXgMhPL2miVtjAtT1jWR6BVdopq6jJLfKEAiwTQWGVQr5ObsbyWTOoWVz5BMix/UlZvCE66W5fkKIyZs3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347814; c=relaxed/simple;
	bh=VyVZ+KqT0OMUMc1Ze7ZuAR82piPMl2UXqlYsWsd7Pzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4e7mBv/1qm2NJCd6Yom8XdCUY44YucI1bTMYNpNymfNunTqNZrqr95+p9slSf7gJo/7s01TdJat0sEyYcAmg5cHAdDvq8lNdhJ89RxwqlspFo3K022E8UaF6CBDT7vRrBJ3tCpH9sq4ZXAhuvE94VTOrGmfN92hTdNMYU6oyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nL84CZrv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYg/pSpz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nL84CZrv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYg/pSpz"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5268713803F8;
	Fri, 14 Jun 2024 02:50:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Jun 2024 02:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347812; x=1718434212; bh=MGPzjXdCm5
	I+zdBT55C40LOdR3iW7wq7523WmfpeVeE=; b=nL84CZrv4v+Q0WSM/D1V4zt5xN
	qUbjiTHX7+TfQgByK5uiv3ukG4y7m5P9WEg8+sqV+meVTXNwao3SSlOc8JuO/w6Y
	dZV8T4IQuzfgJIhDZklpfsEWkbd6Z+CZ56eX8uVUH64j891joZ2EpUf+Jc7WprUX
	9Bxv7EOMFvljvMDg0kFN7lGJ/Z/Bal6XFpKHcNzCYLS7jjdPW6zvVuk1oEblLoxr
	KeGe/niB8V7yLsZTJFK9QJKJ3z10CbqVu6RwPpu40X2xEQkBU/o08AP+qb37Yq6Z
	TRpyWYJ9jzg1yCOx+4tBjOETa3SFjDgsCzW2T3KlmQt7NNjrwGMDZhH9cWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347812; x=1718434212; bh=MGPzjXdCm5I+zdBT55C40LOdR3iW
	7wq7523WmfpeVeE=; b=NYg/pSpzKhn1Av/WRG9GLCVfndoiTXq8O8uHXB8j5yCF
	p+3yNfL7g1+ZgHxF5xRIOe4dvU3iEoOEvKaLu/yuecf7j2T1Q5HwWZoT758iKsH3
	HWhBc1q16xf1/hWPQzrKvEuVyQmwHJOs3Cvg7dloMj186YnSzKA3KgKI8C5PFA+s
	0yTn5o4vtI7/PknSEIEyipda0iYa3tTI4AwSlWgikhUpuyybTTQzFDb0rqoPCXye
	JhDemnPHEfJMPuEJoB+DN9Ce5xUZIZ5+jGYXJGuqDaTqIxiM20FB1ZDBHoxIDL82
	wHD1k/VaqYzeasvHBiu+iJY5MWxD7T1HrVxOj4vxLg==
X-ME-Sender: <xms:JOhrZgyhXdsRH_GV8tcjZQE_59qHI1ijv3ZwDZtClak9mQSHfD-d3Q>
    <xme:JOhrZkR2lKw93K-qJiAapK3uswDnXgMOBOQgZPe7kn6t5L1X5G55ZimpqUB0B03_y
    iX1KGSSIqZuIpWmfQ>
X-ME-Received: <xmr:JOhrZiXLh9P06Kau80z66LaGVgREq_KZmZsWbsHFobxwmoZ1tqe9RsfR93woRsvUMdyc-LQ2XslNrvgGGzJRdJ9SFRqAlVPO6NLoguC1t-mnjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:JOhrZugoVLLDbX9ISkQW3tU24jjBFAggd0njYPx69z2G54csw71e5Q>
    <xmx:JOhrZiCfuaxNMqhc39ylsi4nVk0suRzH4rqC4SDmVXX4SQfDO3aJrw>
    <xmx:JOhrZvIcZkJQP8z6JAaSoIhJu1YsB1lpoJWFHXJOCthZH1eA0sUgDg>
    <xmx:JOhrZpBQMQEr5VrjhTDjSduRwYcyP0QCQEVERj5eUsERuZ0-uiPhnA>
    <xmx:JOhrZp7Fry-AjSuLdtbqSF9BNg9aWtFlYGolM7Xc2IReH1TTr89Wq6jZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de8a42f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:49:56 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/20] hash: make `is_null_oid()` independent of
 `the_repository`
Message-ID: <9ae29e1912a661fa0539b0e03421a24566ed611a.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TmGP4yNegT+39mDq"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--TmGP4yNegT+39mDq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `is_null_oid()` uses `oideq(oid, null_oid())` to check
whether a given object ID is the all-zero object ID. `null_oid()`
implicitly relies on `the_repository` though to return the correct null
object ID.

Get rid of this dependency by always comparing the complete hash array
for being all-zeroes. This is possible due to the refactoring of object
IDs so that their hash arrays are always fully initialized.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash-ll.h | 6 ++++++
 hash.h    | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hash-ll.h b/hash-ll.h
index b04fe12aef..faf6c292d2 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -341,6 +341,12 @@ static inline unsigned int oidhash(const struct object=
_id *oid)
 	return hash;
 }
=20
+static inline int is_null_oid(const struct object_id *oid)
+{
+	static const unsigned char null_hash[GIT_MAX_RAWSZ];
+	return !memcmp(oid->hash, null_hash, GIT_MAX_RAWSZ);
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
=20
diff --git a/hash.h b/hash.h
index ddc2e5ca47..84f2296cfb 100644
--- a/hash.h
+++ b/hash.h
@@ -6,11 +6,6 @@
=20
 #define the_hash_algo the_repository->hash_algo
=20
-static inline int is_null_oid(const struct object_id *oid)
-{
-	return oideq(oid, null_oid());
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
--=20
2.45.2.457.g8d94cfb545.dirty


--TmGP4yNegT+39mDq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6B8ACgkQVbJhu7ck
PpRXSA/8CGLTHmyfxzbjfhi+pU4CLOLJQYieK5JxB0jzsmx8QhTRjrEmsjCVN5/h
5SIOj09X92W+waL0Im/VdkB4a6EaXu0qtA8GSnrsAXEFYr95Jl/zHWfSAJm/qbt7
FQzaHCT0lmanRtdb/nsrAEirOs+wMwBFAMgbLb6ZsA9++Och96gDWtv1y7kPBHXN
kIfhaHcG88Q7vgpqcMksncLVw3Jrg0X8wfNLPjLkMfKWgDVLhXAJrt3YpfVjRiKt
4bJLJTccNQqD2uN3rWMeBgQ/f4ke6R0g30+/GIqM7qfCarLWRSVTiNmCRYrcLL88
KQ4rfohZfHI8nzAUgCcXqU5puSiGzQEpaJpqK9xVSunSqryg2kN1qmjywYv2h6rj
j+ofY+Wm7abH8dV5dROhyyTziNHR7PSyrrQzwUHvnUknQ8SWrrDifmJEYpfcxUUU
9/v4/ZhIMhsW5qCKzAUE35I8ScxMsa7ydVoZyZQGl91wZoQuFsRXDM1OIWjh4//y
2QHj/HsycqwT1b6h8wlr5P+MuZNtRuEzO1mWSrep7RYIkiTiB594yszA2iI9L98a
AeY+HSQcsqf0egyEepBsk1OCezzj7gJFWz0WxwgqMPpL9EmvbFZwAjTmQQACYMth
j2fZ0Z1VP3mU2hfrITdcAsf+UxfTTs/TCxWnAmQ74OrTuRahAGs=
=OOX7
-----END PGP SIGNATURE-----

--TmGP4yNegT+39mDq--
