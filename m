Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C77211B4
	for <e@80x24.org>; Thu, 10 Jan 2019 12:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfAJMFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 07:05:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39186 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJMFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 07:05:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so5207606pfc.6
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 04:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t76JCUZ11pgI3UdkSSnuP+u5dpdputw/2vmRlfIoS7U=;
        b=V2t2a2S9ZzIteAQGa8Q90mYe9nDZWk4GFgwEy9f6fbhh0gANee7uAUvgqzwG0gw7RG
         TZdN63+4brYXmUma8NMuNWq9PAgOemzR313ucrCPbo8PEv4JM5CyPil5smfFZhel0WJ2
         0GgSCKcuWNcRn0TzW1A/ryn7e4VGZMGhKdqQNrZoUKxAoCFwHSbZoLfocbZvaWPxJBig
         DStY5mH2bO/dDvgN0CCsC7giYT2LY2hvy94QCGuNiHjvetGqQmiUQbVN8IkwDy0JHUB3
         GYz0bPU4rN7eSpleq6GWMebocBX7FxJNA84uGiQP5eDSrHOOlktgY7QiIHAAMwEFyZBC
         stYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t76JCUZ11pgI3UdkSSnuP+u5dpdputw/2vmRlfIoS7U=;
        b=BS79rGDSuQTVXIjKs4OSbM/T1MNrPITuFH2OfkNzB+Rxcmds2bz1/HBDrE/b9YJoTF
         ANLh5dMd7t76S4rEiBPRFf2A6A/GXF1LjjujfDVjuBH8RMgNL2ocuWPwEMgKJ+sJil/k
         s+xdmHtkhNcoZ+i9911kcsrTM/XvCkW/vDtKo46PucukNN642o/CwIMJj7rmWgGakIfH
         MBqXZmbf2cJgY7EwRdIXarC615T6gBLCfOHGXPnKYn1oSlL0l71yrsQFK0C/mbszWQxq
         OVEDpPmOGynl9ZmmRbNmvjmcNHu7qEK7X2M1onWAsvWWtFfAIGwWSDqbBgaH/gJ8hv/f
         nH2Q==
X-Gm-Message-State: AJcUukdfpyClBfXYR/btzuC8R+6Eyh9bwVIGMH5LP0WwAVKIKEoSuLWw
        FHFgWnSb7ml/NBwQX25EpgU=
X-Google-Smtp-Source: ALg8bN5wBZ8U5AhoOwX1FytF84dF6FN6g4Rf8Fyrd1BiyyxY5bBpq5GSGu2Px1LBM2O7cfpnBKignA==
X-Received: by 2002:a63:4745:: with SMTP id w5mr9334928pgk.377.1547121910834;
        Thu, 10 Jan 2019 04:05:10 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.204])
        by smtp.gmail.com with ESMTPSA id b2sm137189403pfm.3.2019.01.10.04.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:05:10 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v5 1/5] t5323: test cases for git-pack-redundant
Date:   Thu, 10 Jan 2019 20:01:38 +0800
Message-Id: <20190110120142.22271-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.101.gc01fadde4e
In-Reply-To: <20190109164731.GJ4673@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
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
 t/t5323-pack-redundant.sh | 157 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100755 t/t5323-pack-redundant.sh

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
new file mode 100755
index 0000000000..7410426dee
--- /dev/null
+++ b/t/t5323-pack-redundant.sh
@@ -0,0 +1,157 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Jiang Xin
+#
+
+test_description='git pack-redundant test'
+
+. ./test-lib.sh
+
+create_commits()
+{
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
+	git update-ref refs/heads/master $M
+}
+
+create_pack_1()
+{
+	P1=$(cd .git/objects/pack; printf "$T\n$A\n$B\n$C\n$D\n$E\n$F\n$R\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P1=P1:$P1
+}
+
+create_pack_2()
+{
+	P2=$(cd .git/objects/pack; printf "$B\n$C\n$D\n$E\n$G\n$H\n$I\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P2=P2:$P2
+}
+
+create_pack_3()
+{
+	P3=$(cd .git/objects/pack; printf "$F\n$I\n$J\n$K\n$L\n$M\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P3=P3:$P3
+}
+
+create_pack_4()
+{
+	P4=$(cd .git/objects/pack; printf "$J\n$K\n$L\n$M\n$P\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P4=P4:$P4
+}
+
+create_pack_5()
+{
+	P5=$(cd .git/objects/pack; printf "$G\n$H\n$N\n$O\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P5=P5:$P5
+}
+
+create_pack_6()
+{
+	P6=$(cd .git/objects/pack; printf "$N\n$O\n$Q\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P6=P6:$P6
+}
+
+create_pack_7()
+{
+	P7=$(cd .git/objects/pack; printf "$P\n$Q\n" | git pack-objects pack 2>/dev/null) &&
+	eval P$P7=P7:$P7
+}
+
+create_pack_8()
+{
+	P8=$(cd .git/objects/pack; printf "$A\n" | git pack-objects pack 2>/dev/null) &&
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
+	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
+		sort -u | \
+		while read p; do eval echo "\${P$p}"; done | \
+		sort >actual && \
+	test_cmp expected actual
+'
+
+test_expect_success 'create pack 6, 7' '
+	create_pack_6 && create_pack_7
+'
+
+cat >expected <<EOF
+P2:$P2
+P4:$P4
+P6:$P6
+EOF
+
+test_expect_success 'pack 2, 4, and 6 are redundant' '
+	git pack-redundant --all >out &&
+	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
+		sort -u | \
+		while read p; do eval echo "\${P$p}"; done | \
+		sort >actual && \
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
+test_expect_success 'pack-8, subset of pack-1, is also redundant' '
+	git pack-redundant --all >out &&
+	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
+		sort -u | \
+		while read p; do eval echo "\${P$p}"; done | \
+		sort >actual && \
+	test_cmp expected actual
+'
+
+test_expect_success 'clear loose objects' '
+	git prune-packed &&
+	find .git/objects -type f | sed -e "/objects\/pack\//d" >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'remove redundant packs' '
+	git pack-redundant --all | xargs rm &&
+	git fsck &&
+	git pack-redundant --all >out &&
+	test_must_be_empty out
+'
+
+test_done
-- 
2.20.1.101.gc01fadde4e

