Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975C43636E
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083532; cv=none; b=PE/HndLrEQoG0f6zZX9KR6E+6FwpQcGx557H7Q9ecNmWL9hz+JayoRRAZlt5OejfFDoNeMTe62rEtwW0DRCowxKBjB8ZRd7BcgPMulBdgueFPF9ngzD6n0EyWEGquy1GeQgHq1eQjbiMxzd8aW/XghcBT+96KCUvE0PdA/PMLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083532; c=relaxed/simple;
	bh=axQHNdrbllrWWA/v5lJIP40DeZh+zL5hTu7Ddp4uldU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzsR1iJJ4ItHBvi6aB1Xv8LyZh/QDx6MIOXuInCkjTFGkAoOt1eIiLk6x9x6pz+z+DYWtG1o3vTwhQ1fzUniiXh0S723N857UTafW6YfyCFzqJsfuB5sQS1vySMehJY/jxRlMqgYlpzbN+1XLaBn9e/hJmhhA3Dq3QcW4wFY02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmyLUEAe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmyLUEAe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc32725so7091845e9.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083528; x=1769688328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwMafydlJEUyim7ej75CGto41umOyEAnn8SHOcaxsys=;
        b=fmyLUEAeXFvcFoEtdyZmMvYP2KDCkyoVmq7PQIuYjsz6cqa1diEUpTkMkvrjFQijPq
         IQVrTXEK8Zwav3cL4Z2XteoAwHsiAQ1g5ZN2o6VbW8jBjjXu9u183o2TE9A8hGnFwUVC
         Lk6O5kCOtPyXTwDzbYuG1aFwL2cQB56ce3jtu8veCDgYcjlxqKzpdvQPugAHtfuRbFPb
         K6Zz/c24qN3W75rukqyWEc0WWkphmkXASd0Ir8bIgnGrPi73RMSJzicn2FftgQ1LKUON
         JLCIKPdVLuIHlFVB2cPFNwwVUbzsWTBOPo55j7o0XH4DukBMUaOQSoJz/9Z+r6wtcIQe
         jndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083528; x=1769688328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwMafydlJEUyim7ej75CGto41umOyEAnn8SHOcaxsys=;
        b=eZoTy0uqC1gNEcaDIS3abm3WZhNY7HE047x2SHIj4JHZOQit/qbMM7Q54A9CEOwY3X
         +3FEP/NMmg0ukJ2oX6cYawhJibEHhldmZmo+3IKwxneqSE3kMztHncI0qu4PA0nNxgrj
         YG9uL8q0U11FPRfGlv+cQ/Oh/IpIMr9EXgNRmlKKzQVlsLXTBh3XLU5j1CQXu22okg8B
         N+R8G+Y6Ful2GDQoD1BGk4IObtIJwj+V08+lvQsa8U67/a/M4m7ZH7fPh4Uc+wyx4VaE
         WLs6hvRpo3VseNlWHVXfiCHwUtXPYwQqUx7G4mEU61zCOWLcdBgmC3jwwl6Rfj/cvIur
         40pw==
X-Gm-Message-State: AOJu0YxJrYdDm7foEkb2sLLZYLJ3U4Ov2fSqinaQLqhdatpyHBghk+uu
	dn+CEwpD9fOj+3SsehHrvgiTK8qRFMKSG0Ck8y6cJjSYZB6HFJYRKqUo
X-Gm-Gg: AZuq6aLe6375uRB0wlBKoYv7MzlFjh4k7Sv9f4fDuXMJFacpZ0cwuJ2Zg64M9q0pVLr
	EY/kD90hMMD7ibQI6w65EYt+PEGNFJMiKnQy3LBeUyM86jUUiTeQp7mNwF5Z68lH+C/Q8Pl9Zju
	vTP7ywXB99X7K1Yc114f9gG4tfgwGmqVBjDUu+sHKLcAtdI3QH6N+D4+Me2Iy5kvG5V6ksYbrJy
	Y2b4CfU06GwsuMApeFdEYHWYtKuxQq1A5ZXPmg0bCfxBPAoNqgD5Ld7trjhR1xo8Y4NN9hUy5pi
	6EzI9r3ZEPUTybTNGgYaaqapAqUQYDz3H4o3qOfc4nbfNPLgYXYG0ODmR+0JxpYQC8Ke3TmtqLQ
	DX9sNdzR+OOzDxQdMpykxwjRM/vhRsh5hxWG+28id10ieXDeMmIib+ZFEBKty6/ZL0T+x8Grxrx
	crGV1LClgFg5HEWQhCKy+dQ389mT6n
X-Received: by 2002:a05:600c:4e86:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-4801eac4779mr275893065e9.14.1769083527903;
        Thu, 22 Jan 2026 04:05:27 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ef49:411:ff92:1c50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm64926445e9.5.2026.01.22.04.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:05:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Jan 2026 13:04:59 +0100
Subject: [PATCH v4 5/6] receive-pack: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-5-2ddba0832440@gmail.com>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
In-Reply-To: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=axQHNdrbllrWWA/v5lJIP40DeZh+zL5hTu7Ddp4uldU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlyEoG/VOQxYnpDTonVj5kGJS9ZrDWLPI7Lh
 QWjgvbrxJgkiokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpchKBAAoJED7VnySO
 Rox/CPwL/3Efp83hMyx5hZcTHrlIOekB4MqRsDDYhpMt9ISANBKMPduyMmQmSWPqGyLpOgVilvw
 GxSNzGLknhXxq3SqK6CDiTIB6T069+a3PSW6JJZkXmqtC7hr7ku6rJyk9bhhiRd9CbRygX6py+0
 2gWkrs95LgeF/3MfCzhFgbgVtGxLvYdHtMHscZS2ZG300jY7DvBOLqYd0x68rt6CevmWJVghHr3
 IImHbw0ktls3SlOa2Urs4EljdcmY/sMqBAae0u3A7O8AZvRIE8TjQrW7dUHgL/RlEd1JYX49SXr
 QmEV4MsyS2s2WMq4ehHbQOR85EM744OOoMlV/1gd+oKyRZEfFgR7B6IiECnc2/6xjw1aj/+cnlS
 1Wl/RHBTkIjcy6djHc5mky2A4jQf/Ky9/M2ahs9ZWr+reqkYH3sLIGqeswgE613IC+8tvMhwa6r
 ciMt0QGOoLJMZScOn7fDUldbKmP/sBHan89lOd+9YiV3QaWLpG16+GU5DpOjTCO6632FZBvWuV5
 OU=
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
2.52.0

