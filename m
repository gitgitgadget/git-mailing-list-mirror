Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFD3BBE5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508808; cv=none; b=Fsl/TS9rFuEXJvex3YWLL0/bwTk5zKaXQ4BB8ehrR4uBxr7CmtWyWDiPTcyCUOEW5nP9X9DmQrhfEAsVHEPMqSs4JEBFnLWd+c6fjFpZnAXAP5NHf/GloM+VPKcatzZMdhgZGT1zRsZvHjANTDIB1ciMmluhmz/FA2+mxiE6Crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508808; c=relaxed/simple;
	bh=QI26YNJhbOFfDrSze7+Z9uEP8aKbIB9OJ6WFB9SHQWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM8AhAV/DfG+gJdEFr+sPNd6ZCKobhmkuUhdxR/XY5b2HYCt74lIix83sNIZl5dliWoQaHMjyHACOek65Us3j7a2YaPP35RRP/k0iFvaqNijF2g0/vYlSV7CydvVg26vI1rDkWWS1HUoCHf9vsI3UqNSl9F7o57nvFxLPX2hyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iTu9SFvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qts5DIVO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iTu9SFvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qts5DIVO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4F260114ABC4;
	Thu,  1 Aug 2024 06:40:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 06:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508806; x=1722595206; bh=s4emRCgYEO
	/8vstH3IhbBjyi2ymIg9FlBDAHNbKNWxM=; b=iTu9SFvOWqemIA328qWEa3E78D
	gqgAmbUA2cx/oje8/Mo6uOV0Jo6CboOmcyzhtvGnGkXj3e6urK1zsHM0y3pubs6J
	ZHbroiOXulWMsO14CmGKMPyS9ACSoc0mOPvG6AZBALuKTvIr7j+Y1/sFm6IodLY8
	L5nwdNziB5Oi3ooXUXyqKGLiPNnDxAR7XtnnmzXwLs6nh5GlUYMUAbKfWxldz2UI
	CWv+gCyp4p324Uwpo6wa/5QqhND3fkBmueDsZf7iXo5zXItRKNkvThb/bq+fH6sH
	085qsXkB/FUBHwLs6bvIxNDI67VEhVwOifNwl8KIF4H5uaWh7Xm6dGDvnegQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508806; x=1722595206; bh=s4emRCgYEO/8vstH3IhbBjyi2ymI
	g9FlBDAHNbKNWxM=; b=Qts5DIVOMUhdYvFVUn4epVR52g+ud3VuaogMhRaQaBDP
	JLhRLiVy6ytOkrtcW+0rthzcPFxq25aWaV/I7hgvRwIauUBPvw3/3BrGVSxCpgIT
	W8BKqH7kX3aEyJEgqZ3qpL4KoQpiwPyPcJxXx0sLQPzk5Z/UUoxKN355XTp/7ZN0
	DP4R1TG7XDKP0rvVW5pzUWKTQRfwuaW/4zPWoenxY6HObPgSNNMYendgzcspMsZ9
	wneQXfEPNKGHRNbcW5lK1B5pUJfa1mD1HGzZi1ikvlnE227Fw0lWOQC7JYM5U4mc
	g1fP9Kp+heg/lg2cUHkyoytQkY5s18nFuMe7jorNZQ==
X-ME-Sender: <xms:BmarZlrgMjn1h9ZwU70ejFtCspERe5Z07dfO4WuyTFfLER58NUNdXg>
    <xme:BmarZnp-KDd6x2uP38Fl_FbU4y_JrMx-gHTVtDbAIXxnkbB81oFS-cyNxB9qhIlde
    JY02P104FOkC_vR5Q>
X-ME-Received: <xmr:BmarZiPOtznRv1TUJeiEtsVwgxOYwqsD7-Gm9YXiao6JxcVXBUGwrS3rtPfxJvKs7bXYJs74l5f9nmAthdhleN4UIre-lNw5RpUSo4x9pGOQIC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BmarZg6jnV0VkrRHzf8qnG0N99Ty2Q_eGESglViOdBDmwfjOovaiQQ>
    <xmx:BmarZk7FyC3GOyZLzPSVtMe_TQaoBe6wngHtvISk9sdnr9rhS2jMVQ>
    <xmx:BmarZoiyjujP4spSLz33MQwHSuUG2uiXLqwys-pVqieQ5dl6-xOCXA>
    <xmx:BmarZm7FJTEGQIR6S74ssYSSgF9yn_qU1rq4P_DHIumLmT8nKEyDUQ>
    <xmx:BmarZuQGT7Sc25hMlaWRlJfi9W0y0LvZSNNOwg5rKUinCKzNwPAZxD8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 617d6062 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:33 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 09/24] builtin/ls-remote: fix leaking `pattern` strings
Message-ID: <4330c80905805d51439006e15c64d672ba376291.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EzDVvrkvhkiBTniX"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--EzDVvrkvhkiBTniX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Users can pass patterns to git-ls-remote(1), which allows them to filter
the list of printed references. We assemble those patterns into an array
and prefix them with "*/", but never free either the array nor the
allocated strings.

Refactor the code to use a `struct strvec` instead of manually tracking
the strings in an array. Like this, we can easily use `strvec_clear()`
to release both the vector and the contained string for us, plugging the
leak.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-remote.c          | 24 ++++++++++--------------
 t/t5535-fetch-push-symref.sh |  1 +
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index debf2d4f88..5b61af5d78 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -19,17 +19,16 @@ static const char * const ls_remote_usage[] =3D {
  * Is there one among the list of patterns that match the tail part
  * of the path?
  */
-static int tail_match(const char **pattern, const char *path)
+static int tail_match(const struct strvec *pattern, const char *path)
 {
-	const char *p;
 	char *pathbuf;
=20
-	if (!pattern)
+	if (!pattern->nr)
 		return 1; /* no restriction */
=20
 	pathbuf =3D xstrfmt("/%s", path);
-	while ((p =3D *(pattern++)) !=3D NULL) {
-		if (!wildmatch(p, pathbuf, 0)) {
+	for (size_t i =3D 0; i < pattern->nr; i++) {
+		if (!wildmatch(pattern->v[i], pathbuf, 0)) {
 			free(pathbuf);
 			return 1;
 		}
@@ -47,7 +46,7 @@ int cmd_ls_remote(int argc, const char **argv, const char=
 *prefix)
 	int status =3D 0;
 	int show_symref_target =3D 0;
 	const char *uploadpack =3D NULL;
-	const char **pattern =3D NULL;
+	struct strvec pattern =3D STRVEC_INIT;
 	struct transport_ls_refs_options transport_options =3D
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int i;
@@ -93,13 +92,8 @@ int cmd_ls_remote(int argc, const char **argv, const cha=
r *prefix)
=20
 	packet_trace_identity("ls-remote");
=20
-	if (argc > 1) {
-		int i;
-		CALLOC_ARRAY(pattern, argc);
-		for (i =3D 1; i < argc; i++) {
-			pattern[i - 1] =3D xstrfmt("*/%s", argv[i]);
-		}
-	}
+	for (int i =3D 1; i < argc; i++)
+		strvec_pushf(&pattern, "*/%s", argv[i]);
=20
 	if (flags & REF_TAGS)
 		strvec_push(&transport_options.ref_prefixes, "refs/tags/");
@@ -136,7 +130,7 @@ int cmd_ls_remote(int argc, const char **argv, const ch=
ar *prefix)
 		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
 			continue;
-		if (!tail_match(pattern, ref->name))
+		if (!tail_match(&pattern, ref->name))
 			continue;
 		item =3D ref_array_push(&ref_array, ref->name, &ref->old_oid);
 		item->symref =3D xstrdup_or_null(ref->symref);
@@ -158,5 +152,7 @@ int cmd_ls_remote(int argc, const char **argv, const ch=
ar *prefix)
 	if (transport_disconnect(transport))
 		status =3D 1;
 	transport_ls_refs_options_release(&transport_options);
+
+	strvec_clear(&pattern);
 	return status;
 }
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index e8f6d233ff..7122af7fdb 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'avoiding conflicting update through symref aliasing'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.dirty


--EzDVvrkvhkiBTniX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZgEACgkQVbJhu7ck
PpQqdhAAqJIU1ZzulKL97oHyd36XShFafIzcOExXjsWW42IqM2Bk7jWYke5XDUOs
LC3LpqDYbMJCS+cayXbuKk4Zv945C8Io57dI+9mDm6j8jKFv1toSRvkN9GPdPYI+
bYk0cYeLBsA3pwRKYlzU9zOoN9OEDh7mzlbEcoY6zALYNVpVY7IEKzJ4hlG/EBXf
1rHoeeHESphRB0Qfdgl7U7pWMQStXyfEe8Z8V7rFYSuAX0ep5UCLS/Z3Q4jaWNyC
sIbllak3ZRY+Tyu3UM59BeATdxFXySzVrtzgBfF05jCZWVPGpJfMBmvizMkTCMlH
Xl/fFVH9PWeqYgsVj/jhiGklkgOACORqs44ryDycsI77j/uH/6Tx/2o7lrgRgtux
ehiVUDiaWmG6ePz4f9L8EVmOkEuWRTw3fsWU5jzQLWqeQkeKM8YoxBkKMIiaK+L+
XZ9RVaHcaYTd8sRYErfx3kSDw1p5BU3ey5Qo5saG2No4jHtjXRi6DcW+3L69HRTC
6TF/xrUub1mPt+PAMUjM7QaZmJc7aHDxmTgpYl8Z2XR/WR0yN5Qf1HuKGZetUKXK
feq/82C4WEsQRUATPSdGCs/zPhnh74Z1MOriZo2DLBBrMEsSAQA8DrnSNJKoQLMZ
1QdLvpHk2IRf3jY9QnNbcjPD39S8zi7jeUYR/sCEwN+073+aQhc=
=u7c1
-----END PGP SIGNATURE-----

--EzDVvrkvhkiBTniX--
