Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB428FFE7
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826034; cv=none; b=c8c6oY+MikbKyLcucHkDfbDuYqMFQbsOBqmAlsCVS2gfAtmEbTyqcjWDf8/NnOUCGfIDVbkcZ3V0pgTIKSLdoE9PeuX3okTC9d+RMc1dgfTBlyj+GEIGoiK9A5WngWvFrwlWo/jiP14CRSJ23+1UZFp2TxJAMsinxH2ecZlSVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826034; c=relaxed/simple;
	bh=n2jdLlV+ieaubpjNI/KgO5ZYhsyGS1ZQMlgWSgTJSCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=milPFKSnR/cQ6BbhvFL1VNYhlU+Zej6QOV/bssZMcXcSw9snISNlMQBDPAemhBjPZ2eYKr/InXODLxq1x3F+xgB16lhvVXTvCFGCDJizOwfgU7ubc1uE8MAVeZiyj3cDRHHwGymKKVfLIhakZJYMJEl7NO7FZc1NGmsZXVBRzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+rMikS7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+rMikS7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480142406b3so20559875e9.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 04:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768826031; x=1769430831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R61eKM6Et71mguA6YKkFFae0FOA7BfOaejeLDUgbmk=;
        b=i+rMikS7+jY/H2VcgCAeMetbnJKo+JfywGCmw+bfwcTCAHj1H1totAlS+HSpaQ9LMK
         wjfvoE24xYmQHfbyzPL7w/GOihOjZ9o/D9hQuzYeP1gkflkDh487atKWBdrcE9nqVEUu
         V9+l7ESIVRRaneRjWGVvqKJIPl20TAmRd0/NiWOaZdPm+Dujynjd5bkkopZSrdUK13fz
         E1s/GpM7vPUxUgNaNTcyAGmaztX/BaTUSuWOJSH+Szx3UTLXSRzXUko1arpy/EwKmJPc
         37d+TntJSjjzDubtAPyhIxWtdMx+6k/oh8EM6Dn7pTMrLHbiXrF0kQxjjNeYZjboI5F3
         nVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768826031; x=1769430831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0R61eKM6Et71mguA6YKkFFae0FOA7BfOaejeLDUgbmk=;
        b=iWXUoZrWbJvXIbPOWRLU8pMfBKP/xvVCHcHaBiKbaSitbaBfC//Rodr2WzB/Sz+6yk
         DGTFDo1gaGq8dGccpxt49fr4JNGAeWD3XZJqbl1iCmVGIhh4Nf78elJ0y5dEhTJHCX8O
         v/nxXRK6BRYWyuWTheOPyBeqWCpeWVcpnSsTqsstz+smN2OxEZ4GK269pk2qJ3DiD6mt
         Ipga6c3bt5u7w6nIeP0gBA4tGYcpzN2mygH9U4JClzvyQBEDoPhvYWQx96g8RqVS1jMM
         QJZDpCc2ejrFf2mczbD3zwOC68gmaR2RiyGfEyxR7m6nQa/YEQ3H6BcfOXnRH56ce/DG
         D/Rw==
X-Gm-Message-State: AOJu0YxXhqz/gCX2xAN9F6U+Rfb2R0cjAVpVuoM7DM0zdRNrJYsDagLF
	byOIikjxh9eUoED6PSK/Ay1RlWjjm/KTWfBDeYA2qEYZt56XVF0tYYvnKZFUSg9S
X-Gm-Gg: AY/fxX4/C7QkLOZTK4dOB9jjTyPSurHNUvOyQejIOnFlLu2O3ckzLOU0ZteasDm0ygG
	Usnu0tPhFzh/3IH9d6VtSj5rhsmooKjfxJBLrTT2e5KJA7lTo6u5DigXa8dK96qigs+jn9mQJbJ
	WI7bWQtaFwE1QTpKXXOy4KavOrEuCptGYaWuuYEMXC84F6KFDsWBnIelIs/xiK4Z8wUs6Gq7ED+
	bNmNjquYRaZbYDX5nBHDqasXvZRWte7st43Z1nmtDeyCGl5qUMKnQMFfcPBZtxqVZy8LbQ3C/po
	l7DEiNXwompaXddyNJSduauID2lhU1cJ/DFa2gB9I1o6G1tz393Jt3RB61ytjj6P7y3K42mk6GA
	b9Nd1nnKmbWDW0y4JlvwVeviUBIuvbO3VhG8BXh8YBnF5ApbQk6QyuywX56T115XF8c5/KO9hT1
	pGSkhduElz3NKy+mmGAkD2CMgKXf5RdqPQBq/UdL17AbaPLOn1NQGDjImxqvNiQt7Zcwi0MjN1f
	acouER1xWcCfNw9fA==
X-Received: by 2002:a05:600c:8816:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-4801e8fd2e5mr80512695e9.2.1768826031331;
        Mon, 19 Jan 2026 04:33:51 -0800 (PST)
Received: from localhost.localdomain ([115.98.234.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699272a0sm23176823f8f.17.2026.01.19.04.33.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jan 2026 04:33:50 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH v5 1/2] sparse-checkout: optimize string_list construction
Date: Mon, 19 Jan 2026 18:03:39 +0530
Message-ID: <20260119123339.48435-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114192803.4852-1-amishhhaaaa@gmail.com>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <amishhhaaaa@gmail.com>

Improve O(n^2) complexity to O(n log n) while building a sorted
'string_list' by constructing it unsorted then sorting it
followed by removing duplicates.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/sparse-checkout.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..7dfb276bf0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
+		string_list_remove_duplicates(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
@@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	string_list_sort(&sl);
@@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	strbuf_release(&parent_pattern);
-- 
2.51.0


From b20a99f0773bab063a31eea6fead730e18200ca7 Mon Sep 17 00:00:00 2001
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Mon, 19 Jan 2026 00:20:47 +0530
Subject: [PATCH v5 2/2] t1091: Add tests for deduplication of cone-mode sparse
 patterns

Sparse-checkout deduplicates repeated cone-mode patterns,
but this behaviour was previously untested.

Add tests that verify that sparse-checkout file contain each cone
pattern only once and sparse-checkout list reports each pattern
only once.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b2da4feaef..858801fed3 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -817,6 +817,39 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'sparse-checkout deduplicates repeated cone patterns' '
+    rm -f repo/.git/info/sparse-checkout &&
+    git -C repo sparse-checkout init --cone &&
+    git -C repo sparse-checkout add --stdin <<-\EOF &&
+	/foo/
+	/bar/
+	/foo/
+	EOF
+    cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/bar/
+	/foo/
+	EOF
+    test_cmp expect repo/.git/info/sparse-checkout
+'
+
+test_expect_success 'sparse-checkout list deduplicates repeated cone patterns' '
+    rm -f repo/.git/info/sparse-checkout &&
+    git -C repo sparse-checkout init --cone &&
+    git -C repo sparse-checkout add --stdin <<-\EOF &&
+	/foo/
+	/bar/
+	/foo/
+	EOF
+    git -C repo sparse-checkout list >actual &&
+    cat >expect <<-\EOF &&
+	bar
+	foo
+	EOF
+    test_cmp expect actual
+'
+
 test_expect_success 'malformed cone-mode patterns' '
 	git -C repo sparse-checkout init --cone &&
 	mkdir -p repo/foo/bar &&
-- 
2.51.0

