Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B481B20193
	for <e@80x24.org>; Mon, 24 Oct 2016 23:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbcJXXkr (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 19:40:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32919 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbcJXXkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 19:40:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id i127so4244225oia.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 16:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7mod4cI4uQbj3kifDM2KRrrjne6duj+Go/A1NIy8dw=;
        b=xkg2mPee2T3RfwfktG2+54PVQf4C5LJZ1byqchVOLTxganU+UZwD14XphTCS9J7BZv
         b23y6IZRDtuCYFs5blVmq1TCmi3zIB6YVb/PLW7XV/If/3RGcKckqXKWC98fCP9nP+dw
         3mhX0oaToylWVypTy6TluDDPwpr/9JNPQYjzFNWMuymmhLOq5o3xC8rTb8K2JcJvbMdo
         ljriAoTZQPJtn9kLOBxITbWGtlf6XUSwc+uHlX5QEYGiYgo+WfJkal06nZbtwcdETvZ7
         tTJ1xSCUb8jaQ7yrdsYj7/8vJWivc9YTCIRWVd0oP8Ylro7X0kxVfOENVZCh5apZCASr
         sX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7mod4cI4uQbj3kifDM2KRrrjne6duj+Go/A1NIy8dw=;
        b=J722PD8cn70VUTRWovtrNujaH5uatRx35ZVHtFcMBOz7izg6UR7Mk0hARbLiQtwlFY
         LrwVgFrBdPQao461+DpreWpsFYlfo75FzdpojntBqwR2VkqHKwHiDNskb6HfBW4twpZh
         vx+aLpYJde4/oVaGytJfN2+nU3gA6AyqT98pa+rNZT0lSGCYXDHoenYhI4hjv/bktvys
         z3xuMMyOBdIdudJHfEv0Xl2vV/1QkpbsxYI8NE+Ph72T7ctqnFK85+hHMnN5krR+dSsq
         sPy6J4Om5NvzRvAyufz8tg9WNmne7BxFOnGrg0ZJciZ0s37J4hkIzrFuC6VGe0wd9sua
         3vkg==
X-Gm-Message-State: ABUngvf1ea8LsxF2hV2xvxznELoi+xuCGURiqbtJoyqeoFJ1841QAXXrWVDVajEXQ8P4kA==
X-Received: by 10.36.14.201 with SMTP id 192mr114953ite.35.1477352445488;
        Mon, 24 Oct 2016 16:40:45 -0700 (PDT)
Received: from localhost.localdomain.localdomain (cpe-66-67-97-212.nycap.res.rr.com. [66.67.97.212])
        by smtp.gmail.com with ESMTPSA id g127sm169147itc.7.2016.10.24.16.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 16:40:44 -0700 (PDT)
From:   Aaron M Watson <watsona4@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron M Watson <watsona4@gmail.com>,
        Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] Allow stashes to be referenced by index only
Date:   Mon, 24 Oct 2016 19:40:13 -0400
Message-Id: <1477352413-4628-1-git-send-email-watsona4@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of referencing "stash@{n}" explicitly, it can simply be
referenced as "n".  Most users only reference stashes by their position
in the stash stask (what I refer to as the "index"). The syntax for the
typical stash (stash@{n}) is slightly annoying and easy to forget, and
sometimes difficult to escape properly in a script. Because of this the
capability to do things with the stash by simply referencing the index
is desirable.

This patch includes the superior implementation provided by Øsse Walle
(thanks for that), with a slight change to fix a broken test in the test
suite. I also merged the test scripts as suggested by Jeff King, and
un-wrapped the documentation as suggested by Junio Hamano.

Signed-off-by: Aaron M Watson <watsona4@gmail.com>
---
 Documentation/git-stash.txt |  3 ++-
 git-stash.sh                | 15 +++++++++++++--
 t/t3903-stash.sh            | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 92df596..2e9cef0 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -39,7 +39,8 @@ The latest stash you created is stored in `refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
 the usual reflog syntax (e.g. `stash@{0}` is the most recently
 created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
-is also possible).
+is also possible). Stashes may also be referenced by specifying just the
+stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
 OPTIONS
 -------
diff --git a/git-stash.sh b/git-stash.sh
index 826af18..d7072c8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -384,9 +384,8 @@ parse_flags_and_rev()
 	i_tree=
 	u_tree=
 
-	REV=$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
-
 	FLAGS=
+	REV=
 	for opt
 	do
 		case "$opt" in
@@ -404,6 +403,9 @@ parse_flags_and_rev()
 					die "$(eval_gettext "unknown option: \$opt")"
 				FLAGS="${FLAGS}${FLAGS:+ }$opt"
 			;;
+			*)
+				REV="${REV}${REV:+ }'$opt'"
+			;;
 		esac
 	done
 
@@ -422,6 +424,15 @@ parse_flags_and_rev()
 		;;
 	esac
 
+	case "$1" in
+		*[!0-9]*)
+			:
+		;;
+		*)
+			set -- "${ref_stash}@{$1}"
+		;;
+	esac
+
 	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
 		reference="$1"
 		die "$(eval_gettext "\$reference is not a valid reference")"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2142c1f..f82a8c4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -131,6 +131,26 @@ test_expect_success 'drop middle stash' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'drop middle stash by index' '
+	git reset --hard &&
+	echo 8 >file &&
+	git stash &&
+	echo 9 >file &&
+	git stash &&
+	git stash drop 1 &&
+	test 2 = $(git stash list | wc -l) &&
+	git stash apply &&
+	test 9 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git reset --hard &&
+	git stash drop &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
@@ -604,7 +624,21 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash drop
 '
 
+test_expect_success 'invalid ref of the form "n", n >= N' '
+	git stash clear &&
+	test_must_fail git stash drop 0 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
+	git add file2 &&
+	git stash &&
+	test_must_fail git stash drop 1 &&
+	test_must_fail git stash pop 1 &&
+	test_must_fail git stash apply 1 &&
+	test_must_fail git stash show 1 &&
+	test_must_fail git stash branch tmp 1 &&
+	git stash drop
+'
+
 test_expect_success 'stash branch should not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
-- 
2.7.4

