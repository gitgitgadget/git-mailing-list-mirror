Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20639C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20CB60F5D
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 13:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhJINdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhJINdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 09:33:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33424C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 06:31:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k7so38476187wrd.13
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cX9E989gynjNgKGpGCLgk8PN+b8dWtFVQh9/ETjBimI=;
        b=ldhM5yiGmGrtkbrusiNq69xzE8BROQ/y3qlj1prffVb79NNKweV1pkzz9uiyLsrkx3
         dcBpiF7L3O9lrFl91uzfm5igJRhsNDMTGakZUN+z2di3Ft9/LJ3WgqqWoz4DwKkPsMjK
         9OEVVKRdDHRYloqNB8FC5Tu4vfomPtj/3TW44FGLQ0IQpavx4Xv1tWzR9xF4wpdr41Nd
         5u+qn7fXgB2E5BKqPZ8+5VUtrR7sT0x8btdYxc29vaIqt/cZYg832ySbmH9u0m4qRd6a
         rbimeD3CGzhlCFHHz59I/JqmybxVeLcitXHoBK7v8xfRyAGCK3p/CKfjBvWsgLeTuks2
         rXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cX9E989gynjNgKGpGCLgk8PN+b8dWtFVQh9/ETjBimI=;
        b=YkzZu532D4kmvHY6BtY6e2CzX0GxDnDMQz6YH/7HRD2xNqEVy5hIJK+EtG9iRcSoXY
         NS2y39myF997baBy9O46avneTfseEcDLI14ExzacLqquZ09EnyfHwQFmb6JgwCQToj2U
         Va0pBhSgjO0Cq6ihdc4nX3MjMEm4e+KGclP31KZwdE6wKJzjzO0QvPXsGHiH9NhfRw5W
         UxeiQylwzb6tQwslNsUFsWOeHU2Ll4GP4mXZUkSfa3CsELnj2mgpasDr5TaZ5jBVpSUn
         bHDzC/bMf+9adKdHMR4m5fwTeM1D002YM7RdtRL0FQNQlFs8NzAX4F7Z3V13P5znzBtG
         XX6A==
X-Gm-Message-State: AOAM530QSSvCGf4afAkBiIVK2hZdcdWgP/EPhiaNKxxSubenLVAsXun5
        XWKEcOduK2XMr508Acs/tQ5Vd1iI6ABi/w==
X-Google-Smtp-Source: ABdhPJzyFW7FUVQtFttghpSTO+Cjn1eQOX3kpfmx0v+6waHLxYvpOKMAL3lk9pu7r6PSS/xI180AiA==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr2068905wrr.22.1633786270932;
        Sat, 09 Oct 2021 06:31:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k9sm2177399wrz.22.2021.10.09.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 06:31:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib.sh: try to re-chmod & retry on failed trash removal
Date:   Sat,  9 Oct 2021 15:31:02 +0200
Message-Id: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1492.gcc3b81fc59a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a regression in [1] where t0004-unwritable.sh was made to
use "test_when_finished" for cleanup, we wouldn't re-chmod the
".git/objects" on failure, leading to a persistent error when running
the test.

This can be demonstrated as e.g. (output snipped for less verbosity):

    $ ./t0004-unwritable.sh --run=3 --immediate
    ok 1 # skip setup (--run)
    ok 2 # skip write-tree should notice unwritable repository (--run)
    not ok 3 - commit should notice unwritable repository
    [...]
    $ ./t0004-unwritable.sh --run=3 --immediate
    rm: cannot remove '[...]/trash directory.t0004-unwritable/.git/objects/info': Permission denied
    FATAL: Cannot prepare test area
    [...]

I.e. if any of its tests failed, and the tests were being run under
"--debug"[2] or "--immediate"[3] (which was introduced after [1]) we
wouldn't re-chmod the object directory. We'd then fail on the next run
since the test setup couldn't remove the trash files.

Instead of some version of reverting [1] let's make the test-lib.sh
resilient to this edge-case, it will happen due to [1], but also
e.g. if the relevant "test-lib.sh" process is kill -9'd during the
test run. We should try harder to recover in this case. If we fail to
remove the test directory let's retry after (re-)chmod-ing it.

This doesn't need to be guarded by something that's equivalent to
"POSIXPERM" since if we don't support "chmod" we were about to fail
anyway. Let's also discard any error output from (a possibly
nonexisting) "chmod", we'll fail on the subsequent "rm -rf"
anyway.

The lack of &&-chaining between the "chmod" and "rm -rf" is
intentional, if we fail the first "rm -rf", can't chmod, but then
succeed the second time around that's what we were hoping for. We just
want to nuke the directory, not carry forward every possible error
code or error message.

1. dbda967684d (t0004 (unwritable files): simplify error handling,
   2010-09-06)
2. 5a4a088add3 (test-lib: do not remove trash_directory if called with
   --debug, 2008-08-21)
3. b586744a864 (test: skip clean-up when running under --immediate
   mode, 2011-06-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index aa1ad8180ed..706ce0cdeb9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1210,10 +1210,10 @@ test_done () {
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
 			cd "$TRASH_DIRECTORY/.." &&
-			rm -fr "$TRASH_DIRECTORY" || {
+			remove_trash_directory "$TRASH_DIRECTORY" || {
 				# try again in a bit
 				sleep 5;
-				rm -fr "$TRASH_DIRECTORY"
+				remove_trash_directory "$TRASH_DIRECTORY"
 			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
@@ -1370,6 +1370,18 @@ then
 	exit 1
 fi
 
+# Try really hard to clean up our mess
+remove_trash_directory() {
+	dir="$1"
+	if ! rm -rf "$dir"
+	then
+		say_color info >&3 "Failed to remove trash directory, trying to re-chmod it first..."
+		chmod -R u+w "$dir" 2>/dev/null
+		rm -rf "$dir"
+	fi
+	! test -d "$dir"
+}
+
 # Are we running this test at all?
 remove_trash=
 this_test=${0##*/}
@@ -1388,7 +1400,7 @@ GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME USER_HOME
 
 # Test repository
-rm -fr "$TRASH_DIRECTORY" || {
+remove_trash_directory "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
-- 
2.33.0.1492.gcc3b81fc59a

