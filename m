Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6392C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiC2LTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiC2LS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:18:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDB4B406
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:17:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b15so20298612edn.4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xIOFvSCDJbLOTK3hL4SI4aA90eatL6nVloTUAmwxeJI=;
        b=PXd76WhoDFXq9OXgSG9F+XjZTxiy/uBbvJ7X7W0rsg0VH/5f2PV28VDlafrPsLoUVJ
         7bkQcHa5a1OYth01xVjcgvpFQ62pEzpDLzczglJlOzpV+6hSuE9nwC/F8k4zkT4CO+xT
         OMLPG7Fk66YcOAYhvGPUT0D1OCaAht71MIZNf+RIc6Y/NTUGo6Q+uj+6bXbFD6Gogv9f
         7V9tVY1a87QmbqaSQGvBJeY1SovgfupePxW6frz8uK8KdfNNZbnW48pS99pzS0vvs0Ln
         CxsDgrmczr+cWcI2F9dZ5pjn8Gfsy4yRG+gmuLOZV2LfgRqZTM32ijBqlawOQv/mluK7
         mG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xIOFvSCDJbLOTK3hL4SI4aA90eatL6nVloTUAmwxeJI=;
        b=evuzPTrW12bjytA+ATzPN57gppvN7HBJrB7OLR8ZasX25eHlMafRIkC+T9aqC68b9D
         S8urA/bxk1JnggZcWkOgm2lIxVHj54lThFTcb5HjNAIVaA2EmaBxpbZ+PQmQWwjcc7sN
         jRkH/oWgq4qF1QLXp/E5ACFLEwvgv3b52ot9j5gUwZzDz8kQ2p/L/0pWYMMC1MJW15ff
         wXDEX19svz0CdO59EMgw3ubCp0I/D2rpi/mMugl2iEoPorCB/lfwVwwdNwFxdGl8WoJW
         zBHmbwcaMeA2qdCqwxjktR+Dx+iK8J9TsWjILJwdyIzx9GkzigobN/863SXLhzZcHnBP
         g8kg==
X-Gm-Message-State: AOAM530a8nB1L+OcMcF/jlKFAu2QW0PUp1PnDBRNoFbdfoRgfcGbYRMU
        tb6wo+W6+gYrpUOlnu4v4WfBWs8H+v1tbA==
X-Google-Smtp-Source: ABdhPJx+igSwcRqdwRonj3+5rtg5rTrw1D7kuuyv4sq2Q8WLHwuNljmudofY2/Fk1n/YVfRdGGDOKA==
X-Received: by 2002:a05:6402:454:b0:416:2db7:685b with SMTP id p20-20020a056402045400b004162db7685bmr3841763edw.43.1648552634228;
        Tue, 29 Mar 2022 04:17:14 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm6951248ejd.18.2022.03.29.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:17:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZ9qa-003b8X-V4;
        Tue, 29 Mar 2022 13:17:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 00/13] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
Date:   Tue, 29 Mar 2022 12:47:27 +0200
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
Message-ID: <220329.86czi52ekn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, Neeraj K. Singh via GitGitGadget wrote:

> V4 changes:
>
>  * Make ODB transactions nestable.
>  * Add an ODB transaction around writing out the cached tree.
>  * Change update-index to use a more straightforward way of managing ODB
>    transactions.
>  * Fix missing 'local's in lib-unique-files
>  * Add a per-iteration setup mechanism to test_perf.
>  * Fix camelCasing in warning message.

I haven't looked at the bulk of this in any detail, but:

>  10:  b99b32a469c ! 12:  fdf90d45f52 core.fsyncmethod: performance tests for add and stash
>      @@ t/perf/p3700-add.sh (new)
>       +# core.fsyncMethod=batch mode, which is why we are testing different values
>       +# of that setting explicitly and creating a lot of unique objects.
>       +
>      -+test_description="Tests performance of add"
>      ++test_description="Tests performance of adding things to the object database"

Now having both tests for "add" and "stash" in a test named p3700-add.sh
isn't better, the rest of the perf tests are split up by command,
perhaps just add a helper library and have both use it?

And re the unaddressed feedback I ad of "why the random data"
inhttps://lore.kernel.org/git/220326.86o81sk9ao.gmgdl@evledraar.gmail.com/
I tried patching it on top to do what I suggested there, allowing us to
run these against any arbitrary repository and came up with this:

diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
index ef6024f9897..60abd5ee076 100755
--- a/t/perf/p3700-add.sh
+++ b/t/perf/p3700-add.sh
@@ -13,47 +13,26 @@ export GIT_TEST_FSYNC
 
 . ./perf-lib.sh
 
-. $TEST_DIRECTORY/lib-unique-files.sh
-
-test_perf_fresh_repo
+test_perf_default_repo
 test_checkout_worktree
 
-dir_count=10
-files_per_dir=50
-total_files=$((dir_count * files_per_dir))
-
-for mode in false true batch
+for cfg in \
+	'-c core.fsync=-loose-object -c core.fsyncmethod=fsync' \
+	'-c core.fsync=loose-object -c core.fsyncmethod=fsync' \
+	'-c core.fsync=loose-object -c core.fsyncmethod=batch' \
+	'-c core.fsyncmethod=batch'
 do
-	case $mode in
-	false)
-		FSYNC_CONFIG='-c core.fsync=-loose-object -c core.fsyncmethod=fsync'
-		;;
-	true)
-		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=fsync'
-		;;
-	batch)
-		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=batch'
-		;;
-	esac
-
-	test_perf "add $total_files files (object_fsyncing=$mode)" \
-		--setup "
-		(rm -rf .git || 1) &&
-		git init &&
-		test_create_unique_files $dir_count $files_per_dir files_$mode
-	" "
-		git $FSYNC_CONFIG add files_$mode
-	"
-
-	test_perf "stash $total_files files (object_fsyncing=$mode)" \
-		--setup "
-		(rm -rf .git || 1) &&
-		git init &&
-		test_commit first &&
-		test_create_unique_files $dir_count $files_per_dir stash_files_$mode
-	" "
-		git $FSYNC_CONFIG stash push -u -- stash_files_$mode
-	"
+	test_perf "'git add' with '$cfg'" \
+		--setup '
+			mv -v .git .git.old &&
+			git init .
+		' \
+		--cleanup '
+			rm -rf .git &&
+			mv .git.old .git
+		' '
+		git $cfg add -f -- ":!.git.old/"
+	'
 done
 
 test_done
diff --git a/t/perf/p3900-stash.sh b/t/perf/p3900-stash.sh
new file mode 100755
index 00000000000..12c489069ba
--- /dev/null
+++ b/t/perf/p3900-stash.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='performance of "git stash" with different fsync settings'
+
+# Fsync is normally turned off for the test suite.
+GIT_TEST_FSYNC=1
+export GIT_TEST_FSYNC
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+for cfg in \
+	'-c core.fsync=-loose-object -c core.fsyncmethod=fsync' \
+	'-c core.fsync=loose-object -c core.fsyncmethod=fsync' \
+	'-c core.fsync=loose-object -c core.fsyncmethod=batch' \
+	'-c core.fsyncmethod=batch'
+do
+	test_perf "'stash push -u' with '$cfg'" \
+		--setup '
+			mv -v .git .git.old &&
+			git init . &&
+			test_commit dummy
+		' \
+		--cleanup '
+			rm -rf .git &&
+			mv .git.old .git
+		' '
+		git $cfg stash push -a -u ":!.git.old/" ":!test*" "."
+	'
+done
+
+test_done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index a935ad622d3..24a5108f234 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -194,6 +194,7 @@ test_wrapper_ () {
 	test_start_
 	test_prereq=
 	test_perf_setup_=
+	test_perf_cleanup_=
 	while test $# != 0
 	do
 		case $1 in
@@ -205,6 +206,10 @@ test_wrapper_ () {
 			test_perf_setup_=$2
 			shift
 			;;
+		--cleanup)
+			test_perf_cleanup_=$2
+			shift
+			;;
 		*)
 			break
 			;;
@@ -214,6 +219,7 @@ test_wrapper_ () {
 	test "$#" = 1 || BUG "test_wrapper_ needs 2 positional parameters"
 	export test_prereq
 	export test_perf_setup_
+	export test_perf_cleanup_
 	if ! test_skip "$test_title_" "$@"
 	then
 		base=$(basename "$0" .sh)
@@ -256,6 +262,16 @@ test_perf_ () {
 			test_failure_ "$@"
 			break
 		fi
+		if test -n "$test_perf_cleanup_"
+		then
+			say >&3 "cleanup: $test_perf_cleanup_"
+			if ! test_eval_ $test_perf_cleanup_
+			then
+				test_failure_ "$test_perf_cleanup_"
+				break
+			fi
+
+		fi
 	done
 	if test -z "$verbose"; then
 		echo " ok"


Here it is against Cor.git (a random small-ish repo I had laying around):
	
	$ GIT_SKIP_TESTS='p3[79]00.[12]' GIT_PERF_MAKE_OPTS='CFLAGS=-O3' GIT_PERF_REPO=~/g/Cor/ ./run origin/master HEAD -- p3900-stash.sh
	=== Building abf474a5dd901f28013c52155411a48fd4c09922 (origin/master) ===
	    GEN git-add--interactive
	    GEN git-archimport
	    GEN git-cvsexportcommit
	    GEN git-cvsimport
	    GEN git-cvsserver
	    GEN git-send-email
	    GEN git-svn
	    GEN git-p4
	    SUBDIR templates
	=== Running 1 tests in /home/avar/g/git/t/perf/build/abf474a5dd901f28013c52155411a48fd4c09922/bin-wrappers ===
	ok 1 # skip 'stash push -u' with '-c core.fsync=-loose-object -c core.fsyncmethod=fsync' (GIT_SKIP_TESTS)
	ok 2 # skip 'stash push -u' with '-c core.fsync=loose-object -c core.fsyncmethod=fsync' (GIT_SKIP_TESTS)
	perf 3 - 'stash push -u' with '-c core.fsync=loose-object -c core.fsyncmethod=batch': 1 2 3 ok
	perf 4 - 'stash push -u' with '-c core.fsyncmethod=batch': 1 2 3 ok
	# passed all 4 test(s)
	1..4
	=== Building ecda9c2b029e35d239e369b875b245f45fd2a097 (HEAD) ===
	    GEN git-add--interactive
	    GEN git-archimport
	    GEN git-cvsexportcommit
	    GEN git-cvsimport
	    GEN git-cvsserver
	    GEN git-send-email
	    GEN git-svn
	    GEN git-p4
	    SUBDIR templates
	=== Running 1 tests in /home/avar/g/git/t/perf/build/ecda9c2b029e35d239e369b875b245f45fd2a097/bin-wrappers ===
	ok 1 # skip 'stash push -u' with '-c core.fsync=-loose-object -c core.fsyncmethod=fsync' (GIT_SKIP_TESTS)
	ok 2 # skip 'stash push -u' with '-c core.fsync=loose-object -c core.fsyncmethod=fsync' (GIT_SKIP_TESTS)
	perf 3 - 'stash push -u' with '-c core.fsync=loose-object -c core.fsyncmethod=batch': 1 2 3 ok
	perf 4 - 'stash push -u' with '-c core.fsyncmethod=batch': 1 2 3 ok
	# passed all 4 test(s)
	1..4
	Test       origin/master     HEAD
	---------------------------------------------------
	3900.3:    0.03(0.00+0.00)   0.02(0.00+0.00) -33.3%
	3900.4:    0.02(0.00+0.00)   0.03(0.00+0.00) +50.0%
	
