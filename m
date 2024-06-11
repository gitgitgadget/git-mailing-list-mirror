Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535D171E4B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088136; cv=none; b=bl5UIC3xvpl3uWjnje5zh5ElmzwFkTmJpxBer4RgklmVVkmSphYjNF8j2XWS+SAx5us9NZlmffAADkoW8qhKZR1Pww4WXL96IZTFkwgZrsbBS8w/I5OWnStXOIdJCnmT5cU1779VmKH1E7imneDcf+bDEdaJLDVhnxjzDrWVoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088136; c=relaxed/simple;
	bh=uY7Ik3MwExJq3S2q6LxEWcHNMokuiMVt7i44ZgC/mlA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cc3C9oaA/DgGU3q09fR9iUq1vN7wCqrz9FinsYNBzLsnFNby1qr0lq5UPnH0nJJgH6ObH0Y07uib2VktOJcKx/gLgrp4pAm0u0jXZOOu3n/wd8xw92bW2+n1/0TKZd8MQ1X/VZQwlql+kkaCHlXxKTh6XBekcB49D1Gjw3jupaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgAqjWJB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgAqjWJB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42172ed3487so28185765e9.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088132; x=1718692932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC8lDPj8VFxY0Lxpu41yeqXcWQrVOyHCBQZ4hCu15jg=;
        b=UgAqjWJB0wRAh4JuAgHA1PGp9s7axAb/OmYTxK2rQbkF2NLBQLrsQWTfFR5hOAAPKB
         Gem2nZtoiJQldmtExbwxgeNroNYjXZSYZI/iHJ1LAPsjCaFMuMM6/Sl1v10WRME1U/kT
         KQ+KHmZMnu0ehrNac6GRie9cQ1qd/w9uzqF0eo1n1SIyV7llgV2XOPP+HZ9IGIiJUtyn
         l+cebvJBDvzj7KusWzi+/eX3cGR8GjexRklCn2ZZg1FSyagtwKyUPudVrEviJW7+Om0l
         Mq00lE9GWVNpeb5MLxeE8cmLib4kQMz64O0FKyxuCeY7o9KVfN9nKsJcJU8AAdzhtVbT
         8HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088132; x=1718692932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC8lDPj8VFxY0Lxpu41yeqXcWQrVOyHCBQZ4hCu15jg=;
        b=D2jLgmXxFTiDVyfXdyHAbSTWBzrwv4JicHvH2Xl9VR/2+hxcHOD37213KZe9g5wj3y
         /GQWFLZHLWEjzfOasqb/Lz5Kodhx01s20PPxANzETlmm1PRso81MCO+Df7lan3JK22AQ
         bgL95dhMc0Qk3daPzkThaeIXUAatNSkz8VT7xiLOV6Tp9sXhQ53XgwH5RmgzsIhg7vKs
         t6wLwbJJRj/nuxJUVRMQR9kWCPhwC/nmbpkK2TSlQS0i9DDnlNtk914z+ly3wziCKxGR
         ZikzvgPuFobsZQOYSlNK+gF/VBdnHoTrRcbm3mYAgBqZeNtYZzYQeQvTyMZFeWiHlYku
         ayiw==
X-Gm-Message-State: AOJu0Yxh6uT7t5FaGlPnfCh/b1GVFJBPi4V0qMNb4FTWtEJPm8uAEe5R
	KR+9v6ZfqcOPH0RW2W3mzBzDiTbYsSbBkwfbBkq8rSnPmXaulER/ZrXZGg==
X-Google-Smtp-Source: AGHT+IEwUwzmdsjZGyQyJvgjCOIOBL9tNJU327s6ZJ6jqzyRRT73cEjOCXTKbwsysYn1kGVMGzN3vg==
X-Received: by 2002:a5d:64c8:0:b0:35f:2092:39fd with SMTP id ffacd0b85a97d-35f20923acdmr5489526f8f.36.1718088131794;
        Mon, 10 Jun 2024 23:42:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2bccc281sm1277472f8f.107.2024.06.10.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 23:42:11 -0700 (PDT)
Message-Id: <0a18d7839be67d6c0be137c7e15dff9663a161a8.1718088127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
	<pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 06:42:05 +0000
Subject: [PATCH v5 3/4] unbundle: extend options to support object
 verification
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

This commit extends object verification support in `bundle.c:unbundle`
by adding two new options to `verify_bundle_flags`:

- `VERIFY_BUNDLE_FSCK_ALWAYS` explicitly enables checks for broken
  objects. It will be used to add "--fsck-objects" support for "git
  bundle unbundle" in a separate series.
- `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is designed to be used during fetch
  operations, specifically for direct bundle fetches and _bundle-uri_
  enabled fetches. When enabled, `bundle.c:unbundle` invokes
  `fetch-pack.c:fetch_pack_fsck_objects` to determine whether to enable
  checks for broken objects. Passing this flag during fetching will be
  implemented in a subsequent commit.

Note that the option `VERIFY_BUNDLE_FSCK_ALWAYS` takes precedence over
`VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle.c | 10 ++++++++++
 bundle.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/bundle.c b/bundle.c
index 95367c2d0a0..53ac73834ea 100644
--- a/bundle.c
+++ b/bundle.c
@@ -17,6 +17,7 @@
 #include "list-objects-filter-options.h"
 #include "connected.h"
 #include "write-or-die.h"
+#include "fetch-pack.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -615,6 +616,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int fsck_objects = 0;
 
 	if (verify_bundle(r, header, flags))
 		return -1;
@@ -625,6 +627,14 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
+	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
+		fsck_objects = 1;
+	else if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
+		fsck_objects = fetch_pack_fsck_objects();
+
+	if (fsck_objects)
+		strvec_push(&ip.args, "--fsck-objects");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index 021adbdcbb3..a39d8ea1a7e 100644
--- a/bundle.h
+++ b/bundle.h
@@ -33,6 +33,8 @@ int create_bundle(struct repository *r, const char *path,
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
+	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
+	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 3),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
-- 
gitgitgadget

