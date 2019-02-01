Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E964D1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfBAQWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:22:23 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:36655 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfBAQWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:22:23 -0500
Received: by mail-pl1-f176.google.com with SMTP id g9so3459042plo.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaGzBv+5VAU+O2Rk6mfJvWCTkVs6XhzmtPTIrumhYms=;
        b=eDhAPXQBRMVqOYNISwNPLTxuFp+hevvtztwtuXF9k7SqjjZ6OjObQCLASs9mngoTTb
         9Ab+er6TwnIbt//0l9AUMphr9kR2TTSHXpIqz/23mlAnAGlIEm88P6tgYU8VNBWEQGsa
         8sNETP+rPg64X8U7wSPC5ztP0xhpggMW3A5/Dr3M9XWEu04XBahUNxskxrcNhuv70XMx
         4fqjq4ImDS3MW2vIMVnJlp3aPdXuT4Hjlp4YnL1+ZMf1FpeynqvKze8QwnFMDnL7cxkb
         WBU3TsoVd8qdb0ZkwvTA9DqVsHv9VziUyhLBMW8PoX3SyLQXTHuSHw/I1hbdVboUqWti
         jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaGzBv+5VAU+O2Rk6mfJvWCTkVs6XhzmtPTIrumhYms=;
        b=mKQzTAJSmxMePYKKecgRqEgSOQk9cnyRGThHBrNMA0H/9uoPSeMB2dwHt0SF4atFT4
         Ws5pLU1hCquIw7jF3uCTcc/h/SzWyBLYUwt/pgxykZ2zrKFRddPKurE/M88TrHBGUTUE
         z2MQdNgLizExk585l1MtBrYtadCfvd9FRycDAmNH4KBYo5uRbpRiryiSIchFja5aE6cO
         VRCr6+/oIzlMCe452Q0jdVFQwy9QGjEMWz7vP/09Y+6vOlJZAeTn0hIw/WRoDrDXNs+o
         WrHmmsSBnqpAoIEVXaofJAwZyAkEKOb6LVSyYv2woMbIPsIpKAqyM1MYPBtRz2TSZrX5
         Q1bw==
X-Gm-Message-State: AJcUukePrqZhPiZRiYWXvuqNSyatb1OsC0H13owuZqTo+O2EDxzdmL/T
        RuDBZaMmzO0xHsPXFLLXL7c=
X-Google-Smtp-Source: ALg8bN4+ir5+YcOPNjl42EG5hW+aXPdtkivuwnE/5RZF57+ph1gYXwy3TNRwjN6vn6WRwvZ5aUmxdw==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr40453982plr.15.1549038142562;
        Fri, 01 Feb 2019 08:22:22 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:1:ce70:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id x2sm11872694pfx.78.2019.02.01.08.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 08:22:21 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v9 1/6] t5323: test cases for git-pack-redundant
Date:   Sat,  2 Feb 2019 00:21:47 +0800
Message-Id: <20190201162152.31136-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190130114736.30357-1-worldhello.net@gmail.com>
References: <20190130114736.30357-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add test cases for git pack-redundant to validate new algorithm for git
pack-redundant.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5323-pack-redundant.sh | 510 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 510 insertions(+)
 create mode 100755 t/t5323-pack-redundant.sh

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
new file mode 100755
index 0000000000..d224ff3c50
--- /dev/null
+++ b/t/t5323-pack-redundant.sh
@@ -0,0 +1,510 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Jiang Xin
+#
+
+test_description='Test git pack-redundant
+
+In order to test git-pack-redundant, we will create a number of objects and
+packs in the repository `master.git`. The relationship between packs (P1-P8)
+and objects (T, A-R) is showed in the following chart. Objects of a pack will
+be marked with letter x, while objects of redundant packs will be marked with
+exclamation point, and redundant pack itself will be marked with asterisk.
+
+        | T A B C D E F G H I J K L M N O P Q R
+    ----+--------------------------------------
+    P1  | x x x x x x x                       x
+    P2* |     ! ! ! !   ! ! !
+    P3  |             x     x x x x x
+    P4* |                     ! ! ! !     !
+    P5  |               x x           x x
+    P6* |                             ! !   !
+    P7  |                                 x x
+    P8* |   !
+    ----+--------------------------------------
+    ALL | x x x x x x x x x x x x x x x x x x x
+
+Another repository `shared.git` has unique objects (X-Z), while other objects
+(marked with letter s) are shared through alt-odb (of `master.git`). The
+relationship between packs and objects is as follows:
+
+        | T A B C D E F G H I J K L M N O P Q R   X Y Z
+    ----+----------------------------------------------
+    Px1 |   s s s                                 x x x
+    Px2 |         s s s                           x x x
+'
+
+. ./test-lib.sh
+
+master_repo=master.git
+shared_repo=shared.git
+
+# Note: DO NOT run it in a subshell, otherwise the variables will not be set
+# Usage: create_commits_in <repo> A B C ...
+create_commits_in () {
+	repo="$1" &&
+	parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null) || parent=
+	T=$(git -C "$repo" write-tree) &&
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		test_tick &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git -C "$repo" commit-tree $T)
+		else
+			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid &&
+		shift ||
+		return 1
+	done
+	git -C "$repo" update-ref refs/heads/master $oid
+}
+
+# Note: DO NOT run it in a subshell, otherwise the variables will not be set
+create_pack_1 () {
+	P1=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$T
+		$A
+		$B
+		$C
+		$D
+		$E
+		$F
+		$R
+		EOF
+	) &&
+	eval P$P1=P1:$P1
+}
+
+create_pack_2 () {
+	P2=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$B
+		$C
+		$D
+		$E
+		$G
+		$H
+		$I
+		EOF
+	) &&
+	eval P$P2=P2:$P2
+}
+
+create_pack_3 () {
+	P3=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$F
+		$I
+		$J
+		$K
+		$L
+		$M
+		EOF
+	) &&
+	eval P$P3=P3:$P3
+}
+
+create_pack_4 () {
+	P4=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$J
+		$K
+		$L
+		$M
+		$P
+		EOF
+	) &&
+	eval P$P4=P4:$P4
+}
+
+create_pack_5 () {
+	P5=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$G
+		$H
+		$N
+		$O
+		EOF
+	) &&
+	eval P$P5=P5:$P5
+}
+
+create_pack_6 () {
+	P6=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$N
+		$O
+		$Q
+		EOF
+	) &&
+	eval P$P6=P6:$P6
+}
+
+create_pack_7 () {
+	P7=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$P
+		$Q
+		EOF
+	) &&
+	eval P$P7=P7:$P7
+}
+
+create_pack_8 () {
+	P8=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
+		$A
+		EOF
+	) &&
+	eval P$P8=P8:$P8
+}
+
+format_packfiles () {
+	sed \
+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
+		-e "s#.*/pack-\(.*\)\.pack#\1#" |
+	sort -u |
+	while read p
+	do
+		if test -z "$(eval echo \${P$p})"
+		then
+			echo $p
+		else
+			eval echo "\${P$p}"
+		fi
+	done |
+	sort
+}
+
+test_expect_success 'setup master repo' '
+	git init --bare "$master_repo" &&
+	create_commits_in "$master_repo" A B C D E F G H I J K L M N O P Q R
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#         | T A B C D E F G H I J K L M N O P Q R
+#     ----+--------------------------------------
+#     P1  | x x x x x x x                       x
+#     P2  |     x x x x   x x x
+#     P3  |             x     x x x x x
+#     ----+--------------------------------------
+#     ALL | x x x x x x x x x x x x x x         x
+#
+#############################################################################
+test_expect_success 'no redundant for pack 1, 2, 3' '
+	create_pack_1 && create_pack_2 && create_pack_3 &&
+	(
+		cd "$master_repo" &&
+		git pack-redundant --all >out &&
+		test_must_be_empty out
+	)
+'
+
+test_expect_success 'create pack 4, 5' '
+	create_pack_4 && create_pack_5
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#         | T A B C D E F G H I J K L M N O P Q R
+#     ----+--------------------------------------
+#     P1  | x x x x x x x                       x
+#     P2* |     ! ! ! !   ! ! !
+#     P3  |             x     x x x x x
+#     P4  |                     x x x x     x
+#     P5  |               x x           x x
+#     ----+--------------------------------------
+#     ALL | x x x x x x x x x x x x x x x x x   x
+#
+#############################################################################
+test_expect_success 'one of pack-2/pack-3 is redundant' '
+	(
+		cd "$master_repo" &&
+		cat >expect <<-EOF &&
+			P2:$P2
+			EOF
+		git pack-redundant --all >out &&
+		format_packfiles <out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'create pack 6, 7' '
+	create_pack_6 && create_pack_7
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#         | T A B C D E F G H I J K L M N O P Q R
+#     ----+--------------------------------------
+#     P1  | x x x x x x x                       x
+#     P2* |     ! ! ! !   ! ! !
+#     P3  |             x     x x x x x
+#     P4* |                     ! ! ! !     !
+#     P5  |               x x           x x
+#     P6* |                             ! !   !
+#     P7  |                                 x x
+#     ----+--------------------------------------
+#     ALL | x x x x x x x x x x x x x x x x x x x
+#
+#############################################################################
+test_expect_success 'pack 2, 4, and 6 are redundant' '
+	(
+		cd "$master_repo" &&
+		cat >expect <<-EOF &&
+			P2:$P2
+			P4:$P4
+			P6:$P6
+			EOF
+		git pack-redundant --all >out &&
+		format_packfiles <out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'create pack 8' '
+	create_pack_8
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#         | T A B C D E F G H I J K L M N O P Q R
+#     ----+--------------------------------------
+#     P1  | x x x x x x x                       x
+#     P2* |     ! ! ! !   ! ! !
+#     P3  |             x     x x x x x
+#     P4* |                     ! ! ! !     !
+#     P5  |               x x           x x
+#     P6* |                             ! !   !
+#     P7  |                                 x x
+#     P8* |   !
+#     ----+--------------------------------------
+#     ALL | x x x x x x x x x x x x x x x x x x x
+#
+#############################################################################
+test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
+	(
+		cd "$master_repo" &&
+		cat >expect <<-EOF &&
+			P2:$P2
+			P4:$P4
+			P6:$P6
+			P8:$P8
+			EOF
+		git pack-redundant --all >out &&
+		format_packfiles <out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'clean loose objects' '
+	(
+		cd "$master_repo" &&
+		git prune-packed &&
+		find objects -type f | sed -e "/objects\/pack\//d" >out &&
+		test_must_be_empty out
+	)
+'
+
+test_expect_success 'remove redundant packs and pass fsck' '
+	(
+		cd "$master_repo" &&
+		git pack-redundant --all | xargs rm &&
+		git fsck &&
+		git pack-redundant --all >out &&
+		test_must_be_empty out
+	)
+'
+
+# The following test cases will execute inside `shared.git`, instead of
+# inside `master.git`.
+test_expect_success 'setup shared.git' '
+	git clone --mirror "$master_repo" "$shared_repo" &&
+	(
+		cd "$shared_repo" &&
+		printf "../../$master_repo/objects\n" >objects/info/alternates
+	)
+'
+
+test_expect_success 'no redundant packs without --alt-odb' '
+	(
+		cd "$shared_repo" &&
+		git pack-redundant --all >out &&
+		test_must_be_empty out
+	)
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#     ================ master.git ===============
+#         | T A B C D E F G H I J K L M N O P Q R  <----------+
+#     ----+--------------------------------------             |
+#     P1  | x x x x x x x                       x             |
+#     P3  |             x     x x x x x                       |
+#     P5  |               x x           x x                   |
+#     P7  |                                 x x               |
+#     ----+--------------------------------------             |
+#     ALL | x x x x x x x x x x x x x x x x x x x             |
+#                                                             |
+#                                                             |
+#     ================ shared.git ===============             |
+#         | T A B C D E F G H I J K L M N O P Q R  <objects/info/alternates>
+#     ----+--------------------------------------
+#     P1* | s s s s s s s                       s
+#     P3* |             s     s s s s s
+#     P5* |               s s           s s
+#     P7* |                                 s s
+#     ----+--------------------------------------
+#     ALL | x x x x x x x x x x x x x x x x x x x
+#
+#############################################################################
+test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
+	(
+		cd "$shared_repo" &&
+		cat >expect <<-EOF &&
+			P1:$P1
+			P3:$P3
+			P5:$P5
+			P7:$P7
+			EOF
+		git pack-redundant --all --verbose >out 2>out.err &&
+		test_must_be_empty out &&
+		grep "pack$" out.err | format_packfiles >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remove redundant packs by alt-odb, no packs left' '
+	(
+		cd "$shared_repo" &&
+		cat >expect <<-EOF &&
+			fatal: Zero packs found!
+			EOF
+		git pack-redundant --all --alt-odb | xargs rm &&
+		git fsck &&
+		test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
+# Note: DO NOT run function `create_pack_*` in sub shell, or variables are not set
+create_pack_x1_in () {
+	repo="$1" &&
+	Px1=$(git -C "$repo/objects/pack" pack-objects -q pack <<-EOF
+		$X
+		$Y
+		$Z
+		$A
+		$B
+		$C
+		EOF
+	) &&
+	eval P${Px1}=Px1:${Px1}
+}
+
+create_pack_x2_in () {
+	repo="$1" &&
+	Px2=$(git -C "$repo/objects/pack" pack-objects -q pack <<-EOF
+		$X
+		$Y
+		$Z
+		$D
+		$E
+		$F
+		EOF
+	) &&
+	eval P${Px2}=Px2:${Px2}
+}
+
+test_expect_success 'create new objects and packs in shared.git' '
+	create_commits_in "$shared_repo" X Y Z &&
+	create_pack_x1_in "$shared_repo" &&
+	create_pack_x2_in "$shared_repo"
+'
+
+test_expect_success 'no redundant without --alt-odb' '
+	(
+		cd "$shared_repo" &&
+		git pack-redundant --all >out &&
+		test_must_be_empty out
+	)
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#     ================ master.git ===============
+#         | T A B C D E F G H I J K L M N O P Q R  <----------------+
+#     ----+--------------------------------------                   |
+#     P1  | x x x x x x x                       x                   |
+#     P3  |             x     x x x x x                             |
+#     P5  |               x x           x x                         |
+#     P7  |                                 x x                     |
+#     ----+--------------------------------------                   |
+#     ALL | x x x x x x x x x x x x x x x x x x x                   |
+#                                                                   |
+#                                                                   |
+#     ================ shared.git =======================           |
+#         | T A B C D E F G H I J K L M N O P Q R   X Y Z <objects/info/alternates>
+#     ----+----------------------------------------------
+#     Px1 |   s s s                                 x x x
+#     Px2*|         s s s                           ! ! !
+#     ----+----------------------------------------------
+#     ALL | s s s s s s s s s s s s s s s s s s s   x x x
+#
+#############################################################################
+test_expect_success 'one pack is redundant' '
+	(
+		cd "$shared_repo" &&
+		git pack-redundant --all --alt-odb >out &&
+		format_packfiles <out >actual &&
+		test_line_count = 1 actual
+	)
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#     ================ master.git ===============
+#         | T A B C D E F G H I J K L M N O P Q R  <----------------+
+#     ----+--------------------------------------                   |
+#     P1  | x x x x x x x                       x                   |
+#     P3  |             x     x x x x x                             |
+#     P5  |               x x           x x                         |
+#     P7  |                                 x x                     |
+#     ----+--------------------------------------                   |
+#     ALL | x x x x x x x x x x x x x x x x x x x                   |
+#                                                                   |
+#                                                                   |
+#     ================ shared.git =======================           |
+#         | T A B C D E F G H I J K L M N O P Q R   X Y Z <objects/info/alternates>
+#     ----+----------------------------------------------
+#     Px1*|   s s s                                 i i i
+#     Px2*|         s s s                           i i i
+#     ----+----------------------------------------------
+#     ALL | s s s s s s s s s s s s s s s s s s s   i i i
+#                                                  (ignored objects, marked with i)
+#
+#############################################################################
+test_expect_success 'set ignore objects and all two packs are redundant' '
+	(
+		cd "$shared_repo" &&
+		cat >expect <<-EOF &&
+			Px1:$Px1
+			Px2:$Px2
+			EOF
+		git pack-redundant --all --alt-odb >out <<-EOF &&
+			$X
+			$Y
+			$Z
+			EOF
+		format_packfiles <out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.20.1.103.ged0fc2ca7b

