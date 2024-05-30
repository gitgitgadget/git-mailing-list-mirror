Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0F132135
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073489; cv=none; b=Lkj3YnDu6EmeC6HIQ1Jd9UxnUvnmWGVUjg1KcBxKsdMm1kCPcqfFRUPcSoZ0/JhRAdHCX9I65zLgwCiJDsA1hsCkhQ/OsIz/0Bxs01OzwHXPymNckHAUVG4ZDOgp9+O5mSakSf9BT7GDZ0lGVaNBQ2EXBgy0erADsqpQxCsBxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073489; c=relaxed/simple;
	bh=Sw6GkJSemoiLGzi2kw6jpyZN1HzvtGoZ5sQeuDnM/dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8elI2VWBmLkofslvQzo19vpf6YfpETj0P+ujSH/AM3l2P5Jxnws/axY52vwEf61eHLmgQ0TIokYYU72XFik4lIrKHFCxo/Q2BYyD08/n3ySwBpd8wbb6XpEB0E8+zIC05edTUZzwjzOMyRJG7516/POyx5POlZYU6EsDoo3nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jaGAZ3tW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyI8VeN2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jaGAZ3tW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyI8VeN2"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 996EA13800E9;
	Thu, 30 May 2024 08:51:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073486; x=1717159886; bh=KPYKKqxbc1
	UKyfGMYc6tGSkXeVQ1xE+V8Rvu1nvixy8=; b=jaGAZ3tWSiHBci7lNX6U4prwBH
	p0no6Qs5k+AEf2YNuu7ICYOowusDb1XoAy+uSMfXaSpTGZOTQxgljS3k3ariXVIu
	3rx3bEoQtAPk/0y+LgrH2Jbp/ISq2SWCn6njV7mogEs98Q28lDurBr3/4WxmGZ2A
	ifw09EpQO2N5LVMt/oGPky+nu3pepT6x/Kdpb0Rbw3M1z6zJrvhDpmPCLx83oZwc
	WS66EwUjLU8U4vzeiNREc6D8WLW5P4M19ewxbTRuxELI6M8txaB4f+i1TgeCk3OS
	0Nr+z/8cncZlMAK/VKddPJ6n6drm+LIMRibaLBH4Ke+hNsuz0bX+pRasmvZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073486; x=1717159886; bh=KPYKKqxbc1UKyfGMYc6tGSkXeVQ1
	xE+V8Rvu1nvixy8=; b=hyI8VeN2OlxmhbxShSRB4bGI7Asi5wac27Heg3sB+Lk4
	cgrL81f2UbRkdDN0HRXS3JXJpGv3JgIgsz+7hVtMPtVWhvrWgd4U4sFs9l6t7PoX
	+Hb51FdXs39ILPENUvnhm9jmOuFdpgZhh+1cFTayrAaC/evVhGV7ZHryAC23hA+0
	qwVQfkgUpUYygiWWp/w+XLTX6pKZ5Tfvhq6pYj2Ow0ubQboGCOPu47U/nv8tLrlD
	o//YToC9W4+AsxlcLtu96r17qrrbUrNcl9wjh4oW0xSx4GjFSjD1852x5taLvVL6
	IoYC5fA+Iftq6opmm8GRBM8QniRSTqHRAsSfN8Qyfg==
X-ME-Sender: <xms:TnZYZjGmtSrc2guDnEXHThqN0nXB9c5wiXU6hqLbkaiXuqlHCklc0g>
    <xme:TnZYZgXlyV1CweKWWFJXKbVa6yuelWT4aHlUZ_-tZi4AHpK7uZYbfgC_78F4mVAN3
    hL2NHrOcpL18ttcPg>
X-ME-Received: <xmr:TnZYZlJZtcB3Y4NHkxTpN7CksHVCz6p91e0SCTJ4I9DNmWALHVh6fQ_JZ9qi8-vQoEWUJhnlEbPdQepVzhZfzfoT1FsugaVFTXV2Y_zvJjXpAIDbIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:TnZYZhEg8rNpY9E7Hg9ELGWp76DyakNTP1CR_bbwJaV5Ry95Ray2Iw>
    <xmx:TnZYZpWx1rBns7nLQSd7r54vYO2nfhRaUe-rcdSqHq1C-dY8L7uDLg>
    <xmx:TnZYZsMWOJtORaSnkTgrpiUlI24sqLc03JVBftF3t7wmyq2I_ICtUg>
    <xmx:TnZYZo10tgMzGufNrEMSUqf0zrM_zcgCtEZh6n5UIWPydqwbyP-h6A>
    <xmx:TnZYZsRxNSW8NEUPVPX8e8A5SNRhYVju3vOhW9PNDct1HZSiKs1xSHHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b9d943b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:08 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/19] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <884fbe1da59cdaf092b14b2e4c70b8f8c931f4de.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ikhqy0EgeK41OUh"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--3ikhqy0EgeK41OUh
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
2.45.1.313.g3a57aa566a.dirty


--3ikhqy0EgeK41OUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdkoACgkQVbJhu7ck
PpSC7BAAndunFMYMjYXWXPiTgdo/RyMLiyxd5I1eDp2NEow3eq0FeiL7Lrhp7WT1
aR10w9enIkzhWCbi3Vbb0sSxHtmDZvUSbnorBDSZfwqCskg33ASyzjIBfCRxRmTe
JGq/W0vYzruZlixjcHv5ScFQqJvaA9UDypmU+A/tllDiA7QZuVPH4tqn1qWMcuF7
ZEgmudPzBsa9xKCwQkXry9whGmIjlorFWaW3Im5GoCGOg88qVjQMqfqQNcwk0X1f
rY4868dn2NvYrO2qx+FgXtNM0ssHeGgyo78w9ZY4Kok+EkQQkdNJpmxkzcI0VPAC
pEIE7wa+ujc7nVTGWgnYJpjXbcxEPw8+mvZfLL5qqXdWkR1OdyKMOaX9BIgwT4XW
fU9wZovUMpdhDfQIhpkTbFUy65CzwJbXClhCn2nuf4fGTY+I6r9wUmJTW2ifu8h3
yn1NQvZPMv3dTdzfiv2/xNSaOgmZBzkcRAes4SKnDmjoD9b5bTy/ZsAlr3DzuRXc
FcE0yPoH/jprWZcSKaGDjHDbQYAKQEWOS64WX8vXBZzdb4qFq7shuwy3XZ/Jvcso
TIxEfzNZWs9NL/hz/YqM4R5v3IGUh1jwUE/KP/Rwpz6beRST7JHFG9ePmFyBlPPt
QcLIC4XqLN8bHKvIN+aoTtj8zGGXTaqsuls/6ATMKW32IApHlKk=
=XrhI
-----END PGP SIGNATURE-----

--3ikhqy0EgeK41OUh--
