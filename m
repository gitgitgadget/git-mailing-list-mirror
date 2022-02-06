Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3445EC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiBFWjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiBFWjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A0C061348
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v19so6771679wrv.6
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9tcq3SbDQrWR6k402xQD96ozw8uzjJFlE7nSNFTp9lY=;
        b=RVvhjqfJa4dzQqdfEEOw7O60NL68Qrpz9vN9GiJNbAERMkRpaoO8w0jnhtz+qPACsF
         H1LASj4fN6lkkk+WrAVtxq1qP5CT9dDuyERHodacT+r2tB8tRVSdsJv/oinQqzf4+CIp
         bpvx6s6WCDCbl0on6+v/uzwcwvkRABgfWG/roLJKx0T55jZbA3AASdb1gABa4DJRpWf2
         qBmS88M3N5LttpkdWGTEEI0EZgeY5ES64MRTtjIdSFz8bQ1N6YGzhNf6ivwomukTUNn2
         i+xutbtTuHT02YYbAghREvdPs3XkHlsay9XOBL2Xm8nCQKRfQ/ET4bos/qZZVV/fRAIQ
         p00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9tcq3SbDQrWR6k402xQD96ozw8uzjJFlE7nSNFTp9lY=;
        b=owJO5qNdx4a64JgidsHOEL0FTWcCvYcKl8TDhfxGzm/OMlxP4lsXHylqiX/+L7NZ62
         PRQWCmAjfFnN0YBqMP6sBUb7LiqVpGyYDWrJi7zWxpucUO3lZ3fJioHZG7fgNp4sctUK
         yTYfyghrSI6xPgZRo+UFW2eRZuw9pYyIyk6aLZveku7mQNSFAvi77P0YBR7G5FwLr1wK
         ypAWv00vJKplBa3Z7TU12r5yPHrDRoYk+djryqOqJjWIzlEiHU7YkmdVntXrq9JMTEqs
         TRMQBwuf1S/oFifvoiCfKzi9bCkKDh082KkslhHURjuSOmOKx1DsvipV2fimubfg/Mmg
         rWmA==
X-Gm-Message-State: AOAM5311z9C/uNlknE2WsjlJ3sYjVvUGI9bA6xcPmJTd9ZHVWQ1euVY4
        8ldrXXJV0cU3AZGMNV4NnA0EW1Fck2g=
X-Google-Smtp-Source: ABdhPJx3WL7R5u+EzgayAYXJhTCM970UrcWcejEaOJ7jPDwI2NjSqAL0MQBCS2JuSlJL/MbT3MMzXA==
X-Received: by 2002:adf:e34c:: with SMTP id n12mr7721650wrj.263.1644187150437;
        Sun, 06 Feb 2022 14:39:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm8912963wrd.91.2022.02.06.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:10 -0800 (PST)
Message-Id: <938e38b5a09c7cf1cef4faca577e969b455e1ea5.1644187146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:04 +0000
Subject: [PATCH v2 4/6] scalar diagnose: include disk space information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When analyzing problems with large worktrees/repositories, it is useful
to know how close to a "full disk" situation Scalar/Git operates. Let's
include this information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 53 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  1 +
 2 files changed, 54 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 30ce0799c7a..fd666376109 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -300,6 +300,58 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
+#ifndef WIN32
+#include <sys/statvfs.h>
+#endif
+
+static int get_disk_info(struct strbuf *out)
+{
+#ifdef WIN32
+	struct strbuf buf = STRBUF_INIT;
+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
+	DWORD serial_number, component_length, flags;
+	ULARGE_INTEGER avail2caller, total, avail;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
+		error(_("could not determine free disk size for '%s'"),
+		      buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
+				   &serial_number, &component_length, &flags,
+				   fs_name, sizeof(fs_name))) {
+		error(_("could not get info for '%s'"), buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
+	strbuf_addch(out, '\n');
+	strbuf_release(&buf);
+#else
+	struct strbuf buf = STRBUF_INIT;
+	struct statvfs stat;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (statvfs(buf.buf, &stat) < 0) {
+		error_errno(_("could not determine free disk size for '%s'"),
+			    buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
+	strbuf_release(&buf);
+#endif
+	return 0;
+}
+
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -599,6 +651,7 @@ static int cmd_diagnose(int argc, const char **argv)
 	get_version_info(&buf, 1);
 
 	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	get_disk_info(&buf);
 	off = strchr(buf.buf, ':') + 1 - buf.buf;
 	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
 	strvec_push(&archiver_args, buf.buf);
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index bbd07a44426..f3d037823c8 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -94,6 +94,7 @@ SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	scalar diagnose cloned >out &&
+	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
-- 
gitgitgadget

