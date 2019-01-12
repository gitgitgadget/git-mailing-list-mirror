Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ABA211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbfALJTw (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 04:19:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44897 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJTv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 04:19:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so8068506pfh.11
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 01:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkDoI077mh9aXMKVqvFdgvydrMZO+FeWk3DMwuQmf/0=;
        b=ELT42xJ5rKiRC2orD0ZjSzCmnfLbywCAxUKEhH5sFNIzLRpUo//19+2yQUbFXFZpkl
         71UA1oDS/MNgwQG8gjT3pM+il3TNktLK0VCHcI6ZDsLq/2exTbpNZ4m2h3saGReH7QL1
         ARK+Ja+CycCdCAgNc1ITSIBBvxesUZbqNzVYrH7OEYGeCihWHkE0YjvOumOXMrWivCrt
         2L5HhruxbpkSVrERkfe1ED23JIDIsiZQjsVW+XrEHG9cWtwUgpgWNZ6B1kIhm4tMXeVc
         ZOlPmOluvpcmSpS/I8nfyliNaOvJ2Gmn+nGvjX8q9MRmkHpeJg/ID4zAN+VwprlFV87p
         lL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkDoI077mh9aXMKVqvFdgvydrMZO+FeWk3DMwuQmf/0=;
        b=VFr8TYL35CsFdN0ccHuwcNzLpL/8LdCaTAHwf9Mh+IW7VSNdbTtSDgadjnMcpzYXzQ
         FzQL3glu3SwhfTfFlfNJ2srfirh93OaaE2ZJhujZ9/r+R+pGLQMHDEHHt25A3EPFyhmH
         R+r7DwqvKVuUTDf6DTubyc8uBHa2B7oaGeLH+RjkrunP8gvHKB7NMkSHw0METFb6YFbJ
         OLv5PNQZ/YkXFKeLbrEndbB7A7ccw7cYciFmPnRsjGidPwvtunrvgA80E6odUjgU1bBa
         eb6YMQkBt0nXGxYcIFgbWmWPYJozNlgM5NBUJD/NbI3fxedButuA1lqje6uN3HzUCGhC
         /qwQ==
X-Gm-Message-State: AJcUukedtLlGXxmE0YgdPQmJI4fBvjkgHWllTF97L9FwSJvAGSzZcBwo
        S/RcBVzI7NAHQlzK9PwI4xg=
X-Google-Smtp-Source: ALg8bN7gHpIZNrpcVDZz2EoHhneoi0qkMx5w0uej2lG7JILAPeAqqif4qy3NtANfSKqgMd2ftCQjlw==
X-Received: by 2002:a62:2702:: with SMTP id n2mr18273179pfn.29.1547284790790;
        Sat, 12 Jan 2019 01:19:50 -0800 (PST)
Received: from localhost.localdomain ([221.222.155.87])
        by smtp.gmail.com with ESMTPSA id i5sm27685510pfg.34.2019.01.12.01.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:19:50 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 1/5] t5323: test cases for git-pack-redundant
Date:   Sat, 12 Jan 2019 17:17:50 +0800
Message-Id: <20190112091754.30985-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20190110120142.22271-1-worldhello.net@gmail.com>
References: <20190110120142.22271-1-worldhello.net@gmail.com>
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
---
 t/t5323-pack-redundant.sh | 207 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100755 t/t5323-pack-redundant.sh

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
new file mode 100755
index 0000000000..407838f0e8
--- /dev/null
+++ b/t/t5323-pack-redundant.sh
@@ -0,0 +1,207 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Jiang Xin
+#
+
+test_description='git pack-redundant test'
+
+. ./test-lib.sh
+
+create_commits() {
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
+create_pack_1() {
+	P1=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
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
+create_pack_2() {
+	P2=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
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
+create_pack_3() {
+	P3=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
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
+create_pack_4() {
+	P4=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
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
+create_pack_5() {
+	P5=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
+		$G
+		$H
+		$N
+		$O
+		EOF
+	) &&
+	eval P$P5=P5:$P5
+}
+
+create_pack_6() {
+	P6=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
+		$N
+		$O
+		$Q
+		EOF
+	) &&
+	eval P$P6=P6:$P6
+}
+
+create_pack_7() {
+	P7=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
+		$P
+		$Q
+		EOF
+	) &&
+	eval P$P7=P7:$P7
+}
+
+create_pack_8() {
+	P8=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
+		$A
+		EOF
+	) &&
+	eval P$P8=P8:$P8
+}
+
+test_expect_success 'setup' '
+	create_commits
+'
+
+test_expect_success 'no redundant packs' '
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
+	sed \
+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
+		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
+		sort -u |
+		while read p; do eval echo "\${P$p}"; done |
+		sort >actual &&
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
+	sed \
+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
+		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
+		sort -u |
+		while read p; do eval echo "\${P$p}"; done |
+		sort >actual &&
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
+	sed \
+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
+		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
+		sort -u |
+		while read p; do eval echo "\${P$p}"; done |
+		sort >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'clean loose objects' '
+	git prune-packed &&
+	find .git/objects -type f | sed -e "/objects\/pack\//d" >out &&
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
+test_done
-- 
2.20.0.3.gc45e608566

