Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304561F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfA3Ls1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:48:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42828 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfA3Ls0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:48:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so11290565pfr.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4mCFShSB5uTtLAK36KATSzV3V0UU4pt5G+drub79MU=;
        b=ZDdXlgQl/ffE9ait+7bzaDeBti599lWsDehtfDffB5pu1acohdhxRWdF9+gIlZidb9
         mTSrYx2RZ+XTWMB5mBbUpwAOjBlQhO9j2C1vZbFVLWLrmYQi02B4mAIB9XknTGjOZ7iN
         tzKw++W77ngtvCCZGYFzO1nAGD8YugK3UcBAcjMcO3fC9n9E7N8uwZaz8RhfofFjs84C
         aE4cxcptEcmnH9o93mxxScokNxc3VsJi+Y/h3acYXXDVulC0uc/mXfsMhNpF8ZEojv3z
         QZ23KCfu1MxUZke7AOhFwQbYVnYp75avVtUgyKvCI+EaTZmaBKRr6zYpnIFsV+OhQl59
         K/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4mCFShSB5uTtLAK36KATSzV3V0UU4pt5G+drub79MU=;
        b=nc09maTo8JLI24V7pNnJEDIpa/qBwd5TnJ3dNKcUAvzreVnb72QTb4s6tY7sz1+XSY
         yI9G+spsbUm4UP5RWC8swCQhkAuMAGlyx4IjWBcIKVb5XEoPMi4l/+/ihL6lGtJE6G9O
         p/NxVvGel3pyO84MjERinWMDVg/j/yNgCHoe1UYWSBRJw1M+0PXHMTDQO2rzHwIPFsSq
         8Rq+bRX/7Y92b/ykmN+AYGhWtJ9nOV2FRj69kBeLAqXAdaK/fX2TCMLQrLF732trRPSB
         O3L6HGl8TyuQOmAPJPU6+xKqbcPIlsDPqTduzd91QzxB8KE7HT6EEG4CKJAr3K93F0Bj
         BEFQ==
X-Gm-Message-State: AJcUukcAv/BHmlonmVW9rILhBv8KsONrJpykL9Ve13WOrnsS/7qACwSA
        sM+qwgrtTUiWeSeq9Rn3C6I=
X-Google-Smtp-Source: ALg8bN6PEphX4LAGO7atZQ9djX6iOiuI4efngCj4jU1LF0KqTr7Duw5CcUifH6PP6FcyWj8jxPG25g==
X-Received: by 2002:a63:8043:: with SMTP id j64mr27725480pgd.405.1548848905389;
        Wed, 30 Jan 2019 03:48:25 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:48:24 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
Date:   Wed, 30 Jan 2019 19:47:31 +0800
Message-Id: <20190130114736.30357-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5323-pack-redundant.sh | 322 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 322 insertions(+)
 create mode 100755 t/t5323-pack-redundant.sh

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
new file mode 100755
index 0000000000..710fe9884c
--- /dev/null
+++ b/t/t5323-pack-redundant.sh
@@ -0,0 +1,322 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Jiang Xin
+#
+
+test_description='git pack-redundant test'
+
+. ./test-lib.sh
+
+create_commits () {
+	parent=
+	for name in A B C D E F G H I J K L M N O P Q R
+	do
+		test_tick &&
+		T=$(git write-tree) &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git commit-tree $T)
+		else
+			oid=$(echo $name | git commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid ||
+		return 1
+	done
+	git update-ref refs/heads/master $R
+}
+
+create_pack_1 () {
+	P1=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+	P2=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+	P3=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+	P4=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+	P5=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+	P6=$(git -C objects/pack pack-objects -q pack <<-EOF
+		$N
+		$O
+		$Q
+		EOF
+	) &&
+	eval P$P6=P6:$P6
+}
+
+create_pack_7 () {
+	P7=$(git -C objects/pack pack-objects -q pack <<-EOF
+		$P
+		$Q
+		EOF
+	) &&
+	eval P$P7=P7:$P7
+}
+
+create_pack_8 () {
+	P8=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+test_expect_success 'setup master.git' '
+	git init --bare master.git &&
+	cd master.git &&
+	create_commits
+'
+
+test_expect_success 'no redundant for pack 1, 2, 3' '
+	create_pack_1 && create_pack_2 && create_pack_3 &&
+	git pack-redundant --all >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'create pack 4, 5' '
+	create_pack_4 && create_pack_5
+'
+
+cat >expected <<EOF
+P2:$P2
+EOF
+
+test_expect_success 'one of pack-2/pack-3 is redundant' '
+	git pack-redundant --all >out &&
+	format_packfiles <out >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'create pack 6, 7' '
+	create_pack_6 && create_pack_7
+'
+
+# Only after calling create_pack_6, we can use $P6 variable.
+cat >expected <<EOF
+P2:$P2
+P4:$P4
+P6:$P6
+EOF
+
+test_expect_success 'pack 2, 4, and 6 are redundant' '
+	git pack-redundant --all >out &&
+	format_packfiles <out >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'create pack 8' '
+	create_pack_8
+'
+
+cat >expected <<EOF
+P2:$P2
+P4:$P4
+P6:$P6
+P8:$P8
+EOF
+
+test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
+	git pack-redundant --all >out &&
+	format_packfiles <out >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'clean loose objects' '
+	git prune-packed &&
+	find objects -type f | sed -e "/objects\/pack\//d" >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'remove redundant packs and pass fsck' '
+	git pack-redundant --all | xargs rm &&
+	git fsck --no-progress &&
+	git pack-redundant --all >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'setup shared.git' '
+	cd "$TRASH_DIRECTORY" &&
+	git clone -q --mirror master.git shared.git &&
+	cd shared.git &&
+	printf "../../master.git/objects" >objects/info/alternates
+'
+
+test_expect_success 'no redundant packs without --alt-odb' '
+	git pack-redundant --all >out &&
+	test_must_be_empty out
+'
+
+cat >expected <<EOF
+P1:$P1
+P3:$P3
+P5:$P5
+P7:$P7
+EOF
+
+test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
+	git pack-redundant --all --verbose >out 2>out.err &&
+	test_must_be_empty out &&
+	grep "pack$" out.err | format_packfiles >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+fatal: Zero packs found!
+EOF
+
+test_expect_success 'remove redundant packs by alt-odb, no packs left' '
+	git pack-redundant --all --alt-odb | xargs rm &&
+	git fsck --no-progress &&
+	test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
+	test_cmp expected actual
+'
+
+create_commits_others () {
+	parent=$(git rev-parse HEAD)
+	for name in X Y Z
+	do
+		test_tick &&
+		T=$(git write-tree) &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git commit-tree $T)
+		else
+			oid=$(echo $name | git commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid ||
+		return 1
+	done
+	git update-ref refs/heads/master $Z
+}
+
+create_pack_x1 () {
+	Px1=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+create_pack_x2 () {
+	Px2=$(git -C objects/pack pack-objects -q pack <<-EOF
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
+test_expect_success 'new objects and packs in shared.git' '
+	create_commits_others &&
+	create_pack_x1 &&
+	create_pack_x2 &&
+	git pack-redundant --all >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'one pack is redundant' '
+	git pack-redundant --all --alt-odb >out &&
+	format_packfiles <out >actual &&
+	test_line_count = 1 actual
+'
+
+cat >expected <<EOF
+Px1:$Px1
+Px2:$Px2
+EOF
+
+test_expect_success 'set ignore objects and all two packs are redundant' '
+	git pack-redundant --all --alt-odb >out <<-EOF &&
+		$X
+		$Y
+		$Z
+		EOF
+	format_packfiles <out >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.20.1.103.ged0fc2ca7b

