Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225CC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 13:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjEBN1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjEBN13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 09:27:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA05587
        for <git@vger.kernel.org>; Tue,  2 May 2023 06:27:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so24392565e9.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683034044; x=1685626044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uktDzCdP4OYrLr62od7DFl+s2SZPRYyuCa+v52eWHD8=;
        b=K6Ia6ZLMTe+ElujZ0Yy+Buv/XRvBMt75WmILEJX79INhm9XQCtCHU0JqBeNAMHUgEn
         8aYsYgtatuX1bXggNx88vEM9+RIRn7z5kfw8LX6+sMHhBskkBjv+80cylhTltDPBjLx2
         XQ/a05irH/P0nvsZLpFGLO1DDMAvuOpaWBWeKNOb7IUqTSY3adfmKwGaPEvuotYEJHGn
         q+aavTnGukYrSHP79vYAiLUoBo+/o66zJES/NRVOlYRDOftE4+5c2vGrWYMECL9CBQZk
         FAGYGAhvaXfvIkEOY5ZR0wCUrDPvOaUHnO5JAgLs7rQn8nGFMVzzwR8FlJrHRxjOCs7z
         j2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683034044; x=1685626044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uktDzCdP4OYrLr62od7DFl+s2SZPRYyuCa+v52eWHD8=;
        b=L7Tnwd+zs1+MxoMbPI/SqSoqQZP6unnT4JD5MHTXc7+M8IW2uezcoZik8KhbuqlvGb
         p+YKXGlvdU/rpHF8EmNys5KR1mRRjbhReHAxfaWjanpXxThqVJdXKVnUpEQIh3cASrZD
         UC9UhzegkJKgIQhTWFBQnLdMrJyKvo1gf5yGYf/2SXCfbpvfveRWvSr6BmjX9c0RSyvR
         bqX7jyQtgDmZ8jhiY/wxZFwaqwHg1UzCD/LoQjfwK1pWp2ub9F0SqoBaSlFLfNRDjxPP
         4eFm+9abnLB1UrzQMhVqPJ2hAQcbl10qI7B25au0Aq8Khrvfsc7GqDL6LwJ/exyxSNqu
         np9g==
X-Gm-Message-State: AC+VfDzz/s8DgQr+qCWi3+d5RkVh0b2ptHQNOgRxEF8prSxvr2oVID2L
        HJR2WWFf84Z0vK7T/ncoX6Oz0Gow8v8=
X-Google-Smtp-Source: ACHHUZ4mo39SeBqp87S5XoqngxLzVL3fRVxr47cuBVMTf3MChliRvesMojLNMPLJXPdjQKx0jzO5wA==
X-Received: by 2002:a05:600c:224a:b0:3f2:4fca:1b0f with SMTP id a10-20020a05600c224a00b003f24fca1b0fmr12595571wmm.24.1683034044541;
        Tue, 02 May 2023 06:27:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ip29-20020a05600ca69d00b003f1712b1402sm38834634wmb.30.2023.05.02.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 06:27:24 -0700 (PDT)
Message-Id: <00789bbc55894a1677b4f1e7722e856d1ec1153f.1683034042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
        <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 May 2023 13:27:22 +0000
Subject: [PATCH v2 2/2] fsck: use local repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In 0d30feef3c5 (fsck: create scaffolding for rev-index checks,
2023-04-17) and later 5a6072f631d (fsck: validate .rev file header,
2023-04-17), the check_pack_rev_indexes() method was created with a
'struct repository *r' parameter. However, this parameter was unused and
instead 'the_repository' was used in its place.

Fix this situation with the obvious replacement.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 75b30d1d00c..dcc165bf0c5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -869,20 +869,20 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	int res = 0;
 
 	if (show_progress) {
-		for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)
+		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
 			pack_count++;
 		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
-	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
 		int load_error = load_pack_revindex_from_disk(p);
 
 		if (load_error < 0) {
 			error(_("unable to load rev-index for pack '%s'"), p->pack_name);
 			res = ERROR_PACK_REV_INDEX;
 		} else if (!load_error &&
-			   !load_pack_revindex(the_repository, p) &&
+			   !load_pack_revindex(r, p) &&
 			   verify_pack_revindex(p)) {
 			error(_("invalid rev-index for pack '%s'"), p->pack_name);
 			res = ERROR_PACK_REV_INDEX;
-- 
gitgitgadget
