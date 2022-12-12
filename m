Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E59C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiLLV6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiLLV6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:58:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFE82E5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:10 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v7so6865436wmn.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vIQqKv5xWOKA8gbSfTFvwUL13wNLTqNr35ZzuoxxAo=;
        b=BXT1mtcZpdA3p2cKWELZhP6W+2bR8486qes1QnqYyKf7vE7HQY+A5ahtVC2CI9nVJ/
         57hDZQTB5k0wpRObwUdwS2Qt4M3xBTW3GXsnDGO6wZeYty/6reKnzLfVQ7UOzHqqy6L3
         NUE85S7JEJEwFGWwNRy3Yu5CBoS9BrKj+g2xNlV/nOVqLsIpNaPvwPHgIom5cZWMrBLd
         o7/LeQWHPQVQMfFIOn0U0nThzrwHUbFhnYqpVJXFvQd4I//SZscOAul4NNnfa0zw2UVD
         Uv7qmsHtePgDT8HzXC2jEC4MgZlG6wosGuvTMiS7u8LFQRrx9nBZARnoTFBT6t/biEX2
         P1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vIQqKv5xWOKA8gbSfTFvwUL13wNLTqNr35ZzuoxxAo=;
        b=fG/AfPx10FQUyKntziCO7ymHUWgLD+My5d/7o6zPJ8VNVc2nZv/8A9B2ff2GRoINMN
         72DY0cLYFUhJW0L399efhWjF3q7KRsepKAxds9aks+q07dgL8cY9uzHOnFWWdXpf91+q
         6x2jw300yRuP1itMHql54DX56dnBV25qtZcMI3EZS5QhFS3u5L1oZpDRcqfsW0NOMEGC
         jRJQsMzxMXNIBLMEFyCxVCB0RBAsxJr4Mja3wki5B06ckJSHibSv6aXYVohFEmlCWeR7
         EjDzSh2JAN5hYS3nuAPCGSmiecwohOMckjEcl3cDHopKKDBjs56jfiA95rF69Q5ktOJo
         5x7w==
X-Gm-Message-State: ANoB5pmli42xF3h1ynntNzvKntYo6/sqcnHvQ00VeyAdiMmK300sfik3
        cXCyUdaEzl7qAFMAQnBIJerAY+HVeyA=
X-Google-Smtp-Source: AA0mqf44uvzpiOc4uMqGhGgphMfhLPPkBAViOOWYKG19Me4HrPiB33OO0nLThOhurkASHvsXqyu7Mg==
X-Received: by 2002:a05:600c:1f07:b0:3cf:ab7c:9f6 with SMTP id bd7-20020a05600c1f0700b003cfab7c09f6mr13682739wmb.6.1670882289214;
        Mon, 12 Dec 2022 13:58:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c7406000000b003cf5ec79bf9sm10361577wmc.40.2022.12.12.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:58:08 -0800 (PST)
Message-Id: <eb3ff9d1c056ed1e9b7cf62ca5afab0203d1bb46.1670882286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:58:01 +0000
Subject: [PATCH v5 2/6] fsmonitor: determine if filesystem is local or remote
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
 compat/fsmonitor/fsm-path-utils-linux.c | 193 ++++++++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c

diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 00000000000..629731f75f6
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,193 @@
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+#include <errno.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/vfs.h>
+#include <sys/statvfs.h>
+
+static int is_remote_fs(const char *path) {
+	struct statfs fs;
+
+	if (statfs(path, &fs)) {
+		error_errno(_("statfs('%s') failed"), path);
+		return -1;
+	}
+
+	switch (fs.f_type) {
+	case 0x61636673:  /* ACFS */
+	case 0x5346414F:  /* AFS */
+	case 0x00C36400:  /* CEPH */
+	case 0xFF534D42:  /* CIFS */
+	case 0x73757245:  /* CODA */
+	case 0x19830326:  /* FHGFS */
+	case 0x1161970:   /* GFS */
+	case 0x47504653:  /* GPFS */
+	case 0x013111A8:  /* IBRIX */
+	case 0x6B414653:  /* KAFS */
+	case 0x0BD00BD0:  /* LUSTRE */
+	case 0x564C:      /* NCP */
+	case 0x6969:      /* NFS */
+	case 0x6E667364:  /* NFSD */
+	case 0x7461636f:  /* OCFS2 */
+	case 0xAAD7AAEA:  /* PANFS */
+	case 0x517B:      /* SMB */
+	case 0xBEEFDEAD:  /* SNFS */
+	case 0xFE534D42:  /* SMB2 */
+	case 0xBACBACBC:  /* VMHGFS */
+	case 0xA501FCF5:  /* VXFS */
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int find_mount(const char *path, const struct statvfs *fs,
+	struct mntent *entry)
+{
+	const char *const mounts = "/proc/mounts";
+	char *rp = real_pathdup(path, 1);
+	struct mntent *ment = NULL;
+	struct statvfs mntfs;
+	FILE *fp;
+	int found = 0;
+	int dlen, plen, flen = 0;
+
+	entry->mnt_fsname = NULL;
+	entry->mnt_dir = NULL;
+	entry->mnt_type = NULL;
+
+	fp = setmntent(mounts, "r");
+	if (!fp) {
+		free(rp);
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
+				free(rp);
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
+			 * look for the longest prefix (including root)
+			 */
+			if (dlen > flen &&
+				((dlen == 1 && ment->mnt_dir[0] == '/') ||
+				 (!rp[dlen] || rp[dlen] == '/'))) {
+				flen = dlen;
+				found = 1;
+
+				/*
+				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
+				 *
+				 * The pointer points to a static area of memory which is
+				 * overwritten by subsequent calls to getmntent().
+				 */
+				free(entry->mnt_fsname);
+				free(entry->mnt_dir);
+				free(entry->mnt_type);
+				entry->mnt_fsname = xstrdup(ment->mnt_fsname);
+				entry->mnt_dir = xstrdup(ment->mnt_dir);
+				entry->mnt_type = xstrdup(ment->mnt_type);
+			}
+		}
+	}
+	endmntent(fp);
+	free(rp);
+
+	if (!found)
+		return -1;
+
+	return 0;
+}
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	struct mntent entry;
+	struct statvfs fs;
+
+	fs_info->is_remote = -1;
+	fs_info->typename = NULL;
+
+	if (statvfs(path, &fs))
+		return error_errno(_("statvfs('%s') failed"), path);
+
+	if (find_mount(path, &fs, &entry) < 0) {
+		free(entry.mnt_fsname);
+		free(entry.mnt_dir);
+		free(entry.mnt_type);
+		return -1;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
+			 path, fs.f_flag, entry.mnt_type, entry.mnt_fsname);
+
+	fs_info->is_remote = is_remote_fs(entry.mnt_dir);
+	fs_info->typename = xstrdup(entry.mnt_fsname);
+	free(entry.mnt_fsname);
+	free(entry.mnt_dir);
+	free(entry.mnt_type);
+
+	if (fs_info->is_remote < 0)
+		return -1;
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
+	if (fsmonitor__get_fs_info(path, &fs)) {
+		free(fs.typename);
+		return -1;
+	}
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

