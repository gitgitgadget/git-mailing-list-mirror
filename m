Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A523C3A59F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiKWTAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiKWTAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:00:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05491C3E
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso1517615wmc.4
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlX8fRoMkPnEolpDAbYR1NXBm53dpHMaf0+jydPyO8c=;
        b=emaLUmtqkoChOqRcbodtoAaY37x1SZSrHq0eDIrvFAbhIUkWIsSA+UHguqiczIaud0
         NMr6llJuLPz6K2sBlmjKB420rUyD7uPOxALLp8bwO610TdzKSJeNevInbSOL9IG5mntR
         Tr5OB+tkpFHIXpPwJX8N+wg0owv/yMZQvS4Eul/surWEEsg7WB0UHVxPz5/2OrCmU6tD
         wsSiXuz+/CjQc+HAq8r4bdzTA25l8p/Fpk092MDszwQBbwY8mC9itMYsist/3JdZ5rs+
         DhvUpR3Jxz0+2nHBq1+brCRwXy6vUM6lhMAa411/mtA1c7aquv6V7Fh5TzGHvZkOfMOv
         TIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlX8fRoMkPnEolpDAbYR1NXBm53dpHMaf0+jydPyO8c=;
        b=exGq/ThC0DDHUwr/Kv/5zrfLxVeJdkKoJy3OJSauhQXZUUnM+IZQFLI6PLGvMYxR8e
         hJGfPuTOsAX+7NGps183adCiBfUW6NQ7n0DzvKP8Wl4ofnWqfMoiXWOMeBIYntSjoIAh
         oxm2hNezKzZbP2BWcxP6vSfyuiR6VxL7bzcQ/mk6VwRTgrKTczZpKEuwetC581tnUmHq
         RMThcLyh4CCy8SXLM24ZNao4kbvNMta2Ij1K3xTjlBybaBHd0yfOp/yGokKJ4QUiq04z
         sYR5rpZbjjApYQmdQKK4Vpw6U8RRZN2wIziGRb7NBIes49y1TUxMZ6BTDA84bERFqngo
         Unpw==
X-Gm-Message-State: ANoB5pkA3/CBYR0rfmoB3mWCBo8WCZ8GGZHGIv6wsPPSi7+IT9vg7tvq
        6yFGSI+gv8ug89a+5nxMCWw3EiZwmbo=
X-Google-Smtp-Source: AA0mqf5UjVrv8BM2Xtkdq37PCaLiZrB6WvMxpiyfGpM9/LyTpqmBMdE/cvOe2OMmOV02bTFVsXxsgQ==
X-Received: by 2002:a05:600c:3c96:b0:3cf:a457:2d89 with SMTP id bg22-20020a05600c3c9600b003cfa4572d89mr24138186wmb.20.1669230049495;
        Wed, 23 Nov 2022 11:00:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iw8-20020a05600c54c800b003cfbe1da539sm3115993wmb.36.2022.11.23.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:00:48 -0800 (PST)
Message-Id: <e53fc07754094aa5ba8080ec7761869c6429a8af.1669230044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
        <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 19:00:40 +0000
Subject: [PATCH v4 2/6] fsmonitor: determine if filesystem is local or remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Compare the given path to the mounted filesystems. Find the mount that is
the longest prefix of the path (if any) and determine if that mount is on a
local or remote filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-path-utils-linux.c | 186 ++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c

diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 00000000000..d3281422ebc
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,186 @@
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+#include <errno.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/vfs.h>
+#include <sys/statvfs.h>
+
+static int is_remote_fs(const char* path) {
+	struct statfs fs;
+
+	if (statfs(path, &fs)) {
+		error_errno(_("statfs('%s') failed"), path);
+		return -1;
+	}
+
+	switch (fs.f_type) {
+		case 0x61636673:  /* ACFS */
+		case 0x5346414F:  /* AFS */
+		case 0x00C36400:  /* CEPH */
+		case 0xFF534D42:  /* CIFS */
+		case 0x73757245:  /* CODA */
+		case 0x19830326:  /* FHGFS */
+		case 0x1161970:   /* GFS */
+		case 0x47504653:  /* GPFS */
+		case 0x013111A8:  /* IBRIX */
+		case 0x6B414653:  /* KAFS */
+		case 0x0BD00BD0:  /* LUSTRE */
+		case 0x564C:      /* NCP */
+		case 0x6969:      /* NFS */
+		case 0x6E667364:  /* NFSD */
+		case 0x7461636f:  /* OCFS2 */
+		case 0xAAD7AAEA:  /* PANFS */
+		case 0x517B:      /* SMB */
+		case 0xBEEFDEAD:  /* SNFS */
+		case 0xFE534D42:  /* SMB2 */
+		case 0xBACBACBC:  /* VMHGFS */
+		case 0xA501FCF5:  /* VXFS */
+			return 1;
+		default:
+			break;
+	}
+
+	return 0;
+}
+
+static int find_mount(const char *path, const struct statvfs *fs,
+	struct mntent *ent)
+{
+	const char *const mounts = "/proc/mounts";
+	const char *rp = real_pathdup(path, 1);
+	struct mntent *ment = NULL;
+	struct statvfs mntfs;
+	FILE *fp;
+	int found = 0;
+	int dlen, plen, flen = 0;
+
+	ent->mnt_fsname = NULL;
+	ent->mnt_dir = NULL;
+	ent->mnt_type = NULL;
+
+	fp = setmntent(mounts, "r");
+	if (!fp) {
+		error_errno(_("setmntent('%s') failed"), mounts);
+		return -1;
+	}
+
+	plen = strlen(rp);
+
+	/* read all the mount information and compare to path */
+	while ((ment = getmntent(fp)) != NULL) {
+		if (statvfs(ment->mnt_dir, &mntfs)) {
+			switch (errno) {
+			case EPERM:
+			case ESRCH:
+			case EACCES:
+				continue;
+			default:
+				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
+				endmntent(fp);
+				return -1;
+			}
+		}
+
+		/* is mount on the same filesystem and is a prefix of the path */
+		if ((fs->f_fsid == mntfs.f_fsid) &&
+			!strncmp(ment->mnt_dir, rp, strlen(ment->mnt_dir))) {
+			dlen = strlen(ment->mnt_dir);
+			if (dlen > plen)
+				continue;
+			/*
+			 * root is always a potential match; otherwise look for
+			 * directory prefix
+			 */
+			if ((dlen == 1 && ment->mnt_dir[0] == '/') ||
+				(dlen > flen && (!rp[dlen] || rp[dlen] == '/'))) {
+				flen = dlen;
+				/*
+				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
+				 *
+				 * The pointer points to a static area of memory which is
+				 * overwritten by subsequent calls to getmntent().
+				 */
+				found = 1;
+				free(ent->mnt_fsname);
+				free(ent->mnt_dir);
+				free(ent->mnt_type);
+				ent->mnt_fsname = xstrdup(ment->mnt_fsname);
+				ent->mnt_dir = xstrdup(ment->mnt_dir);
+				ent->mnt_type = xstrdup(ment->mnt_type);
+			}
+		}
+	}
+	endmntent(fp);
+
+	if (!found)
+		return -1;
+
+	return 0;
+}
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	struct mntent ment;
+	struct statvfs fs;
+
+	if (statvfs(path, &fs))
+		return error_errno(_("statvfs('%s') failed"), path);
+
+
+	if (find_mount(path, &fs, &ment) < 0) {
+		free(ment.mnt_fsname);
+		free(ment.mnt_dir);
+		free(ment.mnt_type);
+		return -1;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
+			 path, fs.f_flag, ment.mnt_type, ment.mnt_fsname);
+
+	fs_info->is_remote = is_remote_fs(ment.mnt_dir);
+	fs_info->typename = ment.mnt_fsname;
+	free(ment.mnt_dir);
+	free(ment.mnt_type);
+
+	if (fs_info->is_remote < 0) {
+		free(ment.mnt_fsname);
+		return -1;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+				"'%s' is_remote: %d",
+				path, fs_info->is_remote);
+
+	return 0;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	struct fs_info fs;
+
+	if (fsmonitor__get_fs_info(path, &fs))
+		return -1;
+
+	free(fs.typename);
+
+	return fs.is_remote;
+}
+
+/*
+ * No-op for now.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	return 0;
+}
+
+/*
+ * No-op for now.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info)
+{
+	return NULL;
+}
-- 
gitgitgadget

