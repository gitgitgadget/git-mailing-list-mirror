Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CE23ABB0
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017707; cv=pass; b=CxPn9DuNO9tf28eEK00hc2b/F8n3Nwn3QkijHR/09XlbTt5MmW1xtTckjcq0cNd8GK90Rx+2JacSq3FwWlGtY+TwH+rHdLyWyEEnbUinHJZgrlMiUfJfBoLhLEbkN6MCqaFzVDDle4ZR2QI+pcoLypwcQI1hTBMH9gl0WHSxhEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017707; c=relaxed/simple;
	bh=+t0/9PM7LWzYgSxXuW5IEIlwtS27Pm3veGmgJZSNmSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+ZL5KjrUUO4/7Ns2PDg3r6F+SLR98zgqDu5CMSCldFbqsABwGcGr8grVXcF+7CXnCct4nneh1e6zuB0mKgxgLKq07mGLEJIX6yx8rcWLXn3bf1RnpVb8wTk9WT5hD5cFuKGzTCHfQVfRJyGfgjM0XxjsulGmm9ZBV1pjLeqzWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HWbm9fv5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HWbm9fv5"
ARC-Seal: i=1; a=rsa-sha256; t=1773017693; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I7eoA4eM8qMW348P3uISmb2R/pbInl9ZdRRNHg+vRd2w4VezKBJAZTCE2rcTjKj2wK9gMVk6WndyOW9fHDE72hPCGqoQ7mXrkkBWNviVl8BZiXA0qs1+SBPNn3JOnoVfMpLXaWRUq/VCzpFiHJYfpizTtmxwXFlPPrGBUaZAQzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017693; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WtsblGZySfRPhuEXaIiaowvqpwf6TouvFqmolpUnPNc=; 
	b=PSuQWF/4KH34jiXbIYANIhbA/S0N5q+epzMxMm6eBQWyVn5Ob7HI81ie7wb85fydA0vMXGX/9gD9ovIS9MQwny9FJiPbu+LFysx5eEClXlPpmHyFzgFgY6YNNl6AWEt41D88Q+Nk6/bNN8D5KldqP2rNM9oYYmPsYnsbN758bHo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017693;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WtsblGZySfRPhuEXaIiaowvqpwf6TouvFqmolpUnPNc=;
	b=HWbm9fv5m6Qz8Eey+wo+9ngtx435s6BYS/JvmiK7fcVzV29Rb7liQGjQBS9TdAKS
	waMa2pMDL/BoN6Ycehj7xRavvnTSZWJ0Z8uJO5aPcL+Dr+1NXvFRr8q5r2ddNVRVSPo
	zl5vRv4iNvW5NZgW7ZQlISzFe/boEqPzvzJh+94w=
Received: by mx.zohomail.com with SMTPS id 1773017692309254.8059299086982;
	Sun, 8 Mar 2026 17:54:52 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 09/10] hook: show config scope in git hook list
Date: Mon,  9 Mar 2026 02:54:15 +0200
Message-ID: <20260309005416.2760030-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Users running "git hook list" can see which hooks are configured but
have no way to tell at which config scope (local, global, system...)
each hook was defined.

Store the scope from ctx->kvi->scope in the single-pass config callback,
then carry it through the cache to the hook structs, so we can expose it
to users via the "git hook list --show-scope" flag, which mirrors the
existing git config --show-scope convention.

Without the flag the output is unchanged.

Example usage:
$ git hook list --show-scope pre-commit
linter (global)
no-leaks (local)
hook from hookdir

Traditional hooks from the hookdir are unaffected by --show-scope since
the config scope concept does not apply to them.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  9 +++++++--
 builtin/hook.c              | 14 ++++++++++++--
 hook.c                      | 24 ++++++++++++++++++++----
 hook.h                      |  2 ++
 t/t1800-hook.sh             | 19 +++++++++++++++++++
 5 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 966388660a..4d4e728327 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
-'git hook' list [-z] <hook-name>
+'git hook' list [-z] [--show-scope] <hook-name>
 
 DESCRIPTION
 -----------
@@ -113,7 +113,7 @@ Any positional arguments to the hook should be passed after a
 mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
 linkgit:githooks[5] for arguments hooks might expect (if any).
 
-list [-z]::
+list [-z] [--show-scope]::
 	Print a list of hooks which will be run on `<hook-name>` event. If no
 	hooks are configured for that event, print a warning and return 1.
 	Use `-z` to terminate output lines with NUL instead of newlines.
@@ -134,6 +134,11 @@ OPTIONS
 -z::
 	Terminate "list" output lines with NUL instead of newlines.
 
+--show-scope::
+	For "list"; print the config scope (e.g. `local`, `global`, `system`)
+	in parentheses after the friendly name of each configured hook, to show
+	where it was defined. Traditional hooks from the hookdir are unaffected.
+
 WRAPPERS
 --------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 8fc647a4de..c806640361 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -9,7 +9,7 @@
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
-	N_("git hook list [-z] <hook-name>")
+	N_("git hook list [-z] [--show-scope] <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -33,11 +33,14 @@ static int list(int argc, const char **argv, const char *prefix,
 	struct string_list_item *item;
 	const char *hookname = NULL;
 	int line_terminator = '\n';
+	int show_scope = 0;
 	int ret = 0;
 
 	struct option list_options[] = {
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("use NUL as line terminator"), '\0'),
+		OPT_BOOL(0, "show-scope", &show_scope,
+			 N_("show the config scope that defined each hook")),
 		OPT_END(),
 	};
 
@@ -70,7 +73,14 @@ static int list(int argc, const char **argv, const char *prefix,
 			printf("%s%c", _("hook from hookdir"), line_terminator);
 			break;
 		case HOOK_CONFIGURED:
-			printf("%s%c", h->u.configured.friendly_name, line_terminator);
+			if (show_scope)
+				printf("%s (%s)%c",
+				       h->u.configured.friendly_name,
+				       config_scope_name(h->u.configured.scope),
+				       line_terminator);
+			else
+				printf("%s%c", h->u.configured.friendly_name,
+				       line_terminator);
 			break;
 		default:
 			BUG("unknown hook kind");
diff --git a/hook.c b/hook.c
index 4fe50aa38c..2c03baeaac 100644
--- a/hook.c
+++ b/hook.c
@@ -114,11 +114,11 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 
 /*
  * Cache entry stored as the .util pointer of string_list items inside the
- * hook config cache. For now carries only the command for the hook. Next
- * commits will add more data.
+ * hook config cache.
  */
 struct hook_config_cache_entry {
 	char *command;
+	enum config_scope scope;
 };
 
 /*
@@ -135,7 +135,7 @@ struct hook_all_config_cb {
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
 static int hook_config_lookup_all(const char *key, const char *value,
-				  const struct config_context *ctx UNUSED,
+				  const struct config_context *ctx,
 				  void *cb_data)
 {
 	struct hook_all_config_cb *data = cb_data;
@@ -172,7 +172,19 @@ static int hook_config_lookup_all(const char *key, const char *value,
 
 			/* Re-insert if necessary to preserve last-seen order. */
 			unsorted_string_list_remove(hooks, hook_name, 0);
-			string_list_append(hooks, hook_name);
+
+			if (!ctx->kvi)
+				BUG("hook config callback called without key-value info");
+
+			/*
+			 * Stash the config scope in the util pointer for
+			 * later retrieval in build_hook_config_map(). This
+			 * intermediate struct is transient and never leaves
+			 * that function, so we pack the enum value into the
+			 * pointer rather than heap-allocating a wrapper.
+			 */
+			string_list_append(hooks, hook_name)->util =
+				(void *)(uintptr_t)ctx->kvi->scope;
 		}
 	} else if (!strcmp(subkey, "command")) {
 		/* Store command overwriting the old value */
@@ -251,6 +263,8 @@ static void build_hook_config_map(struct repository *r,
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
 			const char *hname = hook_names->items[i].string;
+			enum config_scope scope =
+				(enum config_scope)(uintptr_t)hook_names->items[i].util;
 			struct hook_config_cache_entry *entry;
 			char *command;
 
@@ -268,6 +282,7 @@ static void build_hook_config_map(struct repository *r,
 			/* util stores a cache entry; owned by the cache. */
 			CALLOC_ARRAY(entry, 1);
 			entry->command = xstrdup(command);
+			entry->scope = scope;
 			string_list_append(hooks, hname)->util = entry;
 		}
 
@@ -348,6 +363,7 @@ static void list_hooks_add_configured(struct repository *r,
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
 		hook->u.configured.command = xstrdup(entry->command);
+		hook->u.configured.scope = entry->scope;
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
diff --git a/hook.h b/hook.h
index 4d0c22f1dc..0d711ed21a 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,6 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "config.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "string-list.h"
@@ -29,6 +30,7 @@ struct hook {
 		struct {
 			const char *friendly_name;
 			const char *command;
+			enum config_scope scope;
 		} configured;
 	} u;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7eee84fc39..aed07575e3 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -408,6 +408,25 @@ test_expect_success 'configured hooks run before hookdir hook' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list --show-scope shows config scope' '
+	test_config_global hook.global-hook.command "echo global" &&
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config hook.local-hook.command "echo local" &&
+	test_config hook.local-hook.event test-hook --add &&
+
+	cat >expected <<-\EOF &&
+	global-hook (global)
+	local-hook (local)
+	EOF
+	git hook list --show-scope test-hook >actual &&
+	test_cmp expected actual &&
+
+	# without --show-scope the scope must not appear
+	git hook list test-hook >actual &&
+	test_grep ! "(global)" actual &&
+	test_grep ! "(local)" actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
-- 
2.52.0.732.gb351b5166d.dirty

