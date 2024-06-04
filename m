Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFC145B0A
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504711; cv=none; b=WCVI1tsBLZxuA7Jo5zZ0A3KrigrRAGkRJ4wij5jEqEeTLkpjNbxUUPYTnhEtYn3RV/iZKe3Nv5TTT5dOHGRJ81fNqUEvo4/59GXCyuNyp0V1wKq826XYIT+sh4TVnrKUuOJaPLOAaV1eJzhNh0cROxqmMKUGUdCPSbp0TxOdOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504711; c=relaxed/simple;
	bh=NXB9bxupk6BT8t8zplqKPsWOewUaR2pff92wsyJhAqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrDUXA7MRqyPKGZ/M2hsKKxxYffGepCVXsuCAo48s25FlBaNiPxHbTng7XKvqkApkfU4n/m2tVHYZbSMIB7u9hmC2I+CMCd/WHO4G+qSduVYCmzluISXfcinO7Sc2HqAkFazgA2fTVp6YiiKNeLy7U5/J3O1Lu3cYyDTcNEdCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ngpDjlqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CgsoiLbg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ngpDjlqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CgsoiLbg"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 852411380157;
	Tue,  4 Jun 2024 08:38:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 08:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504709; x=1717591109; bh=+5pQUqxb4D
	ShfOxSis+iHUMIzBiNEYWqUd8fPqBhngU=; b=ngpDjlqvsrR+0uT0tgcAamUDg8
	oqeOBDR2asyTeoSsW/x/8CnXuCD6487WxI+xYDTRSuG+45TU3kQNBbRayIpsUMxx
	fR0VhTFQaRPb8BZlVJC2oKkmYXs8UmvIuSzS3WYxYeXv51jfJqbhvDbYW+XqIvtx
	GY+T0ZbP3v/DlB5Kabrchzp3c0+LaNb0OfAS1EUvHQqcHxAgrhPDWesRDZ2nbdjQ
	izTyhUyMryEZihfNXUQXq4GLmenzt34QvXunSJG/QHRG41tx3YqqutY+A08eon5i
	Dodm5YgN9Kq29ndLSFMkPWTIRbaPghItiJotFbv1zHDSG0dq2cSRp+XQxNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504709; x=1717591109; bh=+5pQUqxb4DShfOxSis+iHUMIzBiN
	EYWqUd8fPqBhngU=; b=CgsoiLbgOoJkro4S5LlXEHL0ryITERdju40l9xE9Cy2x
	hbXD0RYmowTdWU9FiUVFiidvH0WugId4H4bCJDSIc4TDcFMe7LP8pcNtCxzGSFHX
	EAnULoHjyDnTE9hRb1o0pb3OVleVjR/VC4RreSO8wJ0uLxHyGgKky4hVbkQ4vdPm
	adMxeNe5MT7UiPFDalnaXKSCKvIDGIDwSEPC5Wra68tkB7J8xKCl01XWI+0ekAjh
	Lb7dhFjDUIS42+AFT41lF4NmJc8qYii6lXZYskkXdxFFRtV1HFjlCyxfzSyo7PaK
	WFUA2qfvirV+ZB3SFPHzXnyr4SkSimMICil89aDAAg==
X-ME-Sender: <xms:xQpfZvIPkQC5RRZw9M0QhQWSIhYoOfQ-xYfTyYH1R6qsV4I7fRmBAw>
    <xme:xQpfZjJSJWkWrlJQ7-1ic0mKGBu1KSZbuvPhkyf_a1w-bQvBwU3Usr2kKjEKfmqZN
    Wd7UXH_bwEv4SyUmw>
X-ME-Received: <xmr:xQpfZntDNWaWFgPBV08DIR6Nu4NF47Yrt4YAgsNW0YNoF2mk112WBOAmx4nvr6N3arw50RcquaOxTUZ6YSglsdlwfZW_3afP7jd3zW03swq74qsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xQpfZoaplYMrsJF4zxDdHR0RT-GL4G7syV6s4qa8ht6OpEX1GkCb3Q>
    <xmx:xQpfZmZW0zQMe_Db02f8OjL2z_Jd376VXiI5QpNez4cv97r-1kNdKQ>
    <xmx:xQpfZsAJivgAvF8eg6fftuYCKisKFWIDCGokHFFcPjxBRWQq-lqJBw>
    <xmx:xQpfZkY4Jsde3BKf5Bx-bzhzaypoLl8L2ag1UL0z6qXNPIknN-OhIw>
    <xmx:xQpfZtVJ8FlZX4a1Yn4f8349eWBoGmqd4ZCAgbyr9-xCc-yE5ATfwoV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id af43c7d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:01 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 19/27] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <f2f1ada1432abffbed20227ef6ff8ca1571b9263.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QoMgXMnMkSzZcqwr"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--QoMgXMnMkSzZcqwr
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
 remote-curl.c | 53 ++++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index cae98384da..d0f767df8e 100644
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
@@ -1588,15 +1588,16 @@ int cmd_main(int argc, const char **argv)
 			parse_push(&buf);
=20
 		} else if (skip_prefix(buf.buf, "option ", &arg)) {
-			char *value =3D strchr(arg, ' ');
+			const char *value =3D strchrnul(arg, ' ');
+			size_t arglen =3D value - arg;
 			int result;
=20
-			if (value)
-				*value++ =3D '\0';
+			if (*value)
+				value++; /* skip over SP */
 			else
 				value =3D "true";
=20
-			result =3D set_option(arg, value);
+			result =3D set_option(arg, arglen, value);
 			if (!result)
 				printf("ok\n");
 			else if (result < 0)
--=20
2.45.1.410.g58bac47f8e.dirty


--QoMgXMnMkSzZcqwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCsAACgkQVbJhu7ck
PpQFxw//X8DJmGf6vnMWkfkPBq2P8lHuzPwZEyUMfowwivT1b51X1fk01PjOQUUa
kkb32ZzQyPBscAvwJf7UgJJ9d/A2BwPUGnq1HEWf0YcbIcqirOBZA09LFRuUbjkY
yI6dtFAxOsFBqIRFjh2/CLXY4pzsfyQCjcEnWoRiVaMiPAoCjfWryLKRqZbsWm0X
cY6ZwvaUaT/zVNZJzedSX8GrglZSIrY20hMi+Z5/VzviC3D8oqBIxjNpk/x7vhe+
gHNpTwS5wPM3Zn9zOdzAMA2Ta1u2TbKvVf5w3HuqSWmz3BPPVyp3Im9ghrZEeIdR
hSLyctNafE/2YCks4XRsaXGerIpbZDyIKYrfH/Bkq/nSzAnvqgEegT/yquLlwbh+
P1Icggp3Rx11asfkAydVsNJLllaYX+9d/WQPUTIMZJ+wf0d72TeGAJZdHHZvdolS
v0M5et3fd3NbA8cu5KAccp/cB6+g/5CENsD2qGRCI3iwb/Ts16lCujcXh6qGG9z/
QGW1BKMoNf0gINiQ2KuutKHfwM5ChibHfITTicpD7Dt+9/p2ffIjqBV+PhcdoBlG
+Zu0eTKHRVtp0ja6yyapacWIivAKXysZVswjIaP/kKdr032SDl+y61ssLyfi9OSp
r5zR1fc87sn9aVookHlpuaSSzMf4qJjJs5JkOf/IZPOdhSMNTHE=
=AoK+
-----END PGP SIGNATURE-----

--QoMgXMnMkSzZcqwr--
