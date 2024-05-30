Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5E1474C3
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073455; cv=none; b=bv9jmI+kG8RivL+4jj+gco9AemcRoXb7kJrqlV8GefZSEXT6ixdlEBdzsm1TIuYPHRGoBwi71JZnpSaA3Y+fUANtLv2rEXW5HluD9Qn4iuBdXAPK3NT6bZa8/ReCF/qdsYtbOQ3xhHdy1Ved+SgP1I/WAXdoOK20FfjQ1LKye64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073455; c=relaxed/simple;
	bh=axUNjoo5gPunrXbQrwsVzAOZ8Ef0ee+uBaJz/7QmobA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMhhILw4qybeKg0l/Mjj0Pu9Iokdga1MgOSpDZDIImNFE2OSE+YiaiBW2hbR9pa7UdIsHWYPmPE78SX8KHanV2Ti0qlwTlx27ftlxvV+AdL+96buLLnLkQaPxqSyOlUM+AwXZOnwiZntBJtBwSE6S+Z3otcCFtcwkOWj3EiYQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F37YBxJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMS4Aujk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F37YBxJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMS4Aujk"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CDA5F1140150;
	Thu, 30 May 2024 08:50:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 30 May 2024 08:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073452; x=1717159852; bh=iKNvqJ6y10
	siDBXcSXo0C4hKFXzFEmSeb/UMLZyHeCc=; b=F37YBxJ9rVYf2+yZzlxA6+MQF7
	yAI819OmlxnC5H/0nay3IH/EAgiLFahGM78IRPwp4gUXxK3RcpZUz1zzDxNNi7+L
	1PBg+nAAklbgxslTCLPVg+pHBT6qmXCe6ARjSKotHf1ajXr50Bb7OTh52wXIvPBD
	6rzeQAsXDGro+JLFKX83YIKp2p+zNd3YRs7zkSRqmT7tEsPazwUk4k3lxc6alaww
	QhzB15x5KG+HtQu42Pz7v0AcNBoJUvOp8VSnsq1dScRkbTyY0wVKS//b/cC6Q0VR
	nSTPVOuihJSWNdE7e3jO19fU7T7+VF7ls1LLb43tmiIehsJGo3D1onH9GsIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073452; x=1717159852; bh=iKNvqJ6y10siDBXcSXo0C4hKFXzF
	EmSeb/UMLZyHeCc=; b=KMS4AujkURozXc3nxIzRlct/EaEynhEcEiAaYo2Udp2V
	3x30u1Sgh/Ktq0K4J51koYvp4i0xnNwrsyTw5RNj4P7FK/cJH1ilNiATLclMp2QI
	qWTEthr+Nzr6b9oc6EXk3ebbGlyNMR9tqPkoZ7shVV7NkNUFALS7LNQWazbbj1SD
	/nhxryJx2/30OTK8OK6ivcdaFevRBj6/Fn3dw5c+aAVQoY7sZKRPfT5nyiTx+LJs
	3bhUAb92srn0mLw5ZYIY/x7XHvqpidaizkRwENgE4TMtyU8KYAYWh6iaWaToiVgZ
	3hunUaY4RPmA+udICUJbi8dFYQ72kZUg9Bc8aVMldA==
X-ME-Sender: <xms:LHZYZhZ43g62jKgmmyzNnvBEMuh_X7lnQMWrup9AV5J543UvsvNhLg>
    <xme:LHZYZoYB20Q3WVcUg-V3DDU3KKrk41Vxryf6hdagJZ4Ze-jwjImOsxlC5oQ57mXSi
    7w9V1U2jpX6V0LMpQ>
X-ME-Received: <xmr:LHZYZj9ihqf4t71O40oKTfuhazG9nhhKHEuj_LHE9Ds6LfMas8PsIjeUfafTXhscjmQMq21FhdXMrPx0NS62PKUWVGM_a1Cn2QShe7jdtXVihfFZxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LHZYZvrac4ltGhkdTru7kMHRJhFt38dNUeW63rfGwYHt3Qnn-ThOlg>
    <xmx:LHZYZsqczIOhauQRx9rrQuNluDTeOFWkPCyKv7tNbEcLj-_L_7JzjA>
    <xmx:LHZYZlTaGiqS0t_M1puLVxVVdGazmUogURsjdFfeTyTTT4HLfkRHyg>
    <xmx:LHZYZkr_o518w7OSJFd30fbfKVWW1cjGZZEMJ7JiOfbbQAur6PNyiQ>
    <xmx:LHZYZnW23LrG8cvW2vQbANmG55lRyy25duwXLnE3fZ5lRwDjWj554zUq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:50:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d36737b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:35 +0000 (UTC)
Date: Thu, 30 May 2024 14:50:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/19] compat/win32: fix const-correctness with string
 constants
Message-ID: <961b3357d57296cb236c3832e1823ed44320a44c.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4C9Ub2GqtdH+iA6"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--y4C9Ub2GqtdH+iA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adjust various places in our Win32 compatibility layer where we are not
assigning string constants to `const char *` variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/basename.c | 15 +++++++++++++--
 compat/mingw.c    | 25 +++++++++++++------------
 compat/winansi.c  |  2 +-
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index 96bd9533b4..c3c9d65fac 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,6 +1,13 @@
 #include "../git-compat-util.h"
 #include "../strbuf.h"
=20
+/*
+ * Both basename(3P) and dirname(3P) are mis-specified because they return=
 a
+ * non-constant pointer even though it is specified that they may return a
+ * pointer to internal memory. This variable here is a result of that.
+ */
+static char current_directory[] =3D ".";
+
 /* Adapted from libiberty's basename.c.  */
 char *gitbasename (char *path)
 {
@@ -10,7 +17,7 @@ char *gitbasename (char *path)
 		skip_dos_drive_prefix(&path);
=20
 	if (!path || !*path)
-		return ".";
+		return current_directory;
=20
 	for (base =3D path; *path; path++) {
 		if (!is_dir_sep(*path))
@@ -33,8 +40,12 @@ char *gitdirname(char *path)
 	char *p =3D path, *slash =3D NULL, c;
 	int dos_drive_prefix;
=20
+	/*
+	 * Same here, dirname(3P) is broken because it returns a non-constant
+	 * pointer that may point to internal memory.
+	 */
 	if (!p)
-		return ".";
+		return current_directory;
=20
 	if ((dos_drive_prefix =3D skip_dos_drive_prefix(&p)) && !*p)
 		goto dot;
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b06ea540f..60f0986f76 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2257,6 +2257,7 @@ struct passwd *getpwuid(int uid)
 {
 	static unsigned initialized;
 	static char user_name[100];
+	static char unknown[] =3D "unknown";
 	static struct passwd *p;
 	wchar_t buf[100];
 	DWORD len;
@@ -2279,7 +2280,7 @@ struct passwd *getpwuid(int uid)
 	p->pw_name =3D user_name;
 	p->pw_gecos =3D get_extended_user_info(NameDisplay);
 	if (!p->pw_gecos)
-		p->pw_gecos =3D "unknown";
+		p->pw_gecos =3D unknown;
 	p->pw_dir =3D NULL;
=20
 	initialized =3D 1;
@@ -2800,16 +2801,16 @@ int is_path_owned_by_current_sid(const char *path, =
struct strbuf *report)
 			strbuf_addf(report, "'%s' is on a file system that does "
 				    "not record ownership\n", path);
 		} else if (report) {
-			LPSTR str1, str2, str3, str4, to_free1 =3D NULL,
-			    to_free3 =3D NULL, to_local_free2 =3D NULL,
-			    to_local_free4 =3D NULL;
+			PCSTR str1, str2, str3, str4;
+			LPSTR to_free1 =3D NULL, to_free3 =3D NULL,
+			    to_local_free2 =3D NULL, to_local_free4 =3D NULL;
=20
-			if (user_sid_to_user_name(sid, &str1))
-				to_free1 =3D str1;
+			if (user_sid_to_user_name(sid, &to_free1))
+				str1 =3D to_free1;
 			else
 				str1 =3D "(inconvertible)";
-			if (ConvertSidToStringSidA(sid, &str2))
-				to_local_free2 =3D str2;
+			if (ConvertSidToStringSidA(sid, &to_local_free2))
+				str2 =3D to_local_free2;
 			else
 				str2 =3D "(inconvertible)";
=20
@@ -2822,13 +2823,13 @@ int is_path_owned_by_current_sid(const char *path, =
struct strbuf *report)
 				str4 =3D "(invalid)";
 			} else {
 				if (user_sid_to_user_name(current_user_sid,
-							  &str3))
-					to_free3 =3D str3;
+							  &to_free3))
+					str3 =3D to_free3;
 				else
 					str3 =3D "(inconvertible)";
 				if (ConvertSidToStringSidA(current_user_sid,
-							   &str4))
-					to_local_free4 =3D str4;
+							   &to_local_free4))
+					str4 =3D to_local_free4;
 				else
 					str4 =3D "(inconvertible)";
 			}
diff --git a/compat/winansi.c b/compat/winansi.c
index f83610f684..575813bde8 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -139,7 +139,7 @@ static void write_console(unsigned char *str, size_t le=
n)
 	/* convert utf-8 to utf-16 */
 	int wlen =3D xutftowcsn(wbuf, (char*) str, ARRAY_SIZE(wbuf), len);
 	if (wlen < 0) {
-		wchar_t *err =3D L"[invalid]";
+		const wchar_t *err =3D L"[invalid]";
 		WriteConsoleW(console, err, wcslen(err), &dummy, NULL);
 		return;
 	}
--=20
2.45.1.313.g3a57aa566a.dirty


--y4C9Ub2GqtdH+iA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdigACgkQVbJhu7ck
PpRPNA//fTL/17Lo77PkDzJTwDfA2dj7RzCOl/SaUb+sPsolGojVOAL9P1NcE6qM
UJ3LTYIKeUjpX4cIik2Ag3f56shbjv0kaBsGqjm83k2yekZthdyBtMR2CVDZUwIm
L00KVYONh1Hjy8I6g301OZE+OcxkskAezcWcSBolwWLWGGpwNFUf65Xu3MIwJYV+
2hBJMRdNeuJhMNO/5p4ksBl1gBI0+j7EaUWX67ussiof/E9M0kUGlNQ/lG+ke0d+
dU3yxiCahKdUDZNJytMLfqsBgb8tRvsfu+9lmRL7E/7Wba7/XrDJTvzGKVZhhn3Q
Eed8bVy8oFbZFZwbo5esf/tetgfzXEVlbrSO5XVZhtAy2V1TB24xcEaYcLfvQDY3
ACLfoXB9dLvasoyMwZNJmKaFa+W2bBA0nhgkrxB+/uX6hLtBfpi6SoVYsVdy8b79
zCPWcFcq/tdlRVQr/cICNGx3AQ8Ld8Hds3WOygpi93WUURpgNh4lMoGdAeRttFoA
GIOEY8Dkc3NFMeycWaUZKpO1eLfq4mo2JWbMlE7czkUb1oP0VvgbqZKotD9i1Xh/
3NxncgH4svpyT09tGAuNZe76V5irjRvy6UF39VLVaQ933z/jK5FouFAngmCgVdKf
2w22k+qIhDFACcgLKFHHifgnDRSBFwGnbQpSSriBSzn5vktngZ8=
=CtCN
-----END PGP SIGNATURE-----

--y4C9Ub2GqtdH+iA6--
