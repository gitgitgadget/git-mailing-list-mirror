Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C41DDC3F
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381571; cv=none; b=PeaakdcKeBoH+oQH33S6dEbJBC22+W2yK0Ip6DkpcOumZOftAaZwf37SOu2LbKX+2RFVNFqo6aheKfWXcIoU75jpnpzeCXfaVwgPtZEdQKzI2OmAdf+/tfqQ3TPFt8vZwR2PklOnc0iEa7SUGDE5D1juBOi9ljMogym7BPyvsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381571; c=relaxed/simple;
	bh=QVCgPcu+8n0+pnvjlqciULn2iHaIdeO5AswVSSYpI5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1bHYsb0HwACv2VslqXwwgIyzaRH3LJfiz+6khYShGD33HmgodgwoHWxEDq6O2E16BJ8F7+zUIOgD7rvjRN159i8lRH4sCoIo8b176gIThhmPSBF8ZfXasKO1yuM4LTtmQg2zRRM3aNoTCx2sFaaDiY5NaruiI2U8ditXeUSgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOX74IDa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOX74IDa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso45250715e9.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381568; x=1769986368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFdsjCLG22zeH25oN8mzD8T+Bx6rOvqESIF5/naLAgw=;
        b=NOX74IDanIOMw8kl74SZ7nB/UFP68Q1Ke2Bzhmc/dIi78b0lU0JkVD/xr/ySnJ3Wg0
         TxU0JcGRuV6g/S083BIzJc5qRK8uEE3aZcvN8aJ0x8vBg+ianHhQ5R0xb3fmD8dmlbqL
         2i6vQhG2RRVXW+GRH/2cm9Mox0D8K+s+Ob71vQp47pZoObpFyAGzmnRX7WNssHdp/tUo
         a7wDImDqHaQjzYwc3r7p7g4p2wZEWvw8odhffMjnSU011WiTAtzb9CKaKNaaskqNm5AA
         LMb6VoSkPNTJNrh1M8xKD5OvS83+qKk0cuHqDdaqb/Uewbm70NlUDUbyKJVAdoTuEoTF
         tnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381568; x=1769986368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFdsjCLG22zeH25oN8mzD8T+Bx6rOvqESIF5/naLAgw=;
        b=I2q1sVrrtKpKWTJvYjQRX0ef0tYkbQLzxsqzecA8hHpkh1j7GnZgAKpKBh+NwWlBJA
         rs6lWyqhc56kA3XejFQNQPLmACXnRmMw9xMJYj/9RjwHI/LLPa+/60ujN4RZq/38eRuE
         OZr400eXHIQ8lZbpEunkKZn4IiC3RGQW4F3N1bdLlOmjeLNru8bWTmcr3tG6BU+tRsOe
         3cX3NSc/ZzMDxbOZKEWMVCXhyMa0xoXcLH0b6moOuu9HXrNp6/a9JUScxkE4LXKOj8n7
         Edu/64EVEtZMh/vE/n9v8VBvBnX9faqSSPHEqBZaB2o/zP+oHt48xCjwsFXMgCCLXzDq
         sL/w==
X-Gm-Message-State: AOJu0YyZw0UQCfePrTUAl+frrFjLItF/KTBR9VKLVHD+9hEe2uKz1s9J
	kLoxG4ApuCzthmR+LROyF5BbeDYpHKJkwNc3CBpjg5P8ocdykLHe2aBO
X-Gm-Gg: AZuq6aLyo3BB4XRSKhB67DFDbv3MrA+Zo2HSUx7gc0/XHCHQd88lK8UbXY4psC12A/E
	OhiFZtQAnjsIX84d0IDYVQTTy2pRofYJlsOvuiEic4czOyiA4tGzpnIGd/a2OvVq7hqELhzMmRL
	nl5mztUIkj8e1FC/QfA4HTlX6KtgWNQGdxgmBUicy4N+B+MC0d9TnX1gqAlNq4wB5Atr0JeauPZ
	HAXGI0L3xjeNV0rVgxjnIUoXthAq58/SyFk53pPNpGfXkIaImbZW4jYgreUArVFvEQhTncZ3phW
	cd269o8u+TsbewH3g43NhUrQ0k6aTIBBWbe/pcTo9pTEqCYtp+MHNgGTSChwy0sU22t7QTeyXla
	1ENx4pSYsGgVHbjB6z8ooRc+IBk1qjEgnR13KpKbETWiz0Zm6K4C0fBci52R71vjP+jkPpYJvSM
	FmjAFaQPAf+ZCiBk45cF64ByImlTZI
X-Received: by 2002:a05:600c:4ed2:b0:480:462e:d640 with SMTP id 5b1f17b1804b1-4805d06c8ddmr45161875e9.36.1769381568120;
        Sun, 25 Jan 2026 14:52:48 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:47 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 25 Jan 2026 23:52:39 +0100
Subject: [PATCH v5 4/6] fetch: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-4-d58f3a9edf98@gmail.com>
References: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
In-Reply-To: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QVCgPcu+8n0+pnvjlqciULn2iHaIdeO5AswVSSYpI5k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nriGd0qJeusuVZwSXI2rhnCy0Qr3Rqf6E
 23FAI67DSxP1okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp64AAoJED7VnySO
 Rox/brML/Rf6h2CwMFS3qVaCWE+gPw6eqPO3L5BW8htCB811AY35z0MyL9q4uQyhlmqiwZ79aa5
 X/83szpI3YsgCYjWq2C5ZVDqcF/AmN7PDGxKrj95+M3dn89Fq59kQ19Vbicomx9bOG30D2iNugh
 NCXs7N7q/USl1odeI2TLKehJKr856gvGqHZjBrGyLldHQvKJ4Vh+pSdPX706NWJGrbcsTWlwkUy
 MerpBXaWU/43t6Y8JrdqXJW+UmgZGfdLmMF5EaxacKrFBXJjcJrTXQhOTpjBCJ1k+SkUXSVZX2H
 wB/0LA5ysP9uvok3cKorF7/0z2LFMbyIylNvTlhyodeyWqVEse8c6tR4Npz/8fpgagfPQuUimei
 Rd/B4WJ3dp8CtoMWbmkLJehG7Cx9wupPy5zW6CTtEkan1kfoULXVZXdnsAYIRBrH3nGUBs1zCdo
 AKq9g8udCJDSB8bYMjbvyWjNfLHnOHtNksW733nZBFKQdVguN4JcNHoxcbc0uMZRgWYniMXdS77
 bg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19),
git-fetch(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Similar to the previous commit, switch to using detailed error messages
if present for failed reference updates to fix this regression.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  | 10 ++++++----
 t/t5510-fetch.sh |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d427adea61..49495be0b6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,7 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
@@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"branches"), data->remote_name);
 		data->conflict_msg_shown = true;
 	} else {
-		const char *reason = ref_transaction_error_msg(err);
-
-		error(_("fetching ref %s failed: %s"), refname, reason);
+		if (details)
+			error("%s", details);
+		else
+			error(_("fetching ref %s failed: %s"),
+			      refname, ref_transaction_error_msg(err));
 	}
 
 	*data->retcode = 1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce1c23684e..c69afb5a60 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1516,7 +1516,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 		git remote add origin ../base &&
 		touch refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/branch >actual &&
 		test_cmp expect actual
@@ -1530,7 +1530,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_fd &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot process ${SQ}refs/remotes/origin/foo${SQ} and ${SQ}refs/remotes/origin/foo/bar${SQ} at the same time" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/foo/bar >actual &&
 		test_cmp expect actual
@@ -1544,7 +1544,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_df &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot lock ref ${SQ}refs/remotes/origin/foo${SQ}: there is a non-empty directory ${SQ}./refs/remotes/origin/foo${SQ} blocking reference ${SQ}refs/remotes/origin/foo${SQ}" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/Foo/bar >actual &&
 		test_cmp expect actual
@@ -1658,7 +1658,7 @@ test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 		git remote add origin ../base &&
 		>refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		test_grep "branch ${SQ}branch${SQ} of ../base" FETCH_HEAD &&
 		test_grep "branch ${SQ}foo${SQ} of ../base" FETCH_HEAD
 	)

-- 
2.52.0

