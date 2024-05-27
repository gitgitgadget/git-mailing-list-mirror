Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269051E868
	for <git@vger.kernel.org>; Mon, 27 May 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824524; cv=none; b=MwVAVhE4em9/AIo9qFcxzZ0bGVc57jjeDZk6NXG9CSLefMa0ZVIQJiev5OEvP52j9m6+JhjHpRvnw8Rq65xsg04xRW9jBH+lAikwQ2VUUo29EN76McM32V+fOjMyjhhpg4GIYFdrEDF12wD0syA+TyTJQawCdrD1L7v79x54MCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824524; c=relaxed/simple;
	bh=MsTG/z+lp6HNVp0efJK7Ehl5C86BZJwISCr64TqPkc0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dstXxwHudQH9ZakFNBCqlyX55AwfZ6uECcjG0pKXbB/shWnc3Z9VlU/L/DzCf5j/6oNuSlmf2zWM3pI6SMUY8HBZu1891//T2VntmpnAxfgvg87mNKl+TwLvv8kYXsqpf9VoMRz0CYlx+nfK0e+HcDGlD6TEG+BG6hKOiEZvqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRWUBbxv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRWUBbxv"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202ca70318so79790915e9.1
        for <git@vger.kernel.org>; Mon, 27 May 2024 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716824521; x=1717429321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtAW4HIlbvdxXMiA8L/JwWgJXzNSwT8PqT8pKGFyRHM=;
        b=kRWUBbxvWzPD5GtGcDHMBk/lTbpKURDAE3SBwO/QKfkxv0z3WD9fzuohPDzwJehPe8
         EM32hatGPf05kCcek9qgJzd7Lgsxx4V3XrCCIzfK4w3/hgg5BcVYoZPQbLE48zLtyORo
         xdLdWEIs1KjIYDFLUKlRksltI2x6bX/BVE0Fipsyw6itx3CX2TsCSyZ1rAuLVhsdgkBC
         z4ThNUcjM+g03AESQ/63FYEZGhpT27moOUspnXaA6CfmtGGLARW8RcdHLRBbC11pzVBe
         nr9e7YNIOgTNZqsY5y19GyfrYd7E7onM8/cGBpYpPUK5qjzk+p9cTl8UOBRlwAB54YBC
         /OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824521; x=1717429321;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtAW4HIlbvdxXMiA8L/JwWgJXzNSwT8PqT8pKGFyRHM=;
        b=INd8BvTlrgX1IndJ1t1BEc+UitAtCL+DyAvUH5YJ++9DiNb+0GrLdigY7vs3mbVnbW
         pgjLGTSa6MID5Ald6P2HmtPJdc9amWYmCFgADJsWYa0bAsSURl5tmC0/OQA7YV6pjSB2
         6KA7cK4znuskB/QR82XnMbMa0Ff4Tb9Iezi3qHRgX5RbqfiSPsyQb2UrV8EUeN5mvo8n
         o835RTAEfc/DOGxbFrHRCyrNxE6Pc97adh5VjRKiQkNh5a4W3AfLDr3AzqV9fp4u68Hg
         UzYlPc1aix7fOsjihpO67JzkzZskjKZ3+xw2a5JARtlrCdbdN/x1FQ3saMbeTvP3WmNY
         rZFQ==
X-Gm-Message-State: AOJu0YxWkJO5EiTSM4uZPEFEE3wx4hjke4nU/1GLCowfgmHwD/VfxVTn
	de29zSjzwnA8h/afUggDwSklQWRnFRQYgbKDY9IXatbgPV50ZrnDa2C7Hg==
X-Google-Smtp-Source: AGHT+IGAttC27Hyl1KsGd03K+3kiTNbXHcPVhWV4V+Xb9lNJIPf0iDEexkzBadwS+pvD+ScpB2pNXg==
X-Received: by 2002:a05:600c:4592:b0:41a:bdaf:8c78 with SMTP id 5b1f17b1804b1-421089b2201mr82944775e9.8.1716824521213;
        Mon, 27 May 2024 08:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-356c8daef27sm7206292f8f.115.2024.05.27.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:42:00 -0700 (PDT)
Message-Id: <057c697970ff49301cd9dc6adef099f53d440c3c.1716824518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
	<pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 May 2024 15:41:55 +0000
Subject: [PATCH v3 2/4] unbundle: introduce unbundle_fsck_flags for
 fsckobjects handling
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

This commit adds a new enum `unbundle_fsck_flags` which is designed to
control the fsck behavior when unbundling. `unbundle` can use this newly
passed in enum to further decide whether to enable `--fsck-objects` for
"git-index-pack".

Currently only `UNBUNDLE_FSCK_NEVER` and `UNBUNDLE_FSCK_ALWAYS` are
supported as the very basic options. Another interesting option would be
added in later commits.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/bundle.c |  2 +-
 bundle-uri.c     |  2 +-
 bundle.c         | 12 +++++++++++-
 bundle.h         |  8 +++++++-
 transport.c      |  2 +-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3ad11dc5d05..6c10961c640 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -212,7 +212,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
-			 &extra_index_pack_args, 0) ||
+			 &extra_index_pack_args, 0, UNBUNDLE_FSCK_NEVER) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
diff --git a/bundle-uri.c b/bundle-uri.c
index 65666a11d9c..80f02aac6f1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET, UNBUNDLE_FSCK_ALWAYS)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 95367c2d0a0..a922d592782 100644
--- a/bundle.c
+++ b/bundle.c
@@ -612,7 +612,8 @@ int create_bundle(struct repository *r, const char *path,
 
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags)
+	     enum verify_bundle_flags flags,
+	     enum unbundle_fsck_flags fsck_flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
 
@@ -625,6 +626,15 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
+	switch (fsck_flags) {
+	case UNBUNDLE_FSCK_ALWAYS:
+		strvec_push(&ip.args, "--fsck-objects");
+		break;
+	case UNBUNDLE_FSCK_NEVER:
+	default:
+		break;
+	}
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index 021adbdcbb3..cfa9daddda6 100644
--- a/bundle.h
+++ b/bundle.h
@@ -30,6 +30,11 @@ int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
 
+enum unbundle_fsck_flags {
+	UNBUNDLE_FSCK_NEVER = 0,
+	UNBUNDLE_FSCK_ALWAYS,
+};
+
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
@@ -53,7 +58,8 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
  */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags);
+	     enum verify_bundle_flags flags,
+	     enum unbundle_fsck_flags fsck_flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 0ad04b77fd2..6799988f10c 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0);
+		       &extra_index_pack_args, 0, UNBUNDLE_FSCK_ALWAYS);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget

