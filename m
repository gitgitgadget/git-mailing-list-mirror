Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56BE1F5A2
	for <e@80x24.org>; Sat, 16 Nov 2019 01:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKPBLd (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 20:11:33 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46369 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKPBLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 20:11:32 -0500
Received: by mail-pl1-f175.google.com with SMTP id l4so5825963plt.13
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 17:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=tzipksPCYT8RVBmiUxYGvHUJl0HV5cCnI4qF2SodI2s=;
        b=jNU5npdfo0PK4SMD0RClLz+jJJG1zuxZnYUe1lys6mA0OxKOjXxpIxIvTe+y2rvdpo
         pf5msSyP2UElTp0r3M/sPzo/rTMD/VM7U/9VtOvAKa+3csQvJjFpM59s2hoaMwyosQyd
         BUkBtoify0QwufAxJdjca4GAvTjgxtO3FZg5SkXAS3p+93+s+mpRNQZPChq8Wku1yW8k
         i8oYRnr/7n7URb09rm+oh4ff5kyvHn2oMoofyEfoUHnpyCpcj94S4pNu5LbJRzXv7r5w
         1Ibq17tZgj1H3eZ0YbjyJh9hzQf/byIkvqac99Qv2/iAEXEZar2Fma02ypRtDzi7xb8j
         +WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=tzipksPCYT8RVBmiUxYGvHUJl0HV5cCnI4qF2SodI2s=;
        b=HBwZLEfnd+SCPJN8ssJIyKk2Gx3XFjfiLxn57faVcx6PP8XMSPDllMpwNdbOI4a11Z
         ZIA+K2Htu9cSnOj8UI59GrY3bFaPRi9fwa8mvu/SOCdZl9U4AXlFnq54ULJw+GJA0Jib
         jiPXdCr0VQVwTPtfbZNIPe9eBEJoQjMF73D/6faK5hEeA6K7joENs7Jh8SQSA6sVulee
         XWC5rL2dF2LexVBiE83E96uaJk4oYO6CuvlV+FjBIIgkZ9kEueETe8PzyiChuQRtjsXf
         lEPK2blnUlyTUQOwc/J4/CQgqfF5vLsXpotvz/vLZUyP2fWv2dmJezaZKvS2ASN8Eyy3
         IEBg==
X-Gm-Message-State: APjAAAXdigRJ2ZOqSJ5/SKzmCdjuvRQk2SR39u3ARod6jdc9LgMoJ0p2
        xgpjdz7sgh7bbLVjDaTC+7x91wd0vhk=
X-Google-Smtp-Source: APXvYqyRJP8g0tYuczprYojyMJluCW0eLkwRLsiOwDz8rotW5hAYgaYkcdWUm+o/12i7qzNK9NwEhg==
X-Received: by 2002:a17:902:9046:: with SMTP id w6mr18747599plz.323.1573866690750;
        Fri, 15 Nov 2019 17:11:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a25sm11522814pff.50.2019.11.15.17.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:11:30 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:11:25 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [RFC] Hook management via 'git hooks' command
Message-ID: <20191116011125.GG22855@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.

The topic of multihook support has come up before; here are a handful of
conversations I could find on it:

 brian m. carlson's proposal for multiple hooks via .git/hooks/pre-commit.d/:
   https://public-inbox.org/git/20190424004948.728326-1-sandals@crustytoothpaste.net/

 Jonathan Nieder's discussion of hooks as an attack vector:
   https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/

 Ævar Arnfjörð Bjarmason's RFC for multihooks in a similar manner to brian's:
   https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com/

As I consider these conversations, I think about what goals we are aiming
for:

 1. Let a user run more than one hook on a single event.
 2. Let a user determine the order of those hooks.
 3. Let a user version-control their hooks without kludging. (This is actually
    largely solved by core.hookName, thanks to Ævar.)
 4. Make it hard for a user to run a hook they did not expect to run.
 5. Don't break users who currently have hooks in $REPO/.git/hooks, but provide
    a path for them to stop using hooks from that directory.

It seems that brian's thread stalled out in v2, but as I understand it, the
method was:

 - For each codepath which executes a hook:
   - Check whether .git/hooks/${hookname} is valid (exists, executable)
   - If not, check whether .git/hooks/${hookname}.d exists, and run each script
     within, in alphabetical order.

This approach seems similar to one that Ævar suggested in their RFC linked
above.

Benefits of that approach include:
 - A familiar Unixlike interface
 - Previously configured hooks will Just Work

Drawbacks of that approach include:
 - Still an attack vector, unless core.hooksDirectory is set
 - Still need to configure a hook for each repo, unless core.hooksDirectory is
   set
 - Hooks are still not version controlled, unless core.hooksDirectory is set

This meets goals 1, 2, and 5. Using core.hookPath makes this approach meet 3 as
well.

An alternate suggestion from Jonathan Nieder seems to look something like:

 - Learn a core.${hookname} config.
 - Teach all hook executing codepaths to check core.${hookname}
 - Either add multiple core.${hookname} entries and order ...TBD? or put lots of
   hooks on a single config entry and run in order on that line.

Benefits of the config approach include:
 - Easy to configure global, repo-wide, worktree-wide hooks
 - Long-term, the decision of which hooks to run is left entirely to the user
 - The hooks themselves can be version controlled, even distributed with the
   repo (a user could specify ${repopath}/hooks/pre-push-lint if they wanted,
   and we chose to allow it)

Drawbacks of the config approach include:
 - Different enough from the current approach to be unusual. Coming away from
   the transition period will require some thought.
 - The ordering of hooks may be confusing.
 - It may be difficult to choose _not_ to run a global hook from a local
   project.

This meets goals 3, 4, and 5; it could meet 1 and 2 but needs to be fleshed out
more.

Meanwhile, I have some other concerns when I read through the source:

 - I don't think I saw a codified list of all the possible hooks. Meaning,
   find_hook() is called with a freeform string, not from some enum, and it's
   hard to programmatically list all places where a hook could be used. This
   came up when I was looking at bugreport; even the template
   ${hookname}.sample files prepopulated in .git/hooks aren't a comprehensive
   list of all hooks mentioned in `git help hooks`. This feels like a lack of
   assurance that all hooks are well-documented.

Please do let me know if I missed something in my attempt to frame the "story so
far".

Here's my suggestion.

 - Let configs handle the hook list and ordering, via 'hook.{hookname}' which
   can be specified more than once.
   - global config: hook.update = /path/to/firsthook
     user config: hook.update = /path/to/secondhook
     worktree config: hook.update = -/path/to/firsthook #eliminate the firsthook
      call
   - global config: hook.update = /path/to/firsthook
     repo config: hook.update = /path/to/secondhook
     repo config: hook.update = ^/path/to/firsthook #move firsthook execution
       after secondhook for this project
 - Let users decide whether they want to check core.hookDir in addition to their
   config, instead of their config, or not at all, via a config
   'hook.runHookDir' "hookdir-first", "hookdir-only", "config-only", etc.
 - Let users ask to be notified if running a hook from .git/hooks via a config
   'hook.warnHookDir'. (Mentioning .git/hooks rather than core.hookDir is
   intentional here.) Alternatively, ask for 'hook.warn' with values "hookdir",
   "all" depending on how trusting the user feels.
   - If we want to phase out .git/hooks, we can make this notification opt-out
     instead of opt-in, someday.
   - between runHookDir and warnHookDir, users are able to phase out
     .git/hooks scripts at their own pace.
 - Abstract most of this via a 'git hooks' command.
   - 'git hooks add <hookname> [--<scope>] <path>' to append another hook;
     let the scope setting match 'git config'.
   - 'git hooks show [<hookname>]' to indicate which hooks will be run, either
     on a specific event or for all events, and in which order, as well as each
     hook's config origin
   - 'git hooks edit <hookname>' to modify the hook order, or choose not to run
     a hook locally
   - By managing it through a command, we can reorder the contents of config
     files if it makes sense to do so.
 - Add a hook library.
   - Optionally specify all hook events via enum, so we aren't string-typing
     calls to find_hook() anymore.
   - Resolve configs into a list of hooks to run by concatenating them together
     in config precedence order.
     - Also allow configs formatted like "-<path>" to remove an
       earlier-configured invocation of that hook, or "^<path>" to move the
       earlier-configured invocation to this point in the execution order
   - Move the find_hook() implementation to here, to account for the multihook
     ordering

I think it reaches the goals I mentioned:

 1. User can specify more than one hook per event by adding more configs or
    running 'git hooks add <event>'.
 2. User can determine the order by reordering their configs in file, using
    "^/hookpath" notation, or using 'git hooks edit'.
 3. User can point to a hook script which is checked into the repo they want it
    to run on, another repo in their filesystem, or anywhere at all. Contrary to
    the behavior of core.hookDir, users can manage each hook in a different repo
    if they wish (maybe the git-secrets hooks all live in the git-secrets repo,
    and the Gerrit Change-Id hook lives in the gerrit repo, and each project's
    pre-commit formatting hooks live in their own projects' repos).
 4. Users who have "bought in" to the config-based hook management can ask to be
    warned if a hook is run from .git/hooks, and can turn off running hooks from
    .git/hooks entirely if they wish.
 5. By defaulting to hook.runHookDir=hookdir-first or hookdir-only, we can avoid
    breaking users who are using .git/hooks/ today. The former gives value-add -
    the user can start using config hooks seamlessly - while the latter gives
    old functionality only.

The other benefits I can think of:
 - Having a friendly porcelain command to manage hooks makes life easier for the
   Git and Unix uninitiated.
 - If 'git hooks edit' UI looks like 'git rebase --interactive' UI, then users
   may already feel at home using it.
 - If organizations are already distributing global configs, they can also
   distribute hooks such as git-secrets or other internal hooks if they wish.
 - Users who want to use a hook that comes with a repo may still be subject to
   attack if the hook shipped by the repo changes under their feet (although
   they have explicitly asked Git to run that hook, so the threat doesn't feel
   different from running a shell script from a repo manually).

The drawbacks I can think of:
 - It is a much more complicated approach than adding .git/hooks/${hookname}.d.
 - The config syntax can clutter the output if users want to examine their
   config with 'git config --list'.
 - It is still possible for someone to attack via a zip file if they manipulate
   .git/config to use a hook they specified in the repo.

The issue with .git/config is still a pretty big one, but my own thought is that
we should treat it as a separate piece. Yes, those kinds of attacks are still
possible as long as either .git/config or .git/hooks are present in the repo
directory. But coding around .git/config will lead to some cruft that won't make
sense once repo-local config files are made more secure (for example, one
solution might be to ignore local and worktree configs when evaluating the
hooks list, which would be inconvenient and no longer make sense if those config
scopes are secured).

I look forward to the discussion. Thanks for your thoughts.
 - Emily
