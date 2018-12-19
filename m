Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30381F405
	for <e@80x24.org>; Wed, 19 Dec 2018 12:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeLSMPF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 07:15:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45798 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSMPF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 07:15:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so18850064ota.12
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GV6AoTMF1HqRtZ3u1CauuFkkwx8IdAOFc2CY6PD1Sjo=;
        b=YAFzh8xbY4Sa3DM7YWh+8yf/HkYuljnj4b8sVEdIbcOOWTN4hCOD1kKMJYDRTnA6hD
         ZJp4LSrERTCGGQY5TOIObVOQyjGqz+2u132ptnMw5f9O//x9IxECWbD3QqEgvv4mo+np
         FKYqEVXHiX5vFchtsneHBqxmvymiIaUOlgDosj0dnMFnNG/quKfTS0/Axwwe8ZmKF4aa
         d1HPshxWKZ0nzJyNT8hPKQ03GjlNbyLxzKAYiGba6T2wyRYGbECAut6Pl106ZrQ0GWqB
         QIA68Zn0Qb+FttheviT7Cslv3GTg1fm1NCYDeA5TWqbPSsgK9aKOqdqoFlaq3nzUpWDL
         pdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV6AoTMF1HqRtZ3u1CauuFkkwx8IdAOFc2CY6PD1Sjo=;
        b=imwbB87Y1xQ9aCVsIrZEKswTN7khn+sKQdYxYBVlPNXg8vifEV6CUqHJcoQM1ABVPK
         GuCgrfT5RV4C23JIjtafy9lgJvq5RL6Dy7AjP9XtI4eK1LRlbRVS7zCyoLKfJG4aE9bl
         2UCKyrAE5iz9lu/ncM9dqH7b9MyekI23ms3xbdnIlBFtHrFRTlcQoQiG5+s8HZ1nNhbm
         IUbRCCTS/yLQkqZDhVTHKbMIjsyaNlgFs4lhkQNWSgYDgxx5u1T8K7UvMCHiyt4JUhqi
         NdOjaYWWETQjTM9gV+VD/AZThpZ9ENFTf43o+JNMHNhXcO+RPzPt9QWO1KgL5kbDODci
         Oq5A==
X-Gm-Message-State: AA+aEWacWtBj3+7RDzTJv2+MJJwEIYwjaeVM9JAeGMZ4h5+OFscVVKuC
        OS828EJUB406IrBqRCHNcKO5HC4gd4M=
X-Google-Smtp-Source: AFSGD/W4ELFkjeySKsIObUszOgqVB4wtr2CQ+Xk7Qa2vo/n089Q+XMPsPHGiFgBxVG7SgTIF2zOv7w==
X-Received: by 2002:a9d:6552:: with SMTP id q18mr15123584otl.128.1545221704150;
        Wed, 19 Dec 2018 04:15:04 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.9])
        by smtp.gmail.com with ESMTPSA id e128sm8826357oia.5.2018.12.19.04.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:15:03 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/3] t5322: test cases for git-pack-redundant
Date:   Wed, 19 Dec 2018 20:14:49 +0800
Message-Id: <20181219121451.21697-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181218095829.20092-2-worldhello.net@gmail.com>
References: <20181218095829.20092-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add test cases for git pack-redundant to validate new algorithm for git
pack-redundant.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5322-pack-redundant.sh | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t5322-pack-redundant.sh

diff --git a/t/t5322-pack-redundant.sh b/t/t5322-pack-redundant.sh
new file mode 100755
index 0000000000..4add9c2bb1
--- /dev/null
+++ b/t/t5322-pack-redundant.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Jiang Xin
+#
+
+test_description='git redundant test'
+
+. ./test-lib.sh
+
+create_commits()
+{
+	set -e
+	parent=
+	for name in A B C D E F G H I J K L M
+	do
+		test_tick
+		T=$(git write-tree)
+		if test -z "$parent"
+		then
+			sha1=$(echo $name | git commit-tree $T)
+		else
+			sha1=$(echo $name | git commit-tree -p $parent $T)
+		fi
+		eval $name=$sha1
+		parent=$sha1
+	done
+	git update-ref refs/heads/master $M
+}
+
+create_redundant_packs()
+{
+	set -e
+	cd .git/objects/pack
+	P1=$(printf "$T\n$A\n" | git pack-objects pack 2>/dev/null)
+	P2=$(printf "$T\n$A\n$B\n$C\n$D\n$E\n" | git pack-objects pack 2>/dev/null)
+	P3=$(printf "$C\n$D\n$F\n$G\n$I\n$J\n" | git pack-objects pack 2>/dev/null)
+	P4=$(printf "$D\n$E\n$G\n$H\n$J\n$K\n" | git pack-objects pack 2>/dev/null)
+	P5=$(printf "$F\n$G\n$H\n" | git pack-objects pack 2>/dev/null)
+	P6=$(printf "$F\n$I\n$L\n" | git pack-objects pack 2>/dev/null)
+	P7=$(printf "$H\n$K\n$M\n" | git pack-objects pack 2>/dev/null)
+	P8=$(printf "$L\n$M\n" | git pack-objects pack 2>/dev/null)
+	cd -
+}
+
+# Create commits and packs
+create_commits
+create_redundant_packs
+
+test_expect_success 'clear loose objects' '
+	git prune-packed &&
+	test $(find .git/objects -type f | grep -v pack | wc -l) -eq 0
+'
+
+printf "$P1\n$P4\n$P5\n$P6\n" | sort >expected
+
+test_expect_success 'git pack-redundant --all' '
+	git pack-redundant --all | \
+		sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \
+		sort -u >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'remove redundant packs' '
+	git pack-redundant --all | xargs rm &&
+	git fsck &&
+	test $(git pack-redundant --all | wc -l) -eq 0
+'
+
+test_done
-- 
2.20.0.3.gc45e608566

