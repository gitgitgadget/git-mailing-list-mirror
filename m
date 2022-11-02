Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4184C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKBV2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKBV14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 17:27:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C920EF029
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 14:27:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2116786wmb.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TM0qdkp40QU5z14qV5UzU/tN3y4N+PNZgR36uVD+eI8=;
        b=hT+xkD/3c5aSZSxjE2PfLh/YqaBqJ8cLvk8T3zU+qlbnQn5OMuQxzc7+fv/0gv2VcB
         HJGE7DCcS5Chz1e3Tngh2ZmF2LLEivTfF5ZfqplCGF8wcPXHHBDD5LR0g2fg43xl+ib7
         30mxcozvBFqZcvBzuGpfGpHU8VrzNGOKonhmdEU0eTxMLfi5G55gjPcNQOVVeYfAbCKQ
         zTiCJplnWDJBp2J/Ho3JPaQvZ2RtuOf6pTe0NjGsa5GWh7+LU3koQk9NR6xKdiH2/3Ga
         oJWeRSS2SVNsEMfBi0rAvOfxaLKzl8IgDDgRrILSiGS/uXRW6On9iEdF5leFDTBF2f+I
         Jpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM0qdkp40QU5z14qV5UzU/tN3y4N+PNZgR36uVD+eI8=;
        b=wTzVNTut11BS0QqUAuqdRIjuVi75PBf9h7RpN9CeljjjF2QIqV2+xxqpmvM24sPq6A
         Ck2n5UFuoTv7RT8iOFusTEG1tHh4EyQhKQ7tZQhuejcy6wiGrVVDXsmLHFx/THqoowKy
         bU1NHR9/ugiv836+pd2tXqCpPGKrXNJhI0c4BosbM1L+ssuVIq/VukWkA8WiiVe72IfB
         27rWmLHpF3CzAoSRcRw1orgvBaCsOcAd7USCl8J06CKFNdtCQChs8GOkM4GAfZSNmEdX
         PqLjLGz9TJC6aanu5LFapr+LTYc2EeeRLSmSKrggpV/W/V4QzD2VOfJgP122BzupYOF4
         TI3Q==
X-Gm-Message-State: ACrzQf0KhxcetLv1OWuplCCrinqhBtG1QnOC988Xj01HS8dqxw5JxWUj
        L4TepWLTfILX+DqfImLwJ44Eu79nGIQ=
X-Google-Smtp-Source: AMsMyM5j01a4yOA9oNzQQpbIUkIVpgVhgkn9Fkr3+iMHnSCEEGkiYYht7iowJLPjCvVR1cSi2Kzbfg==
X-Received: by 2002:a1c:7405:0:b0:3cf:5d41:be8b with SMTP id p5-20020a1c7405000000b003cf5d41be8bmr20447807wmc.1.1667424468743;
        Wed, 02 Nov 2022 14:27:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003c6c3fb3cf6sm3598814wmb.18.2022.11.02.14.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:27:48 -0700 (PDT)
Message-Id: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 21:27:47 +0000
Subject: [PATCH v3] status: long status advice adapted to recent capabilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot <rudy.rigot@gmail.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rudy Rigot <rudy.rigot@gmail.com>

Improve the advice displayed when `git status` is slow because
of excessive numbers of untracked files.  Update the `git status`
man page to explain the various configuration options.

`git status` can be slow when there are a large number of untracked
files and directories, because Git must search the entire worktree
to enumerate them.  Previously, Git would print an advice message
with the elapsed search time and a suggestion to disable the search
using the `-uno` option.  This suggestion also carried a warning
that might scare off some users.

Git can reduce the size and time of the untracked file search when
the `core.untrackedCache` and `core.fsmonitor` features are enabled
by caching results from previous `git status` invocations.

Update the advice to explain the various combinations of additional
configuration options and refer to (new) documentation in the man
page that explains it in more detail than what can be printed in an
advice message.

Finally, add new tests to verify the new functionality.

Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
---
    status: long status advice adapted to recent capabilities
    
    Here is version 3 for this patch.
    
    Changes since v2:
    
     * Replaced copy of the commit message with the better one suggested by
       Jeff.
     * Replaced copy of the doc and the default advice message with the
       better ones suggested by Jeff.
     * Fixed EOF.
     * Changed the approach for users who are already optimized, pending
       more conversation to see what makes most sense.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v2:

 1:  9ef7f1834b7 ! 1:  3c98492cb82 status: long status advice adapted to recent capabilities
     @@ Metadata
       ## Commit message ##
          status: long status advice adapted to recent capabilities
      
     -    Currently, if git-status takes more than 2 seconds for enumerating untracked
     -    files, a piece of advice is given to the user to consider ignoring untracked
     -    files. But Git now offers more possibilities to resolve that situation
     -    (untracked cache, fsmonitor) with different downsides.
     +    Improve the advice displayed when `git status` is slow because
     +    of excessive numbers of untracked files.  Update the `git status`
     +    man page to explain the various configuration options.
      
     -    This change is about refreshing that advice message. A new section in the
     -    documentation is introduced to present the possibilities, and the advice
     -    message links to it. I'm also introducing tests for this advice message,
     -    which was untested so far.
     +    `git status` can be slow when there are a large number of untracked
     +    files and directories, because Git must search the entire worktree
     +    to enumerate them.  Previously, Git would print an advice message
     +    with the elapsed search time and a suggestion to disable the search
     +    using the `-uno` option.  This suggestion also carried a warning
     +    that might scare off some users.
      
     -    One of the downsides of untracked cache / fsmonitor, is that the first call
     -    may be long in order to generate the cache, but the user may not know what
     -    their current configuration is. When collecting feedback from users of our
     -    very large repo, that's the most common point of confusion that keeps coming
     -    back: people complain about git status being slow, but are satisfied when
     -    we inform them that it's being cached and they should run it again to check.
     -    As a result, the advice message tries to keep them informed of their current
     -    configuration.
     +    Git can reduce the size and time of the untracked file search when
     +    the `core.untrackedCache` and `core.fsmonitor` features are enabled
     +    by caching results from previous `git status` invocations.
     +
     +    Update the advice to explain the various combinations of additional
     +    configuration options and refer to (new) documentation in the man
     +    page that explains it in more detail than what can be printed in an
     +    advice message.
     +
     +    Finally, add new tests to verify the new functionality.
      
          Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
      
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
      +UNTRACKED FILES AND STATUS SPEED
      +--------------------------------
      +
     -+If your untracked files take an unusual amount of time to enumerate, your
     -+repository certainly has a lot of them, and an advice message will display
     -+about it. Here are some configurations to consider in order to improve the
     -+situation:
     -+
     -+* Setting the `core.untrackedCache` configuration as `true` will allow for
     -+`git status` to keep track of the mtime of folders, in order to cache past
     -+`status` results and be sure to only browse folders that changed on subsequent
     -+runs, for filesystems that can support it (see linkgit:git-update-index[1]
     -+for details).
     -+* Used in conjonction with `core.untrackedCache`, setting the `core.fsmonitor`
     -+configuration as `true` will allow for `git status` to keep track of what
     -+files recently changed, in order to cache past `status` results and be sure
     -+to only focus on those files on subsequent runs (see linkgit:git-update-index[1]
     -+for details).
     -+* If none of the above options are satisfactory, setting the
     -+`status.showUntrackedFiles` configuration as `no` will cause `git status`
     -+to not attempt to list untracked files anymore, in which case you have to be
     -+careful not to forget to add new files yourself.
     -+
     -+If none of the above solutions are satisfactory, and you are bothered with
     -+the advice message, you can disable it by setting the `advice.statusUoption`
     -+configuration to `false`.
     ++`git status` can be very slow in large worktrees if/when it
     ++needs to search for untracked files and directories.  There are
     ++many configuration options available to speed this up by either
     ++avoiding the work or making use of cached results from previous
     ++Git commands.  Since we all work in different ways, there is no
     ++single optimum set of settings right for everyone.  Here is a
     ++brief summary of the relevant options to help you choose which
     ++is right for you.  Each of these settings is independently
     ++documented elsewhere in more detail, so please refer to them
     ++for complete details.
     ++
     ++* `-uno` or `status.showUntrackedFiles=false` : just don't search
     ++    and don't report on untracked files.  This is the fastest.
     ++    `git status` will not list the untracked files, so you need
     ++    to be careful to remember if you create any new files and
     ++    manually `git add` them.
     ++
     ++* `advice.statusUoption=false` : search, but don't complain if it
     ++    takes too long.
     ++
     ++* `core.untrackedCache=true` : enable the untracked cache feature
     ++    and only search directories that have been modified since the
     ++    previous `git status` command.  Git remembers the set of
     ++    untracked files within each directory and assumes that if a
     ++    directory has not been modified, then the set of untracked
     ++    file within has not changed.  This is much faster than
     ++    enumerating the contents of every directory, but still not
     ++    without cost, because Git still has to search for the set of
     ++    modified directories.
     ++
     ++* `core.untrackedCache=true` and `core.fsmonitor=true` or
     ++    `core.fsmonitor=<hook_command_pathname>` : enable both the
     ++    untracked cache and FSMonitor features and only search
     ++    directories that have been modified since the previous
     ++    `git status` command.  This is faster than using just the
     ++    untracked cache alone because Git can also avoid searching
     ++    for modified directories.  Git only has to enumerate the
     ++    exact set of directories that have changed recently.
     ++
     ++Note that after you turn on the untracked cache and/or FSMonitor
     ++features it may take a few `git status` commands for the various
     ++caches to warm up before you see improved command times.  This is
     ++normal.
      +
       SEE ALSO
       --------
     @@ t/t7065-wtstatus-slow.sh (new)
      +'
      +
      +test_done
     - \ No newline at end of file
      
       ## t/t7065/no_untrackedcache_no_fsmonitor (new) ##
      @@
     @@ t/t7065/no_untrackedcache_no_fsmonitor (new)
      +
      +
      +It took X seconds to enumerate untracked files.
     -+See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
     -+for configuration options that may improve that time.
     ++See 'git help status' for information on how to improve this.
      +
      +nothing to commit (create/copy files and use "git add" to track)
      
     @@ t/t7065/with_untrackedcache_no_fsmonitor (new)
      +No commits yet
      +
      +
     -+It took X seconds to enumerate untracked files,
     -+but this is currently being cached, with fsmonitor OFF.
     -+See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
     -+for configuration options that may improve that time.
     ++It took X seconds to enumerate untracked files.
     ++See 'git help status' for information on how to improve this.
      +
      +nothing to commit (create/copy files and use "git add" to track)
      
     @@ t/t7065/with_untrackedcache_with_fsmonitor (new)
      +
      +
      +It took X seconds to enumerate untracked files,
     -+but this is currently being cached, with fsmonitor ON.
     -+See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
     -+for configuration options that may improve that time.
     ++but this is currently being cached.
     ++See 'git help status' for information on how to improve this.
      +
      +nothing to commit (create/copy files and use "git add" to track)
      
     @@ wt-status.c: static void wt_longstatus_print(struct wt_status *s)
      +		if (uf_was_slow(s->untracked_in_ms)) {
      +			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
      +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     -+				if (s->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE) {
     ++				if (fsm_mode > FSMONITOR_MODE_DISABLED) {
      +					status_printf_ln(s, GIT_COLOR_NORMAL,
      +							_("It took %.2f seconds to enumerate untracked files,\n"
     -+							"but this is currently being cached, with fsmonitor %s."),
     -+							s->untracked_in_ms / 1000.0,
     -+							(fsm_mode > FSMONITOR_MODE_DISABLED) ? "ON" : "OFF");
     ++							"but this is currently being cached."),
     ++							s->untracked_in_ms / 1000.0);
      +				} else {
      +					status_printf_ln(s, GIT_COLOR_NORMAL,
      +							_("It took %.2f seconds to enumerate untracked files."),
      +							s->untracked_in_ms / 1000.0);
      +				}
      +				status_printf_ln(s, GIT_COLOR_NORMAL,
     -+						_("See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed\n"
     -+						"for configuration options that may improve that time."));
     ++						_("See 'git help status' for information on how to improve this."));
      +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
      +			}
       		}


 Documentation/git-status.txt               | 47 ++++++++++++++++++++++
 t/t7065-wtstatus-slow.sh                   | 40 ++++++++++++++++++
 t/t7065/no_untrackedcache_no_fsmonitor     |  9 +++++
 t/t7065/with_untrackedcache_no_fsmonitor   |  9 +++++
 t/t7065/with_untrackedcache_with_fsmonitor | 10 +++++
 wt-status.c                                | 38 +++++++++++++----
 6 files changed, 146 insertions(+), 7 deletions(-)
 create mode 100755 t/t7065-wtstatus-slow.sh
 create mode 100644 t/t7065/no_untrackedcache_no_fsmonitor
 create mode 100644 t/t7065/with_untrackedcache_no_fsmonitor
 create mode 100644 t/t7065/with_untrackedcache_with_fsmonitor

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..95f4ed95e96 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -457,6 +457,53 @@ during the write may conflict with other simultaneous processes, causing
 them to fail. Scripts running `status` in the background should consider
 using `git --no-optional-locks status` (see linkgit:git[1] for details).
 
+UNTRACKED FILES AND STATUS SPEED
+--------------------------------
+
+`git status` can be very slow in large worktrees if/when it
+needs to search for untracked files and directories.  There are
+many configuration options available to speed this up by either
+avoiding the work or making use of cached results from previous
+Git commands.  Since we all work in different ways, there is no
+single optimum set of settings right for everyone.  Here is a
+brief summary of the relevant options to help you choose which
+is right for you.  Each of these settings is independently
+documented elsewhere in more detail, so please refer to them
+for complete details.
+
+* `-uno` or `status.showUntrackedFiles=false` : just don't search
+    and don't report on untracked files.  This is the fastest.
+    `git status` will not list the untracked files, so you need
+    to be careful to remember if you create any new files and
+    manually `git add` them.
+
+* `advice.statusUoption=false` : search, but don't complain if it
+    takes too long.
+
+* `core.untrackedCache=true` : enable the untracked cache feature
+    and only search directories that have been modified since the
+    previous `git status` command.  Git remembers the set of
+    untracked files within each directory and assumes that if a
+    directory has not been modified, then the set of untracked
+    file within has not changed.  This is much faster than
+    enumerating the contents of every directory, but still not
+    without cost, because Git still has to search for the set of
+    modified directories.
+
+* `core.untrackedCache=true` and `core.fsmonitor=true` or
+    `core.fsmonitor=<hook_command_pathname>` : enable both the
+    untracked cache and FSMonitor features and only search
+    directories that have been modified since the previous
+    `git status` command.  This is faster than using just the
+    untracked cache alone because Git can also avoid searching
+    for modified directories.  Git only has to enumerate the
+    exact set of directories that have changed recently.
+
+Note that after you turn on the untracked cache and/or FSMonitor
+features it may take a few `git status` commands for the various
+caches to warm up before you see improved command times.  This is
+normal.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
new file mode 100755
index 00000000000..23c37ea71e7
--- /dev/null
+++ b/t/t7065-wtstatus-slow.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='test status when slow untracked files'
+
+. ./test-lib.sh
+
+DATA="$TEST_DIRECTORY/t7065"
+
+GIT_TEST_UF_DELAY_WARNING=1
+export GIT_TEST_UF_DELAY_WARNING
+
+test_expect_success setup '
+	git checkout -b test
+'
+
+test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
+	test_must_fail git config --get core.untrackedCache &&
+	test_must_fail git config --get core.fsmonitor &&
+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+    test_cmp "$DATA/no_untrackedcache_no_fsmonitor" ../actual &&
+    rm -fr ../actual
+'
+
+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
+    git config core.untrackedCache true &&
+	test_must_fail git config --get core.fsmonitor &&
+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+    test_cmp "$DATA/with_untrackedcache_no_fsmonitor" ../actual &&
+    rm -fr ../actual
+'
+
+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
+    git config core.untrackedCache true &&
+	git config core.fsmonitor true &&
+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+    test_cmp "$DATA/with_untrackedcache_with_fsmonitor" ../actual &&
+    rm -fr ../actual
+'
+
+test_done
diff --git a/t/t7065/no_untrackedcache_no_fsmonitor b/t/t7065/no_untrackedcache_no_fsmonitor
new file mode 100644
index 00000000000..91dc3719cda
--- /dev/null
+++ b/t/t7065/no_untrackedcache_no_fsmonitor
@@ -0,0 +1,9 @@
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files.
+See 'git help status' for information on how to improve this.
+
+nothing to commit (create/copy files and use "git add" to track)
diff --git a/t/t7065/with_untrackedcache_no_fsmonitor b/t/t7065/with_untrackedcache_no_fsmonitor
new file mode 100644
index 00000000000..91dc3719cda
--- /dev/null
+++ b/t/t7065/with_untrackedcache_no_fsmonitor
@@ -0,0 +1,9 @@
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files.
+See 'git help status' for information on how to improve this.
+
+nothing to commit (create/copy files and use "git add" to track)
diff --git a/t/t7065/with_untrackedcache_with_fsmonitor b/t/t7065/with_untrackedcache_with_fsmonitor
new file mode 100644
index 00000000000..89d2dd5c2e7
--- /dev/null
+++ b/t/t7065/with_untrackedcache_with_fsmonitor
@@ -0,0 +1,10 @@
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files,
+but this is currently being cached.
+See 'git help status' for information on how to improve this.
+
+nothing to commit (create/copy files and use "git add" to track)
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..4dfc8a8969b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,8 +18,10 @@
 #include "worktree.h"
 #include "lockfile.h"
 #include "sequencer.h"
+#include "fsmonitor-settings.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
+#define UF_DELAY_WARNING_IN_MS (2 * 1000)
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1205,6 +1207,17 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
+static inline int uf_was_slow(uint32_t untracked_in_ms)
+{
+	const char *x;
+	x = getenv("GIT_TEST_UF_DELAY_WARNING");
+	if (x) {
+		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
+	}
+
+	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
+}
+
 static void show_merge_in_progress(struct wt_status *s,
 				   const char *color)
 {
@@ -1814,6 +1827,7 @@ static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
@@ -1870,13 +1884,23 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-					   "may speed it up, but you have to be careful not to forget to add\n"
-					   "new files yourself (see 'git help status')."),
-					 s->untracked_in_ms / 1000.0);
+		if (uf_was_slow(s->untracked_in_ms)) {
+			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+				if (fsm_mode > FSMONITOR_MODE_DISABLED) {
+					status_printf_ln(s, GIT_COLOR_NORMAL,
+							_("It took %.2f seconds to enumerate untracked files,\n"
+							"but this is currently being cached."),
+							s->untracked_in_ms / 1000.0);
+				} else {
+					status_printf_ln(s, GIT_COLOR_NORMAL,
+							_("It took %.2f seconds to enumerate untracked files."),
+							s->untracked_in_ms / 1000.0);
+				}
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("See 'git help status' for information on how to improve this."));
+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+			}
 		}
 	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),

base-commit: bbe21b64a08f89475d8a3818e20c111378daa621
-- 
gitgitgadget
