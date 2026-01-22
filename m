Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257941C2E6
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083530; cv=none; b=kTgk7K3mdHh3CkSX8x3vBVgv5bZhw753FsJH01Z90s0P8oIMZia/9J4WMwCTEg1mEopH5OiWSWdmOEN05kSBZvvpKEh8LPV63r1qLwYA+MNHBk02ItMrz07CPb9qvjLtx5vMLHP+oxijR/46rGJhKlFpN42RP3yET2D/wWioYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083530; c=relaxed/simple;
	bh=WZggZy5SS6pQxqND90mdtHtUUJyrUUigKvfQPUu3OBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCZfinbLZxta4fqcwOPv2YwOT5iKpeeZuMf69l682qlcztaKX/1LkOiPnCCg0vZTDcdIAGt2lt8A0dnEI8/OGjr1zZgykEz6PAy5+upYndigpwAYmsgEQKSng3o2TDosgE86dinam5SSPdIA8JLh/yjvXPetE0ZyWKwqxUnxnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j074xhDI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j074xhDI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so6214395e9.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083526; x=1769688326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLH216vjCZ0yr4d+yWryBtsEOEVL7e2pC5b/o4ecn9I=;
        b=j074xhDIJy8zswx1KADIPpvXlR5ACvwHYksUsd4snjmQ2y/qbqQ93yf2rfOBBBCapY
         gAWYQAanCYIafIKFVX0ub2GQaZZCfMjWWzNIqUbA5yYZhu1y4zb7ecObVTFBErMCU/Rp
         VnTZSfn/DON/OAGaf1rjt4poRTKgChWyX8Kn08Ce/WDWB5f1LnXU1G2XVqGHHdieW2+z
         VXWuwMehZgSmdnc5EfVn71ExAMfZez5j34pwvmN4CCfHgIgTMRR8qU2qPqduWSojuGgx
         KVA5k20QG4tb6NpGri4CTuv/fWAJQXhkG3nIBJXRKe5GcJc885MrmzG33+DdScw73gf+
         6zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083526; x=1769688326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLH216vjCZ0yr4d+yWryBtsEOEVL7e2pC5b/o4ecn9I=;
        b=u73pzyqxx+8p7tY5h5fZE54lM2AjzZL5QMai0nSUqh4jMdYonqH0KZUJG3kTrDQoLp
         kUNBAoS4JfoOlOThZmnb5a/YBcU3SHSCJELFr++frCdru33FfFVj2dEKB72bLaq7LhX9
         F86vl+iAqt5jJ5GlYnRcyu5FXNYvlC9KwQonL269muFY84dTY7yzCYvHvAbt2IbYZdZi
         DQYtJnGb+1KeJYoexNgppIQlWmZ6yjS8x6p1mba4jWRUHE/5DpLxRxbxgBRoKNbTYdJZ
         QNfOHL5Rp/xfMO6h9of0VkVl71yUHDyY1OVeeME+AYm/SeSYUiaJ+MswrYQ51vBNGjsH
         O2kQ==
X-Gm-Message-State: AOJu0Yx9pKnhhC80Mv0ZStmHFcJ+Qqm4Od2T8NiA3STjQ+CeFYUtsZVH
	zulRrR33nNXyU1gJt/nIsQTPaFTscc9gTG3KTL5zNyILo3b+dIUb93ho
X-Gm-Gg: AZuq6aKkR9xmF0a/Uhbh7hAwpXCVjIXhXJYMftmnU0tnYj4uTMNnXjSjnO2bAOU2jM1
	H5HWncGPZ69U+V8H7Hf/7O8mF4R0opflAxy0KLGZ0TDAWfBG1unzOcE6vzGgWoZdLxjI98IMW1e
	VOiiPWRXaKeddnrYMfdS6YaSruP/EYyiqyW7t62CeOGy7g0JNiWKtjvbfL7UXMHo3ZnpAc+H0sc
	/RK144kw9PrZgVJW3mA3cqNPCT6imDCrVQZ8k/ncdgbRrPfh6RVaMIvYOq+715v68A8L8ScYqVx
	ee8wEbuQixggt2364u0QRleyAX3JWDV4hUI53iP7DanUMz3pRieGbvW6G2KZ5JqLf/fd1q8FTl1
	yt0LT5VvU6xBy6EFhIRR8ghuy9JPDtPXfQDNm/WjCDzGp1ZMcUsO5ghTkpXB554gcFNfInjGTFN
	/IpBisOCWo50uJRKSBxjFszDp5XwSP
X-Received: by 2002:a05:600c:a0a:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-4803e7e7db7mr150548025e9.21.1769083525780;
        Thu, 22 Jan 2026 04:05:25 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ef49:411:ff92:1c50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm64926445e9.5.2026.01.22.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:05:25 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Jan 2026 13:04:57 +0100
Subject: [PATCH v4 3/6] update-ref: utilize rejected error details if
 available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-3-2ddba0832440@gmail.com>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
In-Reply-To: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12211;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=WZggZy5SS6pQxqND90mdtHtUUJyrUUigKvfQPUu3OBQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlyEoEu/K8sL/0V3SIF2WEVXDZIdQHoQqGRW
 SmBfojifOIwt4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpchKBAAoJED7VnySO
 Rox/8XkL/i8AKjhW4yC8p8clkKd4jdv62Jhk1lXQs0uGeMDhsFn7Ry7sQoGJIa+GWlrzBEhMKsT
 58NI5w0ZIrqLBbaT7fgfgiFAawMaW6wo/HJOUBLNTR1bPZpiS8Gwkl6s3UsYFF/ETiF8ubzaliv
 sxTRJ7c0EfOWjddDOr7WP8K8iGViVdLJ2wzV80R4Bg+d8CipgrPw0XHH4f0xhiG1PLmhY9F7+Xa
 3Q1P43v2cHil4GDV1JbsVs+tYcoeucTwoB/QHYHNGmZci6k0dlDhDk3+S38sZoOi4frdD13mBXb
 1t5HJMgQTt7hC+FjBMB2hwCD+gi7jePN/ggDAE7a0jzffiVH7jnyrQ+83TEOAk+GlYVJoFPgaZh
 qKYQu+vOR6Dn0j72CJ87/FnE++ooIDuq0jU6aobqCPUqfTQxyBL5xPiEjnqZRXq4HZoz/DP8fgm
 bnDTi9FcTwemF14KOXelR+9nKYC9n0esH6I7gY4iy4Ofz0rL02/XCL162teHSQwgL7oXr8ofuf5
 WE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When git-update-ref(1) received the '--update-ref' flag, the error
details generated in the refs namespace wasn't propagated with failed
updates. Instead only an error code pertaining to the type of rejection
was noted.

This missed detailed error message which the user can act upon. The
previous commits added the required code to propagate these detailed
error messages from the refs namespace. Now that additional details are
available, let's output this additional details to stderr. This allows
users to have additional information over the already present machine
parsable output.

While we're here, improve the existing tests for the machine parsable
output by checking for the entire output string and not just the
rejection reason.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c  |  8 +++---
 t/t1400-update-ref.sh | 71 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0046a87c57..2d68c40ecb 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -573,16 +573,18 @@ static void print_rejected_refs(const char *refname,
 				const char *old_target,
 				const char *new_target,
 				enum ref_transaction_error err,
-				const char *details UNUSED,
+				const char *details,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *reason = ref_transaction_error_msg(err);
+
+	if (details && *details)
+		error("%s", details);
 
 	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
 		    new_oid ? oid_to_hex(new_oid) : new_target,
 		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    reason);
+		    ref_transaction_error_msg(err));
 
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index db7f5444da..db6585b8d8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2093,14 +2093,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$(test_oid 001)" "$head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "invalid new value provided" stdout
+			test_grep "rejected refs/heads/ref2 $(test_oid 001) $head invalid new value provided" stdout &&
+			test_grep "trying to write ref ${SQ}refs/heads/ref2${SQ} with nonexistent object" err
 		)
 	'
 
@@ -2119,14 +2120,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$head_tree" "$head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "invalid new value provided" stdout
+			test_grep "rejected refs/heads/ref2 $head_tree $head invalid new value provided" stdout &&
+			test_grep "trying to write non-commit object $head_tree to branch ${SQ}refs/heads/ref2${SQ}" err
 		)
 	'
 
@@ -2143,12 +2145,13 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			test_must_fail git rev-parse refs/heads/ref2 &&
-			test_grep -q "reference does not exist" stdout
+			test_grep "rejected refs/heads/ref2 $old_head $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: unable to resolve reference ${SQ}refs/heads/ref2${SQ}" err
 		)
 	'
 
@@ -2166,13 +2169,14 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
-			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			test_must_fail git rev-parse refs/heads/ref2 &&
-			test_grep -q "reference does not exist" stdout
+			test_grep "rejected refs/heads/ref2 $old_head $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: reference is missing but expected $head" err
 		)
 	'
 
@@ -2190,7 +2194,7 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "symref-update refs/heads/ref2" "$old_head" "ref" "refs/heads/nonexistent" >>stdin &&
-			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
@@ -2198,7 +2202,8 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "expected symref but found regular ref" stdout
+			test_grep "rejected refs/heads/ref2 $ZERO_OID $ZERO_OID expected symref but found regular ref" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: expected symref with target ${SQ}refs/heads/nonexistent${SQ}: but is a regular ref" err
 		)
 	'
 
@@ -2216,14 +2221,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$old_head" "$Z" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "reference already exists" stdout
+			test_grep "rejected refs/heads/ref2 $old_head $ZERO_OID reference already exists" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: reference already exists" err
 		)
 	'
 
@@ -2241,14 +2247,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$head" "$old_head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "incorrect old value provided" stdout
+			test_grep "rejected refs/heads/ref2 $head $old_head incorrect old value provided" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: is at $head but expected $old_head" err
 		)
 	'
 
@@ -2264,12 +2271,13 @@ do
 			git update-ref refs/heads/ref/foo $head &&
 
 			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
-			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			format_command $type "update refs/heads/ref" "$old_head" "$ZERO_OID" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref/foo >actual &&
 			test_cmp expect actual &&
-			test_grep -q "refname conflict" stdout
+			test_grep "rejected refs/heads/ref $old_head $ZERO_OID refname conflict" stdout &&
+			test_grep "${SQ}refs/heads/ref/foo${SQ} exists; cannot create ${SQ}refs/heads/ref${SQ}" err
 		)
 	'
 
@@ -2284,13 +2292,14 @@ do
 			head=$(git rev-parse HEAD) &&
 			git update-ref refs/heads/ref/foo $head &&
 
-			format_command $type "update refs/heads/foo" "$old_head" "" >stdin &&
-			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			format_command $type "update refs/heads/foo" "$old_head" "$ZERO_OID" >stdin &&
+			format_command $type "update refs/heads/ref" "$old_head" "$ZERO_OID" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/foo >actual &&
 			test_cmp expect actual &&
-			test_grep -q "refname conflict" stdout
+			test_grep "rejected refs/heads/ref $old_head $ZERO_OID refname conflict" stdout &&
+			test_grep "${SQ}refs/heads/ref/foo${SQ} exists; cannot create ${SQ}refs/heads/ref${SQ}" err
 		)
 	'
 
@@ -2309,14 +2318,15 @@ do
 				format_command $type "create refs/heads/ref" "$old_head" &&
 				format_command $type "create refs/heads/Foo" "$old_head"
 			} >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 
 			echo $head >expect &&
 			git rev-parse refs/heads/foo >actual &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref >actual &&
 			test_cmp expect actual &&
-			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
+			test_grep "rejected refs/heads/Foo $old_head $ZERO_OID reference conflict due to case-insensitive filesystem" stdout &&
+			test_grep -e "cannot lock ref ${SQ}refs/heads/Foo${SQ}: Unable to create" -e "Foo.lock" err
 		)
 	'
 
@@ -2357,8 +2367,9 @@ do
 			git symbolic-ref refs/heads/symbolic refs/heads/non-existent &&
 
 			format_command $type "delete refs/heads/symbolic" "$head" >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "reference does not exist" stdout
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
+			test_grep "rejected refs/heads/non-existent $ZERO_OID $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/symbolic${SQ}: unable to resolve reference ${SQ}refs/heads/non-existent${SQ}" err
 		)
 	'
 
@@ -2373,8 +2384,9 @@ do
 			head=$(git rev-parse HEAD) &&
 
 			format_command $type "delete refs/heads/new-branch" "$head" >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "incorrect old value provided" stdout
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
+			test_grep "rejected refs/heads/new-branch $ZERO_OID $head incorrect old value provided" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/new-branch${SQ}: is at $(git rev-parse new-branch) but expected $head" err
 		)
 	'
 
@@ -2387,8 +2399,9 @@ do
 			head=$(git rev-parse HEAD) &&
 
 			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "reference does not exist" stdout
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
+			test_grep "rejected refs/heads/non-existent $ZERO_OID $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/non-existent${SQ}: unable to resolve reference ${SQ}refs/heads/non-existent${SQ}" err
 		)
 	'
 done

-- 
2.52.0

