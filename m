Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3427C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C4764FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCKCLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCKCKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:10:53 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79972C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:53 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id g18so14331931qki.15
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B9BO0k8weuBoUdor5eYmxBnJyAyB0QuaCNZCptqko1s=;
        b=EAyaDV3PAGbiHz9RN3MGdDN+KLWlLjY8hv8JDDdqQJbIQ3De6DtLk822SvjnMnMCPm
         3ARYdcQQjR0V/ByiqwzoWn14JjZ1eZ6TDWJJj6atXt9GTMNUXqC/73N/9jKLUmynbadP
         wpL3ZJ7vmasUvz30lH3/SYERdI5eBb+noRCX1vfGvqMtX1CnVQZHHE/eHWfdhfDrT685
         O0kstV48Q3fD286mOKIt27KqkYkM7Zyx5urO37XQYO/a9P/jQQs35ggwZdNQhSBrf45C
         cabwUxOXsWOzCcV6VBxIedD5xuzupt7ms3/WriqMByDmGCMCIUfg4U0872RporoHkQ63
         WdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B9BO0k8weuBoUdor5eYmxBnJyAyB0QuaCNZCptqko1s=;
        b=Tu7cRtUaNANcOaUuXRmd5OBOnj7U/eBR4TCJyLpOoHIy8pytsmKHG6YwyGAQJvjQi1
         XC/KSpHsQ6AH9cFpWDN+N+apwVZFNKu3ehII4Vk0sAdgDdRblpTXScp9yIq7DQbQBHON
         WMaIPJo0sVePeDleU8Y+8bGMYtUmIwv8ekzuGssY1Xgrt3wCi9wGzcZ5JGznBZOg/Ll1
         c3O3W/flxTJWP3JQ6yGie3mHKV57oiv2zfrN1YSBBj59HqzTQagpEfR3KAzf7zqa+Se2
         cDfNliOwHKy2fI6z2NS5+zr8OTfosWKtKhQ0vJrnImUjdXjtA7u0DSDt14zO95tptkfb
         erLA==
X-Gm-Message-State: AOAM530vNDTQxbt+NBQYtSUmNi+xRXdWY/d8eoYHAWQywQF93+ermZrt
        W+zw4YEiNNKGDe2r+M1zvjdFvxgo8Fnc2XLtPrptNOLU/7TfO9VhLkBE5QZdSNmxkaUmZ8Sqs2I
        /fFuwr5d4TyWM5DBmKBTgDeUGJQv7cuvnnikYcv+iX51eHOQYg8JLvXGlTfcKz56c+LtEkGiIkA
        ==
X-Google-Smtp-Source: ABdhPJzK0e+hGDH+9scBhT6sABlsah744TEOJZJy2cEyqmZTuoy7G2QuMd0ymwtJZ2BCtPADGqiILOb174N9zOSv9O0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:b929:: with SMTP id
 u41mr5776784qvf.30.1615428652653; Wed, 10 Mar 2021 18:10:52 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:01 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 01/37] doc: propose hooks managed by the config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin a design document for config-based hooks, managed via git-hook.
Focus on an overview of the implementation and motivation for design
decisions. Briefly discuss the alternatives considered before this
point. Also, attempt to redefine terms to fit into a multihook world.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v7, made some wording changes based on reviewer comments
    (mostly Junio's, I think).

 - Emily

 Documentation/Makefile                        |   1 +
 .../technical/config-based-hooks.txt          | 369 ++++++++++++++++++
 2 files changed, 370 insertions(+)
 create mode 100644 Documentation/technical/config-based-hooks.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a04..2743de8995 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -82,6 +82,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/config-based-hooks
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
diff --git a/Documentation/technical/config-based-hooks.txt b/Documentation/technical/config-based-hooks.txt
new file mode 100644
index 0000000000..1f973117e4
--- /dev/null
+++ b/Documentation/technical/config-based-hooks.txt
@@ -0,0 +1,369 @@
+Configuration-based hook management
+===================================
+:sectanchors:
+
+[[motivation]]
+== Motivation
+
+Replace the `.git/hook/hookname` path as the only source of hooks to execute;
+allow users to define hooks using config files, in a way which is friendly to
+users with multiple repos which have similar needs - hooks can be easily shared
+between multiple Git repos.
+
+Redefine "hook" as an event rather than a single script, allowing users to
+perform multiple unrelated actions on a single event.
+
+Make it easier for users to discover Git's hook feature and automate their
+workflows.
+
+[[user-interfaces]]
+== User interfaces
+
+[[config-schema]]
+=== Config schema
+
+Hooks can be introduced by editing the configuration manually. There are two new
+sections added, `hook` and `hookcmd`.
+
+[[config-schema-hook]]
+==== `hook`
+
+Primarily contains subsections for each hook event. The order of variables in
+these subsections defines the hook command execution order; hook commands can be
+specified by setting the value directly to the command if no additional
+configuration is needed, or by setting the value as the name of a `hookcmd`. If
+Git does not find a `hookcmd` whose subsection matches the value of the given
+command string, Git will try to execute the string directly. Hooks are executed
+by passing the resolved command string to the shell. In the future, hook event
+subsections could also contain per-hook-event settings; see
+<<per-hook-event-settings,the section in Future Work>> for more details.
+
+Also contains top-level hook execution settings, for example, `hook.runHookDir`.
+(These settings are described more in <<library,Library>>.)
+
+----
+[hook "pre-commit"]
+  command = perl-linter
+  command = /usr/bin/git-secrets --pre-commit
+
+[hook "pre-applypatch"]
+  command = perl-linter
+  # for illustration purposes; error behavior isn't planned yet
+  error = ignore
+
+[hook]
+  runHookDir = interactive
+----
+
+[[config-schema-hookcmd]]
+==== `hookcmd`
+
+Defines a hook command and its attributes, which will be used when a hook event
+occurs. Unqualified attributes are assumed to apply to this hook during all hook
+events, but event-specific attributes can also be supplied. The example runs
+`/usr/bin/lint-it --language=perl <args passed by Git>`, but for repos which
+include this config, the hook command will be skipped for all events.
+Theoretically, the last line could be used to "un-skip" the hook command for
+`pre-commit` hooks, but this hasn't been scoped or implemented yet.
+
+----
+[hookcmd "perl-linter"]
+  command = /usr/bin/lint-it --language=perl
+  skip = true
+  # for illustration purposes; below hasn't been defined yet
+  pre-commit-skip = false
+----
+
+[[command-line-api]]
+=== Command-line API
+
+Users should be able to view, run, reorder, and create hook commands via the
+command line. External tools should be able to view a list of hooks in the
+correct order to run. Modifier commands (`edit` and `add`) have not been
+implemented yet and may not be if manually editing the config proves usable
+enough.
+
+*`git hook list <hook-event>`*
+
+*`git hook run <hook-event> [-a <arg>]... [-e <env-var>]...`*
+
+*`git hook edit <hook-event>`*
+
+*`git hook add <hook-command> <hook-event> <options...>`*
+
+[[hook-editor]]
+=== Hook editor
+
+The tool which is presented by `git hook edit <hook-command>`. Ideally, this
+tool should be easier to use than manually editing the config, and then produce
+a concise config afterwards. It may take a form similar to `git rebase
+--interactive`. This has not been designed or implemented yet and may not be if
+the config proves usable enough.
+
+[[implementation]]
+== Implementation
+
+[[library]]
+=== Library
+
+`hook.c` and `hook.h` are responsible for interacting with the config files. The
+hook library provides a basic API to call all hooks in config order with more
+complex options passed via `struct run_hooks_opt`:
+
+*`int run_hooks(const char *hookname, struct run_hooks_opt *options)`*
+
+`struct run_hooks_opt` allows callers to set:
+
+- environment variables
+- command-line arguments
+- behavior for the hook command provided by `run-command.h:find_hook()` (see
+  below)
+- a method to provide stdin to each hook, either via a file containing stdin, a
+  `struct string_list` containing a list of lines to print, or a callback
+  function to allow the caller to populate stdin manually
+- a method to process stdout from each hook, e.g. for printing to sideband
+  during a network operation
+- parallelism
+- a custom working directory for hooks to execute in
+
+And this struct can be extended with more options as necessary in the future.
+
+The "legacy" hook provided by `run-command.h:find_hook()` - that is, the hook
+present in `.git/hooks/<hookname>` or
+`$(git config --get core.hooksPath)/<hookname>` - can be handled in a number of
+ways, providing an avenue to deprecate these "legacy" hooks if desired. The
+handling is based on a config `hook.runHookDir`, which is checked against a
+number of cases:
+
+- "no": the legacy hook will not be run
+- "error": Git will print a warning to stderr before ignoring the legacy hook
+- "interactive": Git will prompt the user before running the legacy hook
+- "warn": Git will print a warning to stderr before running the legacy hook
+- "yes" (default): Git will silently run the legacy hook
+
+In case this list is expanded in the future, if a value for `hook.runHookDir` is
+given which Git does not recognize, Git should discard that config entry. For
+example, if "warn" was specified at system level and "junk" was specified at
+global level, Git would resolve the value to "warn"; if the only time the config
+was set was to "junk", Git would use the default value of "yes" (but print a
+warning to the user first to let them know their value is wrong).
+
+`struct hookcmd` is expected to grow in size over time as more functionality is
+added to hooks; so that other parts of the code don't need to understand the
+config schema, `struct hookcmd` should contain logical values instead of string
+pairs.
+
+By default, hook parallelism is chosen based on the semantics of each hook;
+callsites initialize their `struct run_hooks_opt` via one of two macros,
+`RUN_HOOKS_OPT_INIT_SYNC` or `RUN_HOOKS_OPT_INIT_ASYNC`. The default number of
+jobs can be configured in `hook.jobs`; this config applies across all hook
+events. If unset, the value of `online_cpus()` (equivalent to `nproc`) is used.
+
+[[builtin]]
+=== Builtin
+
+`builtin/hook.c` is responsible for providing the frontend. It's responsible for
+formatting user-provided data and then calling the library API to set the
+configs as appropriate. The builtin frontend is not responsible for calling the
+config directly, so that other areas of Git can rely on the hook library to
+understand the most recent config schema for hooks.
+
+[[migration]]
+=== Migration path
+
+[[stage-0]]
+==== Stage 0
+
+Hooks are called by running `run-command.h:find_hook()` with the hookname and
+executing the result. The hook library and builtin do not exist. Hooks only
+exist as specially named scripts within `.git/hooks/`.
+
+[[stage-1]]
+==== Stage 1
+
+`git hook list --porcelain <hook-event>` is implemented. `hook.h:run_hooks()` is
+taught to include `run-command.h:find_hook()` at the end; calls to `find_hook()`
+are replaced with calls to `run_hooks()`. Users can opt-in to config-based hooks
+simply by creating some in their config; otherwise users should remain
+unaffected by the change.
+
+[[stage-2]]
+==== Stage 2
+
+The call to `find_hook()` inside of `run_hooks()` learns to check for a config,
+`hook.runHookDir`. Users can opt into managing their hooks completely via the
+config this way.
+
+[[stage-3]]
+==== Stage 3
+
+`.git/hooks` is removed from the template and the hook directory is considered
+deprecated. To avoid breaking older repos, the default of `hook.runHookDir` is
+not changed, and `find_hook()` is not removed.
+
+[[caveats]]
+== Caveats
+
+[[security]]
+=== Security and repo config
+
+Part of the motivation behind this refactor is to mitigate hooks as an attack
+vector.footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
+However, as the design stands, users can still provide hooks in the repo-level
+config, which is included when a repo is zipped and sent elsewhere. The
+security of the repo-level config is still under discussion; this design
+generally assumes the repo-level config is secure, which is not true yet. This
+assumption was made to avoid overcomplicating the design. So, this series
+doesn't particularly improve security or resistance to zip attacks.
+
+[[ease-of-use]]
+=== Ease of use
+
+The config schema is nontrivial; that's why it's important for the `git hook`
+modifier commands to be usable. Contributors with UX expertise are encouraged to
+share their suggestions.
+
+[[alternatives]]
+== Alternative approaches
+
+A previous summary of alternatives exists in the
+archives.footnote:[https://lore.kernel.org/git/20191116011125.GG22855@google.com]
+
+The table below shows a number of goals and how they might be achieved with
+config-based hooks, by implementing directory support (i.e.
+'.git/hooks/pre-commit.d'), or as hooks are run today.
+
+.Comparison of alternatives
+|===
+|Feature |Config-based hooks |Hook directories |Status quo
+
+|Supports multiple hooks
+|Natively
+|Natively
+|With user effort
+
+|Supports parallelization
+|Natively
+|Natively
+|No (user's multihook trampoline script would need to handle parallelism)
+
+|Safer for zipped repos
+|A little
+|No
+|No
+
+|Previous hooks just work
+|If configured
+|Yes
+|Yes
+
+|Can install one hook to many repos
+|Yes
+|With symlinks or core.hooksPath
+|With symlinks or core.hooksPath
+
+|Discoverability
+|Findable with 'git help git' or tab-completion via 'git hook' subcommand
+|Findable via improved documentation
+|Same as before
+
+|Hard to run unexpected hook
+|If configured
+|Could be made to warn or look for a config
+|No
+|===
+
+[[status-quo]]
+=== Status quo
+
+Today users can implement multihooks themselves by using a "trampoline script"
+as their hook, and pointing that script to a directory or list of other scripts
+they wish to run.
+
+[[hook-directories]]
+=== Hook directories
+
+Other contributors have suggested Git learn about the existence of a directory
+such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.
+
+[[future-work]]
+== Future work
+
+[[execution-ordering]]
+=== Execution ordering
+
+We may find that config order is insufficient for some users; for example,
+config order makes it difficult to add a new hook to the system or global config
+which runs at the end of the hook list. A new ordering schema should be:
+
+1) Specified by a `hook.order` config, so that users will not unexpectedly see
+their order change;
+
+2) Either dependency or numerically based.
+
+Dependency-based ordering is prone to classic linked-list problems, like a
+cycles and handling of missing dependencies. But, it paves the way for enabling
+parallelization if some tasks truly depend on others.
+
+Numerical ordering makes it tricky for Git to generate suggested ordering
+numbers for each command, but is easy to determine a definitive order.
+
+[[parallelization]]
+=== Parallelization with dependencies
+
+Currently hooks use a naive parallelization scheme or are run in series.  But if
+one hook depends on another's output, then users will want to specify those
+dependencies. If we decide to solve this problem, we may want to look to modern
+build systems for inspiration on how to manage dependencies and parallel tasks.
+
+[[nontrivial-hooks]]
+=== Multihooks and nontrivial output
+
+Some hooks - like 'proc-receive' - don't lend themselves well to multihooks at
+all. In the case of 'proc-receive', for now, multiple hook definitions are
+disallowed. In the future we might be able to conceive a better approach, for
+example, running the hooks in series and using the output from one hook as the
+input to the next.
+
+[[securing-hookdir-hooks]]
+=== Securing hookdir hooks
+
+With the design as written in this doc, it's still possible for a malicious user
+to modify `.git/config` to include `hook.pre-receive.command = rm -rf /`, then
+zip their repo and send it to another user. It may be necessary to teach Git to
+only allow inlined hooks like this if they were configured outside of the local
+scope (in other words, only run hookcmds, and only allow hookcmds to be
+configured in global or system scope); or another approach, like a list of safe
+projects, might be useful. It may also be sufficient (or at least useful) to
+teach a `hook.disableAll` config or similar flag to the Git executable.
+
+[[submodule-inheritance]]
+=== Submodule inheritance
+
+It's possible some submodules may want to run the identical set of hooks that
+their superrepo runs. While a globally-configured hook set is helpful, it's not
+a great solution for users who have multiple repos-with-submodules under the
+same user. It would be useful for submodules to learn how to run hooks from
+their superrepo's config, or inherit that hook setting.
+
+[[per-hook-event-settings]]
+=== Per-hook-event settings
+
+It might be desirable to keep settings specifically for some hook events, but
+not for others - for example, a user may wish to disable hookdir hooks for all
+events but pre-commit, which they haven't had time to convert yet; or, a user
+may wish for execution order settings to differ based on hook event. In that
+case, it would be useful to set something like `hook.pre-commit.executionOrder`
+which would not apply to the 'prepare-commit-msg' hook, for example.
+
+[[glossary]]
+== Glossary
+
+*hook event*
+
+A point during Git's execution where user scripts may be run, for example,
+_prepare-commit-msg_ or _pre-push_.
+
+*hook command*
+
+A user script or executable which will be run on one or more hook events.
-- 
2.31.0.rc2.261.g7f71774620-goog

