Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89514E2C4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669759; cv=none; b=JQP5tx4TmHs0Jvi1vvFl8opSluMfRz/LjeMN1pF575ECvpiR58MNjfM/vKMZyHQt2sx4JsUJkd+5a+KvuVEsK/b2ls+17DMisk/2/igSFD7I5T3psTUjpiBklUxELjPEolstDmP5mK+zXG4NbhNgLq1bhircQyt+aUwBpT5GOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669759; c=relaxed/simple;
	bh=gW42MBm8WqUiQo0hU0pYF1ng9Y+LtVzQGsVQqW+65Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqsz+Axbp3l8fjmlVNJX2k37pi5Rct9gCkBrInWlTfH4ndIT/bvpTiJ4XA6StFwn1RM6IoankShI846wxnDHawuxzbC0lLCXDhvIEsC0YUI6N1NHtmsXgbgurjDSRmA0SVOP2krTT5ZksKFYULpBL8WW4anCfmXd3mKW0w2VF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fyz+g5e4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pUPFzT1+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fyz+g5e4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUPFzT1+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 95EAC1380149;
	Thu,  6 Jun 2024 06:29:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 06:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669757; x=1717756157; bh=GES5kYcDeI
	YSdQoqYUHp1GWKa03K0+/gDivOoehUHgg=; b=Fyz+g5e4q/KShrczBonm2OtuGo
	rmoPJMJMi3Y7+gwRywZi8SImOHQvmhrVNl7tW2UbFLGEjVUCH+V9Z6tC/P3ZZZgz
	X0TQn3a7EtEid7mP6PdR9bm90oLm5jLMOuyO4RXOQUipMAhyk/batu6eWAyyY33e
	7dFP5QWhRf9QQxAuklZ/ONlHoS4Bxsl6t+DeRBmiliARAo3lWmCuWrBkGRSqCZe/
	+4DFX5kLKxOb4TDxUnuxpbfF7K11prycAlVIQ6y1SWFlJs8PjSaId42PH9c6Gjh/
	7glF59hpTzZO13brJbsV08xAbBA9xGJJINUj4w0nJ3BMhxuDGYv09RnJVUGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669757; x=1717756157; bh=GES5kYcDeIYSdQoqYUHp1GWKa03K
	0+/gDivOoehUHgg=; b=pUPFzT1+QdRkOBxsn3lqUVqVLF/tthABm4vz5+tngsZq
	WI9B45tspRlg+8Ya7Iz2T29UGyb/PutF9rQxO/ofIULiZzicIdrJbyJBcwH/Z2uw
	YunoufYyzENCdGvQnfQPbtb8srz7VmGs7Di436nkH/QEmpr/sA4LKdhUi0Uz65jZ
	EqUJciiEuQ1bD+wat3q53jLt0xc62saP1SBzYbSTgpPTh93bB9DDzGft8HpcpQaf
	XyowZEdoIetR7z9objYCTc7GzRuDIesdlR5MJIyOTr2f9H2YP5aNZKFhlaNklPFF
	1W9wQxZzyWYV0Z41ODj2QpnPfrI+I72ht2pNuRSAcQ==
X-ME-Sender: <xms:fY9hZj-NYwgG0KoMzMkX9HNvWoq1S9h8h1HgBoY-8xLBaAIJ-LTl2Q>
    <xme:fY9hZvvZUyMfK_aybcMsEOC331moQ9hO3ZANYAFO3y9DW6_n1JHg6jC1w44tZvZ-O
    w20h56Biy5SM3bHCQ>
X-ME-Received: <xmr:fY9hZhCqT_WdMWFg-MtPb8jXzRe_RZhMZJAO03gmfJctpikvqCjVu8KBPGUkwxKyl_gMOGxBlUTXL9Bx2vTtJxWzjXPpyecIo-STXxuCjVIKaw3j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fY9hZvc0WfFr7oFqMxYWvdL9YS0z7NQRXqgjEKD004_Ei2wP2xCW7w>
    <xmx:fY9hZoM7iSq-IwrvKXkR66ddpVyVpr-JTHgi3RFEhhct7TVxKW1Vnw>
    <xmx:fY9hZhmlkF9nAFVzl0oV6KvR3XWQgoVpmxYRXUn11xnFBiHoRy8i9Q>
    <xmx:fY9hZitTlPhe3ct1m_lx8cMmx-rzt9Pg4X0ZkFQlwNb-0LcgC572WA>
    <xmx:fY9hZlr87jk729KX6lDoVKj2Sv1pBDMUGlQUqWKvzRV_WeODYoxAGKzx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id efdbab83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:45 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 19/27] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <4598592d2f3b21b8777398ee6f30eaf766aa7efe.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bWHG2NeBXvQDHaS7"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--bWHG2NeBXvQDHaS7
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
2.45.2.409.g7b0defb391.dirty


--bWHG2NeBXvQDHaS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj3kACgkQVbJhu7ck
PpSiPw//WEk38Pk+DOWon3bsKOSN7sDrVjyMHkAkp4d6FLTzouFqRCa0cW3WA9bC
vyBqwYSK0ic4OtlEFIHBKpZ1N1fSBrXxZ9gJrLVqgrh0j8yWMmLAn0xh7de5X1F3
5IdBKYzgdD3ib4ZzfWb94Ag/WNx2gLU4H5BoBQRQDsfp585O1miG8GbcgwWaNUPq
IpRVtcL8nivb4q5RIy5hui0ABwIobQDbxOcl+CeEzLo9Cox4OZQZKanz08EaHm9/
QwgBq+tC7kHi41GJx5klDhlrgQG3HK2w+QasSTBUYF3y273A6UKIHSQEW0c+sNhC
B4V1StGl/5s7HYp9lyWCQlzu9saFcLfvqpwQLooRU+k2OmoHzlMZjHJRf3CcT3Bq
XgEdTBz0NqmwuCqFmwTGPOyjNkaCZ3x2CINWQAQ9+0D8FnHzAUEvp2N7kZGUNII/
cAu6lMVC1TcNY4UQp3xsMZZwUb64dDVt8e1BbvhL1tqC4+6RsMJXxal0XBMDWsst
lYA/sKkiWSymknGoLV0ls2BgXtefwMcgWy90gEtLGkYgNrwPekLQ5BWEB7RvNBjj
PtoH7erwz7gEP/nMZphegyYLS++IlzgmusamtOqb9g/CvHwrI1FYS8pfWL5Hdqwr
aqat60fL2RQVhy78vpHLcRPJKGvrYabieL3ZylLjab1pXews/t4=
=JLVk
-----END PGP SIGNATURE-----

--bWHG2NeBXvQDHaS7--
