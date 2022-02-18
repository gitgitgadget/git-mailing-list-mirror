Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB71C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiBRUoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:44:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiBRUoT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:44:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C13483B4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:44:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p9so16402080wra.12
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g29fdIK5OaCTcDwrm7b5aMnFg+b82968jiukJxdETIg=;
        b=epVmBlVbT64CYPJZMZWVm5OoFGaUXoQKpEE87ACcQxUPHIOcXbc6ojzbdImVWXZGMA
         1YVo5qWbr8ILKMApwYqmF4txxH1NSnhxUc7mTR9bil8DmbwxynJSdvMxF066Wt2irvmG
         z7ir5Js3IXZrPcjoAkStsPcToNtQY1LGnk9syxZ6diZ1paFh8Y92oLcipSHhMgL9nuYu
         wmzRANdB6e9C3v6J/BXEVqB2bvS9p3gqmz9HXH4mVm9t+QBnqLDWVqwWdz6t1D4INFDy
         hiDMvekX9XVoZfbMhpjWJEf+PmVmWX8yNAcY+ypwxYw4K1OZ0t6EPUunY4lQ1tcIMt5r
         EBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g29fdIK5OaCTcDwrm7b5aMnFg+b82968jiukJxdETIg=;
        b=Z1PHh/6DO0qd3kE5xlIr9iG4EKw7obx3lkMCIJRnlhu9OHQJT9JpFyd8mrPlTn6Y6n
         Ph3kXhFVPjc7277GSnu5so9q+lcxFMzXHbDqhEy7OZUc58ffKPdLMhp0zwdCB/Ie/wma
         k+QWEuMCT/YhSbFvFAxFPcXMgCH5FEtaKbDCkQwGhYaHguDL0+Egjz8/DayMDQKgp/jN
         zP9501RBFWnm2091Wp253lWLnB0yXbGcCZtFGInoQLJobGr7IlJgX2Bno07TPncJ9vOD
         mM3T9m6fJ6HPv2TZ+2PIMZxhxzkJLqHNxNuQjkaBOjofg75WeG0jbJQ0tDNdRqAdODBZ
         6S5A==
X-Gm-Message-State: AOAM532oivPCjNW4uXiptbxP+1D4I4Swk/iIQS2sBVUeTmidMsiLUyxs
        LuSZESePZmzXZNhnkG4ze/d1tL7gd+kDDQ==
X-Google-Smtp-Source: ABdhPJxuCKO1vDzMqtNXCRzMfJr+YnCRJyghGctlEcVk56ruohjHr1pEXYM6pu2QdpJA+Vx1qR3EOA==
X-Received: by 2002:a5d:51c1:0:b0:1e3:45bf:da38 with SMTP id n1-20020a5d51c1000000b001e345bfda38mr7137694wrv.144.1645217041172;
        Fri, 18 Feb 2022 12:44:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c14sm4680239wru.37.2022.02.18.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:44:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] merge: don't run post-hook logic on --no-verify
Date:   Fri, 18 Feb 2022 21:43:51 +0100
Message-Id: <patch-1.2-9b5144daee6-20220218T203834Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
In-Reply-To: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a minor bug introduced in bc40ce4de61 (merge: --no-verify to
bypass pre-merge-commit hook, 2019-08-07), when that change made the
--no-verify option bypass the "pre-merge-commit" hook it didn't update
the corresponding find_hook() (later hook_exists()) condition.

As can be seen in the preceding commit in 6098817fd7f (git-merge:
honor pre-merge-commit hook, 2019-08-07) the two should go hand in
hand. There's no point in invoking discard_cache() here if the hook
couldn't have possibly updated the index.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 133831d42fd..fab553e3bc4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -845,15 +845,18 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
-		abort_commit(remoteheads, NULL);
-	/*
-	 * Re-read the index as pre-merge-commit hook could have updated it,
-	 * and write it out as a tree.  We must do this before we invoke
-	 * the editor and after we invoke run_status above.
-	 */
-	if (hook_exists("pre-merge-commit"))
-		discard_cache();
+	if (!no_verify) {
+		if (run_commit_hook(0 < option_edit, index_file,
+				    "pre-merge-commit", NULL))
+			abort_commit(remoteheads, NULL);
+		/*
+		 * Re-read the index as pre-merge-commit hook could have updated it,
+		 * and write it out as a tree.  We must do this before we invoke
+		 * the editor and after we invoke run_status above.
+		 */
+		if (hook_exists("pre-merge-commit"))
+			discard_cache();
+	}
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
-- 
2.35.1.1031.g277d4562d2e

