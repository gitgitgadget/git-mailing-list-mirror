Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE355CD613C
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbjJIV7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbjJIV7E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:59:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853899
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:59:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40651a72807so48928175e9.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888740; x=1697493540; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8lb0sSJAykOh6wTINS3XM4I3mJvJdoxlXy2HbkrBHY=;
        b=ltXD83ckqOxZ8zfdYRUHhjsPWccxrgcoRfFJKAHig5OID7JYCZVdFobhWV983oT1la
         2tnx+LMX72laW4OFVuWv5kxWZQ961zcJAm47GvwT6wxY9qp/8ykOJoRarPcvsgRjPtKm
         zy3b4PrLOGn/tgmFaxWSHKx11nsP5+AryGab57WTkWPAzZTedV3xKSTsjJOiicoFQoFP
         fHm3Jj8777beAPcOujzfmsIRsbIuV5oHBuOOhYnjVP5gaPKoYCdm1XnREx9Ag2eIOcBK
         +n0Us8R5GKZae9zRj16d84GOct8Qv5tx4hIPCMJd+eOgty84tP0hn8rrmxQPZ3/m99W4
         oCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888740; x=1697493540;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8lb0sSJAykOh6wTINS3XM4I3mJvJdoxlXy2HbkrBHY=;
        b=OVh0Kn4N1Z/3Jz/2M8p9T+XdUxWTdE4EzE5j7iioeMdvxm6L/un4P49wNnwZQoJLKB
         trRKM3DTkZS0TljCbumHrCVQeAqAOFofR7BZov6V8MVvCZvBxMpGOW/EMozOimttaGDY
         QnJZXn4TodXSm5zB60ImYkBdUhnaV/THHcgYASdu42fPzY1BoCuCWYtQ/oEFstOB34Fm
         ZXpId3P+7HQ/KoeZshXWh9ykQK0qT53hIfFlDjLWaw2GPV8swkTIwyBfEE4xnqYrdSVX
         Dc8UMJaKzGiWR+SGthRL2NlXorXYL8AFbU8ReiYGt1ccpiuGAj4V+7d4ouSa/dZwk1QG
         gV4A==
X-Gm-Message-State: AOJu0YwBSAXoHcKN+jwAwWtAbBuN6OGlQN1/rOsc0KJQycb+2UR59ysJ
        Nau+NadLFw3YU0nA3jLF2RkrrNm14Uc=
X-Google-Smtp-Source: AGHT+IHxsdG9b8f5Gta63WhWHqO0gPI/mZd68FD7VEucc3TpZ1SdyQqTerLWTi6ZZc98uWgSjYvXwQ==
X-Received: by 2002:a1c:6a07:0:b0:405:4f78:e128 with SMTP id f7-20020a1c6a07000000b004054f78e128mr15491982wmc.4.1696888740335;
        Mon, 09 Oct 2023 14:59:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b004064cd71aa8sm12162373wmj.34.2023.10.09.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:58:59 -0700 (PDT)
Message-ID: <e89501cb51f12b7a49fc6ee03fe6f9e6264ea2b9.1696888736.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 21:58:56 +0000
Subject: [PATCH v2 4/4] files-backend.c: avoid stat in 'loose_fill_ref_dir'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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
