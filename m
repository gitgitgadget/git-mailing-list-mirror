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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E1C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFB422DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgLEBq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLEBq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:46:57 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A13C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:17 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id z129so7046775qkb.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6cPPi981+oTQnopSEARAzAyCvS8FWO93GfCv8uq8KzU=;
        b=ZZ0PVP4SmQQNdtpZ49CAOsXwW7BioUpjKXEM3PPk9xMXgqiiGO2NAKpPvkoyqQUjaA
         S9UCkJ5pcM5zHPF75NP2Czr5+mUm05PB4Kp4NMwlexSSWfvBtcl+MJxKKw7FpObAXGC3
         Hg9LXPVOIp5lg/FHa9xR25CBmXHltqkWSvHBszVV6uNXn9vTLoH9gr+q+oPzKLmT6dXo
         +JUFbvuWcrPGG/jSdH7IraFR3YibJ/XJhouQ3US3FLZDkVBOC3EIAvI4VOwutv/iS2y9
         h9nz3gsdnPcQ+mS9h6L7Q+aNiOxnsbeLY4n5mXvq6In/koW3kGHatSFxA+vmbq2aCd66
         /F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6cPPi981+oTQnopSEARAzAyCvS8FWO93GfCv8uq8KzU=;
        b=qdQldsNclXqBA0mNRhnRsTBHo+nXxvAbeGFN8SJVcveNk6FUAjrs58QcOn/bMJ4TUj
         8Kxq9UCqy/ekkNT3ujlq2bsTNRWc9lzOqWeUN+9PoC8rKKCDxqGZDpJ/Y4kwR+0IPKUZ
         Tisg9a6rbfAuYsY2bjdompOosDR7Ce6lrmyMIjfyGsu9+StFwqBH5Tt75i18KjChCUCl
         8yXSjq6dO+wUA2gM9oYCyIboJCjq6wZo8WZzvdTo0zt/yqlspiY6kXku5cw1nX3Qt1bz
         dDby5YgtajEHkGk9wn51wmG/2T2QL949KSm+IbXcgPe8i3/Xw0v2qm1Kua0eTpd2TMZ4
         fm5Q==
X-Gm-Message-State: AOAM5325YLSttHAlc7s3vu5oO2CcOtatgHvdvXxS2jQcgceXzCaf7GGw
        c/wFMgdUHdHNJlnUjdw3WIlYF3vJpcPqiwgbuclK+Fb5QCwP4PptV+5qKXCOGC4pTLdAAY5a4Ar
        +cGSJhLN2jXMmVN7RkJmYQ2I4Iwb8BZjCZCPunEpPgQ6PrYliYl+bFWIApSLjn7sR97BWSHTMKg
        ==
X-Google-Smtp-Source: ABdhPJz4qF9Jfx9lYC1VqvxQcaKwNRCbtrwkR8lU8q6uTGwbuN+mZ62NA/IcDZgaZT3RjPqjtJ1VijsX81KrGXva4Wo=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:7a9:: with SMTP id
 v9mr9180644qvz.38.1607132776679; Fri, 04 Dec 2020 17:46:16 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:51 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 01/17] doc: propose hooks managed by the config
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
    Since v4, addressed comments from Jonathan Tan about wording. However, I have
    not addressed AEvar's comments or done a full re-review of this document.
    I wanted to get the rest of the series out for initial review first.
    
     - Emily
    
    Since v4, addressed comments from Jonathan Tan about wording.

 Documentation/Makefile                        |   1 +
 .../technical/config-based-hooks.txt          | 367 ++++++++++++++++++
 2 files changed, 368 insertions(+)
 create mode 100644 Documentation/technical/config-based-hooks.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 80d1908a44..58d6b3acbe 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -81,6 +81,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/config-based-hooks
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
diff --git a/Documentation/technical/config-based-hooks.txt b/Documentation/technical/config-based-hooks.txt
new file mode 100644
index 0000000000..dac391f505
--- /dev/null
+++ b/Documentation/technical/config-based-hooks.txt
@@ -0,0 +1,367 @@
+Configuration-based hook management
+===================================
+:sectanchors:
+
+[[motivation]]
+== Motivation
+
+Replace the .git/hook/hookname path as the only source of hooks to execute;
+allow users to define hooks using config files, in a way which is friendly to
+users with multiple repos which have similar needs.
+
+Redefine "hook" as an event rather than a single script, allowing users to
+perform unrelated actions on a single event.
+
+Take a step closer to safety when copying zipped Git repositories from untrusted
+users by making it more apparent to users which scripts will be run during
+normal Git operations.
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
+Also contains top-level hook execution settings, for example, `hook.runHookDir`
+or `hook.disableAll`. (These settings are described more in
+<<library,Library>>.)
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
+include this config, the hook command will be skipped for all events to which
+it's normally subscribed _except_ `pre-commit`.
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
+Users should be able to view, reorder, and create hook commands via the command
+line. External tools should be able to view a list of hooks in the correct order
+to run.
+
+*`git hook list <hook-event>`*
+
+*`git hook list (--system|--global|--local|--worktree)`*
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
+--interactive`.
+
+[[implementation]]
+== Implementation
+
+[[library]]
+=== Library
+
+`hook.c` and `hook.h` are responsible for interacting with the config files. In
+the case when the code generating a hook event doesn't have special concerns
+about how to run the hooks, the hook library will provide a basic API to call
+all hooks in config order with an `strvec` provided by the code which
+generates the hook event:
+
+*`int run_hooks(const char *hookname, struct strvec *args)`*
+
+This call includes the hook command provided by `run-command.h:find_hook()`;
+eventually, this legacy hook will be gated by a config `hook.runHookDir`. The
+config is checked against a number of cases:
+
+- "no": the legacy hook will not be run
+- "interactive": Git will prompt the user before running the legacy hook
+- "warn": Git will print a warning to stderr before running the legacy hook
+- "yes" (default): Git will silently run the legacy hook
+
+In case this list is expanded in the future, if a value for `hook.runHookDir` is
+given which Git does not recognize, Git should discard that config entry. For
+example, if "warn" was specified at system level and "junk" was specified at
+global level, Git would resolve the value to "warn"; if the only time the config
+was set was to "junk", Git would use the default value of "yes".
+
+If the caller wants to do something more complicated, the hook library can also
+provide a callback API:
+
+*`int for_each_hookcmd(const char *hookname, hookcmd_function *cb)`*
+
+Finally, to facilitate the builtin, the library will also provide the following
+APIs to interact with the config:
+
+----
+int set_hook_commands(const char *hookname, struct string_list *commands,
+	enum config_scope scope);
+int set_hookcmd(const char *hookcmd, struct hookcmd options);
+
+int list_hook_commands(const char *hookname, struct string_list *commands);
+int list_hooks_in_scope(enum config_scope scope, struct string_list *commands);
+----
+
+`struct hookcmd` is expected to grow in size over time as more functionality is
+added to hooks; so that other parts of the code don't need to understand the
+config schema, `struct hookcmd` should contain logical values instead of string
+pairs.
+
+----
+struct hookcmd {
+  const char *name;
+  const char *command;
+
+  /* for illustration only; not planned at present */
+  int parallelizable;
+  const char *hookcmd_before;
+  const char *hookcmd_after;
+  enum recovery_action on_fail;
+}
+----
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
+`git hook list --porcelain <hook-event>` is implemented. Users can replace their
+`.git/hooks/<hook-event>` scripts with a trampoline based on `git hook list`'s
+output. Modifier commands like `git hook add` and `git hook edit` can be
+implemented around this time as well.
+
+[[stage-2]]
+==== Stage 2
+
+`hook.h:run_hooks()` is taught to include `run-command.h:find_hook()` at the
+end; calls to `find_hook()` are replaced with calls to `run_hooks()`. Users can
+opt-in to config-based hooks simply by creating some in their config; otherwise
+users should remain unaffected by the change.
+
+[[stage-3]]
+==== Stage 3
+
+The call to `find_hook()` inside of `run_hooks()` learns to check for a config,
+`hook.runHookDir`. Users can opt into managing their hooks completely via the
+config this way.
+
+[[stage-4]]
+==== Stage 4
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
+vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
+however, as the design stands, users can still provide hooks in the repo-level
+config, which is included when a repo is zipped and sent elsewhere.  The
+security of the repo-level config is still under discussion; this design
+generally assumes the repo-level config is secure, which is not true yet. The
+goal is to avoid an overcomplicated design to work around a problem which has
+ceased to exist.
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
+[[comparison]]
+=== Comparison table
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
+|No
+|No
+
+|Discoverability
+|Better (in `git help git`)
+|Same as before
+|Same as before
+
+|Hard to run unexpected hook
+|If configured
+|No
+|No
+|===
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
+=== Parallelization
+
+Users with many hooks might want to run them simultaneously, if the hooks don't
+modify state; if one hook depends on another's output, then users will want to
+specify those dependencies. If we decide to solve this problem, we may want to
+look to modern build systems for inspiration on how to manage dependencies and
+parallel tasks.
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
2.28.0.rc0.142.g3c755180ce-goog

