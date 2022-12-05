Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B2CC47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiLERwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiLERvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482186153
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:48 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so19802360wrl.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CJhC9zf/tPjJhvDDmpb9psUAlq9xPX1O0pWhY3soLg=;
        b=WrxqBQa2FRgZhQufNZj07BQlw4FbnD8Ojwzl0fyLabaAebAx7U3xAdw5P+0ne35Ql7
         7BEQ7Iq2kWkQLnEoVR8sroxy5NcMGQf1PdsqT9AkMduAFITvYl6B4kYDobAxuA5U0h5O
         sdMVPnxHOvRhupYv3X9kg/dAHpEtyXTpHcdpEWd/f69BzQzbRArFxB5uh6MrXAoWKe/Z
         0iyQcPIYI1QTEiPALl+cGsx0fB5Selb2aouQaZf8MiKC6i5dkijBX7o45CTMWartVFpY
         vH5aEyG8jYJYmadc/URN/VrIgPyduXCmSvyYbDR7phwFYIg28hSUbzqSsp5RdZXbYGTy
         ZIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CJhC9zf/tPjJhvDDmpb9psUAlq9xPX1O0pWhY3soLg=;
        b=Ms7WEOCArIXaUhyi3mHSV405dVmjDrRyR5uyGp39Vjg7+tcIuJNIvbyht/Dzb1qWVA
         PovIgBAccWcVu4BW+OTQt+4Qv9BsANABMzJwbul5VdFOHnMr5i/jKC0oCP2KQV9yaGfk
         sd3zQIHJWuOVWDOES5RBTUvopVZ+UvHlshInjB2CBWpsxsWTh3DG1LLln1qx5aDSdjyo
         /GR705Oe7IpPR+5dTJmGHhimYLJvZEoRq03L68fH2FQffsKPOu/t9yXPALx+i5iFc41C
         R7+Khr2Qyfc2pyipphQu6uIjasdo8ZTtQ7A7mDealh52dgadhoBX8klDuwQpTketxN5+
         TCtA==
X-Gm-Message-State: ANoB5plH9H5RkD8bR84rn99Tw9hgTlnozfi5mRsYeGG/uT8mFPhIw9ti
        v2oIyYX+ZDJaHHb5vD4QRA3pblifpVA=
X-Google-Smtp-Source: AA0mqf4jEYSjw5w3yUfgTMeKEnVF8D3wyNikLaTTkJcIUWHY/vo8ELD/XfFslaukAqjqLmovozZ1Rw==
X-Received: by 2002:a5d:444e:0:b0:242:32e9:3a74 with SMTP id x14-20020a5d444e000000b0024232e93a74mr12954341wrr.14.1670262647747;
        Mon, 05 Dec 2022 09:50:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba16-20020a0560001c1000b002365254ea42sm16027157wrb.1.2022.12.05.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:47 -0800 (PST)
Message-Id: <1eec3426aee12bbd674ebd646075f0d4c0b1f5af.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:36 +0000
Subject: [PATCH v3 08/11] strbuf: introduce strbuf_strip_file_from_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

