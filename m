Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A94C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiLVPPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLVPO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9B233AB
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bx10so1996359wrb.0
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CJhC9zf/tPjJhvDDmpb9psUAlq9xPX1O0pWhY3soLg=;
        b=PHQKjY6bv7//fGYmweVktbm+BJMKMdgw6Un7VFMl/NygMb9EeJnKEca70KzagaqIkc
         ZZgjg6hAnO7Vx8+Z8lQj6cCoVX3VrPKXgHsZmhRGlMMrXphF18o1KWTSt6+l08DJ9X9w
         YxO5SOkeFqP+zGRlbBL8katzDNlOjNY/f9gr1X1HeTlECEiyrJQ3YJ1Jka8dJVDK+J28
         IdDrdvfUcvR6B0oYfp2IOChuGT/yrXuxJLEMMNOomq1GVCMscziTsT6wxKKcVbn6zbby
         mae/I6MFK/s0zoiZL+pOkzWXb4+ruyb91bQqHngVuhbobD+Y8aFk1XfGK/vKQhunsurR
         neNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CJhC9zf/tPjJhvDDmpb9psUAlq9xPX1O0pWhY3soLg=;
        b=vX73A1ejCLYbaVD7veYZtiixCMzcSdJJ0NSozPSmwtBQWAxFc7tLg7V2ix2Bx56Aa3
         iirdcxgiT4XvioMn4BBLiRBNJ4pjgYDThG7znEypXP66+9XMLcoBPdqyje1oDjg3N+Mc
         63lZlzk6Oz1zrrGaxYMV8DQpF9yum2ll+KvP7haeoV5TfwCur29FPGVHTxH8guw9fEY0
         FskWOPUi5Lnrvy3DuIUGBeL64WmZVp870p9Me1hxfACyTH9vcma2D9MzBa3+jSHxKAZi
         u1pWolr+gdk2X3Y8pEXre430GYQWoXtblkHABX533q0vGRNw6i9Q2XLzDGftyPfaSTJ6
         87dg==
X-Gm-Message-State: AFqh2kqkcpwTcsI0y/Z3AWTmYLWY/WJyY39mE+0jet4QWKDy6NJda8RU
        SXcXPeZ4Y4XG3IrbQ5VZiZsT70jwrC4=
X-Google-Smtp-Source: AMrXdXvxMmeUxfebtrQBOILgkmdijxzUwnqxPiOp84K5YVP7IehiAbqtWIwe02LOY9TVhbfOZkFaMA==
X-Received: by 2002:adf:f3d0:0:b0:242:6f93:d558 with SMTP id g16-20020adff3d0000000b002426f93d558mr3887831wrp.67.1671722066502;
        Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d52cd000000b002425be3c9e2sm804330wrv.60.2022.12.22.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Message-Id: <d13bd6cd95dad95be1f6fd63e48f4923350d75cd.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:14 +0000
Subject: [PATCH v4 08/11] strbuf: introduce strbuf_strip_file_from_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The strbuf_parent_directory() method was added as a static method in
contrib/scalar by d0feac4e8c0 (scalar: 'register' sets recommended
config and starts maintenance, 2021-12-03) and then removed in
65f6a9eb0b9 (scalar: constrain enlistment search, 2022-08-18), but now
there is a need for a similar method in the bundle URI feature.

Re-add the method, this time in strbuf.c, but with a new name:
strbuf_strip_file_from_path(). The method requirements are slightly
modified to allow a trailing slash, in which case nothing is done, which
makes the name change valuable.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 strbuf.c |  6 ++++++
 strbuf.h | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 0890b1405c5..c383f41a3c5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1200,3 +1200,9 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 	free(path2);
 	return res;
 }
+
+void strbuf_strip_file_from_path(struct strbuf *sb)
+{
+	char *path_sep = find_last_dir_sep(sb->buf);
+	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
+}
diff --git a/strbuf.h b/strbuf.h
index 76965a17d44..f6dbb9681ee 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -664,6 +664,17 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
 int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 			      const char *const *env);
 
+/*
+ * Remove the filename from the provided path string. If the path
+ * contains a trailing separator, then the path is considered a directory
+ * and nothing is modified.
+ *
+ * Examples:
+ * - "/path/to/file" -> "/path/to/"
+ * - "/path/to/dir/" -> "/path/to/dir/"
+ */
+void strbuf_strip_file_from_path(struct strbuf *sb);
+
 void strbuf_add_lines(struct strbuf *sb,
 		      const char *prefix,
 		      const char *buf,
-- 
gitgitgadget

