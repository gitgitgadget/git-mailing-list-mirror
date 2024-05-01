Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE01635D9
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594964; cv=none; b=DM50kMoqcN2f/DK4t6wpgKrz6RfUEPUI8RyhF5vv1MEq+IC/P/xnNzLjZ0B9ExUIRQKEDb+XtEBCoxCiJvKGyqVTdDFRdW8eOQZhP2HNzEe65tbt3PzcAPXRtAnmUZLMdrrXqIovq+pQamEKRJvx5FZONm/BXnZEcC+TOjWQ9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594964; c=relaxed/simple;
	bh=lC37uiZBIXvYQbLcIvGFo3stYfj5MUqrGqfSfT+pdYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldvfZe5RV8YW8ki8ID/dSHiij+SwLH8eTNzpHoHOz8VTKzXLqUjN3PwR4BXlycP/IroUbrjps7BvLqFehYzhYMW5YbYC8s+grLz82Xw2UHY9UXyD+i6tgMEfQcNGhTLmpdyh4WeV9nJr0uizH5a3UIXFGwfWOGhn0YQUILqMEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktRN4JlH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktRN4JlH"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5171a529224so9095363e87.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594961; x=1715199761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDgzCvFcvXMZPfjbwhvs9SkYoMA55687vI/VlkwRO3M=;
        b=ktRN4JlHRWbcCYcycNXAYPnnAIBArWcNkgdFa9iVOxpQMDwwMgeF7QCI/MXI4fhVJO
         t7Mf3OTCgVFmlUte6Xo7eXbtanc5wNfLyBEB+1w+eyOYbFg/woZX9h6c/KGMAXv3yAk9
         p0EM0GlN3wj42NyKj0S0sswx93RmgRgWH35yay8r9VXfAzx4OTd5vkS23C8uhqOw4OEI
         K+ZEfrh38Vt7wlC8XL68W269OsvqALJWomJJY4s+tvWk+SmUzkkNfYWBR4wsF/M3LIfI
         6E+h2yUp/lc278epVP0NdRq4Hqe4IMiRrEgmCBdfkmzcICZ+DVrABqDTACYvzdx9mJak
         HSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594961; x=1715199761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDgzCvFcvXMZPfjbwhvs9SkYoMA55687vI/VlkwRO3M=;
        b=J9zHwxrsoj9NnH3cNs2CpN5s8xabasMNEadsf1hMpuiFLnahI2zRnTxzvheke9oU2n
         GPzpQ6rskZBSU4ruzdxZ67DKQPcHbqWHgi0FuX99k5l6IYwCw6AMdESeKxw9OsDDLYbN
         LQZU4K1scGcGUZbRxbNpRFqIRz6nuQV8pdoULkhMZgZPFeP4u+iNMon/Qpnhfbkc7exl
         kfuZFvmjqs9Wsypdk7HPNMwjhgmf7+7naA98596plCyYUFQwxtg/BXHYKC8DfJdqYPb5
         Y7ryyT3FlMnmbAXD8tALkfhpgLrXKPG/yMNwI/3BS6EYQYWKwJwIJA2pNGk43287EJMl
         zNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtGtDYZveVzgQ2O75Ve6kNarWyYDRiAfW7VZZGBMUMnyXbTNSjNk8dOpMpTxLHpL31i7R8sA+Cyaxwyxvrkt2uF740
X-Gm-Message-State: AOJu0Yz2Y3NTofBN7VarVOntXlJ9jsjrqT8WrW5OJ3/xcSoTqZbZuNqn
	eLCKVm5yJOZhm3M6/M4iff3jkFx5oFcbx7IUpraEsBWNbDwhOqfH
X-Google-Smtp-Source: AGHT+IEbMOor0TsywBI1sHkozXOdeN5/vCqvVSGpaDjg1KzdcsczNJjbSwSUybM7C20f8gkCJG6afA==
X-Received: by 2002:a19:ae12:0:b0:51b:812:3c87 with SMTP id f18-20020a19ae12000000b0051b08123c87mr1916808lfc.39.1714594958320;
        Wed, 01 May 2024 13:22:38 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 5/7] refs: use transaction in `refs_create_symref()`
Date: Wed,  1 May 2024 22:22:27 +0200
Message-ID: <20240501202229.2695774-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `refs_create_symref()` function updates a symref to a given new
target. To do this, it uses a ref-backend specific function
`create_symref()`.

In this previous commit, we introduce symref support in transactions.
This means we can now use transactions to perform symref updates and not
have to resort to `create_symref()`. Doing this allows us to remove and
cleanup `create_symref()`, which we will do in the following commit.

Modify the expected error message for a test in
't/t0610-reftable-basics.sh', since the error is now thrown from the
'refs.c'. This is because in transactional updates, F/D conflicts are
caught before we're in the reference backend.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                           | 24 +++++++++++++++++-------
 t/t0610-reftable-basics.sh       |  2 +-
 t/t1416-ref-transaction-hooks.sh | 23 +++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index a4dca08244..1b67c87f47 100644
--- a/refs.c
+++ b/refs.c
@@ -2291,14 +2291,24 @@ int refs_create_symref(struct ref_store *refs,
 		       const char *refs_heads_master,
 		       const char *logmsg)
 {
-	char *msg;
-	int retval;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->create_symref(refs, ref_target, refs_heads_master,
-					 msg);
-	free(msg);
-	return retval;
+	transaction = ref_store_transaction_begin(refs, &err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref_target, NULL, NULL,
+				   refs_heads_master, NULL, REF_NO_DEREF,
+				   logmsg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ret = error("%s", err.buf);
+	}
+
+	strbuf_release(&err);
+	if (transaction)
+		ref_transaction_free(transaction);
+
+	return ret;
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 178791e086..9e8d22bcbd 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -286,7 +286,7 @@ test_expect_success 'ref transaction: creating symbolic ref fails with F/D confl
 	git init repo &&
 	test_commit -C repo A &&
 	cat >expect <<-EOF &&
-	error: unable to write symref for refs/heads: file/directory conflict
+	error: ${SQ}refs/heads/main${SQ} exists; cannot create ${SQ}refs/heads${SQ}
 	EOF
 	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err &&
 	test_cmp expect err
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..4433ac2177 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -134,4 +134,27 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+test_expect_success 'hook captures git-symbolic-ref updates' '
+	test_when_finished "rm actual" &&
+
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		while read -r line
+		do
+			printf "%s\n" "$line"
+		done >>actual
+	EOF
+
+	git symbolic-ref refs/heads/symref refs/heads/main &&
+
+	cat >expect <<-EOF &&
+		prepared
+		$ZERO_OID ref:refs/heads/main refs/heads/symref
+		committed
+		$ZERO_OID ref:refs/heads/main refs/heads/symref
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

