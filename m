Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281015EFB6
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086757; cv=none; b=f8S4LU1NPF0ak7rgakPgVbSMFluhEaSpWyrgN+I1DkO4r53Jq5Pfv9zeBFKUi2ZpDrz4JHBG0nE9N15iuzYs2YXAYW58USKe8vr+M7Ve/st9bey3lMb3e7wufXr9YrEg6oPJqF9Wu+6VFrA8+EYolMtqC8zbSOJlHFoe3gZcLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086757; c=relaxed/simple;
	bh=TFHcxmTJBGuqtrikEMG5jv8y9m6q834JRzFtvxAY31E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVX/9IuAAlGnAjI7p5G2Ba2JWiSxr69pLBy4dJ0qp4NEISWAnRqwUqyVkXiEypUa3v/RC9NDHbFg0kxgnkUnxHWO1CPQRkZKDgWPZgAwGebuRTUaMnmXR/+XTX/KQ7rlTWYTbK7248Y81BLKlwUUexd9coHFU+yDgiY2yXDsd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VemSBgZM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VemSBgZM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34f0e55787aso1629463f8f.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086754; x=1715691554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EFfwVpZAeNXWeG4gAOc5Zr3xIjZTHISNvyygwVmFSA=;
        b=VemSBgZMRl0ECotnYgXb/ebwi5XO9OMhhl0ZoiyTLBxAw/zUCV2FfZpV5tJ0oZwMk5
         +WPAEcZPmLmStMGoTD/hu2C4Jbc/zJ4H4ZAoeRLB0BatTuAu2GPHk+XhCxzDoc5wQTxX
         IUbKFF3mkTNJ6ki9jj7+V+p3yELUDlByypNWPZeWhDu20CEoXUorY1p2EVZQvS0HrqO9
         wE8o6iw0kAR/PCXJx83MLDeSgi6RLJ0vJvwHq3tJnciHbjM0o67JwQHLpZ8LEueftUXB
         Tv9p2bCTsedkfX1t39UTX8gjL7V/Rxn0jxmTJlCP5Z+8iyWYX/hEA2BKlp4akWdOuS33
         2eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086754; x=1715691554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EFfwVpZAeNXWeG4gAOc5Zr3xIjZTHISNvyygwVmFSA=;
        b=uipBFZlTilVf4Kk02HPyw16BSyrXqKBYw23VLyPKwePSxDs633gGa/+aD31UxG/3Pj
         q6igBVHJ50x5kImtZF+i/SbeL1p4ABLRX7jgVLavxgGSTv95Ef41zEKLcUH99yv7i0cC
         rsPFuKk+0K7SFhkgzyY1y8Nt2XZSZgFc95q1ybpK6p7FZJdMFAzy0ODMN3sagxXKkdpa
         Hu8do+bMkI8NoU0Ld393UXbUHckN9rTb4YGhCWbwDWOCHuj6JHvXnMEpy0MkivjnTVbe
         BWhlQCn35sQyVgnG2vXtygMw+MtKtGtNTNNKWi0UUZVD95Xe0giHn9GPvgZQ6HbS5+Iv
         q41A==
X-Gm-Message-State: AOJu0Yx7n91Md8+geKOK4diFSmnWR63XtduKD1xdt23FuXldO9PcP1UH
	q6wNLsYOdKrVUE4BvnCa01ypILhnDHqVcdHy9c8JaaumgMPs25Eask/jbQ==
X-Google-Smtp-Source: AGHT+IGITzg0krN7uIXc8TzWGaFOUplNrmDPn2AQ9/5hwnZgNf9wyj63zNy2WEiJ0Im1BmVA0lAm3Q==
X-Received: by 2002:a5d:4489:0:b0:34f:3567:cb4c with SMTP id j9-20020a5d4489000000b0034f3567cb4cmr4112977wrq.43.1715086754515;
        Tue, 07 May 2024 05:59:14 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 6/8] refs: use transaction in `refs_create_symref()`
Date: Tue,  7 May 2024 14:58:57 +0200
Message-ID: <20240507125859.132116-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
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

In the previous commits, we introduced symref support in transactions.
This means we can now use transactions to perform symref updates and
don't have to resort to `create_symref()`. Doing this allows us to
remove and cleanup `create_symref()`, which we will do in the following
commit.

Modify the expected error message for a test in
't/t0610-reftable-basics.sh', since the error is now thrown from
'refs.c'. This is because in transactional updates, F/D conflicts are
caught before we're in the reference backend.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                           | 24 +++++++++++++++++-------
 t/t0610-reftable-basics.sh       |  2 +-
 t/t1416-ref-transaction-hooks.sh | 23 +++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index d0ea7573d8..507f5f0525 100644
--- a/refs.c
+++ b/refs.c
@@ -2289,14 +2289,24 @@ int refs_create_symref(struct ref_store *refs,
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
index 2092488090..067fd57290 100755
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
+	prepared
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
+	committed
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

