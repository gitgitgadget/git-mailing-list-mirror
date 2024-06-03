Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30184E16
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407552; cv=none; b=e3hE0ifi3E70eTPrBAdwgXf3OKHbom9W675M0tn9ELLppfMrXpf4hEc7d5YD9kZBkwobbrwzMchsWGlO8kBlPkUNAf0uAtLufyrKfLdd/h6SOQTv/wX3PhH2u7zY3QcfpOEKJXg5Pqxs1Y7M1IavW1Prae/acdVeZhoL7h3dNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407552; c=relaxed/simple;
	bh=TeWgB3oJmmgsYOZjXMuiwSEjeYawK2k9S0iFHWUINW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj5C4NQrGqwpO91iJDCYvms7GomvTqpJDSsO/USwciqyXzlIFy5SzFAgoi81e2+QkMLmFjreBYXKAhomaww//lTuYv/vHy61P9Te5+LiOw0Yag6yGeLVMWu1bxPPvb6Vnl+Az/TipDtl5vykJvj++1pS166aJDST5Nfp1r4Jr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ip7hP+XS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mT5dDmnq; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ip7hP+XS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mT5dDmnq"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id E2C271C000D9;
	Mon,  3 Jun 2024 05:39:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407549; x=1717493949; bh=ubVImeHNhC
	dQRBuphCwodeU0JA7Ee249sBzdNysKjHo=; b=Ip7hP+XSyg2Kh3OiRMeUnccp+f
	u8QWdjpMZ5oOtryKjxikp2ok4HGtOtW71MICAaRg8pq7CMKrhbDP+PKyBX6p0ofj
	TdLgaYeJ1Oijuz+AxEHUpdJcOSPyfauWmWXhbVPY9YwaGL2KY8Co2zvLN/CDycH4
	Fj2mjdTNv1e+d1GVNi0TY0mzmiYEb+009lDnC1779gutGCDMep3ztVAmMDM7e4By
	uPZERr9F7Pv8LeY2q926nB3j9iAte8j8ulnj6K1v/Efpx6qOfGsh/sfRI/aptJzr
	9eQH1QapShvNTu+Ldi4f6R4chH97JDhaSIdDQrH7TxPmRRryhJ38ItDqn8Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407549; x=1717493949; bh=ubVImeHNhCdQRBuphCwodeU0JA7E
	e249sBzdNysKjHo=; b=mT5dDmnqmw+4F4j5goM+7301NsqKSxgkqCvGl0reba19
	Gl7lcd6O4/+VTpolmvTqudvc/5C7sfBqDnu4z3uxKj6st/imNOHhXiTUSMS1c4kQ
	4X+jSYEdVJz3CTBdLLT2JiCBWeMMa4N4BQA6O9ab4qAdMueYJ0yzD/HnqVT45bOb
	6ZOJQdawpeTtgTzN/8Qbs4UF7vs1DMJZ9XuKC9YtwBRp8Pg/f4eL1cxBghj6mevj
	9abvYCbLNAEycXknzLMWwXYJFof0hoDINlSiSUP3hABnHG9/9prWGWSvnVGXDuiq
	QzmrMDUcLStpSW/AATNHpcptBYbAG3cRLZZmWxfmpQ==
X-ME-Sender: <xms:PY9dZgtemm9M7DXWmYttEvqhlqjm1QqH-0MqsqKD63vWAx5gJ_Co9g>
    <xme:PY9dZtcIUrkq8PgZWIl-vL74omf7DMqUKlfbyFEhpSWc3t4E3HSpsdheLebXeXzkv
    pCJAOhzEz5LFn8Gzw>
X-ME-Received: <xmr:PY9dZrxFcyumcBX--7oIkHPDHF82GrjoHVm_N6U_gB1kr203YwE3puCsCTl1O5zW1VuPTGwwM3BT2j-aJsAdpugHEjLkGzUzDnMFyEI1WfJx6nxm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PY9dZjMF76anWAJYj56LZfSzleNB_94ytZjLOViVi3INnlEbHO9ifA>
    <xmx:PY9dZg_NuBMS0GXk4C_MdqVpnH_i_TzSTvRNgQIxi1RMnRJN_iqpBg>
    <xmx:PY9dZrVlpfqOsku6_X7ZoyQOvJyjXdWNpRFD5wKV8kpRncJ2gbyVww>
    <xmx:PY9dZpd9Rn0pKuGPcdKtoQlQw2Rqh4Qc_EJUQlWmnSERuOal_qZucQ>
    <xmx:PY9dZvbsTg3j-R5qrAXxRBjEbDWj9H5ixojqspkpfX_A-yNJeBf7-FnD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6181cab0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:38:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/27] global: convert intentionally-leaking config
 strings to consts
Message-ID: <92cb0b28c65bed0f3cd10e6c4c57b98f199536a9.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jFv3IWlvs+cIDI5F"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--jFv3IWlvs+cIDI5F
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
2.45.1.410.g58bac47f8e.dirty


--jFv3IWlvs+cIDI5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjzkACgkQVbJhu7ck
PpSXZRAAmekqd3GFM5Jd4s2cX4e2+xwSU7gcbeH4ufINjYffl3pRBuKGoPUppCMm
2Im+LWavDyQ/o1Ecf2CP4bM/HvfDAjIqsJ5kYlC97P6RHpZxjBrTbFqCE9wztAVI
1ng3FvNEnmS6x0Qflp5VBgUmEyFygfJNZWizmNzlzXMfv0gOF092j+bX6pm6VNwJ
CEn6a7GBOaE8vIZKN/LYq2rlY9xMK4vAqL4sO+CCjXJWmK0CaaVOd9UncR3REQSa
TYDlHXaRslNtuZXLwZaCYJkjx/M+UOVZVgX8I65fj7kH20rbUWT/6ulGaxim00g0
IZ6c6aG62iAaymdKCUiqONILL/Ex4b7Us5mPfGoH8GZ6wpGQlUvrmh3O9+1H+mP1
BCFwQsASArFkCnnvuG78c4d8NmX//VqRrHzRuJ2Tx1GgGyKsn0HD6vHc7voNg7uc
lxsMEWbl8c5CbXqYnjLZAblTKBuePpuyDX6vux2ggUzGNV1NlBaIFPxCwkMRkZTb
6P/kHN39jfqcVqD60Ixw8l+PjLWIAV+D+l+nz5NDW5cfTfX7i99BeqFgnUjRvDeW
FcLgcgLFpiZQFuk8uWKfXQp5d9c1NoWSSIY+aYOg49Zm9CVVQGO3fVCrmAi8P//v
Zb5icd6tCkjhqVON+5puk0uEHeo4i7rV1j7nNwc3r3fDTcKP99I=
=DzTF
-----END PGP SIGNATURE-----

--jFv3IWlvs+cIDI5F--
