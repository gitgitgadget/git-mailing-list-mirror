Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A74C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A2A206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OopArYK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbgGaQwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732474AbgGaQwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B842C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so4640230wmi.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBVnXfBJF9lQX3a7Ibd8m+x5HaSMVcia4QtZlBo0xfA=;
        b=OopArYK4B5KnDRQ3PCgrdu8FtlvtxlG9W3zZIWkRxFotcm5aMGZUzpm0IY/S7o/cql
         6rJwQusP8WYyxucWNElBfErpuGnDc4eMDRNFRpVYei7RgppvoLuM8jseq0Uips0KpCJD
         AJuk6kM4/heciDL4rg1ZV9M4rortiS8Uwb/jFrYMGZnYYIw90eRVTOVInSjoCwguaBoj
         3jF5kW/zMdwSLGItCGcX8nQU6bHAlI7xcdDxBcQJhTQw4WmaT5LA2IliO/R5a7gOFMLL
         SNmSjDqiEoLF+NAWL56uI/GgZujSoc5AK6HHaPIPFDHB8WnXp8t7bXPSlM013zCxqA28
         g36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBVnXfBJF9lQX3a7Ibd8m+x5HaSMVcia4QtZlBo0xfA=;
        b=HQyCNtObz/CHES/izu3WVW9+3N8D8WjoiNW6uwgUcpdHJie4fik0hXfW+i2PkBcjmk
         2TzfiTLUZ2Y6tilyCZt1NqjNyrjRDwmfGKkfSJO3iYNgtiPiI3D8yqBv1VkxCDuNZM9k
         Ln378KHPkrxoU5U9BlpbzfVaYpwM6Qk9QYo3sc8+/9RqrYj13Wa0So7dXajvGQc6107Z
         lPhQvwMK+aW16+cirVb8PrQZ/xSmJX3WUqmX6ICKehoYbQjPwHkbmYoBdzJTKr+V8P3v
         GLMKm0ox9spmnbI15x8z/dUQHsrvBCfmX0HwoPFlTPBaZYSOUMEEF8Mfj7RJDnXWkerk
         dYsg==
X-Gm-Message-State: AOAM532YTsTJQvaF7+PNPaNz/1GsuRsIpQjppv9YVYyKVNjSkRxYAKHh
        2U8lY3FgKCZSIyZc4wCTiZzGtO4b
X-Google-Smtp-Source: ABdhPJz6BGKC+aduAM16A2OzBUJ3F55tetCpqZWImgd9HSK+tnuub34KKSyiwHWRG80aU/TXm7mFnQ==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr4485530wmt.94.1596214333744;
        Fri, 31 Jul 2020 09:52:13 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:13 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 4/6] stash: remove the second index in save_untracked_files()
Date:   Fri, 31 Jul 2020 18:51:38 +0200
Message-Id: <20200731165140.29197-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731165140.29197-1-alban.gruin@gmail.com>
References: <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200731165140.29197-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in save_untracked_files().

This functions creates a new commit with no parents, and a tree
containing only untracked files, so the tree is reset to the empty tree
at the beginning (hence the need for reset_tree() to accept constant
trees).  The environment of `update-index' is no longer updated, and the
index is discarded after this command exits.

As the only caller of this function is do_create_stash(), and the next
user of the index is either save_untracked_files() or stash_patch(),
which both want a different tree, the index is left as-is at the end.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index eaeb7bc8c4..cbe37cd24b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -954,41 +954,36 @@ static int check_changes(const struct pathspec *ps, int include_untracked,
 static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 				struct strbuf files)
 {
-	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+
+	if (reset_tree(the_hash_algo->empty_tree, 0, 1))
+		return -1;
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
 			 "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
+
+	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
+			 NULL, 0))
+		return -1;
+
+	discard_cache();
+	if (write_cache_as_tree(&info->u_tree, 0, NULL))
+		return -1;
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
-	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
-			 NULL, 0)) {
-		ret = -1;
-		goto done;
-	}
-
-	if (write_index_as_tree(&info->u_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
-		ret = -1;
-		goto done;
-	}
-
 	if (commit_tree(untracked_msg.buf, untracked_msg.len,
 			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
-		ret = -1;
-		goto done;
+		strbuf_release(&untracked_msg);
+		return -1;
 	}
 
-done:
-	discard_index(&istate);
+	/* Do not reset the tree, as either stash_patch() or
+	 * stash_working_tree() will do it. */
+
 	strbuf_release(&untracked_msg);
-	remove_path(stash_index_path.buf);
-	return ret;
+	return 0;
 }
 
 static int stash_patch(struct stash_info *info, const struct pathspec *ps,
-- 
2.20.1

