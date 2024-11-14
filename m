Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265818A6AD
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604549; cv=none; b=AC+jCA3u4GK4kiTFprj+2LRbSgtxlqX3Ae/wkrCjOMfj+iWsJJkRk/OOgsntcoYsVoF0uPAehoyMDKFd3THLAsvZMiePEr6MzfPp/5s0G5v44VTurCvN7ZPcBTKTu8R+Lk35UBLbHmqX5qwfrksRS58HgLIjNWjgeRyI03nUSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604549; c=relaxed/simple;
	bh=9+IhYtjCrh3yLDjOwzciHeVQHjS5kV8KhSvvSq+zkoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLn/SrPINpqIHh2XTe0qBCjfkeffeDOhp6x7PUjVlb2S+YCqzqb7FLuJueb4wUTmnIGujuZiEQEeU2reDjqGmV9dK+D599OplnLL7x2Ryy+jo+i/xEcVXakG+PPY2NGoc0mV19eP8IqBY9O0w0kc+SDPpa9TJBjxFlGSL/1dK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8+uCWeg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8+uCWeg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72061bfec2dso650742b3a.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604546; x=1732209346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJBxIWkBL/An0Wg6ijAitMSxTHjCH24xATqohL3GKk=;
        b=K8+uCWegEWR252OqY6oPAJAf0hY5Ipor2A4h1B8I02DGHWYrYHtSVpa9f1couvc6h4
         xo2LCe/PIvo1NbKE7FBQHuYEhFrTtBZnbxRze0I0iFszujtWjYyJiOGMS9gqj42bi1Lg
         WWmWnN/brIwYx77EgIs2mbYqGO99/d1agg7nHa1DWBXulLXWlFYfA5B3PZDxhVJ2P/Op
         v0a1sAPRNDmxAJfeIkXY2nW8UvsY3kFZOeokpKiH70pxh4FdI8IiBJNM8O3S5hCbT+4T
         6e5tgTpybMguX4eVoFy3BTowxWkUTkVmxj6oBJLBTRxfC/abJQsXQ2Aqyk+hMJGlh3BR
         MNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604546; x=1732209346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNJBxIWkBL/An0Wg6ijAitMSxTHjCH24xATqohL3GKk=;
        b=vK9s39QT44YkxF/62h3Xdwg1/FP8sHttFTaEvg5GfS76DYfE9JYWsyGHBvdyFAdphj
         YH7qYApUZW9iBVW4Rdxi/0TEMqQ7fl7N38LCwMdWNljjaTJdhjE6hhuaFAXk7BU16EPs
         IlBuhfgrI5HXGelmw5bKoV2VT7ZB6QG+zFw7PAK45MziHmKuInCOdBoiRfb7PWT8egAj
         KKjeKTFNodr9hUbFIZislG6Bq/UhgtaQ+VQc0XTdkqC9GRkhYOA1AYG/jVfJV7LbsONZ
         7u/urROSMio+7/9dNBtHzWirgjymD1u91GC3A11nthxajntmuszRA56zIdVscS0KEBNH
         suKg==
X-Gm-Message-State: AOJu0YwyP4NZh9LghfmIrhVf1UgSNyiYDqE9DPNbYbl8BrAt+66xTHjj
	yUZb8jT3G5S02NPnac208O/J0xrMUWjYABc+6HQtaMflC1DqxUUwVTYjzA==
X-Google-Smtp-Source: AGHT+IHIszBYW6viqQPqVMk+sVxpRBGnxXqCngjKe+RbuhPyPguK6eq4s0vsIivfET6YHNCmnlU91A==
X-Received: by 2002:a05:6a00:8cf:b0:724:63f1:a520 with SMTP id d2e1a72fcca58-72469df055amr3337748b3a.18.1731604545697;
        Thu, 14 Nov 2024 09:15:45 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:45 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 2/6] push: fix the behavior of the Done message for porcelain
Date: Fri, 15 Nov 2024 01:15:33 +0800
Message-Id: <9dfea9953c2a671600beebbaa0692a1e68afea34.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com> <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When executing git-push(1) with the "--porcelain" flag, then we will
print updated references in a machine-readable format that looks like
this:

To destination
=   refs/heads/noop:refs/heads/noop [up to date]
!   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push failed)
!   refs/heads/noff:refs/heads/(off (non-fast-forward)
Done

The final "Done" stanza was introduced via 77555854be (git-push: make
git push --porcelain print "Done", 2010-02-26), with the following
behaviors:

 - Show a "Done" porcelain message if there are no errors.
 - Fail to update a ref in a --dry-run does not count as an error.
 - Actual rejections in non --dry-run pushes do count as errors.
 - Return a non-zero exit code if there are errors.

However, the behavior of the "Done" message is not consistent when
pushing with different protocols. This is because the return values of
transport->vtable->hush_refs() across different protocols are
inconsistent. For the HTTP protocol, the return value is zero when
there are no connection errors or protocol errors. We should reference
the return code of push_had_errors() to check for failures in updating
references. Since failing to update a reference in a --dry-run does not
count as an error, we should ignore the result of push_had_errors()
when both --porcelain and --dry-run options are set.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c                                       | 11 ++++++-----
 t/t5411/test-0001-standard-git-push--porcelain.sh |  1 -
 .../test-0003-pre-receive-declined--porcelain.sh  |  1 -
 t/t5411/test-0012-no-hook-error--porcelain.sh     |  2 --
 t/t5411/test-0014-bad-protocol--porcelain.sh      |  9 ---------
 t/t5411/test-0021-report-ng--porcelain.sh         |  2 --
 .../test-0023-report-unexpect-ref--porcelain.sh   |  1 -
 .../test-0025-report-unknown-ref--porcelain.sh    |  1 -
 .../test-0033-report-with-options--porcelain.sh   |  1 -
 t/t5411/test-0039-report-mixed-refs--porcelain.sh |  1 -
 t/t5504-fetch-receive-strict.sh                   |  1 -
 t/t5516-fetch-push.sh                             |  3 +--
 t/t5534-push-signed.sh                            |  1 -
 t/t5541-http-push-smart.sh                        |  1 -
 t/t5548-push-porcelain.sh                         |  7 ++-----
 transport.c                                       | 15 +++++++++++++--
 16 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6677c44e8a..4845f63737 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -630,7 +630,7 @@ int send_pack(struct send_pack_args *args,
 				reject_atomic_push(remote_refs, args->send_mirror);
 				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
-				ret = args->porcelain ? 0 : -1;
+				ret = (args->porcelain && args->dry_run) ? 0 : -1;
 				goto out;
 			}
 			/* else fallthrough */
@@ -760,11 +760,12 @@ int send_pack(struct send_pack_args *args,
 
 	if (ret < 0)
 		goto out;
-
-	if (args->porcelain) {
-		ret = 0;
+	else if (args->porcelain && args->dry_run)
+		/*
+		 * Knowing a ref will be rejected in a --dry-run does not
+		 * count as an error.
+		 */
 		goto out;
-	}
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 373ec3d865..5ff901454a 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -73,7 +73,6 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 	> To <URL/of/upstream.git>
 	>  	<COMMIT-B>:refs/heads/next	<COMMIT-A>..<COMMIT-B>
 	> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index 67ca6dc4f8..f4cdf9db42 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -18,7 +18,6 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 	> To <URL/of/upstream.git>
 	> !	<COMMIT-B>:refs/heads/main	[remote rejected] (pre-receive hook declined)
 	> !	HEAD:refs/heads/next	[remote rejected] (pre-receive hook declined)
-	Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 04468b5018..563de67859 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -17,7 +17,6 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
 	> To <URL/of/upstream.git>
 	> *	HEAD:refs/heads/next	[new branch]
 	> !	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual &&
 
@@ -52,7 +51,6 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	> !	<COMMIT-B>:refs/heads/main	[remote rejected] (fail to run proc-receive hook)
 	> !	HEAD:refs/heads/next	[remote rejected] (fail to run proc-receive hook)
 	> !	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index 298a3d1fec..096f13a832 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -21,7 +21,6 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual-report &&
 
@@ -59,7 +58,6 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
@@ -90,7 +88,6 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
@@ -121,7 +118,6 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
@@ -153,7 +149,6 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
@@ -183,7 +178,6 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
-	Done
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
@@ -219,7 +213,6 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
 	> To <URL/of/upstream.git>
 	> *	HEAD:refs/heads/next	[new branch]
 	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -260,7 +253,6 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 	> remote: error: proc-receive reported incomplete status line: "ok"        Z
 	> To <URL/of/upstream.git>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -294,7 +286,6 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porce
 	> remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"        Z
 	> To <URL/of/upstream.git>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index 502b34fe3d..c4b1d25562 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -22,7 +22,6 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/por
 	> remote: proc-receive> ng refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (failed)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -55,7 +54,6 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/p
 	> remote: proc-receive> ng refs/for/main/topic error msg        Z
 	> To <URL/of/upstream.git>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (error msg)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index 6d116ef692..d224e2400e 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -28,7 +28,6 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 	> To <URL/of/upstream.git>
 	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index 8b3f5d05a3..278fc597eb 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -23,7 +23,6 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
 	> remote: error: proc-receive reported status on unknown ref: refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
 	> !	HEAD:refs/for/a/b/c/my/topic	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 2e1831b104..2c1117457f 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -25,7 +25,6 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/
 	> remote: error: proc-receive reported "option" without a matching "ok/ng" directive        Z
 	> To <URL/of/upstream.git>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 40f4c5b1af..e1b64edea9 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -63,7 +63,6 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
 	> !	HEAD:refs/for/next/topic1	[remote rejected] (fail to call Web API)
 	> !	HEAD:refs/for/next/topic3	[remote rejected] (proc-receive failed to report status)
-	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 138e6778a4..bf33cc69d0 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -68,7 +68,6 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 cat >exp <<EOF
 To dst
 !	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
-Done
 EOF
 
 test_expect_success 'push without strict' '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 331778bd42..b133ab6ffc 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1190,7 +1190,6 @@ test_expect_success 'push --porcelain rejected' '
 
 	echo >.git/foo  "To testrepo"  &&
 	echo >>.git/foo "!	refs/heads/main:refs/heads/main	[remote rejected] (branch is currently checked out)" &&
-	echo >>.git/foo "Done" &&
 
 	test_must_fail git push >.git/bar --porcelain  testrepo refs/heads/main:refs/heads/main &&
 	test_cmp .git/foo .git/bar
@@ -1207,7 +1206,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	echo >>.git/foo "!	refs/heads/main^:refs/heads/main	[rejected] (non-fast-forward)" &&
 	echo >>.git/foo "Done" &&
 
-	test_must_fail git push >.git/bar --porcelain  --dry-run testrepo refs/heads/main^:refs/heads/main &&
+	git push >.git/bar --porcelain  --dry-run testrepo refs/heads/main^:refs/heads/main &&
 	test_cmp .git/foo .git/bar
 '
 
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index d43aee0c32..2e40bad53d 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -385,7 +385,6 @@ test_expect_success GPG 'failed atomic push does not execute GPG' '
 	=	refs/heads/noop:refs/heads/noop	[up to date]
 	!	refs/heads/ff:refs/heads/ff	[rejected] (atomic push failed)
 	!	refs/heads/noff:refs/heads/noff	[rejected] (non-fast-forward)
-	Done
 	EOF
 	test_cmp expect out
 '
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 3ad514bbd4..b543c10314 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -499,7 +499,6 @@ test_expect_success 'report error server does not provide ref status' '
 	cat >expect <<-EOF &&
 	To $HTTPD_URL/smart/no_report
 	!	HEAD:refs/tags/will-fail	[remote failure] (remote failed to report status)
-	Done
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index ca5cf684bc..424391eadd 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -110,7 +110,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
 	test_expect_success "git-push --porcelain --dry-run ($PROTOCOL)" '
-		test_must_fail git -C workbench push --porcelain --dry-run origin \
+		git -C workbench push --porcelain --dry-run origin \
 			main \
 			:refs/heads/foo \
 			$B:bar \
@@ -176,7 +176,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
 	test_expect_success "git-push --porcelain --dry-run --atomic ($PROTOCOL)" '
-		test_must_fail git -C workbench push --porcelain --dry-run --atomic origin \
+		git -C workbench push --porcelain --dry-run --atomic origin \
 			main \
 			:refs/heads/foo \
 			$B:bar \
@@ -257,7 +257,6 @@ run_git_push_porcelain_output_test() {
 		> -	:refs/heads/foo	[deleted]
 		> *	refs/heads/next:refs/heads/next	[new branch]
 		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
-		> Done
 		EOF
 		test_cmp expect actual &&
 
@@ -325,7 +324,6 @@ run_git_push_porcelain_output_test() {
 		> !	(delete):refs/heads/foo	[rejected] (atomic push failed)
 		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
 		> !	refs/heads/next:refs/heads/next	[rejected] (atomic push failed)
-		> Done
 		EOF
 		test_cmp expect actual &&
 
@@ -396,7 +394,6 @@ run_git_push_porcelain_output_test() {
 		> !	:refs/heads/foo	[remote rejected] (pre-receive hook declined)
 		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
 		> !	refs/heads/next:refs/heads/next	[remote rejected] (pre-receive hook declined)
-		> Done
 		EOF
 		test_cmp expect actual &&
 
diff --git a/transport.c b/transport.c
index 47fda6a773..9e03a7148c 100644
--- a/transport.c
+++ b/transport.c
@@ -1486,7 +1486,18 @@ int transport_push(struct repository *r,
 	} else
 		push_ret = 0;
 	err = push_had_errors(remote_refs);
-	ret = push_ret | err;
+	/*
+	 * The return values of transport->vtable->hush_refs() across
+	 * different protocols are inconsistent. For the HTTP protocol,
+	 * the return value is zero when there are no connection errors
+	 * or protocol errors. We should reference the return code of
+	 * push_had_errors() to check for failures in updating references.
+	 * Since failing to update a reference in a --dry-run does not
+	 * count as an error, we could ignore the result of
+	 * push_had_errors() when both --porcelain and --dry-run options
+	 * are set.
+	 */
+	ret = (porcelain && pretend) ? push_ret : (push_ret | err);
 
 	if (!quiet || err)
 		transport_print_push_status(transport->url, remote_refs,
@@ -1503,7 +1514,7 @@ int transport_push(struct repository *r,
 			transport_update_tracking_ref(transport->remote, ref, verbose);
 	}
 
-	if (porcelain && !push_ret)
+	if (porcelain && !ret)
 		puts("Done");
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
 		/* stable plumbing output; do not modify or localize */
-- 
2.47.0.rc1.21.g81e7bd6151

