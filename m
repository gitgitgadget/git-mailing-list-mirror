Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FDD1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeAEUDT (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:03:19 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45938 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbeAEUDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:03:14 -0500
Received: by mail-pl0-f68.google.com with SMTP id o2so3629451plk.12
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N5hWUJxHaF4q871GhNVJvcDimoSc7kr51X70OsmQE90=;
        b=OEb2cRNJYuWvQWwBOMrIOzpnbzIYwDEAtrMoXEYo3zyxmlYxXOLgZSWVZ/m+G7MKMN
         ZOcE/8+9ZMsNJ4GCznIrhyHOGsvRF/yTrTd5VvaavqHtVUrcFwrdCSBH1FofcO0SnFDk
         Qwn7XqGUmYAX3aXQECXpw8XcDxJqrD6JClXO9Jilsar0OZoXzPX1/Gw/ixnL7xZxFgnU
         S6JHhq6OTZWOI9rs0fNrTydmsTA0YxDeKsNBGSBGbVBBoF2XqrSQQuvFIxBcfyBJhnYW
         iNrL34X9z5E9P62+UVYGwiYEGhwf+zgUrobW9u9SkSSfL4WwqPDoCY34cHVVQhC1d9mO
         B36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N5hWUJxHaF4q871GhNVJvcDimoSc7kr51X70OsmQE90=;
        b=cUyv36XYs7ZmUmeO/dRYEm48TNzSLcCx/IvjOl6PrK+yyNoHI/fhLBKdMQOrxNFAV2
         Ojnd+JaiB3PjpLvi+ImfKStanyBlEDGgW1wpa8+w7xD7G9KLMM3XL1YrouG2XYx7I5QV
         8/Uni5E97nRpnNwZE0RHovbj/hxo5/4WM3bUEKrxvJNgTp7M2s2NWnbY/PeAuXlTQRDk
         G35kTewMyniNqBIaDiobwvf9mONDjZ5EU4/dyQ5Jpyhf9+NqndoAsziBJibA7axuYZAq
         krvcuFAgMZ6OteDBXneJrzwlSmBFAXTXBSzt7AHd7eIoblpSJwQJEhbeNAN39iekcd5X
         yuTA==
X-Gm-Message-State: AKGB3mKxDVbQ0hwK3sKSwbJvvSOyoEpk/ZG9ta4pAXGcmSRVqRFb4YEK
        gszCOUu57Ya2+V8PjFoyUzCwhA==
X-Google-Smtp-Source: ACJfBovELSDWFTx0yhSZC8xdFf/y6rSUuyNEPA71YkAquldbSOf0wfHZLQwiuluyVN3Nz1ewSBuA1g==
X-Received: by 10.84.247.141 with SMTP id o13mr4131404pll.285.1515182593993;
        Fri, 05 Jan 2018 12:03:13 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a23sm13100177pfa.177.2018.01.05.12.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:03:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/4] submodule: submodule_move_head omits old argument in forced case
Date:   Fri,  5 Jan 2018 12:03:04 -0800
Message-Id: <20180105200304.34173-5-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180105200304.34173-1-sbeller@google.com>
References: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
 <20180105200304.34173-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 2967704317..47ddc9b273 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1657,7 +1657,9 @@ int submodule_move_head(const char *path,
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
2.16.0.rc0.223.g4a4ac83678-goog

