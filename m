Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5382188019
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508837; cv=none; b=V3qjFbt/3Uiv44IG/OpP2CWtir0r3E5npZOGqJOlAUUJcFULSAp411gkkos5BOil5eVjuqTcwmGBa5FSR8TEKsN1Lj0MD0KlMD52H83Hz5HeU4nq3JPsC1ZWQDLspoXZwoB6CUlryN3WZYe01mM/sSqU7CjZ68GZL/LMiGQxyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508837; c=relaxed/simple;
	bh=i9NdLqEp7I8/y+itB1YKYeKHBjVnm5CyGcj6rj9sZiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+767RcymrU+7MBgyEPKLQxwv7RHt/l3lhYA5H8KlAlZsDEAANfb8FZU9jk++jfp9+/fjtARu0NmDgTdvGQRc5YBNnaOEt5j6X8755l2vaQ157G88MrG4DUs8l1HDjtuvCceJw1EQEzq6O4dLDN+xJAaRxlvwdbA6FXm0CUSPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zw96EA4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qcEzT7iH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zw96EA4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcEzT7iH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF3CC114ABC8;
	Thu,  1 Aug 2024 06:40:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 06:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508834; x=1722595234; bh=NYOjR45wct
	yVMdDeaXLvx4vi8xbiziHV21etTV7SUTw=; b=Zw96EA4dAZvxmHmjdp07O2+cIz
	5LFaVKB/WiI+Cpr7XiHxL1Ct8SCLaoOy21cLxmQ2Czfz/u70NxdIT0o7WOTafoE9
	pjHH+zYy1Tsk461Gulnyh+LG8DRYkqZJM6TPrjEnlAsMH7ujroTDlA7Ggg0+umht
	VbDquL+S2G+JlQY9TeDZ+2jm2Mf90SZ2fuMZHfvgc7ApohXkIKWLLDMBfgHtl1gJ
	NjN4yKmIfajf9oj34DGn8Dchdam+m9HcSxnGewPwkhBumGdWddwvVUUURFvA1B2G
	IwKmWVSXR7DIe9z5QhzKu732IssKd7odn6zRHmifDIRsQukXVIbIsJC+wwhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508834; x=1722595234; bh=NYOjR45wctyVMdDeaXLvx4vi8xbi
	ziHV21etTV7SUTw=; b=qcEzT7iHZnC7YTHE+K/znUqv2puJIKEPu/7QaFvwKOsn
	EU6BS+tzHaX5N06einbK5zzTA97mdFx+XX7dmJPhC3syzxjg2A7PgjU9xS3cYoyD
	vEOU7mq6rQdIkzSrUauT4mnQrEwerlpxa3G16j29AkYKmwOQ2K8X/zNleBVjKdwb
	U5/69rYyKb0bGfsm1nS+QRsEwKENzn9ZtGfMahsNJYX08pax2vy8uUBSCtugjxdX
	Rs1RiZbLSfZEOoQDH0uOkYYjUCUxjRkZNFEqHt3QF72KjYSPP+zdpa05DR7hMZjy
	OxDy7uaQhxEsgRIvKwnO3+J1qgGiWL8vqzAW3MW0Hg==
X-ME-Sender: <xms:ImarZhzhUmFsVOSLxRrhGoM9sI1ZInqK7hvNEviU6bL8MZxwfVRwtA>
    <xme:ImarZhQdT_yU8EymwrAdC0bEaV1T01DNgfVRUHT0I0Sk5Z2iqwjp1_ToskqMM1lJr
    DUsBI1ohfEUt5VaKw>
X-ME-Received: <xmr:ImarZrWxn5-B8nhjlbb3keWjspJbNydl6qR7XxzoGbfVd_SMG9aQi-Wirp7KH0Otbm0eYO7n0B57F1c0QzkZClYHlEStmkBRwAp-OEAsPs657lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ImarZji0Zn7rqx98mztYeD_ZE9tVr1XPQVw9O1VSFWhxco9WvRXD1A>
    <xmx:ImarZjDQiAcxsZBjlUtyYgLJF49IxzlMkLDut15--uoIVEsUMtUajQ>
    <xmx:ImarZsJgci0Z-3zUZVh_S4G6FGjLI-zCZLWLpUgistl9AwrMxhd4Hg>
    <xmx:ImarZiAQF_7BJ0N9BEo_GFBtdvPEssB6nJK6KEc-S4nbzqiI1j6dhA>
    <xmx:ImarZu5v7UmoCUVOANQpzTQdDuTrHaziCmhAgY5srCTAOJn7bdR7bDCX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fccb4e9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:02 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 15/24] builtin/credential-store: fix leaking credential
Message-ID: <b553f1ffb9faa5ae93d93423db7d689c2def60a1.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alzyzV2KGgNfFZFS"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--alzyzV2KGgNfFZFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free credentials read by the credential store, leading to a
memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-store.c     | 1 +
 t/t0302-credential-store.sh    | 2 ++
 t/t0303-credential-external.sh | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 494c809332..97968bfa1c 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -218,5 +218,6 @@ int cmd_credential_store(int argc, const char **argv, c=
onst char *prefix)
 		; /* Ignore unknown operation. */
=20
 	string_list_clear(&fns, 0);
+	credential_clear(&c);
 	return 0;
 }
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 716bf1af9f..f83db659e2 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'credential-store tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index 72ae405c3e..8aadbe86c4 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -29,6 +29,7 @@ you can set GIT_TEST_CREDENTIAL_HELPER_SETUP to a sequenc=
e of shell
 commands.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
2.46.0.dirty


--alzyzV2KGgNfFZFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZh4ACgkQVbJhu7ck
PpTz7g/9GPnOW//nwYBk4Vcs76aixgFh87w5Nj4HJ+lVV7JdE8IZppFQKwrfgRqn
Sul5R07bU6FQgeBzVXKW5CMqrW41kszxs0A8/Ho6/cJ8r7fDvLjTg0V/SObKR0XB
Ed2yJ2qJjQJ9Uqtn+LINd3hfHf7nkQcuU8QGQu29Nsuz8Oc/xHwCqa8HSFEN1/aT
Hm9IgW0qR0jCvLJi1hDZINEMuRGoC0VKDQfIZmTGyChPidVa86YMKijLRT3SaIoM
UiZUQxtTE743p4hbyOWzqCmotX7LslEBXaznOhGeC72EztrvxC0rtKNfxcv97ceW
Mdqql35tLHfSVkVrjvV8MEwSyeXzFBRrXWYRujlMLr9xeQKi78lz0tKlqcgfhYdO
SgO8sxrtsk99zC3keyqZ04o/eQux4hKrcK/DVHISq/oNTRYF9hmDaOVpDCqUj9Vf
jB5iRu/TPXvJxrmdtzFg4rN/WsdjjZS6gPcWbasqCgv9Ujwz5mLpsBjydY7mnTSZ
dfn3lXIF5Tmi29GcGUQpJwuoJPMQq6G83Gt7mRFDsMFsAszwjlGixCELmskc+CD+
Wyo8DLA34Ic+pIkVnqEDs6saqEBFskk5BSF9ffk6+EdR36YMReShpJDlhFmG58bL
N6YseQpTYq403jlAHmSEaFYMxdYuUVgnfiyX1ANe+9s2/CMYY8E=
=Zs3m
-----END PGP SIGNATURE-----

--alzyzV2KGgNfFZFS--
