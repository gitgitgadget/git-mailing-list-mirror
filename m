Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB21339A4
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991048; cv=none; b=Z+r1NFA39LQPuTzl9xeVU0Ov4vYZe9vjZV2005tPMVkTqu5HG9VYFndQSg1/tf/B+pdDPDXClXFsceggZ/Cz01b+MS0L/1XVFRxvLKXBj9FmsVqo5ry/q4obR7yeHETrdTnHYL3dTUAG5J8mEvQUGuY5vMpMihXiMj6FiSwWss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991048; c=relaxed/simple;
	bh=zXxYXV7q9kBB72i7F7F1svz4UoetdzFizCqTpfvXdgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwX363FS7HEsIVX1tkffu2Sjb2dHThhz068uufc7CmJPmjQDRMc6jnz8UQGdD0UWH9r5ozBPzWxveAGRX3lwTfj2B8re6JYY118qh1MsdJnn7SOhk2Li8WHFSaethiSFmk+ae2/nwQtBuAYjZsf1u7G2asjIElxdcpqtSo1V5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfY814cA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfY814cA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso32365815e9.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991044; x=1738595844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4ZW2HD8iqBChRk3a6LTDIZRTdmHbBd3xkjjVsqxF28=;
        b=PfY814cAiWqzpFGBfn8FdgnxHpcs4mf6kWk8D0DuLtNBsRgpYIW4jhS/XfaEttPCXn
         cnIgUoWzHqsn01SpRN/LoYafvrRNJDsx5vgAXPN8tnSFrR+J/nipbYdfDLSnrrpfOfRJ
         YYLcMsj8PyHQhXCUTsA7a563EQBKU7PVn7l9y7rWeVkZ9LgH9zOYPo1GYfA8J+42cpVf
         v9enpXuRyQ2LBUQM2eAotT8NTYjElS5ZMShmphMoxoX7/D5jgg5wRaf14d75GLe7Kkzy
         B5gLOsxPotvOPgZxb4BPzWlhUxa2p9tfGtbfmKZgUdBLZl0QxVFP2aH3n6KruZuv9RXd
         AojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991044; x=1738595844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4ZW2HD8iqBChRk3a6LTDIZRTdmHbBd3xkjjVsqxF28=;
        b=UnqEIfqV74p8tUNTzSOrbD0G4/rbq/avlJm//NbrhOZtj4lDmRpGJTFZKE3f8pHMhq
         2xPeQqc5iZpf42mitNYwvV/k04rEvksj68GbGtcm4vZhOek8sS7PF4KPV5blQ03fi7S3
         tve81rh3mMOjCNTXw0nDD39TZGfvvYgMJF0mlcDXXv9LAZO0UBi2zOtIo9Ozy9f3C41o
         wOztdCS9PuhhB2dZ+OolbXvyGxoowdfmy6i0mU3sD+narJaTAl9MrSpaMUyifGdhW6tY
         1bBHcILIXx2bEXWuzvJXb7WSAZkgN8DQTPFp5N6q3XS6S9xKQjVh2uJgvft6AKs8v9jX
         kosQ==
X-Gm-Message-State: AOJu0YxBsxmGa5oEp514Hr772yvApD2Rl60zI0AWoaNiYhnNLerXVjEX
	9UpSdxsv6XpEtWHxxdgJ++JD/zFsh2SAPrBSigdOO3mrT8Gz6FmbN5QKdQ==
X-Gm-Gg: ASbGncubieu4qDyIM/bm/vWaZJSBeuflWxyEwE5ogzGeQ3Oohe40FE+35GnsyJbtwjB
	JtrEAIVrBdtK05z9IGYzAeOuFquXL/ai7250gDJhL0U4Jn6P9/DU6GGxbQd3FBTIhwv9z8WYi9m
	wMiYogCCVKcfBV0gN8/v+3B+ZRtqhUA1w3gwCdKfZBVKiFuGnXotn66ooyVX3UwSU5QN0cDCXLF
	Aeq10hhUgDGW+Z3estrSiL/ENLsEa36cDXvfXjexKNe97bOqzzfsIb/ujbwDKeX0VH77PuI/23c
	ADyW9Iwp4HWL9NteE2DMC4nqjttz09L2wltxtHUJzWGmJkdp3+VJxNfKzjzuZUI=
X-Google-Smtp-Source: AGHT+IGdlmqYRZbeRyK3hLWDdh3/tx5oxTC3ZX4IcrafvnCilP/1YnrgUwr1QcNio9hpyLQDX+ck3w==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr441528825e9.14.1737991044480;
        Mon, 27 Jan 2025 07:17:24 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm135269625e9.39.2025.01.27.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:17:22 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 3/6] version: make redact_non_printables() non-static
Date: Mon, 27 Jan 2025 16:16:58 +0100
Message-ID: <20250127151701.2321341-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.rc0.95.gcbf174a634
In-Reply-To: <20250127151701.2321341-1-christian.couder@gmail.com>
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we are going to reuse redact_non_printables() outside "version.c",
let's make it non-static.
---
 version.c | 6 +-----
 version.h | 8 ++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/version.c b/version.c
index 4f37b4499d..77423fcaf3 100644
--- a/version.c
+++ b/version.c
@@ -12,11 +12,7 @@
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
-/*
- * Trim and replace each character with ascii code below 32 or above
- * 127 (included) using a dot '.' character.
- */
-static void redact_non_printables(struct strbuf *buf)
+void redact_non_printables(struct strbuf *buf)
 {
 	strbuf_trim(buf);
 	for (size_t i = 0; i < buf->len; i++) {
diff --git a/version.h b/version.h
index 7c62e80577..fcc1816685 100644
--- a/version.h
+++ b/version.h
@@ -4,7 +4,15 @@
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
 
+struct strbuf;
+
 const char *git_user_agent(void);
 const char *git_user_agent_sanitized(void);
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character.
+*/
+void redact_non_printables(struct strbuf *buf);
+
 #endif /* VERSION_H */
-- 
2.46.0.rc0.95.gcbf174a634

