Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01C2EAB72
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468572; cv=pass; b=WrcAQxZ586YVF47+9FUHY1Qr/K6Se7ViKgXwtyYkW6GMMIHkYa+W5ReLvNiU+kxKY0kk0vwbpTSY+oCwRJxWNB/SoaYonfF77Dw77VKoDDhpZlHn6yRDoARG1Ok2mX3bBfsUPzFZJp5BQ8NLDfMXiiD8sKuFI4gNZ6egoGBS8Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468572; c=relaxed/simple;
	bh=zGqXniLQ0x3T99G/ZBTq/RZovVxYhYI2H4zc6Z2k7bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLJ4r+M1HzkfcMfpjvnLP6Y3UtPb7aQgsLhRR7GPHtBWpY8PyrWgQIT07U61esLjNNvjwJznS0/9FLgzYTevkxpxWRZmySMIbst7PhXqFwXdTToQRT1oy2jdmiIWa/coAhMmlBEp1y8VTRkwzbBb7BJBYglgJfmG4Of6D6Oz4rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=h4PEPjWR; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="h4PEPjWR"
ARC-Seal: i=1; a=rsa-sha256; t=1774468560; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jcsc5S3PfjvqJc44ib3TH7v+E5SbLJNB9HYXpXpf9WWLQigutJqpza83grj4dkAGz8WQsajVhzl1LUMYbxi55efpDXbmE0cD2qIa5Tf1vHlw3nzzglIz7camwu8xS6Un4DCvUGVeVWf5QoTpJk1lYlqm/mcUDUeWE0KVSLG78m8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468560; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ud2aGtUp8LgGXRalQYUz5RNkg00pSbXB+yGVAainvVY=; 
	b=cWucxGjqDROxefjFN9IzLbhnGO9yn3q1mCAkSgXjounmcHtJJixTVNOPVkrD8SXRKquVICQXFjxTYWW1Jib4lnm4oY6sMXoQq5mUKGYJFAmMnUDLYzTQthMcHyWNO5GP45feQ8hRfQyZj5lEwkH+301/hLwo32Rp/jzi3hn9auo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468560;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ud2aGtUp8LgGXRalQYUz5RNkg00pSbXB+yGVAainvVY=;
	b=h4PEPjWRrWDOWOHsAtm2O61mUf74AqL7mVXxYvRXQBWY9PhjnUl13kI/C+fNy2wc
	XzuBeYzKBnB1vJ1CznhEUjyx+jrk1IrIgegYCuBVmgm/A43Y7tLuXG80TnAvMEqeU51
	+JnwOBCu8NVA+AsjS9gmic9KJOXTFLlVHWB73INY=
Received: by mx.zohomail.com with SMTPS id 177446855866616.97607792212989;
	Wed, 25 Mar 2026 12:55:58 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 10/12] hook: show config scope in git hook list
Date: Wed, 25 Mar 2026 21:55:01 +0200
Message-ID: <20260325195503.1139418-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
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

The scope is printed as a tab-separated prefix (like "git config --show-scope"),
making it unambiguously machine-parseable even when the friendly name
contains spaces.

Example usage:
$ git hook list --show-scope pre-commit
global	linter
local	no-leaks
hook from hookdir

Traditional hooks from the hookdir are unaffected by --show-scope since
the config scope concept does not apply to them.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc | 10 ++++++++--
 builtin/hook.c              | 14 ++++++++++++--
 hook.c                      | 24 ++++++++++++++++++++----
 hook.h                      |  2 ++
 t/t1800-hook.sh             | 21 +++++++++++++++++++++
 5 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 966388660a..e7d399ae57 100644
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
@@ -134,6 +134,12 @@ OPTIONS
 -z::
 	Terminate "list" output lines with NUL instead of newlines.
 
+--show-scope::
+	For "list"; prefix each configured hook's friendly name with a
+	tab-separated config scope (e.g. `local`, `global`, `system`),
+	mirroring the output style of `git config --show-scope`. Traditional
+	hooks from the hookdir are unaffected.
+
 WRAPPERS
 --------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 54b737990b..4cc65a0dc5 100644
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
+				printf("%s\t%s%c",
+				       config_scope_name(h->u.configured.scope),
+				       h->u.configured.friendly_name,
+				       line_terminator);
+			else
+				printf("%s%c", h->u.configured.friendly_name,
+				       line_terminator);
 			break;
 		default:
 			BUG("unknown hook kind");
diff --git a/hook.c b/hook.c
index 54f99f4989..74f5a1df35 100644
--- a/hook.c
+++ b/hook.c
@@ -110,11 +110,11 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 
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
@@ -131,7 +131,7 @@ struct hook_all_config_cb {
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
 static int hook_config_lookup_all(const char *key, const char *value,
-				  const struct config_context *ctx UNUSED,
+				  const struct config_context *ctx,
 				  void *cb_data)
 {
 	struct hook_all_config_cb *data = cb_data;
@@ -168,7 +168,19 @@ static int hook_config_lookup_all(const char *key, const char *value,
 
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
@@ -246,6 +258,8 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
 			const char *hname = hook_names->items[i].string;
+			enum config_scope scope =
+				(enum config_scope)(uintptr_t)hook_names->items[i].util;
 			struct hook_config_cache_entry *entry;
 			char *command;
 
@@ -263,6 +277,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 			/* util stores a cache entry; owned by the cache. */
 			CALLOC_ARRAY(entry, 1);
 			entry->command = xstrdup(command);
+			entry->scope = scope;
 			string_list_append(hooks, hname)->util = entry;
 		}
 
@@ -344,6 +359,7 @@ static void list_hooks_add_configured(struct repository *r,
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
 		hook->u.configured.command = xstrdup(entry->command);
+		hook->u.configured.scope = entry->scope;
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
diff --git a/hook.h b/hook.h
index d2cf59e649..a0432e8307 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,6 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "config.h"
 #include "run-command.h"
 #include "string-list.h"
 #include "strmap.h"
@@ -29,6 +30,7 @@ struct hook {
 		struct {
 			const char *friendly_name;
 			const char *command;
+			enum config_scope scope;
 		} configured;
 	} u;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7eee84fc39..6fc6603da8 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -408,6 +408,27 @@ test_expect_success 'configured hooks run before hookdir hook' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list --show-scope shows config scope' '
+	setup_hookdir &&
+	test_config_global hook.global-hook.command "echo global" &&
+	test_config_global hook.global-hook.event pre-commit --add &&
+	test_config hook.local-hook.command "echo local" &&
+	test_config hook.local-hook.event pre-commit --add &&
+
+	cat >expected <<-\EOF &&
+	global	global-hook
+	local	local-hook
+	hook from hookdir
+	EOF
+	git hook list --show-scope pre-commit >actual &&
+	test_cmp expected actual &&
+
+	# without --show-scope the scope must not appear
+	git hook list pre-commit >actual &&
+	test_grep ! "^global	" actual &&
+	test_grep ! "^local	" actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
-- 
2.52.0.732.gb351b5166d.dirty

