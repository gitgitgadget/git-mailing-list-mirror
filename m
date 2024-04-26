Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397071514C2
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145104; cv=none; b=fOLmWyPY+PSdmGSRI9fPJWP5tM5aOrgF+pLChV8Ale6c0LeN0XhSK55UEDHZGP5Ao30Rw1gMf8vydYNa2XJvUsghHeyo3CCLOWNhYQRK7muGjmbF8lJR8KuTek0J/6vEt83qOzaBQ5QWvI1Acww4UzI4JRw9D9xrraAWhjQXpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145104; c=relaxed/simple;
	bh=yUWzQt/oTI76ZCjK/T+bIZ4N7q+xlSa5DLKiM2uUslg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqgwxJHJVMozi1Mv2cC5MqicOLTjFd6iWRtkXDKX7+lKNXQvwK7PP4WZW/auPAy8vqjrRnDYuS+KxPSisKR3Yx+x/Woy1/5oobgPU4sC5VAsCtH10kMOq/ysjBpJP8Bdtnf8NCz9fNJMqknyU5GNdgNlEqsyBdjUbC6pfSuRr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccATXRd6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccATXRd6"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so3119268e87.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145100; x=1714749900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vZ/Rbr2oc3Q7/0WDOOreCOOxs0mpGhGeznFIqaXXPU=;
        b=ccATXRd6IkxnyXiNRtEdum14BkgzAusy9zb4J+wzNgQtIKbgTpPQDutATBOHcCKpQX
         VaQJrC8EPfHq6ztKsnzfApaefoAyY2ZuZkKe0c+ynmxKuV8N4l6zLJwazE8Cg3oSkuxz
         3gr4xq0R5Xkj6gHeyryjglRZb0ifi9lT7WvKsC9sN72BeG2HYlxHmsFQRBwFgpVEeX3B
         lGGa4i5vYlqeq4I6col61I+uZ9eISoWwkKEVg/8ZkUkonavTBxxKFkiaSSAX1YylhAIb
         N190Ccj34J/rP/djC20g9Qk35SP5n2B7XcP+JC3ZUy3hiengUWk5Qnv3S+W8c4R21eNi
         eDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145100; x=1714749900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vZ/Rbr2oc3Q7/0WDOOreCOOxs0mpGhGeznFIqaXXPU=;
        b=GbSItyjFycchMHTiVOwQACmxsUZKRjPI/+l5pnXxqLYa8TapAnn1rivW3Sah4ls1fS
         0MxzZ8JIgLj6edmVU9sIMAz638wqAzyVRv+cm7WkKWrEWQfza5pl3UlFgdJWeKCnwgzF
         t0PKNQF24YVJcrPpeJJ1h1WB+J8bPyn1DOyGlr5N8lwr6bnhDszO49SwapNxjLpd4Q7L
         MAs2AHUFwRTo8iPGaEq0uIT0XLyMJ4xCcZY7cfQjFaEuZg/5wkN3Uum3UzcadW5vy1nD
         Yi2UjV2xdHqhIzZhgued2tZ4MrLpfZsJRGgU9ZZJXklQZ1SnvTKW58aZVbCcOiHEbSeV
         yIvg==
X-Forwarded-Encrypted: i=1; AJvYcCUQUJCFWh5sFAAtH6w/5kT5K4k7oxIJRdtBwZg0vlBd9FTllUeSRkK8SEPjruf6qpfE+rOqXDGprJitiz//lTNar6a7
X-Gm-Message-State: AOJu0Yx+9nw2izqpoSh2q5zsDFhIGIk5qIgDDADkHSG0rEakyoS0KHxv
	3/18Wd5l9o9/jdGh+qJzs/jTPXx9vEu1uYEzHJsBn94FyCpbxSYc
X-Google-Smtp-Source: AGHT+IFlWf+f0TQFpg0k/JqXuFGpGdXiezWmh+nKtsR6JJYSZKZJUkLhqdjaYhkuhGn0Xb2xJdRcFw==
X-Received: by 2002:a19:3855:0:b0:51b:14d9:9c12 with SMTP id d21-20020a193855000000b0051b14d99c12mr1918892lfj.30.1714145100017;
        Fri, 26 Apr 2024 08:25:00 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:59 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 7/7] ref: support symrefs in 'reference-transaction' hook
Date: Fri, 26 Apr 2024 17:24:49 +0200
Message-ID: <20240426152449.228860-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'reference-transaction' hook runs whenever a reference update is
made to the system. In the previous commits, we added symref support for
various commands in `git-update-ref`. While it allowed us to now
manipulate symbolic refs via `git-update-ref`, it didn't activate the
'reference-transaction' hook.

Let's activate the hook for symbolic reference updates too. There is no
new format described for this and we stick to the existing format of:
    <old-value> SP <new-value> SP <ref-name> LF
but now, <old-value> and <new-value> could also denote references
instead of objects, where the format is similar to that in
'git-update-ref', i.e. 'ref:<ref-target>'.

While this seems to be backward incompatible, it is okay, since the only
way the `reference-transaction` hook has refs in its output is when
`git-update-ref` is used to manipulate symrefs. Also the documentation
for reference-transaction hook always stated that support for symbolic
references may be added in the future.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt       | 14 +++++++----
 refs.c                           | 21 ++++++++--------
 t/t1416-ref-transaction-hooks.sh | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ee9b92c90d..0bf8ca87a6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -486,7 +486,7 @@ reference-transaction
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
 committed or aborted and may thus get called multiple times. The hook
-does not cover symbolic references (but that may change in the future).
+also cover symbolic references.
 
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
@@ -503,16 +503,20 @@ given reference transaction is in:
 For each reference update that was added to the transaction, the hook
 receives on standard input a line of the format:
 
-  <old-oid> SP <new-oid> SP <ref-name> LF
+  <old-value> SP <new-value> SP <ref-name> LF
 
-where `<old-oid>` is the old object name passed into the reference
-transaction, `<new-oid>` is the new object name to be stored in the
+where `<old-value>` is the old object name passed into the reference
+transaction, `<new-value>` is the new object name to be stored in the
 ref and `<ref-name>` is the full name of the ref. When force updating
 the reference regardless of its current value or when the reference is
-to be created anew, `<old-oid>` is the all-zeroes object name. To
+to be created anew, `<old-value>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
 `<ref-name>` via `git rev-parse`.
 
+For symbolic reference updates the `<old_value>` and `<new-value>`
+fields could denote references instead of objects, denoted via the
+`ref:<ref-target>` format.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs.c b/refs.c
index 42cb4126a7..9a510744a7 100644
--- a/refs.c
+++ b/refs.c
@@ -2365,18 +2365,19 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		strbuf_reset(&buf);
 
-		/*
-		 * Skip reference transaction for symbolic refs.
-		 */
-		if (update->new_target || update->old_target)
-			continue;
+		if (update->flags & REF_HAVE_OLD && update->old_target)
+			strbuf_addf(&buf, "ref:%s ", update->old_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+		if (update->flags & REF_HAVE_NEW && update->new_target)
+			strbuf_addf(&buf, "ref:%s ", update->new_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
+
+		strbuf_addf(&buf, "%s\n", update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..0a7e86062e 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -134,4 +134,45 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+# This test doesn't add a check for symref 'delete' since there is a
+# variation between the ref backends WRT 'delete'. In the files backend,
+# 'delete' also triggers an additional transaction update on the
+# packed-refs backend, which constitutes additional reflog entries.
+test_expect_success 'hook gets all queued symref updates' '
+	test_when_finished "rm actual" &&
+
+	git update-ref refs/heads/branch $POST_OID &&
+	git symbolic-ref refs/heads/symref refs/heads/main &&
+	git symbolic-ref refs/heads/symrefu refs/heads/main &&
+
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		while read -r line
+		do
+			printf "%s\n" "$line"
+		done >>actual
+	EOF
+
+	cat >expect <<-EOF &&
+		prepared
+		ref:refs/heads/main $ZERO_OID refs/heads/symref
+		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
+		committed
+		ref:refs/heads/main $ZERO_OID refs/heads/symref
+		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
+	EOF
+
+	git update-ref --no-deref --stdin <<-EOF &&
+		start
+		symref-verify refs/heads/symref refs/heads/main
+		symref-create refs/heads/symrefc refs/heads/main
+		symref-update refs/heads/symrefu refs/heads/branch ref refs/heads/main
+		prepare
+		commit
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

