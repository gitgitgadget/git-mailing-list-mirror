Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FA197A61
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540469; cv=none; b=jpciSmCX3Yf69IXZzT69snyr8jvDX77jBNpDzRFIueiqAw44vSid2FQ/uY2YgVGfwiq1hnS4lV9fIfYP5e2ZKzNafPhUD7/61snLJo9gVXrHDLtZfq352Cbcuk1tn1HnkHVsfV2dPJWwc3oPujD+esQzM1yzBce748M5gq7A4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540469; c=relaxed/simple;
	bh=vcvJ2gU0T4725WY1W+MvMV+AevxExkj4K0ujkx/K0aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXCdjC51/lQ7opjSi1ttgY9YQMiaJdv2exHlmdpUVrVIAt+dQondD8p6oFeD+siCMs2AdMyCxzDfd3olbgcUi09gjZaTl9GafDE2bbw2xc2K1r0TRUxUqZSS9YzWnX8VNjNT13ieKgn8UPvzwBKXI0nk2EEmHULb8rTPAvmrM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CA8D75w0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gja20jwD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CA8D75w0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gja20jwD"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7D7D31389D07;
	Tue, 13 Aug 2024 05:14:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540466; x=1723626866; bh=Vd/lrhpHZL
	Tb4FWCV6kvAck7ro2/ITBtYZQThYlMsfU=; b=CA8D75w0W63sFVEfGaOJ8mHLBO
	/5hNNYSE8r6mjxTVil28iVM1uM0Nef30D8SKgLGotDyYVGytMVDHiRZC8bWoYZ6A
	2yOGd2vfYL8VfDbOgfTULZJYrDjKeFnHTf42uukXbIiLTScZ4K4NsueekaS9qbNf
	PY3nEWoUDRjul3jBRU/el1R4u3vZZJ4sC48VkOywCoWQSaIQd9E0feL4PGSrhMpD
	O2bRVv+WXPkc5Flt37CJMDG+T5eyR71uf7NffTNUGJQI1cERv/2jNy7x8mZibMAk
	FQfcbxwXpdvThgGICtbJ2IMiFAg5reqA/4ojxvWvGmeXh+NvyAfUuW8rL+jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540466; x=1723626866; bh=Vd/lrhpHZLTb4FWCV6kvAck7ro2/
	ITBtYZQThYlMsfU=; b=Gja20jwDihTAOnfF52UD1HIUPI5k74I/dFKlDtBsodue
	s6ZrtbWbgjIoNDb4tSQlXcX4nj3gJOPT7smZtIOB14d5RHfd8/flVT+AObA0htXx
	yLq8j6KVptpbHRd1rUIix7haxd5n8he/48bU3OwVTiwMb8wGY935EfnsQkH9eOs1
	B1vX9AMLqR+I6G72fkLeKd5J9tyOJ6loXCzFW7oW77iu+TPzUOwEj2OjRWVEUtm5
	JoU/jjQpJytKPI80XxaG28rin4hfTOHMGSpyLJ+DqVvVBvyN9Lft0munRI+Ev6S/
	bvEpK2z5G6wVAsaTykU0i0a+6GOz0Hju3DQR6FrnPA==
X-ME-Sender: <xms:8iO7ZlENKPCQnYjxkXlEY16B8lfPTs37SLt1f9z0Mv8wlRw6wKt1-w>
    <xme:8iO7ZqWNpgnk59yu0hQ1qUdV4WUlVFJSy1hE0JNxnme1ztI1WNJPwEcFIHDCRn5sH
    gGz2pE_5VKkgz94_w>
X-ME-Received: <xmr:8iO7ZnLlqGCNaHHpRGr43M3f5Zew49u-8KTgS8Rx7KsI23vLjvixvYmA93H0aZFpjanKHmHRl4G6Cd4B5VftnhoU5K3fmpCc0PEbZfqvimUoww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8iO7ZrGJCYwNUUvbkWgcL3BT2cah59_yc9l_8O4y787c85If54z5KQ>
    <xmx:8iO7ZrVqNNvIgqexysI19w-ZluSNUcAfFjSQsCRVpIDVVL6vsDSGlQ>
    <xmx:8iO7ZmOp8kJX51XUpkACKFrEZguz5D7aSDGsnrS-DzIi7jDOEMenvw>
    <xmx:8iO7Zq2iYvluxEqOE6yh_1R7nk-_uzYErCeRh0o4tRzKNoq0LIBI-A>
    <xmx:8iO7ZmS4czaNGZ7DRrm9hLvBDEJ4uXVdhdMbhztbKNpRtPGsS7sxYawX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 237fa457 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:14:09 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/20] config: hide functions using `the_repository` by
 default
Message-ID: <467cd481f54e6e8735a221482e435e3cd5419291.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

The config subsystem provides a bunch of legacy functions that read or
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
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
@@ -2695,78 +2693,6 @@ void git_protected_config(config_fn_t fn, void *data)
 	configset_iter(&protected_config, fn, data);
 }
 
-/* Functions used historically to read configuration from 'the_repository' */
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
-int git_config_get_value_multi(const char *key, const struct string_list **dest)
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
 int repo_config_get_expiry(struct repository *r, const char *key, const char **output)
 {
 	int ret = repo_config_get_string(r, key, (char **)output);
@@ -3186,35 +3112,17 @@ int repo_config_set_in_file_gently(struct repository *r, const char *config_file
 	return repo_config_set_multivar_in_file_gently(r, config_filename, key, value, NULL, comment, 0);
 }
 
-int git_config_set_in_file_gently(const char *config_filename,
-				  const char *key, const char *comment, const char *value)
-{
-	return repo_config_set_in_file_gently(the_repository, config_filename,
-					      key, comment, value);
-}
-
 void repo_config_set_in_file(struct repository *r, const char *config_filename,
 			     const char *key, const char *value)
 {
 	repo_config_set_multivar_in_file(r, config_filename, key, value, NULL, 0);
 }
 
-void git_config_set_in_file(const char *config_filename,
-			    const char *key, const char *value)
-{
-	repo_config_set_in_file(the_repository, config_filename, key, value);
-}
-
 int repo_config_set_gently(struct repository *r, const char *key, const char *value)
 {
 	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
 }
 
-int git_config_set_gently(const char *key, const char *value)
-{
-	return repo_config_set_gently(the_repository, key, value);
-}
-
 int repo_config_set_worktree_gently(struct repository *r,
 				    const char *key, const char *value)
 {
@@ -3236,11 +3144,6 @@ void repo_config_set(struct repository *r, const char *key, const char *value)
 	trace2_cmd_set_config(key, value);
 }
 
-void git_config_set(const char *key, const char *value)
-{
-	repo_config_set(the_repository, key, value);
-}
-
 char *git_config_prepare_comment_string(const char *comment)
 {
 	size_t leading_blanks;
@@ -3569,17 +3472,6 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	goto out_free;
 }
 
-int git_config_set_multivar_in_file_gently(const char *config_filename,
-					   const char *key, const char *value,
-					   const char *value_pattern,
-					   const char *comment,
-					   unsigned flags)
-{
-	return repo_config_set_multivar_in_file_gently(the_repository, config_filename,
-						       key, value, value_pattern,
-						       comment, flags);
-}
-
 void repo_config_set_multivar_in_file(struct repository *r,
 				      const char *config_filename,
 				      const char *key, const char *value,
@@ -3594,21 +3486,6 @@ void repo_config_set_multivar_in_file(struct repository *r,
 		die(_("could not unset '%s'"), key);
 }
 
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
 
-void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_pattern, unsigned flags)
-{
-	repo_config_set_multivar(the_repository, key, value,
-				 value_pattern, flags);
-}
-
 static size_t section_name_match (const char *buf, const char *name)
 {
 	size_t i = 0, j = 0;
diff --git a/config.h b/config.h
index 589d6dae26..4d319a4193 100644
--- a/config.h
+++ b/config.h
@@ -26,7 +26,7 @@ struct object_id;
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
 #define CONFIG_NO_SECTION_OR_NAME 2
-/* git_config_set_gently(), git_config_set_multivar_gently() return the above or these: */
+/* repo_config_set_gently(), repo_config_set_multivar_gently() return the above or these: */
 #define CONFIG_NO_LOCK -1
 #define CONFIG_INVALID_FILE 3
 #define CONFIG_NO_WRITE 4
@@ -170,9 +170,9 @@ int git_default_config(const char *, const char *,
 
 /**
  * Read a specific file in git-config format.
- * This function takes the same callback and data parameters as `git_config`.
+ * This function takes the same callback and data parameters as `repo_config`.
  *
- * Unlike git_config(), this function does not respect includes.
+ * Unlike repo_config(), this function does not respect includes.
  */
 int git_config_from_file(config_fn_t fn, const char *, void *);
 
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
@@ -210,11 +210,11 @@ void read_very_early_config(config_fn_t cb, void *data);
  *
  * Unlike git_config_from_file(), this function respects includes.
  */
-void git_config(config_fn_t fn, void *);
+void repo_config(struct repository *r, config_fn_t fn, void *);
 
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
- * git_config_source` in `config.h` for details. Regular `git_config` defaults
+ * git_config_source` in `config.h` for details. Regular `repo_config` defaults
  * to `NULL`.
  *
  * - `opts`
  * Specify options to adjust the behavior of parsing config files. See `struct
- * config_options` in `config.h` for details. As an example: regular `git_config`
+ * config_options` in `config.h` for details. As an example: regular `repo_config`
  * sets `opts.respect_includes` to `1` by default.
  */
 int config_with_options(config_fn_t fn, void *,
@@ -297,7 +297,6 @@ int git_config_pathname(char **, const char *, const char *);
 
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
-int git_config_set_in_file_gently(const char *, const char *, const char *, const char *);
 int repo_config_set_in_file_gently(struct repository *r, const char *config_filename,
 				   const char *key, const char *comment, const char *value);
 
@@ -305,10 +304,8 @@ int repo_config_set_in_file_gently(struct repository *r, const char *config_file
  * write config values to a specific config file, takes a key/value pair as
  * parameter.
  */
-void git_config_set_in_file(const char *, const char *, const char *);
 void repo_config_set_in_file(struct repository *, const char *, const char *, const char *);
 
-int git_config_set_gently(const char *, const char *);
 int repo_config_set_gently(struct repository *r, const char *, const char *);
 
 /**
@@ -321,14 +318,13 @@ int repo_config_set_worktree_gently(struct repository *, const char *, const cha
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
-void git_config_set(const char *, const char *);
 void repo_config_set(struct repository *, const char *, const char *);
 
 int git_config_parse_key(const char *, char **, size_t *);
 
 /*
  * The following macros specify flag bits that alter the behavior
- * of the git_config_set_multivar*() methods.
+ * of the repo_config_set_multivar*() methods.
  */
 
 /*
@@ -345,11 +341,8 @@ int git_config_parse_key(const char *, char **, size_t *);
  */
 #define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
 
-int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
-void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 void repo_config_set_multivar(struct repository *r, const char *, const char *, const char *, unsigned);
-int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_in_file_gently(struct repository *, const char *, const char *, const char *, const char *, const char *, unsigned);
 
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
@@ -563,39 +551,11 @@ int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *i
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_pathname(struct config_set *cs, const char *key, char **dest);
 
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
 
@@ -611,17 +571,17 @@ void git_protected_config(config_fn_t fn, void *data);
  * -------------------------------
  *
  * For programs wanting to query for specific variables in a non-callback
- * manner, the config API provides two functions `git_config_get_value`
- * and `git_config_get_value_multi`. They both read values from an internal
+ * manner, the config API provides two functions `repo_config_get_value`
+ * and `repo_config_get_value_multi`. They both read values from an internal
  * cache generated previously from reading the config files.
  *
- * For those git_config_get*() functions that aren't documented,
+ * For those repo_config_get*() functions that aren't documented,
  * consult the corresponding repo_config_get*() function's
  * documentation.
  */
 
 RESULT_MUST_BE_USED
-int git_config_get(const char *key);
+int repo_config_get(struct repository *r, const char *key);
 
 /**
  * Finds the highest-priority value for the configuration variable `key`,
@@ -630,7 +590,7 @@ int git_config_get(const char *key);
  * `value`. The caller should not free or modify `value`, as it is owned
  * by the cache.
  */
-int git_config_get_value(const char *key, const char **value);
+int repo_config_get_value(struct repository *r, const char *key, const char **value);
 
 /**
  * Finds and returns the value list, sorted in order of increasing priority
@@ -641,16 +601,15 @@ int git_config_get_value(const char *key, const char **value);
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
 
 /**
  * Resets and invalidates the config cache.
  */
-void git_config_clear(void);
 void repo_config_clear(struct repository *repo);
 
 /**
@@ -659,14 +618,15 @@ void repo_config_clear(struct repository *repo);
  * error message and returns -1. When the configuration variable `key` is
  * not found, returns 1 without touching `dest`.
  */
-int git_config_get_string(const char *key, char **dest);
+int repo_config_get_string(struct repository *r, const char *key, char **dest);
 
 /**
- * Similar to `git_config_get_string`, but does not allocate any new
+ * Similar to `repo_config_get_string`, but does not allocate any new
  * memory; on success `dest` will point to memory owned by the config
  * machinery, which could be invalidated if it is discarded and reloaded.
  */
-int git_config_get_string_tmp(const char *key, const char **dest);
+int repo_config_get_string_tmp(struct repository *r,
+			       const char *key, const char **dest);
 
 /**
  * Finds and parses the value to an integer for the configuration variable
@@ -674,12 +634,13 @@ int git_config_get_string_tmp(const char *key, const char **dest);
  * `dest` and returns 0. When the configuration variable `key` is not found,
  * returns 1 without touching `dest`.
  */
-int git_config_get_int(const char *key, int *dest);
+int repo_config_get_int(struct repository *r, const char *key, int *dest);
 
 /**
- * Similar to `git_config_get_int` but for unsigned longs.
+ * Similar to `repo_config_get_int` but for unsigned longs.
  */
-int git_config_get_ulong(const char *key, unsigned long *dest);
+int repo_config_get_ulong(struct repository *r,
+			  const char *key, unsigned long *dest);
 
 /**
  * Finds and parses the value into a boolean value, for the configuration
@@ -690,25 +651,21 @@ int git_config_get_ulong(const char *key, unsigned long *dest);
  * configuration variable `key` is not found, returns 1 without touching
  * `dest`.
  */
-int git_config_get_bool(const char *key, int *dest);
+int repo_config_get_bool(struct repository *r, const char *key, int *dest);
 
 /**
- * Similar to `git_config_get_bool`, except that integers are copied as-is,
+ * Similar to `repo_config_get_bool`, except that integers are copied as-is,
  * and `is_bool` flag is unset.
  */
-int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+int repo_config_get_bool_or_int(struct repository *r, const char *key,
+				int *is_bool, int *dest);
 
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
 
 int repo_config_get_index_threads(struct repository *r, int *dest);
 int repo_config_get_split_index(struct repository *r);
@@ -732,7 +689,7 @@ NORETURN void git_die_config(struct repository *r, const char *key, const char *
 /**
  * Helper function which formats the die error message according to the
  * parameters entered. Used by `git_die_config()`. It can be used by callers
- * handling `git_config_get_value_multi()` to print the correct error message
+ * handling `repo_config_get_value_multi()` to print the correct error message
  * for the desired value.
  */
 NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
@@ -741,4 +698,140 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 	lookup_config(mapping, ARRAY_SIZE(mapping), var)
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
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
+static inline int git_config_get_value_multi(const char *key, const struct string_list **dest)
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
+static inline int git_config_get_string_tmp(const char *key, const char **dest)
+{
+	return repo_config_get_string_tmp(the_repository, key, dest);
+}
+
+static inline int git_config_get_int(const char *key, int *dest)
+{
+	return repo_config_get_int(the_repository, key, dest);
+}
+
+static inline int git_config_get_ulong(const char *key, unsigned long *dest)
+{
+	return repo_config_get_ulong(the_repository, key, dest);
+}
+
+static inline int git_config_get_bool(const char *key, int *dest)
+{
+	return repo_config_get_bool(the_repository, key, dest);
+}
+
+static inline int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
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
+	return repo_config_set_multivar_in_file_gently(the_repository, config_filename,
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
+static inline int git_config_set_multivar_gently(const char *key, const char *value,
+				   const char *value_pattern, unsigned flags)
+{
+	return repo_config_set_multivar_gently(the_repository, key, value,
+					       value_pattern, flags);
+}
+
+static inline void git_config_set_multivar(const char *key, const char *value,
+			     const char *value_pattern, unsigned flags)
+{
+	repo_config_set_multivar(the_repository, key, value,
+				 value_pattern, flags);
+}
+# endif /* USE_THE_REPOSITORY_VARIABLE */
+
 #endif /* CONFIG_H */
-- 
2.46.0.46.g406f326d27.dirty

