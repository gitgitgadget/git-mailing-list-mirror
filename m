Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A38C43217
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiKPTwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKPTvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CDD4732B
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o30so12685744wms.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yED6eliENaJBDbhgcKLiK4M2LH9Jm+dGgAJNGYKvQeY=;
        b=TP3i8LHiBJMcZTVPGp0PPhMEjnl4tkW9u1xrr6pOde+7LQeJReaJpb+pEkDt8G935s
         5V+azr5I5HJ9u+kbImQZLXXRwVdilCgS4J0N24h201G0F68Gc/+g4SUKyH5NIsh+K4Pr
         tK3W2uEsVEa4v8ZJXGmz/3p+c6V+srYtbXQEszMzrqX+WRQ1FxH/SPWvVkND6g0oAJ04
         IZsI7qW2PTd5iEl8BUwCONp40rpxizZa8RV9yF5JVMb2sZ76xJBhqdNIg5GMwZUkO/BK
         eBCTtTnOynWP6KnURad0AJpsS7wm6ke1ORabspMCxe9YfHux4eOK0Ry2Zm0zNxnMgWUT
         Q71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yED6eliENaJBDbhgcKLiK4M2LH9Jm+dGgAJNGYKvQeY=;
        b=nf7whTPLkdhMQ5ITv8uZ9rD42Xga/PoTli7aXu68iEHpdBQy6ridQwa/KxCZNuXxrb
         ELv0t/lfg4Rw88oxNGW2zTNTwUnfUlbIInoXJIzm4trPsLnxvlQ6l9D/J8C0gfQuU4yh
         NU/sTDxlWm55NuLrlEdlP56fIySs7EzXFBadK1X2ITMcaGYo9H6wJASl65PHqhvP2/JO
         /4FRzrKAOtInOJ94KMUcfNQHuJc8DanoSlDJf1VBXWjDpPyhUVSCZj+nW6z+ZxBl+aBS
         XIIjIqRBoD8Q2tvvLqWHKzFzOVkj9YYtu35nQZBULWDiGC2e7/BuaWSIJxlwTJlEOO+P
         pzLQ==
X-Gm-Message-State: ANoB5pk1SZB4l2Moxx2i1tPhZfg1FCgpXwUjujgZWvg3TJThsqCDrIvv
        iLQlU+lDi5+3lDZSHeljMKbCgzVmkm4=
X-Google-Smtp-Source: AA0mqf7sQJMftLpUwJpkWjIreCwOACgkYTEBDI5g+nfZw6A2MNnA5aTakfya9z6TLf8XzsKHwJvwcw==
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id c42-20020a05600c4a2a00b003b4c00d2329mr3114241wmp.124.1668628309487;
        Wed, 16 Nov 2022 11:51:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b003c6b874a0dfsm4316682wmq.14.2022.11.16.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:49 -0800 (PST)
Message-Id: <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
        <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:39 +0000
Subject: [PATCH v2 6/9] strbuf: introduce strbuf_strip_file_from_path()
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
makes the name change valuable. The return value is the number of bytes
removed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 strbuf.c |  9 +++++++++
 strbuf.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 0890b1405c5..8d1e2e8bb61 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1200,3 +1200,12 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 	free(path2);
 	return res;
 }
+
+size_t strbuf_strip_file_from_path(struct strbuf *buf)
+{
+	size_t len = buf->len;
+	size_t offset = offset_1st_component(buf->buf);
+	char *path_sep = find_last_dir_sep(buf->buf + offset);
+	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
+	return len - buf->len;
+}
diff --git a/strbuf.h b/strbuf.h
index 76965a17d44..4822b713786 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -664,6 +664,18 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
 int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 			      const char *const *env);
 
+/*
+ * Remove the filename from the provided path string. If the path
+ * contains a trailing separator, then the path is considered a directory
+ * and nothing is modified. Returns the number of characters removed from
+ * the path.
+ *
+ * Examples:
+ * - "/path/to/file" -> "/path/to/" (returns: 4)
+ * - "/path/to/dir/" -> "/path/to/dir/" (returns: 0)
+ */
+size_t strbuf_strip_file_from_path(struct strbuf *buf);
+
 void strbuf_add_lines(struct strbuf *sb,
 		      const char *prefix,
 		      const char *buf,
-- 
gitgitgadget

