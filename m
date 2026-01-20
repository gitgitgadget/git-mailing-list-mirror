Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0B3D3CF8
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903184; cv=none; b=bCJONa/lXJravbAHIKDgGNHf8buxrD+UvIMIfcgn/g6D0jixnxb9NGOBBXHGGnt3+00Y7AzS4B41hq1L978ESyZIxl7gHMJtV1RwfobH5eV7LGPKQMNPKk0G2AhqIHD6svGqTz3aibOl7cRTxlycKqLqvesz9k+YXa3whWqNRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903184; c=relaxed/simple;
	bh=wv3Ur+P4oXks8vKU796VlZkPmJadl6J01y+zjlIdhZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIHk6m7DjhcsyiQW+4uVvDBqEq1AHY6H+ASx9wQX8T0SYui8/f+Vs183IgA4L2tuBznhd27Xj4LeQN2L0s8e8FO8o00GvTpbeHeFayj6tX1lTobCcAnRpRBWiAe6SCyhtFVZNltr7VRUe0pLueTPrIMYrEVlK4NE6RfkaDabvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQFU6s61; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQFU6s61"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359228b7c6so208423f8f.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903180; x=1769507980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7GPScBVSStWY5FuyUuy5LXa0II7eZiBZWTbPV4c3lU=;
        b=UQFU6s61g6GnuV/2zKd4z1ZH+vfgAQy2h2M078k7izGNwVpxfEYwfy9ay6+eEAikqu
         lgkyL46fgdatQmxYP3DZcsYLZqTOMsOnGWwgdI7qeX76Bso2sMqtsAft5GtdMYTYEAF3
         qt9jopZKFWJCPmUQuWbHcPsIvk6tPH1KyiDBaeOEmKkuooeNZU4xmYZeJetMue1ub2Yr
         4QD4P97wXbsQfhneZmNBFt7gbIaHhLA4ns9uYF2o0aNrybBz3audyKvwebys2ZYfltgP
         paTSN1QtUW1oEKGEq5Jd6MGzCx/fyYrlfyJVw/t1g26xryKYHXzVHPucSYyF5h5KytZi
         HKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903180; x=1769507980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7GPScBVSStWY5FuyUuy5LXa0II7eZiBZWTbPV4c3lU=;
        b=Lx7mgVAiFx2o5vgDB1In+Y2fGNo3w2pBEuAs5kqtZKYZS1rYshKc2oBftU6wWCWwCu
         oNeC74oniFRJXElrsAZ+OABFsLMLl/N4hCH1n7dfB34zfqVhVGhesJmSlduA03BM0225
         R77aTxFA88rQd+jvXG9wsGLGqGahxFbbOoMUlWEvEzcT/tlDw6ENKrUYWLR7qPDqqbBU
         nzuVMscGbKRCb+JSFDmc7k3uDVxoIpau0xr4MtFbtqThj9JHRhFyPYxMD+bSpiI1HMn9
         CQLYXTLg72uLTJsTsfxlnOZnRviVAulQHD6AwgL5PgKHn8rfkhyB5GCi3w3PdgVOAJx5
         +bSA==
X-Gm-Message-State: AOJu0YxZKIRuiS4Cp5qldQjbudcM7oRBwTv7ppVCmPFa+ejVjTv6dnlX
	fiTqnsGS0MYCd0fXZI7rzy5tHPsCeKCWLMepS81tez+qCvsMCDyzjweN
X-Gm-Gg: AZuq6aJ9UfyCVw51UAYWvTcEh9VveK45eNbQOxPOwNoHXHKsX9EW5a8IjnjH0HA6JZ8
	0B4AmoN893geTa8asOKV3HMlQpakBxvzz2JxOaNq2DIHJD5Un+trO7bg/IGq9QYdDRPF8jKy64i
	MqNL9P7TfaOCT33v8A5KDvdm82SuXV0JPr1u9didAz4EHG3rFcR15aiPKXpin5u+b2A0C88bcm2
	I2g7J4OZpCplJDyfdkP94Q580fxTRaPZF8mLUDkIZ3r0YXTO79E67yNeINrgxUJT8jggyRcwE6c
	aC++hjM4ozSHm829GqG5to2MPFXrAjTWzA7Gbz/cgUggnoqE/hBdsn/HiP/FONAdkSrvzc9p6YD
	O6zCLC5spM9PWUicIdtYezx011xe+8tCB+eefLbtMQS7KzQVByF1dgE/Qmn/cU8Y0/dg8aNzb+B
	FqZrp1/7LLiBShcZ83EBl0AYe/z6mc
X-Received: by 2002:a05:6000:2203:b0:430:f255:14b2 with SMTP id ffacd0b85a97d-4356a026486mr20683955f8f.13.1768903180503;
        Tue, 20 Jan 2026 01:59:40 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 Jan 2026 10:59:23 +0100
Subject: [PATCH v3 5/6] receive-pack: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-5-e0edb29acbef@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=wv3Ur+P4oXks8vKU796VlZkPmJadl6J01y+zjlIdhZI=;
 b=owJ4nAHsARP+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUgZtjxOYgqT4/OZ3p+ezHj9ENSq7t/jO8
 g2+5TSD9Cl7rIkBsgQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IGAAoJED7VnySO
 Rox/nbwL+P917uiigVawFtFRw0FI6pelMlxleIdoP/vsBxxgUWq8T6sL4beAg3cDhf42MS6sUgA
 thgpTGR3hwqM5g8C06sp7zg7sxdMaqtKeVCfLjq+uuVxJk+01m0xi+5+3MYbAa1p+aH+DsMpRrB
 AiTF+xWhm48breZH1+BHpD4O1FPplzqnetFj2TXd6UZIIImSejhYa/7/L6wzR5eO6lrbOfeZaiH
 DN/LVNPrGhWTJoJCCUXw4wWBnFDfYGizLDssq2mPezFwzdp2AAvo9gCvG1N5+TdYt+4MuqyUisV
 i0KPdWLXn2IaJKV735+6ilGuQNt5xIzKN6OCofPjP0mkVYFajei5EEHlu+gp3Vy+yCNsuw5ZOTV
 xri7l17Bo2itJZ+sLPiWZ89JPohSlex8ibM/+RqvpNmPEMBu68PiO1LBqQL0VbU2G67IFDoZfyi
 jOsK7Z09wNa2i8EI6pHmOm/e5Az/xtV1LZgIe+ugU/1VO4cmZJ6qTLHDvQIv82FEdRXJ9oimrt+
 g==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19),
git-receive-pack(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Now that the updates also contain detailed error message, propagate
those to the client via 'rp_error'. The detailed error messages can be
very verbose, for e.g. in the files backend, when trying to write a
non-commit object to a branch, you would see:

   ! [remote rejected] 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d ->
   branch (cannot update ref 'refs/heads/branch': trying to write
   non-commit object 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d to branch
   'refs/heads/branch')

Here the refname is repeated multiple times due to how error messages
are propagated and filled over the code stack. This potentially can be
cleaned up in a future commit.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c |  8 ++++++--
 t/t5516-fetch-push.sh  | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d3e73cee..70e04b3efb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1813,11 +1813,14 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct strmap *failed_refs = cb_data;
 
+	if (details)
+		rp_error("%s", details);
+
 	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
 }
 
@@ -1884,6 +1887,7 @@ static void execute_commands_non_atomic(struct command *commands,
 		}
 
 		ref_transaction_for_each_rejected_update(transaction,
+
 							 ref_transaction_rejection_handler,
 							 &failed_refs);
 
@@ -1895,7 +1899,7 @@ static void execute_commands_non_atomic(struct command *commands,
 			if (reported_error)
 				cmd->error_string = reported_error;
 			else if (strmap_contains(&failed_refs, cmd->ref_name))
-				cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
+				cmd->error_string = cmd->error_string_owned = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
 		}
 
 	cleanup:
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 46926e7bbd..45595991c8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1882,4 +1882,19 @@ test_expect_success 'push with F/D conflict with deletion and creation' '
 	git push testrepo :refs/heads/branch/conflict refs/heads/branch
 '
 
+test_expect_success 'pushing non-commit objects should report error' '
+	test_when_finished "rm -rf dest repo" &&
+	git init dest &&
+	git init repo &&
+
+	(
+		cd repo &&
+		test_commit --annotate test &&
+
+		tagsha=$(git rev-parse test^{tag}) &&
+		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
+		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
+	)
+'
+
 test_done

-- 
2.51.2

