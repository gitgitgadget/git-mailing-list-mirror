Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81BEEB562
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245441AbjIHRpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjIHRpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:45:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE6C1FC9
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:44:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74829dd58fso2295142276.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195096; x=1694799896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCEun3E/pwYZAWIVkC4IHhrRXlp9Q6Tai0uw+cifELk=;
        b=H+1NTKGeyi5MmzCRuwYkp+jSE0gasgN0FwqWDNFSvSmTdfOWpedkJko0+vcoZNqy+C
         5G3rVJuwvimICKYcnTb0Vz/2hwLcpVR2PGiiHi8IcbBT16pZ+lBCnlbPti8OyMq4+xER
         BYixQB5Iyd9FKMR/9zKa6SSqrxYSQqQR9NZaiuPu89XRyz5TwToq307DtLs5UCR5uivq
         kDz1APc20ngkkszA4k07kYvRuA6wSSecskGO77oE0v6n5ApNkk8ybeZ8OqZyovU4NF/4
         KCwQR81EDPogSktZwm8hqpvB5eSWSxLmSu8P+KFeVQQi+e57UdXMwFbguz/rGmcCZFTZ
         Du3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195096; x=1694799896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCEun3E/pwYZAWIVkC4IHhrRXlp9Q6Tai0uw+cifELk=;
        b=fTVvB80Mmr5Iq5iPGpUUogBlY1UlAWvFi2rQXcUBtcxbiUbi+yyyksjDAHli8x6V3y
         NghwpyRN1GaQZF7vreH0Z0NfghStmHJe24dAQT2gJKiUlTymSS9K+IjdL1m8FKziLJC0
         aYmG7oZjGIY8r6Zzyykvrq2DiK7njx5Dk+1557fxrMXHqIwkv9evraZf5F6iq0ntTUSq
         lu6blYotHlzHOXEWLc8WmA+U7EelcUa2oz1qD56aapbuog7QFQIEZZ+FyPpKZF4EVNir
         WKF0Tr4l9gThdPU6BY52czdn/qxWHlpsgN6/TigbbaG1+UL/5pHLBanC9uQxvv/+Y2gr
         RobQ==
X-Gm-Message-State: AOJu0YwkhXBjOqSnniYArgj8c2Yl/uYejGDw2Qu7gAIUe4fjh/VKLQxQ
        G+RoGM3tVC32pEkQQF4F9/UcU/n6q3k3ZQhqpjn42dGIJ+gkhpG6aMGCpXtGKGcEswmXUc/qMet
        fH9iMTWwAjdgg+Ntt3guAJFLlkLj0WeMRRGTy7CI5s6BjP8T4W11rRktYKs0wX3kaOw==
X-Google-Smtp-Source: AGHT+IGalFpUKlDlJaGRGQL9ABfoWSKJCsjoauwXFjIhw1W2usrNQlpdEv+XZ7XEeL45pEP6UM2HUmS8hC4nwwo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:ac02:0:b0:d80:eb4:9ca with SMTP id
 w2-20020a25ac02000000b00d800eb409camr71107ybi.0.1694195096283; Fri, 08 Sep
 2023 10:44:56 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:44:41 +0000
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230908174134.1026823-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908174443.1027716-4-calvinwan@google.com>
Subject: [PATCH v3 4/6] parse: create new library for parsing strings and env values
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While string and environment value parsing is mainly consumed by
config.c, there are other files that only need parsing functionality and
not config functionality. By separating out string and environment value
parsing from config, those files can instead be dependent on parse,
which has a much smaller dependency chain than config. This ultimately
allows us to inclue parse.[ch] in an independent library since it
doesn't have dependencies to Git-specific internals unlike in
config.[ch].

Move general string and env parsing functions from config.[ch] to
parse.[ch].

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Makefile                   |   1 +
 attr.c                     |   2 +-
 config.c                   | 180 +-----------------------------------
 config.h                   |  14 +--
 pack-objects.c             |   2 +-
 pack-revindex.c            |   2 +-
 parse-options.c            |   3 +-
 parse.c                    | 182 +++++++++++++++++++++++++++++++++++++
 parse.h                    |  20 ++++
 pathspec.c                 |   2 +-
 preload-index.c            |   2 +-
 progress.c                 |   2 +-
 prompt.c                   |   2 +-
 rebase.c                   |   2 +-
 t/helper/test-env-helper.c |   2 +-
 unpack-trees.c             |   2 +-
 wrapper.c                  |   2 +-
 write-or-die.c             |   2 +-
 18 files changed, 219 insertions(+), 205 deletions(-)
 create mode 100644 parse.c
 create mode 100644 parse.h

diff --git a/Makefile b/Makefile
index 861e643708..9226c719a0 100644
--- a/Makefile
+++ b/Makefile
@@ -1091,6 +1091,7 @@ LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
 LIB_OBJS += parallel-checkout.o
+LIB_OBJS += parse.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
diff --git a/attr.c b/attr.c
index 71c84fbcf8..3c0b4fb3d9 100644
--- a/attr.c
+++ b/attr.c
@@ -7,7 +7,7 @@
  */
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "parse.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "attr.h"
diff --git a/config.c b/config.c
index 7dde0aaa02..c7bc21a25d 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "date.h"
 #include "branch.h"
 #include "config.h"
+#include "parse.h"
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
@@ -1165,129 +1166,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 	return error_return;
 }
 
-static uintmax_t get_unit_factor(const char *end)
-{
-	if (!*end)
-		return 1;
-	else if (!strcasecmp(end, "k"))
-		return 1024;
-	else if (!strcasecmp(end, "m"))
-		return 1024 * 1024;
-	else if (!strcasecmp(end, "g"))
-		return 1024 * 1024 * 1024;
-	return 0;
-}
-
-static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
-{
-	if (value && *value) {
-		char *end;
-		intmax_t val;
-		intmax_t factor;
-
-		if (max < 0)
-			BUG("max must be a positive integer");
-
-		errno = 0;
-		val = strtoimax(value, &end, 0);
-		if (errno == ERANGE)
-			return 0;
-		if (end == value) {
-			errno = EINVAL;
-			return 0;
-		}
-		factor = get_unit_factor(end);
-		if (!factor) {
-			errno = EINVAL;
-			return 0;
-		}
-		if ((val < 0 && -max / factor > val) ||
-		    (val > 0 && max / factor < val)) {
-			errno = ERANGE;
-			return 0;
-		}
-		val *= factor;
-		*ret = val;
-		return 1;
-	}
-	errno = EINVAL;
-	return 0;
-}
-
-static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
-{
-	if (value && *value) {
-		char *end;
-		uintmax_t val;
-		uintmax_t factor;
-
-		/* negative values would be accepted by strtoumax */
-		if (strchr(value, '-')) {
-			errno = EINVAL;
-			return 0;
-		}
-		errno = 0;
-		val = strtoumax(value, &end, 0);
-		if (errno == ERANGE)
-			return 0;
-		if (end == value) {
-			errno = EINVAL;
-			return 0;
-		}
-		factor = get_unit_factor(end);
-		if (!factor) {
-			errno = EINVAL;
-			return 0;
-		}
-		if (unsigned_mult_overflows(factor, val) ||
-		    factor * val > max) {
-			errno = ERANGE;
-			return 0;
-		}
-		val *= factor;
-		*ret = val;
-		return 1;
-	}
-	errno = EINVAL;
-	return 0;
-}
-
-int git_parse_int(const char *value, int *ret)
-{
-	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
-static int git_parse_int64(const char *value, int64_t *ret)
-{
-	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
-int git_parse_ulong(const char *value, unsigned long *ret)
-{
-	uintmax_t tmp;
-	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(long)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
-int git_parse_ssize_t(const char *value, ssize_t *ret)
-{
-	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
 NORETURN
 static void die_bad_number(const char *name, const char *value,
 			   const struct key_value_info *kvi)
@@ -1363,23 +1241,6 @@ ssize_t git_config_ssize_t(const char *name, const char *value,
 	return ret;
 }
 
-static int git_parse_maybe_bool_text(const char *value)
-{
-	if (!value)
-		return 1;
-	if (!*value)
-		return 0;
-	if (!strcasecmp(value, "true")
-	    || !strcasecmp(value, "yes")
-	    || !strcasecmp(value, "on"))
-		return 1;
-	if (!strcasecmp(value, "false")
-	    || !strcasecmp(value, "no")
-	    || !strcasecmp(value, "off"))
-		return 0;
-	return -1;
-}
-
 static const struct fsync_component_name {
 	const char *name;
 	enum fsync_component component_bits;
@@ -1454,16 +1315,6 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 	return (current & ~negative) | positive;
 }
 
-int git_parse_maybe_bool(const char *value)
-{
-	int v = git_parse_maybe_bool_text(value);
-	if (0 <= v)
-		return v;
-	if (git_parse_int(value, &v))
-		return !!v;
-	return -1;
-}
-
 int git_config_bool_or_int(const char *name, const char *value,
 			   const struct key_value_info *kvi, int *is_bool)
 {
@@ -2126,35 +1977,6 @@ void git_global_config(char **user_out, char **xdg_out)
 	*xdg_out = xdg_config;
 }
 
-/*
- * Parse environment variable 'k' as a boolean (in various
- * possible spellings); if missing, use the default value 'def'.
- */
-int git_env_bool(const char *k, int def)
-{
-	const char *v = getenv(k);
-	int val;
-	if (!v)
-		return def;
-	val = git_parse_maybe_bool(v);
-	if (val < 0)
-		die(_("bad boolean environment value '%s' for '%s'"),
-		    v, k);
-	return val;
-}
-
-/*
- * Parse environment variable 'k' as ulong with possibly a unit
- * suffix; if missing, use the default value 'val'.
- */
-unsigned long git_env_ulong(const char *k, unsigned long val)
-{
-	const char *v = getenv(k);
-	if (v && !git_parse_ulong(v, &val))
-		die(_("failed to parse %s"), k);
-	return val;
-}
-
 int git_config_system(void)
 {
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
diff --git a/config.h b/config.h
index 6332d74904..14f881ecfa 100644
--- a/config.h
+++ b/config.h
@@ -4,7 +4,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "repository.h"
-
+#include "parse.h"
 
 /**
  * The config API gives callers a way to access Git configuration files
@@ -243,16 +243,6 @@ int config_with_options(config_fn_t fn, void *,
  * The following helper functions aid in parsing string values
  */
 
-int git_parse_ssize_t(const char *, ssize_t *);
-int git_parse_ulong(const char *, unsigned long *);
-int git_parse_int(const char *value, int *ret);
-
-/**
- * Same as `git_config_bool`, except that it returns -1 on error rather
- * than dying.
- */
-int git_parse_maybe_bool(const char *);
-
 /**
  * Parse the string to an integer, including unit factors. Dies on error;
  * otherwise, returns the parsed result.
@@ -385,8 +375,6 @@ int git_config_rename_section(const char *, const char *);
 int git_config_rename_section_in_file(const char *, const char *, const char *);
 int git_config_copy_section(const char *, const char *);
 int git_config_copy_section_in_file(const char *, const char *, const char *);
-int git_env_bool(const char *, int);
-unsigned long git_env_ulong(const char *, unsigned long);
 int git_config_system(void);
 int config_error_nonbool(const char *);
 #if defined(__GNUC__)
diff --git a/pack-objects.c b/pack-objects.c
index 1b8052bece..f403ca6986 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -3,7 +3,7 @@
 #include "pack.h"
 #include "pack-objects.h"
 #include "packfile.h"
-#include "config.h"
+#include "parse.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const struct object_id *oid,
diff --git a/pack-revindex.c b/pack-revindex.c
index 7fffcad912..a01a2a4640 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -6,7 +6,7 @@
 #include "packfile.h"
 #include "strbuf.h"
 #include "trace2.h"
-#include "config.h"
+#include "parse.h"
 #include "midx.h"
 #include "csum-file.h"
 
diff --git a/parse-options.c b/parse-options.c
index e8e076c3a6..093eaf2db8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,11 +1,12 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "abspath.h"
-#include "config.h"
+#include "parse.h"
 #include "commit.h"
 #include "color.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "utf8.h"
 
 static int disallow_abbreviated_options;
diff --git a/parse.c b/parse.c
new file mode 100644
index 0000000000..42d691a0fb
--- /dev/null
+++ b/parse.c
@@ -0,0 +1,182 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "parse.h"
+
+static uintmax_t get_unit_factor(const char *end)
+{
+	if (!*end)
+		return 1;
+	else if (!strcasecmp(end, "k"))
+		return 1024;
+	else if (!strcasecmp(end, "m"))
+		return 1024 * 1024;
+	else if (!strcasecmp(end, "g"))
+		return 1024 * 1024 * 1024;
+	return 0;
+}
+
+int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
+{
+	if (value && *value) {
+		char *end;
+		intmax_t val;
+		intmax_t factor;
+
+		if (max < 0)
+			BUG("max must be a positive integer");
+
+		errno = 0;
+		val = strtoimax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
+		factor = get_unit_factor(end);
+		if (!factor) {
+			errno = EINVAL;
+			return 0;
+		}
+		if ((val < 0 && -max / factor > val) ||
+		    (val > 0 && max / factor < val)) {
+			errno = ERANGE;
+			return 0;
+		}
+		val *= factor;
+		*ret = val;
+		return 1;
+	}
+	errno = EINVAL;
+	return 0;
+}
+
+static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+{
+	if (value && *value) {
+		char *end;
+		uintmax_t val;
+		uintmax_t factor;
+
+		/* negative values would be accepted by strtoumax */
+		if (strchr(value, '-')) {
+			errno = EINVAL;
+			return 0;
+		}
+		errno = 0;
+		val = strtoumax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
+		factor = get_unit_factor(end);
+		if (!factor) {
+			errno = EINVAL;
+			return 0;
+		}
+		if (unsigned_mult_overflows(factor, val) ||
+		    factor * val > max) {
+			errno = ERANGE;
+			return 0;
+		}
+		val *= factor;
+		*ret = val;
+		return 1;
+	}
+	errno = EINVAL;
+	return 0;
+}
+
+int git_parse_int(const char *value, int *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_int64(const char *value, int64_t *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_ulong(const char *value, unsigned long *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(long)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_ssize_t(const char *value, ssize_t *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_maybe_bool_text(const char *value)
+{
+	if (!value)
+		return 1;
+	if (!*value)
+		return 0;
+	if (!strcasecmp(value, "true")
+	    || !strcasecmp(value, "yes")
+	    || !strcasecmp(value, "on"))
+		return 1;
+	if (!strcasecmp(value, "false")
+	    || !strcasecmp(value, "no")
+	    || !strcasecmp(value, "off"))
+		return 0;
+	return -1;
+}
+
+int git_parse_maybe_bool(const char *value)
+{
+	int v = git_parse_maybe_bool_text(value);
+	if (0 <= v)
+		return v;
+	if (git_parse_int(value, &v))
+		return !!v;
+	return -1;
+}
+
+/*
+ * Parse environment variable 'k' as a boolean (in various
+ * possible spellings); if missing, use the default value 'def'.
+ */
+int git_env_bool(const char *k, int def)
+{
+	const char *v = getenv(k);
+	int val;
+	if (!v)
+		return def;
+	val = git_parse_maybe_bool(v);
+	if (val < 0)
+		die(_("bad boolean environment value '%s' for '%s'"),
+		    v, k);
+	return val;
+}
+
+/*
+ * Parse environment variable 'k' as ulong with possibly a unit
+ * suffix; if missing, use the default value 'val'.
+ */
+unsigned long git_env_ulong(const char *k, unsigned long val)
+{
+	const char *v = getenv(k);
+	if (v && !git_parse_ulong(v, &val))
+		die(_("failed to parse %s"), k);
+	return val;
+}
diff --git a/parse.h b/parse.h
new file mode 100644
index 0000000000..07d2193d69
--- /dev/null
+++ b/parse.h
@@ -0,0 +1,20 @@
+#ifndef PARSE_H
+#define PARSE_H
+
+int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
+int git_parse_ssize_t(const char *, ssize_t *);
+int git_parse_ulong(const char *, unsigned long *);
+int git_parse_int(const char *value, int *ret);
+int git_parse_int64(const char *value, int64_t *ret);
+
+/**
+ * Same as `git_config_bool`, except that it returns -1 on error rather
+ * than dying.
+ */
+int git_parse_maybe_bool(const char *);
+int git_parse_maybe_bool_text(const char *value);
+
+int git_env_bool(const char *, int);
+unsigned long git_env_ulong(const char *, unsigned long);
+
+#endif /* PARSE_H */
diff --git a/pathspec.c b/pathspec.c
index 3a3a5724c4..7f88f1c02b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "parse.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/preload-index.c b/preload-index.c
index e44530c80c..63fd35d64b 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,7 +7,7 @@
 #include "environment.h"
 #include "fsmonitor.h"
 #include "gettext.h"
-#include "config.h"
+#include "parse.h"
 #include "preload-index.h"
 #include "progress.h"
 #include "read-cache.h"
diff --git a/progress.c b/progress.c
index f695798aca..c83cb60bf1 100644
--- a/progress.c
+++ b/progress.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 #include "trace2.h"
 #include "utf8.h"
-#include "config.h"
+#include "parse.h"
 
 #define TP_IDX_MAX      8
 
diff --git a/prompt.c b/prompt.c
index 3baa33f63d..8935fe4dfb 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "parse.h"
 #include "environment.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/rebase.c b/rebase.c
index 17a570f1ff..69a1822da3 100644
--- a/rebase.c
+++ b/rebase.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "rebase.h"
-#include "config.h"
+#include "parse.h"
 #include "gettext.h"
 
 /*
diff --git a/t/helper/test-env-helper.c b/t/helper/test-env-helper.c
index 66c88b8ff3..1c486888a4 100644
--- a/t/helper/test-env-helper.c
+++ b/t/helper/test-env-helper.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "config.h"
+#include "parse.h"
 #include "parse-options.h"
 
 static char const * const env__helper_usage[] = {
diff --git a/unpack-trees.c b/unpack-trees.c
index 87517364dc..761562a96e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2,7 +2,7 @@
 #include "advice.h"
 #include "strvec.h"
 #include "repository.h"
-#include "config.h"
+#include "parse.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/wrapper.c b/wrapper.c
index 453a20ed99..7da15a56da 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,7 +3,7 @@
  */
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "parse.h"
 #include "gettext.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/write-or-die.c b/write-or-die.c
index d8355c0c3e..42a2dc73cd 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "parse.h"
 #include "run-command.h"
 #include "write-or-die.h"
 
-- 
2.42.0.283.g2d96d420d3-goog

