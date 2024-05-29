Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB788181325
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986662; cv=none; b=pc0CoVTkxv+N3xSJEFmQmVvxlHV3fWbdXfXPM2hiyR4zTK2L1+qFIKi4PZ4jyjzE7righZ+vvT84v27O2EQUqtsnTjFoSGg6vCHDqy3QPtFwivWkY0RwXuVXMlPKb6KJ1vq8mm6tEXRNmX7OQUUDD0jQsF3s80rBbQoG0juBvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986662; c=relaxed/simple;
	bh=ZmJCw0NZYB2EKYyw+OzTsspmciK1t1jx+274qxiTj3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtC9jGqKq9lwvXp+Bu6wU+bc5aL7iBPyQ1Yw4PwptX0Uf29l9k3yQWouad41u7/pcYuw6Q7OYzcYly0D/e9oY0fMztKi95nyyAqTjAphGZiI0HWbRPzxB6l2qaAmhZ0xC0dwPpB3yN1AJbeCCEwYeKS7Fn7xEaXLzjnxL+v3wCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jEAVJypN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XpjEdKs3; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jEAVJypN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XpjEdKs3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id CB5511800122;
	Wed, 29 May 2024 08:44:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 08:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986659; x=1717073059; bh=LSs4aIfKwp
	NSxYKPnn9sHrMj9L6Xy8EIanCRLK7q8LI=; b=jEAVJypNwAfFSHt9m1TBtixCNB
	RtUDIIt3KR9+y+OcJCq/pMglV6V9X7h6dUiyRcwhx7ADVwELjCYZyY5xnX9swhfA
	5hdx9PkbXDjUXgX5aIFqsZtNDz24uz1SZWyAikki4QET+BnYUBeET+L5OgYzDqd2
	RyarqlrmfW9Y3QaaaN5OqdIGHWjkkRGlAM3WZkjJqpf1VofUk0IFyYqxcavvGMAZ
	MfObjHL9B+2u2NxhxiLQJhXF1zP+qkk1nMnUdRlGYude6++KIay8DqlS/e5aobPe
	/gi5/S3Ud6RXwlps8+Cl/xks24WdOK9Ns91uoSeDDYcYeC/XMgj8/NhjmCdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986659; x=1717073059; bh=LSs4aIfKwpNSxYKPnn9sHrMj9L6X
	y8EIanCRLK7q8LI=; b=XpjEdKs3mq7bTblFJbx1QdIr/ZsBhujqOQJcMe7/c3bp
	Rt0OU6JnT+RfEyEZPYAH10cZfLXpg4f3M0/YvbAmR3waw10SKoYPxuULBUVkrJOy
	J1Tfp0NXVqxyNiPdkJ2QqY7tQaETBRpYfi6DvEt4szjA+lGGfF5dnO17r6pKgRlr
	fGayeGmC4Ms5RxRybD4/ZV8NMvcZny8vleX3LwyG9DG5yqfvjTTOEFOfZ+tM8g9m
	f4AG834XTzepq4+BcxlU0MUYXdDwq1iCPlMEnDjN8ZuktQayJe48vs27KfHsDXmd
	7/AZ2Abl52GkCvQGBJ1jxIW+dqlwR4QUHy+MEFt3VQ==
X-ME-Sender: <xms:IyNXZkD1vETKSgPrCQPYOX_E3EVjaW4gRlUJ4d13wzECbPd84KLcUw>
    <xme:IyNXZmgIwudXdB34n0FUy8MPHVR95Oi-6m1kt-MDjiCbs4nJF8tHvlcXlPCuGovyj
    mRPb71rg8YGzO_YLg>
X-ME-Received: <xmr:IyNXZnlca-jMIBptFdTOGPdBOK5guOFto6Q7N-9l8KiSibQENPlE2rEJpsj2Vz-RqHA_Tviex_85qDG9d7bXP302EBmwWH30ZvEI9kiX4cKguaIp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IyNXZqyBOt1F3t6HDkKs40DjQf4MH58XFFZiVGxr3J_z7WIDi9sXYA>
    <xmx:IyNXZpSCPbFy9RkFjbbUmMSYiXZx-7ro_zF2zBHoaGrC4meUSuz-bg>
    <xmx:IyNXZlYt2PNgW2MVzq5qC95jZ5Vggt9e4IPjbf5afUbv7fbteZVy0g>
    <xmx:IyNXZiQjrN17R186emVafLyXyA6sKEo9lcqaogBsB8m2cjPtDGhGxw>
    <xmx:IyNXZkfONpXDmw8c8N_QaTxtHcTv-WwL7J6jZfSAxLaBCD3SZyaUCbv7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bb5cb10b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:04 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 03/19] global: convert intentionally-leaking config strings
 to consts
Message-ID: <8f3decbb762916a536ec7a8d319c5903bd8f30c1.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="78t85RqMtL78Liz2"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--78t85RqMtL78Liz2
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

All of these are intentionally kept alive and never free'd. Let's mark
the respective fields as `const char *` and cast away the constness when
assigning those values.

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


--78t85RqMtL78Liz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIx8ACgkQVbJhu7ck
PpQvHg//QlpsplJrRlD8M2OfqK2AHdmb6Y2zj2at+wOv7jI8UWhr9yJjNXLYGYLe
hFpQAXuvON0f59WTo9BxIJa8cid2aBO2jP2ftDS3JohKCHHiyLXMUus8g2TSecS0
u2ZsE31a0xLLcU9y7dLV2GszWlI9hjaYgKXCmJvZix1aOaiF4DK+Wy2Zr+RxEp7Y
yGW0CP0tgkndVDwP8+QpZBXU51xF/3cApO15lGHuuFRU6IPn+X3qs+ARrEIXbUvU
b139Dt5uAB+7VcoCbI1FZxA5+SVkWjDWPoMTvN2bQ2OytD4YNOMsBlf3IYA845hp
FritIxa909hAmJF8Ho67seYQqSrJnAzXDd+bAA6HsDE5fiEUIFYDrnrBviki9Yx/
ai2EaFCANR/vQu1ZKNj/Ppa8e5Bi/bDGH9RyeFXjqnZrtWWkm+lU9attRgVUFMJE
nAo+UhVYlXxHG9JOqOH9UxcPuVfa7FHhLPhfoBXEYKVSWSCR9RTWhm3z/d5MsYq6
kmAoE3OfX+etPQ9RVoIRjYanq2urWj/vozrc8OtO2v/7suc1ZMS05mZpakEnMhLG
VYW9tQ416P5k82fsO8ubelCkZWsvTkwc8LC3qdS0UCjsVgFetS6Mi5rabooaub+9
rUCUPuRfuFuRQ5N0RQqkTeUTlavWcWdG4MKhibPHd7dLuE6FAmI=
=GyN7
-----END PGP SIGNATURE-----

--78t85RqMtL78Liz2--
