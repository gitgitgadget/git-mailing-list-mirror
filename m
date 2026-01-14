Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F23A0B23
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405273; cv=none; b=aDs1FRR48pYmhdx76im1LXScLQQfr320MXTBDrKIF3G/UGGYroz6xC6SVgAYA1jIX96hvL7iVfaYIpDIztZnTmjNsLiJAssOmd5VjbjKGbJqZMegD5uahVmfKZuBr1AcfPXQOSzZ00TaTi1XY1pffOaku8X8+C4ZJdNrx60pE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405273; c=relaxed/simple;
	bh=u9ESgyXdftevntYpBo5J2q4gbn8/+50wr5NrLto+9sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DByDP8SmLlRqpO1msBJ66QmdcuvPee4XlC/I3rkE7QRFq6OnpOF2jcf0/eUTl1/RfrXGXGMInlNHjfPdvwk0/CFVWM6L4vPPrcFWVoe9Igfv9zgTTG0hO9tbtOWgnRn4xz/3YZONCiQS0Z/z4y4lGMHmAJGbVzmLWtck6VlV5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH/wHGeD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH/wHGeD"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8718187eb6so503162266b.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405270; x=1769010070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TY2TpiNNEgze+x5PHHEwPz4tSKqNdWdvg34sORKXoU4=;
        b=bH/wHGeDLMR0Vkt/QdyjoNjBsaxvt+cpdKRbL2GfZmSeqHDfZzTYM2Dw4R8272l1zf
         6st//hkE+vckpEZZDfpVIo+fiHNu2pfX6WXgYZUa9KH5NVYquPlvlEsXlS/zUb11lysC
         udAzOXPRbFJJ8BmJkNjC4xZ267wLE7oa+VRvlP456eYj+7KISkDCRbxgfuKGEWgGmkue
         y5gvaybrI43bqIPOO7VJ/RSN/x+TJXfzIdVldQsZIfbz0R8mt2AB6xA1vDzciEtafc0S
         LHaMeHe2XmRxJJpIziaTUGnbvQZTcpxMjjjS25M0423kE8HMh1wfXKH7laQhfSqDKU4A
         y5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405270; x=1769010070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TY2TpiNNEgze+x5PHHEwPz4tSKqNdWdvg34sORKXoU4=;
        b=JFoLgRh1W23CWtEBMwTsZORa0fzpyuDtGdhvgj7cezENDccNsB04mE6iR3cN5mR+vF
         skVyuQHcbkPbHzJBUPBQ8GUHKB62c90AhHJ7ATVNSs9N7LiVC0us0TPa9IeDjWdMsMre
         MV3crdWYNTodVAavTq61oYgpCZFQEh4Zf+Xsj5W71M1QVsxdeNGBCnUipK4CvPNQyNvD
         zxjlVu15vRUA/T60twnmC2h0P6rKchOQ+8+OGtXEnU0aSTUb8Q6DFKNDU1uFzYPDH+4J
         vsljzHTEDn2BrZm3ZX5WZQh5qfygvv6lQLS2QrpHSmCE/E0s/7SNbAIauPEqezTAT+hT
         aLEw==
X-Gm-Message-State: AOJu0YyV0H81nbY4SDS7jefgk5N+KQXpwcUpvjaN9BlK3oYqLC2zApVe
	/LsY/ucpPul1QRaaetchKu1auNZJoiWdo+4GoYjVp0S6Lh4qmqwxLNTF
X-Gm-Gg: AY/fxX6UJgLXA1+jEPdrRgaZt5KAuSd7z03tDqTevSfAXwUFsCDO2T8BPAGPk3XL1SO
	va0bkDaNOcp44E0BuK6N7YNZCyeA7kRi/OVHPo85jMi8nKhtHPcNXu3nD2JTbZiQzj0sL7lBb6r
	A1Vy6Sk2sDcdN8MrTuo0ljb0Gtv307fCf5vZcY0PKdl6KI5R2+sxxtbhyyOHtCVLSe9nI+du/A9
	qNbGwWzbSIYnHBGYOG0pFIZJpcpOotD5qQDUTy9ffaE5u7dYLsDukD+TqIl4M5F0dzMKH+NW+Fe
	FcsIOO1u5mDcmFhq7NKISGBeJz+lfXDNkstjipSXUqAKSLC+jWuE7mStgX/ypC3J8WEpnMY7y8t
	ZJTLKtB5G/MORpoLE67x84OdT8GUdE7nhCap8qn7TEXTMv//3Ag+/hUShjixS8A8z4X3OoNNp5E
	p1srFv/QzQ2lckpXrQ428=
X-Received: by 2002:a17:907:841:b0:b80:3fb7:f3a8 with SMTP id a640c23a62f3a-b876142f5f7mr291778066b.63.1768405269904;
        Wed, 14 Jan 2026 07:41:09 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Jan 2026 16:40:47 +0100
Subject: [PATCH 6/6] receive-pack: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-6-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=u9ESgyXdftevntYpBo5J2q4gbn8/+50wr5NrLto+9sw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuRD2MfUIlwldwj5hJfVXTJ52hSdzNwXfQ
 G09n0wrb28M84kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kQAAoJED7VnySO
 Rox/s7IL/jkyBBaWjsEFjOY06IoJCCLn1q41NuAxCezpuoer4sADPSOj/q7Y11CzKM1/PwwgbEM
 JEEDMF5jHxUmU5hTdiWYyTZSAa/a06roT26EyJeFUxS8ueUsTVe0R4XTAudleC0ojttORzRxXJs
 ez0MA/VQUxbELkWmRyi9/VR64IZESb9CV9knzvPp681cq86eN8RIvu/O9wFdd64c22wT0DVbhvj
 /uAirix6fs0MNYACiO1gjYHAMP4k8nSbBWR1mzPBdHsXSjgBBvdUXgh4sCHs715pm3LXBLLrpgT
 LxjWovtGVaTSRARpygIDJJpIKNQLw/o4kawny30jDk2lWuNqSfrhW13lDmq9lg2W8jz7jHIH7IT
 D5ORHFiDb533aDp1XNbaICDO+Yyss++lOKhRKXUacyITHzdYmaShYnA/6m8QwTZv16e500g7Dg9
 DSdgzDP+/3T+Edca3spm4+8mXkfZF73W0EzODVeNwWEsleQobyLgTFeD8UwbK8/8IeSNbYjw/76
 pk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19),
git-receive-pack(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Similar to the previous commit, switch to using detailed error messages
if present for failed reference updates to fix this regression.

One downside of this is that the messages can be very verbose, for e.g.
in the files backend, when trying to write a non-commit object to a
branch, you would see:

   ! [remote rejected] 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d ->
   branch (cannot update ref 'refs/heads/branch': trying to write
   non-commit object 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d to branch
   'refs/heads/branch')

Here the refname is repeated multiple times due to how error messages
are propagated and filled over the code stack. This potentially can be
cleaned up in a future commit.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 10 +++++++---
 t/t5516-fetch-push.sh  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d3e73cee..969d59ae3e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1813,12 +1813,15 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct strmap *failed_refs = cb_data;
 
-	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
+	if (!details)
+		details = ref_transaction_error_msg(err);
+
+	strmap_put(failed_refs, refname, (char *)details);
 }
 
 static void execute_commands_non_atomic(struct command *commands,
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

