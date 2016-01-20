From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 11/11] t7063: add tests for core.untrackedCache
Date: Wed, 20 Jan 2016 10:59:44 +0100
Message-ID: <1453283984-8979-12-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpf7-00080T-2R
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000AbcATKGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:39 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36374 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbcATKGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:31 -0500
Received: by mail-wm0-f42.google.com with SMTP id l65so172199236wmf.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hN5mHDNue7hbqt/+rhZfGkDyHoi010O+Ojs7yYR5bTE=;
        b=bISyv9F3bHL/Tl0qufPDK7fGXd3qWE4nkTlxZULUHQVzjlOHLe8s0Y2qJcUzQvwMMt
         eKq2hozi6jfWFljT+FT5+Hd9n5P7lgT82ZLtAI4Cf71f2ASW0/E6jtA6EIVdj8ZbeFEe
         13DL7hahruA/F0QDl+54MAcvy+QZ74gpv8GBiNSDL0U5EaNXnNTRYPAszywZc5jEGfRg
         21SoBS4dKJhChzGU6iwTKbVjMSn4n8365s1A7h0ANo7n/DOd+HLxU7uBpMMFS/WUl9Pi
         MAYpivPQx9mnXNGu6ATQz0uaWZ79e2MVLdTFrvHvH6ZZAuFhn3Te+5/7d/D7hwi3rehC
         5DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hN5mHDNue7hbqt/+rhZfGkDyHoi010O+Ojs7yYR5bTE=;
        b=hv90tlr7KjRjVKx6p9qdCdDO+tmDTaRHx5OPoPYtPRCLecnMaF6WJxVkEwvxs+QY/B
         5XSXTPFA7dm71yDQ3gH+eFgZgj6cJW2IlgyTHcVIhg+5oQmfzqS6xYoQimvvPvncZp7O
         unn8UFKmaTjDLpT+FVgscoMRdqsZYXiKp25RUaExnIz4vvHe3BcU6lY8tyil5Of3AbZY
         nLodBvTHniZHXjyPLGOolOqnWER/CztLlkqA22AJTb1bG9SD3lLxEZisqiGiFoBQqHbr
         kQl0K71rPfjaW6lBwG25RbQKpsZB8yMwHykdi/iyK65c5dVT/edLE6awgyWytc6+1B0r
         mxww==
X-Gm-Message-State: ALoCoQkWg/PG4NkmeJaaPz3pWGRTMOYLlh28s3s4AnqYj7WYvtsKIUNA+is1FezcmtPukDX0ZrMparBSXiY0ym44vtILGE/g/A==
X-Received: by 10.194.95.136 with SMTP id dk8mr36838553wjb.96.1453284389568;
        Wed, 20 Jan 2016 02:06:29 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:28 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284445>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7063-status-untracked-cache.sh | 85 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 253160a..a971884 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,6 +18,10 @@ if ! test_have_prereq UNTRACKED_CACHE; then
 	test_done
 fi
 
+test_expect_success 'core.untrackedCache is unset' '
+	test_must_fail git config --get core.untrackedCache
+'
+
 test_expect_success 'setup' '
 	git init worktree &&
 	cd worktree &&
@@ -30,13 +34,13 @@ test_expect_success 'setup' '
 
 test_expect_success 'untracked cache is empty' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-empty <<EOF &&
 info/exclude 0000000000000000000000000000000000000000
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-empty ../actual
 '
 
 cat >../status.expect <<EOF &&
@@ -506,7 +510,7 @@ EOF
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
@@ -525,7 +529,7 @@ file
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
 two
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-from-test-dump ../actual
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
@@ -569,4 +573,77 @@ EOF
 	test_cmp ../status.expect ../status.actual
 '
 
+test_expect_success '--no-untracked-cache removes the cache' '
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	echo "no untracked cache" >../expect-no-uc &&
+	test_cmp ../expect-no-uc ../actual
+'
+
+test_expect_success 'git status does not change anything' '
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
+	git config core.untrackedCache true &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'using --no-untracked-cache does not fail when core.untrackedCache is true' '
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual &&
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to false and using git status removes the cache' '
+	git config core.untrackedCache false &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual
+'
+
+test_expect_success 'using --untracked-cache does not fail when core.untrackedCache is false' '
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to keep' '
+	git config core.untrackedCache keep &&
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual &&
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-no-uc ../actual &&
+	git update-index --force-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'test ident field is working' '
+	mkdir ../other_worktree &&
+	cp -R done dthree dtwo four three ../other_worktree &&
+	GIT_WORK_TREE=../other_worktree git status 2>../err &&
+	echo "warning: Untracked cache is disabled on this system or location." >../expect &&
+	test_cmp ../expect ../err
+'
+
 test_done
-- 
2.7.0.36.g6be5eef
