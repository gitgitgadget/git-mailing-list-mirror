Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4B12BF0C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817037; cv=none; b=db8nkkkWIWhESf/Z+tx/5Zf5uGAPKVU3lm8SkREquBcqGO2TYK3MZzvfkDeSwLEAlxcSu0im5fgy767CAqAxeqF/1lQaz7O2cuSIttN1CX+DSQ+/VXju6fXZ63mf2p5rPF08gDkxO1SU+IlryhVpGyFzREyPt9v6M7X4kshl6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817037; c=relaxed/simple;
	bh=YVADI5Qa51df0Ls90zRtIWOQ3GhtQDwjYiEBBYj5z3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhoBsZZ09vosEtFCgXcx7yUzeqniKbBtRoAY1h7JI+IVKL06+LbXcW37g4dLUur+4i1FlKT8FBVkC+2mgf1OMYHTgBaoYB7xwxBBFsm6fLFuIBiGaciZVJyhh8Z4dnbui4IwuQTnXh7NAieLEk9jVtuiV1f59spfmYwCLIStOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VyxX5IVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B22NQk4p; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VyxX5IVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B22NQk4p"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 81D1D1C00096;
	Thu,  7 Mar 2024 08:10:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 08:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709817034; x=1709903434; bh=QMdmn9bbUr
	GmtfXx5ygVhh0H43/8YTpa8YuUplshwZw=; b=VyxX5IVuxsQJwL+afRPIaOIwCb
	czjE0TROOmWcHUJZo7nIUKkrkLZ7c48W8p3rOQBszIScYeczLk3zAJfb6g5W30Oa
	7rkpb3yic2qnLkP9n/vcMrLOmcozZYauHsVSirvLt1YZ+xA/3bnXewmLuFgNbH22
	buIwmUg5ROW8hs15UUZcsqqvz4wsW49/Y9Nyty7eiOpCIIZV3j1EWsoIwfGs0qOK
	vyoB9pOGpwxebQibIAl9kUVy2MGD9Y8NN/W2YnS2ERJLjcu5j7W5WN+38JMz/60/
	CK8OiPnA/UwJaO5536MhoGUA5CNMlLytgvzk7N9wkQBqj34ySP/chgBx0cTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709817034; x=1709903434; bh=QMdmn9bbUrGmtfXx5ygVhh0H43/8
	YTpa8YuUplshwZw=; b=B22NQk4pDm8mt9NdezycTIvnaioEwzTLU/pVj02LmlJp
	St7Pyyd4EcktZyqDeJnR09w4MEJR/MVaGTurwwZK+Z3WLzi1088aFbX37kDQvm/r
	lwb8PIU2mF8MBLjY9RLIz44BWQ6eygmIZ6xjK5h6FPc4HEcuQvcfvJ7lhAFkr9oR
	Kh5rcUwmJ2pzQ9RzGxYZPc98zPUG2RZmeUv1+u3VEMHit7mkPuVtWkxA3gQowbia
	YZaLsP+v2GViTnvaJfrhr9shv8la4/aMu+mg0j9DcDEkW7vpNvXwMrQg9PBH9jPC
	NY05r5c6qYJujdyZgqqjm5vNtaY/BpAf8Ira0OjsEQ==
X-ME-Sender: <xms:ybzpZQkFwnjKJb_3JpjctBW3TI6btr1pHH3OYuRqZD4p1ss6GPRfnw>
    <xme:ybzpZf1WZHXrJQ1hVTKqQb1D2DtpaF1Jlt2zGwdcAjO23K6UhP6lPlD8dbBqyC5Rv
    IJsewnRxuS_3DeF1w>
X-ME-Received: <xmr:ybzpZeqvfLAk0O_lI9vU_DBYX_dCD5OTe8cdggEWzYfEzUaPP228LKsgAJsGCcTjfVP1bOxVE3nGl_3rBWZ8uYVmWRBad4sjuPG0NBek8Io4XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ybzpZcmOvoev-neXea59ojmjVv7deZT9wJRVsx6Uk4MzdxQmTObsjw>
    <xmx:ybzpZe0l-yuReCCiF4H_hvdFgcsq75_hyp5XIh1hGc4uX0-3cFUGvQ>
    <xmx:ybzpZTuwZFtLWiRy5SP56iD7GPLthMTbN7-OyZEl1X6zpw_M-d4XWQ>
    <xmx:yrzpZRQ7_pmBhf2RDwKghpazujM801hz2-GhKxegzpCmJNCLSkG3SjN35Dc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 08:10:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0fc82b28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 13:06:01 +0000 (UTC)
Date: Thu, 7 Mar 2024 14:10:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] lockfile: report when rollback fails
Message-ID: <782e96a678346bbdfca51ebcb4514307de84b882.1709816483.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
 <cover.1709816483.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VfUJQ51BRjEiKmSS"
Content-Disposition: inline
In-Reply-To: <cover.1709816483.git.ps@pks.im>


--VfUJQ51BRjEiKmSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not report to the caller when rolling back a lockfile fails, which
will be needed by the reftable compaction logic in a subsequent commit.
It also cannot really report on all errors because the function calls
`delete_tempfile()`, which doesn't return an error either.

Refactor the code so that both `delete_tempfile()` and
`rollback_lock_file()` return an error code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 lockfile.h |  6 +++---
 tempfile.c | 21 +++++++++++++--------
 tempfile.h |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index 90af4e66b2..1bb9926497 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -321,11 +321,11 @@ static inline int commit_lock_file_to(struct lock_fil=
e *lk, const char *path)
  * Roll back `lk`: close the file descriptor and/or file pointer and
  * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
  * for a `lock_file` object that has already been committed or rolled
- * back.
+ * back. No error will be returned in this case.
  */
-static inline void rollback_lock_file(struct lock_file *lk)
+static inline int rollback_lock_file(struct lock_file *lk)
 {
-	delete_tempfile(&lk->tempfile);
+	return delete_tempfile(&lk->tempfile);
 }
=20
 #endif /* LOCKFILE_H */
diff --git a/tempfile.c b/tempfile.c
index ecdebf1afb..ed88cf8431 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -50,15 +50,17 @@
=20
 static VOLATILE_LIST_HEAD(tempfile_list);
=20
-static void remove_template_directory(struct tempfile *tempfile,
+static int remove_template_directory(struct tempfile *tempfile,
 				      int in_signal_handler)
 {
 	if (tempfile->directory) {
 		if (in_signal_handler)
-			rmdir(tempfile->directory);
+			return rmdir(tempfile->directory);
 		else
-			rmdir_or_warn(tempfile->directory);
+			return rmdir_or_warn(tempfile->directory);
 	}
+
+	return 0;
 }
=20
 static void remove_tempfiles(int in_signal_handler)
@@ -353,16 +355,19 @@ int rename_tempfile(struct tempfile **tempfile_p, con=
st char *path)
 	return 0;
 }
=20
-void delete_tempfile(struct tempfile **tempfile_p)
+int delete_tempfile(struct tempfile **tempfile_p)
 {
 	struct tempfile *tempfile =3D *tempfile_p;
+	int err =3D 0;
=20
 	if (!is_tempfile_active(tempfile))
-		return;
+		return 0;
=20
-	close_tempfile_gently(tempfile);
-	unlink_or_warn(tempfile->filename.buf);
-	remove_template_directory(tempfile, 0);
+	err |=3D close_tempfile_gently(tempfile);
+	err |=3D unlink_or_warn(tempfile->filename.buf);
+	err |=3D remove_template_directory(tempfile, 0);
 	deactivate_tempfile(tempfile);
 	*tempfile_p =3D NULL;
+
+	return err ? -1 : 0;
 }
diff --git a/tempfile.h b/tempfile.h
index d0413af733..2d2ae5b657 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -269,7 +269,7 @@ int reopen_tempfile(struct tempfile *tempfile);
  * `delete_tempfile()` for a `tempfile` object that has already been
  * deleted or renamed.
  */
-void delete_tempfile(struct tempfile **tempfile_p);
+int delete_tempfile(struct tempfile **tempfile_p);
=20
 /*
  * Close the file descriptor and/or file pointer if they are still
--=20
2.44.0


--VfUJQ51BRjEiKmSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpvMYACgkQVbJhu7ck
PpQ8bQ/+O+xet2vOerVfbnIKwGbH1OfXiZxYwoDkmgMEZnOriz5pRRZAF7e4J3WQ
wCb6BQTtOEu6+Po5Z/m0c9CPNmuLQfeeYCxaMmDVF38B9AKxBGm4V9/OlYmk1A/6
h9DEkSVNQXnMXEDhsYDgt3X6vwQyfA+BmD1q9gjmRlCqfb/bRGKRIMQRWs6de9d+
QcBQZQ6jDbK0JtwrntDPADd4Bw3CWQjY7k4GXzXqBQTlPHkvf5Ye5YEXohcA1xda
OV5ExOwlD0q35NK0aeb15Ai2MLCXu8OytWJoJzgrLAGBtsC0Qflp5qtalvroOKnA
fl8ZaKzayhccpUmKwYbUOJ4+WPb1dGGe62Feets/VWZMTIFXP5xJucGY32w8KyGk
v84vRQ2Db/vFZAuMkJ/CT6jkkt2jZy6Mzbdz58BYEglMYX3c6GSHUAgo7SRvj5oL
TtlMu4/M0MjAg0JvnreIUjrwR6Kymz0e+6iQd/exqNLXYCvVs8L5xudvsYGdNRDd
RFgxt1vcPz5bCK0cglGtGZ+UJFumnlG77zyMUrseB2HICObhbXfo+GmNvehjWlfp
kuSJWUodWCkDDz4xQckxz0Cc0ECdeCeP8Q3cYHHOnlQFYASMDaNpu2CHfbXQUDef
ksh2VfiFCBzzUXfdgAuH+3KnzdkSuX8JUOb8RS3VNvfB7K0oqfs=
=tjTd
-----END PGP SIGNATURE-----

--VfUJQ51BRjEiKmSS--
