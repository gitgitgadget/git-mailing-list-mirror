Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669FEE81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJFSJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjJFSJg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:09:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9FDBE
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:09:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406609df1a6so23007665e9.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615773; x=1697220573; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8lb0sSJAykOh6wTINS3XM4I3mJvJdoxlXy2HbkrBHY=;
        b=Q+5ojLEvpSw+cx5N1QCCdbdeIqq3sks9MXNlZr9vipuj26JWAa0eG+yeUhtBUzw3XV
         SIZxzfpw1eaxkUq33MK6hupAoxmA0yi/7BG8D1AP4pkv1phk4o8t9gHEf89wYmPMY0GB
         pZEzEK81EKAwyA91Kk85MWPswUSglQZf7CS8WLVG9zZ37mt9bUIGaYgM5K1URUaMLB0i
         xEsb2b1J/y4re13iu+iREyLDjBlCQvwzzheYaxLme/eoWzEcjVaZjgrc/xuKbhYfjzft
         o8qizRUHTAUfNLlkRSHmXlB1P1fnnusaI/gH5RiubokMjUDsEXKmkCvouHBJA8KmoF3h
         l0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615773; x=1697220573;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8lb0sSJAykOh6wTINS3XM4I3mJvJdoxlXy2HbkrBHY=;
        b=wkLS2I+HeEELY06hV1BtOIZk+FrnnG0+cXZLc2Ybo6nsUVorpXtZv0EPJLHonLLEA7
         uMz2l2Jrl2oJ6aemFHuE2Cf/nzT0Wuq9/czTvmFDuw9XMGHxU2Hr2cQ2UHKj+pp9OT05
         F4nEaQAl9EBJKO/R9yIXSN66UsVAjMGnWnk2LGdrfuCZc7VlVbwgyXkVqfrckvpVhclS
         I1TSZmCwR50nXUwmeq9764NnUBiclWXL/ntlz2Bh96JdR8KoqRFzBQfm8rLXH3LqiF0U
         QKVEMAF06F60GZ71hoTfEnK1V/mjJcsgGhselpA6GB2+nChOwl6iqY2AH2sNpivIuEed
         esZg==
X-Gm-Message-State: AOJu0YwA2BKZ9IaZz+8h4QnspjlAMYLHtTo4W/3cZ0HloErUDVAMaHZ2
        XgDpDpPb9HZqsfw/20HeVPT22wv3MsQ=
X-Google-Smtp-Source: AGHT+IHkNSSG4UiC902yMb4i9wyEzMeOztYdFvQ/dRwx3i2Tj8UgNuaV2ug+Vn++zT/KbMdvDdes+g==
X-Received: by 2002:a7b:ce89:0:b0:404:f9c1:d5d7 with SMTP id q9-20020a7bce89000000b00404f9c1d5d7mr7985612wmj.25.1696615772680;
        Fri, 06 Oct 2023 11:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j31-20020a05600c1c1f00b004068e09a70bsm4127449wms.31.2023.10.06.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:09:32 -0700 (PDT)
Message-ID: <e193a45318244d9f8b05dfe2fb1ce57f6a4f6428.1696615769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 18:09:29 +0000
Subject: [PATCH 4/4] files-backend.c: avoid stat in 'loose_fill_ref_dir'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Modify the 'readdir' loop in 'loose_fill_ref_dir' to, rather than 'stat' a
file to determine whether it is a directory or not, use 'get_dtype'.

Currently, the loop uses 'stat' to determine whether each dirent is a
directory itself or not in order to construct the appropriate ref cache
entry. If 'stat' fails (returning a negative value), the dirent is silently
skipped; otherwise, 'S_ISDIR(st.st_mode)' is used to check whether the entry
is a directory.

On platforms that include an entry's d_type in in the 'dirent' struct, this
extra 'stat' check is redundant. We can use the 'get_dtype' method to
extract this information on platforms that support it (i.e. where
NO_D_TYPE_IN_DIRENT is unset), and derive it with 'stat' on platforms that
don't. Because 'stat' is an expensive call, this confers a
modest-but-noticeable performance improvement when iterating over large
numbers of refs (approximately 20% speedup in 'git for-each-ref' in a 30k
ref repo).

Unlike other existing usage of 'get_dtype', the 'follow_symlinks' arg is set
to 1 to replicate the existing handling of symlink dirents. This
unfortunately requires calling 'stat' on the associated entry regardless of
platform, but symlinks in the loose ref store are highly unlikely since
they'd need to be created manually by a user.

Note that this patch also changes the condition for skipping creation of a
ref entry from "when 'stat' fails" to "when the d_type is anything other
than DT_REG or DT_DIR". If a dirent's d_type is DT_UNKNOWN (either because
the platform doesn't support d_type in dirents or some other reason) or
DT_LNK, 'get_dtype' will try to derive the underlying type with 'stat'. If
the 'stat' fails, the d_type will remain 'DT_UNKNOWN' and dirent will be
skipped. However, it will also be skipped if it is any other valid d_type
(e.g. DT_FIFO for named pipes, DT_LNK for a nested symlink). Git does not
handle these properly anyway, so we can safely constrain accepted types to
directories and regular files.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 refs/files-backend.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 341354182bb..db5c0c7a724 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -246,10 +246,8 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	int dirnamelen = strlen(dirname);
 	struct strbuf refname;
 	struct strbuf path = STRBUF_INIT;
-	size_t path_baselen;
 
 	files_ref_path(refs, &path, dirname);
-	path_baselen = path.len;
 
 	d = opendir(path.buf);
 	if (!d) {
@@ -262,23 +260,22 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 
 	while ((de = readdir(d)) != NULL) {
 		struct object_id oid;
-		struct stat st;
 		int flag;
+		unsigned char dtype;
 
 		if (de->d_name[0] == '.')
 			continue;
 		if (ends_with(de->d_name, ".lock"))
 			continue;
 		strbuf_addstr(&refname, de->d_name);
-		strbuf_addstr(&path, de->d_name);
-		if (stat(path.buf, &st) < 0) {
-			; /* silently ignore */
-		} else if (S_ISDIR(st.st_mode)) {
+
+		dtype = get_dtype(de, &path, 1);
+		if (dtype == DT_DIR) {
 			strbuf_addch(&refname, '/');
 			add_entry_to_dir(dir,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
-		} else {
+		} else if (dtype == DT_REG) {
 			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
@@ -308,7 +305,6 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_ref_entry(refname.buf, &oid, flag));
 		}
 		strbuf_setlen(&refname, dirnamelen);
-		strbuf_setlen(&path, path_baselen);
 	}
 	strbuf_release(&refname);
 	strbuf_release(&path);
-- 
gitgitgadget
