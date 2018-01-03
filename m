Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CB21F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeACBMp (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:12:45 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33940 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeACBMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:12:42 -0500
Received: by mail-it0-f65.google.com with SMTP id m11so12640611iti.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b6goWZdhGhrzuzSG2BdADtY2XGEAOBvg1pFtN6uHNwE=;
        b=jL2hp9jENE8WXmEZVpLI9lSlkhaQ2N2VbiVYlJttM4n5KLCx9Yj1KEC+tTf7ao9JPA
         0d6GDxcaAdHrtCuwj7spDkHmn6juK9/wr9r7B59Tlj9BNg8dTPGOYYZdwma+iPAknCMA
         Fr+v6TOQ+d35yl6K3GniBUCF5C3T7wO8DuceIEEyRnq8dCPRuIploC0+LJHKgGEDtmhg
         t5VeLF0whSFmWgRMBwazxVyGfrMteZpJS/4GZ0KBtdwYhxP2yyH/LgkeBSXJvOV94mUU
         MGS2XCYZkn4Qov8kGAF4HlVKI6AA28a+fiyD8gFzDj6z8YWnWGjldweudYWUKmlp6CeC
         LO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b6goWZdhGhrzuzSG2BdADtY2XGEAOBvg1pFtN6uHNwE=;
        b=VSLeRt7BKF3oMIGG1Co10NhxqrxSr1VYe6KQCyvnTWmnS+arYS74SDr8V74zrBW/4U
         HaXL0pn9dVFTEes+UdRTKt3/rQ9BiSz3RfyqBdb8Sk3xg77fNmwceQ2+BLQBkLARd+jd
         q9MzBKmt1tb4kcysaEpXpDv/kPsE0LwD4akjv0PpyIou8THV/nPP3s7Q5lamTfQozgma
         L+XvUxNgogIxRExSNGtYIPSIjRx5Ujes94osahfTyEefmRXaLzLS3+I2WCfXxntgwJjJ
         HxESP+U8gADB+JmnHPf1//rwcr3Zsf/nli7HJ5tu8JhpPFFFj5dZ/fNVV0cseUrfiVBx
         uI8g==
X-Gm-Message-State: AKGB3mJCQc6uW5lR2bDpKjnu79xSU8IxA+oBmEGjSDggV52eZmTjjcPp
        ixftqxKIGU4N/uCPytGO5dNZpA==
X-Google-Smtp-Source: ACJfBoviV9/gNWT92OR0PlYq8icP28a3uj7tjC2Vmy49y4o951r6jRR2guVnow2g6UW3eLC4tY8f5Q==
X-Received: by 10.36.224.207 with SMTP id c198mr93502ith.141.1514941961093;
        Tue, 02 Jan 2018 17:12:41 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w6sm57299itc.5.2018.01.02.17.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 17:12:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 5/5] submodule: submodule_move_head omits old argument in forced case
Date:   Tue,  2 Jan 2018 17:12:26 -0800
Message-Id: <20180103011226.160185-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103011226.160185-1-sbeller@google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
 <20180103011226.160185-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using hard reset or forced checkout with the option to recurse into
submodules, the submodules need to be reset, too.

It turns out that we need to omit the duplicate old argument to read-tree
in all forced cases to omit the 2 way merge and use the more assertive
behavior of reading the specific new tree into the index and updating
the working tree.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index fa25888783..db0f7ac51e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1653,7 +1653,9 @@ int submodule_move_head(const char *path,
 	else
 		argv_array_push(&cp.args, "-m");
 
-	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
+		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+
 	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
 
 	if (run_command(&cp)) {
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb0173ea87..1f38a85371 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1015,4 +1015,18 @@ test_submodule_forced_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
+
+	test_expect_success "$command: changed submodule worktree is reset" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			rm sub1/file1 &&
+			: >sub1/new_file &&
+			git -C sub1 add new_file &&
+			$command HEAD &&
+			test_path_is_file sub1/file1 &&
+			test_path_is_missing sub1/new_file
+		)
+	'
 }
-- 
2.15.1.620.gb9897f4670-goog

