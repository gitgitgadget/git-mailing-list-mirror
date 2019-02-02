Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF241F453
	for <e@80x24.org>; Sat,  2 Feb 2019 13:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfBBNaz (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 08:30:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46019 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfBBNaz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 08:30:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so4279523pgc.12
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 05:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+H0We4XLZtB4Xiyux/kJ+1SstAS03Mak+coluwKVAOU=;
        b=vFyL9u+QQPM0im3+RwcMuEvGm7PHB0WpGbO9CiZk/IX/AvtDfQ7BcdRzj1ugmoXEln
         EW0p3KlPCpRz1TzY0aSocPxxflvUP/cHgHbhhjRmuy4E/Sremo8nwuZ9Jp9YdPEJqL8c
         MQfNAriJjqRYZkN01XNP1qEX5aojhIYytBf0pilD58fRaWcLXv1p7yjEXCDn9byOOtgm
         IMSGJCdoPXytPVe32WUBFmXIb49KUWHNILGIWc37gSMwCHqobGH2QuWUNLA6HrrH3PLR
         34BtUDiy+JKc9f9mJzTwpXt1SSNtWsjr3Evrq084t7vjT9+kgOGq7SK1sWjOQVN8j/lI
         p+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+H0We4XLZtB4Xiyux/kJ+1SstAS03Mak+coluwKVAOU=;
        b=VYyL5aklOOImR5eidzLYVeGVKcAdwNuDgUq94YdgkjK9ajeZY1CYxd3WI+tB51iYcg
         N2St/RgjSGBXRHhH8zAu/JYh75TMyBQqBSihbZ2xWkkhmHrrQwZ3JmUasyd9Bi084S98
         nYNquS3herb94HSv+Ry5WxvmdJE60Pwo+IXJLxFL3PTtlDcTNuMJVgvsuHnDlsabdQKI
         ybJhp55Lnk+oJabE+ScNWietT0wRbR9Ob0ze9VqC8w97aogw1hd8cgBV+f46ZVns6gbm
         lt8oD8PSaFTAdodOdOVf7NACfAI20Z2vTSnDSz3reuYscqSqbbb6dSLc5daMft9db3IR
         w29Q==
X-Gm-Message-State: AHQUAub+OMieOHNBnZDh2FwgTHpuzxzqOBLqLTMWs9f98bElmtd/INDl
        r/KcHGJ49dtPs6e2QcBBElI=
X-Google-Smtp-Source: AHgI3Iav7znUej7as6YFmZawmnQhFLedewwpcftVTXn0h8Uk6BDwejXT8jrdW6lJ/CG9Gjb8grDZtg==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr5941244pgg.347.1549114253908;
        Sat, 02 Feb 2019 05:30:53 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:c5:f1ee:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id t21sm12580010pgg.24.2019.02.02.05.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:30:53 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <16657101987@163.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v10 1/6] t5323: test cases for git-pack-redundant
Date:   Sat,  2 Feb 2019 21:30:12 +0800
Message-Id: <20190202133017.1039-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
References: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
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
 t/t5323-pack-redundant.sh | 467 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 467 insertions(+)
 create mode 100755 t/t5323-pack-redundant.sh

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
new file mode 100755
index 0000000000..f18db06d91
--- /dev/null
+++ b/t/t5323-pack-redundant.sh
@@ -0,0 +1,467 @@
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
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Avoid calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" &&
+	if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
+	then
+		parent=
+	fi &&
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
+	done &&
+	git -C "$repo" update-ref refs/heads/master $oid
+}
+
+# Create pack in <repo> and assign pack id to variable given in the 2nd argument
+# (<name>). Commits in the pack will be read from stdin. E.g.:
+#
+#     create_pack_in <repo> <name> <<-EOF
+#         ...
+#         EOF
+#
+# NOTE: commits from stdin should be given using heredoc, not using pipe, and
+# avoid calling this function from a subshell since variable assignments will
+# disappear when subshell exits.
+create_pack_in () {
+	repo="$1" &&
+	name="$2" &&
+	pack=$(git -C "$repo/objects/pack" pack-objects -q pack) &&
+	eval $name=$pack &&
+	eval P$pack=$name:$pack
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
+test_expect_success 'master: no redundant for pack 1, 2, 3' '
+	create_pack_in "$master_repo" P1 <<-EOF &&
+		$T
+		$A
+		$B
+		$C
+		$D
+		$E
+		$F
+		$R
+		EOF
+	create_pack_in "$master_repo" P2 <<-EOF &&
+		$B
+		$C
+		$D
+		$E
+		$G
+		$H
+		$I
+		EOF
+	create_pack_in "$master_repo" P3 <<-EOF &&
+		$F
+		$I
+		$J
+		$K
+		$L
+		$M
+		EOF
+	(
+		cd "$master_repo" &&
+		git pack-redundant --all >out &&
+		test_must_be_empty out
+	)
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
+test_expect_success 'master: one of pack-2/pack-3 is redundant' '
+	create_pack_in "$master_repo" P4 <<-EOF &&
+		$J
+		$K
+		$L
+		$M
+		$P
+		EOF
+	create_pack_in "$master_repo" P5 <<-EOF &&
+		$G
+		$H
+		$N
+		$O
+		EOF
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
+test_expect_success 'master: pack 2, 4, and 6 are redundant' '
+	create_pack_in "$master_repo" P6 <<-EOF &&
+		$N
+		$O
+		$Q
+		EOF
+	create_pack_in "$master_repo" P7 <<-EOF &&
+		$P
+		$Q
+		EOF
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
+test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
+	create_pack_in "$master_repo" P8 <<-EOF &&
+		$A
+		EOF
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
+test_expect_success 'master: clean loose objects' '
+	(
+		cd "$master_repo" &&
+		git prune-packed &&
+		find objects -type f | sed -e "/objects\/pack\//d" >out &&
+		test_must_be_empty out
+	)
+'
+
+test_expect_success 'master: remove redundant packs and pass fsck' '
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
+test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
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
+test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
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
+test_expect_success 'shared: remove redundant packs, no packs left' '
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
+test_expect_success 'shared: create new objects and packs' '
+	create_commits_in "$shared_repo" X Y Z &&
+	create_pack_in "$shared_repo" Px1 <<-EOF &&
+		$X
+		$Y
+		$Z
+		$A
+		$B
+		$C
+		EOF
+	create_pack_in "$shared_repo" Px2 <<-EOF
+		$X
+		$Y
+		$Z
+		$D
+		$E
+		$F
+		EOF
+'
+
+test_expect_success 'shared: no redundant without --alt-odb' '
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
+test_expect_success 'shared: one pack is redundant with --alt-odb' '
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
+test_expect_success 'shared: ignore unique objects and all two packs are redundant' '
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

