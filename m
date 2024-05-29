Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F9142E68
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986666; cv=none; b=SJvDQT+pE632kTvzOze6GedUyco2AyPIp1xdWcps6F9Jq4JoPoUfWrRQtKuVYUzOUJsH+E5OxAUFXP4h4OrzjpJfn5ks+zJJk8j1fztAKHrP09gXavEq9Buai19RLiqJYBBKSpyI10C+bOyWDrVB5xXpk7wv6t6vLDEtyO60tC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986666; c=relaxed/simple;
	bh=rKaIK9SF6RCjhLVg6wsjmclMnzbnCXo618tT75JsNgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff2fMSwmoNWodPkeiMAwXNXk2+5Zp1WNSwsRnrhV90XHbHmlesjKtDtU40Z8lQP3mDzRzSfuyNwBYucWineSdLy3Ifq7N0C03A737XIK9hv1jdSjbMQM+Jtpwl8yWr+rgLnnwbSaxgvVFSnXKNumw0FuXiaQaP561i/S1u0mSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=beEeazLD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KW4xufu+; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="beEeazLD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KW4xufu+"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8A5201800121;
	Wed, 29 May 2024 08:44:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 08:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986664; x=1717073064; bh=ARaraX1D0e
	NfY+Ts7uFPmDwPjhbjt3rSZWXSsuTb9ds=; b=beEeazLDIBG9JHB6yEi2iJhqdb
	vATNx1lsK2CU60ZcxnvaIGxvENfwRuoKLsKAWJi2t9uNN/+hOg/d+IyDhPmYcdgm
	raEcKd3fvPb4S9IQJWt0jUcBvNO7+dYqhNcE2AuJJ8VgdSuUxkBzSIb2ha0RY+TI
	4JY6zaqxZ2mRX7UBGCtCDXCutdi0cnVEe4xlpffIJk2nvb6hRx5qSaRXLKYvLCKT
	ctGVWJBspZ7XReqKOn1tbbO0uWvMx27ZFYRHNIbECnE6TnSgsoKywrjBEhaYkIgx
	CI/EGrh2GsvjTxPFdE47gCHlEo5Emy5DQ0iLfqcTySOMXClg5/89Va/PaFrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986664; x=1717073064; bh=ARaraX1D0eNfY+Ts7uFPmDwPjhbj
	t3rSZWXSsuTb9ds=; b=KW4xufu+dEvBf1qvmwgtxbgV/6iik1VQCiMEHYCoF9Mn
	SPUnrLIsYPUKgmGdurJKik1UFciGgsDvjYd0pZsB9MrpbK6mKYlhnc1DrE9OGlT+
	d0ahdQKI2//bjTuQGhksrubr6OYJmaeWqgFTcBGRYfsh3UHufGCCFYc2w3bjuTje
	MLhY9CS6FwzsdJdAzdVms4+Oeur98HLYd+LLeAZioCAXRumJlVen8GXy38sL5oBz
	ZqkCwokoson7fX6I3QTfTHvxV9SX2LNB7oL7owWUPts7oIxQKDlAYkVXbNZu6IyE
	XUF/Nhf6M8uL0Ju67mqx8cnyGfk3/727KvIWhA0GTA==
X-ME-Sender: <xms:KCNXZlIrc12hJfWeRSysSDzTmbkuDC2XF67KJmAfzCfRVw1fqG_BUg>
    <xme:KCNXZhI6g5ZFf5cMccOQ8SrRUyWQILYblj__KwDQQ4AzyBfrrqUOwiCr4tHJz82DL
    gWipVbGBW1GRjYQbg>
X-ME-Received: <xmr:KCNXZts9BBiFV-0Bss3X3lwa8SKC4Feh37HbdTFGYcceO5fM3vpEJ-lPdfM60if-A7RwBlg2dlyG_smjsCRgHkbn5SV4Qv2JDkw0QyJf5z89e_GI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KCNXZmaEKD6WH2tr3Ft4aAJ3RRS4UlmGDD43BOIObWrQZz8eaZMhNA>
    <xmx:KCNXZsbHf5yM2rPkl_-ZY6-tJN1ZVqlzkhygjkgmRTnA3W2ql2TVeg>
    <xmx:KCNXZqCPUs-FAWqrsPGvYZlMM9zx_3uRD3Mv582qxb-RjbhVrJ_PQg>
    <xmx:KCNXZqZ4Tg2t_vjOZF8TwBsG-axsT84AZYg5Gb9bxTbbeqGZyQXDtw>
    <xmx:KCNXZrnH9R8QsEgd3V3LU62kVeAzIE1otrT35jzUeTWGOOwxXyyr1h8j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1ccf6f59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:09 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 04/19] compat/win32: fix const-correctness with string
 constants
Message-ID: <ba50e49f8640b5c8a175f740dd035a1e63faa410.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQZfoWcN16Q8kUMG"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--fQZfoWcN16Q8kUMG
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


--fQZfoWcN16Q8kUMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIyQACgkQVbJhu7ck
PpR2zA/+Kx+cs4wYVoOhLVlijVztKc6qDHeStfZysTdx2KZfFtH/KsVQzyGLYZEI
ryYjQQIPVla5Xb/8jMHo8+55ZQGkaFfMaatYRtLVJgQAKtSNfvmtSvOjIrwcKLs7
ie27EXdmOtX5S+1+MRc0rWkgQs0dByse8EDywdOKT26flYLKgpezVrvDZkstBMBW
8cUInCRl7w/QGA3DUWQTzYo6Yawrqe0yjIi2sD0TGGSIVcQ37o56w3iooFXfraI8
2WI7U8QHfjvkfIVCRRPHa8w4eb4rRgY5+uAkwM8ox7JT+Wocc7sAHQNGgtI/0LNB
i3XnkI6Qze0K6LO7UwkkoGQX3QvLL/dy7OL+XvubyGERRwqa/QTC0dscfGl/Scoa
m+eWLooa7B8cI+Oh5pbIPElYrMRN49MxVx0PAmp1+3WZap6aeJqw8AaJ4pQzCgvr
z8xeQ6F8UmSIXh+b/Y9dVNu0lj1GRzf+/Iv6P4th/cEdButrqm3h1FYjNDZsWVsv
tHHL96F+5SwPOKcOYgb3ByGLWREHkQkaCs+JGXk2gZ/CZHbsYAIeD6V8ANT5Kdmc
nGdoZWEylOld2T3/NP5B25kEEL4hily3BVd3Z71cbfnzKw+eLMYlSZTarcPCDZLD
eiZxDSxtxk3rR5t0l01wEYZHaOlIT3a2z+fk7FSNA/FeDwmdLbA=
=w6LR
-----END PGP SIGNATURE-----

--fQZfoWcN16Q8kUMG--
