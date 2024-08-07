Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4E198E7A
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013901; cv=none; b=o1JIlyup2zoRWtX0vGw6kJtWD4eGPitIn/M3/rGMLN0emQuAfCtmzhwS9X+qEdwhrnm89b5VOBqN5wJ6h7oiw3aAXpWXmatTv/4aYYqeR8TyJKGP+kUsgoF2VXreMMuVAsNxjQ14Jx7MKLz3Y3HCjIHybv/XKBOQmcWWvIuzsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013901; c=relaxed/simple;
	bh=7h4gmmjHx2KoilC4FJNpHHABvBC11tYLK1zgazKRtKM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ46fS5mA45tkUgKh3eSKGi5OcAL5G1q2iT6Kvr1iIQBW/Wz6zD3zlA24Iuecx0AnJn7dyCKQJI3uSdwBUNz/Nf+Mj6az+qeiTkOclMtUmzo+4B6GnGa8CbleorShSQ6zrUo4D/H92O8vooFJu4ER+7vOseN3DdnI2ntR1l/hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P4k0uo8A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfxEluqR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P4k0uo8A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfxEluqR"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E3FCA1151AED
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:58:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 02:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013897; x=1723100297; bh=0ARFJDgHj+
	NvZQandwmdIZK9E1Gt04hhyz2cE3wrkOc=; b=P4k0uo8AVO3GvlfB8vQy/qMsIe
	8hEd79lUOfUgi+1Nfj7HZbx0UJyDhC0l1avSWkaaVOMc57rcV87pjyX0hqut4BHZ
	noVV9CuumHLL56o+WjO6mmjsBDn+mCM43BWxICMyhqcuWPqj+hMBTTbjt+PKeY2O
	WyDdIab9mDQ68CDDDWr2lhQdcffGtLtfY19zgomwL1+kZ2RcMUYjOLsODZ4EpQMY
	M+IbEU088GDX+BoPx8WyVDYwsvjU4zBX9Ns7u10+ulPmGMH21VTGEXYCRXr1BOCl
	zClXTVB2TehnIRD2JCROo75uC8NHErehWx5gYylGsa+AS4nP+TvIREybMO0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013897; x=1723100297; bh=0ARFJDgHj+NvZQandwmdIZK9E1Gt
	04hhyz2cE3wrkOc=; b=CfxEluqRn2h2aiM260CT5CPoGV4BtLfuQU8UFPq8W9RM
	QLkYDDYWqEgvgGtrelT/s0iUO3p95aruMhT2Lbsbsu67u3yWRdq/TC5LGYIPt+lC
	N6UqNwaEsGInTlIO2z4AkMkWTuHqrazdv3gU/v77rTLh08yIRFoPJP+hVsIYIuaP
	OJkDegk7Fbwm2EMV1r1Tv4DdNMYCqqhbpkrLcPrLRS+pJBDjfBUODYN27gEZfphQ
	4PxTT9jHHS5hHQQwDYDwFdUb88WFe7grHLRjA/n8A6owXGYaJveKf57YrpGmE4y6
	4lq+kXdAgfpEdTWQi3Wig8xyIMOXriur50i4jf18tA==
X-ME-Sender: <xms:CRuzZjMVYFKMDUE8bRg6lQFlVk67uVjGYIWgSbyC4ViMg0EdLjtDbw>
    <xme:CRuzZt_07nKDIXVcnBz3MHb0GPZvPNzXGk3pAMj1rY_l8u2HUP3OkAEEcs2PDfUjl
    -3NKOrZlIyraGkQGg>
X-ME-Received: <xmr:CRuzZiT1srY9nNtcEq--PPqJZ3dztMbcQg85CQ3-FlknJIS-fOQRzTkl5JBtxwTCH-kynY1yg0n1lHPXAlsZgQIi2hIuIFEbHfNL53tkqgtS20WO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:CRuzZnskhAzjcCTrghBrsk_6fvAvLwqZjbMwv7O_YjwSLdD1skViMQ>
    <xmx:CRuzZrfOsZQd-trUTVGuU_daVyPuiuOxJ28EioKq4rhnI0k8WW2bmw>
    <xmx:CRuzZj0KCNP3c0U0q--MEYPEyusMjBmda1Dkz8CdKT1LgCw_RLeYxg>
    <xmx:CRuzZn-7eNyjBSnULw09pAkm81nRtFT2iKS3Z8e5OpL2Bdy-JFA2jg>
    <xmx:CRuzZjEkz3Uh90DQGHcn_DvqH9fF9We0N0nmF17uVQpvda_K0-bUaP09>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:58:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f541fe9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:58:13 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:58:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/20] config: hide functions using `the_repository` by
 default
Message-ID: <43757f30770bf5a27fd8d7ac55a343185dbe62b3.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54yWUY06bPJueD0z"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--54yWUY06bPJueD0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The config subsytem provides a bunch of legacy functions that read or
set configuration for `the_repository`. The use of those functions is
discouraged, and it is easy to miss the implicit dependency on
`the_repository` that calls to those functions may cause.

Move all config-related functions that use `the_repository` into a block
that gets only conditionally compiled depending on whether or not the
macro has been defined. This also removes all dependencies on that
variable in "config.c", allowing us to remove the definition of said
preprocessor macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 130 -----------------------------
 config.h | 249 ++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 171 insertions(+), 208 deletions(-)

diff --git a/config.c b/config.c
index 08437f75e5..c4fdbf6e1b 100644
--- a/config.c
+++ b/config.c
@@ -6,8 +6,6 @@
  *
  */
=20
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
@@ -2695,78 +2693,6 @@ void git_protected_config(config_fn_t fn, void *data)
 	configset_iter(&protected_config, fn, data);
 }
=20
-/* Functions used historically to read configuration from 'the_repository'=
 */
-void git_config(config_fn_t fn, void *data)
-{
-	repo_config(the_repository, fn, data);
-}
-
-void git_config_clear(void)
-{
-	repo_config_clear(the_repository);
-}
-
-int git_config_get(const char *key)
-{
-	return repo_config_get(the_repository, key);
-}
-
-int git_config_get_value(const char *key, const char **value)
-{
-	return repo_config_get_value(the_repository, key, value);
-}
-
-int git_config_get_value_multi(const char *key, const struct string_list *=
*dest)
-{
-	return repo_config_get_value_multi(the_repository, key, dest);
-}
-
-int git_config_get_string_multi(const char *key,
-				const struct string_list **dest)
-{
-	return repo_config_get_string_multi(the_repository, key, dest);
-}
-
-int git_config_get_string(const char *key, char **dest)
-{
-	return repo_config_get_string(the_repository, key, dest);
-}
-
-int git_config_get_string_tmp(const char *key, const char **dest)
-{
-	return repo_config_get_string_tmp(the_repository, key, dest);
-}
-
-int git_config_get_int(const char *key, int *dest)
-{
-	return repo_config_get_int(the_repository, key, dest);
-}
-
-int git_config_get_ulong(const char *key, unsigned long *dest)
-{
-	return repo_config_get_ulong(the_repository, key, dest);
-}
-
-int git_config_get_bool(const char *key, int *dest)
-{
-	return repo_config_get_bool(the_repository, key, dest);
-}
-
-int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
-{
-	return repo_config_get_bool_or_int(the_repository, key, is_bool, dest);
-}
-
-int git_config_get_maybe_bool(const char *key, int *dest)
-{
-	return repo_config_get_maybe_bool(the_repository, key, dest);
-}
-
-int git_config_get_pathname(const char *key, char **dest)
-{
-	return repo_config_get_pathname(the_repository, key, dest);
-}
-
 int repo_config_get_expiry(struct repository *r, const char *key, const ch=
ar **output)
 {
 	int ret =3D repo_config_get_string(r, key, (char **)output);
@@ -3186,35 +3112,17 @@ int repo_config_set_in_file_gently(struct repositor=
y *r, const char *config_file
 	return repo_config_set_multivar_in_file_gently(r, config_filename, key, v=
alue, NULL, comment, 0);
 }
=20
-int git_config_set_in_file_gently(const char *config_filename,
-				  const char *key, const char *comment, const char *value)
-{
-	return repo_config_set_in_file_gently(the_repository, config_filename,
-					      key, comment, value);
-}
-
 void repo_config_set_in_file(struct repository *r, const char *config_file=
name,
 			     const char *key, const char *value)
 {
 	repo_config_set_multivar_in_file(r, config_filename, key, value, NULL, 0);
 }
=20
-void git_config_set_in_file(const char *config_filename,
-			    const char *key, const char *value)
-{
-	repo_config_set_in_file(the_repository, config_filename, key, value);
-}
-
 int repo_config_set_gently(struct repository *r, const char *key, const ch=
ar *value)
 {
 	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
 }
=20
-int git_config_set_gently(const char *key, const char *value)
-{
-	return repo_config_set_gently(the_repository, key, value);
-}
-
 int repo_config_set_worktree_gently(struct repository *r,
 				    const char *key, const char *value)
 {
@@ -3236,11 +3144,6 @@ void repo_config_set(struct repository *r, const cha=
r *key, const char *value)
 	trace2_cmd_set_config(key, value);
 }
=20
-void git_config_set(const char *key, const char *value)
-{
-	repo_config_set(the_repository, key, value);
-}
-
 char *git_config_prepare_comment_string(const char *comment)
 {
 	size_t leading_blanks;
@@ -3569,17 +3472,6 @@ int repo_config_set_multivar_in_file_gently(struct r=
epository *r,
 	goto out_free;
 }
=20
-int git_config_set_multivar_in_file_gently(const char *config_filename,
-					   const char *key, const char *value,
-					   const char *value_pattern,
-					   const char *comment,
-					   unsigned flags)
-{
-	return repo_config_set_multivar_in_file_gently(the_repository, config_fil=
ename,
-						       key, value, value_pattern,
-						       comment, flags);
-}
-
 void repo_config_set_multivar_in_file(struct repository *r,
 				      const char *config_filename,
 				      const char *key, const char *value,
@@ -3594,21 +3486,6 @@ void repo_config_set_multivar_in_file(struct reposit=
ory *r,
 		die(_("could not unset '%s'"), key);
 }
=20
-void git_config_set_multivar_in_file(const char *config_filename,
-				     const char *key, const char *value,
-				     const char *value_pattern, unsigned flags)
-{
-	repo_config_set_multivar_in_file(the_repository, config_filename,
-					 key, value, value_pattern, flags);
-}
-
-int git_config_set_multivar_gently(const char *key, const char *value,
-				   const char *value_pattern, unsigned flags)
-{
-	return repo_config_set_multivar_gently(the_repository, key, value,
-					       value_pattern, flags);
-}
-
 int repo_config_set_multivar_gently(struct repository *r, const char *key,
 				    const char *value,
 				    const char *value_pattern, unsigned flags)
@@ -3632,13 +3509,6 @@ void repo_config_set_multivar(struct repository *r,
 	free(file);
 }
=20
-void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_pattern, unsigned flags)
-{
-	repo_config_set_multivar(the_repository, key, value,
-				 value_pattern, flags);
-}
-
 static size_t section_name_match (const char *buf, const char *name)
 {
 	size_t i =3D 0, j =3D 0;
diff --git a/config.h b/config.h
index 589d6dae26..4d319a4193 100644
--- a/config.h
+++ b/config.h
@@ -26,7 +26,7 @@ struct object_id;
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
 #define CONFIG_NO_SECTION_OR_NAME 2
-/* git_config_set_gently(), git_config_set_multivar_gently() return the ab=
ove or these: */
+/* repo_config_set_gently(), repo_config_set_multivar_gently() return the =
above or these: */
 #define CONFIG_NO_LOCK -1
 #define CONFIG_INVALID_FILE 3
 #define CONFIG_NO_WRITE 4
@@ -170,9 +170,9 @@ int git_default_config(const char *, const char *,
=20
 /**
  * Read a specific file in git-config format.
- * This function takes the same callback and data parameters as `git_confi=
g`.
+ * This function takes the same callback and data parameters as `repo_conf=
ig`.
  *
- * Unlike git_config(), this function does not respect includes.
+ * Unlike repo_config(), this function does not respect includes.
  */
 int git_config_from_file(config_fn_t fn, const char *, void *);
=20
@@ -198,9 +198,9 @@ void read_very_early_config(config_fn_t cb, void *data);
 /**
  * Most programs will simply want to look up variables in all config files
  * that Git knows about, using the normal precedence rules. To do this,
- * call `git_config` with a callback function and void data pointer.
+ * call `repo_config` with a callback function and void data pointer.
  *
- * `git_config` will read all config sources in order of increasing
+ * `repo_config` will read all config sources in order of increasing
  * priority. Thus a callback should typically overwrite previously-seen
  * entries with new ones (e.g., if both the user-wide `~/.gitconfig` and
  * repo-specific `.git/config` contain `color.ui`, the config machinery
@@ -210,11 +210,11 @@ void read_very_early_config(config_fn_t cb, void *dat=
a);
  *
  * Unlike git_config_from_file(), this function respects includes.
  */
-void git_config(config_fn_t fn, void *);
+void repo_config(struct repository *r, config_fn_t fn, void *);
=20
 /**
  * Lets the caller examine config while adjusting some of the default
- * behavior of `git_config`. It should almost never be used by "regular"
+ * behavior of `repo_config`. It should almost never be used by "regular"
  * Git code that is looking up configuration variables.
  * It is intended for advanced callers like `git-config`, which are
  * intentionally tweaking the normal config-lookup process.
@@ -223,12 +223,12 @@ void git_config(config_fn_t fn, void *);
  * - `config_source`
  * If this parameter is non-NULL, it specifies the source to parse for
  * configuration, rather than looking in the usual files. See `struct
- * git_config_source` in `config.h` for details. Regular `git_config` defa=
ults
+ * git_config_source` in `config.h` for details. Regular `repo_config` def=
aults
  * to `NULL`.
  *
  * - `opts`
  * Specify options to adjust the behavior of parsing config files. See `st=
ruct
- * config_options` in `config.h` for details. As an example: regular `git_=
config`
+ * config_options` in `config.h` for details. As an example: regular `repo=
_config`
  * sets `opts.respect_includes` to `1` by default.
  */
 int config_with_options(config_fn_t fn, void *,
@@ -297,7 +297,6 @@ int git_config_pathname(char **, const char *, const ch=
ar *);
=20
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
-int git_config_set_in_file_gently(const char *, const char *, const char *=
, const char *);
 int repo_config_set_in_file_gently(struct repository *r, const char *confi=
g_filename,
 				   const char *key, const char *comment, const char *value);
=20
@@ -305,10 +304,8 @@ int repo_config_set_in_file_gently(struct repository *=
r, const char *config_file
  * write config values to a specific config file, takes a key/value pair as
  * parameter.
  */
-void git_config_set_in_file(const char *, const char *, const char *);
 void repo_config_set_in_file(struct repository *, const char *, const char=
 *, const char *);
=20
-int git_config_set_gently(const char *, const char *);
 int repo_config_set_gently(struct repository *r, const char *, const char =
*);
=20
 /**
@@ -321,14 +318,13 @@ int repo_config_set_worktree_gently(struct repository=
 *, const char *, const cha
 /**
  * write config values to `.git/config`, takes a key/value pair as paramet=
er.
  */
-void git_config_set(const char *, const char *);
 void repo_config_set(struct repository *, const char *, const char *);
=20
 int git_config_parse_key(const char *, char **, size_t *);
=20
 /*
  * The following macros specify flag bits that alter the behavior
- * of the git_config_set_multivar*() methods.
+ * of the repo_config_set_multivar*() methods.
  */
=20
 /*
@@ -345,11 +341,8 @@ int git_config_parse_key(const char *, char **, size_t=
 *);
  */
 #define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
=20
-int git_config_set_multivar_gently(const char *, const char *, const char =
*, unsigned);
 int repo_config_set_multivar_gently(struct repository *, const char *, con=
st char *, const char *, unsigned);
-void git_config_set_multivar(const char *, const char *, const char *, uns=
igned);
 void repo_config_set_multivar(struct repository *r, const char *, const ch=
ar *, const char *, unsigned);
-int git_config_set_multivar_in_file_gently(const char *, const char *, con=
st char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_in_file_gently(struct repository *, const cha=
r *, const char *, const char *, const char *, const char *, unsigned);
=20
 char *git_config_prepare_comment_string(const char *);
@@ -374,11 +367,6 @@ char *git_config_prepare_comment_string(const char *);
  *
  * It returns 0 on success.
  */
-void git_config_set_multivar_in_file(const char *config_filename,
-				     const char *key,
-				     const char *value,
-				     const char *value_pattern,
-				     unsigned flags);
 void repo_config_set_multivar_in_file(struct repository *r,
 				      const char *config_filename,
 				      const char *key,
@@ -563,39 +551,11 @@ int git_configset_get_bool_or_int(struct config_set *=
cs, const char *key, int *i
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, i=
nt *dest);
 int git_configset_get_pathname(struct config_set *cs, const char *key, cha=
r **dest);
=20
-/* Functions for reading a repository's config */
-struct repository;
-void repo_config(struct repository *repo, config_fn_t fn, void *data);
-
 /**
  * Run only the discover part of the repo_config_get_*() functions
  * below, in addition to 1 if not found, returns negative values on
  * error (e.g. if the key itself is invalid).
  */
-RESULT_MUST_BE_USED
-int repo_config_get(struct repository *repo, const char *key);
-int repo_config_get_value(struct repository *repo,
-			  const char *key, const char **value);
-RESULT_MUST_BE_USED
-int repo_config_get_value_multi(struct repository *repo, const char *key,
-				const struct string_list **dest);
-RESULT_MUST_BE_USED
-int repo_config_get_string_multi(struct repository *repo, const char *key,
-				 const struct string_list **dest);
-int repo_config_get_string(struct repository *repo,
-			   const char *key, char **dest);
-int repo_config_get_string_tmp(struct repository *repo,
-			       const char *key, const char **dest);
-int repo_config_get_int(struct repository *repo,
-			const char *key, int *dest);
-int repo_config_get_ulong(struct repository *repo,
-			  const char *key, unsigned long *dest);
-int repo_config_get_bool(struct repository *repo,
-			 const char *key, int *dest);
-int repo_config_get_bool_or_int(struct repository *repo,
-				const char *key, int *is_bool, int *dest);
-int repo_config_get_maybe_bool(struct repository *repo,
-			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, char **dest);
=20
@@ -611,17 +571,17 @@ void git_protected_config(config_fn_t fn, void *data);
  * -------------------------------
  *
  * For programs wanting to query for specific variables in a non-callback
- * manner, the config API provides two functions `git_config_get_value`
- * and `git_config_get_value_multi`. They both read values from an internal
+ * manner, the config API provides two functions `repo_config_get_value`
+ * and `repo_config_get_value_multi`. They both read values from an intern=
al
  * cache generated previously from reading the config files.
  *
- * For those git_config_get*() functions that aren't documented,
+ * For those repo_config_get*() functions that aren't documented,
  * consult the corresponding repo_config_get*() function's
  * documentation.
  */
=20
 RESULT_MUST_BE_USED
-int git_config_get(const char *key);
+int repo_config_get(struct repository *r, const char *key);
=20
 /**
  * Finds the highest-priority value for the configuration variable `key`,
@@ -630,7 +590,7 @@ int git_config_get(const char *key);
  * `value`. The caller should not free or modify `value`, as it is owned
  * by the cache.
  */
-int git_config_get_value(const char *key, const char **value);
+int repo_config_get_value(struct repository *r, const char *key, const cha=
r **value);
=20
 /**
  * Finds and returns the value list, sorted in order of increasing priority
@@ -641,16 +601,15 @@ int git_config_get_value(const char *key, const char =
**value);
  * owned by the cache.
  */
 RESULT_MUST_BE_USED
-int git_config_get_value_multi(const char *key,
-			       const struct string_list **dest);
-RESULT_MUST_BE_USED
-int git_config_get_string_multi(const char *key,
+int repo_config_get_value_multi(struct repository *r, const char *key,
 				const struct string_list **dest);
+RESULT_MUST_BE_USED
+int repo_config_get_string_multi(struct repository *r, const char *key,
+				 const struct string_list **dest);
=20
 /**
  * Resets and invalidates the config cache.
  */
-void git_config_clear(void);
 void repo_config_clear(struct repository *repo);
=20
 /**
@@ -659,14 +618,15 @@ void repo_config_clear(struct repository *repo);
  * error message and returns -1. When the configuration variable `key` is
  * not found, returns 1 without touching `dest`.
  */
-int git_config_get_string(const char *key, char **dest);
+int repo_config_get_string(struct repository *r, const char *key, char **d=
est);
=20
 /**
- * Similar to `git_config_get_string`, but does not allocate any new
+ * Similar to `repo_config_get_string`, but does not allocate any new
  * memory; on success `dest` will point to memory owned by the config
  * machinery, which could be invalidated if it is discarded and reloaded.
  */
-int git_config_get_string_tmp(const char *key, const char **dest);
+int repo_config_get_string_tmp(struct repository *r,
+			       const char *key, const char **dest);
=20
 /**
  * Finds and parses the value to an integer for the configuration variable
@@ -674,12 +634,13 @@ int git_config_get_string_tmp(const char *key, const =
char **dest);
  * `dest` and returns 0. When the configuration variable `key` is not foun=
d,
  * returns 1 without touching `dest`.
  */
-int git_config_get_int(const char *key, int *dest);
+int repo_config_get_int(struct repository *r, const char *key, int *dest);
=20
 /**
- * Similar to `git_config_get_int` but for unsigned longs.
+ * Similar to `repo_config_get_int` but for unsigned longs.
  */
-int git_config_get_ulong(const char *key, unsigned long *dest);
+int repo_config_get_ulong(struct repository *r,
+			  const char *key, unsigned long *dest);
=20
 /**
  * Finds and parses the value into a boolean value, for the configuration
@@ -690,25 +651,21 @@ int git_config_get_ulong(const char *key, unsigned lo=
ng *dest);
  * configuration variable `key` is not found, returns 1 without touching
  * `dest`.
  */
-int git_config_get_bool(const char *key, int *dest);
+int repo_config_get_bool(struct repository *r, const char *key, int *dest);
=20
 /**
- * Similar to `git_config_get_bool`, except that integers are copied as-is,
+ * Similar to `repo_config_get_bool`, except that integers are copied as-i=
s,
  * and `is_bool` flag is unset.
  */
-int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+int repo_config_get_bool_or_int(struct repository *r, const char *key,
+				int *is_bool, int *dest);
=20
 /**
- * Similar to `git_config_get_bool`, except that it returns -1 on error
+ * Similar to `repo_config_get_bool`, except that it returns -1 on error
  * rather than dying.
  */
-int git_config_get_maybe_bool(const char *key, int *dest);
-
-/**
- * Similar to `git_config_get_string`, but expands `~` or `~user` into
- * the user's home directory when found at the beginning of the path.
- */
-int git_config_get_pathname(const char *key, char **dest);
+int repo_config_get_maybe_bool(struct repository *r,
+			      const char *key, int *dest);
=20
 int repo_config_get_index_threads(struct repository *r, int *dest);
 int repo_config_get_split_index(struct repository *r);
@@ -732,7 +689,7 @@ NORETURN void git_die_config(struct repository *r, cons=
t char *key, const char *
 /**
  * Helper function which formats the die error message according to the
  * parameters entered. Used by `git_die_config()`. It can be used by calle=
rs
- * handling `git_config_get_value_multi()` to print the correct error mess=
age
+ * handling `repo_config_get_value_multi()` to print the correct error mes=
sage
  * for the desired value.
  */
 NORETURN void git_die_config_linenr(const char *key, const char *filename,=
 int linenr);
@@ -741,4 +698,140 @@ NORETURN void git_die_config_linenr(const char *key, =
const char *filename, int l
 	lookup_config(mapping, ARRAY_SIZE(mapping), var)
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
=20
+# ifdef USE_THE_REPOSITORY_VARIABLE
+static inline void git_config(config_fn_t fn, void *data)
+{
+	repo_config(the_repository, fn, data);
+}
+
+static inline void git_config_clear(void)
+{
+	repo_config_clear(the_repository);
+}
+
+static inline int git_config_get(const char *key)
+{
+	return repo_config_get(the_repository, key);
+}
+
+static inline int git_config_get_value(const char *key, const char **value)
+{
+	return repo_config_get_value(the_repository, key, value);
+}
+
+static inline int git_config_get_value_multi(const char *key, const struct=
 string_list **dest)
+{
+	return repo_config_get_value_multi(the_repository, key, dest);
+}
+
+static inline int git_config_get_string_multi(const char *key,
+				const struct string_list **dest)
+{
+	return repo_config_get_string_multi(the_repository, key, dest);
+}
+
+static inline int git_config_get_string(const char *key, char **dest)
+{
+	return repo_config_get_string(the_repository, key, dest);
+}
+
+static inline int git_config_get_string_tmp(const char *key, const char **=
dest)
+{
+	return repo_config_get_string_tmp(the_repository, key, dest);
+}
+
+static inline int git_config_get_int(const char *key, int *dest)
+{
+	return repo_config_get_int(the_repository, key, dest);
+}
+
+static inline int git_config_get_ulong(const char *key, unsigned long *des=
t)
+{
+	return repo_config_get_ulong(the_repository, key, dest);
+}
+
+static inline int git_config_get_bool(const char *key, int *dest)
+{
+	return repo_config_get_bool(the_repository, key, dest);
+}
+
+static inline int git_config_get_bool_or_int(const char *key, int *is_bool=
, int *dest)
+{
+	return repo_config_get_bool_or_int(the_repository, key, is_bool, dest);
+}
+
+static inline int git_config_get_maybe_bool(const char *key, int *dest)
+{
+	return repo_config_get_maybe_bool(the_repository, key, dest);
+}
+
+static inline int git_config_get_pathname(const char *key, char **dest)
+{
+	return repo_config_get_pathname(the_repository, key, dest);
+}
+
+static inline void git_config_set_in_file(const char *config_filename,
+					  const char *key, const char *value)
+{
+	repo_config_set_in_file(the_repository, config_filename, key, value);
+}
+
+static inline int git_config_set_gently(const char *key, const char *value)
+{
+	return repo_config_set_gently(the_repository, key, value);
+}
+
+static inline void git_config_set(const char *key, const char *value)
+{
+	repo_config_set(the_repository, key, value);
+}
+
+static inline int git_config_set_in_file_gently(
+	const char *config_filename,
+	const char *key,
+	const char *comment,
+	const char *value)
+{
+	return repo_config_set_in_file_gently(the_repository, config_filename,
+					      key, comment, value);
+}
+
+static inline int git_config_set_multivar_in_file_gently(
+	const char *config_filename,
+	const char *key, const char *value,
+	const char *value_pattern,
+	const char *comment,
+	unsigned flags)
+{
+	return repo_config_set_multivar_in_file_gently(the_repository, config_fil=
ename,
+						       key, value, value_pattern,
+						       comment, flags);
+}
+
+static inline void git_config_set_multivar_in_file(
+	const char *config_filename,
+	const char *key,
+	const char *value,
+	const char *value_pattern,
+	unsigned flags)
+{
+	repo_config_set_multivar_in_file(the_repository, config_filename,
+					 key, value, value_pattern, flags);
+}
+
+static inline int git_config_set_multivar_gently(const char *key, const ch=
ar *value,
+				   const char *value_pattern, unsigned flags)
+{
+	return repo_config_set_multivar_gently(the_repository, key, value,
+					       value_pattern, flags);
+}
+
+static inline void git_config_set_multivar(const char *key, const char *va=
lue,
+			     const char *value_pattern, unsigned flags)
+{
+	repo_config_set_multivar(the_repository, key, value,
+				 value_pattern, flags);
+}
+# endif /* USE_THE_REPOSITORY_VARIABLE */
+
 #endif /* CONFIG_H */
--=20
2.46.0.dirty


--54yWUY06bPJueD0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGwYACgkQVbJhu7ck
PpQUkw/9FSJPgNdy0ZAGxxpscCi7LkYPGwgX3iJcMv1rRnkFlE2rEvkMn1FKb7OI
VWe4juuA2nn3dxW7fXI7MBWyYiC3hG5GOshne8FByMbpgfEhtYw71cBVxHwG+jjO
XWhEEw6HRxrZ3gwrLbYBdjYea6rNgkFWvwMyR82Tq62b09z4SZHWVcBF8YBEmDkt
nkhSV8uJwSLw87ZVgHIhpttYE0F+jJi0hknriyqEgIm8VJTR9fBgFDnFZH3mDJqY
OItSTqFhO+92jwNqyF4O99KBLcArWdeurgQD3FcmfphYxDuYgYkPPg6r50k3K7U2
1t9AkBMu4Q630yIF6aGKe2gLykdCn4fdR/P4i0mL+IRi4J3EFF++QXZxUY8brdVp
aX4bJ3hzkA8oTX0mOaM72rJvdIF+BOySz7q7O+GCYUC+bkJggG5mw6AzVtdKbQEu
h9oq31D0V1U6ZLziPQaJa7DbFn5Xol/2db/weX+Z6wPyPDKJe9kXVkfzX3PkW+KY
3EfmmBciwwnLr/Jdtu0sFxGYpGLgQ18f4ZY8ukSbMJw6TISWyMAD4Wra8my5Ihzv
Hpg7DKLQu7KDKq6AoEFeBSjggfu89xICAh/IeAfK3FFQD4SsKE6zwf/Y8Q+nrm7f
zWoP8eXHvf5mggqT8Y7tkHvK9eYJZ7APQafB7nnB/094/g3tiZ4=
=refm
-----END PGP SIGNATURE-----

--54yWUY06bPJueD0z--
