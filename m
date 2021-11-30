Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD21C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbhK3ORn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbhK3ORi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:17:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F10C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:14:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y196so17578012wmc.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BZxLjqDT/my+5AQIdCYmpzFg5ULZcSBkUbu+tlEAe5o=;
        b=htoxMAmxBc1w/OP6+PvEt7jVHtoSn0BtHmqlKPqpOWN2fajXy6QfWqR+de7H7sFpDt
         5HUAdDsOkq9NQlpUmsM0oebkXtg8B/fhj5lv5ebVxv/ZAKZbBsdt9l0G3M1TXzEBYijd
         hTjqTKxnGyLthNgMlrVZ2g6FzJn6gtCVXFmcACbdvMjjhlQOLNMl7uZYGOTtG4H9duWe
         v6FJRl/DdZ26BOGSguWJ/1LuK22CXAjR6GcktqCEAOFxcvqwYW2Mjrn0+1rRQiqHO6k7
         5f/NJUSKJj/QFXUVAdxZliRpktrjbHVOP7z6/5ik0Ypym0ndd8oecH1ebBkeGgIhL0hF
         44HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BZxLjqDT/my+5AQIdCYmpzFg5ULZcSBkUbu+tlEAe5o=;
        b=lHLbG42hRxwUgi5YFf/ASLqX0G2Iga8MR4zGaUFaBAfUhJwUJSZKSZZs8EvmATcWCR
         sfqk3kSJgGiU0QWqcfNMVGYlEB+9HDMDHnD2SDhqk8zl5zeiKeHP8ViuIoZyq9GHv0VG
         JGbK2iZX3gdzpAfuc76AdE562c9KVVbvPbkIGBWrJKOd4Shq6g9NckRVf18oBfcvTxva
         +r2jxL93w1hLYuklEjHkosncEA1b8b60cDHQh3DZQSvKKmJuazEZO+/Z6+EpVTWZQIj7
         rbaSTssDCR3ayA3DiYPEfXoMt8RcVqc/bUG9zgBy5Q1KU7ojnkWweOz2OM67d+KLUgYC
         CDnA==
X-Gm-Message-State: AOAM533Em+N0Z21X7wHOqeUPYhCrbC2872tcBsYlhFjQTMEbPLPMa6rD
        rl6XOfAwpxanqfsRTreJr2ZWzcQOFi8=
X-Google-Smtp-Source: ABdhPJwUcJjfpFWMLdtLEGKAHxknjX6rqQqfOxuq9CKJ7yMRr1achS4JqvUMpqQpO9tde8BvOmurtg==
X-Received: by 2002:a05:600c:6022:: with SMTP id az34mr5434039wmb.22.1638281657316;
        Tue, 30 Nov 2021 06:14:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm22459752wrd.57.2021.11.30.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:14:17 -0800 (PST)
Message-Id: <a0cf71031781b481b092d0f501bc4d78376543f3.1638281655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 14:14:14 +0000
Subject: [PATCH 1/2] t2016: require the PERL prereq only when necessary
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Slavica =?UTF-8?Q?=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The scripted version of the interactive mode of `git add` still requires
Perl, but the built-in version does not. Let's only require the PERL
prereq if testing the scripted version.

This addresses a long-standing NEEDSWORK added in 35166b1fb54 (t2016:
add a NEEDSWORK about the PERL prerequisite, 2020-10-07).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2016-checkout-patch.sh | 42 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index abfd586c32b..71c5a15be00 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -4,7 +4,13 @@ test_description='git checkout --patch'
 
 . ./lib-patch-mode.sh
 
-test_expect_success PERL 'setup' '
+if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN false && ! test_have_prereq PERL
+then
+	skip_all='skipping interactive add tests, PERL not set'
+	test_done
+fi
+
+test_expect_success 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
@@ -18,44 +24,40 @@ test_expect_success PERL 'setup' '
 
 # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
 
-# NEEDSWORK: Since the builtin add-p is used when $GIT_TEST_ADD_I_USE_BUILTIN
-# is given, we should replace the PERL prerequisite with an ADD_I prerequisite
-# which first checks if $GIT_TEST_ADD_I_USE_BUILTIN is defined before checking
-# PERL.
-test_expect_success PERL 'saying "n" does nothing' '
+test_expect_success 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
 	test_write_lines n n | git checkout -p &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
-test_expect_success PERL 'git checkout -p' '
+test_expect_success 'git checkout -p' '
 	test_write_lines n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'git checkout -p with staged changes' '
+test_expect_success 'git checkout -p with staged changes' '
 	set_state dir/foo work index &&
 	test_write_lines n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
 
-test_expect_success PERL 'git checkout -p HEAD with NO staged changes: abort' '
+test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
 	set_and_save_state dir/foo work head &&
 	test_write_lines n y n | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
-test_expect_success PERL 'git checkout -p HEAD with NO staged changes: apply' '
+test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
 	test_write_lines n y y | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'git checkout -p HEAD with change already staged' '
+test_expect_success 'git checkout -p HEAD with change already staged' '
 	set_state dir/foo index index &&
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines n y n | git checkout -p HEAD &&
@@ -63,21 +65,21 @@ test_expect_success PERL 'git checkout -p HEAD with change already staged' '
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'git checkout -p HEAD^...' '
+test_expect_success 'git checkout -p HEAD^...' '
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines n y n | git checkout -p HEAD^... &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
 
-test_expect_success PERL 'git checkout -p HEAD^' '
+test_expect_success 'git checkout -p HEAD^' '
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines n y n | git checkout -p HEAD^ &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
 
-test_expect_success PERL 'git checkout -p handles deletion' '
+test_expect_success 'git checkout -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
 	test_write_lines n y | git checkout -p &&
@@ -90,28 +92,28 @@ test_expect_success PERL 'git checkout -p handles deletion' '
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
 # the failure case (and thus get out of the loop).
 
-test_expect_success PERL 'path limiting works: dir' '
+test_expect_success 'path limiting works: dir' '
 	set_state dir/foo work head &&
 	test_write_lines y n | git checkout -p dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'path limiting works: -- dir' '
+test_expect_success 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
 	test_write_lines y n | git checkout -p -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
+test_expect_success 'path limiting works: HEAD^ -- dir' '
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines y n n | git checkout -p HEAD^ -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
 
-test_expect_success PERL 'path limiting works: foo inside dir' '
+test_expect_success 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines y n n | (cd dir && git checkout -p foo) &&
@@ -119,11 +121,11 @@ test_expect_success PERL 'path limiting works: foo inside dir' '
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'none of this moved HEAD' '
+test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
-test_expect_success PERL 'empty tree can be handled' '
+test_expect_success 'empty tree can be handled' '
 	test_when_finished "git reset --hard" &&
 	git checkout -p $(test_oid empty_tree) --
 '
-- 
gitgitgadget

