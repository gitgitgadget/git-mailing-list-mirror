Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFF3C199F
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903183; cv=none; b=ijfFdDZ/1qslXuD8uCDZVCj+6lmwKt5ZsyBKTT/I9+lqg2WSqHMQ6jHnAqha3U//rO3hwaPIreI6SQsbt1gxkmADv+SDMGK/qRLCGYgWpf0ac9NozIFcITfqfPv7ck9KzfSeo+3DIKndPIODnNQDsvjJMqZTjuKv+AlA9iZCSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903183; c=relaxed/simple;
	bh=rLVJf4SAxI1OeTQIbZ08KWVXP48o1NHXgjTLD+mJHuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t64qUP4n0BtWIzmiDUPAZszjBpoUROrkfzZNKHQjMC1YB9hG90ZulPKXHcdCZw9pzSPfpLfyOVGm25eIueHRSGY5gLPp+2+GrGkRvgCqrItgLWXPz1PmFzbYqDOp9AutyxAGf7I4T5+2/YAjhEmxNuJi/Ay/C0Wll5BT1FPQ2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhuJnWlx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhuJnWlx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43596062728so11345f8f.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903179; x=1769507979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGkIy9wAhShM0Mzicd2BhN7YiqjKjVwdMo2jeYNepWA=;
        b=mhuJnWlxrEbS/N5pIyWHTzjkMqFbPklNnZscXSY6bdb9i+a207COt3DZ9z+veXrs4y
         VsMMToYB4a8m9lTiNCu0CPYsrpKgVu9/SppIixUQs2wlg1iW52CSJ+FUM3Ir+shzRsaw
         hWNzBKO4hZNThUJquvUp9+g6h+9uVblLcRxZ35GplFJ8NGHF5Sn7uB6JE/8CsLF8c4lx
         RKaMMFVyfTMZDwGH7INlg/qt0rGalp8zBHt9nyRxJ+HRSe4NiDW+57hFZ6jbbh9hrUC5
         MDT7Qd6xwRA8mv8piObtBP6aioG9gAkM6insFPdJoaMHw7yNOP4tOo0KlTtOE8RqfQSd
         RLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903179; x=1769507979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FGkIy9wAhShM0Mzicd2BhN7YiqjKjVwdMo2jeYNepWA=;
        b=HjMlUWQceHqPioTYWuI7LiXKrZFDUtoFGzEu0A99nV+HcD1x2bNJXyAhVUkclpuzcl
         00J9sd39lDR+MF+Q17ZFnPSCCmSsbpgxzPNhLoMeC6789eA/Qp4bER2+JEhtrFpvT3tf
         r41vsxZ+WvIMI3hkaIreUE4kk/yKxBFXYcb7iYUxW6kRc1Xu+sasUdMnHHuagGz+kmFz
         o755/++LMVYfDJtg/Q1o0lPUtpF6YWnqfBWBVugxcw+Yj1E0dDG/W443d/TxjQllGDgK
         G00fUUqnxgdHdNt2/bn+kb/CyQ4RrylTzZK9M22I6oVlAzXyxF61vMjPdrHAZK2RBp0+
         G7ZA==
X-Gm-Message-State: AOJu0YyrrKKikoPLLxYaTtBBb/2babA0XUnW0W5daXPjtdsbEU9UDjUP
	qskM0rmDjV3JwOZEFun9o8RhX6Tboqb4q1Ac8QyqSjIWg4MWcNCl+gSG
X-Gm-Gg: AZuq6aKsRia6WkhTjpd44ir7pJ5taxgvogU+EQ/L27q0EyFrFx3UUwc7aPLrY4L+HVm
	hmDGYeImr0BpV6ZFA7LMF0fL2+S7rt97Ss8TisXGBDqrHI/kF80qZR4v/jwTjf+i0MrTe78wB90
	/LzkeRm162t9ojioBZty2QaeCVh2Y0YGEGcIWfVGKUp/pSse+J59XclZkLNIFWnUs22DbMrgU1w
	vF5kNU8nNbk2zxU7drcrSj/bYPYQNjvqluC1x5QeSqo4MMz1qp+OUWs4t5DPxMaYiP480cOk7XX
	bfjyCKWkVbXlOKoT7Onfx4Lzihtvq+I/a/KqABrQtIqMJsoNCmDLwUpIzzG/6m3G9ibimRsTNBs
	gaM/osBZonckDU5VEpsZnx3JXRixI2ma6CCjSPa5m2yt/10OJpxwk0K7Lxqzn4S+tVw+zVRiAU9
	z/qfnyxf6TSOmraxXtxlB1Hq++8GQt
X-Received: by 2002:a5d:588c:0:b0:430:fdbe:cc4f with SMTP id ffacd0b85a97d-434d756e9a2mr27457644f8f.13.1768903178868;
        Tue, 20 Jan 2026 01:59:38 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 Jan 2026 10:59:21 +0100
Subject: [PATCH v3 3/6] update-ref: utilize rejected error details if
 available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-3-e0edb29acbef@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12211;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=rLVJf4SAxI1OeTQIbZ08KWVXP48o1NHXgjTLD+mJHuw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUga+Fs3YzRK2uehaD3DWeGTqhlaZ5wnDa
 6Kt4Qr9NtX4IokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IGAAoJED7VnySO
 Rox/nPcL/1lXAzr8V9TDwbDBDe9wQCFlZEkD4q8sRVkGJJpfKIsjZ13Wx5hvkwED0MhWhL9fyO9
 9HNt3afYrMIaXaoIksz2W3QSYyCXmY6jvrfLIveC7+8vhIz6Y6j1+nE0R1HxIUzVbBh0lOOdPfx
 0dAkLrcCbasqtQ0mysSFThTplCZsCTt8ns5ELNkNY7xI+UUF3sNKxd+C/FgmRWI6Z33yx+K2xWy
 9Dpp2vrEw+qhyKcQZgbAVUrXdkHvZtiCL0YyDoM2cDTuqQVW8SFGvZzCkdjV1noa/oH4CdgmB4C
 QhaF+3A/gEVHWxJNxVDHLf17hBNYFGELwLfkg+kc6o7UizsQU132xqJEALc52qVlWXGQbC89aNV
 QccTVtwCxswyPXRuxdu+PCR+0sOSXGxIBulcqYH3s/SXLIbUguceqBUW2e80wRmGkvVKxYzcJM8
 GRrgvO6T2XkD6ag05Oltudur0W9kvaMTxiAPITc5bllNJa2rm+YSwqSMqxPgVdFBXMEXvTd+6b4
 nA=
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
2.51.2

