Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63567C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiKPXXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiKPXXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:23:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6AB7CC
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so32720114wrt.11
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzsaAR0X8JQprc/ENUUg7TQxj4tsxrHAeMaKjdaTLuE=;
        b=S1I6CYeqOcXDOd2UNa0/aPu1S9ke7WU8Fo2CNmi/k/N13yev6T2TMOEsbYab5o7PDU
         Y/oeOAlW7HZp7W18hHznmM1GQovicWlUyko3PiZawLF2ufWlTt6O19fOxKkXeohQ/c9T
         Tjh+5HSHm+htnQCgJypvLHT7QniFCuFxCKEPbxeh6mdR+myXq3a0bifwvnoQyvLMlqip
         JuLZjm5nARRdQGpwsxXc3xOYHDnLoEWyIcBT8tc84kaSajJxj1731Q29IcKr78AdWfBO
         vL/f3ulpQmKuIgW1i3rHc7HdKylPOO5kSBmDnguxmDagyCy6LDRS+JjXyZ1xNe+u7AOZ
         naXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzsaAR0X8JQprc/ENUUg7TQxj4tsxrHAeMaKjdaTLuE=;
        b=oG0Q/DxWJ8ZhQSaoDVZ1xCim9FU0Lw5LHoqC5Fy4K+BSSkUwwYOBXxaSvUH0B2ckwK
         0FoKFymDVBwcSG/nhkQLo68mIzAbmxDWcJxW6X8O0MYMazIIb0oU3DeQhqhQE7ngKTJ6
         byGsQJCidUt3K3fpNEPzqiC9xGdbK62rmJL9fy/TomkgvfyM+zSEr46csVeX6DckgSy4
         TZsL4jRWHf5SBOaHF+tEW4R9OdUprp+um8v0GMKA2ovyB6y32t6OAGYlS1EOmWvEx6bu
         GJ1BgA5kRsFyDq0YeVLvcoT9NGxdlk80lFAjbfyiLicpAfhNuJuQpmjsTAvVnLC1riEw
         5ZOg==
X-Gm-Message-State: ANoB5pkzOxKRjKr5JDfGYj9whvagfioZ65wcqBTnFUf5SnYsfdFS7KGG
        9U8H+LnsM6TsSNDkO2lXsIsoi6b3yGM=
X-Google-Smtp-Source: AA0mqf779cv67EjsOOWL/TvT6KOOodyjpDGP2pvFGk78o3sLZ3tQH40cv/0zuYb6N1aYL04G2wYzXw==
X-Received: by 2002:a5d:5087:0:b0:236:8201:11a7 with SMTP id a7-20020a5d5087000000b00236820111a7mr14834812wrt.704.1668641023223;
        Wed, 16 Nov 2022 15:23:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19-20020a1c7513000000b003b4a699ce8esm3434358wmc.6.2022.11.16.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:23:42 -0800 (PST)
Message-Id: <aa405379891bdb1a8fcad750767aedd965db77fa.1668641019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 23:23:35 +0000
Subject: [PATCH v3 2/6] fsmonitor: determine if filesystem is local or remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

