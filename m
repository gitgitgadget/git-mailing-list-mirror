Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68BCC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJNVqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJNVqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:46:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439CC4B4B6
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so6540989wme.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzsaAR0X8JQprc/ENUUg7TQxj4tsxrHAeMaKjdaTLuE=;
        b=qdHCeLiSUquabkOHe/wd+7avFaSo1xJuD//r72lAozdLtCBmDfH7lXCunn8IB4Fpmk
         fDdWZ/DUgObXIrMLqN0Doo8Lf/jJhfREnPIAzZzyEqQYI0WdIxuLS0EkIXtBtukKypES
         2U01RXLT5feaIZSfumVBtdRk4rz4cpIDPXng9T9f/DD13oc9VHAYSce/fLU5DQu0ZbTr
         ZXczla/JiRtFyNWKOMprCcsN41a+e83Hv1pQK/JvAd/+Jq9M+o8X+7meKfUnklaWDmHY
         grM4x40v5h2ttOCnSWtqkoTHMbMxqFMuBBrIzl4FPs12CM271/42bV4bMuwGYB2ZNLd2
         6l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzsaAR0X8JQprc/ENUUg7TQxj4tsxrHAeMaKjdaTLuE=;
        b=QyJpTtp6DYTJiB6AxLxtLNKZVbC87rZ3cYxIY/xuUj+eOYAOuAkqeGZ/drECmOb7fq
         T7kzka4zkQ39+EfD+BLKznVBqXhFd8NiqBmaqL+E01Jrz+37JyhzKoVul79w/Mig2Qpj
         rZG1BLr6dnfEf1bn8hxYNqQOtUfXz7bXe1kv/cXC1Xaf9aKZBkRjt7ZTURjNPr8RPDaW
         QymzOrfTa8KCEZpofoodUDbkW74knA4v7G6OM2KnCcleUFDWMqRkI1Sno6P0C6YEuv/u
         +4k/YmMyPlyMJxekkPBMEWFGGdG9klfB0f3nCqzN95gAIA/L5W/sCRXihi5Bo6apglu/
         ljxA==
X-Gm-Message-State: ACrzQf2m94+ZCWR+oUxneU3a12zL9dqCFNuaByIEmcJzj6kdLn9iIE0+
        mXUHUK9hhyP0+Zz7w198WJJFFdMtABk=
X-Google-Smtp-Source: AMsMyM675EajXu+oaZKhpYJxOuPYCkY0O30MfZjm2gx+1hbGr6ETigY+8/MmFeHTmYiPR/Y3cLqsYA==
X-Received: by 2002:a05:600c:3b21:b0:3c6:172:9c5a with SMTP id m33-20020a05600c3b2100b003c601729c5amr5091967wms.129.1665783956077;
        Fri, 14 Oct 2022 14:45:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003c0d504a92csm7728903wmk.22.2022.10.14.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:55 -0700 (PDT)
Message-Id: <7d7ef78728f890db68166b3b5b6b7dd33f20e62c.1665783945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:40 +0000
Subject: [PATCH v2 08/12] fsmonitor: determine if filesystem is local or
 remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
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
 compat/fsmonitor/fsm-path-utils-linux.c | 169 ++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c

diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 00000000000..039f044b670
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,169 @@
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+#include <errno.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/statvfs.h>
+
+/*
+ * https://github.com/coreutils/gnulib/blob/master/lib/mountlist.c
+ */
+#ifndef ME_REMOTE
+/* A file system is "remote" if its Fs_name contains a ':'
+   or if (it is of type (smbfs or cifs) and its Fs_name starts with '//')
+   or if it is of any other of the listed types
+   or Fs_name is equal to "-hosts" (used by autofs to mount remote fs).
+   "VM" file systems like prl_fs or vboxsf are not considered remote here. */
+# define ME_REMOTE(Fs_name, Fs_type)            \
+	(strchr (Fs_name, ':') != NULL              \
+	 || ((Fs_name)[0] == '/'                    \
+		 && (Fs_name)[1] == '/'                 \
+		 && (strcmp (Fs_type, "smbfs") == 0     \
+			 || strcmp (Fs_type, "smb3") == 0   \
+			 || strcmp (Fs_type, "cifs") == 0)) \
+	 || strcmp (Fs_type, "acfs") == 0           \
+	 || strcmp (Fs_type, "afs") == 0            \
+	 || strcmp (Fs_type, "coda") == 0           \
+	 || strcmp (Fs_type, "auristorfs") == 0     \
+	 || strcmp (Fs_type, "fhgfs") == 0          \
+	 || strcmp (Fs_type, "gpfs") == 0           \
+	 || strcmp (Fs_type, "ibrix") == 0          \
+	 || strcmp (Fs_type, "ocfs2") == 0          \
+	 || strcmp (Fs_type, "vxfs") == 0           \
+	 || strcmp ("-hosts", Fs_name) == 0)
+#endif
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
+	fs_info->is_remote = ME_REMOTE(ment.mnt_fsname, ment.mnt_type);
+	fs_info->typename = ment.mnt_fsname;
+	free(ment.mnt_dir);
+	free(ment.mnt_type);
+
+	trace_printf_key(&trace_fsmonitor,
+				"'%s' is_remote: %d",
+				path, fs_info->is_remote);
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

