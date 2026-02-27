Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1795296BBF
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235783; cv=none; b=jdh8QBwjFvmztXI1Sj92fJ8HZt7HmZbt1t0ByT65ZZ6vcRB+BGNHAewRA8PccOglYUxGuWypn6dzFRh5cGqLZWG/LOfmF0aKrhTLOonGaRpQbB6GG/Gg5tgyDuLLhDQCtyyispmkYf5K0I/8KtglOlxtG2RodU4XHQEqBl1Rpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235783; c=relaxed/simple;
	bh=mlzJEw6JEvMw7iJ2ttuiQyx/7g85Z0oxyXwRXGivzxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OB66jyRB/q9/LEdI/7qKilbkG4+ROq/sVUX1TYmCbdsVRtze9G+rLFjfrRMEArG7o9IdPq1i0Y1luvlbhYAQN26pXKHMh3hqwixQoGQwaA6kDNBhwIDzmyeFI2qG9JN+uuWUfetUkFD4WbA8kjY5+GoEEBHDM0Q3ZeTUp2yYNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLEOm42y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLEOm42y"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436317c80f7so2364503f8f.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772235780; x=1772840580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI5EGYyWEW1cyUezTJTLtE683buKJEjDOwsfAOa4zMo=;
        b=eLEOm42ylfBbasOdUt3daQOgHK23w0N113XAzLA0Pw0Q1h2wVAmHl2zgGK7+WCC1Lc
         aTZNNn/+tNl2GeaC3Rvtf0pI0xAXwD8rOxU9U1fUFEKJSaq7bs0PXYbGqRkR3KDvzw4J
         q1NEIEFT4DKYl+TO2WiJwrXIEOkpHkZlXU368FZ6mynWyyFmOEQbbXtgLYJh07RrRbzw
         LVmFeW5WLc1PQGSe21CDP9JG/4J6L1t4iIoiV5ct7Lu+pPycL11NG3YlTy5jRFGE4VZv
         MfRm6NGULiR3jC3A7AtqPXB2NV5MPT3DURsEnmBeUZjYHyPZv/mUgfdVAv3TuT61EqL7
         XjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235780; x=1772840580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wI5EGYyWEW1cyUezTJTLtE683buKJEjDOwsfAOa4zMo=;
        b=pETO57vz2kzzdu4HIfmr205sQ0XBjT2/+ry99xZOO5dEVie6Lqv42KjWzD865EAza2
         8yS06aJ27YsdwKfM5iV2DBtAhf8vodjB9YijI7MGoRauz4sxya2cSmcW0HNRtXGbZ9i/
         Ey6BfFoJlySHvZ7pDxfxe35p5gxd/h1dTnKoGdN7xIPySgRxRNN1D3HYbNDx2XfKC8Aw
         Y++u2Ab+5JlJPpm4Dw23uz7E33BZK90W8/LVxb0GWm9Zz2/4IKSX7T89CXgRzIXlcqJ+
         mg5z2MjCYywUuOYGgT77h0b5QM+u27HPnJD5IvAUQ8KWPw59RScojagZzqdYoK4k1Z4s
         H/qA==
X-Gm-Message-State: AOJu0Yxgvc9jM6iJyYkvJKQPZOygSilGKCtXNclYkJb77CiJPBWO3ZVm
	961dn5hcrkYQr7fraY1YRfjFfBanEIJq7oZFSGcgRTRxTDkqT2vlgjGnYsfupIU7
X-Gm-Gg: ATEYQzyNbldF+w43/vQrE5i5Y8KNap7uZIRDM8qe5h1V6V4UemR9paEwV8TbN1DivlP
	EO6oO58517vNsvIvEibajc/UHJ5zwmmrCn5EoXl86CNJQbz384sThcE8rsXMXOhIX0T3RwjRHeT
	/adoXStfoPo5/GnTCgO0No6C+a/XAyBBnZNRvVNuXIzmcLXSMtGPRonzXI33m0i1y05k2019pci
	vXyNYeDMyFgsD8N3WY7EN1B075/+OiSOJsovymZUlEfYqpE1Yo1OqEggWBGUgM1CgS7FvKodzC8
	Q6rXDl2e7KSMLJ2wL15W01b1+ntWbU9g+hlPeHCDkimqxUMPAOu1JMnkRP4LidcWIi/icfwBZbc
	cbahBaRtHVF+Jd22EClbgeE5bQGOF3s5vkrHzjZmmj49iwsE+5HIHkEMcjp1UYwav7AJT5U+JPl
	TeUV6vNLU5rbs7J1+08OqDXsomkgc1HIXrF0pNM3IWcwaDtzwO/M8zcFFM+Dj6Ues=
X-Received: by 2002:a7b:ca50:0:b0:483:78e7:ce15 with SMTP id 5b1f17b1804b1-483c33e9899mr104018635e9.13.1772235779942;
        Fri, 27 Feb 2026 15:42:59 -0800 (PST)
Received: from localhost.localdomain ([105.113.107.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm9710899f8f.36.2026.02.27.15.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:42:59 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 3/5] list-objects-filter: use oidmap_clear_with_free() for cleanup
Date: Sat, 28 Feb 2026 00:42:11 +0100
Message-ID: <20260227234213.17633-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227234213.17633-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Replace the use of oidmap_clear(&seen_at_depth, 1) in
filter_trees_free() with oidmap_clear_with_free().

The seen_at_depth map stores heap-allocated struct
seen_map_entry objects. Previously, passing 1 relied on
oidmap_clear() internally calling free() on each entry.

Convert this to the explicit oidmap_clear_with_free() API
and provide a typed free_seen_map_entry() helper to free
each container entry.

This makes the ownership and cleanup policy explicit and
removes reliance on the legacy boolean free_entries
parameter.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 list-objects-filter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 78316e7f90..0038bfaac5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -143,6 +143,13 @@ struct seen_map_entry {
 	size_t depth;
 };
 
+static void free_seen_map_entry(void *e)
+{
+	struct seen_map_entry *entry =
+		container_of(e, struct seen_map_entry, base);
+	free(entry);
+}
+
 /* Returns 1 if the oid was in the omits set before it was invoked. */
 static int filter_trees_update_omits(
 	struct object *obj,
@@ -244,7 +251,7 @@ static void filter_trees_free(void *filter_data) {
 	struct filter_trees_depth_data *d = filter_data;
 	if (!d)
 		return;
-	oidmap_clear(&d->seen_at_depth, 1);
+	oidmap_clear_with_free(&d->seen_at_depth, free_seen_map_entry);
 	free(d);
 }
 
-- 
2.43.0

