Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B60A3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996111; cv=none; b=TdZEFrOEXwzPFrWlCbzgkzkt2GHfyH2A/glmBXaW9p8cc/zY7M+vrIyY5MsFQV8mZpN4wWTJPJQ/5PnQhelnpfhWVr77YFCeh+449AbcP18fX+QuVOkKx4+WOFRsRiTbUa+IEisuVBG5b+23hc+Ytvn3gLQwai84AfEsq04royY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996111; c=relaxed/simple;
	bh=VRXNDcGJ4HWe6YpfCm8xFsjceQTMYKgLp6F2Q1PbZOk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKlYl+pg5FQAQM0G8ZrT2z1gZlnFL7lVXVg/NQsXbNV94eGvDzfsPFAyxf1NQP1I4+7UgZbf26X+szhInoc+C1ZkPWAfAWXM4wcE2ZU+xWtPFzyUyFUtkSfFmsSU0m6QmFXC1SEkdC3B+bmglx9Y6y/AdmL3dp9/yZAnGqUo0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fGXwInUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/H54iRb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fGXwInUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/H54iRb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 74BBE1380532
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 26 Jul 2024 08:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996108; x=1722082508; bh=/xVE2Lesc+
	A1JM41zcuE8UgGg+Y6uhpj1DZmanjNan0=; b=fGXwInUNhuSwcnFdL9/2QYyVmu
	L4Hc4949y2xe7ETxNzQTWKgEU1az8l8j9na/a1vorpnvHqIl28IkwEnBkRtGJONW
	FLzztsN3EqUkYN0WrLDUida68tJfwOysQU8ivTQbxP6hhR1IlygZMgpF4QHh94Y4
	imJzE+nm6jf6r3YbzfyPPEBLJ73C1k4HW74l0hla5OBXfIue7MFvojqvgnWhqcGQ
	QxxgV+6GR8RDANA4f52kV8wyVvPwWYswmV4AHf4p++ffdeW0KIdPMeBXq+/QO5cF
	TB2Mkl18CVE86zb6lX4tUV37V56U63yzSjERpEiYSJC4nLT8+JAhQ9Yfltow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996108; x=1722082508; bh=/xVE2Lesc+A1JM41zcuE8UgGg+Y6
	uhpj1DZmanjNan0=; b=g/H54iRbuXxzLM1eLqwHkVedXPgiO5DgK+5VRyGCTxdq
	jXp/9+aDZGOdKZ5eM7otF34vv3GaSxyzmOBU3Cii8u//i+Jg3QMq2CJgX00q4n50
	CawdpOAOg9NNf+ur6NHtReQCagkax2bOdcRwVbEK1cqhWzfsAVSJ2et5iKvVNo/P
	/ZmiujwwOntmWYzjYfSfmwioWUmfwkDLLx/kLBsyr8fQRfkwXP+ZvEUo2XwCZMwd
	uMWwbanOKxrOKKd555Z7Ri6jMEb0Uj2tbeXbvnamZXGlCARdhHsJFWoObn7M1bwB
	Ph6HDLtJYAIWSLZtJH1Ml9a78vFFh9a+R8i32CaRDA==
X-ME-Sender: <xms:TJOjZlPKIgQPqaJI7AMxSEy645NhbtbKXLEw9zW50PTkHBeBEL6Z2Q>
    <xme:TJOjZn_TEMsOhFl517Jwp76gNrp4Ky1nKNKmJvycxKnIU1_PHLlYBaZEuDZLAjGGw
    ed7tU6YKPuu0FhDBQ>
X-ME-Received: <xmr:TJOjZkR_oqaziVGLT45UPSWNzERSOO2BZsXX6WRkBLNm4SwzOphM6zhWVWtZu_siGS1OZp_pYnx9eBpcLRrjGl7xKhg7GJJxAYCawP9uT2QL6Ib8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:TJOjZhu0GoHANvF5CQcJtw9SZxVwiPVxLmqcpOcbJF4x5KNnAZDleA>
    <xmx:TJOjZte1VqUtXswb4OIEFVh4a1mUZ6hGcRnRs6FT2Ba7161zo9m44A>
    <xmx:TJOjZt0yZeIt7KGnCHYBOL9mYdmekbcft2awvlHlWY4pk0auT9Z4JA>
    <xmx:TJOjZp_HIk2pRspOYLSA_dx5ludI5-jEJRqILbv_NRl5N3Fs4ljbaQ>
    <xmx:TJOjZtEHjCKycgzH1R5Bti-uGHbr_BKFhQbh_WweRDytL9ngPCtTXuBl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 37a551b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:13:45 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:14:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/23] builtin/name-rev: fix various trivial memory leaks
Message-ID: <088f730572f0f5aaa8f9640ea35a4687be9094ba.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+qedKR5Q6pjQ+ZFy"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--+qedKR5Q6pjQ+ZFy
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
2.46.0.rc1.dirty


--+qedKR5Q6pjQ+ZFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkz4ACgkQVbJhu7ck
PpRA0Q//QmKrg1fqi4E6cBmVffTJ3RzJYkPtxBVtSlTW5iZISicZ5eJ/kS1inX4X
gvUjy41zfRA0UU6tCkZnWnaqKaRPVrPME99SSZ7GtrEunwtZHn8MdRCl5UCNSQYW
o95LfpQMyj4Gddn2YMhWiox6S+pgDnckkq/QeFCSlL1fCPg4mHKk4b2VGVOt7L2x
RxxKbwOucGVQioPC2F17kcoPRuiGSfTOX/xsIPKXdWNLRuS+CcUKYpcrv+3iUjlS
TgnS40RMFc29/3xBKQFZKPSMvzDKK11kEbSIpwOh/yvM/h6nnaQTxLD3is3Dl8iv
Ex8bXxsbk9ah2LXtmNFRFq/sGwxSh76uBwcWO9jpeWeXy/rjoFJGVMxLWO9y7uaZ
SxHyCjvW+KjA7JnW9l2KA/lg+/aLyNCml3yI16RkQHLmz+B1RRBYj/7Et6buXujb
4CFoFeRiTBEdZwidvqCqDtHvJp6V9hakr4YrUFnHcwTvF+KTULXvadkGHtS8GSsI
XcehWB13XlAP5KSDRu+lb/mhmneS24Aarz5NNkWf9u4KhJpPbGd6PtZYQI8RQZ3n
z4UPCJlofUfiB/q/Ww90kNNyLZ/dL/QXpEtd/g5l7+1Sj7uwdPXS+jfAcnarMc1F
4H8qZ2YSObxlmMQpD7cZnMptkQT+8IoPLpTT0dc4gAD4PqYWWVw=
=0frh
-----END PGP SIGNATURE-----

--+qedKR5Q6pjQ+ZFy--
