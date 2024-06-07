Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5B153801
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742349; cv=none; b=cgjTpyaBdqDdYvX7piAagR8QHUthFMxho2dzuBWuut6m7nIbHZl+9Xlr528M9CtNPVheeYV6+91oljJgRqsqUokO71XDHIQVmw+6RvHKQmdemDDUnYdXdg4bxaBzG5/9P74NpgdglqXe2t+vDcYNFiJ2vZIMbpRTpvIKwPR69Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742349; c=relaxed/simple;
	bh=SGP+P3ftOGuvOcbM7QL7rlkj/GpeQ2UfUWmfT2v87Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftzeh2TxGp6wWVaW36b61JAY5cJTduRGrd/yBBtxHzLGxY4z4Kkj26YEPi06jlJieLv6z/Vj/2OJV/6f98t5NLCJjVO7L3kAfQjWivjfgO9XzFtxApM7N89NMI3lbJVe8eq/4y8kjU49v+Rt1FON+MsllGd1daV6voBRiZ5fnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jyO+uXtm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yc2uWkoD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jyO+uXtm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yc2uWkoD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 01D2813801ED;
	Fri,  7 Jun 2024 02:39:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Jun 2024 02:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742346; x=1717828746; bh=5aWecju8pf
	Ggtgv68CBe9wFLNmM39Vve2i/OWm0QM8g=; b=jyO+uXtm3aTUO3RFCmFwO0GG/Y
	VXiMjJpBTpSsEwuuVO4vXYNoe5mbPZW+4b+sqmeTG4A4QboB5KyQHWAe97u30e87
	neIR3+/Yzg/K0c5k/47BwngKTnxhSXP64P2/Eu58ycE4Tkg8vCt5bWyLm64uAXZB
	+TATBOS9Be5KO+0jKRzPpZF/us1T7PLWSJXMf0A+YlDoZc9cAZckTcAimHJepwMj
	Q/svANWUChi4iBpD9tYt5+RfHEA0Wscu/dpQHHv9EpM+RcFedJV1bUSzblR+T2A1
	+cVn/5BcwTu8xfTqpBjjLxB6g0mSCyqjHmjgijvni74EOiEYUJ4Dma3heGyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742346; x=1717828746; bh=5aWecju8pfGgtgv68CBe9wFLNmM3
	9Vve2i/OWm0QM8g=; b=Yc2uWkoD3Bd2EoGCXP8t2KHqRfyvPiM6AEgANnzIFbSG
	85T6kBD/6sPN/c2Fd3nDAjoUqKjil56SChHwrD/y5hoTRINV4yRtjxH4HDb9QSSn
	EM+67oxIkYeENchSUg361sjDeMucKdkMy77d5leoQUZAtuKXhRQ/O0xN9nyamhSG
	+HStRBjctp0HrZ/Lu94sJeZU4FWuh1h5v3i4aPilNHDOjk8iSlSsS/zoKVCTzZIl
	BKABRSWQMcTcv0CuDlTxL+oGGqJfpKQdQGQJdi7wamfTvtpaqokBSY1nbrnBuH/5
	xtASMF3LoQbowGvHwGqvZO9uOc9m6/70jzerBbCCaw==
X-ME-Sender: <xms:CqtiZtftkRaR3Yy8RSYk_gAozc3QbrQ18tA6cBjn0ZrtSaHe-8yT7g>
    <xme:CqtiZrOK-7Num32DV2JLiSTTeBZZDVsRtd0XLvp6-VpNXCA0CkKsyCsX2dh7AwGEV
    IWlSc3nLjBqhzufgg>
X-ME-Received: <xmr:CqtiZmg4G68uMP_QP_phyDwc2MYLoKkvWxmCog6uMJkxNj8HxE7EOF9iGiwDB_6_By5di3gYHMDv2vTqnjjCSejhx6u3xeWTjYTCQGgzt8u5RkKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:CqtiZm_gB3j1lYlBka_kw_LxCLGuofMgfyd37H3uUuHiAzzI6hYmdw>
    <xmx:CqtiZpsNlpMvSDaGj4paUKt4fU2YfCBqnWqV3GD9dO_SuCQb4BXD1w>
    <xmx:CqtiZlGp5xyeAhKDJJsA5LozBSOCx6q_v-vEWNeKb3KNvXj_hWyrJg>
    <xmx:CqtiZgNvCzj-SvrdBtVpONleNwcqbYQ1cJG_oSkpRE9NE-DqB9R0Mw>
    <xmx:CqtiZjK7zJAErUZf12wlV6AwEEsDZbA6pZzzvH5Bi4ch9mYDFGbRpHqh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b85b38f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:04 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 19/27] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <99c88897be33bc1ed1c50f84e48cae7717a7b10b.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XCUvrOsdIF0QrqGe"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--XCUvrOsdIF0QrqGe
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
2.45.2.436.gcd77e87115.dirty


--XCUvrOsdIF0QrqGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqwYACgkQVbJhu7ck
PpRfQQ/9GM07T3j8vYqgbt1zoonUxubtuVNS+edwW87lzEvWQUju8Moh2E+ZcZkJ
JZmdXaSOxRnciL+4xuglNQkpv0CBMqqTZr2pke6gaYeFc+kPVxwnQR6y+6TMnIiX
mOalSxjZg0LiqvWLizQ4YvonCK/GFmh/UR4/FHcj+BL9Re7yaw6NuaGfnaGiECWr
X1CvzO9R3U06s7gcEX3Llj8M8z0lePrgL4RY6Bsm3gB9HRNIPRdvQKqAkJrr031c
fiwJVRn9odCxvbvyMz+SDH9lsOUCzZlbnv8yeF1tIYw5Tn6GWEk6gZS7cxLoahB+
/co/gOs4yuRw3u+a1axmDpE1odJYvFZBDgbnnYIGAPK4+9HhzU04n1o9o93tges+
JYHAQkgSt8Xo3Fjx6L01t9cdOlAzWm3XtFSVDWRfu/ftGgnVojRr0qhEqm3+b0vq
95iTffWgf6bJX9tRpcVXIK/XsGGvInJSXxkxGo5fC2xwA8biRbK5Oalo9+8qCnAu
9NJWFKxD34byn1s9/NbWN8i+7Q1ezQ9FgEMKTmZ5RWJvLkwz8LSO/988MUQ8Ew0s
WRPKBVckR4k/gwZT7y4nVzyZcwKVJZzytCVQTZakUAnbEA+Q5+b7P7Rs5uGBZcmH
YbnRd1LRJoFMZYHr4VXncQH3PYrbcHZEKrQxb5AubhgClzFfyZ0=
=EOQi
-----END PGP SIGNATURE-----

--XCUvrOsdIF0QrqGe--
