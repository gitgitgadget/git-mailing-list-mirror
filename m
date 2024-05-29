Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653394C70
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986706; cv=none; b=XoO5SCMEDFZ7pkkZJwSLGGldTmbAVp/ryLQYRmzwrFQYGtcmwRFBZCLOxDNH+F4k4jRK+6Wbeg4kcfZl+TFl3QkcgPvQUZPMDI3vuNncWCLBtmYOkg+plQxfTfk8ju3u/Agq5OGZA+TRXrcMSh5LTJbHNBY5kljfUvoAW75YfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986706; c=relaxed/simple;
	bh=RXoNTIdRxt4cPojTDi+FdBkjhPiYaryvLuloBAsel1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4ZeZb3a6jH5dF+UuxMn366Wh+AFn6psZIBALMIOK0j7olVyO6oul9YhTuNTfFPJu5bVlkg+M1RnSeyuB26Bvzs13imefjXT7joke8/558upOVelGewr4gt6SUeUIv6WfBDs+/NVq3gdq+UQS71x3qk9CTNweGhwu/u8TBjeQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nCEYo6LN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFRdWf3c; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nCEYo6LN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFRdWf3c"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C1F4C1800124;
	Wed, 29 May 2024 08:45:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 08:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986703; x=1717073103; bh=wL8B1fD134
	7cnd4vWot9bWq5ULmM/mQjkriYBfuZV9E=; b=nCEYo6LNM1anFitFjm2CkTv/5Y
	RbQfCEUl58aTg9p/1NVZrJzfBNn8xyxR+H+WBGFEdqERvU2WBvyXWjIhKFRlMFtR
	dgNgYf+Wgowrz4Ppdd63MwUjlu3JH6UHKZxP+ELRKvZLb/+SZAjrkwnAmZjtQVts
	WHGf/UTm1AQ+hP65WOBjgqt/ZOs+DRS4K8kYb8xX4B8BcmIey/+q593hIuGpvH7v
	kQLymWwKqYnkTVlHWcR5WgK2t5Ba1OmkhPYPCkpCPg/JioK40gXz7Iw0Cleu56zr
	dfQelgQeVAQH7G4VbQRx8wduMX9b4ypChU5EeP/UqhOihvOtGrbi5plEgBEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986703; x=1717073103; bh=wL8B1fD1347cnd4vWot9bWq5ULmM
	/mQjkriYBfuZV9E=; b=MFRdWf3c0aI92MLbxOqug5WTdaCmxMuklCsTw34In3Y5
	/hXmtBCxBmgm0BEJN2C1Fj5sMILpI7BWTafWV/CqDH/j4B/eE/qJDyb9aLmLzjXG
	txozk2EJNSmYspPbMCgTJKs5bFvbWEgeS/SxYjQ0WBZ8HC1B5tnrdT0vASTOOacj
	SibOb6u0ssRcsNHdLrZZuHWYd+1mZ/p5jgFbcntQO+KriSzx2y2R6i3YrRw/i6eo
	EtFnPdYqmVyVFDiaCMlGoNGWesihAdOjB4jAESMC0FcPgIu8GIodXfu0MnTv2hYk
	Yz4Xx7zJVGMO2KEiJmTk9Ib2S3jXo+umA51574doUA==
X-ME-Sender: <xms:TyNXZlx3wL5cVWSaZVQtZlQ7Yw2O5aO63AyejTnpKykPVWHKiqsgeQ>
    <xme:TyNXZlSW9TtnWwM1pD0Z8jiOu5i3D8MY0TuAqaDDh9BVldlDNOb46XO7lEw71R4ZL
    _aOkLl5RTmS6PMLyQ>
X-ME-Received: <xmr:TyNXZvXRcJFIQE9AVZmIOpIcGNngdy-4RteAYzxx4XX-sv4cZWbUbL9qhhjq0EtCr9wSfag0eVY7U2coRts4TGfXhbxR5yM2lvz7VTaTJSuVTIvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:TyNXZnjvapLcklPScrcLWAbQuMAx4JeFb-8P_kmfFOJA2cewqtN_8A>
    <xmx:TyNXZnCKkXnUTPp6VjHC32wQM-iGbYg17q1qVLqHzNJIn5Sbt-vXAg>
    <xmx:TyNXZgIuf8WZ-OcKhOGf71sNPayoBL08QBqVpArHaJX-lfxq9zGqkA>
    <xmx:TyNXZmD08fIUBQMHzZ9B1KikuXK7yOgNR6xw2uF3ekXIyjf6AeFKqA>
    <xmx:TyNXZqN1uV_vYQx6rN1tiCoTD9Z3ubhtamAqMaBIMRd2tnlE9L8RbHoX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 01c0a0c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:47 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 12/19] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <00b4a7dbbcdfd8a0f7b4beb4ecaf272257838460.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzKpHdwp07g6kksP"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--hzKpHdwp07g6kksP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When processing remote options, we split the option line into two by
searching for a space. If there is one, we replace the space with '\0',
otherwise we implicitly assume that the value is "true" and thus assign
a string constant.

As the return value of strchr(3P) weirdly enough is a `char *` even
though it gets a `const char *` as input, the assigned-to variable also
is a non-constant. This is fine though because the argument is in fact
an allocated string, and thus we are allowed to modify it. But this will
break once we enable `-Wwrite-strings`.

Refactor the code stop splitting the fields with '\0' altogether.
Instead, we can pass the length of the option name to `set_option()` and
then use strncmp(3P) instead of strcmp(3P).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote-curl.c | 58 +++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index cae98384da..ac185d4f88 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -58,9 +58,9 @@ struct options {
 static struct options options;
 static struct string_list cas_options =3D STRING_LIST_INIT_DUP;
=20
-static int set_option(const char *name, const char *value)
+static int set_option(const char *name, size_t namelen, const char *value)
 {
-	if (!strcmp(name, "verbosity")) {
+	if (!strncmp(name, "verbosity", namelen)) {
 		char *end;
 		int v =3D strtol(value, &end, 10);
 		if (value =3D=3D end || *end)
@@ -68,7 +68,7 @@ static int set_option(const char *name, const char *value)
 		options.verbosity =3D v;
 		return 0;
 	}
-	else if (!strcmp(name, "progress")) {
+	else if (!strncmp(name, "progress", namelen)) {
 		if (!strcmp(value, "true"))
 			options.progress =3D 1;
 		else if (!strcmp(value, "false"))
@@ -77,7 +77,7 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 0;
 	}
-	else if (!strcmp(name, "depth")) {
+	else if (!strncmp(name, "depth", namelen)) {
 		char *end;
 		unsigned long v =3D strtoul(value, &end, 10);
 		if (value =3D=3D end || *end)
@@ -85,15 +85,15 @@ static int set_option(const char *name, const char *val=
ue)
 		options.depth =3D v;
 		return 0;
 	}
-	else if (!strcmp(name, "deepen-since")) {
+	else if (!strncmp(name, "deepen-since", namelen)) {
 		options.deepen_since =3D xstrdup(value);
 		return 0;
 	}
-	else if (!strcmp(name, "deepen-not")) {
+	else if (!strncmp(name, "deepen-not", namelen)) {
 		string_list_append(&options.deepen_not, value);
 		return 0;
 	}
-	else if (!strcmp(name, "deepen-relative")) {
+	else if (!strncmp(name, "deepen-relative", namelen)) {
 		if (!strcmp(value, "true"))
 			options.deepen_relative =3D 1;
 		else if (!strcmp(value, "false"))
@@ -102,7 +102,7 @@ static int set_option(const char *name, const char *val=
ue)
 			return -1;
 		return 0;
 	}
-	else if (!strcmp(name, "followtags")) {
+	else if (!strncmp(name, "followtags", namelen)) {
 		if (!strcmp(value, "true"))
 			options.followtags =3D 1;
 		else if (!strcmp(value, "false"))
@@ -111,7 +111,7 @@ static int set_option(const char *name, const char *val=
ue)
 			return -1;
 		return 0;
 	}
-	else if (!strcmp(name, "dry-run")) {
+	else if (!strncmp(name, "dry-run", namelen)) {
 		if (!strcmp(value, "true"))
 			options.dry_run =3D 1;
 		else if (!strcmp(value, "false"))
@@ -120,7 +120,7 @@ static int set_option(const char *name, const char *val=
ue)
 			return -1;
 		return 0;
 	}
-	else if (!strcmp(name, "check-connectivity")) {
+	else if (!strncmp(name, "check-connectivity", namelen)) {
 		if (!strcmp(value, "true"))
 			options.check_self_contained_and_connected =3D 1;
 		else if (!strcmp(value, "false"))
@@ -129,7 +129,7 @@ static int set_option(const char *name, const char *val=
ue)
 			return -1;
 		return 0;
 	}
-	else if (!strcmp(name, "cas")) {
+	else if (!strncmp(name, "cas", namelen)) {
 		struct strbuf val =3D STRBUF_INIT;
 		strbuf_addstr(&val, "--force-with-lease=3D");
 		if (*value !=3D '"')
@@ -139,7 +139,7 @@ static int set_option(const char *name, const char *val=
ue)
 		string_list_append(&cas_options, val.buf);
 		strbuf_release(&val);
 		return 0;
-	} else if (!strcmp(name, TRANS_OPT_FORCE_IF_INCLUDES)) {
+	} else if (!strncmp(name, TRANS_OPT_FORCE_IF_INCLUDES, namelen)) {
 		if (!strcmp(value, "true"))
 			options.force_if_includes =3D 1;
 		else if (!strcmp(value, "false"))
@@ -147,7 +147,7 @@ static int set_option(const char *name, const char *val=
ue)
 		else
 			return -1;
 		return 0;
-	} else if (!strcmp(name, "cloning")) {
+	} else if (!strncmp(name, "cloning", namelen)) {
 		if (!strcmp(value, "true"))
 			options.cloning =3D 1;
 		else if (!strcmp(value, "false"))
@@ -155,7 +155,7 @@ static int set_option(const char *name, const char *val=
ue)
 		else
 			return -1;
 		return 0;
-	} else if (!strcmp(name, "update-shallow")) {
+	} else if (!strncmp(name, "update-shallow", namelen)) {
 		if (!strcmp(value, "true"))
 			options.update_shallow =3D 1;
 		else if (!strcmp(value, "false"))
@@ -163,7 +163,7 @@ static int set_option(const char *name, const char *val=
ue)
 		else
 			return -1;
 		return 0;
-	} else if (!strcmp(name, "pushcert")) {
+	} else if (!strncmp(name, "pushcert", namelen)) {
 		if (!strcmp(value, "true"))
 			options.push_cert =3D SEND_PACK_PUSH_CERT_ALWAYS;
 		else if (!strcmp(value, "false"))
@@ -173,7 +173,7 @@ static int set_option(const char *name, const char *val=
ue)
 		else
 			return -1;
 		return 0;
-	} else if (!strcmp(name, "atomic")) {
+	} else if (!strncmp(name, "atomic", namelen)) {
 		if (!strcmp(value, "true"))
 			options.atomic =3D 1;
 		else if (!strcmp(value, "false"))
@@ -181,7 +181,7 @@ static int set_option(const char *name, const char *val=
ue)
 		else
 			return -1;
 		return 0;
-	} else if (!strcmp(name, "push-option")) {
+	} else if (!strncmp(name, "push-option", namelen)) {
 		if (*value !=3D '"')
 			string_list_append(&options.push_options, value);
 		else {
@@ -192,7 +192,7 @@ static int set_option(const char *name, const char *val=
ue)
 						 strbuf_detach(&unquoted, NULL));
 		}
 		return 0;
-	} else if (!strcmp(name, "family")) {
+	} else if (!strncmp(name, "family", namelen)) {
 		if (!strcmp(value, "ipv4"))
 			git_curl_ipresolve =3D CURL_IPRESOLVE_V4;
 		else if (!strcmp(value, "ipv6"))
@@ -202,16 +202,16 @@ static int set_option(const char *name, const char *v=
alue)
 		else
 			return -1;
 		return 0;
-	} else if (!strcmp(name, "from-promisor")) {
+	} else if (!strncmp(name, "from-promisor", namelen)) {
 		options.from_promisor =3D 1;
 		return 0;
-	} else if (!strcmp(name, "refetch")) {
+	} else if (!strncmp(name, "refetch", namelen)) {
 		options.refetch =3D 1;
 		return 0;
-	} else if (!strcmp(name, "filter")) {
+	} else if (!strncmp(name, "filter", namelen)) {
 		options.filter =3D xstrdup(value);
 		return 0;
-	} else if (!strcmp(name, "object-format")) {
+	} else if (!strncmp(name, "object-format", namelen)) {
 		options.object_format =3D 1;
 		if (strcmp(value, "true"))
 			die(_("unknown value for object-format: %s"), value);
@@ -1588,15 +1588,19 @@ int cmd_main(int argc, const char **argv)
 			parse_push(&buf);
=20
 		} else if (skip_prefix(buf.buf, "option ", &arg)) {
-			char *value =3D strchr(arg, ' ');
+			const char *value =3D strchr(arg, ' ');
+			size_t arglen;
 			int result;
=20
-			if (value)
-				*value++ =3D '\0';
-			else
+			if (value) {
+				arglen =3D value - arg;
+				value++;
+			} else {
+				arglen =3D strlen(arg);
 				value =3D "true";
+			}
=20
-			result =3D set_option(arg, value);
+			result =3D set_option(arg, arglen, value);
 			if (!result)
 				printf("ok\n");
 			else if (result < 0)
--=20
2.45.1.313.g3a57aa566a.dirty


--hzKpHdwp07g6kksP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI0sACgkQVbJhu7ck
PpS7fhAApH2iaDCnBx2fXH+a83d/D0ophz1cKJnBzsZSAef+Kjiy3v+SPSBIkWlN
SBfOoDQMk/ncUwk824fjaesdtjuGBVJq9Wb603/KO8LoFKQcOHtYXNVFrZxjBup8
Q1q9qHQVKZrqoPusixKpbfP0jyPrmf+5gSUR9HnMAUV2x6+h4jpH/AJxehm9qN0a
WstesK8S/Qv/ix+xNdE658dDNI+ADcfKIHkMLEzXrys3BO5B/XfTff0Q466dcX0H
CjTWqMNykZbEZOX8lepWtft/UYXrOa59MDAAWKGhfkZHOFWuQ+ALgE1f/t/ojsOE
kxWySZ2mqTQyboJ19mxDT8UP2z3voxTfHR+NR2P7VOp5txHSA1I1dLujANheEqsL
+txOsCcHRlW3aZiQXGpdUNGOJ1I2HcmOTjXfixlCPB5/rmFlTrkUHlNT2EpOSYhJ
b9DJG5XASRYJC9lfkLTuGzCaYThrmBQZouem7Ohg2/BnzJFXoqiiVFx+DIdc2oX1
Y2Orw6SoH5fLMkjMZLNZ2bTmzAfn4isiTBxKO6AreKJrWPMfZ7CNbE86tNXAolYU
qGW/5EjLshaE3IPewfKsFqpYpEFnXkFLwRKxkKdGorf9KJZpeVFwgyP201f7ukbt
uKKrJTvWwv4dn28K1lE7yk73uJmWTxopsMbEXI++4gFD/3/z1UU=
=L2YL
-----END PGP SIGNATURE-----

--hzKpHdwp07g6kksP--
