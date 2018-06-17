Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD321F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeFQF7L (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:11 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40523 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753576AbeFQF7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id f79-v6so12189640oib.7
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ENYz9gjvq/WxjsvmYAD02s2X3gipAtlgV6IksgFRLOc=;
        b=lOcIykCuhcI597oTLbrXJB1+lrh2MMUVOUbtcWUJpkkMl2sQYrVfGW8mqHUNvoJAir
         SLSUxzvg/VFhxVph67APyHboc2YphZRLgT+YH9uyCvmPXJ+7kR+2w2fXUaiAUGBeBMBo
         HoyKPMmsXPQ+uz5SORzdMzpVVZN3zRMLKtInkLUNhm3UlTlUxT/SJ31ei+y+EkmZ1y06
         IUIN3hU3jOALEZU0RLwDGIR5txV9G5KtK470dCbSiazeSs0Ng/B1Xsvlrv6cQTeIstDt
         EMwXkFVkFfWs02WHDB/TdSTeQBjANC4ai3Vi2hIbT47+muXm/J5Ry/cdrpPxKztGzMqy
         KVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ENYz9gjvq/WxjsvmYAD02s2X3gipAtlgV6IksgFRLOc=;
        b=jRinwLJuxDI2FdmRm+WqndIKWUD9S/cBLGY/BgwqsRFWxa60AujJtIUmeuqGRT5kNC
         /EAepCjeSiD7IcCqawxGSRahsks8qPnhp7iW+egwoJNMRQTl+vqhbCwruzdbcmttZsPO
         GNLihFvYrq80z8h61vd+NTJZiRVYCvW8PO7vIO1I5DTnliPxxyv4nhs5KLQlIeRnc+3v
         W7CH4JTw7XwCFTB1C8DiHdmvL/D6lVmwjwZwgiKkYowS+HUTb1UE7ENitmMLEn3z24B3
         3Ha307gigtAhgVY6RrjOIe/zdTWN/sB9arsvmAW4GKzYT3PUIGcOQjxaIHWPMbMTBSl2
         L4pw==
X-Gm-Message-State: APt69E1wHs+Xem5GLLPOgUJN7ZG6TU8y7LfEmUrI9xwKGhdWMEyuD19u
        idjUHfPcCs1TumVkIuz0VA035Q==
X-Google-Smtp-Source: ADUXVKLqQMVZqW3DJaYVrN5lPnCjg74X1wXbRoEKJg0nkwU+4102GMM75Vpi7CbgTAToTkl0F+mH2w==
X-Received: by 2002:aca:f244:: with SMTP id q65-v6mr4752026oih.71.1529215147007;
        Sat, 16 Jun 2018 22:59:07 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:06 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 3/7] t3422: new testcases for checking when incompatible options passed
Date:   Sat, 16 Jun 2018 22:58:52 -0700
Message-Id: <20180617055856.22838-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase is split into three types: am, merge, and interactive.  Various
options imply different types, and which mode we are using determine which
sub-script (git-rebase--$type) is executed to finish the work.  Not all
options work with all types, so add tests for combinations where we expect
to receive an error rather than having options be silently ignored.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3422-rebase-incompatible-options.sh | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t3422-rebase-incompatible-options.sh

diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
new file mode 100755
index 0000000000..04cdae921b
--- /dev/null
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='test if rebase detects and aborts on incompatible options'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_seq 2 9 >foo &&
+	git add foo &&
+	git commit -m orig &&
+
+	git branch A &&
+	git branch B &&
+
+	git checkout A &&
+	test_seq 1 9 >foo &&
+	git add foo &&
+	git commit -m A &&
+
+	git checkout B &&
+	# This is indented with HT SP HT.
+	echo "	 	foo();" >>foo &&
+	git add foo &&
+	git commit -m B
+'
+
+#
+# Rebase has lots of useful options like --whitepsace=fix, which are
+# actually all built in terms of flags to git-am.  Since neither
+# --merge nor --interactive (nor any options that imply those two) use
+# git-am, using them together will result in flags like --whitespace=fix
+# being ignored.  Make sure rebase warns the user and aborts instead.
+#
+
+test_run_rebase () {
+	opt=$1
+	shift
+	test_expect_failure "$opt incompatible with --merge" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --merge A
+	"
+
+	test_expect_failure "$opt incompatible with --strategy=ours" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --strategy=ours A
+	"
+
+	test_expect_failure "$opt incompatible with --strategy-option=ours" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --strategy=ours A
+	"
+
+	test_expect_failure "$opt incompatible with --interactive" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --interactive A
+	"
+
+	test_expect_failure "$opt incompatible with --exec" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --exec 'true' A
+	"
+
+}
+
+test_run_rebase --whitespace=fix
+test_run_rebase --ignore-whitespace
+test_run_rebase --committer-date-is-author-date
+test_run_rebase -C4
+
+test_done
-- 
2.18.0.rc2.1.g5453d3f70b.dirty

