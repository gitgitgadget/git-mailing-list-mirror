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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F1C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525F765004
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCKCMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCKCL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5CC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j4so23635881ybt.23
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TDcc7y21l5avJ17QXas+6l7D6Gq5qvI/tmLqrEEjjL0=;
        b=imSEIgmQ2opeG0KNO32RyNUQO99jJxE2GteTH5Gi4OpPw6UkHt0sDFy5sN3Fa8Kj6t
         AuJbE1cOETFxlyzFpHG4DXLIM0iu4iPAmWwRaboeAOqBTX/WMfcGQXu0dPSTWr4jp13X
         FTexm+TVb8qf+26f8nwFk2ksacgfqPDcPP0eHMASz/vwD6HPsMdxAdBTg9Vv7jmmE+tI
         XKnm/u2QgxS1ln19T16+kFF7TkpydTrgGhepjRks/CO4YsscsqOZdFkTqN05SJrA7TKN
         BahVo/hspq6bPxT8ZRpzsI/SfHHfWw7v1UAbKj1Mul1sMhQz0Gxwva8Miggd8G0yf+d/
         qeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TDcc7y21l5avJ17QXas+6l7D6Gq5qvI/tmLqrEEjjL0=;
        b=HKqgc2TTnrTpRUOWZeHgL5M+pKZzoXc8QKwyLiTLlpypfvOFVNgdgRpQPcRInG1PPp
         G206VTIbpbzyysWDxCLLKPLbaab06OnhsQ558Nl29T1yA9EfdM4S+pGTr8LqvdAZHuYp
         S2Y/0CuRsJO6ceY9H2nCuR4mcDma05v0bSygcvXqm7n/X4HgKwUCasB6gu0ikSwNdNdu
         UwTEsiwas+CWX3dC5VTpm85kNdnHivUT0dHSdZ/rqSTznmWOZ38ygE9nBXSFTxUeIh28
         ZN43G5bd7SZiZHG/BhSSo2HWTyRLNWqYhClqCswH/5g5D4fI60rKMwYatzCd3vsXzMtl
         8PDg==
X-Gm-Message-State: AOAM533aqptGxMa7agLIXo4N1aicKkvGQEwRt29ziDRJm8GmXvRIJzoS
        RhBwg1r7pUN/hUHTiF7lks+PtTLb5bNY/rxCIUmnZL6m83xEbxMZ9J1M6hRUIZXbsaEk6tbjeEo
        FquZusQ1P688sSJBB5GaRwjgbNevuLVIej6SBU1lL3KqE8eaYZWB6nSpaqklhFlXSqROWVrQmBw
        ==
X-Google-Smtp-Source: ABdhPJwE+SGIb8pJgtzoeZntVSUPELb33PHaHpLR1y3oQsOuy1xzW9kds1YJ+1sB8dcLAL8pNIHvLZ4Vxs3YVSdMX+U=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:3495:: with SMTP id
 b143mr7027938yba.431.1615428716952; Wed, 10 Mar 2021 18:11:56 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:37 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-38-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
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
 Documentation/git-hook.txt     |  11 +
 Documentation/githooks.txt     | 716 +--------------------------------
 Documentation/native-hooks.txt | 708 ++++++++++++++++++++++++++++++++
 3 files changed, 724 insertions(+), 711 deletions(-)
 create mode 100644 Documentation/native-hooks.txt

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 81b8e94994..4ad31ac360 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -17,6 +17,13 @@ DESCRIPTION
 You can list and run configured hooks with this command. Later, you will be able
 to add and modify hooks with this command.
 
+In general, when instructions suggest adding a script to
+`.git/hooks/<something>`, you can specify it in the config instead by running
+`git config --add hook.<something>.command <path-to-script>` - this way you can
+share the script between multiple repos. That is, `cp ~/my-script.sh
+~/project/.git/hooks/pre-commit` would become `git config --add
+hook.pre-commit.command ~/my-script.sh`.
+
 This command parses the default configuration files for sections `hook` and
 `hookcmd`. `hook` is used to describe the commands which will be run during a
 particular hook event; commands are run in the order Git encounters them during
@@ -145,6 +152,10 @@ CONFIGURATION
 -------------
 include::config/hook.txt[]
 
+HOOKS
+-----
+include::native-hooks.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b63054b947..9a25dfdc3f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -7,15 +7,16 @@ githooks - Hooks used by Git
 
 SYNOPSIS
 --------
+'git hook'
 $GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
 
 
 DESCRIPTION
 -----------
 
-Hooks are programs you can place in a hooks directory to trigger
-actions at certain points in git's execution. Hooks that don't have
-the executable bit set are ignored.
+Hooks are programs you can specify in your config (see linkgit:git-hook[1]) or
+place in a hooks directory to trigger actions at certain points in git's
+execution. Hooks that don't have the executable bit set are ignored.
 
 By default the hooks directory is `$GIT_DIR/hooks`, but that can be
 changed via the `core.hooksPath` configuration variable (see
@@ -41,714 +42,7 @@ The currently supported hooks are described below.
 
 HOOKS
 -----
-
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
-Hooks run during 'applypatch-msg' will not be parallelized, because hooks are
-expected to edit the file holding the commit log message.
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
-Hooks run during 'pre-applypatch' will be run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks run during 'post-applypatch' will be run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks executed during 'prepare-commit-msg' will not be parallelized, because
-hooks are expected to edit the file containing the commit log message.
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
-Hooks executed during 'commit-msg' will not be parallelized, because hooks are
-expected to edit the file containing the proposed commit log message.
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
-Hooks executed during 'post-commit' will run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks executed during 'pre-rebase' will run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks executed during 'post-merge' will run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks executed during 'pre-push' will run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks executed during 'update' are run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks executed during 'post-receive' are run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks run during 'post-update' will be run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks run during 'reference-transaction' will be run in parallel, unless
-hook.jobs is configured to 1.
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
-Hooks run during 'pre-auto-gc' will be run in parallel, unless hook.jobs is
-configured to 1.
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
-Hooks run during 'post-rewrite' will be run in parallel, unless hook.jobs is
-configured to 1.
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
-and it is not suppressed by the `--no-verify` option. This hook
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
-Hooks run during 'post-index-change' will be run in parallel, unless hook.jobs
-is configured to 1.
+include::native-hooks.txt[]
 
 GIT
 ---
diff --git a/Documentation/native-hooks.txt b/Documentation/native-hooks.txt
new file mode 100644
index 0000000000..6c4aad83e1
--- /dev/null
+++ b/Documentation/native-hooks.txt
@@ -0,0 +1,708 @@
+applypatch-msg
+~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-am[1].  It takes a single
+parameter, the name of the file that holds the proposed commit
+log message.  Exiting with a non-zero status causes `git am` to abort
+before applying the patch.
+
+The hook is allowed to edit the message file in place, and can
+be used to normalize the message into some project standard
+format. It can also be used to refuse the commit after inspecting
+the message file.
+
+The default 'applypatch-msg' hook, when enabled, runs the
+'commit-msg' hook, if the latter is enabled.
+
+Hooks run during 'applypatch-msg' will not be parallelized, because hooks are
+expected to edit the file holding the commit log message.
+
+pre-applypatch
+~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-am[1].  It takes no parameter, and is
+invoked after the patch is applied, but before a commit is made.
+
+If it exits with non-zero status, then the working tree will not be
+committed after applying the patch.
+
+It can be used to inspect the current working tree and refuse to
+make a commit if it does not pass certain test.
+
+The default 'pre-applypatch' hook, when enabled, runs the
+'pre-commit' hook, if the latter is enabled.
+
+Hooks run during 'pre-applypatch' will be run in parallel, unless hook.jobs is
+configured to 1.
+
+post-applypatch
+~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-am[1].  It takes no parameter,
+and is invoked after the patch is applied and a commit is made.
+
+This hook is meant primarily for notification, and cannot affect
+the outcome of `git am`.
+
+Hooks run during 'post-applypatch' will be run in parallel, unless hook.jobs is
+configured to 1.
+
+pre-commit
+~~~~~~~~~~
+
+This hook is invoked by linkgit:git-commit[1], and can be bypassed
+with the `--no-verify` option.  It takes no parameters, and is
+invoked before obtaining the proposed commit log message and
+making a commit.  Exiting with a non-zero status from this script
+causes the `git commit` command to abort before creating a commit.
+
+The default 'pre-commit' hook, when enabled, catches introduction
+of lines with trailing whitespaces and aborts the commit when
+such a line is found.
+
+All the `git commit` hooks are invoked with the environment
+variable `GIT_EDITOR=:` if the command will not bring up an editor
+to modify the commit message.
+
+The default 'pre-commit' hook, when enabled--and with the
+`hooks.allownonascii` config option unset or set to false--prevents
+the use of non-ASCII filenames.
+
+Hooks executed during 'pre-commit' will not be parallelized.
+
+pre-merge-commit
+~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-merge[1], and can be bypassed
+with the `--no-verify` option.  It takes no parameters, and is
+invoked after the merge has been carried out successfully and before
+obtaining the proposed commit log message to
+make a commit.  Exiting with a non-zero status from this script
+causes the `git merge` command to abort before creating a commit.
+
+The default 'pre-merge-commit' hook, when enabled, runs the
+'pre-commit' hook, if the latter is enabled.
+
+This hook is invoked with the environment variable
+`GIT_EDITOR=:` if the command will not bring up an editor
+to modify the commit message.
+
+If the merge cannot be carried out automatically, the conflicts
+need to be resolved and the result committed separately (see
+linkgit:git-merge[1]). At that point, this hook will not be executed,
+but the 'pre-commit' hook will, if it is enabled.
+
+Hooks executed during 'pre-merge-commit' will not be parallelized.
+
+prepare-commit-msg
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-commit[1] right after preparing the
+default log message, and before the editor is started.
+
+It takes one to three parameters.  The first is the name of the file
+that contains the commit log message.  The second is the source of the commit
+message, and can be: `message` (if a `-m` or `-F` option was
+given); `template` (if a `-t` option was given or the
+configuration option `commit.template` is set); `merge` (if the
+commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
+(if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
+a commit SHA-1 (if a `-c`, `-C` or `--amend` option was given).
+
+If the exit status is non-zero, `git commit` will abort.
+
+The purpose of the hook is to edit the message file in place, and
+it is not suppressed by the `--no-verify` option.  A non-zero exit
+means a failure of the hook and aborts the commit.  It should not
+be used as replacement for pre-commit hook.
+
+The sample `prepare-commit-msg` hook that comes with Git removes the
+help message found in the commented portion of the commit template.
+
+Hooks executed during 'prepare-commit-msg' will not be parallelized, because
+hooks are expected to edit the file containing the commit log message.
+
+commit-msg
+~~~~~~~~~~
+
+This hook is invoked by linkgit:git-commit[1] and linkgit:git-merge[1], and can be
+bypassed with the `--no-verify` option.  It takes a single parameter,
+the name of the file that holds the proposed commit log message.
+Exiting with a non-zero status causes the command to abort.
+
+The hook is allowed to edit the message file in place, and can be used
+to normalize the message into some project standard format. It
+can also be used to refuse the commit after inspecting the message
+file.
+
+The default 'commit-msg' hook, when enabled, detects duplicate
+`Signed-off-by` trailers, and aborts the commit if one is found.
+
+Hooks executed during 'commit-msg' will not be parallelized, because hooks are
+expected to edit the file containing the proposed commit log message.
+
+post-commit
+~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-commit[1]. It takes no parameters, and is
+invoked after a commit is made.
+
+This hook is meant primarily for notification, and cannot affect
+the outcome of `git commit`.
+
+Hooks executed during 'post-commit' will run in parallel, unless hook.jobs is
+configured to 1.
+
+pre-rebase
+~~~~~~~~~~
+
+This hook is called by linkgit:git-rebase[1] and can be used to prevent a
+branch from getting rebased.  The hook may be called with one or
+two parameters.  The first parameter is the upstream from which
+the series was forked.  The second parameter is the branch being
+rebased, and is not set when rebasing the current branch.
+
+Hooks executed during 'pre-rebase' will run in parallel, unless hook.jobs is
+configured to 1.
+
+post-checkout
+~~~~~~~~~~~~~
+
+This hook is invoked when a linkgit:git-checkout[1] or
+linkgit:git-switch[1] is run after having updated the
+worktree.  The hook is given three parameters: the ref of the previous HEAD,
+the ref of the new HEAD (which may or may not have changed), and a flag
+indicating whether the checkout was a branch checkout (changing branches,
+flag=1) or a file checkout (retrieving a file from the index, flag=0).
+This hook cannot affect the outcome of `git switch` or `git checkout`,
+other than that the hook's exit status becomes the exit status of
+these two commands.
+
+It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
+used. The first parameter given to the hook is the null-ref, the second the
+ref of the new HEAD and the flag is always 1. Likewise for `git worktree add`
+unless `--no-checkout` is used.
+
+This hook can be used to perform repository validity checks, auto-display
+differences from the previous HEAD if different, or set working dir metadata
+properties.
+
+Hooks executed during 'post-checkout' will not be parallelized.
+
+post-merge
+~~~~~~~~~~
+
+This hook is invoked by linkgit:git-merge[1], which happens when a `git pull`
+is done on a local repository.  The hook takes a single parameter, a status
+flag specifying whether or not the merge being done was a squash merge.
+This hook cannot affect the outcome of `git merge` and is not executed,
+if the merge failed due to conflicts.
+
+This hook can be used in conjunction with a corresponding pre-commit hook to
+save and restore any form of metadata associated with the working tree
+(e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
+for an example of how to do this.
+
+Hooks executed during 'post-merge' will run in parallel, unless hook.jobs is
+configured to 1.
+
+pre-push
+~~~~~~~~
+
+This hook is called by linkgit:git-push[1] and can be used to prevent
+a push from taking place.  The hook is called with two parameters
+which provide the name and location of the destination remote, if a
+named remote is not being used both values will be the same.
+
+Information about what is to be pushed is provided on the hook's standard
+input with lines of the form:
+
+  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
+
+For instance, if the command +git push origin master:foreign+ were run the
+hook would receive a line like the following:
+
+  refs/heads/master 67890 refs/heads/foreign 12345
+
+although the full, 40-character SHA-1s would be supplied.  If the foreign ref
+does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
+deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
+SHA-1>` will be 40 `0`.  If the local commit was specified by something other
+than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
+supplied as it was originally given.
+
+If this hook exits with a non-zero status, `git push` will abort without
+pushing anything.  Information about why the push is rejected may be sent
+to the user by writing to standard error.
+
+Hooks executed during 'pre-push' will run in parallel, unless hook.jobs is
+configured to 1.
+
+[[pre-receive]]
+pre-receive
+~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
+Just before starting to update refs on the remote repository, the
+pre-receive hook is invoked.  Its exit status determines the success
+or failure of the update.
+
+This hook executes once for the receive operation. It takes no
+arguments, but for each ref to be updated it receives on standard
+input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> LF
+
+where `<old-value>` is the old object name stored in the ref,
+`<new-value>` is the new object name to be stored in the ref and
+`<ref-name>` is the full name of the ref.
+When creating a new ref, `<old-value>` is 40 `0`.
+
+If the hook exits with non-zero status, none of the refs will be
+updated. If the hook exits with zero, updating of individual refs can
+still be prevented by the <<update,'update'>> hook.
+
+Both standard output and standard error output are forwarded to
+`git send-pack` on the other end, so you can simply `echo` messages
+for the user.
+
+The number of push options given on the command line of
+`git push --push-option=...` can be read from the environment
+variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
+found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
+If it is negotiated to not use the push options phase, the
+environment variables will not be set. If the client selects
+to use push options, but doesn't transmit any, the count variable
+will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
+
+See the section on "Quarantine Environment" in
+linkgit:git-receive-pack[1] for some caveats.
+
+Hooks executed during 'pre-receive' will not be parallelized.
+
+[[update]]
+update
+~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
+Just before updating the ref on the remote repository, the update hook
+is invoked.  Its exit status determines the success or failure of
+the ref update.
+
+The hook executes once for each ref to be updated, and takes
+three parameters:
+
+ - the name of the ref being updated,
+ - the old object name stored in the ref,
+ - and the new object name to be stored in the ref.
+
+A zero exit from the update hook allows the ref to be updated.
+Exiting with a non-zero status prevents `git receive-pack`
+from updating that ref.
+
+This hook can be used to prevent 'forced' update on certain refs by
+making sure that the object name is a commit object that is a
+descendant of the commit object named by the old object name.
+That is, to enforce a "fast-forward only" policy.
+
+It could also be used to log the old..new status.  However, it
+does not know the entire set of branches, so it would end up
+firing one e-mail per ref when used naively, though.  The
+<<post-receive,'post-receive'>> hook is more suited to that.
+
+In an environment that restricts the users' access only to git
+commands over the wire, this hook can be used to implement access
+control without relying on filesystem ownership and group
+membership. See linkgit:git-shell[1] for how you might use the login
+shell to restrict the user's access to only git commands.
+
+Both standard output and standard error output are forwarded to
+`git send-pack` on the other end, so you can simply `echo` messages
+for the user.
+
+The default 'update' hook, when enabled--and with
+`hooks.allowunannotated` config option unset or set to false--prevents
+unannotated tags to be pushed.
+
+Hooks executed during 'update' are run in parallel, unless hook.jobs is
+configured to 1.
+
+[[proc-receive]]
+proc-receive
+~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but uses a pkt-line format protocol to communicate with
+'receive-pack' to read commands, push-options and send results.  In the
+following example for the protocol, the letter 'S' stands for
+'receive-pack' and the letter 'H' stands for this hook.
+
+    # Version and features negotiation.
+    S: PKT-LINE(version=1\0push-options atomic...)
+    S: flush-pkt
+    H: PKT-LINE(version=1\0push-options...)
+    H: flush-pkt
+
+    # Send commands from server to the hook.
+    S: PKT-LINE(<old-oid> <new-oid> <ref>)
+    S: ... ...
+    S: flush-pkt
+    # Send push-options only if the 'push-options' feature is enabled.
+    S: PKT-LINE(push-option)
+    S: ... ...
+    S: flush-pkt
+
+    # Receive result from the hook.
+    # OK, run this command successfully.
+    H: PKT-LINE(ok <ref>)
+    # NO, I reject it.
+    H: PKT-LINE(ng <ref> <reason>)
+    # Fall through, let 'receive-pack' to execute it.
+    H: PKT-LINE(ok <ref>)
+    H: PKT-LINE(option fall-through)
+    # OK, but has an alternate reference.  The alternate reference name
+    # and other status can be given in option directives.
+    H: PKT-LINE(ok <ref>)
+    H: PKT-LINE(option refname <refname>)
+    H: PKT-LINE(option old-oid <old-oid>)
+    H: PKT-LINE(option new-oid <new-oid>)
+    H: PKT-LINE(option forced-update)
+    H: ... ...
+    H: flush-pkt
+
+Each command for the 'proc-receive' hook may point to a pseudo-reference
+and always has a zero-old as its old-oid, while the 'proc-receive' hook
+may update an alternate reference and the alternate reference may exist
+already with a non-zero old-oid.  For this case, this hook will use
+"option" directives to report extended attributes for the reference given
+by the leading "ok" directive.
+
+The report of the commands of this hook should have the same order as
+the input.  The exit status of the 'proc-receive' hook only determines
+the success or failure of the group of commands sent to it, unless
+atomic push is in use.
+
+It is forbidden to specify more than one hook for 'proc-receive'. If a
+globally-configured 'proc-receive' must be overridden, use
+'hookcmd.<global-hook>.skip = true' to ignore it.
+
+[[post-receive]]
+post-receive
+~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
+It executes on the remote repository once after all the refs have
+been updated.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but gets the same information as the
+<<pre-receive,'pre-receive'>>
+hook does on its standard input.
+
+This hook does not affect the outcome of `git receive-pack`, as it
+is called after the real work is done.
+
+This supersedes the <<post-update,'post-update'>> hook in that it gets
+both old and new values of all the refs in addition to their
+names.
+
+Both standard output and standard error output are forwarded to
+`git send-pack` on the other end, so you can simply `echo` messages
+for the user.
+
+The default 'post-receive' hook is empty, but there is
+a sample script `post-receive-email` provided in the `contrib/hooks`
+directory in Git distribution, which implements sending commit
+emails.
+
+The number of push options given on the command line of
+`git push --push-option=...` can be read from the environment
+variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
+found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
+If it is negotiated to not use the push options phase, the
+environment variables will not be set. If the client selects
+to use push options, but doesn't transmit any, the count variable
+will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
+
+Hooks executed during 'post-receive' are run in parallel, unless hook.jobs is
+configured to 1.
+
+[[post-update]]
+post-update
+~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
+It executes on the remote repository once after all the refs have
+been updated.
+
+It takes a variable number of parameters, each of which is the
+name of ref that was actually updated.
+
+This hook is meant primarily for notification, and cannot affect
+the outcome of `git receive-pack`.
+
+The 'post-update' hook can tell what are the heads that were pushed,
+but it does not know what their original and updated values are,
+so it is a poor place to do log old..new. The
+<<post-receive,'post-receive'>> hook does get both original and
+updated values of the refs. You might consider it instead if you need
+them.
+
+When enabled, the default 'post-update' hook runs
+`git update-server-info` to keep the information used by dumb
+transports (e.g., HTTP) up to date.  If you are publishing
+a Git repository that is accessible via HTTP, you should
+probably enable this hook.
+
+Both standard output and standard error output are forwarded to
+`git send-pack` on the other end, so you can simply `echo` messages
+for the user.
+
+Hooks run during 'post-update' will be run in parallel, unless hook.jobs is
+configured to 1.
+
+reference-transaction
+~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by any Git command that performs reference
+updates. It executes whenever a reference transaction is prepared,
+committed or aborted and may thus get called multiple times.
+
+The hook takes exactly one argument, which is the current state the
+given reference transaction is in:
+
+    - "prepared": All reference updates have been queued to the
+      transaction and references were locked on disk.
+
+    - "committed": The reference transaction was committed and all
+      references now have their respective new value.
+
+    - "aborted": The reference transaction was aborted, no changes
+      were performed and the locks have been released.
+
+For each reference update that was added to the transaction, the hook
+receives on standard input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> LF
+
+The exit status of the hook is ignored for any state except for the
+"prepared" state. In the "prepared" state, a non-zero exit status will
+cause the transaction to be aborted. The hook will not be called with
+"aborted" state in that case.
+
+Hooks run during 'reference-transaction' will be run in parallel, unless
+hook.jobs is configured to 1.
+
+push-to-checkout
+~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository, and when
+the push tries to update the branch that is currently checked out
+and the `receive.denyCurrentBranch` configuration variable is set to
+`updateInstead`.  Such a push by default is refused if the working
+tree and the index of the remote repository has any difference from
+the currently checked out commit; when both the working tree and the
+index match the current commit, they are updated to match the newly
+pushed tip of the branch.  This hook is to be used to override the
+default behaviour.
+
+The hook receives the commit with which the tip of the current
+branch is going to be updated.  It can exit with a non-zero status
+to refuse the push (when it does so, it must not modify the index or
+the working tree).  Or it can make any necessary changes to the
+working tree and to the index to bring them to the desired state
+when the tip of the current branch is updated to the new commit, and
+exit with a zero status.
+
+For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
+in order to emulate `git fetch` that is run in the reverse direction
+with `git push`, as the two-tree form of `git read-tree -u -m` is
+essentially the same as `git switch` or `git checkout`
+that switches branches while
+keeping the local changes in the working tree that do not interfere
+with the difference between the branches.
+
+Hooks executed during 'push-to-checkout' will not be parallelized.
+
+pre-auto-gc
+~~~~~~~~~~~
+
+This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
+takes no parameter, and exiting with non-zero status from this script
+causes the `git gc --auto` to abort.
+
+Hooks run during 'pre-auto-gc' will be run in parallel, unless hook.jobs is
+configured to 1.
+
+post-rewrite
+~~~~~~~~~~~~
+
+This hook is invoked by commands that rewrite commits
+(linkgit:git-commit[1] when called with `--amend` and
+linkgit:git-rebase[1]; however, full-history (re)writing tools like
+linkgit:git-fast-import[1] or
+https://github.com/newren/git-filter-repo[git-filter-repo] typically
+do not call it!).  Its first argument denotes the command it was
+invoked by: currently one of `amend` or `rebase`.  Further
+command-dependent arguments may be passed in the future.
+
+The hook receives a list of the rewritten commits on stdin, in the
+format
+
+  <old-sha1> SP <new-sha1> [ SP <extra-info> ] LF
+
+The 'extra-info' is again command-dependent.  If it is empty, the
+preceding SP is also omitted.  Currently, no commands pass any
+'extra-info'.
+
+The hook always runs after the automatic note copying (see
+"notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
+thus has access to these notes.
+
+Hooks run during 'post-rewrite' will be run in parallel, unless hook.jobs is
+configured to 1.
+
+The following command-specific comments apply:
+
+rebase::
+	For the 'squash' and 'fixup' operation, all commits that were
+	squashed are listed as being rewritten to the squashed commit.
+	This means that there will be several lines sharing the same
+	'new-sha1'.
++
+The commits are guaranteed to be listed in the order that they were
+processed by rebase.
+
+sendemail-validate
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
+the name of the file that holds the e-mail to be sent.  Exiting with a
+non-zero status causes `git send-email` to abort before sending any
+e-mails.
+
+fsmonitor-watchman
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked when the configuration option `core.fsmonitor` is
+set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
+depending on the version of the hook to use.
+
+Version 1 takes two arguments, a version (1) and the time in elapsed
+nanoseconds since midnight, January 1, 1970.
+
+Version 2 takes two arguments, a version (2) and a token that is used
+for identifying changes since the token. For watchman this would be
+a clock id. This version must output to stdout the new token followed
+by a NUL before the list of files.
+
+The hook should output to stdout the list of all files in the working
+directory that may have changed since the requested time.  The logic
+should be inclusive so that it does not miss any potential changes.
+The paths should be relative to the root of the working directory
+and be separated by a single NUL.
+
+It is OK to include files which have not actually changed.  All changes
+including newly-created and deleted files should be included. When
+files are renamed, both the old and the new name should be included.
+
+Git will limit what files it checks for changes as well as which
+directories are checked for untracked files based on the path names
+given.
+
+An optimized way to tell git "all files have changed" is to return
+the filename `/`.
+
+The exit status determines whether git will use the data from the
+hook to limit its search.  On error, it will fall back to verifying
+all files and folders.
+
+p4-changelist
+~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-changelist` hook is executed after the changelist
+message has been edited by the user. It can be bypassed with the
+`--no-verify` option. It takes a single parameter, the name
+of the file that holds the proposed changelist text. Exiting
+with a non-zero status causes the command to abort.
+
+The hook is allowed to edit the changelist file and can be used
+to normalize the text into some project standard format. It can
+also be used to refuse the Submit after inspect the message file.
+
+Run `git-p4 submit --help` for details.
+
+p4-prepare-changelist
+~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-prepare-changelist` hook is executed right after preparing
+the default changelist message and before the editor is started.
+It takes one parameter, the name of the file that contains the
+changelist text. Exiting with a non-zero status from the script
+will abort the process.
+
+The purpose of the hook is to edit the message file in place,
+and it is not suppressed by the `--no-verify` option. This hook
+is called even if `--prepare-p4-only` is set.
+
+Run `git-p4 submit --help` for details.
+
+p4-post-changelist
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-post-changelist` hook is invoked after the submit has
+successfully occurred in P4. It takes no parameters and is meant
+primarily for notification and cannot affect the outcome of the
+git p4 submit action.
+
+Run `git-p4 submit --help` for details.
+
+p4-pre-submit
+~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
+from standard input. Exiting with non-zero status from this script prevent
+`git-p4 submit` from launching. It can be bypassed with the `--no-verify`
+command line option. Run `git-p4 submit --help` for details.
+
+
+
+post-index-change
+~~~~~~~~~~~~~~~~~
+
+This hook is invoked when the index is written in read-cache.c
+do_write_locked_index.
+
+The first parameter passed to the hook is the indicator for the
+working directory being updated.  "1" meaning working directory
+was updated or "0" when the working directory was not updated.
+
+The second parameter passed to the hook is the indicator for whether
+or not the index was updated and the skip-worktree bit could have
+changed.  "1" meaning skip-worktree bits could have been updated
+and "0" meaning they were not.
+
+Only one parameter should be set to "1" when the hook runs.  The hook
+running passing "1", "1" should not be possible.
+
+Hooks run during 'post-index-change' will be run in parallel, unless hook.jobs
+is configured to 1.
+
-- 
2.31.0.rc2.261.g7f71774620-goog

