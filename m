Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3F7C25B0F
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiHLUKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiHLUK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CB6592
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso4799523wmc.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=YKKdcJFhp+40tORJ9u012i+7uSC/4xTtFFym2CPkqAw=;
        b=lc26Ncc+9ptdvl/RxG8M9J+YCXeQ5bPqBSoRduYeuesgQD1q5bPRB1GbbzIJ+kPDvm
         po2A6baLh0PVCxU8OPfpGcUrnzQ1o5+x4FNBS84UIgiVob9ZZRk5lwAyR6xiXw4VJKvn
         tOKuOhtxW5JexsFKidyF5zlb6hBt8RaK6F2ec+pD9e14SOcaHc1xkRa25t5V6+XgCE/h
         C2Emz5EEi0R2KyGOBBzK+9ChwjfIRouLvv4aqd+rP7bZIgHiZMAkkCR4M+7bP/Cai0MM
         bULsPUpsHgc6VaCQ9XsH2wkqJhhdrgymWf48fnOEbXuo0qVE8M7lBAshlwoCoOagE15w
         lVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=YKKdcJFhp+40tORJ9u012i+7uSC/4xTtFFym2CPkqAw=;
        b=T7cq9mQIOPzVIaMVI/TCW6iQq1kh8xKenkuD8DnqB5blku4W6A6Yxgx22LlGi+vhJU
         a1YG1SYC/s9I9mJusQdSrqyj9s4r0kLe+1fvdKz7YpXt0bU/nUtB6L5tFDxzhPUsErSJ
         s1wwpnfI2AxUmr2abun4OVQgPxOCZ1120O1N7XiXTJql+8RdbUkulKvEPPEMudwTU4uj
         Ui4p8iCIE065S+8FyLvsmSFrT+6GTfyYMg/oNISUlwfQVBWUzSOPTmcnozCK9yFIj9Zg
         BgkJMJnatO698AFNX5bWhhe1M38LQ5Cj2psTdloEP3BRZLfvtuRxKcHKFsxFtgHTBXRL
         2gjQ==
X-Gm-Message-State: ACgBeo1mFW1Vj9DNvrYArzjKOUN1f2WqVgSUtwhRYCNqx/k7VQYU5L1d
        iUsyeLbIPKZ+Xv9G8pDsrT2TTvxaIMs=
X-Google-Smtp-Source: AA6agR4l7r7cU/KTeP6DaUO5QCaTuOSMi03Tt/EFd09HEM4bgjv09yhsnzH3mpbPXANxvJMAqI2piw==
X-Received: by 2002:a05:600c:214d:b0:3a5:ce18:bb71 with SMTP id v13-20020a05600c214d00b003a5ce18bb71mr2792622wml.1.1660335025308;
        Fri, 12 Aug 2022 13:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003a37d8b864esm552861wmq.30.2022.08.12.13.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:24 -0700 (PDT)
Message-Id: <18f2ba4e0cdd9aea213dc7d0e908c6c0d8eccfd0.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:12 +0000
Subject: [PATCH v4 04/11] scalar-diagnose: move 'get_disk_info()' to 'compat/'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move 'get_disk_info()' function into 'compat/'. Although Scalar-specific
code is generally not part of the main Git tree, 'get_disk_info()' will be
used in subsequent patches by additional callers beyond 'scalar diagnose'.
This patch prepares for that change, at which point this platform-specific
code should be part of 'compat/' as a matter of convention.

The function is copied *mostly* verbatim, with two exceptions:

* '#ifdef WIN32' is replaced with '#ifdef GIT_WINDOWS_NATIVE' to allow
  'statvfs' to be used with Cygwin.
* the 'struct strbuf buf' and 'int res' (as well as their corresponding
  cleanup & return) are moved outside of the '#ifdef' block.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 compat/disk.h           | 56 +++++++++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c | 53 +-------------------------------------
 git-compat-util.h       |  1 +
 3 files changed, 58 insertions(+), 52 deletions(-)
 create mode 100644 compat/disk.h

diff --git a/compat/disk.h b/compat/disk.h
new file mode 100644
index 00000000000..50a32e3d8a4
--- /dev/null
+++ b/compat/disk.h
@@ -0,0 +1,56 @@
+#ifndef COMPAT_DISK_H
+#define COMPAT_DISK_H
+
+#include "git-compat-util.h"
+
+static int get_disk_info(struct strbuf *out)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int res = 0;
+
+#ifdef GIT_WINDOWS_NATIVE
+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
+	DWORD serial_number, component_length, flags;
+	ULARGE_INTEGER avail2caller, total, avail;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
+		error(_("could not determine free disk size for '%s'"),
+		      buf.buf);
+		res = -1;
+		goto cleanup;
+	}
+
+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
+				   &serial_number, &component_length, &flags,
+				   fs_name, sizeof(fs_name))) {
+		error(_("could not get info for '%s'"), buf.buf);
+		res = -1;
+		goto cleanup;
+	}
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
+	strbuf_addch(out, '\n');
+#else
+	struct statvfs stat;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (statvfs(buf.buf, &stat) < 0) {
+		error_errno(_("could not determine free disk size for '%s'"),
+			    buf.buf);
+		res = -1;
+		goto cleanup;
+	}
+
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, (off_t)stat.f_bsize * (off_t)stat.f_bavail);
+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
+#endif
+
+cleanup:
+	strbuf_release(&buf);
+	return res;
+}
+
+#endif /* COMPAT_DISK_H */
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index b9092f0b612..607fedefd82 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -13,6 +13,7 @@
 #include "help.h"
 #include "archive.h"
 #include "object-store.h"
+#include "compat/disk.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -309,58 +310,6 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
-#ifndef WIN32
-#include <sys/statvfs.h>
-#endif
-
-static int get_disk_info(struct strbuf *out)
-{
-#ifdef WIN32
-	struct strbuf buf = STRBUF_INIT;
-	char volume_name[MAX_PATH], fs_name[MAX_PATH];
-	DWORD serial_number, component_length, flags;
-	ULARGE_INTEGER avail2caller, total, avail;
-
-	strbuf_realpath(&buf, ".", 1);
-	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
-		error(_("could not determine free disk size for '%s'"),
-		      buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_setlen(&buf, offset_1st_component(buf.buf));
-	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
-				   &serial_number, &component_length, &flags,
-				   fs_name, sizeof(fs_name))) {
-		error(_("could not get info for '%s'"), buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, avail2caller.QuadPart);
-	strbuf_addch(out, '\n');
-	strbuf_release(&buf);
-#else
-	struct strbuf buf = STRBUF_INIT;
-	struct statvfs stat;
-
-	strbuf_realpath(&buf, ".", 1);
-	if (statvfs(buf.buf, &stat) < 0) {
-		error_errno(_("could not determine free disk size for '%s'"),
-			    buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, (off_t)stat.f_bsize * (off_t)stat.f_bavail);
-	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
-	strbuf_release(&buf);
-#endif
-	return 0;
-}
-
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 58d7708296b..9a62e3a0d2d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -258,6 +258,7 @@ static inline int is_xplatform_dir_sep(int c)
 #include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <sys/statvfs.h>
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
-- 
gitgitgadget

