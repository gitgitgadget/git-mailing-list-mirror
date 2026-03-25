Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0030F93D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468555; cv=pass; b=nhoFDWTaHFCYyw7oKx6EU0h40mot7bGi9q+lJdeQciezYdfm93gs4f+2tczY4RISmy6hjALw7b9cagZP1qkq5oQvkWSaze/Hyn+BTZGcIAFWb5+9ZqajmMn0s7YJ6urDBjoEmbAmpY3sKomQKP9MiM+7rrCOR831bbV6iw72APU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468555; c=relaxed/simple;
	bh=AKn3d3FywyI8iDphhfNa0qsFCO86U8jMWIicni17nck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vd3mWRlMP+kySkJKl83bxHRzgrI8wXcXoC4XhNb3hAFOimBxF+ZjcttjcurFRjGS6EXOPOzR2D5bU4hKTUVT5ym8Vypyhw/5+24deF/gchxpfYzhttt4+x9vwMU/IY5YEJF545vyP/xw1yPbdFGQTj6yh7sPD14IT/LqFNikIa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=RfmJlC8S; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="RfmJlC8S"
ARC-Seal: i=1; a=rsa-sha256; t=1774468539; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mRvKg6RMDzMCh+oQ0B2ZZ23RyUlU4+uDrssRSQScCTvKcPLpjw6vMZS0spDdfEKWWRgOYx8NtiZRw5J4FmywdXG3n6oZ1ZsYK5pikf0aS1hFZZV2ODLmYB9aPFDY5i8X+Hn27K9FH0XPIoZ+6dRfYdjhHpxCqUSe874RuL6/T+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468539; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9t5xrRQGWdyhsrFdAL8DixiIhVkqNcXL06U26ohf4kQ=; 
	b=LXl7nE2TDCZI5NHtvY2ctTsDFRpvCX0yaDCCWsykowNigzWI87F31WCH3X9daWuOLBvx46fQxGT2OFYsK1PIlbIlLXW1HERnHEZvOZ+e4Lh7xsAsX+8Yn3H6poc2GrQLBCrYTUGFeiUVV8Np24fqUcfBOl2KBVb6Ec8IqrL2Dxg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468539;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9t5xrRQGWdyhsrFdAL8DixiIhVkqNcXL06U26ohf4kQ=;
	b=RfmJlC8S9G3bfpYGgOmF+hJ7BOuiCtF4+sIMbQ0UOqIsu0A5c1ddIL+JgPk47S/E
	b+UTqOTIfZtiwdCAgnxOOXVrF5Z2Nw2tgaYUookyqsjMS18xsca7p9wzjd/U9pd6mL4
	4rVGC3zk8Qrs720fYdEEiihUE6+1DhsjJQWeWiXA=
Received: by mx.zohomail.com with SMTPS id 1774468537491853.6910969972129;
	Wed, 25 Mar 2026 12:55:37 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 00/12] config-hook cleanups and three small git-hook features
Date: Wed, 25 Mar 2026 21:54:51 +0200
Message-ID: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
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

v3 addresses all the feedback and requests received in v2, many thanks to all
who contributed.

Let's please stop adding features since this is getting rather big again. :)
New features can be added in subsequent patches.

This series is mostly for minor cleanups, bug fixes and refactorings + three
minor feature additions to git-hook, which resulted from review discussions:

1. The ability to show the config scope (--show-scope).
2. The ability to show which hooks are disabled.
3. The ability reject unknown hook names with "--allow-unknown-hook-name" as
   an escape hatch.

The series is based on the master branch.

Branch pushed GitHub: [1]
Successful CI run: [2]

Thanks again,
Adrian

1: https://github.com/10ne1/git/tree/dev/aratiu/config-cleanups-v3
2: https://github.com/10ne1/git/actions/runs/23540818495

Changes in v3:
* New commit: properly initialize strbuf in receive-pack.c (Patrick)
* New commit: add a check which prevents unknown hooks with git-hook(1) (Patrick)
* Removed duplicated function doc comment between .h and .c files (Patrick)
* Extended `git hook list` test to also include a hook from the hookdir (Patrick)
* Converted unsigned int disabled:1 to proper bool (Patrick)
* Minor commit rewording, header sorting, blank line fixes (Patrick)

Range-diff v2 -> v3:
 1:  aeefa72f33 =  1:  db8b7b0552 hook: move unsorted_string_list_remove() to string-list.[ch]
 -:  ---------- >  2:  02854ecc8b builtin/receive-pack: properly init receive_hook strbuf
 2:  90e821bdfa !  3:  14dcedcd9b hook: fix minor style issues
    @@ Metadata
      ## Commit message ##
         hook: fix minor style issues
     
    -    Fix some minor style nits pointed by Patrick, Junio and Eric:
    +    Fix some minor style nits pointed out by Patrick, Junio and Eric:
           * Use CALLOC_ARRAY instead of xcalloc.
           * Init struct members during declaration.
           * Simplify if condition boolean logic.
    @@ Commit message
           * Capitalization and full-stop in error/warn messages.
           * Curly brace on separate line when defining struct.
           * Comment spelling: free'd -> freed.
    +      * Sort the included headers.
    +      * Blank line fixes to improve readability.
     
         These contain no logic changes, the code behaves the same as before.
     
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix,
      	}
     
      ## builtin/receive-pack.c ##
    +@@
    + 
    + #include "builtin.h"
    + #include "abspath.h"
    +-
    ++#include "commit.h"
    ++#include "commit-reach.h"
    + #include "config.h"
    ++#include "connect.h"
    ++#include "connected.h"
    + #include "environment.h"
    ++#include "exec-cmd.h"
    ++#include "fsck.h"
    + #include "gettext.h"
    ++#include "gpg-interface.h"
    + #include "hex.h"
    +-#include "lockfile.h"
    +-#include "pack.h"
    +-#include "refs.h"
    +-#include "pkt-line.h"
    +-#include "sideband.h"
    +-#include "run-command.h"
    + #include "hook.h"
    +-#include "exec-cmd.h"
    +-#include "commit.h"
    ++#include "lockfile.h"
    + #include "object.h"
    +-#include "remote.h"
    +-#include "connect.h"
    +-#include "string-list.h"
    +-#include "oid-array.h"
    +-#include "connected.h"
    +-#include "strvec.h"
    +-#include "version.h"
    +-#include "gpg-interface.h"
    +-#include "sigchain.h"
    +-#include "fsck.h"
    +-#include "tmp-objdir.h"
    +-#include "oidset.h"
    +-#include "packfile.h"
    + #include "object-file.h"
    + #include "object-name.h"
    + #include "odb.h"
    ++#include "oid-array.h"
    ++#include "oidset.h"
    ++#include "pack.h"
    ++#include "packfile.h"
    ++#include "parse-options.h"
    ++#include "pkt-line.h"
    + #include "protocol.h"
    +-#include "commit-reach.h"
    ++#include "refs.h"
    ++#include "remote.h"
    ++#include "run-command.h"
    + #include "server-info.h"
    ++#include "setup.h"
    ++#include "shallow.h"
    ++#include "sideband.h"
    ++#include "sigchain.h"
    ++#include "string-list.h"
    ++#include "strvec.h"
    ++#include "tmp-objdir.h"
    + #include "trace.h"
    + #include "trace2.h"
    ++#include "version.h"
    + #include "worktree.h"
    +-#include "shallow.h"
    +-#include "setup.h"
    +-#include "parse-options.h"
    + 
    + static const char * const receive_pack_usage[] = {
    + 	N_("git receive-pack <git-dir>"),
     @@ builtin/receive-pack.c: static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
      static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
      {
      	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
     -	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
     +	struct receive_hook_feed_state *data;
    ++
     +	CALLOC_ARRAY(data, 1);
      	data->report = init_state->report;
      	data->cmd = init_state->cmd;
      	data->skip_broken = init_state->skip_broken;
    + 	strbuf_init(&data->buf, 0);
    ++
    + 	return data;
    + }
    + 
     @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      {
      	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      	/* set up stdin callback */
     -	feed_init_state.cmd = commands;
     -	feed_init_state.skip_broken = skip_broken;
    +-	strbuf_init(&feed_init_state.buf, 0);
      	opt.feed_pipe_ctx = &feed_init_state;
      	opt.feed_pipe = feed_receive_hook_cb;
      	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
     
      ## hook.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "abspath.h"
    + #include "advice.h"
    ++#include "config.h"
    ++#include "environment.h"
    + #include "gettext.h"
    + #include "hook.h"
    +-#include "path.h"
    + #include "parse.h"
    ++#include "path.h"
    + #include "run-command.h"
    +-#include "config.h"
    ++#include "setup.h"
    + #include "strbuf.h"
    + #include "strmap.h"
    +-#include "environment.h"
    +-#include "setup.h"
    + 
    + const char *find_hook(struct repository *r, const char *name)
    + {
     @@ hook.c: static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
      	if (!h)
      		return;
    @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *c
      		struct string_list *hook_names = e->value;
     -		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
     +		struct string_list *hooks;
    -+		CALLOC_ARRAY(hooks, 1);
      
    ++		CALLOC_ARRAY(hooks, 1);
      		string_list_init_dup(hooks);
      
    + 		for (size_t i = 0; i < hook_names->nr; i++) {
     @@ hook.c: static struct strmap *get_hook_config_cache(struct repository *r)
      		 * it just once on the first call.
      		 */
    @@ hook.c: static void list_hooks_add_configured(struct repository *r,
      		const char *command = configured_hooks->items[i].util;
     -		struct hook *hook = xcalloc(1, sizeof(struct hook));
     +		struct hook *hook;
    ++
     +		CALLOC_ARRAY(hook, 1);
      
      		if (options && options->feed_pipe_cb_data_alloc)
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      	if (options->invoked_hook)
     
      ## hook.h ##
    +@@
    + #ifndef HOOK_H
    + #define HOOK_H
    +-#include "strvec.h"
    + #include "run-command.h"
    + #include "string-list.h"
    + #include "strmap.h"
    ++#include "strvec.h"
    + 
    + struct repository;
    + 
     @@ hook.h: struct hook {
      typedef void (*cb_data_free_fn)(void *data);
      typedef void *(*cb_data_alloc_fn)(void *init_ctx);
 3:  dee1dd49a4 =  4:  bd49f58486 hook: rename cb_data_free/alloc -> hook_data_free/alloc
 4:  86f61204b3 =  5:  9502a98b09 hook: detect & emit two more bugs
 5:  30542de351 !  6:  b623e682c7 hook: replace hook_list_clear() -> string_list_clear_func()
    @@ Commit message
         API becomes cleaner, e.g. no more calls with NULL function args
         like hook_list_clear(hooks, NULL).
     
    +    In other words, the callers don't need to keep track of hook
    +    internal state to determine when cleanup is necessary or not
    +    (pass NULL) because each `struct hook` now owns its data_free
    +    callback.
    +
         Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
      }
      
     -static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
    -+/*
    -+ * Frees a struct hook stored as the util pointer of a string_list_item.
    -+ * Suitable for use as a string_list_clear_func_t callback.
    -+ */
     +void hook_free(void *p, const char *str UNUSED)
      {
     +	struct hook *h = p;
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
      	h->kind = HOOK_TRADITIONAL;
      	h->u.traditional.path = xstrdup(hook_path);
     @@ hook.c: static void list_hooks_add_configured(struct repository *r,
    - 		struct hook *hook;
    + 
      		CALLOC_ARRAY(hook, 1);
      
     -		if (options && options->feed_pipe_cb_data_alloc)
 6:  4e1374b84e =  7:  315b62b24e hook: make consistent use of friendly-name in docs
 7:  075f8202aa =  8:  830cea298b t1800: add test to verify hook execution ordering
 8:  8f948bbbe7 !  9:  4f4a720cb8 hook: introduce hook_config_cache_entry for per-hook data
    @@ hook.c: static void list_hooks_add_configured(struct repository *r,
     -		const char *command = configured_hooks->items[i].util;
     +		struct hook_config_cache_entry *entry = configured_hooks->items[i].util;
      		struct hook *hook;
    - 		CALLOC_ARRAY(hook, 1);
      
    + 		CALLOC_ARRAY(hook, 1);
     @@ hook.c: static void list_hooks_add_configured(struct repository *r,
      
      		hook->kind = HOOK_CONFIGURED;
 9:  dbf81604ed ! 10:  164e3df981 hook: show config scope in git hook list
    @@ hook.h
      #ifndef HOOK_H
      #define HOOK_H
     +#include "config.h"
    - #include "strvec.h"
      #include "run-command.h"
      #include "string-list.h"
    + #include "strmap.h"
     @@ hook.h: struct hook {
      		struct {
      			const char *friendly_name;
    @@ t/t1800-hook.sh: test_expect_success 'configured hooks run before hookdir hook'
      '
      
     +test_expect_success 'git hook list --show-scope shows config scope' '
    ++	setup_hookdir &&
     +	test_config_global hook.global-hook.command "echo global" &&
    -+	test_config_global hook.global-hook.event test-hook --add &&
    ++	test_config_global hook.global-hook.event pre-commit --add &&
     +	test_config hook.local-hook.command "echo local" &&
    -+	test_config hook.local-hook.event test-hook --add &&
    ++	test_config hook.local-hook.event pre-commit --add &&
     +
     +	cat >expected <<-\EOF &&
     +	global	global-hook
     +	local	local-hook
    ++	hook from hookdir
     +	EOF
    -+	git hook list --show-scope test-hook >actual &&
    ++	git hook list --show-scope pre-commit >actual &&
     +	test_cmp expected actual &&
     +
     +	# without --show-scope the scope must not appear
    -+	git hook list test-hook >actual &&
    ++	git hook list pre-commit >actual &&
     +	test_grep ! "^global	" actual &&
     +	test_grep ! "^local	" actual
     +'
10:  2a67244b20 ! 11:  ab9cd3ec68 hook: show disabled hooks in "git hook list"
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
      struct hook_config_cache_entry {
      	char *command;
      	enum config_scope scope;
    -+	unsigned int disabled:1;
    ++	bool disabled;
      };
      
      /*
    @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *c
     -			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
     -							hname))
     -				continue;
    -+			int is_disabled =
    ++			bool is_disabled =
     +				!!unsorted_string_list_lookup(
     +					&cb_data.disabled_hooks, hname);
      
    @@ hook.h: struct hook {
      			const char *friendly_name;
      			const char *command;
      			enum config_scope scope;
    -+			unsigned int disabled:1;
    ++			bool disabled;
      		} configured;
      	} u;
      
 -:  ---------- > 12:  dce86488bc hook: reject unknown hook names in git-hook(1)

Adrian Ratiu (12):
  hook: move unsorted_string_list_remove() to string-list.[ch]
  builtin/receive-pack: properly init receive_hook strbuf
  hook: fix minor style issues
  hook: rename cb_data_free/alloc -> hook_data_free/alloc
  hook: detect & emit two more bugs
  hook: replace hook_list_clear() -> string_list_clear_func()
  hook: make consistent use of friendly-name in docs
  t1800: add test to verify hook execution ordering
  hook: introduce hook_config_cache_entry for per-hook data
  hook: show config scope in git hook list
  hook: show disabled hooks in "git hook list"
  hook: reject unknown hook names in git-hook(1)

 Documentation/config/hook.adoc |  30 +++---
 Documentation/git-hook.adoc    |  27 +++--
 Makefile                       |   1 +
 builtin/hook.c                 |  61 +++++++++--
 builtin/receive-pack.c         |  64 +++++------
 hook.c                         | 192 +++++++++++++++++++++------------
 hook.h                         |  34 +++---
 refs.c                         |   3 +-
 string-list.c                  |   9 ++
 string-list.h                  |   8 ++
 t/t1800-hook.sh                | 167 ++++++++++++++++++++++------
 transport.c                    |   3 +-
 12 files changed, 424 insertions(+), 175 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

