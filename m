Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4E2D063E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913623; cv=none; b=XrCj3/2tGbJEyvTUbBmav1uU69dajzmD/Ct2Eo3IHfhNh6BbvMZiT5tC6LO82vJeAg72s391NsFI0rjudfsARCDt/RMERJd9VIZozPtduf+vEkzv+aOOf5g9FNFoXJuyGqiVResJiDtnPhe88hBFiA5Huod42pydwiVlsQFropU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913623; c=relaxed/simple;
	bh=cgGqDBmVuxJxiRnpznF3R225lLxKuD1RYhg0P/y5FFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1lkOp8L+tuylY9xOkifSHEzgh2ed7Zs/OxtoxTyb1yLCzgEfKVKycQzdrs/THFVwkFvCwZBzLjTbPEAlenwfNT3qCBeV5qURnxYLqJ8gKol+mbXnSgkq7pL7W9v/yY9BsnhvPYdp9cT8TotTLkfyyfhEhS6L2d4cL+e5guvAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lu90yWy1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lu90yWy1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-826c49b7628so2649627b3a.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 22:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1771913621; x=1772518421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebeBY9tzRPeLgOavBteRJv4uQqSMuAsUSBDptzUOquc=;
        b=lu90yWy12M+jw8KKNgRq0XGijPYFj9TqjduX9x7RI2ssUawbDZ5BvpF6iz92nyFHSL
         /N5SeXDV3/+0LwA9DHJ/1Xx/PcAue2iD7GcZ72YyqbzedeGfTY1TQb706RgGbxJZo82p
         Qq6q/TzLkqVdUm4Sk0/WmiPsU1pPouTRxPDQlBsr09nFU0sdqb8QvTv2YXudfT+0YZDo
         W/W90gFHeLbDB4arYqugH4nFzp5KVn2LlDkpXswjzDWfWz3UXLR1bCk2MBDG/1Kui0G+
         nlJFJdPfP2SuNelodba50UolmmCkXNqHqe8JBaRtzZqclXEOTC97uZsaEt4GtE6eIRW0
         UiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913621; x=1772518421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebeBY9tzRPeLgOavBteRJv4uQqSMuAsUSBDptzUOquc=;
        b=W8aQ+wBnfweE7JK+MUpBlxJVAde0rDhOqLTmK85MXkJqR7Vks8kwx6UEpK4niPTgMj
         jfpb1fa7cub/kpykOcpkBfcKscPG/RKzv8x2AyVS/0bx8lTwUB3QbjW8wXU4MKCALbGu
         RuVULfAESUsOG8TEC3G3nC7oL7zv+TZycDYkUNI9qm8U2ldcgrpAj6F9iNFiOZed2Pdd
         124HJZ35hmj943P/eEGybmNbhb2Te0uI8Mx+hwJwzXBO8N/8WcNpoOg87hpcAjhypWmd
         kEI20vsA4kcB13MLlRDIrvGp9BNzHTqBOGuuF47WwxXXxM2cSC8JQJ4+xNM3gFdVVFQp
         N1bA==
X-Gm-Message-State: AOJu0YzDmazIyaMrDCFhfHQPU4b0iqtA6q5na23pkdPeuBDGVYjlW1uV
	zeKg8cVMRGynq4cHY/tHUUgml88rGcLkALflR4HwWmhC7jPGQIA3OALwyEChrsBfOlipAzNeUxV
	Fa3IM+Y8=
X-Gm-Gg: ATEYQzymjGZEpNsN8uxlceN4Bx+5t7bFM1YcNqRNGTFN+gOAnZxOcv62Aa1IVRJkDeu
	JouX5Rzy+csfTP46Nd4hBy8k0j6MsqonEj1nhT2Ca99eYIutu4Mnsnf1ccFbILC5/umNq2JodfQ
	f5NllNg9zm43H6d3PRd3sVs3D+3nO5PSaizpYSwNfFQXNZtZHWaFy3e3MTGk13sEGut4pS8drw6
	63cje96Oo1W7HhPILezs66jmuIxttgVXwwI4Rxo3aXY+J13Oqm6/wkO8CGN8yxvjHoEL7ZCC2pp
	C48u606w0BJoIFeX8bONcWkXP1SjGyIu6cAOhwH+IjFMSYRtSkrGd2uiKDtBu2bYaWNr9ehxC8Z
	5OfWh9cykZFp6CIqkquDdXDDRudSehOolNR02aE5EuUkUSp+fEMz9NwzLqpOdwfcGuOSriICx7z
	laN1jO5M1Cqwf2KGSpdz2ANbUWHrjZeLSqBfIrau6H6QqokoDVOG9sZRO0CK9rWYdz
X-Received: by 2002:a05:6a00:23c3:b0:81f:4dc7:d44 with SMTP id d2e1a72fcca58-826dab0de6amr8083503b3a.66.1771913620946;
        Mon, 23 Feb 2026 22:13:40 -0800 (PST)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826f2fc0c9esm5692869b3a.8.2026.02.23.22.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Feb 2026 22:13:40 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v3 1/1] diffcore-break: avoid segfault with freed entries
Date: Tue, 24 Feb 2026 14:13:29 +0800
Message-ID: <20260224061329.60364-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224061329.60364-1-hanyang.tony@bytedance.com>
References: <20260212072002.2347-1-hanyang.tony@bytedance.com>
 <20260224061329.60364-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After we have freed the file pair, we should set the queue reference to null.
When computing a diff in a partial clone, there is a chance that we
could trigger a prefetch of missing objects when there are freed entries in
the global diff queue due to break-rewrites detection. The segfault only occurs
if an entry has been freed by break-rewrites and there is an entry
to be prefetched.

There is a new test in t4067 that trigger the segmentation fault that results
in this case. The test explicitly fetch the necessary blobs to trigger the
break rewrites, some blobs are left to be prefetched.

The fix is to set the queue pointer to NULL after it is freed, the prefetch
will skip NULL entries.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 diffcore-break.c              |  1 +
 t/t4067-diff-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index c4c2173f30..9b11fe2fa0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -222,6 +222,7 @@ void diffcore_break(struct repository *r, int break_score)
 				free(p); /* not diff_free_filepair(), we are
 					  * reusing one and two here.
 					  */
+				q->queue[i] = NULL;
 				continue;
 			}
 		}
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 72f25de449..30813109ac 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -132,6 +132,37 @@ test_expect_success 'diff with rename detection batches blobs' '
 	test_line_count = 1 done_lines
 '
 
+test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo xyz >server/foo &&
+	mkdir server/bar &&
+	test_seq -f "line %d" 1 100 >server/bar/baz &&
+	git -C server add -A &&
+	git -C server commit -m x &&
+
+	echo xyzz >server/foo &&
+	test_seq -f "line %d" 90 190 >server/bar/baz &&
+	git -C server add -A &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Fetch bar/baz without fetching foo.
+	# Foo will be lazily fetched during break rewrites detection.
+	git -C client checkout HEAD~1 bar &&
+
+	# Ensure baz in the working tree is different from baz in HEAD~1.
+	# We need baz to trigger break-rewrites detection.
+	git -C client reset --hard HEAD &&
+
+	# break-rewrites detction in reset.
+	git -C client reset HEAD~1
+'
+
 test_expect_success 'diff succeeds even if entries are removed from queue' '
 	test_when_finished "rm -rf server client trace" &&
 
-- 
2.52.0

