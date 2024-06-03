Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26B85284
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407633; cv=none; b=WkmYYCCKmHC+tOGBtlkWQ7G1frlQui5xRCq4yqkwGBpdG9ZSVpSxXB+HO8ykfRDx3XerTchLXD1B4n7ZUVu2mEOhEvOU3NyFC8S87mEkMafnXJb19MUNxODc8Zw5sLDqTaJTKS6kBoIb4+ywoufj2lG8/ITgSQ+rG43xfpM4K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407633; c=relaxed/simple;
	bh=SmDYpIVzwF0I6codBOBYFtuPmoggdUIF/1FyQkEyOwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fccEf0rrRFQtb001oDKtuKMcQAqyEmrqZoG0zkjwrLbxI5wqnWuKqbs6ma7S1mFf6JklNlccMNd/Vw5nRSzgeEaRZ+phKbDIKUucHsyJCAyQqzouZydsPHFEKyJw4DHow3g1MVKUMxqc7ZDb+lA3YAxKKOSsphDZY81tW7R7rNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bczwLwzb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mM4hX3i9; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bczwLwzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mM4hX3i9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 60F2E18000F6;
	Mon,  3 Jun 2024 05:40:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407631; x=1717494031; bh=/+udFgrZ3P
	vOPoe++BmC2cO98pBpGMps0ea4Ex+Jr08=; b=bczwLwzb054Lbf2KwfPy+4yoY8
	wmSBsa8nd7MftWEqyPePsvcUNAK3RAUrRGWaVTVRvZ5NkRcchwliaamnD41cjD8Y
	OCYfiFGWgl0Dxm3Ljv9uMR8dGH/+FWNdV9AgJCh07ogx+/YUmMlnw9VuCYPXOULE
	qEu3yLuj5RhuwuTjg78GvgabWLTejSbApwhAk6HN8OxyOfxBs3cvg2DKopShrrid
	1m0h65A0C+YvGR7Qhr4w6sHNfsmH4CNaKJbnOa5YII+vyuc6OKPNb5HbXhsGWW1h
	1wku+fuq4r8+hg07gMPzjHIu5aU7l6/JOldz3tw+taemrqChURs/ihGtR0mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407631; x=1717494031; bh=/+udFgrZ3PvOPoe++BmC2cO98pBp
	GMps0ea4Ex+Jr08=; b=mM4hX3i9bjHNNfs2ZTYPI6V7HkNbaFglbk0DOxtTNaDA
	RZ9iN089FygNA2yLWkzSZcu8mjq9So7ZLIR46COyh0fDYczA0kp8xbQVGKdVKN14
	RrKtLPkcn+ZTN/iK2z4Q5SDZO58Kdk5kg3eFkWHZ/+DRDq9tOqFVvBCF9v0x2Z1B
	aR7h+CNXf+93PT6HnX/R57+dL3Ooy00uVv4cawUr4gTIStgf0LwnTFxdgwCWUdlu
	RFXiZmhnSvghd0pwvmo6jD68h7lMG7IosJHUuGQdJIYBHaqSV0F/jlj5musVvgJK
	5v8sM6V+5GOaXp2PX1mSE9/di+WQFsNPfumITHn4bQ==
X-ME-Sender: <xms:jo9dZmvIbq1AAYeXDDcWJD53Iyu9a6WfuYCe9kJ6aK9zVYpRDbHg_w>
    <xme:jo9dZreT1TS3e_m9hvDV9U4YaQibSqxiTGanIGaRzz-h9mkXVce9TiHDcPPcTmPi4
    gOd9cBRX1EC1Aq0DQ>
X-ME-Received: <xmr:jo9dZhynujfiwY68Ps7ZY4MgTA-ot72b0oJszShsfalhXS04jTY6Y5W-UNoy0yQy7AnD_oZtEyUoMNQoZM_x6AiT2qLOP-SWrSsotbZVx258VoSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:jo9dZhO7TwfWNZmC6_mcvTJpHntii7P-4QhcHk7smlb_6CE8KN-0Sw>
    <xmx:jo9dZm99zeo2K4xrO_ujnqjM5YXF5jCn27T7ZSH8FBJCR4VcYONQCg>
    <xmx:jo9dZpW-av1rTd2cOwvCG33fIFHJDOnyWO1pNFI-su-7-zgHwtjQlg>
    <xmx:jo9dZveUpifGHVz087M6HulMOV_AuZTlI9fdXRIgrWmKUudLmujnag>
    <xmx:j49dZtaBUvOVs16NzF2WYPC5p2Ru6un1f7G23mccL1cJJFixt0rHQTz4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6eced3be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:05 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/27] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <af82e49682d065a07809dbb55d40a6f92c0ff17d.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wu6KGPlXh6pextx3"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--Wu6KGPlXh6pextx3
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


--Wu6KGPlXh6pextx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj4oACgkQVbJhu7ck
PpQR5g//YgRcmKYUAETXRfBoBseYZ2kmiycwwx4fd/fjv1NFzV7Krc1ur7lmhvyk
HScCDR/Pun748YKaeF7PuCsQSGfc24jmGc68wQVMDa3ygzhxCf8rGIeaVkTUZucf
3/JgNQQqkFN03Vgmk56zzTfBuaU+5P26HiM4O7x1HzDgkUKu5K/Hn3JuuxMqHT3U
ma4bIRUwJa8JN8Qh/YzPajs75LlSwGArBDXlMWg/w7vbEqBqdXPD4rN9wZdkYwmS
xBhVIYM+/QvVi8Z9mpB0odC6+iNNWmYpdFXNYJV/YoIqZylVKhD0lsz65RROUO4u
Ghh0OcPkp5aZjKjyMDcaKtYvv1BnXqZK9HRtpqFUYGn++2nd00NNOvzqOC0iqVn/
Iqx5uwAKCd42EPLmEl1iWjZmU+nsoVcLrGHr4LgLmDY4LTDE3v/kCGxEUq/pPcHl
JjSmGpsqIf+fK/p0kKuwI0hiXYuwphVddKIFjhhakG1EEleBu+xF0yaCfBHIbT4Q
XseOHjZseE93yQltbjth7dw//mgwAjZCr16g8t+rML0dAeo29NNVVSF5dLtGDHyM
9qEgRW5f3inbZhEdCvLADp2JqfMDZiu2KKAweP2VDkKfhGYNdXkCBYhw6kVqbnKp
iA/E9+r3WJsfYhf2wP5X0r84jV3kLfyRPAM42FtM5X12AMJh/dY=
=T9hg
-----END PGP SIGNATURE-----

--Wu6KGPlXh6pextx3--
