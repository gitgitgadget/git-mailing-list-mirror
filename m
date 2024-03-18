Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709C381A4
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759203; cv=none; b=uL0pkvPW/ib9qLuBqb3pCEYLs/ETDSPVZ5VCwO5xHCp1kXLVcw3lUYIjgp+Gb0NsP5RH+I8IW+3FXa3eoLs4nII0VU18qeMsNbZnzhkXOISY4nFRJONU4Cezta30XrUYBJMwvJoQK1E6u00X5RKl9wdi2cBfbs50YPaZruioQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759203; c=relaxed/simple;
	bh=uA9ohyiCQuT2CVly4E0YxGX1OwRJCr7ZIHMd5AItVss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYcm5uEJDfJ09edSts1rtfxDj6RqraW2hwdBCBzKyggXNnYDUxzzSR0tP847KNVpu559ErxeNIp8eZ14dL8m4s+utbUSvfdFzamGUcc04Bfj4uCJmKa5naprejb7mSsIJynmMtXkLOO9MLYtw1fm8FYRc0RLy7PHrkKYTVie840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eyq9/tXL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYu6ZiBH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eyq9/tXL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYu6ZiBH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E20A3114009B;
	Mon, 18 Mar 2024 06:53:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Mar 2024 06:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759200; x=1710845600; bh=bSlEPbwMHZ
	Ywu+ZRrfl3qNrPWEu8vPt88gJuHuIkbus=; b=eyq9/tXL/bq7EoH6ukkyZt7oDD
	ZXwltBC+Vk+Q+4k3Vc+BIZokVec6ZVqJC+NzYF04CneOp/3O3j/DJSbkHDMm1N2I
	a7QRU7jF3zLGyO/d/N2Hb2aB/+TATuvZcvUNNXs7QC/6Yq55SmFqFfSGb2Vl6Yjh
	6oUUGSV+GH+nnofP+AFyYA5yavRfFw9xdAz2Z3eX+n0Q1j6rD/qu7+WuzqX8z2Es
	J+bCAF2hzVixButm1YhSaPeMpeh2uz+plEntkg4hRQDcHwEDuPgeDdCG6zSxCasn
	ZnKzeJpwBiTyMilChTMDb44d0vdOrorT7xAqrSi+SARzFyquL9e7YPMv1mYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759200; x=1710845600; bh=bSlEPbwMHZYwu+ZRrfl3qNrPWEu8
	vPt88gJuHuIkbus=; b=SYu6ZiBHOYHy6YX3d0RtP4sskvKKkkLQzRvmRC3DCVlu
	x54MWWNmf5K90XOne9BClME6xiOoDwiajcJ9cEt8KGiUeXzhwpEjpEZK2hYndNSK
	aAxkSYZ1cMKzZsOeauLygHm5qeK+xVJPGy824zk2hi7WuNXkNn7Ais1k7YdpVztl
	87ocaN0iubYr9CZpkQt1xRH5C8/I7RNYHNWEf+LPUceTtybyeMFZevLos6eg42Nj
	UBC1Mf2EOXJPDB7Cgo1rRxlxYJjmEf14VcZndq4ZDO7ZvHB4SQbLsdRoDqH7r1We
	luAQW2qP9lqlZwEbG9YNc/VVmWv2IGIh6v7lPQjsIw==
X-ME-Sender: <xms:IB34ZToJsLmYCpHs1mbZ4bqUcY-YR-zdi6_tJiVwue3FrdKhD2oiOA>
    <xme:IB34ZdolrE3-sQdIIJzNSHId-KkDfWmKqlSdYlb2LWHLp8OHD2DAs4yC-D4enLLmH
    lsjjnKfVT7nDsfsyA>
X-ME-Received: <xmr:IB34ZQNSpqTtNkaSFcWDj97Z6-Kd9FihX4L1EFT1yzd3DYTiVBgI8Tq_glhKD9K0DtwrMuCUxkp2vABhMZnUmtGbCJ1_GLDapgSV2DP6GfqAWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:IB34ZW4JJwLeUAOjlWV4TK2YziEaJf34lkq9vbnIxkzr0KY1bD-vmg>
    <xmx:IB34ZS6cw05MKfy2n6mlJ5w0sRMjxIBC73A2FFIbHgwoRgJE-qiS_g>
    <xmx:IB34Zehv6aYEuLLNaH0DYuc6qoexJawQGCjp0I26WaZ39wG6I6cKcA>
    <xmx:IB34ZU6nbJh-aJUdLVn7qSrkn_HOHWRXT2ITYrmVQR668s1C2XeZ2g>
    <xmx:IB34ZYnqyKp0mopuLC1t8bjMYDmHvKcBpp3sTFUO_SBEecDHoxcCrA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c39799fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:29 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 12/15] builtin/gc: move `struct maintenance_run_opts`
Message-ID: <65c9ff3ee51c982203e8b76378536958836db7d5.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3/qx6jyaJSTQAk+"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--p3/qx6jyaJSTQAk+
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
2.44.0


--p3/qx6jyaJSTQAk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HR0ACgkQVbJhu7ck
PpSvsA/+IyqIqYw8N3P3JP8id1hh1G3ByazwTXTXKFTxeif/ZR2CZ81/acW9bjvB
aqF5e+tudFq88fwPM2gixJ+0++YeUYj5ucWy/GCU6rcH2M08of2fZ3TpriCmo/xf
nsGIwinXwXCoqGH+imhrSFQTIkiMjJ8w357N7TUPEbbFlS9pz3ZULjCui5ZVFbay
zX/BjmGOwDqRJv5GIeL2v0snQrh5QD2H2oG0fQpNLvwsX8oExulHWXPU3Dxr0e1A
AytJPx589G6FbsE5r4B2d/s8DP3E45zd8j+ix9kCHwn0rDbBmpBSMaTTOxQBtkEQ
W68KrST8pQYvsiW8OsDVPZ8dSs5iLs6nyDoaHu6bgLPEuVcUKKdRkw3wgTOgyl7a
HFra4VEoogPAagY+01Io/R2wjIyMmvINvYG0utpv9ZhgUOCbP/Bq9R6sdk+Q/FL8
Fu9/eW8/JC8r5uQQq+ktX2X0jyoYBvelxGB088MwF/tzUflEgXsrhoTyIeUhMa+w
5oYluZYGH+fPksh54DzaSkpxjLfTMzkUmFIjhLYyaLiPLtYHDtZtfy7w9RWMbd6I
sLeWYrlKJf7LXPveMlN+9MiJ+o1jHK07PkaOMEQBcAR6VKquVo+rT98Lv/d3hsOt
JFrtkI44q6YcKhqMOjITbaO//h3LEKyuv6DgyfpHofoy5hdvIQw=
=GZ/p
-----END PGP SIGNATURE-----

--p3/qx6jyaJSTQAk+--
