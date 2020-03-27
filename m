Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A3CC2D0ED
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA057206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQTD4Rvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgC0AtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45292 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgC0AtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so9415095wrw.12
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pmWJR9CFy0G549gUQSywKDSK51q+vKpVHdR5OKt//mI=;
        b=CQTD4RvfO85nIo1VMZAaBe+udX17QP0DmWCr3EO0fw3Cdem35gm9IrmupStChQir78
         1lW8+hcVy1mhBSG4iRHcI/wAyoTe8A65pP/yEbwCdCz28n/n/FDdHHB2LUSSS+7nZDNm
         21IhZuXBFQXZ25so9aGvpm5OOF4ZPXFRCttRHWCujKYFILawJOjxE7Y0Lcwomx94dzum
         YxXoue4pvlTlMg1mqWuHEHKjS2n/NpSVynKu1Wpq09b4ep79Cg6dk5YwToyfelrlg1uf
         Q7WgWSVdPs9ltW+5YIC/O06hgCVfjZGiLHAFfZ19jcylLvrbgOlqBW8FXVgesWjg7uwV
         X8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pmWJR9CFy0G549gUQSywKDSK51q+vKpVHdR5OKt//mI=;
        b=ntkOaDD+Bj9AUSO+l71CPj2tT92keB/V2mF8C8ZCqOUNGIpi9JNL4f+zmQ4z9FKTwj
         uv4IWdtrDMsEZp7slcatAMY1L4oAQ8+rqa+N1jweOtqtLfvBlOydnIp25P3nAC6/rbrk
         GX9X+qPWzMsB+c2qIBZy6cf8je/a1sc2dE/fdWz2r1JKQfLYmNPHY/baCofn6TmBBntJ
         Reixs/oG5/1MQMmc/AO43bl/EYZBE3uPNftp3z2xT4n7Qxiyz20EIGlj0lxCs8hxl9XK
         TKvVUs9eWs1WzM7nDqRY1hY7GPtCB9ngsbwQoc+Ph+l5rNfOlt+cW8spEqoYR8cjoAtg
         apiw==
X-Gm-Message-State: ANhLgQ3ZBz60VT1wzHuzWqEiGFpRZs8vWOUFpD7z36txec6j0SDlF+SM
        hXQesBWrd3PSFDc6hp3VKuh8riUz
X-Google-Smtp-Source: ADFU+vtPXatbsU0l/ZJ+gNZUKzAcxtMeLju8WiNngc1vtfGZS4+OBSDONUJVNnwQNSiDYeOLnXt1Aw==
X-Received: by 2002:adf:9346:: with SMTP id 64mr11837311wro.174.1585270153227;
        Thu, 26 Mar 2020 17:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16sm6028879wrr.56.2020.03.26.17.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:12 -0700 (PDT)
Message-Id: <90c514e220ba22e8fe63c33fd9c8cb9a67d21e64.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:56 +0000
Subject: [PATCH v3 13/18] unpack-trees: rename ERROR_* fields meant for
 warnings to WARNING_*
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

We want to treat issues with setting the SKIP_WORKTREE bit as a warning
rather than an error; rename the enum values to reflect this intent as
a simple step towards that goal.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 12 ++++++------
 unpack-trees.h |  8 +++++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index eeac309e30e..2a2306c5c28 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -46,10 +46,10 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_LOSE_SUBMODULE */
 	"Submodule '%s' cannot checkout new HEAD.",
 
-	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
+	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
-	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
+	/* WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
 };
 
@@ -168,9 +168,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
 		_("Cannot update submodule:\n%s");
 
-	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
+	msgs[WARNING_SPARSE_NOT_UPTODATE_FILE] =
 		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
-	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
+	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
 
 	opts->show_all_errors = 1;
@@ -509,7 +509,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		ce->ce_flags &= ~CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
-		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN, o))
+		if (verify_absent_sparse(ce, WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN, o))
 			return -1;
 		ce->ce_flags |= CE_UPDATE;
 	}
@@ -1875,7 +1875,7 @@ int verify_uptodate(const struct cache_entry *ce,
 static int verify_uptodate_sparse(const struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
+	return verify_uptodate_1(ce, o, WARNING_SPARSE_NOT_UPTODATE_FILE);
 }
 
 /*
diff --git a/unpack-trees.h b/unpack-trees.h
index 3e996a6c0a9..aac1ad4b014 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -23,9 +23,11 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
 	ERROR_WOULD_LOSE_SUBMODULE,
-	ERROR_SPARSE_NOT_UPTODATE_FILE,
-	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
-	NB_UNPACK_TREES_ERROR_TYPES
+
+	WARNING_SPARSE_NOT_UPTODATE_FILE,
+	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
+
+	NB_UNPACK_TREES_ERROR_TYPES,
 };
 
 /*
-- 
gitgitgadget

