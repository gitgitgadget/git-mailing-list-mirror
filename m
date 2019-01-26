Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868351F453
	for <e@80x24.org>; Sat, 26 Jan 2019 20:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAZUvG (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 15:51:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAZUvG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 15:51:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so9924712wmt.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8vG8/46ExJkrXbvChwtuYGy1qMXioW6XwG14U3wnuU=;
        b=kkeF4Ns9Xnc5PyggfqNmNSlCVDkf00voERUugbnRkdCpuGNfOfODe/SU4g6glwAFtG
         HVyUttB1VJsoXZCdwlt5tQTtIl3DWe5fuL0li/F5xJnLSnMLhWtEieOk0I9FCS0re2kr
         fgKrbt04c+/uMdfwabjXO2dzfDcztsSUj//BBKhO6Aj6cDQD4tF7rbi5jJUigIaU4qPh
         lSD3Kf1Qhqhp49a9u/pI8fjKf+RsYN3BwdJti2HES263J37O0Ix5VLcf4UesxNeLzMeA
         REjwuM4H7OEJ9iRqHI5GF3VA0L72S3w9xJZTnnM5BzzpAkiU/1BfHC/sb7yASdXRqUca
         D1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8vG8/46ExJkrXbvChwtuYGy1qMXioW6XwG14U3wnuU=;
        b=YGux7mRHMCitzZdHT8cSxbdIV0qE0T1EVFYbXUihnObF/V6xO81wPEY1nIFwfzdPGp
         PCanwHiBkMAXniSBmCLGMSxxYaRLlYl2I9dLUSjw7nVTnXyCq/IH2Rxzm6iEMkfAsjOv
         OBzWniNRXrMywLZeXh+GCWG2wH3vwo9NaGtBaakx9y+x1o5NjMjTehwyvouAV2I1OYEp
         bNBmD1fxVWdsdri68um5dPeNe0UktEaV/JTKzNj2KN8J1P9TUA2W9pjZEg3nEyZQ7yrm
         +Sdu8TPIbGo2JOuDIu/cx/Bei8aceRg50R9YsdBEbCREbcR3UC12S5cVkl0DgQv6/2yW
         nB3Q==
X-Gm-Message-State: AJcUukfjGqN0ikM2AULozZHPoi1KHPZFNemQOn/0NFpyGG1P5QaZnxBN
        s1G1+l1/HFeEZu14q1vofUPCV0zaFvE=
X-Google-Smtp-Source: ALg8bN7zjzX1gvm22fsQRkPrHww9/Xv5qQq7czOjtEc02u6rECQc6W5irJQHOme20VSc1WTsR19eLg==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr11219973wmj.142.1548535863685;
        Sat, 26 Jan 2019 12:51:03 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id m21sm48049415wmi.43.2019.01.26.12.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Jan 2019 12:51:02 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v2 1/3] Add tests for describe with --work-tree
Date:   Sat, 26 Jan 2019 21:49:49 +0100
Message-Id: <20190126204951.42455-1-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dirty ones are already passing, but just because describe is comparing
with the wrong working tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index d639d94696..9a6bd1541f 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -28,6 +28,24 @@ check_describe () {
 	'
 }
 
+check_describe_worktree () {
+  cd "$TEST_DIRECTORY"
+	expect="$1"
+	shift
+	R=$(git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe "$@" 2>err.actual)
+	S=$?
+	cat err.actual >&3
+	test_expect_success "describe with --work-tree $*" '
+	test $S = 0 &&
+	case "$R" in
+	$expect)	echo happy ;;
+	*)	echo "Oops - $R is not $expect";
+		false ;;
+	esac
+	'
+  cd "$TRASH_DIRECTORY"
+}
+
 test_expect_success setup '
 
 	test_tick &&
@@ -145,14 +163,20 @@ check_describe A-* HEAD
 
 check_describe "A-*[0-9a-f]" --dirty
 
+check_describe_worktree "A-*[0-9a-f]" --dirty
+
 test_expect_success 'set-up dirty work tree' '
 	echo >>file
 '
 
 check_describe "A-*[0-9a-f]-dirty" --dirty
 
+check_describe_worktree "A-*[0-9a-f]-dirty" --dirty
+
 check_describe "A-*[0-9a-f].mod" --dirty=.mod
 
+check_describe_worktree "A-*[0-9a-f].mod" --dirty=.mod
+
 test_expect_success 'describe --dirty HEAD' '
 	test_must_fail git describe --dirty HEAD
 '
-- 
2.20.1

