Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A130FC0E
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381570; cv=none; b=nmQC2aD6RgMbHPJ0zIkzlV5rquoq0zIoZVU4f7My88tcDY+RWDtGsR7QwvcZoKQN5/6ifK62bkADhtNoL6DFp1TxMyQOwWgEeZ/xxY6cU+UWjSbxOJ7lCiOPz20RwBsTE69VNsO7cpPGuUaxC9yvuminlbZZo0NARAVCJ/YQncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381570; c=relaxed/simple;
	bh=WZggZy5SS6pQxqND90mdtHtUUJyrUUigKvfQPUu3OBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ekzl09CkRa47vi533j20crBTDQokJCnR/VO6Bqz6E4e/t4QRfwy6GBTawFRU7HCACF+jPqeYob0VBxIFd9HTFZKUV508qL+vBHNZrtf1VaUBkuR2Rq6tJlgEg/UXryCEREjUboA5cWd8MT0DwbejQufceHN/35+sRL2uHUAFYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klTaHZG6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klTaHZG6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4805ef35864so3892225e9.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381567; x=1769986367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLH216vjCZ0yr4d+yWryBtsEOEVL7e2pC5b/o4ecn9I=;
        b=klTaHZG6uZ6WpVFrXSjbUrZLZSiA4yQPr8T668QuzIB2TK8uiYxOF0WggqdJ3U23YB
         kBTRsCnCI8qen37cY/FQ8iXLwmCXiCT/GNx7bZYTyiFYim+JMsgW/gNcgIxS3YoCsFQY
         P6Bhq0tOraiJXI00Wu/vCxECoqbQo/aG13xeLMuKMKGU61fqrf86GeEHN/s0bRIk6NCu
         /jJiTOZXoaUsvAaCTuEodjG4MJCnlTYUPc05z8nft4UhN9U0+o/9jIZAEUxll7PejiRd
         6+QkvaqBV6ulNjd7w1s6z4+ibtHv+yUUm/ICcwOlzlSAJaYFX7rECZ65Wl8kqa4mRPv4
         ojNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381567; x=1769986367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLH216vjCZ0yr4d+yWryBtsEOEVL7e2pC5b/o4ecn9I=;
        b=siJOBOngk8mfMEH2haejD9wVLbJuXug40VaTpMsuCY0mOo66aDx13X8czdxzXV5pmh
         SdYK/dR4dDJ+8vYeNgQScc+f5iBL6b3TzoSgKaweDVwuD/IMk+GCQmaRLdTjpJFmK0sQ
         5esqVTBQjVPqd2GUVVnpBveyphpzIRM3vEUGZ3c7Cz96xY9IvHVhTR3vZIIL0WzxNrvF
         62GgUT4fUqEoC0pysketh1igHekEtQ/hqhMCMnTcJasFnEgaGBKnoVbSa0TBa4aYz3tY
         dav6PrWTwcUeGvqoUnF11phljUMWeYhhHF/+9avRwFAsY+dAus4ySVRyd4TFsMK7huoO
         FOqA==
X-Gm-Message-State: AOJu0Yzb+brNTUzoPbgELX6DNL+X32ABKlYUZRBv5o3d0yyixIWP/B13
	PoMVe8NJmgYraAlYpJk4cxTSsnALx6fB9YLSiEEAAl9DguE+TV1ls85Z
X-Gm-Gg: AZuq6aJkQx5RsYdVgHDEdOOAlK4iIZ/tjKf+6o0CeQxcyuW7IKhMPR8jjr8rXRTWHl9
	2u+G/Xo8kQI3p169sq/+1L1xYcP0Eqrpg5zwGrDBSQJngHmzIcSryrytmzbD3K+npoc1GqDn3R5
	L57HCoY2kXZnnzA32is1tgVhxHQ1R+kIspkP7g0pBVisMxO239YK3nsyujGgPayTtIlBDglplMt
	nIwqMzFNCo8LJXYqTeq+TB2NKmufCieRyQj+/ftJQ6rtacXZ2kc4mDoHECERP+f92DvuzFAdVQs
	2fAES/iNEcrsppG9yrqsM/Jc77QqJNZhhRGUnWP3h2RmOfn4TmZsA5kQRzAHt0OXJWNf8uJAYKf
	u1gr88I8X/sdI+SOwMtgSsbh20z+kSNRiWlMopJUETfjMUcdG0DS6zwdhPq/h/+Ku34/YpaDeM/
	5nAp91/TaeDq4M+FpZwA==
X-Received: by 2002:a05:600c:1c17:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4805ce67ec1mr51509355e9.22.1769381567211;
        Sun, 25 Jan 2026 14:52:47 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 25 Jan 2026 23:52:38 +0100
Subject: [PATCH v5 3/6] update-ref: utilize rejected error details if
 available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-3-d58f3a9edf98@gmail.com>
References: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
In-Reply-To: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12211;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=WZggZy5SS6pQxqND90mdtHtUUJyrUUigKvfQPUu3OBQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nrgSyqt+f9OFfn4Z57m4RHWZlQv4CMgZ8
 aGp8gmIhGFuYYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp64AAoJED7VnySO
 Rox/fVcMAJlo4x683DeXwZGYWUIgkeftJR4lawNAxqwKltIh/3he9MYn2p6MKO/ANxcDgJSrSZz
 s6p7/B8UycuUpKP5FlJw5OPnuD2CKzsbyByb4eTDXsfCcaI2efVJdVqLsGe0TeepeBvasPjMKxG
 Gz/DB0Y0oiWzecxPcT67CswnBXOXY9enaDu2hDnxKmptNg07nteNrEBncnaITA6QMMmQxqSGS6H
 U+BYVhXlX8tRTBdyVrybM/balcKpGSN8OPY2F8VUG4SOWgGAEDfBjZhUtWNDQLTPlNCMoUssITY
 WzUUj3ojqJvODqif7Y42x+E2WI8x6gWdrCvM5lwWRINfOXSssKjqgqACTbrLVV4nifObUq/sXVm
 U69i5i9SqrHskCgVhpBDBBhvJIG12GBpv+keCHB73kY0gV8WDLJEsQ/YXPLpEGtyhALQvTBWPu4
 S21EWTx7yo02rCMHi0l0SNXT0n2bqhi8xoByoRuYMOXO5bIVjc278S/Ami53BZw8xZt/9UYIpY4
 8Q=
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

