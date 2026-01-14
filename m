Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55117395268
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405272; cv=none; b=bFgNMilHqhmTXoEUWgWgOpsi/Vr2LGwvfPTAb8CwEPfnea6gWlikvQTK+b8lULcSJAqaKDXH0pAnwIwiRShTFqngl9XyJdtxKp9CJeEmiIv1lpSoTyDpVuBKjEXqMuvIQRk0s5WeTcUyAnXzprkR/dLluRTwHWigY1mTm1+mLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405272; c=relaxed/simple;
	bh=/HJJCsNqI+E7W0kQ4WINfEtIMB2tZIeFV2BzwUdyYYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1OrOwvG65Gw46l917VJEXFcoNLFCASWekitvxlaKRB1prZsyYDQRBdBclwKA2nGCzrywdB1+3HPCtxH3vcWNAWlLthTentzzjXQk86M5PrnkvjTekpPqbIehvNmXwfYmc6cbNHS/Rh3M9lRK3QfQUp8uuGZf9S27FgJtRudpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMMOW7dc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMMOW7dc"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-653781de668so2649426a12.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405269; x=1769010069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5SkiE/WAf57bXaJfDREsOT++VedcEfDwUOd9mGOyQU=;
        b=YMMOW7dckQoE7RizordXyU3ak15k9CuLfLDgNPiRWsc9686jf0UEQX+lQiyq6EFnRn
         Z1nmWYXCIYGBtg8a2rbZF9SwX7nO91HOYJfbZyD7++xBPw/JYJobH+vCWKxPtkI/Izw4
         Z05I+kK1f55aJ12KEOKvPlS4lZtglDria/OXHCIAyl2Uhv7KzS/RIhEWVWDsVfvDnlmw
         CBpGsbzzVVP1VpILePbrSFWDca9k7f07S2nWYa7E9S20GP2ii0fPzTvffp/MY03SJRHO
         H8YOU/+SnU1z/9DbntsI/di9elgeCPuz4LQ/uP2nkObRj4i0DjnjAJpBZx6zK15rUDdS
         Uetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405269; x=1769010069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5SkiE/WAf57bXaJfDREsOT++VedcEfDwUOd9mGOyQU=;
        b=b3afmvvaAWEFUPglS4uC+t/WrQKcNLD6jrLfCCb8hVYJIxKYtiP8C5c2KhH6jJEUbq
         wcsjC4qFyKr1JckkKgXtLcMM/fQN75MTOj24IfR2qdQgLMCahqn9oMZ//TMBy5qvYi/4
         nb4QPNje025ELw7C32HZ4wW2I04Pez8bDYknukAofXMZ/Ku5noqVF6R8hf8euTXlPX/c
         T78SastnH5G+XNuFiGqp8mdBggj/67ivarn83YgFDysxxqgPYJmodbv/KJVg2Mwve5/p
         wWLkxx6v2p60ZtVVZzlVezeIKOVLfW0vz4u29fF1ccjZi6NlnPtLPWIipKAP03Z/NFFl
         3Pow==
X-Gm-Message-State: AOJu0YyKtWGqnWM/VMzoxOeJaE+TrwFtwQ/ELcLZQd7WTc9KvOCAJUwh
	Yr9O5YMAOd7zhy3DrdlsENOOwUwSck7MFQeZWDOD+4orMb1ZYAnp+rDtW8q+ig==
X-Gm-Gg: AY/fxX6MuxUImhPcwMHk7meGz9/c7qD6dReLp4E8OUCdNWnvJ5iwK3TkScJ2lcpG+zT
	mEeVPNU6km4FK6Nna0GNaQONM1+x/Gw8w0KfqP5jX2QT/0+I+iJgXCTJhokguQKpYhr/3M8op9G
	IfpVCNhXC2URDqeYpSo6/De8VVluGVPQiUvz8z4ztsNYOv13SKZMbEm/pvElqCd3LY0aXVP3+V7
	E5m4bOX4I7o7RV//qKfTCUPP9N4KJYsUd3lG/v/w+LiYvPsXfeNvRxRMLCmLxqYVK4quU1nw/AH
	lW6trsHI6E5RQmz2vXH1Zt6O1RfNi+oY2BM/jyBtQ2ixsurZlPX2bh/CCUQ6XTyM0zOQ860SHwa
	h51Ms+j0KgBS8ES6DaFB2nupa+3eavK68xEnHTMAK+DO1+RKvk8Eg/UvEhGo5uw20RHIwaT9R6z
	igBFwYgHyr//bKJK4Xx7/2zwY1p0khwA==
X-Received: by 2002:a17:907:2d23:b0:b83:3773:dd96 with SMTP id a640c23a62f3a-b876770a418mr194684766b.3.1768405268454;
        Wed, 14 Jan 2026 07:41:08 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:08 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Jan 2026 16:40:45 +0100
Subject: [PATCH 4/6] update-ref: utilize rejected error details if
 available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-4-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6321; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=/HJJCsNqI+E7W0kQ4WINfEtIMB2tZIeFV2BzwUdyYYg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuQ+piEfCXS6u6K/QWgPWeLRTivpi0TQHs
 BTW5WEUL23gRIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kPAAoJED7VnySO
 Rox/PDEL/RufrnR9lYG56NhsPF6n9L3saHXumIyt1f3Xq+D/RP8pIJiHu9ec/auDploHMamsBr1
 /Qi+Sg6wl/Fk0KT44TXqwmBRypr1ZwVEmpw9ugPNrDF6Hj26BYi1dqiHQs5vEW9/zEzbskjdfyT
 nqb/gn12k4CcjAsKBAyRKOn7t7tDhVnT3WZoE7OZe9dHmmT5b7rfWXRjjF6fCrWyzCby0KP+HsT
 Oj4ZKitsYKvulU47b1RBGs7mUY1SUl01hfY6WYQl7MOO11Gs8cY/m2ZJWZ8jih20vfhATbug3NF
 BOL+LLhEuasjOjj+JML4ROqlFDRDWtvpapHDQrE14aTcyFMfC9g8DPkPcuiJ4XGcvMuQKhyfZHo
 T6TKy4s/OKEAJH1t43sfbsgovnBAunheDyyCGY3LFskvXeLUk4KKX11QG2DTI+avRvS+kiEEubZ
 BluePlfMuSs/rHfPHldWbP5M+rh2crirujl9xPxKMIlRAy4l9HfyCY0iCmMBqhoP49D7yaoExi8
 Ms=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When git-update-ref(1) received the '--update-ref' flag, the error
details generated in the refs namespace wasn't propagated with failed
updates. Instead only an error code pertaining to the type of rejection
was noted.

This missed detailed error message which the user can act upon. The
previous commits added the required code to propagate these detailed
error messages from the refs namespace. Now that additional details are
available, use them instead of the generic error message based of the
error code. Fix the tests to also accommodate these error messages.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c  | 14 ++++++++------
 t/t1400-update-ref.sh | 26 +++++++++++++-------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0046a87c57..800e380d32 100644
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
 
-	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
-		    new_oid ? oid_to_hex(new_oid) : new_target,
-		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    reason);
+	if (details)
+		strbuf_addf(&sb, "%s\n", details);
+	else
+		strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+			    new_oid ? oid_to_hex(new_oid) : new_target,
+			    old_oid ? oid_to_hex(old_oid) : old_target,
+			    ref_transaction_error_msg(err));
 
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index db7f5444da..6cd6b45411 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2100,7 +2100,7 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "invalid new value provided" stdout
+			test_grep -q "trying to write ref ${SQ}refs/heads/ref2${SQ} with nonexistent object" stdout
 		)
 	'
 
@@ -2126,7 +2126,7 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "invalid new value provided" stdout
+			test_grep -q "trying to write non-commit object $head_tree to branch ${SQ}refs/heads/ref2${SQ}" stdout
 		)
 	'
 
@@ -2148,7 +2148,7 @@ do
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			test_must_fail git rev-parse refs/heads/ref2 &&
-			test_grep -q "reference does not exist" stdout
+			test_grep -q "cannot lock ref ${SQ}refs/heads/ref2${SQ}: unable to resolve reference ${SQ}refs/heads/ref2${SQ}" stdout
 		)
 	'
 
@@ -2172,7 +2172,7 @@ do
 			test_cmp expect actual &&
 			echo $head >expect &&
 			test_must_fail git rev-parse refs/heads/ref2 &&
-			test_grep -q "reference does not exist" stdout
+			test_grep -q "cannot lock ref ${SQ}refs/heads/ref2${SQ}: reference is missing but expected $head" stdout
 		)
 	'
 
@@ -2198,7 +2198,7 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "expected symref but found regular ref" stdout
+			test_grep -q "cannot lock ref ${SQ}refs/heads/ref2${SQ}: expected symref with target ${SQ}refs/heads/nonexistent${SQ}: but is a regular ref" stdout
 		)
 	'
 
@@ -2223,7 +2223,7 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "reference already exists" stdout
+			test_grep -q "cannot lock ref ${SQ}refs/heads/ref2${SQ}: reference already exists" stdout
 		)
 	'
 
@@ -2248,7 +2248,7 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "incorrect old value provided" stdout
+			test_grep -q "cannot lock ref ${SQ}refs/heads/ref2${SQ}: is at $head but expected $old_head" stdout
 		)
 	'
 
@@ -2269,7 +2269,7 @@ do
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref/foo >actual &&
 			test_cmp expect actual &&
-			test_grep -q "refname conflict" stdout
+			test_grep -q "${SQ}refs/heads/ref/foo${SQ} exists; cannot create ${SQ}refs/heads/ref${SQ}" stdout
 		)
 	'
 
@@ -2290,7 +2290,7 @@ do
 			echo $old_head >expect &&
 			git rev-parse refs/heads/foo >actual &&
 			test_cmp expect actual &&
-			test_grep -q "refname conflict" stdout
+			test_grep -q "${SQ}refs/heads/ref/foo${SQ} exists; cannot create ${SQ}refs/heads/ref${SQ}" stdout
 		)
 	'
 
@@ -2316,7 +2316,7 @@ do
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref >actual &&
 			test_cmp expect actual &&
-			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
+			test_grep -e "cannot lock ref ${SQ}refs/heads/Foo${SQ}: Unable to create" -e "Foo.lock" stdout
 		)
 	'
 
@@ -2358,7 +2358,7 @@ do
 
 			format_command $type "delete refs/heads/symbolic" "$head" >stdin &&
 			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "reference does not exist" stdout
+			test_grep "cannot lock ref ${SQ}refs/heads/symbolic${SQ}: unable to resolve reference ${SQ}refs/heads/non-existent${SQ}" stdout
 		)
 	'
 
@@ -2374,7 +2374,7 @@ do
 
 			format_command $type "delete refs/heads/new-branch" "$head" >stdin &&
 			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "incorrect old value provided" stdout
+			test_grep "cannot lock ref ${SQ}refs/heads/new-branch${SQ}: is at $(git rev-parse new-branch) but expected $head" stdout
 		)
 	'
 
@@ -2388,7 +2388,7 @@ do
 
 			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
 			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "reference does not exist" stdout
+			test_grep "cannot lock ref ${SQ}refs/heads/non-existent${SQ}: unable to resolve reference ${SQ}refs/heads/non-existent${SQ}" stdout
 		)
 	'
 done

-- 
2.51.2

