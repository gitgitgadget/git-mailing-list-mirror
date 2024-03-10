Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0F3A28B
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096425; cv=none; b=ROpMorI6O7jrNPGeLd27F2J1luexv+y/OBEgUle63G8FPKgTQNgHGR20Dvgfqat32rbkABvRYqewuIB/kNByU7GLvAjQPvMeT3ZEV1gytR9nY2hZPBMgpIW7tyzSnuhXzMDonwEipO5Ll1b22MbRPBK+X2pceb/qYJ5zyKEaQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096425; c=relaxed/simple;
	bh=ULNyA2bK+bCi0P36K5Jmp9lCmTWnajWAqSj+TyN7rwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoM8p2qf17wUIl2Uee4iG0a6asYfZiamVekXOZKdm50/BrcONuHw6kTN7TmHKWaxvJSSoqSXjCxsOP2NiHnobXbeXIzYzXcvAOEWgOcYsg6MOPx2ICD8HBwQh9q8dXc3O6Ylzpb6b9A6XRK/9DK+PPaNhJu6iblSilfDtq0XKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSnIYX62; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSnIYX62"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a1bf69a3a5so1073430eaf.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096422; x=1710701222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJhceFjtT9Km7ojna7zOap76xqTPIXL1ycKUvSghO7w=;
        b=VSnIYX62G8Qryu1eIsDjy3jp473J/l6Mbdlvg0+58wvg9m3hH6BBd9jjybYniQTO+r
         lpD5AuQ7VBEBT0YwX6NLFkoBXtAXeU1DyzpTKwW1KYemNZgj5Vzyxn3XHyUkoulLB5dJ
         yRHhb9s34tBxuR/2Dm7yOGW+uUL/Nhnx4lWSm4wTEn6QVM5flyNIGXNE5dMv/T/il4kn
         9EtPiNAPLi+4I0KBNsjGEYz1cC5I/qa01cEWMm/Br/oowvfCzfBKoqYrrBr1WChYi2Oi
         vFj/D0BhYUZ/W3RzED4gcJ27UcDrLQbIulDZZtlPUYkMt4N1BxkwhcFwZHKBtqCQfOHl
         lUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096422; x=1710701222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJhceFjtT9Km7ojna7zOap76xqTPIXL1ycKUvSghO7w=;
        b=n38p14lDRmI00evThd6KWmVExHULYowgMxvmJcAgSRTIPa2Av5bDP5bDaiQq2706ih
         WbYz7EFncdXgDWEOH8seMKNxmHtLWD9v4cXX/Ozp5cnrZjBtEkKc3DmSJTrK055wtT4M
         ipxOFBuN1TZPd4BIH+14BvJNRDnMzqn9uNmZk/JFGeG6YC8H/ejvyAwthsqxfosTAb3f
         B3pcYpCMayeRHiakEac5bHKal+2dLNaQIRdZzFouRCn55rerwwi3izSUL3rDXcRpDuEG
         0wrgaTVwzShA/z49v7oxVBvVDv8K/NR2CCq/LspCTaxu6BVHVbJdGpXqCpGPGS+cVR8e
         iSMw==
X-Gm-Message-State: AOJu0YwjteOXjKR/Xq3CNzgja67fdY2V91bxc1ijcqLvfXnAxiyRFU5D
	D14vu9pYkRekze0RxxDqYqtqyhH1rDfkRj4CEhM61ZWJI9EPBbvPueWD5JPBSIo=
X-Google-Smtp-Source: AGHT+IHZ88xkJVUVveXWJwP3NBUQ2LdMb1FQiyW/90p1YJru9ujYErHPZLcI7XyuffZlspCT3maZNw==
X-Received: by 2002:a05:6830:f8b:b0:6e5:24f5:32fa with SMTP id ez11-20020a0568300f8b00b006e524f532famr3254057otb.15.1710096422536;
        Sun, 10 Mar 2024 11:47:02 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:47:01 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 6/7] cherry-pick: enforce `--keep-redundant-commits` incompatibility
Date: Sun, 10 Mar 2024 13:42:05 -0500
Message-ID: <20240310184602.539656-7-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `--keep-redundant-commits` was added in  b27cfb0d8d
(git-cherry-pick: Add keep-redundant-commits option, 2012-04-20), it was
not marked as incompatible with the various operations needed to
continue or exit a cherry-pick (`--continue`, `--skip`, `--abort`, and
`--quit`).

Enforce this incompatibility via `verify_opt_compatible` like we do for
the other various options.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Differences from v2:

- New tests are added to t3505-cherry-pick-empty.sh instead of a new
  test file

 builtin/revert.c             |  1 +
 t/t3505-cherry-pick-empty.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 89821bab95..a1936ef70e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,6 +167,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--ff", opts->allow_ff,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+				"--keep-redundant-commits", opts->keep_redundant_commits,
 				NULL);
 	}

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index eba3c38d5a..61f91aaa0a 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -99,4 +99,18 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	test_cmp expect actual
 '

+test_expect_success '--keep-redundant-commits is incompatible with operations' '
+	test_must_fail git cherry-pick HEAD 2>output &&
+	test_grep "The previous cherry-pick is now empty" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --continue 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --continue" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --skip 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --skip" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --abort 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --abort" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --quit 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --quit" output &&
+	git cherry-pick --abort
+'
+
 test_done
-- 
2.43.0

