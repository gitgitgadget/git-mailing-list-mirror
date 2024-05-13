Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4B147C7C
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588319; cv=none; b=NhHzd8gZGZFEo/WdOxJ+cAHYGb2QKrKV0O7s1Ho9ZG1PG3Rnqj1usTWoFyEIBB6ujCao8n0RMZXnPnFqTnl2Onfq9wF/Pkl4kuJjMMs0swFXakkfpBZPDDqkpGA+C8uypbCkg4Dw5VJ5HKOvXZ4Dm/sqdJNVyShY3Z9P3/PgluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588319; c=relaxed/simple;
	bh=qfUCS3ulBo3iqB2bUF0gX9sSRAs9HT7b/OMhtKgkySs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLnnq8R9pKewt/WWNZu76SP+G+0APquOLXiEF1rhFothK6yTu/7km/nIdeyJan/YJDlVtDyOwpLqP91CF6tCOoVrgYhV6Mh01lvPGk91rfObkIkaXEIA24Ljtz/Iqpnqd/6bOLGNa9J3hhFQ1VZNKHEqm4wfpiZg5zvl9dmfVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z8REzbyq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YVjIpXi7; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z8REzbyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVjIpXi7"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 452641C000E9;
	Mon, 13 May 2024 04:18:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588316; x=1715674716; bh=pifuyWtq6V
	VoeaYei6nHtO3GOjMeg7S2kqt6BKzv3IU=; b=Z8REzbyqlftKvXmqo8Md0K4gek
	Kha6+9LOCxbMHUybt+hVeNkoQWGsHXW2Nzz7SMIQQzBop7B7zmdKEKlHZTL8w1Bb
	KNik2NAbmqVVXlFMppNwVZSQ73nRsXf9VIfcWIl8GPNUqg8ghGk7o1y0pfogwzpu
	3Gu8LWKGSn0XsOxvKhFnH4fKbglJa+Rr4cgwQ6+9Uiomh0DnT6aik/cId7f0D3E4
	Er/u2uqnP0MdlA6O/U3U6eDmln1M5HNvP2ePAWoI1GcFlgGgnVSN2TjtnhuI7sUc
	/NG7L+WGSwxliyhsfAl+wDdsNCx5y0qKJoMlg+Uj6JPETU7pIO/2/k1PuTIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588316; x=1715674716; bh=pifuyWtq6VVoeaYei6nHtO3GOjMe
	g7S2kqt6BKzv3IU=; b=YVjIpXi7mLNFMdTJWtWgL1ZzLf2uSNJIJp2T+nm9YxJk
	JujB+HfVJZsRHAtDxGkxLfTLUI/atFLNXZ2fK5++e7RZBdiOB1rogUp2IES8E1+e
	HpghMwo3jLEF1N8sOzcj7mEy7fj8TRJBpkvl7djBznCa81fuAppC6FPW7vgwKJmE
	7iqQghvIaXcdpOeJtaz9tu9Fl+GuFDmGQOUw1UXRejVUsfMKWlvsp5hps6a/3DTp
	7CqWNJrT8lMOlRXt5tvKpN38u+vBD3S7Ya6vNb3X3PXRkrrVajo0nDbJmGyIdIy8
	t0167bQ/N0HC3zKIXlxEwUDulbpiPOwvJEIOCg9Jfg==
X-ME-Sender: <xms:3MxBZibQgYMYVTMTjhkBR3NinIbVSRqer3v2RQua6_RtckBPq_Yryw>
    <xme:3MxBZlbgRb6hydQaRByzAlE4mfFT0PUiUJoWBPMEjiiR5YXu_AwyENyIWTpZkpOlD
    dVGbEgpeposgPjwRA>
X-ME-Received: <xmr:3MxBZs8g9iXGDXszi_Ddgzgt8YDdagG8HrpakhtCn_7vqlSRXqe4UzRgvvXkgF2FftkooZa-Gt1_PrKxlLzlod0vKBOsb6bIjGDTX20sovyX_KI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdevudfhteeiveehheeiffduheevjeffveefieeiudetffeitdejgefgvdfghedu
    necuffhomhgrihhnpegrlhhlohifrghnhihshhgrudhinhifrghnthdrihhtnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:3MxBZkpe_VCvavl47Xk4oQfUazg5MN6-O8oJDYwMmxwLDZU3MaY76g>
    <xmx:3MxBZtplE3MWFqCxtf5Nr0jeR_R-hUk02PiAEQsRjfkSgSnwxHaLbA>
    <xmx:3MxBZiTWot6nVZTQZXBsmwHdjnFOjYl7vawl1hWicp__e_8H5n3ClQ>
    <xmx:3MxBZtoWhys7jF_F8hP-x4_5GLn0Oc14mrdS2y1WhlHZjt8DlbL1rg>
    <xmx:3MxBZunmDozOwAkFNEtQLgqEUCO865ztIDwgwmHYLE-hOAd5xd_RLQvy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0753c547 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:18:17 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/11] refs/reftable: allow disabling writing the object
 index
Message-ID: <b128d584a5aa3de73a5594e7996264beab424f68.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Ap+EJ6DZCLTfSl9"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--5Ap+EJ6DZCLTfSl9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Besides the expected "ref" and "log" records, the reftable library also
writes "obj" records. These are basically a reverse mapping of object
IDs to their respective ref records so that it becomes efficient to
figure out which references point to a specific object. The motivation
for this data structure is the "uploadpack.allowTipSHA1InWant" config,
which allows a client to fetch any object by its hash that has a ref
pointing to it.

This reverse index is not used by Git at all though, and the expectation
is that most hosters nowadays use "uploadpack.allowAnySHA1InWant". It
may thus be preferable for many users to disable writing these optional
object indices altogether to safe some precious disk space.

Add a new config "reftable.indexObjects" that allows the user to disable
the object index altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt |  6 +++
 refs/reftable-backend.c           |  2 +
 t/t0613-reftable-write-options.sh | 69 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index 2374be71d7..68083876fa 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -30,3 +30,9 @@ A maximum of `65535` restart points per block is supporte=
d.
 +
 The default value is to create restart points every 16 records. A value of=
 `0`
 will use the default value.
+
+reftable.indexObjects::
+	Whether the reftable backend shall write object blocks. Object blocks
+	are a reverse mapping of object ID to the references pointing to them.
++
+The default value is `true`.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a2880aabce..5ffb36770a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -245,6 +245,8 @@ static int reftable_be_config(const char *var, const ch=
ar *value,
 		if (restart_interval > UINT16_MAX)
 			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
 		opts->restart_interval =3D restart_interval;
+	} else if (!strcmp(var, "reftable.indexobjects")) {
+		opts->skip_index_objects =3D !git_config_bool(var, value);
 	}
=20
 	return 0;
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-opt=
ions.sh
index e0a5b26f58..e2708e11d5 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -214,4 +214,73 @@ test_expect_success 'restart interval exceeding maximu=
m supported interval' '
 	)
 '
=20
+test_expect_success 'object index gets written by default with ref index' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 5)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.blockSize=3D100 pack-refs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 95
+		    restarts: 1
+		  - length: 71
+		    restarts: 1
+		  - length: 80
+		    restarts: 1
+		obj:
+		  - length: 11
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'object index can be disabled' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 5)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.blockSize=3D100 -c reftable.indexObjects=3Dfalse pack-re=
fs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 95
+		    restarts: 1
+		  - length: 71
+		    restarts: 1
+		  - length: 80
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.45.GIT


--5Ap+EJ6DZCLTfSl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzNgACgkQVbJhu7ck
PpSLFQ//b6tRi9fTYpebJ8Uzfcj85/6BWoB4Re4S+D8B35yPfuWfLFcvF2Kh6Eth
i/6wR1Uqr+MneQGHSJPeBZe9a3567T7G+9SCd3XO3lEBwvxoxLe0JR77xwhhZf8g
zHuxHCsQVCRqJXwi0JvVEqwQLjhW+wV6fAXAF5YCDYpSO42jtereUG80kG4C4avH
93VtgPINCFNb9DtwH4XS372HX9V++ghx/z2KrzIMyicJWMx/GoVkWFszn/oPrXSh
im0+c0fKSBvc5dO5+Qu754UFl710Sn5esZBMn7f6s6fUDWVAs3nFgBhAWLEYEsQM
OAWb64n2m6u1UEH+q2oVRxJ5L8O+2TCZs7iaVwRQOzdQLjoS9jUJzwDwE7FD8hAQ
nlWSeW2TcJ3V71j7g9XMwy6VtSkBw0xCBkwMicWKZLvI2LVNBnFLk1E0YSOlCkAi
m78JBRNI7eeqQfOPg+vRR9qcO273mjsXTwYBijJU24rkLIIyXufhL/lKjl21hpYU
w1ye4QsmN7jCkJPAny28vd5TFGSnYXEIHnMYEjuuOSIgFoCTUKLumwwyLlFdNbAJ
VHCTVfTyD/INMw318q784q5tz04/BRprd1oHuAMP3HfO5eU9LaTbxsDTl2R+8Ybx
/Slz8g2Y+JSfM5/XlzEbdmNFzj/UJo5SH72MvCVwpriJQLKZEQQ=
=Uj76
-----END PGP SIGNATURE-----

--5Ap+EJ6DZCLTfSl9--
