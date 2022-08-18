Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00CCC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbiHRVlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347032AbiHRVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:40:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE501BD292
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so1626165wms.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=elNanR4Ph8PeiR+oaJRraoDgRb6A0aplfq7xbGsvpSc=;
        b=gCnm9VES8fQRXX8b48VIQL6+1G174eltywVR2iSUZyEI+V9hCkId0s+sH/PNsM164+
         doVOUxMqqPq89KluuYYcgspVVRiw/habZOsYkoDxnKJ8cilXnDXPEK0hlAwFQDpQj4da
         r7JkTPgQzYychL6ELtwGfy4oAnYNSD2EZQvVCstg3tQEKF67PIIlSqQEJ/583HNamCib
         FRXpiV2aBlYjMykuK55eTQmqEzaMYhb0FwWpJ/9xaGBL1WuX9JHNhukeN5p+38AsX//z
         NyMTDDYRg2HhOC4043zOv/6Qy6zNKSd7K4rrkF82B8/kj2JeF7MAqwkfHhcK6XzOh3WD
         vOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=elNanR4Ph8PeiR+oaJRraoDgRb6A0aplfq7xbGsvpSc=;
        b=QuxAxtLbSHBk7z3NbM5267Q++SFHW5YCoNLxovTMXDfcgvpMsa/eMWpTD1sp/Wz/cy
         jm45WsYQL+o61fkSQQBv8c1rTThb3H5nht1fairvVhuiCCIAXovL+qVngE9TV32kQKDz
         UqodVLgkxdEJTj0l9uEPNN3AEVauom0p3ha6DdI+ab/IEqjzJl5o0yHyynhlh98/8+dl
         LM/DzJfnINd9xWej0aifeWCARj0O5k402nR6Cjn41W56Lj8MOEjP8N7wj3RzxP3B3ss0
         63b2AIGB8X2pTnSbhwOsHHTzUYuVdT5tU87kvOAs3n4VL0+7XK1KS8gK/748Rq/PHeau
         u52w==
X-Gm-Message-State: ACgBeo1FVpJ+OLzAI+bDo65NFq1R7mB780UkqJJkBviNezqSFwh30xT5
        zAUjlzzhbyNgozlxoXl+TYC4oZJo4FM=
X-Google-Smtp-Source: AA6agR5GkahsTPSY7Z3o63pt5DThWGsN0HPnIOp0C5zvKuXGryQ8pmdgJuimSqOAHT8nNNcuvESpkg==
X-Received: by 2002:a05:600c:1906:b0:3a5:fe9c:4dcf with SMTP id j6-20020a05600c190600b003a5fe9c4dcfmr3038471wmq.118.1660858854953;
        Thu, 18 Aug 2022 14:40:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22-20020a1ce916000000b003a531c7aa66sm3407184wmc.1.2022.08.18.14.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:40:54 -0700 (PDT)
Message-Id: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:45 +0000
Subject: [PATCH v3 0/8] scalar: enable built-in FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series enables the built-in FSMonitor [1] on 'scalar'-registered
repository enlistments. To avoid errors when unregistering an enlistment,
the FSMonitor daemon is explicitly stopped during 'scalar unregister'.

Maintainer's note: this series has a minor conflict with
'vd/scalar-generalize-diagnose'. Please let me know if there's anything else
I can provide (in addition to [2]) that would make resolution easier.


Changes since V2
================

 * Updated prerequisites for FSMonitor in Scalar to include
   'fsm_settings__get_reason(the_repository) == FSMONITOR_REASON_OK' to
   handle cases where the platform is supported, but the repository is not.
 * Gated enabling the 'core.fsmonitor' on FSMonitor compatibility with the
   repo.
 * Replaced 'die()' failures in 'delete_enlistment()' with 'error()'s.
 * Replaced 'BUILTIN_FSMONITOR' test prerequisite with already-existing
   'FSMONITOR_DAEMON' for FSMonitor.
 * Rewrote Scalar enlistment/repo search in 'setup_enlistment_directory()'
   to avoid unconstrained search and respect 'GIT_CEILING_DIRECTORIES'.
   Added tests to show the new expected behavior.


Changes since V1
================

 * Added a patch to fix 'unregister_dir()'s handling of return values > 0
   from 'toggle_maintenance()' and 'add_or_remove_enlistment()'.
 * Added a patch to print error messages in 'register_dir()' and
   'unregister_dir()' indicating which of their internal steps fail.
 * Moved check of 'fsmonitor_ipc__is_supported()' to '[un]register_dir()' to
   avoid calling '(start|stop)_fsmonitor_daemon()' when the feature is not
   supported. Added assertion of 'fsmonitor_ipc__is_supported()' to
   '(start|stop)_fsmonitor_daemon()' to enforce that they are not called
   when the feature is unavailable.
 * Simplified '(start|stop)_fsmonitor_daemon()' implementation. Now, if
   FSMonitor is already running/stopped (respectively), the function simply
   returns 0; otherwise, it runs 'git fsmonitor--daemon (start|stop)' and
   returns the exit code.
   * Note that the "could not (start|stop) the FSMonitor daemon: <err_msg>"
     error messages are no longer printed by
     '(start|stop)_fsmonitor_daemon()'. Instead, "<err_msg>" is printed to
     stderr by swapping 'pipe_command()' out for 'run_git()', and
     '[un]register_dir()' prints the "could not (start|stop) the FSMonitor
     daemon" message.

Thanks

 * Victoria

[1]
https://lore.kernel.org/git/pull.1143.git.1644940773.gitgitgadget@gmail.com/

[2] The conflict is a result of both series updating the Scalar roadmap doc.
For reference, my merge resolution (from git diff <merge commit> <merge
commit>^1 <merge commit>^2, where <merge commit>^1 is
'vd/scalar-generalize-diagnose' and <merge commit>^2 is this series) looks
like:

------------->8------------->8------------->8------------->8------------->8-------------
diff --cc Documentation/technical/scalar.txt
index f6353375f0,047390e46e..0600150b3a
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@@ -84,20 -84,26 +84,23 @@@ series have been accepted
  
  - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
  
 +- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
 +  into `git diagnose` and `git bugreport --diagnose`.
 +
+ - 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
+   enlistments. At the end of this series, Scalar should be feature-complete
+   from the perspective of a user.
+ 
  Roughly speaking (and subject to change), the following series are needed to
  "finish" this initial version of Scalar:
  
- - Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
-   and implement `scalar help`. At the end of this series, Scalar should be
-   feature-complete from the perspective of a user.
 -- Generalize features not specific to Scalar: In the spirit of making Scalar
 -  configure only what is needed for large repo performance, move common
 -  utilities into other parts of Git. Some of this will be internal-only, but one
 -  major change will be generalizing `scalar diagnose` for use with any Git
 -  repository.
--
  - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-   `git`, including updates to build and install it with the rest of Git. This
-   change will incorporate Scalar into the Git CI and test framework, as well as
-   expand regression and performance testing to ensure the tool is stable.
+   `git`. This includes a variety of related updates, including:
+     - building & installing Scalar in the Git root-level 'make [install]'.
+     - builing & testing Scalar as part of CI.
+     - moving and expanding test coverage of Scalar (including perf tests).
+     - implementing 'scalar help'/'git help scalar' to display scalar
+       documentation.
  
  Finally, there are two additional patch series that exist in Microsoft's fork of
  Git, but there is no current plan to upstream them. There are some interesting
-------------8<-------------8<-------------8<-------------8<-------------8<---------


Johannes Schindelin (1):
  scalar unregister: stop FSMonitor daemon

Matthew John Cheetham (1):
  scalar: enable built-in FSMonitor on `register`

Victoria Dye (6):
  scalar: constrain enlistment search
  scalar-unregister: handle error codes greater than 0
  scalar-[un]register: clearly indicate source of error
  scalar-delete: do not 'die()' in 'delete_enlistment()'
  scalar: move config setting logic into its own function
  scalar: update technical doc roadmap with FSMonitor support

 Documentation/technical/scalar.txt |  17 ++-
 contrib/scalar/scalar.c            | 201 +++++++++++++++++------------
 contrib/scalar/t/t9099-scalar.sh   |  93 +++++++++++++
 3 files changed, 220 insertions(+), 91 deletions(-)


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1324%2Fvdye%2Fscalar%2Fadd-fsmonitor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1324/vdye/scalar/add-fsmonitor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1324

Range-diff vs v2:

 -:  ----------- > 1:  2f6cad83613 scalar: constrain enlistment search
 1:  36fc3cb604d = 2:  a6bb0113b9c scalar-unregister: handle error codes greater than 0
 2:  4bacf8bce8a = 3:  aea8723e718 scalar-[un]register: clearly indicate source of error
 -:  ----------- > 4:  aced836aaa3 scalar-delete: do not 'die()' in 'delete_enlistment()'
 -:  ----------- > 5:  f8471e94e83 scalar: move config setting logic into its own function
 3:  5fdf8337972 ! 6:  fb379fd2097 scalar: enable built-in FSMonitor on `register`
     @@ Commit message
          file system monitor such as e.g. Watchman).
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Victoria Dye <vdye@github.com>
     @@ contrib/scalar/scalar.c
       #include "run-command.h"
      +#include "simple-ipc.h"
      +#include "fsmonitor-ipc.h"
     ++#include "fsmonitor-settings.h"
       #include "refs.h"
       #include "dir.h"
       #include "packfile.h"
     +@@ contrib/scalar/scalar.c: static int set_scalar_config(const struct scalar_config *config, int reconfigure
     + 	return res;
     + }
     + 
     ++static int have_fsmonitor_support(void)
     ++{
     ++	return fsmonitor_ipc__is_supported() &&
     ++	       fsm_settings__get_reason(the_repository) == FSMONITOR_REASON_OK;
     ++}
     ++
     + static int set_recommended_config(int reconfigure)
     + {
     + 	struct scalar_config config[] = {
      @@ contrib/scalar/scalar.c: static int set_recommended_config(int reconfigure)
     - 		{ "core.autoCRLF", "false" },
     - 		{ "core.safeCRLF", "false" },
     - 		{ "fetch.showForcedUpdates", "false" },
     -+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     -+		/*
     -+		 * Enable the built-in FSMonitor on supported platforms.
     -+		 */
     -+		{ "core.fsmonitor", "true" },
     -+#endif
     - 		{ NULL, NULL },
     - 	};
     - 	int i;
     + 				     config[i].key, config[i].value);
     + 	}
     + 
     ++	if (have_fsmonitor_support()) {
     ++		struct scalar_config fsmonitor = { "core.fsmonitor", "true" };
     ++		if (set_scalar_config(&fsmonitor, reconfigure))
     ++			return error(_("could not configure %s=%s"),
     ++				     fsmonitor.key, fsmonitor.value);
     ++	}
     ++
     + 	/*
     + 	 * The `log.excludeDecoration` setting is special because it allows
     + 	 * for multiple values.
      @@ contrib/scalar/scalar.c: static int add_or_remove_enlistment(int add)
       		       "scalar.repo", the_repository->worktree, NULL);
       }
       
      +static int start_fsmonitor_daemon(void)
      +{
     -+	assert(fsmonitor_ipc__is_supported());
     ++	assert(have_fsmonitor_support());
      +
      +	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
      +		return run_git("fsmonitor--daemon", "start", NULL);
     @@ contrib/scalar/scalar.c: static int register_dir(void)
       	if (toggle_maintenance(1))
       		return error(_("could not turn on maintenance"));
       
     -+	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
     ++	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
      +		return error(_("could not start the FSMonitor daemon"));
     ++	}
      +
       	return 0;
       }
       
      
       ## contrib/scalar/t/t9099-scalar.sh ##
     -@@ contrib/scalar/t/t9099-scalar.sh: PATH=$PWD/..:$PATH
     - GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
     - export GIT_TEST_MAINT_SCHEDULER
     - 
     -+test_lazy_prereq BUILTIN_FSMONITOR '
     -+	git version --build-options | grep -q "feature:.*fsmonitor--daemon"
     -+'
     -+
     - test_expect_success 'scalar shows a usage' '
     - 	test_expect_code 129 scalar -h
     +@@ contrib/scalar/t/t9099-scalar.sh: test_expect_success 'scalar enlistments need a worktree' '
     + 	grep "Scalar enlistments require a worktree" err
       '
       
     -+test_expect_success BUILTIN_FSMONITOR 'scalar register starts fsmon daemon' '
     ++test_expect_success FSMONITOR_DAEMON 'scalar register starts fsmon daemon' '
      +	git init test/src &&
      +	test_must_fail git -C test/src fsmonitor--daemon status &&
      +	scalar register test/src &&
     -+	git -C test/src fsmonitor--daemon status
     ++	git -C test/src fsmonitor--daemon status &&
     ++	test_cmp_config -C test/src true core.fsmonitor
      +'
      +
       test_expect_success 'scalar unregister' '
 4:  fc4aa1fde31 ! 7:  bb58a78fdb2 scalar unregister: stop FSMonitor daemon
     @@ contrib/scalar/scalar.c: static int start_fsmonitor_daemon(void)
       
      +static int stop_fsmonitor_daemon(void)
      +{
     -+	assert(fsmonitor_ipc__is_supported());
     ++	assert(have_fsmonitor_support());
      +
      +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
      +		return run_git("fsmonitor--daemon", "stop", NULL);
     @@ contrib/scalar/scalar.c: static int start_fsmonitor_daemon(void)
       static int register_dir(void)
       {
       	if (add_or_remove_enlistment(1))
     -@@ contrib/scalar/scalar.c: static int unregister_dir(void)
     - 	if (add_or_remove_enlistment(0))
     - 		res = error(_("could not remove enlistment"));
     +@@ contrib/scalar/scalar.c: static int delete_enlistment(struct strbuf *enlistment)
     + 	strbuf_release(&parent);
     + #endif
       
     -+	if (fsmonitor_ipc__is_supported() && stop_fsmonitor_daemon() < 0)
     -+		res = error(_("could not stop the FSMonitor daemon"));
     ++	if (have_fsmonitor_support() && stop_fsmonitor_daemon())
     ++		return error(_("failed to stop the FSMonitor daemon"));
      +
     - 	return res;
     - }
     + 	if (remove_dir_recursively(enlistment, 0))
     + 		return error(_("failed to delete enlistment directory"));
       
 5:  dd59caa2e5a = 8:  7cee014e2d2 scalar: update technical doc roadmap with FSMonitor support

-- 
gitgitgadget
