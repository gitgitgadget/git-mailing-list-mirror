Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4D153512
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742269; cv=none; b=o5pT2MrRaJwuAKLKsq0rqnFDQ/Tb97j86cDoBFRnK2pCwa5ISHJTqGiQ9UYF5Da6QaY34BSU5dsb73NbBk2vJG5G1vly0DZYJqYKFkVghWDykaeikH1KspIm7SdCQwiAvYNlf5UlZmiKN0Lp8qEoB5eEHwvkPjGSljsF4kviUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742269; c=relaxed/simple;
	bh=0EbOsvLUhuAC2ZNNfUI8HHdqeBAasS1KmnVpZrg1siw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RddNd7JxLkxFvY+PLS06Kb/3604TtGtXlWXXe68SeON4OboyKtL9I05GYbNwpnauhDfSvBNb/F7LSi66SOBK36fkrXfPBDbJJekPdRQvv2KNmtyv4L8qdkDqMqZGIcaGHU2wYMirymEXyq9N956WW3Wu9ujXIAR/KV9nTYiOW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K0pLcQw0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IW2aKpdb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K0pLcQw0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IW2aKpdb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 21467138020E;
	Fri,  7 Jun 2024 02:37:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742267; x=1717828667; bh=RZ/UJGnU+m
	1AuoED8givORJ1USIduwa8d4yMGkMY3YE=; b=K0pLcQw0bu3qOC7r8SkbK/GFWD
	LRc3VEfhDDJ56eohOCOPrxnqrhIWwkHQfJwfanoujE8V6LJoYzheIbKFkqN7q1/g
	KpODomzpE9COt/unInOhRne0jwGtwHzG/8ri/hILfPemeSxKVVuMZDanINdacozg
	eBOD1kYX7z67fZtlUS/FuM+Ign9zPFN/90Cw6GJcO/md6DdmGtaooT0i68eRPrx3
	VKkhjw+ixXck86pcMCE80rUigI43/cLFiGwcgB+a0rlHiBUh5dCViWX3W4L90TUG
	DZezbKYnlgZQuIxxqGrZWtZYtPZSG1BYTXX6V+u9K6dVSgQa/K/vCl+8SlRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742267; x=1717828667; bh=RZ/UJGnU+m1AuoED8givORJ1USId
	uwa8d4yMGkMY3YE=; b=IW2aKpdbAGuHCwL2t5ciwYdOP4NRaS9mUX6aJomrY9Ug
	Hhqnp5vj9qF7Iiyo3hDeo/v4+2IEuZyTSorCVuxPuE61My+fqLXR9o/T75GXvY3X
	Tkhwp5ACb0JuCrt+u2kYOXJ56v67BcPRDWAVA9Yj3vM1DyY/9EdLVMcxmontsEQv
	FVyEKtSPN/F/x/K4ez/TM39tSzQ3WADWcJWGf7rmC69IUOyqZu8rRV6O8MwU/tgj
	5G1RcESWmK4Y+pGu6176DtElpmdFA5w1enG9jXawSJ1GFAuBtPkeXMQEIgUN79vl
	In0lV0bZfVyu+8LVyKcvlRz+v/aBkbS2VpgDclxLKg==
X-ME-Sender: <xms:uqpiZriUgP8ndSDHxH8EpG-c8_0O926DeRpTy_4FnDuEGVkDULQgfw>
    <xme:uqpiZoC-8kAXPD9FRWKm872jW-Jeh9TaCnBfnOqFXYGuZ0aT__KlG_v0gywA1lZmC
    IffoK_F4RQ-9aO4ng>
X-ME-Received: <xmr:uqpiZrF04lM4LP8SLSCUdITkWyHZ47SejQMly0aEou_sjtyHV9-DzsH50FfhpOHTYhkg7Ye18qkQUNioTe8RTsTdhPeCz5p8BGg7r6UpZ9dEwQ_e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:uqpiZoQhUoJ0UOF3QagM-h530HE6YI5K_ExUacxRFOcUseepqu_kpg>
    <xmx:uqpiZoyhCOH10nNY4q_-cvurSqpCbFHXq77qtJA13F68lesQF8XwSw>
    <xmx:uqpiZu4sx2fueahU3YgJ27lWl0Xi5sb-TgKDM-xdC3B_6DaH7PHfkA>
    <xmx:uqpiZtyGMWQbg7PO17khmtFYdoRltvcIAHHTBF63YF6tUIYA6Xjogg>
    <xmx:u6piZiuV4iPflOJ1MToQDK2s6E6GurqJzvjLawILIkfvNtP3a8rzPsXR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:37:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4e2a0079 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:37:45 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:37:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 02/27] global: convert intentionally-leaking config
 strings to consts
Message-ID: <4769bdb89393c70f2a42847e233fd2d89a90ebd6.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ru6/yGNjYMc1VdKF"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--ru6/yGNjYMc1VdKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple cases where we intentionally leak config strings:

  - `struct gpg_format` is used to track programs that can be used for
    signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
    user can override the commands via several config variables. As the
    array is populated once, only, and the struct memers are never
    written to or free'd.

  - `struct ll_merge_driver` is used to track merge drivers. Same as
    with the GPG format, these drivers are populated once and then
    reused. Its data is never written to or free'd, either.

  - `struct userdiff_funcname` and `struct userdiff_driver` can be
    configured via `diff.<driver>.*` to add additional drivers. Again,
    these have a global lifetime and are never written to or free'd.

All of these are intentionally kept alive and are never written to.
Furthermore, all of these are being assigned both string constants in
some places, and allocated strings in other places. This will cause
warnings once we enable `-Wwrite-strings`, so let's mark the respective
fields as `const char *` and cast away the constness when assigning
those values.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gpg-interface.c |  4 ++--
 merge-ll.c      | 11 ++++++++---
 userdiff.c      | 10 +++++-----
 userdiff.h      | 12 ++++++------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 71a9382a61..5c824aeb25 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -34,7 +34,7 @@ static enum signature_trust_level configured_min_trust_le=
vel =3D TRUST_UNDEFINED;
=20
 struct gpg_format {
 	const char *name;
-	char *program;
+	const char *program;
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
@@ -783,7 +783,7 @@ static int git_gpg_config(const char *var, const char *=
value,
=20
 	if (fmtname) {
 		fmt =3D get_format_by_name(fmtname);
-		return git_config_string(&fmt->program, var, value);
+		return git_config_string((char **) &fmt->program, var, value);
 	}
=20
 	return 0;
diff --git a/merge-ll.c b/merge-ll.c
index e29b15fa4a..180c19df67 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -27,7 +27,7 @@ typedef enum ll_merge_result (*ll_merge_fn)(const struct =
ll_merge_driver *,
=20
 struct ll_merge_driver {
 	const char *name;
-	char *description;
+	const char *description;
 	ll_merge_fn fn;
 	char *recursive;
 	struct ll_merge_driver *next;
@@ -304,8 +304,13 @@ static int read_merge_config(const char *var, const ch=
ar *value,
 		ll_user_merge_tail =3D &(fn->next);
 	}
=20
-	if (!strcmp("name", key))
-		return git_config_string(&fn->description, var, value);
+	if (!strcmp("name", key)) {
+		/*
+		 * The description is leaking, but that's okay as we want to
+		 * keep around the merge drivers anyway.
+		 */
+		return git_config_string((char **) &fn->description, var, value);
+	}
=20
 	if (!strcmp("driver", key)) {
 		if (!value)
diff --git a/userdiff.c b/userdiff.c
index 82bc76b910..371032a413 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -399,7 +399,7 @@ static struct userdiff_driver *userdiff_find_by_namelen=
(const char *name, size_t
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
 		const char *v, int cflags)
 {
-	if (git_config_string(&f->pattern, k, v) < 0)
+	if (git_config_string((char **) &f->pattern, k, v) < 0)
 		return -1;
 	f->cflags =3D cflags;
 	return 0;
@@ -445,15 +445,15 @@ int userdiff_config(const char *k, const char *v)
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-		return git_config_string(&drv->external, k, v);
+		return git_config_string((char **) &drv->external, k, v);
 	if (!strcmp(type, "textconv"))
-		return git_config_string(&drv->textconv, k, v);
+		return git_config_string((char **) &drv->textconv, k, v);
 	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
-		return git_config_string(&drv->word_regex, k, v);
+		return git_config_string((char **) &drv->word_regex, k, v);
 	if (!strcmp(type, "algorithm"))
-		return git_config_string(&drv->algorithm, k, v);
+		return git_config_string((char **) &drv->algorithm, k, v);
=20
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index cc8e5abfef..d726804c3e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -7,19 +7,19 @@ struct index_state;
 struct repository;
=20
 struct userdiff_funcname {
-	char *pattern;
+	const char *pattern;
 	int cflags;
 };
=20
 struct userdiff_driver {
 	const char *name;
-	char *external;
-	char *algorithm;
+	const char *external;
+	const char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
-	char *word_regex;
-	char *word_regex_multi_byte;
-	char *textconv;
+	const char *word_regex;
+	const char *word_regex_multi_byte;
+	const char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
--=20
2.45.2.436.gcd77e87115.dirty


--ru6/yGNjYMc1VdKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqrYACgkQVbJhu7ck
PpSLUA/+NBW2rsVR8r3+uvWK6zXHNH+WQ4tA8qpU0ZXohzXw83GMUrQx/7h1uyGu
Al1WAgzNQvZbBkd+GqHwE9LKnhqGgvFSR2O/mZuYxRlEWozY+4YQh9WdxSTjpXrl
otO9/naHsO2L+YUc4MYb6H92jRO3ICoRCrusd5mZ8+chnNdZ9gppFrpFeo11Zkz/
5ojhJQWWFklLCszimBOdO4yxfBko6svImPfm+InUT7Rb0sqgu1yhg96+2b2sP4vx
uuExvvXsBtUdM9u0/mmlelRmmga5uSU7XPg1FBHhSZXJDQSSWvSToJlACiDWOi3E
MVD3vzqne5OpmTX8yTK+aLNoM+luf4Z2hjV910Wc1zyXO81ritwmmRlabnXYK3Es
QdqWu5H56UpYlA57J5tac0zA528gL04n/VfBlKe+eXsKswd1fN7IqqtfB0dzDTp3
PKslKiePpCiWrJGJjPTdMjEPBnC63FOGlQNVPp7DILRhbzPl/osLJiwG0R3ZJ+8g
9ypQ29eeNhPPlXwyF/d1is8h8SAn9NpVpo18iQ27V49nD9HJHVe0v9LbQOIE3jCl
caFLxOjOduyHFqLSQ4urF3fLk+rxpirkJlWxfLFcJnNfKTZmQ1btiE173nLaVpry
7mphkGibPLVG1ZP4l6W1SY6hpam3A+CVwER35+6paUxQZKvHfh8=
=CHcd
-----END PGP SIGNATURE-----

--ru6/yGNjYMc1VdKF--
