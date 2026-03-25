Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D733A9C3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468576; cv=pass; b=paUn8ipfXi8y851RPpWSbdiAOYEagGg3QEtagAblAbHSRUQ2YVqIbkeqUbyjwd4zjVwU3HhByrw765KlBp2nJxbGeB7+qm19eQXnTFreICSX8IBMugr/sUU1L6JIx/mWFv7vMTorH1CPUqMVN2ouzig1xXueF/AP4CciancHJc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468576; c=relaxed/simple;
	bh=f6ZpPtkgIp7/VPvhOX1OsYzXVpVb6C07W+ojApHPzlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3/GUDuoF0F7AgakToigf6mY38LkzjzGErs5mefRU7xjmzddqa9/h9aGHLTc+U3jI7NSyL5uoyViA69gmhpfvoCL+eRU+ieC5LQlE9gSPqRUBj/IXE4TAJHMMWYYM4/3evxluG81S9oAHMES3nQa71JayJUqqYLYlIsMCHvqQlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Gmkn1U3W; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Gmkn1U3W"
ARC-Seal: i=1; a=rsa-sha256; t=1774468562; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IAot5zxt3h2EZSdiao/Vu0xf2eG7x5feTbKDnpDLGcCvkISFAfR+SRsJCPUkE+AYg3Mz1I3I36kd6i/PFv576HHUe7IQNuaLLigsDsQwmS5Ps841AaFH78c9MS03Fg/vpVNAHKfKPg6sHFHClW7W+HqNo7vqeaT7Kby/mPq3KMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468562; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aFGe27anJl8+ihWM4ES/2EFNc2nqgkdMIDHQ4zbUuXg=; 
	b=OVpBLN/E7jIiYIKGhVKC1IIJi21sKYtlAivqXKQbfzKP+zg61EY/2cwB3GPnf4YKKrZ93yrzftmgrmuV4Tj9CuTjBKPYthC3wr9mbl05vlxVDSeaIn15HmD9dy4wyM8utC82iiQkXN6X2NhgRWvLHQBHJZLcrwR/p5RgFH2jeqc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468562;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aFGe27anJl8+ihWM4ES/2EFNc2nqgkdMIDHQ4zbUuXg=;
	b=Gmkn1U3W+GIBn4E7xnNB9XCd1wY/ONxbvbt7HAnqS/zMmx2iTV2UdnIHjgLCxAtJ
	YA3r5vOZ/dxhoNwF0q+DijEmObzVshVteHTE4lZ1TGOVi41zeWU1bxvhxniy7X66+jW
	ENkWdaRir99VoaYG39WKTawCpiba8T+Ip6k1e2z0=
Received: by mx.zohomail.com with SMTPS id 1774468560672723.5359493087383;
	Wed, 25 Mar 2026 12:56:00 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 11/12] hook: show disabled hooks in "git hook list"
Date: Wed, 25 Mar 2026 21:55:02 +0200
Message-ID: <20260325195503.1139418-12-adrian.ratiu@collabora.com>
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

Disabled hooks were filtered out of the cache entirely, making them
invisible to "git hook list". Keep them in the cache with a new
"disabled" flag which is propagated to the respective struct hook.

"git hook list" now shows disabled hooks as tab-separated columns,
with the status as a prefix before the name (like scope with
--show-scope). With --show-scope it looks like:

$ git hook list --show-scope pre-commit
global	linter
local	disabled	no-leaks
hook from hookdir

A disabled hook without a command issues a warning instead of the
fatal "hook.X.command must be configured" error. We could also throw
an error, however it seemd a bit excessive to me in this case.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c  | 20 ++++++++++--------
 hook.c          | 54 +++++++++++++++++++++++++++++++++----------------
 hook.h          |  1 +
 t/t1800-hook.sh | 33 +++++++++++++++++++++++++++---
 4 files changed, 80 insertions(+), 28 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 4cc65a0dc5..f671e7f91a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -72,16 +72,20 @@ static int list(int argc, const char **argv, const char *prefix,
 		case HOOK_TRADITIONAL:
 			printf("%s%c", _("hook from hookdir"), line_terminator);
 			break;
-		case HOOK_CONFIGURED:
-			if (show_scope)
-				printf("%s\t%s%c",
-				       config_scope_name(h->u.configured.scope),
-				       h->u.configured.friendly_name,
-				       line_terminator);
+		case HOOK_CONFIGURED: {
+			const char *name = h->u.configured.friendly_name;
+			const char *scope = show_scope ?
+				config_scope_name(h->u.configured.scope) : NULL;
+			if (scope)
+				printf("%s\t%s%s%c", scope,
+				       h->u.configured.disabled ? "disabled\t" : "",
+				       name, line_terminator);
 			else
-				printf("%s%c", h->u.configured.friendly_name,
-				       line_terminator);
+				printf("%s%s%c",
+				       h->u.configured.disabled ? "disabled\t" : "",
+				       name, line_terminator);
 			break;
+		}
 		default:
 			BUG("unknown hook kind");
 		}
diff --git a/hook.c b/hook.c
index 74f5a1df35..cc23276d27 100644
--- a/hook.c
+++ b/hook.c
@@ -115,6 +115,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 struct hook_config_cache_entry {
 	char *command;
 	enum config_scope scope;
+	bool disabled;
 };
 
 /*
@@ -213,8 +214,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
  * every item's string is the hook's friendly-name and its util pointer is
  * the corresponding command string. Both strings are owned by the map.
  *
- * Disabled hooks and hooks missing a command are already filtered out at
- * parse time, so callers can iterate the list directly.
+ * Disabled hooks are kept in the cache with entry->disabled set, so that
+ * "git hook list" can display them. A non-disabled hook missing a command
+ * is fatal; a disabled hook missing a command emits a warning and is kept
+ * in the cache with entry->command = NULL.
  */
 void hook_cache_clear(struct strmap *cache)
 {
@@ -263,21 +266,26 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 			struct hook_config_cache_entry *entry;
 			char *command;
 
-			/* filter out disabled hooks */
-			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
-							hname))
-				continue;
+			bool is_disabled =
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
+			entry->command = xstrdup_or_null(command);
 			entry->scope = scope;
+			entry->disabled = is_disabled;
 			string_list_append(hooks, hname)->util = entry;
 		}
 
@@ -358,8 +366,10 @@ static void list_hooks_add_configured(struct repository *r,
 
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
-		hook->u.configured.command = xstrdup(entry->command);
+		hook->u.configured.command =
+			entry->command ? xstrdup(entry->command) : NULL;
 		hook->u.configured.scope = entry->scope;
+		hook->u.configured.disabled = entry->disabled;
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
@@ -397,7 +407,16 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
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
@@ -412,10 +431,11 @@ static int pick_next_hook(struct child_process *cp,
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
index a0432e8307..5c5628dd1f 100644
--- a/hook.h
+++ b/hook.h
@@ -31,6 +31,7 @@ struct hook {
 			const char *friendly_name;
 			const char *command;
 			enum config_scope scope;
+			bool disabled;
 		} configured;
 	} u;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 6fc6603da8..8c5237449d 100755
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
+	test_grep "^disabled	inactive$" actual
+'
+
+test_expect_success 'disabled hook shows scope with --show-scope' '
+	test_config hook.myhook.event "pre-commit" &&
+	test_config hook.myhook.command "echo hi" &&
+	test_config hook.myhook.enabled false &&
+
+	git hook list --show-scope pre-commit >actual &&
+	test_grep "^local	disabled	myhook$" actual
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

