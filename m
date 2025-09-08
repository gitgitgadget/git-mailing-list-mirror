Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679C22579E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309483; cv=none; b=ZIM0JrU0qQRhKgzBgxs0m7BS7ePnVVWUm5YpG5P97a5KQF2Ul3amRSCFQU/4nO7rRs52UJv7nzjgvx9TN4mjxuPEK7d0Bo4F+Xg1/IUVNWhFtTuSGiKzL9Mi6o8x5mJFTYNwfFMtND1WamQqbzm9ShUIuzGj+PPcZO5EknxiqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309483; c=relaxed/simple;
	bh=q5z8u2b0Fx0+ztikiCtQq3ZTrLXPtRP91pyu7vfc0Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2azDyhIgkZNPboB33q53EZjrBxgdz5k/VVthiCQzAru14i3YD8l2NiZTARpIY8UCbaOmlVDA7akQxIv5e4N+uMt0M0n5h1/ksnO0EvwO/p4lYoHHd9XK5gu1kKZh9rdGMDRDnRtvom3p0C1MfGzpFmAgqIeJGD+nc830V76Kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USLsUPFi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USLsUPFi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de287cc11so3648925e9.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309478; x=1757914278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTlt32fKcZlq5ck9QmXsAkyKgdSkixXZSVWNU/zypNc=;
        b=USLsUPFixN4HsyqP0exTs1V7dqA6T7wBnYQ0HXXtY8xcYg9qgEfRy8OYVtpir41r2z
         XzW2tGxy9Bpg5cUV52AbXaP3NOuFiRldcG1eHIcVyW4J0sgxKWgI7yvbIE5jC8o6WK8f
         WH/FMuImTf90RrOY7MZk5eyLfoEG1BdOANBuqt3Q2Z6mLbso9AToDDnLViZC3yhe77lt
         aQj9R+E1cjI1ws4J410G1JX7bqCL228NyenNFNSjJRkATWykWGjHdp/xOCtWPVg1lemY
         pvNrViK7lM7JmxiiS2OPKJxCb1Mh4EUU4MZjkTVLvEK1pGlc9es+p+bEXvGoZsYZ0I8+
         nEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309478; x=1757914278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTlt32fKcZlq5ck9QmXsAkyKgdSkixXZSVWNU/zypNc=;
        b=q5EkT2VfvyFIZui0mbgJvWlmZN+aKXQ5gZXNVyG24+Ym8FPiQJ/8iGiIAqlWkkNwXC
         ZqTVEDR+9QWODRTic80iLw1ZEqVx+cbpvUQIBXVC7myTa+CpmUQr5B8TW8w+LTHuQJus
         OrK2IR1QyBcDk104X2BBpxSJTq/Sgfd4uhS5zsT4JG+90mgOlwb4OvRzskg3JAVW4M5I
         OKsplAm7D9JA+TfHvCawmvdXHaf96SNKPfUjaUKdCDt7CtJ4tRMD40U5FGtcPcyejn04
         zbI3nU3pGtQDoVrXNBxDlapMnAHVKw/1T62bqWTgjmTUfyxjk/jOO4IDEt7zb+JdJ4ia
         JMkg==
X-Gm-Message-State: AOJu0YxeH1SMOYm2jE+n3udDABJYYuiSD8Vl3eTONA+wI4dcZvpJkaK6
	//suK2YTyJWUsXJa1ecgLxymiQQ8O6yxQzUsI/SW+vyYZ8hYHqEZugcYhet7vw==
X-Gm-Gg: ASbGncvw7L4ZksbcCXo26xeqyUNvP9Qd8yDcBEvF9tB/m3bHJlof/jKnowj5yGi9Xi/
	4Jt0BtlOeM7T1hv+0cdhL9pVYqJZK4qoHzqrCU8UjCrbbZ8l7u+ZH6BJnWtaZrB9VDs0SviLs4a
	PZBC91UO7NoFRRGM1GCGYTQC0fZFZU09lOOTuAmwFz79luDOtzylthgbjfjDHVg58oGdXVUzqPD
	+xV6naKy49oYbeP1IHAtATRISbhpiyW2k8IxfC3j+0CLOY2xSbP1ud1+HcB4N8muEPs8ksjjeHK
	CB9p8GeduH1frcQgDQYCFxqHPdcMf+kfAhdnO15R/PLkD1CbkIAiwRPMU3paw+W95wBGL3+CVJo
	LTe91zmz0gT0sZZnzBIxit4K8XmAy2QTrHgPRw2E23KPtx4f0nQyF6IywQy2MWbbYFbTtP4KroN
	msYD4r
X-Google-Smtp-Source: AGHT+IEO1KP0UNUegcvRPBO+of+nmLURrM4kJc9wsUlflvlKRMLB10faLLjr1ONdZNtoXEFE8ew6cw==
X-Received: by 2002:a05:6000:26c1:b0:3c2:502:d944 with SMTP id ffacd0b85a97d-3e61ce3dee1mr5208523f8f.0.1757309478187;
        Sun, 07 Sep 2025 22:31:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 3/7] promisor-remote: use string constants for 'name' and 'url' too
Date: Mon,  8 Sep 2025 07:30:49 +0200
Message-ID: <20250908053056.956907-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.174.g123d41a7fc
In-Reply-To: <20250908053056.956907-1-christian.couder@gmail.com>
References: <20250731072401.3817074-1-christian.couder@gmail.com>
 <20250908053056.956907-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit started to define `promisor_field_filter` and
`promisor_field_token`, and used them instead of the
"partialCloneFilter" and "token" string literals.

Let's do the same for "name" and "url" to avoid repeating them
several times and for consistency with the other fields.

For skipping "name=" or "url=" in advertisements, let's introduce
a skip_field_name_prefix() helper function to keep parsing clean
and easy to understand.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 98ba59e952..3913e32c11 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,12 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+/*
+ * All the fields used in "promisor-remote" protocol capability,
+ * including the mandatory "name" and "url" ones.
+ */
+static const char promisor_field_name[] = "name";
+static const char promisor_field_url[] = "url";
 static const char promisor_field_filter[] = "partialCloneFilter";
 static const char promisor_field_token[] = "token";
 
@@ -497,9 +503,9 @@ char *promisor_remote_info(struct repository *repo)
 		if (item != config_info.items)
 			strbuf_addch(&sb, ';');
 
-		strbuf_addstr(&sb, "name=");
+		strbuf_addf(&sb, "%s=", promisor_field_name);
 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
+		strbuf_addf(&sb, ",%s=", promisor_field_url);
 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
 
 		if (p->filter) {
@@ -563,6 +569,15 @@ static int should_accept_remote(enum accept_promisor accept,
 	return 0;
 }
 
+static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
+{
+	const char *p;
+	if (!skip_prefix(elem, field_name, &p) || *p != '=')
+		return 0;
+	*value = p + 1;
+	return 1;
+}
+
 static void filter_promisor_remote(struct repository *repo,
 				   struct strvec *accepted,
 				   const char *info)
@@ -610,8 +625,8 @@ static void filter_promisor_remote(struct repository *repo,
 
 		for (size_t j = 0; elems[j]; j++) {
 			strbuf_strip_suffix(elems[j], ",");
-			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
-				skip_prefix(elems[j]->buf, "url=", &remote_url);
+			if (!skip_field_name_prefix(elems[j]->buf, promisor_field_name, &remote_name))
+				skip_field_name_prefix(elems[j]->buf, promisor_field_url, &remote_url);
 		}
 
 		if (remote_name)
-- 
2.51.0.168.gc8716bf361

