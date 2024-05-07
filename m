Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606417A715
	for <git@vger.kernel.org>; Tue,  7 May 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065911; cv=none; b=JVC1domlseohrCEIJscHxtugWwB1KRj9Vh6CFGo1w1VzoQfXTi8v5i2K6wsU82qgAdN7HUtVkuGl7ThhmNY0EgPdryaYPNu6RT+Sv3naTQE9zAsErXcc0/+HCw0IUvsYNNNy9+vPJGoXetnEvh8UVZBFHeB5genmz1ngS21l4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065911; c=relaxed/simple;
	bh=a3XCGTDQY1dxm9IcXxjXVyBx0jKYQs8wheHLim032HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whx04SUjXeNQXPt49dpSNWNL0kwagMAKCC24Mp97iT36Rgr1ljsIyKGtw9n5TQD1Et+iUXI3qs6bfBlPEvvLW765fdB1F+4L88F/+WcjnAneJ2ETdPEJGn/u7poQnCiVsiFKB3IKo2UucbBe6gmAah5y+fLcMo75OD1M4ymz7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mtKq9sa5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2C5u4MA; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mtKq9sa5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2C5u4MA"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 499451C001BF;
	Tue,  7 May 2024 03:11:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 May 2024 03:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715065907; x=1715152307; bh=n8MIDc8ilS
	tPiRrVxMWU8nmmOdnytScECHDHnVq/GJU=; b=mtKq9sa5Z7pcECHdqoLdWFVOjs
	hs3I2melDv3ekLJUkdNCagfzdh86Xq9z7etZmV/Nn8IMV2NbXhOOzOCpYHHFHsDh
	E+SX62KSdECif87s2BMMPq8lRUBFKukFwko6L27IuMlzWq2bVaerlqezOmmXAZpB
	7w/fJrH3idnydRH4qPSG5zxoGzBZJXVrfSR9EkjySfE8w51XSgSKaxkyLjFIns/x
	rat/Vo5lpvSnFMNDfxFHBH9gfA4VvhVraLR+Ygf1lmN8ILeCcn1M/yxLR/bWdsTm
	HbX+6LaP5o4uIEvO3IevBqu5HxjSN/qnHgJrb/N3DJFBEaTXh6pxWMMpEDRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715065907; x=1715152307; bh=n8MIDc8ilStPiRrVxMWU8nmmOdny
	tScECHDHnVq/GJU=; b=h2C5u4MAg3kgE6d5dqE7LcnEFusP/uF/avoXMGC/o2jC
	9tkdkiS2eN4FKsk1J6l3EnFX7MT8e8q9eVAf828QIYypfZzBhTS4z5kauCyi0Sz+
	hmVBhAxHvgwNSe2JiwEp62l/6XaA4LmDM1gXs8NeEK/XI0ruocpXbde8LR+eF2zx
	NG0u5A5RkVhS0HHY5LEaNvahdKwOr5EEtokwJLeoIxNMEf8ZW2lJu72XE/tQK9Gq
	P4uimmxbDtCUecn7PJw7DD3rYLaWge/2ZgurZeQvZMR5pMpVdqV/P7cLFvQMzs1/
	+23ak0ccNcwP9XQZ3UkJkz0IuzUp3CVyAo3I+VjQXQ==
X-ME-Sender: <xms:M9Q5Zi6rKR31pk5LOOZfcN8EP_fPv-UX6gCAj6nP_NPg0QIF8sfysg>
    <xme:M9Q5Zr5S59TXs3TubDYEWmy8G-qzcbqToDLn6a3-h4MqSXQe5ooP-u0YhzHLz2FHB
    um5ox4Y4ZpChp3AnA>
X-ME-Received: <xmr:M9Q5ZhdHXX2XM2tU8broYFJsud4dujjtu4lbs9hL49LLgEtVMUpwKPJaVBl8Bhzi9N3TopDNUJacNheKNDGWkcRF7C1z47_p4NL-47xlF26MGY0QaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:M9Q5ZvJare5yWJHqkQT4rjU2Aeo2mPtdHW0RyeAcWfZog9M-xUJX-Q>
    <xmx:M9Q5ZmLp4E6i8XkXrxgJkv345qv-g8o4uyceI0WBO-Ev9LC7lJfgKw>
    <xmx:M9Q5ZgwHsEoi50T2Dtfs0tnymWlKC0kJv407KLm-vwlS5X6tXcP9uA>
    <xmx:M9Q5ZqJZ9Uz9ydEEcNX8sDUsFTmr4b5ATvp-hEmJ_9u_apujNsocQg>
    <xmx:M9Q5ZrG6pzW7x8Q7sgZoUb6Qf1J9W8eXnuUfzlRSt3ajrStWSeTxE1si>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 03:11:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e950f570 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 07:11:39 +0000 (UTC)
Date: Tue, 7 May 2024 09:11:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 2/5] refs: add `exclude_patterns` parameter to
 `for_each_fullref_in()`
Message-ID: <4f34bb2e03479b4987ef30330f096650de354b06.1715065736.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
 <cover.1715065736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A5ssdc/wxVSVUmOg"
Content-Disposition: inline
In-Reply-To: <cover.1715065736.git.ps@pks.im>


--A5ssdc/wxVSVUmOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `for_each_fullref_in()` function is supposedly the ref-store-less
equivalent of `refs_for_each_fullref_in()`, but the latter has gained a
new parameter `exclude_patterns` over time. Bring these two functions
back in sync again by adding the parameter to the former function, as
well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  4 ++--
 builtin/show-ref.c  |  4 ++--
 ref-filter.c        | 10 +++++-----
 refs.c              |  8 +++++---
 refs.h              |  3 ++-
 5 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 624182e507..2b28d43939 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -908,8 +908,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_fullref_in("refs/bisect/bad", show_reference, NULL);
-				for_each_fullref_in("refs/bisect/good", anti_reference, NULL);
+				for_each_fullref_in("refs/bisect/bad", NULL, show_reference, NULL);
+				for_each_fullref_in("refs/bisect/good", NULL, anti_reference, NULL);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1c15421e60..3c521dbfd4 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -208,9 +208,9 @@ static int cmd_show_ref__patterns(const struct patterns=
_options *opts,
 		head_ref(show_ref, &show_ref_data);
 	if (opts->heads_only || opts->tags_only) {
 		if (opts->heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
+			for_each_fullref_in("refs/heads/", NULL, show_ref, &show_ref_data);
 		if (opts->tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
+			for_each_fullref_in("refs/tags/", NULL, show_ref, &show_ref_data);
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 59ad6f54dd..eab4beba16 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2640,7 +2640,7 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return for_each_fullref_in("", cb, cb_data);
+		return for_each_fullref_in("", NULL, cb, cb_data);
 	}
=20
 	if (filter->ignore_case) {
@@ -2649,7 +2649,7 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return for_each_fullref_in("", cb, cb_data);
+		return for_each_fullref_in("", NULL, cb, cb_data);
 	}
=20
 	if (!filter->name_patterns[0]) {
@@ -3060,11 +3060,11 @@ static int do_filter_refs(struct ref_filter *filter=
, unsigned int type, each_ref
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind =3D=3D FILTER_REFS_BRANCHES)
-			ret =3D for_each_fullref_in("refs/heads/", fn, cb_data);
+			ret =3D for_each_fullref_in("refs/heads/", NULL, fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_REMOTES)
-			ret =3D for_each_fullref_in("refs/remotes/", fn, cb_data);
+			ret =3D for_each_fullref_in("refs/remotes/", NULL, fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_TAGS)
-			ret =3D for_each_fullref_in("refs/tags/", fn, cb_data);
+			ret =3D for_each_fullref_in("refs/tags/", NULL, fn, cb_data);
 		else if (filter->kind & FILTER_REFS_REGULAR)
 			ret =3D for_each_fullref_in_pattern(filter, fn, cb_data);
=20
diff --git a/refs.c b/refs.c
index 7cafda1c25..00bcc72719 100644
--- a/refs.c
+++ b/refs.c
@@ -1742,10 +1742,12 @@ int for_each_ref_in(const char *prefix, each_ref_fn=
 fn, void *cb_data)
 	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, f=
n, cb_data);
 }
=20
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+int for_each_fullref_in(const char *prefix,
+			const char **exclude_patterns,
+			each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, NULL, fn, 0, 0, cb_data);
+	return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+					prefix, exclude_patterns, fn, cb_data);
 }
=20
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
diff --git a/refs.h b/refs.h
index 10982dcf03..a28de62fb5 100644
--- a/refs.h
+++ b/refs.h
@@ -353,7 +353,8 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn,=
 void *cb_data);
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data);
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+int for_each_fullref_in(const char *prefix, const char **exclude_patterns,
+			each_ref_fn fn, void *cb_data);
=20
 /**
  * iterate all refs in "patterns" by partitioning patterns into disjoint s=
ets
--=20
2.45.0


--A5ssdc/wxVSVUmOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY51C8ACgkQVbJhu7ck
PpQO/w//T8shWvFaJBKdE/llzC23D1k2+Ehy7nzNwS+Di5UKFWpkT3WPNEeSlO5J
P1moydJNYeqLro60qnUXMs+PxT+YU99ZXGI8ExCLya0L0TS6FjnOEyd2TQoSsrPV
UHuiF+Y4PKazpEE8iDtrzTE4+JMjd3hpqtagvX9k/sHuSWJhaV8MlSbJsqM4Gorg
MuBso+QnXF8k2sczSjsCQhdAWbHf2TBhIQndENcnKFcwNyCcQe+oyT/7RWJbPsIE
nZIDKmuuTYGsXdW2slvAa8i1k9cwA7mkeote6twdpWgp80/ToyszDuYK3atLPdzk
OWe9RC7Mb1XGMKf89bD7ts8HZ5IPenp+Qm6yKC737H25nt5bmNQkDDAUK8XEd6P7
VrTHjHB6ywlaXYHNoa4xxkJaViFaaL5/iGtfQ3/Cr8a93aGqvEKNORmroWht9Ap2
bjdKA2HPZq5Bcr9iKkuEx90fk/gbIpSwXP0fgptBwrSNKOQHBfMWgHPWbbYLRt8I
GTSChKtkJqtUOA6D9Fa48iYm7rzF9gy+gptTEQ1kUWZvguRq2SnOGhsQjPI+yFt1
ukKtfaWt4NrjURkls4BUm4syLOagGBG/fXTQm+0/dZmtXUZxTcy52pM0YETK53ZC
P6g0cXx4ulOcPVVjIy+JE6XJOnrisUow1PklGuMKiQKT4crB06I=
=ZXEp
-----END PGP SIGNATURE-----

--A5ssdc/wxVSVUmOg--
