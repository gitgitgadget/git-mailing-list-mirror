Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599318146A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361009; cv=none; b=BjFF3gSiPK17HdScl56mlBtC0TsfwBcX3qfIfUM5UdxO3cq4cVZESscAnZo1jtj8ubPWvBo8Okkrl3qHj1PY+IG11TAhh5+nVhWGIdNFgW4HE/SvmpJ9o7iX+bODojxMre7caLWnx9KgJsnnkvXBzJ65owJRfCWTYVtDqMnIClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361009; c=relaxed/simple;
	bh=pQoREen2kvlD/nI8e2OFfxMWKqRQL+IDn2OQcypuvck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYvzUCuMMIEZYKOvBJCDSmkSoEaYgIs+pTm+704Vqn1DP6pKc+TagylqxVBoHzRv8G2In9VH2AgcuggqhESUacRcpYkz2J9++3wOOuxiH9IGemwsFjos0O58ianH6B1cs/IMRwCfcCpXwK6AYbcqQyfSZUJFVOIa92tnCuusAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IAdGY1vq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIgUGUh+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IAdGY1vq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIgUGUh+"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5861F13800AD;
	Mon, 25 Mar 2024 06:03:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 06:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361007; x=1711447407; bh=6ByXzITrTv
	ztJ1YR40SpTZ0kfsGPNzO+iVqLYGasWU0=; b=IAdGY1vq2i1Lb760ZrOr/PvC4r
	7rF6gG8sLqSFJmrHMfCd3hpwztOCWScpA42DEyqFuNad37VqmSLutQ91Swnox6wV
	GhIA+2ejfWTPMsvNBwbDckGhj8GbZAef1fm5kT4XT/La1q4L2+GzW5LVShxs3B53
	5Y8rHlUwHdzlCrehYnCfj3ttQDNePPVVw1rshks3C1iHQSeKPfaFCg8s2IR3WbRg
	X4isedz+FktEo8jBRbUFph3hgtssINW/VmvuX0iqSXbwLbtV4PJtSsZysSgqyEiE
	i1PKP0t5ppL/g4z2JTJnc3YRMTFsFaFyUy/AFQak2knPm0huf/2dYGQDIUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361007; x=1711447407; bh=6ByXzITrTvztJ1YR40SpTZ0kfsGP
	NzO+iVqLYGasWU0=; b=oIgUGUh+VAkOyGwNpyMw/KP1pxSGxCU9j3odNFeZv+Nb
	hOu+M/hHmSpG9YuJKhT9nr5QwS51wjBOUCU4TK8ETE2TW71IJfqg42aQkqx69hPw
	AgDd+ybVA0dDWnGIQ04YmnPxFSefNMJss5/FKKwhXX4b5uke6ZwW9hxzfqRUCSRZ
	+uR43osFGddoGKDc4Bcje1LTbbyWUh38S5h8YLf1w1l+CnpuRUqwLxFVhaOZWyaB
	OSOkN7MDIAvTExiL54aiZychR3dJlFJ6aLkL9cIV2pTNcKmCg7X37yaMgNAfHGNb
	3iP0zzv7YRlfyzHCjFsefi1c2Qp4u4aLKayYYHyx0g==
X-ME-Sender: <xms:70sBZn3saYkMZHtSdimRmOQtcy3aTyiBu4DEgDkcnLvRp4H_3ig_yw>
    <xme:70sBZmEbxF3mVFIDXJ5BTW5_FU978xWLrm2GQUzaHefPsBzTnZ08rc43lHlwFIsJb
    5Mxh_xtrWa4PEm8Zw>
X-ME-Received: <xmr:70sBZn4m5W9mOPvFAT6gLHaX7Z-Gl4iXd2uujMvX1Zg_zDOv93f-PKJEck9G7VYQ-Oa9hxwtu2BBI98sPgaEf6fGLLPPtBE-E6diowRTK6bIUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:70sBZs0DMorXjRgj8geCN6Zn67o7p10L1zeAfsHzRChBAqGcbxwApA>
    <xmx:70sBZqGQ9Ukyt5X45v-wnD4HoB_arx9NmGT30DnmMN8UIKjLA89nOg>
    <xmx:70sBZt_W0ZBsozBLO2PuUTnrO65yi2fQIyCVWjHpgoI95PxXbT1Umg>
    <xmx:70sBZnlolhqMDtsZbWLmnoEJVxZYFmPiZKWS3Zkr2WwMidkV4hn8OQ>
    <xmx:70sBZmgttW0QwGTgTZiFywlyQt92oBAqTdfLnjai7Cb5iByquBZMhg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 111a1590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:16 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 12/15] builtin/gc: move `struct maintenance_run_opts`
Message-ID: <94cb036345230691f802f4afae4e801f74f90ab2.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QiwcBSLCYWe389+r"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--QiwcBSLCYWe389+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to start using `struct maintenance_run_opts` in
`maintenance_task_pack_refs()`. Move its definition up to prepare for
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 53 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb..e0029c88f9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -180,7 +180,32 @@ static void gc_config(void)
 	git_config(git_default_config, NULL);
 }
=20
-struct maintenance_run_opts;
+enum schedule_priority {
+	SCHEDULE_NONE =3D 0,
+	SCHEDULE_WEEKLY =3D 1,
+	SCHEDULE_DAILY =3D 2,
+	SCHEDULE_HOURLY =3D 3,
+};
+
+static enum schedule_priority parse_schedule(const char *value)
+{
+	if (!value)
+		return SCHEDULE_NONE;
+	if (!strcasecmp(value, "hourly"))
+		return SCHEDULE_HOURLY;
+	if (!strcasecmp(value, "daily"))
+		return SCHEDULE_DAILY;
+	if (!strcasecmp(value, "weekly"))
+		return SCHEDULE_WEEKLY;
+	return SCHEDULE_NONE;
+}
+
+struct maintenance_run_opts {
+	int auto_flag;
+	int quiet;
+	enum schedule_priority schedule;
+};
+
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_=
opts *opts)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
@@ -773,26 +798,6 @@ static const char *const builtin_maintenance_run_usage=
[] =3D {
 	NULL
 };
=20
-enum schedule_priority {
-	SCHEDULE_NONE =3D 0,
-	SCHEDULE_WEEKLY =3D 1,
-	SCHEDULE_DAILY =3D 2,
-	SCHEDULE_HOURLY =3D 3,
-};
-
-static enum schedule_priority parse_schedule(const char *value)
-{
-	if (!value)
-		return SCHEDULE_NONE;
-	if (!strcasecmp(value, "hourly"))
-		return SCHEDULE_HOURLY;
-	if (!strcasecmp(value, "daily"))
-		return SCHEDULE_DAILY;
-	if (!strcasecmp(value, "weekly"))
-		return SCHEDULE_WEEKLY;
-	return SCHEDULE_NONE;
-}
-
 static int maintenance_opt_schedule(const struct option *opt, const char *=
arg,
 				    int unset)
 {
@@ -809,12 +814,6 @@ static int maintenance_opt_schedule(const struct optio=
n *opt, const char *arg,
 	return 0;
 }
=20
-struct maintenance_run_opts {
-	int auto_flag;
-	int quiet;
-	enum schedule_priority schedule;
-};
-
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
=20
--=20
2.44.GIT


--QiwcBSLCYWe389+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS+sACgkQVbJhu7ck
PpRmcRAAjet0vipOYyGzs1JxGidA/O/netFWfuB7wwt3GPVyiLiW4MwDlNVW/o6A
sT0m2Ik4e+5R4PYy87d8RHdt5Y3U4k5u7cSI+jsBI+eOJoLLQ0YoAl0DAdhDmzAm
w+Eyo4d/ThdkCqBwETaXW6aDGLF6CiRlOyAwuq9Zy/5RCJP18KG3DRXQ2H5GIps7
1+S/XXmgxfxO4y6JH0BZwJ3XUCiieLuDYJmmDqFathgGiWpK2GzWLJYbrjS4EuNE
trlvC1Mq45SKTn+EjnouNygOUvnFmjQEAqUFg+Zo9ZF8Q9BkU+fLtcplpCBHYptK
/4/qAEPrRFF/RFm6664PtHV1BIxXpPDkHf0DvtcdP1XnEnWLuAJkMZQfoyyj7r3J
QF16zZfH27uVg/shNAbVhNsz+VRWDjrfK1hW3LMeP5RCU35LoAKVq/6vOjKtqlO+
seqq4X8+0PryNfcimCIEsKHYR7/jqmBGxjRy2W+P1rqDJivufG6vw3pjDUxRAxbS
x5KkbQZBa2LWc09wlwtEB6CeA5ti/W5a+5BWVjvhSDo8AtXmrqGbFV8++qDCbTK8
wjRJ+LMfLqZRpwNPOgupJdW+3pwX/BXa+MhEhLVgMua0HyTEY1q5TwSEmsYkTiyY
17qnCy55Z1HD7KbWeJyaXxHI99wIvCabLin2U71ej+JKYg3Fxj4=
=QSoe
-----END PGP SIGNATURE-----

--QiwcBSLCYWe389+r--
