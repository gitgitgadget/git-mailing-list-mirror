Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBB17C216
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109951; cv=none; b=n++WfjXJRnWvakewZ1sxbvXWe4tQSqLoM8gKNVNABb7QRv5ohMnQhKDCbUkS8ZItE2e9/sLsu67GPlZHayuqSXrrzOs6koS7OA+4sQZ1CbcDd4i99z1e223/FA5eT+Yo9CVxE46a2WltcQVaFBPTtkziHKWGffbMQCxbE4wtfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109951; c=relaxed/simple;
	bh=XLb5xiWA4dAF2Fx/JHqqeBya6F3OqFt/2QpQOAIOTOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EI8mb1d8xQUaM3RwVmVnFG7FU86fG+wxu/eC41PRBqJ+Nz/8qgX/5sruofe6c5XSi5R9yrYOySOk0phDYLcWckv+j+ZL4n/74+CIADK0MtEMMmXB2E6r01MFQNiPLPhD9JROsYGLZmmnRJeoS+SKOAdeCr7dZmxymF2Qks0l3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQj8VEGd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQj8VEGd"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f1c490c13so3064074f8f.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718109947; x=1718714747; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=fQj8VEGdTV2QhXnpFcmpDd8OyUfY1LjnxtCB2nOoEenl8nrXdrvDa5d/k+pfETEFKL
         5GilHpEfmKuXO6f6XvtqJjA3xPoa2dHu0oX+ZpSkM8rvZuCJ6vGwtHePtau9wi6hCud7
         1uNkVF+LYvtSsUvS6LKYZeL4Z/eURK5PkT8cFPURvoH5My+OHj6MV87Wpo0XVSdtXgY3
         wME7kbqkubVY503Yp8N4I/u3rKtoniCkM3pyzDHNeWLuupFfDUBMAzdvMFdXcbEZ7Tm2
         7mgqRqb0KqVR1t/5AARG5AlFhoW6CHeL1vDkM9Aho7MrLXjktYHcu5bVfNNWjqbZLuTt
         WpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109947; x=1718714747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=JfgHfR+yyhyrBvLdIBXeJWRC0XyhvItmihfgPMgzI2+Po7BqA1rcIX/vOil80Vbq2J
         j8y210oHZN4L87kYEKh0Y/0II4WpEgnQhc9y2Q6jFOvDFeUQudBwhjdPDU5TKoGLc4V/
         usJMYsxMyRixOTRnq7TL57KjSWkGshMV7W3xc/CMIyFyPT9DTBUg1LE+20Sb5bEb6+Xo
         PUvuvRe6YVamm4AvFmxfHfE77Ph/dHNhAQTjmr2cthSehW6saJDNh5QeMcZt43M9t0oe
         yQ0H38igBiWrjnd/yyd2hXMJxVsk2dgnT1TnDKhzKpZ/FuT2LE6HaXE/SEXADv/J9TNF
         VwDw==
X-Gm-Message-State: AOJu0YxXFufPuSjWcIe7fB+66nLUmTjRV4fFeSUc9ZZtOomFk0KlAHgd
	BbVIc+gEMVA6qce1zXt7EVHf8VaD09oCQYns51F1Wd7pwn+LFGLGosVa5w==
X-Google-Smtp-Source: AGHT+IEVl+pxpLHgZm48UdlpM+T5a/rhtEIkWUMa89wnK+ZO4K83Dg5Yokd2oP1m5cM6RNHHb3j1Kg==
X-Received: by 2002:a5d:6daf:0:b0:35f:aee:8d2c with SMTP id ffacd0b85a97d-35f0aee8ddbmr13208608f8f.15.1718109947059;
        Tue, 11 Jun 2024 05:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c57bac8sm7779120f8f.83.2024.06.11.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:45:46 -0700 (PDT)
Message-Id: <d21c236b8dec9fd8c81a4224c1f63c511b04d8b9.1718109943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
	<pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 12:45:42 +0000
Subject: [PATCH v6 2/3] fetch-pack: expose fsckObjects configuration logic
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

Currently, we can use "transfer.fsckObjects" and the more specific
"fetch.fsckObjects" to control checks for broken objects in received
packs during fetches. However, these configurations were only
acknowledged by `fetch-pack.c:get_pack` and did not take effect in
direct bundle fetches and fetches with _bundle-uri_ enabled.

This commit exposes the fetch-then-transfer configuration logic by
adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. This
new function is used to replace the assignment for `fsck_objects` in
`fetch-pack.c:get_pack`. In the next commit, it will also be used by
`bundle.c:unbundle` to better fit fetching scenarios.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 fetch-pack.c | 17 +++++++++++------
 fetch-pack.h |  5 +++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d2aef21add..3acff2baf09 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -954,12 +954,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (fetch_fsck_objects >= 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >= 0
-	    ? transfer_fsck_objects
-	    : 0)
-		fsck_objects = 1;
+	fsck_objects = fetch_pack_fsck_objects();
 
 	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
 		if (pack_lockfiles || fsck_objects)
@@ -2046,6 +2041,16 @@ static const struct object_id *iterate_ref_map(void *cb_data)
 	return &ref->old_oid;
 }
 
+int fetch_pack_fsck_objects(void)
+{
+	fetch_pack_setup();
+	if (fetch_fsck_objects >= 0)
+		return fetch_fsck_objects;
+	if (transfer_fsck_objects >= 0)
+		return transfer_fsck_objects;
+	return 0;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[],
 		       const struct ref *ref,
diff --git a/fetch-pack.h b/fetch-pack.h
index 6775d265175..b5c579cdae2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -101,4 +101,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
 
+/*
+ * Return true if checks for broken objects in received pack are required.
+ */
+int fetch_pack_fsck_objects(void);
+
 #endif
-- 
gitgitgadget

