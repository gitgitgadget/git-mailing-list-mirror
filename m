Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB08C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbiFNT1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiFNT1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:27:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834811A0A
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so12609556wrb.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ovwh48JS+zXXejB+qWQus7s/m8HrzCWv9GDjfY+y+H8=;
        b=YGqtZvTWKgzgIaqWytH8V/3qEFPsoczXOmwszbAU9P6zBc4Xpw5ZIwN3b5I/kv72nV
         /e5lP2le9lZecpxyLg7yIfgyBw+M6ZmAABjNW9CjNbxXJs6MK1lTa53aDKi7kMv/t5dV
         EDfdVQrBOUTE4CSpC2rvHB+gMMqN0wiyfS33PTuuMgwohJ9ffDhteZATYsinW/hgqePl
         hzSsI/Kf4uxgLiDiAJvtEdBjywJ8wOq8VmmXH1M5zYBgPR53A4lKkL3+swF/jLBLxvim
         zKql026q5TFDTuR0Rfa7l5R5TXkEo4A8hr0Ydld7Qf2ueA8EqkUqS1VGU0tyAH1Tiz7y
         /V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ovwh48JS+zXXejB+qWQus7s/m8HrzCWv9GDjfY+y+H8=;
        b=TTUxCUNomAeEBJO3eOT7RPtagcTczl4+//EOsi35y/ipx39OLR7C5VWGOoYHOhKxrx
         RufCx/yXkuPE6jched4wib6xyV2yktpuMMrU0RC24ExJLdJOb1yyfvkBidGMuaaHZK+h
         U0MDRJOUY4kgCZJOef6KI3eNETAay79zaIfKjyr5PCr8m3KRYZP80Od7niEbzfB+EBM+
         EsQVLcc7jV7Z2+3GFbrSv1JhlJvxVWjw3KngYNW2beeu/RSaa9dM+DzMuhxuayIr6Htz
         V0FqzYSnJtPblf82mou2sxXuJCikMEX3AHOntLKBhy7/8pVge+Cp+7PBY8vqdK3UHBFz
         senQ==
X-Gm-Message-State: AJIora8XCHpPJA++QW/fxQGK4rpsvwQKEC+aH9z7ikOsgQPAAbOsae4c
        p9tgE4Ki+/xYc2Sf8jnuer4/um12Tzia2A==
X-Google-Smtp-Source: AGRyM1vRL+kYyPaXKqvZMtRaj9ys0fYg4Wd4mhLfORhPFnPUKkPRmHAif5PW+nIPYJiFBW5xgQYP4w==
X-Received: by 2002:a5d:47a7:0:b0:218:5a5d:6c55 with SMTP id 7-20020a5d47a7000000b002185a5d6c55mr6230582wrb.192.1655234859907;
        Tue, 14 Jun 2022 12:27:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az21-20020a05600c601500b0039c871d3191sm13296019wmb.3.2022.06.14.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:27:39 -0700 (PDT)
Message-Id: <d7e63f9dfd608d7d00c08bb57b03310a884b2e8e.1655234853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 19:27:32 +0000
Subject: [PATCH v2 4/5] branch: use branch_checked_out() when deleting refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This is the last current use of find_shared_symref() that can easily be
replaced by branch_checked_out(). The benefit of this switch is that the
code is a bit simpler, but also it is faster on repeated calls.

The remaining uses of find_shared_symref() are non-trivial to remove, so
we probably should not continue in that direction:

* builtin/notes.c uses find_shared_symref() with "NOTES_MERGE_REF"
  instead of "HEAD", so it doesn't have an immediate analogue with
  branch_checked_out(). Perhaps we should consider extending it to
  include that symref in addition to HEAD, BISECT_HEAD, and
  REBASE_HEAD.

* receive-pack.c checks to see if a worktree has a checkout for the ref
  that is being updated. The tricky part is that it can actually decide
  to update the worktree directly instead of just skipping the update.
  This all depends on the receive.denyCurrentBranch config option. The
  implementation currenty cares about receiving the worktree in the
  result, so the current branch_checked_out() prototype is insufficient
  currently. This is something to investigate later, though, since a
  large number of refs could be updated at the same time and using the
  strmap implementation of branch_checked_out() could be beneficial.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/branch.c          | 7 +++----
 t/t2407-worktree-heads.sh | 5 ++++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5d00d0b8d32..f875952e7b5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -253,12 +253,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		name = mkpathdup(fmt, bname.buf);
 
 		if (kinds == FILTER_REFS_BRANCHES) {
-			const struct worktree *wt =
-				find_shared_symref(worktrees, "HEAD", name);
-			if (wt) {
+			const char *path;
+			if ((path = branch_checked_out(name))) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
-				      bname.buf, wt->path);
+				      bname.buf, path);
 				ret = 1;
 				continue;
 			}
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 1fbde05fe2b..a5aec1486c5 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -37,7 +37,10 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	for i in 1 2 3 4
 	do
 		test_must_fail git branch -f wt-$i HEAD 2>err
-		grep "cannot force update the branch" err || return 1
+		grep "cannot force update the branch" err &&
+
+		test_must_fail git branch -D wt-$i 2>err
+		grep "Cannot delete branch" err || return 1
 	done
 '
 
-- 
gitgitgadget

