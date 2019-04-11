Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077EF20248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKNNn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46951 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKNNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so3490147pgv.13
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4a3c9yzyAVoCdmc9ZDXo76dqfSw+dvgUALGk5lrLa2k=;
        b=Z9wNmZ1xFdXTRL3+xaPxGhGzyD94g9d1XNFwsmpvR46EiAX1CKKuRSQXWKjyZQb1xV
         xhmhLxnFnimuxzyxnJ4to5jbnpflFhhW/MeBs1OOYACLaz1VPU9sA2f5mm3QDlWOKgb1
         w/MkZcdqsFTghsjx2hdaMA9QuPIL/FCa6j6sM8WvauwDARYjo0YGH/SXfCDJa1p1uLEO
         lUBVjk9RceD8dxdKcayTdevUqhWjcEUNsKfEepW63OQebt4mWcFLzkZgt6GzWoVrNABG
         2uxqTZfgjZGrFrIztKKKGzg6hTGVDWxtUCDF5uoHwctXx6/NUcjUAvAFz42WDd5gpBLm
         owRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4a3c9yzyAVoCdmc9ZDXo76dqfSw+dvgUALGk5lrLa2k=;
        b=XxbNMS8YXAqfU8EUN8TRU6FLjzkXLK9PYCKCXHNcUIAhSueLdwXKcK0dAOEYf6IBNp
         MqPMgMRN7vui+e6Mrc+srfRQdKAjM2Yvr7zC3TbV/+GtRUKU47YW+wcsBUcpg5c/CiEA
         8tKO8rjVd3yDLFSrm667hfw6gzra9J9hdAfyzJsdubWpSszr9XSZeG2enJGh9ndv5JF6
         CXwFMxWpyoHMrfZEBLWHrUGqe+8wU0tmbxt8N1hlcI+d3cPVPg+XfSPsqk5HsCMztr63
         QnOHo57/DF0x2XEoWS9CmyYP0cs0EG24Q/TQX9NSFff1wmio9UTJbyTXchU/TBeEFX0h
         2BCA==
X-Gm-Message-State: APjAAAVMsBvOdCOB8ZKDPh4GgPAreliwCVr6pa7j1/hnDZk5qfyxIJCG
        /dfEOwPuRIwYxe25Md5soec=
X-Google-Smtp-Source: APXvYqxeLD1+fO59EI/WzG2pGnmjqRYJ776m79s2JMrNKEY0w7eUrF705GIrenJSJ6AhJt3dY4Ja4A==
X-Received: by 2002:a63:e818:: with SMTP id s24mr46725605pgh.190.1554988421922;
        Thu, 11 Apr 2019 06:13:41 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id y23sm55672768pfn.25.2019.04.11.06.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 11/16] t: add tests for restore
Date:   Thu, 11 Apr 2019 20:12:13 +0700
Message-Id: <20190411131218.19195-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/lib-patch-mode.sh               |  12 ++++
 t/t2070-restore.sh (new +x)       |  99 +++++++++++++++++++++++++++
 t/t2071-restore-patch.sh (new +x) | 110 ++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index 06c3c91762..cfd76bf987 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -2,28 +2,40 @@
 
 . ./test-lib.sh
 
+# set_state <path> <worktree-content> <index-content>
+#
+# Prepare the content for path in worktree and the index as specified.
 set_state () {
 	echo "$3" > "$1" &&
 	git add "$1" &&
 	echo "$2" > "$1"
 }
 
+# save_state <path>
+#
+# Save index/worktree content of <path> in the files _worktree_<path>
+# and _index_<path>
 save_state () {
 	noslash="$(echo "$1" | tr / _)" &&
 	cat "$1" > _worktree_"$noslash" &&
 	git show :"$1" > _index_"$noslash"
 }
 
+# set_and_save_state <path> <worktree-content> <index-content>
 set_and_save_state () {
 	set_state "$@" &&
 	save_state "$1"
 }
 
+# verify_state <path> <expected-worktree-content> <expected-index-content>
 verify_state () {
 	test "$(cat "$1")" = "$2" &&
 	test "$(git show :"$1")" = "$3"
 }
 
+# verify_saved_state <path>
+#
+# Call verify_state with expected contents from the last save_state
 verify_saved_state () {
 	noslash="$(echo "$1" | tr / _)" &&
 	verify_state "$1" "$(cat _worktree_"$noslash")" "$(cat _index_"$noslash")"
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
new file mode 100755
index 0000000000..73ea13ede9
--- /dev/null
+++ b/t/t2070-restore.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='restore basic functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first &&
+	echo first-and-a-half >>first.t &&
+	git add first.t &&
+	test_commit second &&
+	echo one >one &&
+	echo two >two &&
+	echo untracked >untracked &&
+	echo ignored >ignored &&
+	echo /ignored >.gitignore &&
+	git add one two .gitignore &&
+	git update-ref refs/heads/one master
+'
+
+test_expect_success 'restore without pathspec is not ok' '
+	test_must_fail git restore &&
+	test_must_fail git restore --source=first
+'
+
+test_expect_success 'restore a file, ignoring branch of same name' '
+	cat one >expected &&
+	echo dirty >>one &&
+	git restore one &&
+	test_cmp expected one
+'
+
+test_expect_success 'restore a file on worktree from another ref' '
+	test_when_finished git reset --hard &&
+	git cat-file blob first:./first.t >expected &&
+	git restore --source=first first.t &&
+	test_cmp expected first.t &&
+	git cat-file blob HEAD:./first.t >expected &&
+	git show :first.t >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'restore a file in the index from another ref' '
+	test_when_finished git reset --hard &&
+	git cat-file blob first:./first.t >expected &&
+	git restore --source=first --staged first.t &&
+	git show :first.t >actual &&
+	test_cmp expected actual &&
+	git cat-file blob HEAD:./first.t >expected &&
+	test_cmp expected first.t
+'
+
+test_expect_success 'restore a file in both the index and worktree from another ref' '
+	test_when_finished git reset --hard &&
+	git cat-file blob first:./first.t >expected &&
+	git restore --source=first --staged --worktree first.t &&
+	git show :first.t >actual &&
+	test_cmp expected actual &&
+	test_cmp expected first.t
+'
+
+test_expect_success 'restore --staged uses HEAD as source' '
+	test_when_finished git reset --hard &&
+	git cat-file blob :./first.t >expected &&
+	echo index-dirty >>first.t &&
+	git add first.t &&
+	git restore --staged first.t &&
+	git cat-file blob :./first.t >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
+	git init unmerged &&
+	(
+		cd unmerged &&
+		echo one >unmerged &&
+		echo one >common &&
+		git add unmerged common &&
+		git commit -m common &&
+		git switch -c first &&
+		echo first >unmerged &&
+		git commit -am first &&
+		git switch -c second master &&
+		echo second >unmerged &&
+		git commit -am second &&
+		test_must_fail git merge first &&
+
+		echo dirty >>common &&
+		test_must_fail git restore . &&
+
+		git restore --ignore-unmerged --quiet . >output 2>&1 &&
+		git diff common >diff-output &&
+		: >empty &&
+		test_cmp empty output &&
+		test_cmp empty diff-output
+	)
+'
+
+test_done
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
new file mode 100755
index 0000000000..98b2476e7c
--- /dev/null
+++ b/t/t2071-restore-patch.sh
@@ -0,0 +1,110 @@
+#!/bin/sh
+
+test_description='git restore --patch'
+
+. ./lib-patch-mode.sh
+
+test_expect_success PERL 'setup' '
+	mkdir dir &&
+	echo parent >dir/foo &&
+	echo dummy >bar &&
+	git add bar dir/foo &&
+	git commit -m initial &&
+	test_tick &&
+	test_commit second dir/foo head &&
+	set_and_save_state bar bar_work bar_index &&
+	save_head
+'
+
+test_expect_success PERL 'restore -p without pathspec is fine' '
+	echo q >cmd &&
+	git restore -p <cmd
+'
+
+# note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
+
+test_expect_success PERL 'saying "n" does nothing' '
+	set_and_save_state dir/foo work head &&
+	test_write_lines n n | git restore -p &&
+	verify_saved_state bar &&
+	verify_saved_state dir/foo
+'
+
+test_expect_success PERL 'git restore -p' '
+	set_and_save_state dir/foo work head &&
+	test_write_lines n y | git restore -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'git restore -p with staged changes' '
+	set_state dir/foo work index &&
+	test_write_lines n y | git restore -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo index index
+'
+
+test_expect_success PERL 'git restore -p --source=HEAD' '
+	set_state dir/foo work index &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines n y n | git restore -p --source=HEAD &&
+	verify_saved_state bar &&
+	verify_state dir/foo head index
+'
+
+test_expect_success PERL 'git restore -p --source=HEAD^' '
+	set_state dir/foo work index &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines n y n | git restore -p --source=HEAD^ &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent index
+'
+
+test_expect_success PERL 'git restore -p handles deletion' '
+	set_state dir/foo work index &&
+	rm dir/foo &&
+	test_write_lines n y | git restore -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo index index
+'
+
+# The idea in the rest is that bar sorts first, so we always say 'y'
+# first and if the path limiter fails it'll apply to bar instead of
+# dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
+# the failure case (and thus get out of the loop).
+
+test_expect_success PERL 'path limiting works: dir' '
+	set_state dir/foo work head &&
+	test_write_lines y n | git restore -p dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'path limiting works: -- dir' '
+	set_state dir/foo work head &&
+	test_write_lines y n | git restore -p -- dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
+	set_state dir/foo work head &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines y n n | git restore -p --source=HEAD^ -- dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent head
+'
+
+test_expect_success PERL 'path limiting works: foo inside dir' '
+	set_state dir/foo work head &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines y n n | (cd dir && git restore -p foo) &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'none of this moved HEAD' '
+	verify_saved_head
+'
+
+test_done
-- 
2.21.0.682.g30d2204636

