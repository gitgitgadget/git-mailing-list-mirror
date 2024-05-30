Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3B13211A
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073451; cv=none; b=fQ1AG58Qm7nMaqUIBX8Kbl18OCZRhWQCFPBHPnV8a4ZF66RoWT6TMf77sbz1bAyy6SvcS4E76rbiNTMDd2h63SYHBn9BDLZbLy13OcXjC1HaqRg9DWZvcTNNk2Xc6CbnqOlzaBy6MB3cFf+7ybjLzR5mNmVCCbtKH+QEQzmmG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073451; c=relaxed/simple;
	bh=Fag49imr4pldgzNMYFXLOqfgwBNnRXR9chPWUUJEv9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLv7Knz5I5mqWZzYFYuFnoWE7+BM09udm0Cpk3wAcOihpQF8w2OZmIJ0UTZ9N+OT9eTqkAeg9ZE6VIzfZDq+BcGtwoS3O78JktccDklgDxxq8LQN/ZMDuNjZyOi2kTAku/XeP7LlICEe7kogz8Tnx7FouOckFvrSDNMTIx7Ynek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h6dyms9p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hmTi21u7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h6dyms9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hmTi21u7"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9BE9613800DA;
	Thu, 30 May 2024 08:50:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 May 2024 08:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073448; x=1717159848; bh=Z/UvoMJgZX
	8r/jIYpDtek38EZfuaYrofxkeyZpS4XBU=; b=h6dyms9pL+BUcH+ZME5rQEtwbC
	8DMkwx8WMw42KX1YkW9xPb2bJhCSiGGp8q9FWYSTHg9BlwPPVYkjZiThFQ0t+eX7
	cZDZvKoitlkBSOZ2qKwEDYmRWNfCXpvUGj6/a6WxKI+WsAASl+yfQ07AbALtnthd
	cIn2MPiOJD3KV8Umt6oKaJqBZsbujbz+LUbSdUjiwzrtOXs3KNb32GiS39Xp928m
	omTPUHPEkq09x++XTMNY+ZHHOAREV67pwPmo/D0wlr18lPyj/gdJQoonTfysaqiz
	Pah8/K/C4uIqIuXkJ9PtBIvswEocEeMAAL1RGLSikusa/GZ4ro30IxvMUISw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073448; x=1717159848; bh=Z/UvoMJgZX8r/jIYpDtek38EZfua
	YrofxkeyZpS4XBU=; b=hmTi21u7eUpIXxYMTa5oc5pIv4Bvy/G3MuQoHBZFmvje
	ZN62IceoBuJ/MiPkyD/fWSULB4gZwsY1xSEPw43gD062Y4mM7HK1ethAIXUz8aGT
	P8PBx2fu+rOTkGfgBUm5W7cwUD6jRrWdT80j83qDbUX8c0Yw5lxWcuRmuTI0F8ph
	xmKUHqvg+/EHYhGk5Zrpi2Z+mUQsk62RNQnozgmkBXnflZjuVMRlBgTvdIIgs+2r
	lrIS0cRNg2pWp9oDoNhwpBXyUOxEn/gaihvMbCKnVZN0+wI+CLHqiNFo+CfC+kyA
	gs2sgx5F7JJ1MBoSpLlZuPY9GmkQSDsQQE0yQX2g1g==
X-ME-Sender: <xms:KHZYZpjLax0yUKTrkOQqHLELfoHCdmcblteM8jj9BkpRIs944YdcWQ>
    <xme:KHZYZuBb5iet6945pZ0w-U8_-WbDSATbYO5HkyY8080-WCI-kcVX3_S3iX6ots9NS
    lD3WvRkBqT02Cr2ug>
X-ME-Received: <xmr:KHZYZpG2gN0mo1Zqp78wO9aHRbTO9-0HlDnmu3oVNednPNTBf2b4hXa7mXRgFE-OHnM9LuZaZGv4b-OFpOFsCWqE5xODK7r4rtZ_FLb-oWfg0PW-xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KHZYZuRtY0QM3COwy8bhNS4fop-vp3ABHLDHQ-F1C3DR60hHtQgmjA>
    <xmx:KHZYZmxmhLUykX-8g4iBeUN8KGkPzxER8mxHSAM0BYYeiviZFTj22w>
    <xmx:KHZYZk5A29GjWCmFRSUprpFHDzMEz5Dc1uBHHBXuek9edXHRHtv3yA>
    <xmx:KHZYZrwGprQFPNifdf8RK1A10sdVb7q298W27ojhCf0XIhKIUFQFxw>
    <xmx:KHZYZq8hIt2iddscjlAX8QJaM4S7av5JpiNH0gLQNGTjXZdNhiHHN7yi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:50:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ab065cfb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:30 +0000 (UTC)
Date: Thu, 30 May 2024 14:50:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/19] global: convert intentionally-leaking config
 strings to consts
Message-ID: <8b71dfa208c14600e4f9164017acda10627ba70a.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KE4UCO1DZtYBvXwc"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--KE4UCO1DZtYBvXwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple cases where we intentionally leak config strings:

  - `struct gpg_format` is used to track programs that can be used for
    signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
    user can override the commands via several config variables. As the
    array is populated once, only, and will never be free'd, it is fine
    to treat the program as a quasi-constant.

  - `struct ll_merge_driver` is used to track merge drivers. Same as
    with the GPG format, these drivers are populated once and then
    reused. Its data is never free'd, either.

  - `struct userdiff_funcname` and `struct userdiff_driver` can be
    configured via `diff.<driver>.*` to add additional drivers. Again,
    these have a global lifetime and are never free'd.

All of these are intentionally kept alive and never free'd. Furthermore,
all of these are being assigned both string constants in some places,
and allocated strings in other places. This will cause warnings once we
enable `-Wwrite-strings`, so let's mark the respective fields as `const
char *` and cast away the constness when assigning those values.

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
2.45.1.313.g3a57aa566a.dirty


--KE4UCO1DZtYBvXwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdiMACgkQVbJhu7ck
PpTdLQ//V5lIQ/17uUu1CuWkEgeWnrRrNCyZ7zkLDZkTLp7Ly5gcfTIxEJxrLCe/
yj5MZ8J1yThqUUBYmvbLfeMWEbDLwTCJCZ9bxkI+jGbmtKLdaRlWClVytQ6qFHhv
uEZ3XME2eBYavJAEbDAxUssSV/HccR005jNXZJ7cJtRkE8l8+IqN5vRACT0nOlhs
8hRKhKTuubd6qjoXaBZZOhq3s2atkF3Y8NMPyVCYswqtQu1wGlbDkOF0I+//16Aq
C4NYFJkzpykDVr2KvcL1MCTivo8wOho9O7H/u/tLHf6evprxUQOl1xbqfPH56gom
j942uajY0wwvZYIksWnXKQ+BVPSnsbi6aX9IERIatyjJNKhz2K4H9cDumOF3N7gQ
bfS2An+1mSGFZnF8HQuW5MhwMZj4SYbzo0ENDJJ1d2jt2RmVod7S176XPGlUF+DZ
TGrrvjovz5we5Q0p0ykxj8tRagEqAjYHHFIgwondTy34GtdQdlXm9CVOlJo9QHg5
xJiuPkKGfittlNsKSQuazAXijw0KjSNC5n/fvmWQIoBCW+6Mubg4WfMJXBAbW8nj
8vZgUzvgS0iBxg2PkFHj/IajvJY1Bij+oOSQbag07mnAm9R9+DhRe87Q7ATRYswn
WpCdhb9R6HhwcbwKAPF+Ed91sHcaDRhByjLehGc2851SXX7tGFI=
=dWjd
-----END PGP SIGNATURE-----

--KE4UCO1DZtYBvXwc--
