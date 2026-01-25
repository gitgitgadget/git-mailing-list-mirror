Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75F30FF04
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381572; cv=none; b=oKt71peB9Tu3NA9iGm/rORmH1x7zphZR21r/L8bCr9qmm+WK2lnk9bdNk4PyDww0jxv3UWaSwElS/GVxXZGF8AE8eph/c5Nm64n4l1K7DoCjnNzdjzETivAbrK//6InFofN9ojZw+Qs424GqPlyEPxCNIb2Zzd2azX/FaNDxUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381572; c=relaxed/simple;
	bh=axQHNdrbllrWWA/v5lJIP40DeZh+zL5hTu7Ddp4uldU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RoaKe7Nc07EKFY8pX18VX441AJ7P/gaLXwofPY/LJc5CeJqksYDkmNA6gDsJWOEenP12QKHBo9mvgEfGaDzRAXkLyenwFvSkWn/rxtC18XQjTsnB43KkJtFya9tq72M982WEa68HAPaxvT1o0WDCcnL8eZsra8UUxXgMOUtUHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjNANxon; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjNANxon"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso33069405e9.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381570; x=1769986370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwMafydlJEUyim7ej75CGto41umOyEAnn8SHOcaxsys=;
        b=SjNANxonRVpGHv2YB2E/iQ5Y+jbmdUnt0U8FSG09wpk6A6jnDuUleZA6utqH3InY+e
         jRd/oc/HsOp1LIfEm/NwW54AKCNXLn+psHp3l2S6tKJHora0dozWTP9dQQ+4uiYPsA4X
         vw5ipQBs07l1Gm1sz/nabSI+DusVwpHSWeKfDSheoSmIT9MC5du2bD1CwkzjNUVIrac/
         VbBl3AZovfHmpO5Nqtk6bxCa2zYB7bk1YBwoi44wUS30ckP5j0jMJOHuE9rI2eMqvowH
         bcmkBAGFC/FT60m2484/mNoBa4+kBWg+U/o7r0A3OUJl6iqXm3WmQpEu3ibAo0lamlNW
         793Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381570; x=1769986370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwMafydlJEUyim7ej75CGto41umOyEAnn8SHOcaxsys=;
        b=aLzg36phirtR/XP4+YjhkBQ/X9iWsvb8IIZ3ZjEN2Uzcj2XIaQykBD8iDcQFkIuQHx
         Gob16S+gmEHz9tn6oMuyP/R+MSvO7kTwAthUlkbw1WIoZdZp6JdGsFNzWG0NMvuRSNG1
         N7iaxUdISrlZ42c1x+QuRlQ+M6AVFQzonNn6zd3ne63haDfIf7/xVk+H2UqiukdEl+wT
         IEk1XfsmPrw8psMb3MraD9VzEN+74ZJhkBC0iBCz9lBf/2vt+OqY3ZIhzpyAv8ydzIHc
         FFGwsm4c4H0UWhw3E5ZX9JwS+aSD/oxSvyLLQxkRSFGS2iRmNap7H39U4rKxNHQKr9cE
         z1Ow==
X-Gm-Message-State: AOJu0Yw/tJeSBAFMtm7tTPdLXa64+8BGd7IK1hWRxOYeDtqyl+OjzrgW
	yz+kQqRICsjb/FMTqQFQcmFkpkZPnsO06Mm7LbdctBLgSBpX6XjTg2GX32b7LA==
X-Gm-Gg: AZuq6aLLj1lDct8QJTbevxgT5GOYhJVTK3jCwEOIldC113883TymTKYqyJKiuwaXa/a
	THQASAgj6tOJerkSvOiCsTUIY9HJ/IToaL/rStZEqbBc61p4pnCNkdgiwrZjgg74MQAXpFvajeU
	ZIV4XvJ+eTCa2GMG0Cukm3/2qaBL1U9sMeS3b896JNh3o1ubKsencyWgFGLkF/k5L1UsKxFqzMd
	eYaKFlddIo0/5h/VmppeRyTIJCXn8Drn0rJD0o8LkV88CL/o5N5Kmgg2diPXZPL2386K7Uvf2JN
	sZ9iSfaaH+dUlaAgBhJQCS9Xv39GMy040ottzJJ069NDtYHkHhuJMHQrcwBwul303cTWMb6nlmL
	8iJ0OMegj2neIK22zddE1JVrPw3J9u8BENEvvt1Kfxt41KPSq8y7y4CDZ99qcLItv0be1cc6u3o
	vHcu03Axt1WJRe3Qd7AA==
X-Received: by 2002:a05:600c:c165:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4805cd0e361mr47398035e9.4.1769381569495;
        Sun, 25 Jan 2026 14:52:49 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:48 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 25 Jan 2026 23:52:40 +0100
Subject: [PATCH v5 5/6] receive-pack: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-5-d58f3a9edf98@gmail.com>
References: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
In-Reply-To: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=axQHNdrbllrWWA/v5lJIP40DeZh+zL5hTu7Ddp4uldU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nrhuZEj+B/GyRjBQ22+TIQGlZ9wGYdQU1
 0ylQLqRUbk74okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp64AAoJED7VnySO
 Rox/UZ0L/1+gSEPL47A3kGRbTjhTL68ZaVX5BjsGPK8dSG2awabwgN812dVTAnQEgCZtSRozEId
 HlQhlfKKNLva/zQsib9s4LYlPM239mTC1u9wDV7AGjFJmS6ZR8hSaYOdvJIRC5b+4Lps6f4jgaZ
 yXaG3p7MjWmde1TQ7ewTbsXQBcxmY2nD5jWth4bq3Xg9knXgGctdgBMxQcEXEwjkzLeGUZEyDg1
 VjEDVbH/qC9HVBZ22iZRbm+i/7PjqAl8lkC0mbkmBMdDHwmbjuUuDiNYZqM99/CArwM8saLw0Qi
 3SSbFxd5ouSbovvy7TQ16y46Ax6bXSCFC387gYLpzadKy9rYc30V7mLmKS+x//BteXPkhaXAMTW
 HuAzVL0BX39+tpVbD1iFrEfQ/BsZkciLCpy7rcRGYCls4vSWxGxzPcHywH3SJsX15z58e+IqJxg
 LsAnzIO/FYtl+v0q09yNkURU6qbkxlmFZ7hn1EwHl3zfVWFKMEDM+K0K4CgPNjx9vB8HjgAgl35
 HA=
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

