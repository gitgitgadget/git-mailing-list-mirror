Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBE170A3D
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508721; cv=none; b=uaKOGqG/J/0Ra01ZW5oMHvWXuKJEcjBYebLoLZrR1lkZfw8rIZMcjHR6PQWoc2oPyhgWtWACs1flxCWdysdtHi1nNTllD6F5Mr0wr/PMhS7bhP/SRXXpdW8dsYnix71yaGL08YiHrmfM0UL8T7Py7M3bdR2OOEokWcBb/lEekNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508721; c=relaxed/simple;
	bh=kOSDdnpdWr2Eu9Syxp8i9nIcw3LnxJlSxI8UFK8IOyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqUyPRizbGgnGVzmzMhEWgRWeASKb45FoV5M/BR5Fq6GIhCvbe3fmbvnlOijC+UpZz5EzCFb4Agmb/FrhQnALUY9sCHV0mqT8sg569xTd22Sad2GUlE/NjfrRep3z/FumC6jtEW9AppZuTcGiGvb1o43VD4ssn1q/K4SEnh5Rxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AU7eTQM+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1mfOtZa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AU7eTQM+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1mfOtZa"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EA9E4114ABBF;
	Thu,  1 Aug 2024 06:38:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 06:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508718; x=1722595118; bh=n0w+Ym2LsX
	KH1LRXKEioscAZijnqB9qeulCPlmrIXHY=; b=AU7eTQM+cj0XMot+QGYYKDq+HX
	YBR1GOdUbaFWSpxSppGJl2l28OQcOhnTf31NntyftPKC63OPXuuTLz4/wkHpwtEK
	tvec69+FcEGTgSzaGthWCCf+Fbr95bLvB/Q2dU3ZtIaYIFIX/kDMFNwmWwkhK5Kt
	Zz2dPGzKiE4g4DB058LvBfALPEUF4ueIzguuKGamDZsjOWusKW3grnt5/iroG0cr
	S5T+ORcxWdGZd5Z8mqPPWxSHWIY0SOhlaoxB7NxkOySDnL/uGw0VSo8VLD6rONM3
	mwP5FSaykthI/FDfMXGjgYJJkcQisCcanbXwHnjBbr3OAUru77b003ZHKHjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508718; x=1722595118; bh=n0w+Ym2LsXKH1LRXKEioscAZijnq
	B9qeulCPlmrIXHY=; b=D1mfOtZakH5CA7qyxwGpyipvVJ4O0v3js39E/4FAyc1c
	Z7TarCSiwRjtf0ZFrTw0+MDAanu3TARySL4wy/mEmRlcvzP2NFvjFLURCDXBvwra
	anqaddcf/qAZ9NQUrgARe9SSWJFP4YS0Ytrb0eoSxaByHOal7TgeyWxNyRKULwiz
	4pP+cK4ddIfW2dayCoMZFoxq24UkDMdkJLQ5vt2sqBgb1DsAV9orotsj6KMFdNa4
	K59/Y2msF4b2/NjAOjal5JvjEsrzD+o0pdTDF25joNa0+hZ3vgECsvS67nHDciNX
	sAGPEkHuVuiVj+du4JCQt1pWitlPqHWv1t4EjsG9Wg==
X-ME-Sender: <xms:rmWrZsBAEXIiQk67j5NuqRwruParJRJR-uG0iyXpqQE6YYvFXZmynw>
    <xme:rmWrZugte4oAmgTuRqFw7JJ87dCWflMj2WaJyWX46r6x59s7Qljl4aS81rmHfQMVO
    6cFB_DoIMf-IjSPhg>
X-ME-Received: <xmr:rmWrZvlT8RqJCMiEqWEW45sRSdsRTSu5CNpESToqPReJviESbwkg4gdPtsInZvGI8k0gVaHjvf3J_h74CY14FbqmTAJgm-UvJFzC2pkNRRSk9rE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:rmWrZizjoeYP8c1cxt0BBs0qZGegU0d-jozP2kqz82YwedqFrqPl9A>
    <xmx:rmWrZhQG23WK82S-hY4vRgXgwMXz5ixm8QM2oGofI5_Kb9d0F_5v4w>
    <xmx:rmWrZtYqDmnRoLSuyXx3sWQMcP-nYpMj4DUuMo0dqvrmSWmwXczwvQ>
    <xmx:rmWrZqQSavkxMMZZ0Pg-Mk26M9RG8B2qj7-BQVI-YlsZasXat19Vlw>
    <xmx:rmWrZqKsx_iJJieM2Rhb8j8EWawlu8UcjcRU_CrjINcyyVvlLHLVUCFX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85d79959 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:37:05 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 06/24] builtin/name-rev: fix various trivial memory leaks
Message-ID: <e38e9d1b623fcd4cd0113771124d44d470a48126.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f98QEb5WAfROQKS4"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--f98QEb5WAfROQKS4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several structures that we don't release after
`cmd_name_rev()` is done. Plug those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/name-rev.c                   | 6 ++++--
 t/t6007-rev-list-cherry-pick-file.sh | 1 +
 t/t6120-describe.sh                  | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 70e9ec4e47..f62c0a36cb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -677,7 +677,9 @@ int cmd_name_rev(int argc, const char **argv, const cha=
r *prefix)
 				  always, allow_undefined, data.name_only);
 	}
=20
-	UNLEAK(string_pool);
-	UNLEAK(revs);
+	string_list_clear(&data.ref_filters, 0);
+	string_list_clear(&data.exclude_filters, 0);
+	mem_pool_discard(&string_pool, 0);
+	object_array_clear(&revs);
 	return 0;
 }
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry=
-pick-file.sh
index 6f3e543977..2d337d7287 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -5,6 +5,7 @@ test_description=3D'test git rev-list --cherry-pick -- file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # A---B---D---F
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 79e0f19deb..05ed2510d9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -14,6 +14,7 @@ test_description=3D'test describe'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_describe () {
--=20
2.46.0.dirty


--f98QEb5WAfROQKS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZaoACgkQVbJhu7ck
PpQlqg//SsOryLkrc5fhTSSp4S89XQhnyqiQjTySXrv2mVjgLLmUpXIkTvPH1iuu
z9u6P79eABDS1Yg5v8NOqdNkXpNmCX1QE9H3rNUE73+P5UYqDOLKXLKvtEDIVEs8
iCDSltUgiQpVOwO8+3Y0OOqZsCWVGZBMTU2WHtPtv94jK2FPpTWmWTO24tBowf6d
aOcV4huuCN/eJjurXhCWzK5TN4rimEtw3+eKKenRwdQ5hsv1gJteu6stOUlWUIai
MjA7V5nxT3NMgG6CjJPLmfN0zgPKmcJqMS8/bGGeGAB86qpI2oDm9b5ONe6pB6sJ
Mj23o1b09xpNY1TPzz1+janzjTtOlN1HKjua5JemjdDH8G8oGD23jt8yAYiAv9/W
aZK0+heAjdXrV36LwKZd0GkZHBUc8XLfb+iUN3A7BXrCImXyyk5YvbIbH13tFKeq
5NZKahHUde3KvM3OBN/hpvYyFbscaVoe+mLYZljrrmTa1uEQdw5yqAnvZbUNsdkW
qi46tu61R88r9QevQrYN+1jKitKqYy/Vw5GGtSUrM3LXwUd31lzy2mn8Sd+Y9958
QgpyCfTnCchoDJBRgHGJNH1mLWNW28mWqQMsZqJshMMgcym02WxhNgqxCOBgp96c
Cn062gQ30IsikKJag7TZe/XtZflfbVvI8PCB3s4R7EQEI7awkdk=
=diI7
-----END PGP SIGNATURE-----

--f98QEb5WAfROQKS4--
