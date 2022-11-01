Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C9BFA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKABH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKABHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D4A16595
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y16so18215800wrt.12
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0WcloxmUBLoHeCAmzYfJFJ2dAabXIl2IzKQa0WH0r0=;
        b=KpYRYaN+ertlGZtWDWPoAHVvltzHUUL1ZtDlI/QXgT9ntjGBeDo7eC6lgXui4q8uWE
         EpnpJrIbxVewAej+rVS8H3+DLjNiien9+KIA9P5LRFkQ+CtXeXYPSeZsqLOk9scz0364
         mcE/oWrGi94wjJwFwovWw6FlY9pY4q7Wy6dYYSR8n97OT5ilPrHWY6ZbG7uc6iDUjfUx
         5wG946pBGRml5fjbDn2YynydcGWycPj03Ajd0OORj4b5GsOX81nKYlMbqF+RJCFB0mvz
         07qhS677pEbPDGa+CYhfwYtBlpD04akj1xqaqperKhHK6e8zTXcTIlzJJJRgiR7ZwHtq
         TEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0WcloxmUBLoHeCAmzYfJFJ2dAabXIl2IzKQa0WH0r0=;
        b=bLsX76XHClhUue6Jv1xJcEbDAEDnVz18D8gEwzjxpL/StOaBCO1nd6L4uLVbinMBvE
         Bw3fXyUFdVrPdACOMpqzvjSV8+b/FSzo+dUchXLuecjcpCVkhk3v9lZe2NaUenid2NxY
         U0uqKeJm+IaDyTJRy7MFCCF+YpYYryAzYIIZcZ6VeFmz/tb7DJa6Vx8oRVzneGE0r8T8
         YFKy7IoqPCFaE+RF/7y/kH1zu7NSIwJ7Uk1nl53BZLPjy1G5Vb5dESP8oJEa5wPAgF/R
         HMOcQTyMwI/bW4ZgFetsCAbiuE1JbHbbjNNali6R+7x0uht4itdCxM7gOB1iEranuQV2
         ON+g==
X-Gm-Message-State: ACrzQf0k3fPbaUCaBkscvNH65DY10c8AV8tM0dZwNoaFJtlfHYRqQbYR
        vq1TYEwFKxeruUcgNx/uwQ7JhGRU7j4=
X-Google-Smtp-Source: AMsMyM7l7njlltPMFc13utS7LIRrVBoiDkYnt2AWgD34i1E7f/qQiFEmL/xX/dU/T9NHNnD5zRARgQ==
X-Received: by 2002:adf:f081:0:b0:236:5e7c:4ec2 with SMTP id n1-20020adff081000000b002365e7c4ec2mr9521962wro.641.1667264861002;
        Mon, 31 Oct 2022 18:07:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp7-20020a5d5a87000000b00236545edc91sm8573348wrb.76.2022.10.31.18.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:40 -0700 (PDT)
Message-Id: <2200a70d279adcc6460dcb7bef7b0e681d19a414.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:31 +0000
Subject: [PATCH 6/9] strbuf: reintroduce strbuf_parent_directory()
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

Re-add the method, this time in strbuf.c. The method requirements are
slightly modified to allow a trailing slash, in which case nothing is
done. The return value is the number of byte removed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 strbuf.c | 9 +++++++++
 strbuf.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 0890b1405c5..b5cb324c431 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1200,3 +1200,12 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 	free(path2);
 	return res;
 }
+
+size_t strbuf_parent_directory(struct strbuf *buf)
+{
+	size_t len = buf->len;
+	size_t offset = offset_1st_component(buf->buf);
+	char *path_sep = find_last_dir_sep(buf->buf + offset);
+	strbuf_setlen(buf, path_sep ? path_sep - buf->buf : offset);
+	return len - buf->len;
+}
diff --git a/strbuf.h b/strbuf.h
index 76965a17d44..8a964a08c31 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -664,6 +664,13 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
 int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 			      const char *const *env);
 
+/*
+ * Remove the deepest subdirectory in the provided path string. If path
+ * contains a trailing separator, then the path is considered a directory
+ * and nothing is modified.
+ */
+size_t strbuf_parent_directory(struct strbuf *buf);
+
 void strbuf_add_lines(struct strbuf *sb,
 		      const char *prefix,
 		      const char *buf,
-- 
gitgitgadget

