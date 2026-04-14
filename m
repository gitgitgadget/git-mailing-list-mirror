Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F863D6685
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163828; cv=none; b=MtBf4exkFCz2O/HEAwb8ksfBrJlqLYIFpp0K04pWFgVsG3rQsEKdREjyyuByDJPa0pFOc025xC0oEXeq9HQb2tLX7XmSO6OMvacSCs3OIeIyySgqfVffI6aephIboekodZ0U7oEqf+KCBUnk8N4q5Tx4UZwnt4bBNEgy1vh80Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163828; c=relaxed/simple;
	bh=wM6X1kOQ8RlWuvfEoeb3y4LRctIqntGIPQzSL9sCO5Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TGMJg99ZVvsOk0ojgVMA9lgn/o9eSJZn6lcKxVhPxLFCF0a2YkAglRuYvanZG+E0y6woWzXmqcU0/pSS/PC/fsm2CPCMzaegNBuQNOtUANJ6d1XRn57yGyCvS81msm0kd+de42TRjhVpCCNJlVZnWFojSRXil7QI4rIcDoN9NP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+mW2bfC; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+mW2bfC"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d832f2f44cso2795452eec.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163825; x=1776768625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45kNGcKZbNJJ2R6xHYB9UH7NOBs25a7xMtYNOIXh2zs=;
        b=J+mW2bfCmEf94N8vUBNbA89HCFcpe2A5q0BN7pnOjyYKx5tJ5+0K6bRAMGzxSsXKGJ
         b5DrNOGNXEtcvvBhQHJ3dOgXYz8YqlhfvfvxIr8+BcshX9iSlrITpQ3y3qJfSG3m0MDp
         Bp7aRiXB9yULQzzWzUdDHnYHDNXrb9hnzowEhU7Ju0Z5/kkA3yOrsC9ro1kXsjVleLpE
         2A/zRKKDjGgMS7iUSkJV6UlpGmBYVBbdIXk+BlAugxkn7GuEEJraytHlD4TaX8532Ibr
         ZcSmS8mmUPEBhFgAiEq+paDOBaKybVW1SMq2S8zaFEx6gtbqxcOUB63LLGuBnhTxBoG0
         vAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163825; x=1776768625;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45kNGcKZbNJJ2R6xHYB9UH7NOBs25a7xMtYNOIXh2zs=;
        b=Kz+8KhPUtXr+XpVcghNHNcK7NR6YnDplc+pvTL4ziifIs04SJkI4ALhaBfNa5BeItO
         olLzBo+RKSG7SNvAcc1xDRYKwL9SjcZL17528EDNSUhl/GoMfFR48y91hGfZyrAm38fp
         0EIEcoKjFSZSwzA0plbuznEWM7tmxZt2tDQYuqKl9LtwrZSU9OBMDg1+UzlCrvC4K2rg
         9Ndb4CxB7BxZx3BaxyYnc1PB3Zf3019KlEGvR+q5Wh8obGCUK92O5FkkAyIMm7Bfenox
         Afje1ZEAT1kDsfNg1uzp3poxXSo3owvaEVbKgAOCk19xMjrMKsYhar+PgVw172O3optU
         oTeA==
X-Gm-Message-State: AOJu0YwRzZ6/JuKKSBQNZ2JuJfCRgwMo9ayeo5zPO/uR/LPDExDAPqQF
	LBjF4Lm8DMU/mXirRds8iFCjp9yky92fQ9l2lPpno+hHBggSi9Nh4uaWR+Hk6w==
X-Gm-Gg: AeBDieuqM9htFtgXx7sWJdiorxxGzkQgkBLfePPyvv+ky8nhKMBuQtK/hBVnFrzDNHt
	loZqEfbDZ6N9AKt/poxhOjrcrRtwsVXv+Xv2cIqIdvUqPumfcT21TSqJiw8Y68mdxPyESbFRHPz
	NiLy/EjAMFHnUXCxP9FW/J8XAN4HQxzmTdCT+Hl6Th4e8XANBDonelVylvCJwbT052dfGtDpnJF
	+QS15GbrIJxJ6Ruq9i+iU57YVFLCCxhdpdFoSuG8HDq2e57M9jCgEVzZOF2mrA8VH5WWg+FJsYR
	z0bpTahEgEXeVynJaUG1YkQAJSwXgwE2y83PNY4WByPJpc0t2Wu1zZNNkJGXmVINzLWb+5fK/D1
	8wBa6+wdylzBwS0EuwNHp4EclsbG6Xp4iWtD9KcEYgvjomCH64ZBsKRfckZKwBq6PKYr2pfs+Ko
	Vq662AhWVJeYY5gp04NOZAczMXNFST
X-Received: by 2002:a05:7300:e207:b0:2d4:afb3:7af4 with SMTP id 5a478bee46e88-2d587990c51mr9592544eec.10.1776163824631;
        Tue, 14 Apr 2026 03:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d9875ce4fcsm7223477eec.6.2026.04.14.03.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:50:24 -0700 (PDT)
Message-Id: <e7f8328e3c2c4ec746f095ab35b5f2d310878a1e.1776163819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
References: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
	<pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 10:50:17 +0000
Subject: [PATCH v11 2/4] sequencer: allow create_autostash to run silently
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 15 +++++++++++----
 sequencer.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..1197d7d8a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      bool silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4702,7 +4703,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4716,17 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, false);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, false);
+}
+
+void create_autostash_ref_silent(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname, true);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..570f804457 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -230,6 +230,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_silent(struct repository *r, const char *refname);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

