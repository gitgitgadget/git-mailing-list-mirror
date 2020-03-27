Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F33C2D0ED
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12C8206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMQ1m1jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgC0AtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38832 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0AtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so9467956wrv.5
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zt+2CXqAsbTAAMaUm+8IRelHfOj3odtzLDFgT1D3YRM=;
        b=MMQ1m1jGYvPY5pGuwInS6+pMvyWYJTrWUR3Pm2xgrtIPWos3vQxcUV7evvvFLW/Ton
         mvWPGqp8C2BSkqIXelMwEuu9GzIuDw6gUtnA/7tz55AC0KloKB05H5Omw5MWFKMN9P7F
         xC96aLGq9kkHpYTPsx9+iiqxst13xAbmU8cJZXnAKxeQSso+ywV4ZkP4bzKT9KK+z0hB
         VnQCKIr5iCBfXnmGOWONvwfKrhtZriPp1NjKJ0kzR0Xy13LTy1s3e/WcDFirhLhfdQQS
         QLkkP8iT9/NzA6IjzUyfJ+0gyjU/mz6VWYosxtwXfNC28fblsMaaS4srcfd0YMVDgcra
         lfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zt+2CXqAsbTAAMaUm+8IRelHfOj3odtzLDFgT1D3YRM=;
        b=Fc4zvZT3UjWCAmCXaH25Ci/taY9kRAZz1D9OzoS+FOiZKqPwt39gmXon5ynoD5IqjZ
         VxQNGgykUygiWnUWWNyhJP4k5WTw9REE0biXlfX+RvV4AsDoOBffQoplAWI8nQE361Y0
         EEiGI/3FsEBvxTXDpkrMpzoiTE7R9roqwlPkwjjpR4vdUD1FeUYjSG4bfmh+PiMVbIB4
         Qh3Rt4MRBp2IrwuCYUob1qBSkyJQNXpoDcJZMJcN8kbD/NNJpLzXuJRgzPRtR8LjM4qC
         wj0omvm31HIghFs7+OEOXzzaT6qrODqqIImDawTx6F3uQr/gBbCzW8WSEQphH+glGj10
         ywkA==
X-Gm-Message-State: ANhLgQ2vSPu1S/9WriXpqNxKcB4I7JKsz2yhHckgefMg7YITUbSzHtQV
        swnsbFkTfGkSP2QpDFgYgscv+ZEX
X-Google-Smtp-Source: ADFU+vu1VPxa5XFIHdPHev/2VfGWwQxY4jdY3uLoKvcFxC9lKqYyk/LeojazYNXPM1+9ierkx4++tw==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr12413555wrn.144.1585270145669;
        Thu, 26 Mar 2020 17:49:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm5693331wru.87.2020.03.26.17.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:05 -0700 (PDT)
Message-Id: <97a95e91d8f2d71df59d7fa9911d8974d2199a38.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:46 +0000
Subject: [PATCH v3 03/18] unpack-trees: simplify verify_absent_sparse()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

verify_absent_sparse() was introduced in commit 08402b0409
("merge-recursive: distinguish "removed" and "overwritten" messages",
2010-08-11), and has always had exactly one caller which always passes
error_type == ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN.  This function
then checks whether error_type is this value, and if so, sets it instead
to ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN.  It has been nearly a decade
and no other caller has been created, and no other value has ever been
passed, so just pass the expected value to begin with.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f72a7a21f9c..3af2e126abf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -506,7 +506,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		ce->ce_flags &= ~CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
-		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
+		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN, o))
 			return -1;
 		ce->ce_flags |= CE_UPDATE;
 	}
@@ -2026,11 +2026,7 @@ static int verify_absent_sparse(const struct cache_entry *ce,
 				enum unpack_trees_error_types error_type,
 				struct unpack_trees_options *o)
 {
-	enum unpack_trees_error_types orphaned_error = error_type;
-	if (orphaned_error == ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN)
-		orphaned_error = ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN;
-
-	return verify_absent_1(ce, orphaned_error, o);
+	return verify_absent_1(ce, error_type, o);
 }
 
 static int merged_entry(const struct cache_entry *ce,
-- 
gitgitgadget

