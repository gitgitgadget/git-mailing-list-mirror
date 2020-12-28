Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE0C4332D
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC6522475
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgL1Wzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbgL1Wk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 17:40:59 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC9DC061796
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 14:40:19 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id j5so10079573qvu.22
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 14:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=nfrg2zG1zF4wLlLGq+Xouw/vEtdcn+A9nGN2VNincK8=;
        b=WzWfPatX9wxqiG7ziZ8sTT8fIwAislt3GWZLl4ldxT9oNvt1l4m8WLe9kMYrTPu4jl
         9/5qHFDMUNIYcdjd84R+P96FYh0gsCVCrY+Ojes+iZvNF2zX0Ht7sopSsj7iAoIEYv3E
         eVTvvvbd/pXHCkiWGolnMIbcrpSEhYxZJJivuLK+kVivm2PJNR6URrPeJJdk3dXBAiQD
         aKjRr0EY3mdAXAHjLGMRMaXTRMb2H29eRy9itU66hkZiDN7XkZ0iBH9S6JqD3G6wdYfp
         Dsab/Bwph1MyiFI2d5aLoxbe1/J3YSaOmfnUdlSw8dVCpiFsQ6n+mGGaDLRtEzN62neJ
         tfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=nfrg2zG1zF4wLlLGq+Xouw/vEtdcn+A9nGN2VNincK8=;
        b=gQci5XpT7IiptTKkzjGRY0uAfhQHx/xJG/KECLhDfk5kFALnvZT6/n9dnUJioCzrKo
         2hyI6wzcJqQLTHdQRe3qNweDfj46vjDNOSq0cYznypidzxuE5pY8YFYNuiffOeYdzD5o
         CLofT7P7QWShkHKz2hy3CtQMJU5Ke2ITMmcUJZSFtLOUlbrsyb9C9sTsHHZc8rlj9Dea
         B1j3N3x+KPiymQ4ItOM7rlC5VCUAKJiQh5qeT79GH7BMhDNmYTZDrbyhR94QrfoUiwkd
         9H7okqoh5rZYNOz0sdMdkS51s6GqdM5KZhIZTV3nVYgv+IN5nFeDxV4rHqXU/yEiIk3Z
         VJpQ==
X-Gm-Message-State: AOAM531G2Lsz82gvB7PbdBDoGdHtCwT9RRAcFScu+ilVSunfcRW1AgO7
        GEl+G2e2O63QOoCm5fg8GW+nKRv/0vr6ubNCSvfhoBhYxhiuzVTj58Gbm1rRE0LW9PsZ12e5Q1+
        ShpJE9csUfI2uxLRDQPqWXwgBkl1xMYluFs9ojWB8PIShGcF3RuKBlayQx8Uqz+zA2bgIPWDZqQ
        ==
X-Google-Smtp-Source: ABdhPJwLqq7chRWRx+lzKf3o4mKNe+OZKHABuP23b/rWxcAuMd1tHDHyf/Si3xbuAxfiGkUEP4fYuLfMA3g+nTJzgXA=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:5bce:: with SMTP id
 t14mr49284889qvt.6.1609195218531; Mon, 28 Dec 2020 14:40:18 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:40:15 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201228224015.286845-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 18/17] doc: make git-hook.txt point of truth
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By showing the list of all hooks in 'git help hook' for users to refer
to, 'git help hook' becomes a one-stop shop for hook authorship. Since
some may still have muscle memory for 'git help githooks', though,
reference the 'git hook' commands and otherwise don't remove content.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Sorry for the wonky subject. It seemed unnecessary to send the entirety
of the topic again when there were no changes. (I was able to push this
patch to my fork without -f, so indeed the rest is unchanged.)

I'd really prefer if 'git help githooks' opens the 'git-hook.txt' manpage,
but I couldn't figure out how to do that. This seemed like the next best thing
to me - users can still find information at the old manpage, but get a little
nudge towards the new manpage in case they didn't notice it.

Extremely open to other notes about the direction of these docs; I'm not
confident in anything except that it'd be annoying to have 'git help
githooks' remain unchanged.

 - Emily

 Documentation/git-hook.txt |   5 +
 Documentation/githooks.txt | 701 +------------------------------------
 2 files changed, 13 insertions(+), 693 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 01cee4ad81..cb8e383ec9 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -112,6 +112,11 @@ CONFIGURATION
 -------------
 include::config/hook.txt[]
 
+HOOKS
+-----
+
+include::native-hooks.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index c450f7a27e..4d06369924 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -8,15 +8,20 @@ githooks - Hooks used by Git
 SYNOPSIS
 --------
 $GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
+[verse]
+'git hook' list <hook-name>
+'git hook' run <hook-name>
 
 
 DESCRIPTION
 -----------
 
-Hooks are programs you can place in a hooks directory to trigger
-actions at certain points in git's execution. Hooks that don't have
+Hooks are programs you can place in a hooks directory or specify in the config
+to trigger actions at certain points in Git's execution. Hooks that don't have
 the executable bit set are ignored.
 
+For information about specifying hooks in the config, check linkgit:git-hook[1].
+
 By default the hooks directory is `$GIT_DIR/hooks`, but that can be
 changed via the `core.hooksPath` configuration variable (see
 linkgit:git-config[1]).
@@ -42,697 +47,7 @@ The currently supported hooks are described below.
 HOOKS
 -----
 
-applypatch-msg
-~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-am[1].  It takes a single
-parameter, the name of the file that holds the proposed commit
-log message.  Exiting with a non-zero status causes `git am` to abort
-before applying the patch.
-
-The hook is allowed to edit the message file in place, and can
-be used to normalize the message into some project standard
-format. It can also be used to refuse the commit after inspecting
-the message file.
-
-The default 'applypatch-msg' hook, when enabled, runs the
-'commit-msg' hook, if the latter is enabled.
-
-Hooks run during 'applypatch-msg' will not be parallelized.
-
-pre-applypatch
-~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-am[1].  It takes no parameter, and is
-invoked after the patch is applied, but before a commit is made.
-
-If it exits with non-zero status, then the working tree will not be
-committed after applying the patch.
-
-It can be used to inspect the current working tree and refuse to
-make a commit if it does not pass certain test.
-
-The default 'pre-applypatch' hook, when enabled, runs the
-'pre-commit' hook, if the latter is enabled.
-
-Hooks run during 'pre-applypatch' will be run in parallel by default.
-
-post-applypatch
-~~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-am[1].  It takes no parameter,
-and is invoked after the patch is applied and a commit is made.
-
-This hook is meant primarily for notification, and cannot affect
-the outcome of `git am`.
-
-Hooks run during 'post-applypatch' will be run in parallel by default.
-
-pre-commit
-~~~~~~~~~~
-
-This hook is invoked by linkgit:git-commit[1], and can be bypassed
-with the `--no-verify` option.  It takes no parameters, and is
-invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with a non-zero status from this script
-causes the `git commit` command to abort before creating a commit.
-
-The default 'pre-commit' hook, when enabled, catches introduction
-of lines with trailing whitespaces and aborts the commit when
-such a line is found.
-
-All the `git commit` hooks are invoked with the environment
-variable `GIT_EDITOR=:` if the command will not bring up an editor
-to modify the commit message.
-
-The default 'pre-commit' hook, when enabled--and with the
-`hooks.allownonascii` config option unset or set to false--prevents
-the use of non-ASCII filenames.
-
-Hooks executed during 'pre-commit' will not be parallelized.
-
-pre-merge-commit
-~~~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-merge[1], and can be bypassed
-with the `--no-verify` option.  It takes no parameters, and is
-invoked after the merge has been carried out successfully and before
-obtaining the proposed commit log message to
-make a commit.  Exiting with a non-zero status from this script
-causes the `git merge` command to abort before creating a commit.
-
-The default 'pre-merge-commit' hook, when enabled, runs the
-'pre-commit' hook, if the latter is enabled.
-
-This hook is invoked with the environment variable
-`GIT_EDITOR=:` if the command will not bring up an editor
-to modify the commit message.
-
-If the merge cannot be carried out automatically, the conflicts
-need to be resolved and the result committed separately (see
-linkgit:git-merge[1]). At that point, this hook will not be executed,
-but the 'pre-commit' hook will, if it is enabled.
-
-Hooks executed during 'pre-merge-commit' will not be parallelized.
-
-prepare-commit-msg
-~~~~~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-commit[1] right after preparing the
-default log message, and before the editor is started.
-
-It takes one to three parameters.  The first is the name of the file
-that contains the commit log message.  The second is the source of the commit
-message, and can be: `message` (if a `-m` or `-F` option was
-given); `template` (if a `-t` option was given or the
-configuration option `commit.template` is set); `merge` (if the
-commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
-(if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA-1 (if a `-c`, `-C` or `--amend` option was given).
-
-If the exit status is non-zero, `git commit` will abort.
-
-The purpose of the hook is to edit the message file in place, and
-it is not suppressed by the `--no-verify` option.  A non-zero exit
-means a failure of the hook and aborts the commit.  It should not
-be used as replacement for pre-commit hook.
-
-The sample `prepare-commit-msg` hook that comes with Git removes the
-help message found in the commented portion of the commit template.
-
-Hooks executed during 'prepare-commit-msg' will not be parallelized.
-
-commit-msg
-~~~~~~~~~~
-
-This hook is invoked by linkgit:git-commit[1] and linkgit:git-merge[1], and can be
-bypassed with the `--no-verify` option.  It takes a single parameter,
-the name of the file that holds the proposed commit log message.
-Exiting with a non-zero status causes the command to abort.
-
-The hook is allowed to edit the message file in place, and can be used
-to normalize the message into some project standard format. It
-can also be used to refuse the commit after inspecting the message
-file.
-
-The default 'commit-msg' hook, when enabled, detects duplicate
-`Signed-off-by` trailers, and aborts the commit if one is found.
-
-Hooks executed during 'commit-msg' will not be parallelized.
-
-post-commit
-~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-commit[1]. It takes no parameters, and is
-invoked after a commit is made.
-
-This hook is meant primarily for notification, and cannot affect
-the outcome of `git commit`.
-
-Hooks executed during 'post-commit' will run in parallel by default.
-
-pre-rebase
-~~~~~~~~~~
-
-This hook is called by linkgit:git-rebase[1] and can be used to prevent a
-branch from getting rebased.  The hook may be called with one or
-two parameters.  The first parameter is the upstream from which
-the series was forked.  The second parameter is the branch being
-rebased, and is not set when rebasing the current branch.
-
-Hooks executed during 'pre-rebase' will run in parallel by default.
-
-post-checkout
-~~~~~~~~~~~~~
-
-This hook is invoked when a linkgit:git-checkout[1] or
-linkgit:git-switch[1] is run after having updated the
-worktree.  The hook is given three parameters: the ref of the previous HEAD,
-the ref of the new HEAD (which may or may not have changed), and a flag
-indicating whether the checkout was a branch checkout (changing branches,
-flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of `git switch` or `git checkout`,
-other than that the hook's exit status becomes the exit status of
-these two commands.
-
-It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
-used. The first parameter given to the hook is the null-ref, the second the
-ref of the new HEAD and the flag is always 1. Likewise for `git worktree add`
-unless `--no-checkout` is used.
-
-This hook can be used to perform repository validity checks, auto-display
-differences from the previous HEAD if different, or set working dir metadata
-properties.
-
-Hooks executed during 'post-checkout' will not be parallelized.
-
-post-merge
-~~~~~~~~~~
-
-This hook is invoked by linkgit:git-merge[1], which happens when a `git pull`
-is done on a local repository.  The hook takes a single parameter, a status
-flag specifying whether or not the merge being done was a squash merge.
-This hook cannot affect the outcome of `git merge` and is not executed,
-if the merge failed due to conflicts.
-
-This hook can be used in conjunction with a corresponding pre-commit hook to
-save and restore any form of metadata associated with the working tree
-(e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
-for an example of how to do this.
-
-Hooks executed during 'post-merge' will run in parallel by default.
-
-pre-push
-~~~~~~~~
-
-This hook is called by linkgit:git-push[1] and can be used to prevent
-a push from taking place.  The hook is called with two parameters
-which provide the name and location of the destination remote, if a
-named remote is not being used both values will be the same.
-
-Information about what is to be pushed is provided on the hook's standard
-input with lines of the form:
-
-  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
-
-For instance, if the command +git push origin master:foreign+ were run the
-hook would receive a line like the following:
-
-  refs/heads/master 67890 refs/heads/foreign 12345
-
-although the full, 40-character SHA-1s would be supplied.  If the foreign ref
-does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
-deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
-SHA-1>` will be 40 `0`.  If the local commit was specified by something other
-than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
-supplied as it was originally given.
-
-If this hook exits with a non-zero status, `git push` will abort without
-pushing anything.  Information about why the push is rejected may be sent
-to the user by writing to standard error.
-
-Hooks executed during 'pre-push' will run in parallel by default.
-
-[[pre-receive]]
-pre-receive
-~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
-`git push` and updates reference(s) in its repository.
-Just before starting to update refs on the remote repository, the
-pre-receive hook is invoked.  Its exit status determines the success
-or failure of the update.
-
-This hook executes once for the receive operation. It takes no
-arguments, but for each ref to be updated it receives on standard
-input a line of the format:
-
-  <old-value> SP <new-value> SP <ref-name> LF
-
-where `<old-value>` is the old object name stored in the ref,
-`<new-value>` is the new object name to be stored in the ref and
-`<ref-name>` is the full name of the ref.
-When creating a new ref, `<old-value>` is 40 `0`.
-
-If the hook exits with non-zero status, none of the refs will be
-updated. If the hook exits with zero, updating of individual refs can
-still be prevented by the <<update,'update'>> hook.
-
-Both standard output and standard error output are forwarded to
-`git send-pack` on the other end, so you can simply `echo` messages
-for the user.
-
-The number of push options given on the command line of
-`git push --push-option=...` can be read from the environment
-variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
-found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
-If it is negotiated to not use the push options phase, the
-environment variables will not be set. If the client selects
-to use push options, but doesn't transmit any, the count variable
-will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
-
-See the section on "Quarantine Environment" in
-linkgit:git-receive-pack[1] for some caveats.
-
-Hooks executed during 'pre-receive' will not be parallelized.
-
-[[update]]
-update
-~~~~~~
-
-This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
-`git push` and updates reference(s) in its repository.
-Just before updating the ref on the remote repository, the update hook
-is invoked.  Its exit status determines the success or failure of
-the ref update.
-
-The hook executes once for each ref to be updated, and takes
-three parameters:
-
- - the name of the ref being updated,
- - the old object name stored in the ref,
- - and the new object name to be stored in the ref.
-
-A zero exit from the update hook allows the ref to be updated.
-Exiting with a non-zero status prevents `git receive-pack`
-from updating that ref.
-
-This hook can be used to prevent 'forced' update on certain refs by
-making sure that the object name is a commit object that is a
-descendant of the commit object named by the old object name.
-That is, to enforce a "fast-forward only" policy.
-
-It could also be used to log the old..new status.  However, it
-does not know the entire set of branches, so it would end up
-firing one e-mail per ref when used naively, though.  The
-<<post-receive,'post-receive'>> hook is more suited to that.
-
-In an environment that restricts the users' access only to git
-commands over the wire, this hook can be used to implement access
-control without relying on filesystem ownership and group
-membership. See linkgit:git-shell[1] for how you might use the login
-shell to restrict the user's access to only git commands.
-
-Both standard output and standard error output are forwarded to
-`git send-pack` on the other end, so you can simply `echo` messages
-for the user.
-
-The default 'update' hook, when enabled--and with
-`hooks.allowunannotated` config option unset or set to false--prevents
-unannotated tags to be pushed.
-
-Hooks executed during 'update' are run in parallel by default.
-
-[[proc-receive]]
-proc-receive
-~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-receive-pack[1].  If the server has
-set the multi-valued config variable `receive.procReceiveRefs`, and the
-commands sent to 'receive-pack' have matching reference names, these
-commands will be executed by this hook, instead of by the internal
-`execute_commands()` function.  This hook is responsible for updating
-the relevant references and reporting the results back to 'receive-pack'.
-
-This hook executes once for the receive operation.  It takes no
-arguments, but uses a pkt-line format protocol to communicate with
-'receive-pack' to read commands, push-options and send results.  In the
-following example for the protocol, the letter 'S' stands for
-'receive-pack' and the letter 'H' stands for this hook.
-
-    # Version and features negotiation.
-    S: PKT-LINE(version=1\0push-options atomic...)
-    S: flush-pkt
-    H: PKT-LINE(version=1\0push-options...)
-    H: flush-pkt
-
-    # Send commands from server to the hook.
-    S: PKT-LINE(<old-oid> <new-oid> <ref>)
-    S: ... ...
-    S: flush-pkt
-    # Send push-options only if the 'push-options' feature is enabled.
-    S: PKT-LINE(push-option)
-    S: ... ...
-    S: flush-pkt
-
-    # Receive result from the hook.
-    # OK, run this command successfully.
-    H: PKT-LINE(ok <ref>)
-    # NO, I reject it.
-    H: PKT-LINE(ng <ref> <reason>)
-    # Fall through, let 'receive-pack' to execute it.
-    H: PKT-LINE(ok <ref>)
-    H: PKT-LINE(option fall-through)
-    # OK, but has an alternate reference.  The alternate reference name
-    # and other status can be given in option directives.
-    H: PKT-LINE(ok <ref>)
-    H: PKT-LINE(option refname <refname>)
-    H: PKT-LINE(option old-oid <old-oid>)
-    H: PKT-LINE(option new-oid <new-oid>)
-    H: PKT-LINE(option forced-update)
-    H: ... ...
-    H: flush-pkt
-
-Each command for the 'proc-receive' hook may point to a pseudo-reference
-and always has a zero-old as its old-oid, while the 'proc-receive' hook
-may update an alternate reference and the alternate reference may exist
-already with a non-zero old-oid.  For this case, this hook will use
-"option" directives to report extended attributes for the reference given
-by the leading "ok" directive.
-
-The report of the commands of this hook should have the same order as
-the input.  The exit status of the 'proc-receive' hook only determines
-the success or failure of the group of commands sent to it, unless
-atomic push is in use.
-
-It is forbidden to specify more than one hook for 'proc-receive'. If a
-globally-configured 'proc-receive' must be overridden, use
-'hookcmd.<global-hook>.skip = true' to ignore it.
-
-[[post-receive]]
-post-receive
-~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
-`git push` and updates reference(s) in its repository.
-It executes on the remote repository once after all the refs have
-been updated.
-
-This hook executes once for the receive operation.  It takes no
-arguments, but gets the same information as the
-<<pre-receive,'pre-receive'>>
-hook does on its standard input.
-
-This hook does not affect the outcome of `git receive-pack`, as it
-is called after the real work is done.
-
-This supersedes the <<post-update,'post-update'>> hook in that it gets
-both old and new values of all the refs in addition to their
-names.
-
-Both standard output and standard error output are forwarded to
-`git send-pack` on the other end, so you can simply `echo` messages
-for the user.
-
-The default 'post-receive' hook is empty, but there is
-a sample script `post-receive-email` provided in the `contrib/hooks`
-directory in Git distribution, which implements sending commit
-emails.
-
-The number of push options given on the command line of
-`git push --push-option=...` can be read from the environment
-variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
-found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
-If it is negotiated to not use the push options phase, the
-environment variables will not be set. If the client selects
-to use push options, but doesn't transmit any, the count variable
-will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
-
-Hooks executed during 'post-receive' are run in parallel by default.
-
-[[post-update]]
-post-update
-~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
-`git push` and updates reference(s) in its repository.
-It executes on the remote repository once after all the refs have
-been updated.
-
-It takes a variable number of parameters, each of which is the
-name of ref that was actually updated.
-
-This hook is meant primarily for notification, and cannot affect
-the outcome of `git receive-pack`.
-
-The 'post-update' hook can tell what are the heads that were pushed,
-but it does not know what their original and updated values are,
-so it is a poor place to do log old..new. The
-<<post-receive,'post-receive'>> hook does get both original and
-updated values of the refs. You might consider it instead if you need
-them.
-
-When enabled, the default 'post-update' hook runs
-`git update-server-info` to keep the information used by dumb
-transports (e.g., HTTP) up to date.  If you are publishing
-a Git repository that is accessible via HTTP, you should
-probably enable this hook.
-
-Both standard output and standard error output are forwarded to
-`git send-pack` on the other end, so you can simply `echo` messages
-for the user.
-
-Hooks run during 'post-update' will be run in parallel by default.
-
-reference-transaction
-~~~~~~~~~~~~~~~~~~~~~
-
-This hook is invoked by any Git command that performs reference
-updates. It executes whenever a reference transaction is prepared,
-committed or aborted and may thus get called multiple times.
-
-The hook takes exactly one argument, which is the current state the
-given reference transaction is in:
-
-    - "prepared": All reference updates have been queued to the
-      transaction and references were locked on disk.
-
-    - "committed": The reference transaction was committed and all
-      references now have their respective new value.
-
-    - "aborted": The reference transaction was aborted, no changes
-      were performed and the locks have been released.
-
-For each reference update that was added to the transaction, the hook
-receives on standard input a line of the format:
-
-  <old-value> SP <new-value> SP <ref-name> LF
-
-The exit status of the hook is ignored for any state except for the
-"prepared" state. In the "prepared" state, a non-zero exit status will
-cause the transaction to be aborted. The hook will not be called with
-"aborted" state in that case.
-
-Hooks run during 'reference-transaction' will be run in parallel by default.
-
-push-to-checkout
-~~~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
-`git push` and updates reference(s) in its repository, and when
-the push tries to update the branch that is currently checked out
-and the `receive.denyCurrentBranch` configuration variable is set to
-`updateInstead`.  Such a push by default is refused if the working
-tree and the index of the remote repository has any difference from
-the currently checked out commit; when both the working tree and the
-index match the current commit, they are updated to match the newly
-pushed tip of the branch.  This hook is to be used to override the
-default behaviour.
-
-The hook receives the commit with which the tip of the current
-branch is going to be updated.  It can exit with a non-zero status
-to refuse the push (when it does so, it must not modify the index or
-the working tree).  Or it can make any necessary changes to the
-working tree and to the index to bring them to the desired state
-when the tip of the current branch is updated to the new commit, and
-exit with a zero status.
-
-For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
-in order to emulate `git fetch` that is run in the reverse direction
-with `git push`, as the two-tree form of `git read-tree -u -m` is
-essentially the same as `git switch` or `git checkout`
-that switches branches while
-keeping the local changes in the working tree that do not interfere
-with the difference between the branches.
-
-Hooks executed during 'push-to-checkout' will not be parallelized.
-
-pre-auto-gc
-~~~~~~~~~~~
-
-This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
-takes no parameter, and exiting with non-zero status from this script
-causes the `git gc --auto` to abort.
-
-Hooks run during 'pre-auto-gc' will be run in parallel by default.
-
-post-rewrite
-~~~~~~~~~~~~
-
-This hook is invoked by commands that rewrite commits
-(linkgit:git-commit[1] when called with `--amend` and
-linkgit:git-rebase[1]; however, full-history (re)writing tools like
-linkgit:git-fast-import[1] or
-https://github.com/newren/git-filter-repo[git-filter-repo] typically
-do not call it!).  Its first argument denotes the command it was
-invoked by: currently one of `amend` or `rebase`.  Further
-command-dependent arguments may be passed in the future.
-
-The hook receives a list of the rewritten commits on stdin, in the
-format
-
-  <old-sha1> SP <new-sha1> [ SP <extra-info> ] LF
-
-The 'extra-info' is again command-dependent.  If it is empty, the
-preceding SP is also omitted.  Currently, no commands pass any
-'extra-info'.
-
-The hook always runs after the automatic note copying (see
-"notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
-thus has access to these notes.
-
-Hooks run during 'post-rewrite' will be run in parallel by default.
-
-The following command-specific comments apply:
-
-rebase::
-	For the 'squash' and 'fixup' operation, all commits that were
-	squashed are listed as being rewritten to the squashed commit.
-	This means that there will be several lines sharing the same
-	'new-sha1'.
-+
-The commits are guaranteed to be listed in the order that they were
-processed by rebase.
-
-sendemail-validate
-~~~~~~~~~~~~~~~~~~
-
-This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
-the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes `git send-email` to abort before sending any
-e-mails.
-
-fsmonitor-watchman
-~~~~~~~~~~~~~~~~~~
-
-This hook is invoked when the configuration option `core.fsmonitor` is
-set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
-depending on the version of the hook to use.
-
-Version 1 takes two arguments, a version (1) and the time in elapsed
-nanoseconds since midnight, January 1, 1970.
-
-Version 2 takes two arguments, a version (2) and a token that is used
-for identifying changes since the token. For watchman this would be
-a clock id. This version must output to stdout the new token followed
-by a NUL before the list of files.
-
-The hook should output to stdout the list of all files in the working
-directory that may have changed since the requested time.  The logic
-should be inclusive so that it does not miss any potential changes.
-The paths should be relative to the root of the working directory
-and be separated by a single NUL.
-
-It is OK to include files which have not actually changed.  All changes
-including newly-created and deleted files should be included. When
-files are renamed, both the old and the new name should be included.
-
-Git will limit what files it checks for changes as well as which
-directories are checked for untracked files based on the path names
-given.
-
-An optimized way to tell git "all files have changed" is to return
-the filename `/`.
-
-The exit status determines whether git will use the data from the
-hook to limit its search.  On error, it will fall back to verifying
-all files and folders.
-
-p4-changelist
-~~~~~~~~~~~~~
-
-This hook is invoked by `git-p4 submit`.
-
-The `p4-changelist` hook is executed after the changelist
-message has been edited by the user. It can be bypassed with the
-`--no-verify` option. It takes a single parameter, the name
-of the file that holds the proposed changelist text. Exiting
-with a non-zero status causes the command to abort.
-
-The hook is allowed to edit the changelist file and can be used
-to normalize the text into some project standard format. It can
-also be used to refuse the Submit after inspect the message file.
-
-Run `git-p4 submit --help` for details.
-
-p4-prepare-changelist
-~~~~~~~~~~~~~~~~~~~~~
-
-This hook is invoked by `git-p4 submit`.
-
-The `p4-prepare-changelist` hook is executed right after preparing
-the default changelist message and before the editor is started.
-It takes one parameter, the name of the file that contains the
-changelist text. Exiting with a non-zero status from the script
-will abort the process.
-
-The purpose of the hook is to edit the message file in place,
-and it is not supressed by the `--no-verify` option. This hook
-is called even if `--prepare-p4-only` is set.
-
-Run `git-p4 submit --help` for details.
-
-p4-post-changelist
-~~~~~~~~~~~~~~~~~~
-
-This hook is invoked by `git-p4 submit`.
-
-The `p4-post-changelist` hook is invoked after the submit has
-successfully occurred in P4. It takes no parameters and is meant
-primarily for notification and cannot affect the outcome of the
-git p4 submit action.
-
-Run `git-p4 submit --help` for details.
-
-p4-pre-submit
-~~~~~~~~~~~~~
-
-This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
-from standard input. Exiting with non-zero status from this script prevent
-`git-p4 submit` from launching. It can be bypassed with the `--no-verify`
-command line option. Run `git-p4 submit --help` for details.
-
-
-
-post-index-change
-~~~~~~~~~~~~~~~~~
-
-This hook is invoked when the index is written in read-cache.c
-do_write_locked_index.
-
-The first parameter passed to the hook is the indicator for the
-working directory being updated.  "1" meaning working directory
-was updated or "0" when the working directory was not updated.
-
-The second parameter passed to the hook is the indicator for whether
-or not the index was updated and the skip-worktree bit could have
-changed.  "1" meaning skip-worktree bits could have been updated
-and "0" meaning they were not.
-
-Only one parameter should be set to "1" when the hook runs.  The hook
-running passing "1", "1" should not be possible.
-
-Hooks run during 'post-index-change' will be run in parallel by default.
+include::native-hooks.txt[]
 
 GIT
 ---
-- 
2.29.2.490.gc7ae633391

