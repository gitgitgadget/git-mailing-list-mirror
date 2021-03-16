Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B741C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A3864F04
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhCPA4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhCPA4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE4FC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 205so4526696pgh.9
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2iQLI0PQ/J2j6ySE0fTaxcD8Dxt3YsQsADOTribANyc=;
        b=mzNhQmH4GsvpNERyyhSgv7741hUzgL1aeFkVncAPukv9ZqvxCaKF+w/U8TatBKqUmK
         49tHpR6e1LuLkO/CqbcS3HEqqKPG6+pLZ3gf2C2zMXdCCVlMxkQtc0QsYSdTWK2fm8zn
         tvTLBxLqCryylie2c+Fi/a6KgCyKlYDglqKJ51IjAahVvN/N5CXnhnsie+7fi0JcoAX/
         qeyi364pvf5H+jzQFXVuElqWxdN+Fr/P1q1PRE81fIJcP45pvpOJMFCcLDEd8FPRKSOB
         6R7/F3Xy0HOFsc1jrx6rRsKJaAnOo3cFaLVq2lBMW5kOtBjBKaYffduRRkl1d708mq6y
         9XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iQLI0PQ/J2j6ySE0fTaxcD8Dxt3YsQsADOTribANyc=;
        b=QhRRYCo59GRwVghgVTC4me08jcktFzjUYgQSCcac2+0MMym5tWbC6yr7eeXZTORjK3
         NySdaNxjVJCWcEVJ2WHpDr23Du04ME3gbt6L3NgSWbz5KeJPdHt+BWUVs7jmYAjKL3zn
         iubaCoxyKleeqyKHy//7LAxwQpztlkoJOnVW/pZkYxXWbmtTgeVlR5MLy33O9daVeuuk
         OfGgOiVRMacxCa+1RYp4b35mGnzv+/YaUpPjPKHp068PukZaMRXnQyJBuEcggIDca4y/
         cv70F/MpEQNYmhIbM+/a/GZSo+bzpXlQ0/WTm8xerkFWU/TBUUK8RN216FP2HByuSBDM
         XjNA==
X-Gm-Message-State: AOAM532rInvV9iWtPez8tohPEMKf+4+/dnzZGbfEE9/LaTxqebSiPPq6
        IMQgCGwDLHDdqclptdZ4SPK93u2jBbY=
X-Google-Smtp-Source: ABdhPJwJVzMfV8JNGYhRUpOIXF7w7+AvCc4aikVzi+7HzHbEdzqQXUIaUDLpSztqzDav0JyTShfxfg==
X-Received: by 2002:a63:4c5e:: with SMTP id m30mr1578192pgl.402.1615856192372;
        Mon, 15 Mar 2021 17:56:32 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:32 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] builtin.h: ASCII-sort list of functions
Date:   Mon, 15 Mar 2021 17:56:22 -0700
Message-Id: <aee5f6d1e2e123505c1e3b0b8ff952cce7de3436.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The list of builtin functions have, over time, gotten slightly out of
ASCII order. Sort this list to bring them back into order.

ASCII sorting was chosen over strict alphabetical order for the same
reason as 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21): the
purpose of maintaining the sorted list is to ensure line insertions are
deterministic. By using ASCII ordering, it is more easily mechanically
reproducible in the future, such as by using :sort in Vim.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin.h b/builtin.h
index b6ce981b73..dd6beff6b2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -122,16 +122,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
-int cmd_checkout(int argc, const char **argv, const char *prefix);
-int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 int cmd_check_attr(int argc, const char **argv, const char *prefix);
 int cmd_check_ignore(int argc, const char **argv, const char *prefix);
 int cmd_check_mailmap(int argc, const char **argv, const char *prefix);
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
+int cmd_checkout(int argc, const char **argv, const char *prefix);
+int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 int cmd_cherry(int argc, const char **argv, const char *prefix);
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
-int cmd_clone(int argc, const char **argv, const char *prefix);
 int cmd_clean(int argc, const char **argv, const char *prefix);
+int cmd_clone(int argc, const char **argv, const char *prefix);
 int cmd_column(int argc, const char **argv, const char *prefix);
 int cmd_commit(int argc, const char **argv, const char *prefix);
 int cmd_commit_graph(int argc, const char **argv, const char *prefix);
@@ -143,9 +143,9 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix);
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
 int cmd_credential_store(int argc, const char **argv, const char *prefix);
 int cmd_describe(int argc, const char **argv, const char *prefix);
+int cmd_diff(int argc, const char **argv, const char *prefix);
 int cmd_diff_files(int argc, const char **argv, const char *prefix);
 int cmd_diff_index(int argc, const char **argv, const char *prefix);
-int cmd_diff(int argc, const char **argv, const char *prefix);
 int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 int cmd_difftool(int argc, const char **argv, const char *prefix);
 int cmd_env__helper(int argc, const char **argv, const char *prefix);
@@ -169,16 +169,16 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
 int cmd_log(int argc, const char **argv, const char *prefix);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 int cmd_ls_files(int argc, const char **argv, const char *prefix);
-int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 int cmd_ls_remote(int argc, const char **argv, const char *prefix);
+int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 int cmd_maintenance(int argc, const char **argv, const char *prefix);
 int cmd_merge(int argc, const char **argv, const char *prefix);
 int cmd_merge_base(int argc, const char **argv, const char *prefix);
+int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
-int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
@@ -189,6 +189,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix);
 int cmd_notes(int argc, const char **argv, const char *prefix);
 int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
+int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 int cmd_patch_id(int argc, const char **argv, const char *prefix);
 int cmd_prune(int argc, const char **argv, const char *prefix);
 int cmd_prune_packed(int argc, const char **argv, const char *prefix);
@@ -204,6 +205,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
 int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 int cmd_repack(int argc, const char **argv, const char *prefix);
+int cmd_replace(int argc, const char **argv, const char *prefix);
 int cmd_rerere(int argc, const char **argv, const char *prefix);
 int cmd_reset(int argc, const char **argv, const char *prefix);
 int cmd_restore(int argc, const char **argv, const char *prefix);
@@ -216,9 +218,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix);
 int cmd_show(int argc, const char **argv, const char *prefix);
 int cmd_show_branch(int argc, const char **argv, const char *prefix);
 int cmd_show_index(int argc, const char **argv, const char *prefix);
+int cmd_show_ref(int argc, const char **argv, const char *prefix);
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
-int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
+int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 int cmd_switch(int argc, const char **argv, const char *prefix);
@@ -235,14 +238,11 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
 int cmd_upload_pack(int argc, const char **argv, const char *prefix);
 int cmd_var(int argc, const char **argv, const char *prefix);
 int cmd_verify_commit(int argc, const char **argv, const char *prefix);
+int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 int cmd_version(int argc, const char **argv, const char *prefix);
 int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 int cmd_worktree(int argc, const char **argv, const char *prefix);
 int cmd_write_tree(int argc, const char **argv, const char *prefix);
-int cmd_verify_pack(int argc, const char **argv, const char *prefix);
-int cmd_show_ref(int argc, const char **argv, const char *prefix);
-int cmd_pack_refs(int argc, const char **argv, const char *prefix);
-int cmd_replace(int argc, const char **argv, const char *prefix);
 
 #endif
-- 
2.31.0.rc2.261.g7f71774620

