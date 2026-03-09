Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62A2472A5
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017709; cv=pass; b=BJEwaTM59dPUAmW2LEe++0KJvnpR7wAr1gA67bLWE6lz2ck3SvY9Qp6ITfDM8/PYmhlihbB1rsJHM6eJ5gQFEYN2W4oqHNNx4BKFDKlFq05Tpwbl2y/+rKoCmFZkOrVnZhthGMscs361NsuqIvwI9PmKDpLQzXTnr2yejrfgvTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017709; c=relaxed/simple;
	bh=o+8zFzZy87GBKMlXkdq07D343JqkRfRPpXVqk5COkgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAJKLfB3/ulSKL9WmfNil9PKuCBEZKIoUuHPT+cSupyKWDtrGvBwm8C3LSASEBkdV0lTxiN34zmymaib+gtHpyq+HPLLZYU8oE+6MhRvSB+/h96CJCtgz/1qa9A0Q4+mnmeYQN3IybO85o5go6YHqpzdZD/7wAynUN3p0ga4kdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Fwpd/qgX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Fwpd/qgX"
ARC-Seal: i=1; a=rsa-sha256; t=1773017695; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V01WDgwmmSuGaHvGjv/sxxuG+SieTGm9VkLH5yUk4lde+iYhAfAQiIGcaT2IMAf4XF++WUHDGnmsjRVPr6RgOOWI8LOUSmb4P+92ycIbB5jdbENPxl5wXHu8ZMtwCX+JoClm4iCN+4+uJyf2q014dUA1Q1ie/9fcO609YR6wuN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017695; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y7jfAKHJrciP0VfV4LagB/sZrCdnrR6uk3Q7ZlQibn4=; 
	b=CtLgnPP9E1/38p/PAsWGar13fhWOcjoyZ54BTubnnEHuE0NQRP/8YgtdCLJYeVUuDVkbkuxamiMUvHMdwb7vNO9/RQHWMWF3fbpDolHr/LWSyU3nUzLgkz978fg3aFNDkV1Wz8MLVYXM0Lx9J8h+HQLSKHBN0GjOOQXSW6ms4bs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017695;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=y7jfAKHJrciP0VfV4LagB/sZrCdnrR6uk3Q7ZlQibn4=;
	b=Fwpd/qgXczGXiZyi3scEQ4Rn3qGM6qFj8mRayJsr0809lbTyLMkZpczNoLyEyyo3
	nJFM2y6TZpkzLotzA0C87Pbo/SsYvDcQgEl9bWThMjXe2xxK7WKJDTtEXKefdIsefLQ
	hWRasKxVNR/aQMT5Kc9DCnY+bgx7F/eD8heeReY0=
Received: by mx.zohomail.com with SMTPS id 1773017694093629.7443894165325;
	Sun, 8 Mar 2026 17:54:54 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 10/10] hook: show disabled hooks in "git hook list"
Date: Mon,  9 Mar 2026 02:54:16 +0200
Message-ID: <20260309005416.2760030-11-adrian.ratiu@collabora.com>
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

Disabled hooks were filtered out of the cache entirely, making them
invisible to "git hook list". Keep them in the cache with a new
"disabled" flag which is propagated to the respective struct hook.

"git hook list" now shows disabled hooks annotated with "(disabled)"
in the config order. With --show-scope, it looks like:

$ git hook list --show-scope pre-commit
linter (global)
no-leaks (local, disabled)
hook from hookdir

A disabled hook without a command issues a warning instead of the
fatal "hook.X.command must be configured" error. We could also throw
an error, however it seemd a bit excessive to me in this case.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c  | 18 ++++++++++-------
 hook.c          | 54 +++++++++++++++++++++++++++++++++----------------
 hook.h          |  1 +
 t/t1800-hook.sh | 33 +++++++++++++++++++++++++++---
 4 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index c806640361..ff446948fa 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -72,16 +72,20 @@ static int list(int argc, const char **argv, const char *prefix,
 		case HOOK_TRADITIONAL:
 			printf("%s%c", _("hook from hookdir"), line_terminator);
 			break;
-		case HOOK_CONFIGURED:
-			if (show_scope)
-				printf("%s (%s)%c",
-				       h->u.configured.friendly_name,
-				       config_scope_name(h->u.configured.scope),
+		case HOOK_CONFIGURED: {
+			const char *name = h->u.configured.friendly_name;
+			const char *scope = show_scope ?
+				config_scope_name(h->u.configured.scope) : NULL;
+			if (scope)
+				printf("%s (%s%s)%c", name, scope,
+				       h->u.configured.disabled ? ", disabled" : "",
 				       line_terminator);
+			else if (h->u.configured.disabled)
+				printf("%s (disabled)%c", name, line_terminator);
 			else
-				printf("%s%c", h->u.configured.friendly_name,
-				       line_terminator);
+				printf("%s%c", name, line_terminator);
 			break;
+		}
 		default:
 			BUG("unknown hook kind");
 		}
diff --git a/hook.c b/hook.c
index 2c03baeaac..4f4f060156 100644
--- a/hook.c
+++ b/hook.c
@@ -119,6 +119,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 struct hook_config_cache_entry {
 	char *command;
 	enum config_scope scope;
+	int disabled;
 };
 
 /*
@@ -217,8 +218,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
  * every item's string is the hook's friendly-name and its util pointer is
  * a hook_config_cache_entry. All strings are owned by the map.
  *
- * Disabled hooks and hooks missing a command are already filtered out at
- * parse time, so callers can iterate the list directly.
+ * Disabled hooks are kept in the cache with entry->disabled set, so that
+ * "git hook list" can display them. Hooks missing a command are filtered
+ * out at build time; if a disabled hook has no command it is silently
+ * skipped rather than triggering a fatal error.
  */
 void hook_cache_clear(struct hook_config_cache *cache)
 {
@@ -268,21 +271,26 @@ static void build_hook_config_map(struct repository *r,
 			struct hook_config_cache_entry *entry;
 			char *command;
 
-			/* filter out disabled hooks */
-			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
-							hname))
-				continue;
+			int is_disabled =
+				!!unsorted_string_list_lookup(
+					&cb_data.disabled_hooks, hname);
 
 			command = strmap_get(&cb_data.commands, hname);
-			if (!command)
-				die(_("'hook.%s.command' must be configured or "
-				      "'hook.%s.event' must be removed;"
-				      " aborting."), hname, hname);
+			if (!command) {
+				if (is_disabled)
+					warning(_("disabled hook '%s' has no "
+						  "command configured"), hname);
+				else
+					die(_("'hook.%s.command' must be configured or "
+					      "'hook.%s.event' must be removed;"
+					      " aborting."), hname, hname);
+			}
 
 			/* util stores a cache entry; owned by the cache. */
 			CALLOC_ARRAY(entry, 1);
-			entry->command = xstrdup(command);
+			entry->command = command ? xstrdup(command) : NULL;
 			entry->scope = scope;
+			entry->disabled = is_disabled;
 			string_list_append(hooks, hname)->util = entry;
 		}
 
@@ -362,8 +370,10 @@ static void list_hooks_add_configured(struct repository *r,
 
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
-		hook->u.configured.command = xstrdup(entry->command);
+		hook->u.configured.command =
+			entry->command ? xstrdup(entry->command) : NULL;
 		hook->u.configured.scope = entry->scope;
+		hook->u.configured.disabled = entry->disabled;
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
@@ -401,7 +411,16 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
 int hook_exists(struct repository *r, const char *name)
 {
 	struct string_list *hooks = list_hooks(r, name, NULL);
-	int exists = hooks->nr > 0;
+	int exists = 0;
+
+	for (size_t i = 0; i < hooks->nr; i++) {
+		struct hook *h = hooks->items[i].util;
+		if (h->kind == HOOK_TRADITIONAL ||
+		    !h->u.configured.disabled) {
+			exists = 1;
+			break;
+		}
+	}
 	string_list_clear_func(hooks, hook_free);
 	free(hooks);
 	return exists;
@@ -416,10 +435,11 @@ static int pick_next_hook(struct child_process *cp,
 	struct string_list *hook_list = hook_cb->hook_command_list;
 	struct hook *h;
 
-	if (hook_cb->hook_to_run_index >= hook_list->nr)
-		return 0;
-
-	h = hook_list->items[hook_cb->hook_to_run_index++].util;
+	do {
+		if (hook_cb->hook_to_run_index >= hook_list->nr)
+			return 0;
+		h = hook_list->items[hook_cb->hook_to_run_index++].util;
+	} while (h->kind == HOOK_CONFIGURED && h->u.configured.disabled);
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
diff --git a/hook.h b/hook.h
index 0d711ed21a..0432df963f 100644
--- a/hook.h
+++ b/hook.h
@@ -31,6 +31,7 @@ struct hook {
 			const char *friendly_name;
 			const char *command;
 			enum config_scope scope;
+			int disabled;
 		} configured;
 	} u;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index aed07575e3..cbf7d2bf80 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -357,7 +357,15 @@ test_expect_success 'disabled hook is not run' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'disabled hook does not appear in git hook list' '
+test_expect_success 'disabled hook with no command warns' '
+	test_config hook.nocommand.event "pre-commit" &&
+	test_config hook.nocommand.enabled false &&
+
+	git hook list pre-commit 2>actual &&
+	test_grep "disabled hook.*nocommand.*no command configured" actual
+'
+
+test_expect_success 'disabled hook appears as disabled in git hook list' '
 	test_config hook.active.event "pre-commit" &&
 	test_config hook.active.command "echo active" &&
 	test_config hook.inactive.event "pre-commit" &&
@@ -365,8 +373,27 @@ test_expect_success 'disabled hook does not appear in git hook list' '
 	test_config hook.inactive.enabled false &&
 
 	git hook list pre-commit >actual &&
-	test_grep "active" actual &&
-	test_grep ! "inactive" actual
+	test_grep "^active$" actual &&
+	test_grep "^inactive (disabled)$" actual
+'
+
+test_expect_success 'disabled hook shows scope with --show-scope' '
+	test_config hook.myhook.event "pre-commit" &&
+	test_config hook.myhook.command "echo hi" &&
+	test_config hook.myhook.enabled false &&
+
+	git hook list --show-scope pre-commit >actual &&
+	test_grep "myhook (local, disabled)" actual
+'
+
+test_expect_success 'disabled configured hook is not reported as existing by hook_exists' '
+	test_when_finished "rm -f git-bugreport-hook-exists-test.txt" &&
+	test_config hook.linter.event "pre-commit" &&
+	test_config hook.linter.command "echo lint" &&
+	test_config hook.linter.enabled false &&
+
+	git bugreport -s hook-exists-test &&
+	test_grep ! "pre-commit" git-bugreport-hook-exists-test.txt
 '
 
 test_expect_success 'globally disabled hook can be re-enabled locally' '
-- 
2.52.0.732.gb351b5166d.dirty

