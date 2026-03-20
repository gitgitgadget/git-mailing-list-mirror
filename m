Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0619377004
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007583; cv=pass; b=YmFLPlv5MIofT/Xl4GOXjVwpyjGtNY1zsGSvUa4VUG4bKO7Oquv6D7LtnQhYwqVIeydWdXIhaVofOrijIsRSgagGbKoi8Jfh9W1/OBXCfFK3Bf/NCv21vt59TY/Pxr3m8tPKZZMEkd8Gegy3oOzhtcqv0gIK6MPYADTtaphyB/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007583; c=relaxed/simple;
	bh=5t8gVZOFSvlUOd+9EeFt1Yb7BUYeXrFJr3fzv2hLEh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAzeFUJNSOTpMeKryv7uB5eTR5jiuJ+zbf0NkOYqt6q481kdlaTLauRf7YaA1Sn3n4Ey7j0G8146dTUWTa+YHFJ+hUaYpd3eALNbGTmKdkJeofH4W6CDaTGuOI5AMzKexhIhbQ1WfbleslA/5yljCrjza/ePxLVsfVAh2q6+pjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=BEPDnFz0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="BEPDnFz0"
ARC-Seal: i=1; a=rsa-sha256; t=1774007568; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MRuAfeBILMb5dfO2+39piO7osLY+2f0fhligTDoRwvK954x8uhxhJDSUgIoi2vrHwAyxUoI0RSs2JuvFvf7Ya5vFJ2XCVOupqKHDXEDr7GPbqTsO8rq557yF6H6zBvZPRCb1LpnKDDGxnMHZRncCl+Zrj14PkhLviIi+7x0TQj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007568; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BdCOXm+eUUAdJhQ1TKr1zEkLLxRCEl5w3Bg+7I2OP7A=; 
	b=IZvRtXzzanizisvIpSxn0gKxDG+niZGuLHR3OSbwKAkUpw7xgU+BSCbyCuH0BeZa/1/spOH4JlPX2pR+9G4LD+RnWZujGibo/n1A3udgx6AoChklW2Qkr3FSlPwittzqes6ncj0b6NAEiMXinKyNQveuqf04mjZL0zzfff4RwtA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007568;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BdCOXm+eUUAdJhQ1TKr1zEkLLxRCEl5w3Bg+7I2OP7A=;
	b=BEPDnFz0ZqVrg3Ky/R2de49FdtXhPzDCALyQkevjyah3Qr91/37qVN7wReq/SAk7
	lp6LcKqHncSVVRGoxJQbLR3jTi7qMvwyhlC8xXUVlazm5o7WmeunuzjtskntlgXQNEE
	nd9LzqYwSgrWpyJYFJzFe9Kv7Tzm0Iyho98y/YRc=
Received: by mx.zohomail.com with SMTPS id 1774007567355658.8352311284592;
	Fri, 20 Mar 2026 04:52:47 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 00/10] config-hook cleanups and two small 'git hook list' features
Date: Fri, 20 Mar 2026 13:52:01 +0200
Message-ID: <20260320115211.177351-1-adrian.ratiu@collabora.com>
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

Hello everyone,

v2 addresses all the feedback received in v1, many thanks to everyone
who contributed.

This series is just minor cleanups / refactorings + two minor feature additions
to `git hook list`, which resulted from the previous series review discussions:

1. The ability to show the config scope (--show-scope).
2. The ability to show which hooks are disabled.

This is now based on the master branch.

I have pushed the branch to Github [1] and provided a clean CI run [2] with
the exception of a known breakage for some MacOS builders (REG_ENHANCED).

Thanks again,
Adrian

1: https://github.com/10ne1/git/tree/dev/aratiu/config-cleanups-v2
2: https://github.com/10ne1/git/actions/runs/23340298770

Changes in v2:
* Cleanly rebased on master, no conflicts (Adrian)
* Fix first patch build break by updating call-sites in same commit (Szeder)
* Drop UNUSED from function declaration in the header file (Eric)
* Drop the new struct hook_config_cache because it's redundant (Junio)
* git hook list now prints in tab separated output format similar
  to git config --show-scope to improve machine parseability (Junio, Patrick)
* Fix small style issues, comments, type, commit messages. (Eric, Patrick)

Range-diff v1 -> v2:
 1:  6f4ac0ddf8 !  1:  aeefa72f33 hook: move unsorted_string_list_remove() to string-list.[ch]
    @@ Commit message
         Move the convenience wrapper from hook to string-list since
         it's a more suitable place. Add a doc comment to the header.
     
    +    Also add a free_util arg to make the function more generic
    +    and make the API similar to other functions in string-list.h.
    +    Update the existing call-sites.
    +
         Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
      /*
       * Callback struct to collect all hook.* keys in a single config pass.
       * commands: friendly-name to command map.
    +@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    + 			struct strmap_entry *e;
    + 
    + 			strmap_for_each_entry(&data->event_hooks, &iter, e)
    +-				unsorted_string_list_remove(e->value, hook_name);
    ++				unsorted_string_list_remove(e->value, hook_name, 0);
    + 		} else {
    + 			struct string_list *hooks =
    + 				strmap_get(&data->event_hooks, value);
    +@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    + 			}
    + 
    + 			/* Re-insert if necessary to preserve last-seen order. */
    +-			unsorted_string_list_remove(hooks, hook_name);
    ++			unsorted_string_list_remove(hooks, hook_name, 0);
    + 			string_list_append(hooks, hook_name);
    + 		}
    + 	} else if (!strcmp(subkey, "command")) {
    +@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    + 			break;
    + 		case 1: /* enabled: undo a prior disabled entry */
    + 			unsorted_string_list_remove(&data->disabled_hooks,
    +-						    hook_name);
    ++						    hook_name, 0);
    + 			break;
    + 		default:
    + 			break; /* ignore unrecognised values */
     
      ## string-list.c ##
     @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 2:  df876b8bc5 !  2:  90e821bdfa hook: fix minor style issues
    @@ Metadata
      ## Commit message ##
         hook: fix minor style issues
     
    -    Fix some minor style nits pointed by Patrick and Junio:
    +    Fix some minor style nits pointed by Patrick, Junio and Eric:
           * Use CALLOC_ARRAY instead of xcalloc.
           * Init struct members during declaration.
           * Simplify if condition boolean logic.
           * Missing curly braces in if/else stmts.
           * Unnecessary header includes.
    -      * Capitalization in error/warn messages.
    +      * Capitalization and full-stop in error/warn messages.
    +      * Curly brace on separate line when defining struct.
           * Comment spelling: free'd -> freed.
     
         These contain no logic changes, the code behaves the same as before.
     
    +    Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix,
      	 */
      	if (argc != 1)
     -		usage_msg_opt(_("You must specify a hook event name to list."),
    -+		usage_msg_opt(_("you must specify a hook event name to list."),
    ++		usage_msg_opt(_("you must specify a hook event name to list"),
      			      builtin_hook_list_usage, list_options);
      
      	hookname = argv[0];
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      
      	if (options->invoked_hook)
     
    + ## hook.h ##
    +@@ hook.h: struct hook {
    + typedef void (*cb_data_free_fn)(void *data);
    + typedef void *(*cb_data_alloc_fn)(void *init_ctx);
    + 
    +-struct run_hooks_opt
    +-{
    ++struct run_hooks_opt {
    + 	/* Environment vars to be set for each hook */
    + 	struct strvec env;
    + 
    +
      ## refs.c ##
     @@ refs.c: static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
      
 3:  7cf6e32087 !  3:  dee1dd49a4 hook: rename cb_data_free/alloc -> hook_data_free/alloc
    @@ hook.h: struct hook {
     +typedef void (*hook_data_free_fn)(void *data);
     +typedef void *(*hook_data_alloc_fn)(void *init_ctx);
      
    - struct run_hooks_opt
    - {
    -@@ hook.h: struct run_hooks_opt
    + struct run_hooks_opt {
    + 	/* Environment vars to be set for each hook */
    +@@ hook.h: struct run_hooks_opt {
      	 *
      	 * The `feed_pipe_ctx` pointer can be used to pass initialization data.
      	 */
 4:  06a9f3bfcb =  4:  86f61204b3 hook: detect & emit two more bugs
 5:  47190d7a22 !  5:  30542de351 hook: replace hook_list_clear() -> string_list_clear_func()
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
      
      	h->kind = HOOK_TRADITIONAL;
      	h->u.traditional.path = xstrdup(hook_path);
    -@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    - 			struct strmap_entry *e;
    - 
    - 			strmap_for_each_entry(&data->event_hooks, &iter, e)
    --				unsorted_string_list_remove(e->value, hook_name);
    -+				unsorted_string_list_remove(e->value, hook_name, 0);
    - 		} else {
    - 			struct string_list *hooks =
    - 				strmap_get(&data->event_hooks, value);
    -@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    - 			}
    - 
    - 			/* Re-insert if necessary to preserve last-seen order. */
    --			unsorted_string_list_remove(hooks, hook_name);
    -+			unsorted_string_list_remove(hooks, hook_name, 0);
    - 			string_list_append(hooks, hook_name);
    - 		}
    - 	} else if (!strcmp(subkey, "command")) {
    -@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    - 			break;
    - 		case 1: /* enabled: undo a prior disabled entry */
    - 			unsorted_string_list_remove(&data->disabled_hooks,
    --						    hook_name);
    -+						    hook_name, 0);
    - 			break;
    - 		default:
    - 			break; /* ignore unrecognised values */
     @@ hook.c: static void list_hooks_add_configured(struct repository *r,
      		struct hook *hook;
      		CALLOC_ARRAY(hook, 1);
    @@ hook.h: struct hook {
     +	hook_data_free_fn data_free;
     +};
      
    - struct run_hooks_opt
    - {
    + struct run_hooks_opt {
    + 	/* Environment vars to be set for each hook */
     @@ hook.h: struct string_list *list_hooks(struct repository *r, const char *hookname,
      			       struct run_hooks_opt *options);
      
    @@ hook.h: struct string_list *list_hooks(struct repository *r, const char *hooknam
     + * Suitable for use as a string_list_clear_func_t callback.
       */
     -void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free);
    -+void hook_free(void *p, const char *str UNUSED);
    ++void hook_free(void *p, const char *str);
      
      /**
       * Frees the hook configuration cache stored in `struct repository`.
 6:  469b8a7192 =  6:  4e1374b84e hook: make consistent use of friendly-name in docs
 7:  dff30a5c06 =  7:  075f8202aa t1800: add test to verify hook execution ordering
 8:  e53a000982 <  -:  ---------- hook: refactor hook_config_cache from strmap to named struct
 -:  ---------- >  8:  8f948bbbe7 hook: introduce hook_config_cache_entry for per-hook data
 9:  7d7753b48a !  9:  dbf81604ed hook: show config scope in git hook list
    @@ Commit message
     
         Without the flag the output is unchanged.
     
    +    The scope is printed as a tab-separated prefix (like "git config --show-scope"),
    +    making it unambiguously machine-parseable even when the friendly name
    +    contains spaces.
    +
         Example usage:
         $ git hook list --show-scope pre-commit
    -    linter (global)
    -    no-leaks (local)
    +    global  linter
    +    local   no-leaks
         hook from hookdir
     
         Traditional hooks from the hookdir are unaffected by --show-scope since
    @@ Documentation/git-hook.adoc: OPTIONS
      	Terminate "list" output lines with NUL instead of newlines.
      
     +--show-scope::
    -+	For "list"; print the config scope (e.g. `local`, `global`, `system`)
    -+	in parentheses after the friendly name of each configured hook, to show
    -+	where it was defined. Traditional hooks from the hookdir are unaffected.
    ++	For "list"; prefix each configured hook's friendly name with a
    ++	tab-separated config scope (e.g. `local`, `global`, `system`),
    ++	mirroring the output style of `git config --show-scope`. Traditional
    ++	hooks from the hookdir are unaffected.
     +
      WRAPPERS
      --------
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix,
      		case HOOK_CONFIGURED:
     -			printf("%s%c", h->u.configured.friendly_name, line_terminator);
     +			if (show_scope)
    -+				printf("%s (%s)%c",
    -+				       h->u.configured.friendly_name,
    ++				printf("%s\t%s%c",
     +				       config_scope_name(h->u.configured.scope),
    ++				       h->u.configured.friendly_name,
     +				       line_terminator);
     +			else
     +				printf("%s%c", h->u.configured.friendly_name,
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
      		}
      	} else if (!strcmp(subkey, "command")) {
      		/* Store command overwriting the old value */
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      
      		for (size_t i = 0; i < hook_names->nr; i++) {
      			const char *hname = hook_names->items[i].string;
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      			struct hook_config_cache_entry *entry;
      			char *command;
      
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      			/* util stores a cache entry; owned by the cache. */
      			CALLOC_ARRAY(entry, 1);
      			entry->command = xstrdup(command);
    @@ t/t1800-hook.sh: test_expect_success 'configured hooks run before hookdir hook'
     +	test_config hook.local-hook.event test-hook --add &&
     +
     +	cat >expected <<-\EOF &&
    -+	global-hook (global)
    -+	local-hook (local)
    ++	global	global-hook
    ++	local	local-hook
     +	EOF
     +	git hook list --show-scope test-hook >actual &&
     +	test_cmp expected actual &&
     +
     +	# without --show-scope the scope must not appear
     +	git hook list test-hook >actual &&
    -+	test_grep ! "(global)" actual &&
    -+	test_grep ! "(local)" actual
    ++	test_grep ! "^global	" actual &&
    ++	test_grep ! "^local	" actual
     +'
     +
      test_expect_success 'git hook run a hook with a bad shebang' '
10:  dabb17aad6 ! 10:  2a67244b20 hook: show disabled hooks in "git hook list"
    @@ Commit message
         invisible to "git hook list". Keep them in the cache with a new
         "disabled" flag which is propagated to the respective struct hook.
     
    -    "git hook list" now shows disabled hooks annotated with "(disabled)"
    -    in the config order. With --show-scope, it looks like:
    +    "git hook list" now shows disabled hooks as tab-separated columns,
    +    with the status as a prefix before the name (like scope with
    +    --show-scope). With --show-scope it looks like:
     
         $ git hook list --show-scope pre-commit
    -    linter (global)
    -    no-leaks (local, disabled)
    +    global  linter
    +    local   disabled        no-leaks
         hook from hookdir
     
         A disabled hook without a command issues a warning instead of the
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix,
      			break;
     -		case HOOK_CONFIGURED:
     -			if (show_scope)
    --				printf("%s (%s)%c",
    --				       h->u.configured.friendly_name,
    +-				printf("%s\t%s%c",
     -				       config_scope_name(h->u.configured.scope),
    +-				       h->u.configured.friendly_name,
    +-				       line_terminator);
     +		case HOOK_CONFIGURED: {
     +			const char *name = h->u.configured.friendly_name;
     +			const char *scope = show_scope ?
     +				config_scope_name(h->u.configured.scope) : NULL;
     +			if (scope)
    -+				printf("%s (%s%s)%c", name, scope,
    -+				       h->u.configured.disabled ? ", disabled" : "",
    - 				       line_terminator);
    -+			else if (h->u.configured.disabled)
    -+				printf("%s (disabled)%c", name, line_terminator);
    ++				printf("%s\t%s%s%c", scope,
    ++				       h->u.configured.disabled ? "disabled\t" : "",
    ++				       name, line_terminator);
      			else
     -				printf("%s%c", h->u.configured.friendly_name,
     -				       line_terminator);
    -+				printf("%s%c", name, line_terminator);
    ++				printf("%s%s%c",
    ++				       h->u.configured.disabled ? "disabled\t" : "",
    ++				       name, line_terminator);
      			break;
     +		}
      		default:
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
      struct hook_config_cache_entry {
      	char *command;
      	enum config_scope scope;
    -+	int disabled;
    ++	unsigned int disabled:1;
      };
      
      /*
     @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
       * every item's string is the hook's friendly-name and its util pointer is
    -  * a hook_config_cache_entry. All strings are owned by the map.
    +  * the corresponding command string. Both strings are owned by the map.
       *
     - * Disabled hooks and hooks missing a command are already filtered out at
     - * parse time, so callers can iterate the list directly.
     + * Disabled hooks are kept in the cache with entry->disabled set, so that
    -+ * "git hook list" can display them. Hooks missing a command are filtered
    -+ * out at build time; if a disabled hook has no command it is silently
    -+ * skipped rather than triggering a fatal error.
    ++ * "git hook list" can display them. A non-disabled hook missing a command
    ++ * is fatal; a disabled hook missing a command emits a warning and is kept
    ++ * in the cache with entry->command = NULL.
       */
    - void hook_cache_clear(struct hook_config_cache *cache)
    + void hook_cache_clear(struct strmap *cache)
      {
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      			struct hook_config_cache_entry *entry;
      			char *command;
      
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      			/* util stores a cache entry; owned by the cache. */
      			CALLOC_ARRAY(entry, 1);
     -			entry->command = xstrdup(command);
    -+			entry->command = command ? xstrdup(command) : NULL;
    ++			entry->command = xstrdup_or_null(command);
      			entry->scope = scope;
     +			entry->disabled = is_disabled;
      			string_list_append(hooks, hname)->util = entry;
    @@ hook.h: struct hook {
      			const char *friendly_name;
      			const char *command;
      			enum config_scope scope;
    -+			int disabled;
    ++			unsigned int disabled:1;
      		} configured;
      	} u;
      
    @@ t/t1800-hook.sh: test_expect_success 'disabled hook does not appear in git hook
     -	test_grep "active" actual &&
     -	test_grep ! "inactive" actual
     +	test_grep "^active$" actual &&
    -+	test_grep "^inactive (disabled)$" actual
    ++	test_grep "^disabled	inactive$" actual
     +'
     +
     +test_expect_success 'disabled hook shows scope with --show-scope' '
    @@ t/t1800-hook.sh: test_expect_success 'disabled hook does not appear in git hook
     +	test_config hook.myhook.enabled false &&
     +
     +	git hook list --show-scope pre-commit >actual &&
    -+	test_grep "myhook (local, disabled)" actual
    ++	test_grep "^local	disabled	myhook$" actual
     +'
     +
     +test_expect_success 'disabled configured hook is not reported as existing by hook_exists' '

Adrian Ratiu (10):
  hook: move unsorted_string_list_remove() to string-list.[ch]
  hook: fix minor style issues
  hook: rename cb_data_free/alloc -> hook_data_free/alloc
  hook: detect & emit two more bugs
  hook: replace hook_list_clear() -> string_list_clear_func()
  hook: make consistent use of friendly-name in docs
  t1800: add test to verify hook execution ordering
  hook: introduce hook_config_cache_entry for per-hook data
  hook: show config scope in git hook list
  hook: show disabled hooks in "git hook list"

 Documentation/config/hook.adoc |  30 +++---
 Documentation/git-hook.adoc    |  16 ++-
 builtin/hook.c                 |  28 +++--
 builtin/receive-pack.c         |  11 +-
 hook.c                         | 187 +++++++++++++++++++++------------
 hook.h                         |  32 ++++--
 refs.c                         |   3 +-
 string-list.c                  |   9 ++
 string-list.h                  |   8 ++
 t/t1800-hook.sh                |  83 ++++++++++++++-
 transport.c                    |   3 +-
 11 files changed, 295 insertions(+), 115 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

