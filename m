Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C8BC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066F3206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKl0ybEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404777AbgFYMtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404761AbgFYMtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4AC0613ED
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:48:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so5421986wmi.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAvHl/JhnYRaMUMuiirHrgwuklbVky8tI/TBNJJKK+M=;
        b=iKl0ybEXbk4MoOR+diED94GptRGIYNP6EI5xVR3pOlNaIzy0wizYWkXZvkRjjYH6EW
         NdmkDmRRQ1zmK2DlLFKhuf5oRE5mSH6nPL4GCwIrLOWJMpe/tEw8c0FfLqfN8JEdwa7c
         T84dFnbTqLuU7KyxABeyYxmgaBuIsSdk64TmQyppT6HtpICtBN1R5Wbl+hsu9qNmgFqi
         yORhK/LjGxTkAgYFmMt1qhVq6vwLv/V6myAA718aGNB2QRzXSJ4Xoc03vapdWEtyctZ9
         BnVYNTX1/DBTDLCMhVbGkOSB6bTdWubq4h5+w0XlMOaLqqX2JHxM718SHGRneODFX1YX
         BnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAvHl/JhnYRaMUMuiirHrgwuklbVky8tI/TBNJJKK+M=;
        b=CgJUQtMbIJGbOFFNNRCtfuJd+xe7VqhFWbugBzV3D4KBYRYW6BOSHA7hHkEAyY2WjL
         v4VRPxGLggLl+uroOccvskFVMV3OPNjWQ35MNAx0T8MqVECRnYFt+y6AO8QQFObFSz72
         DnLwgBF+09/gE5wK5lQskG4arr0qAtbVRkAa2VupfBTV5LqNkFQpDyO+j/AnPl2rEmvx
         It1n5VWefrGtcrjeMd9bmaDbFO4wEjNpHNBJhkIl9GjMbs7CvNY3vc9j27LoNgz7pi1T
         RT5wCQl6mlKo5YJ1isqMpvlMgTB9icuULqKjO7KcKq4ovkYaqxpJUvr7AaUTUYsp4erY
         uEVA==
X-Gm-Message-State: AOAM532BDY09YTp1ES113hWSuNBG1g/QCnG9QwSN1aV0k/qYHffgl8NV
        aWDRoIa/kzo4XappltByi/urvDUD
X-Google-Smtp-Source: ABdhPJxYam6lMPRIQKoa0n6wRXEwOs2fY2xZW/pJut9HDWrd7rp1DGtLyt4uBGut25972eAetOV4pw==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr3224037wmh.130.1593089337465;
        Thu, 25 Jun 2020 05:48:57 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:48:56 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 03/17] merge-one-file: remove calls to external processes
Date:   Thu, 25 Jun 2020 14:19:39 +0200
Message-Id: <20200625121953.16991-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To save precious cycles by avoiding reading and flushing the index
repeatedly, or write temporary files when an operation can be performed
in-memory, this removes call to external processes:

 - calls to `update-index --add --cacheinfo' are replaced by calls to
   add_cache_entry();

 - calls to `update-index --remove' are replaced by calls to
   remove_file_from_cache();

 - calls to `checkout-index -u -f' are replaced by calls to
   checkout_entry();

 - calls to `unpack-file' and `merge-files' are replaced by calls to
   read_mmblob() and xdl_merge(), respectively, to merge files
   in-memory;

 - calls to `checkout-index -f --stage=2' are replaced by calls to
   cache_file_exists();

 - calls to `update-index' are replaced by calls to add_file_to_cache().

To enable these changes, the index is read and written back in
cmd_merge_one_file().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-one-file.c | 160 +++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 82 deletions(-)

diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
index 4992a6cd30..d9ebd820cb 100644
--- a/builtin/merge-one-file.c
+++ b/builtin/merge-one-file.c
@@ -27,54 +27,48 @@
 #include "dir.h"
 #include "lockfile.h"
 #include "object-store.h"
-#include "run-command.h"
 #include "xdiff-interface.h"
 
-static int create_temp_file(const struct object_id *oid, struct strbuf *path)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "unpack-file", oid_to_hex(oid), NULL);
-	ret = pipe_command(&cp, NULL, 0, path, 0, &err, 0);
-	if (!ret && path->len > 0)
-		strbuf_trim_trailing_newline(path);
-
-	fprintf(stderr, "%.*s", (int) err.len, err.buf);
-	strbuf_release(&err);
-
-	return ret;
-}
-
 static int add_to_index_cacheinfo(unsigned int mode,
 				  const struct object_id *oid, const char *path)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
+	struct cache_entry *ce;
+	int len, option;
 
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "update-index", "--add", "--cacheinfo", NULL);
-	argv_array_pushf(&cp.args, "%o,%s,%s", mode, oid_to_hex(oid), path);
-	return run_command(&cp);
-}
+	if (!verify_path(path, mode))
+		return error("Invalid path '%s'", path);
 
-static int remove_from_index(const char *path)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
+	len = strlen(path);
+	ce = make_empty_cache_entry(&the_index, len);
 
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "update-index", "--remove", "--", path, NULL);
-	return run_command(&cp);
+	oidcpy(&ce->oid, oid);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = len;
+	ce->ce_mode = create_ce_mode(mode);
+	if (assume_unchanged)
+		ce->ce_flags |= CE_VALID;
+	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	if (add_cache_entry(ce, option))
+		return error("%s: cannot add to the index", path);
+
+	return 0;
 }
 
 static int checkout_from_index(const char *path)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
+	struct checkout state;
+	struct cache_entry *ce;
 
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "checkout-index", "-u", "-f", "--", path, NULL);
-	return run_command(&cp);
+	state.istate = &the_index;
+	state.force = 1;
+	state.base_dir = "";
+	state.base_dir_len = 0;
+
+	ce = cache_file_exists(path, strlen(path), 0);
+	if (checkout_entry(ce, &state, NULL, NULL) < 0)
+		return error("%s: cannot checkout file", path);
+	return 0;
 }
 
 static int merge_one_file_deleted(const struct object_id *orig_blob,
@@ -96,7 +90,9 @@ static int merge_one_file_deleted(const struct object_id *orig_blob,
 			remove_path(path);
 	}
 
-	return remove_from_index(path);
+	if (remove_file_from_cache(path))
+		return error("%s: cannot remove from the index", path);
+	return 0;
 }
 
 static int do_merge_one_file(const struct object_id *orig_blob,
@@ -104,61 +100,50 @@ static int do_merge_one_file(const struct object_id *orig_blob,
 			     const struct object_id *their_blob, const char *path,
 			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
 {
-	int ret, source, dest;
-	struct strbuf src1 = STRBUF_INIT, src2 = STRBUF_INIT, orig = STRBUF_INIT;
-	struct child_process cp_merge = CHILD_PROCESS_INIT,
-		cp_checkout = CHILD_PROCESS_INIT,
-		cp_update = CHILD_PROCESS_INIT;
+	int ret, i, dest;
+	mmbuffer_t result = {NULL, 0};
+	mmfile_t mmfs[3];
+	xmparam_t xmp = {{0}};
+	struct cache_entry *ce;
 
-	if (our_mode == S_IFLNK || their_mode == S_IFLNK) {
-		fprintf(stderr, "ERROR: %s: Not merging symbolic link changes.\n", path);
-		return 1;
-	} else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK) {
-		fprintf(stderr, "ERROR: %s: Not merging conflicting submodule changes.\n",
-			path);
-		return 1;
-	}
+	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
+		return error(_("%s: Not merging symbolic link changes."), path);
+	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
+		return error(_("%s: Not merging conflicting submodule changes."), path);
 
-	create_temp_file(our_blob, &src1);
-	create_temp_file(their_blob, &src2);
+	read_mmblob(mmfs + 0, our_blob);
+	read_mmblob(mmfs + 2, their_blob);
 
 	if (orig_blob) {
 		printf("Auto-merging %s\n", path);
-		create_temp_file(orig_blob, &orig);
+		read_mmblob(mmfs + 1, orig_blob);
 	} else {
 		printf("Added %s in both, but differently.\n", path);
-		create_temp_file(the_hash_algo->empty_blob, &orig);
+		read_mmblob(mmfs + 1, the_hash_algo->empty_blob);
 	}
 
-	cp_merge.git_cmd = 1;
-	argv_array_pushl(&cp_merge.args, "merge-file", src1.buf, orig.buf, src2.buf,
-			 NULL);
-	ret = run_command(&cp_merge);
+	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
+	xmp.style = 0;
+	xmp.favor = 0;
 
-	if (ret != 0)
+	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
+
+	for (i = 0; i < 3; i++)
+		free(mmfs[i].ptr);
+
+	if (ret > 127)
 		ret = 1;
 
-	cp_checkout.git_cmd = 1;
-	argv_array_pushl(&cp_checkout.args, "checkout-index", "-f", "--stage=2",
-			 "--", path, NULL);
-	if (run_command(&cp_checkout))
-		return 1;
+	ce = cache_file_exists(path, strlen(path), 0);
+	if (!ce)
+		BUG("file is not present in the cache?");
 
-	source = open(src1.buf, O_RDONLY);
-	dest = open(path, O_WRONLY | O_TRUNC);
-
-	copy_fd(source, dest);
-
-	close(source);
+	unlink(path);
+	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
+	write_in_full(dest, result.ptr, result.size);
 	close(dest);
 
-	unlink(orig.buf);
-	unlink(src1.buf);
-	unlink(src2.buf);
-
-	strbuf_release(&src1);
-	strbuf_release(&src2);
-	strbuf_release(&orig);
+	free(result.ptr);
 
 	if (ret) {
 		fprintf(stderr, "ERROR: ");
@@ -178,9 +163,7 @@ static int do_merge_one_file(const struct object_id *orig_blob,
 		return 1;
 	}
 
-	cp_update.git_cmd = 1;
-	argv_array_pushl(&cp_update.args, "update-index", "--", path, NULL);
-	return run_command(&cp_update);
+	return add_file_to_cache(path, 0);
 }
 
 static int merge_one_file(const struct object_id *orig_blob,
@@ -250,11 +233,17 @@ int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
 {
 	struct object_id orig_blob, our_blob, their_blob,
 		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
-	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0;
+	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret;
+	struct lock_file lock = LOCK_INIT;
 
 	if (argc != 8)
 		usage(builtin_merge_one_file_usage);
 
+	if (read_cache() < 0)
+		die("invalid index");
+
+	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+
 	if (!get_oid(argv[1], &orig_blob)) {
 		p_orig_blob = &orig_blob;
 		orig_mode = strtol(argv[5], NULL, 8);
@@ -270,6 +259,13 @@ int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
 		their_mode = strtol(argv[7], NULL, 8);
 	}
 
-	return merge_one_file(p_orig_blob, p_our_blob, p_their_blob, argv[4],
-			      orig_mode, our_mode, their_mode);
+	ret = merge_one_file(p_orig_blob, p_our_blob, p_their_blob, argv[4],
+			     orig_mode, our_mode, their_mode);
+
+	if (ret) {
+		rollback_lock_file(&lock);
+		return ret;
+	}
+
+	return write_locked_index(&the_index, &lock, COMMIT_LOCK);
 }
-- 
2.27.0.139.gc9c318d6bf

