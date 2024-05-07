Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A115ECCE
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086754; cv=none; b=k13vaiKoCK+mLINp276zSmiDi8XksIuOyuJ7KQOTL+su4YN6xc28tNKlFCNEuLivA2RGK8Aq7HHDeymSUTaUvDRG8ymQZ8CQTFyaTpgEAHXucSyIrwVPTQAXUp9DXaTt3TTPkDH+Ua5ACTZ6uRs5xHyocNiT1zNE351zvEb13lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086754; c=relaxed/simple;
	bh=5w3h2rbS6Fo1abqhSfLQHJEFOMlsvrQDrpr+5SPdFII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ucq/sU3582Y/1SOZC2zQC6JkQjU8ehQCEihNFbm5wu4pgcn4OMy45EBCYG+sskN72y4GZSz6mx+r0Jzjj9OILsxz4OyneFoq29DZaqy/fmHMl3C+6pUo1pG8QRTc4iSxjZpc5D6yzrFNg7h3VLY8wZHRY4RIj/nLvn9eAKMgnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TciB1C1E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TciB1C1E"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34ef66c0178so1788711f8f.1
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086751; x=1715691551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT1B7rYzwhAzoD/9cHWGyPtnchR/T78MSC/yWv1nfZ8=;
        b=TciB1C1EoqmhS1kzBOJyx8/27nkeGVMQzkidEaVYXpH8ZOPGiZEEdB1K916YST5H4F
         WkxDljBbuRba5maNa+2UgaMECOcjqu5yJ23ppZU0zamnQpspaueOYtdmX7S7jmynAlX9
         t+UrJV087J5wP7U76MVyilvy74zJ9m0XD3bzUoxAqvO4fJX0D03L8T8twiZczR8qDh7K
         iqydyWn+kE1pzKwvNUMwaiq36WBUk5SNTNrULeH+xnhzRbFQ/w+UNXQdhfEXufAxHfyQ
         YZaXxlE/CLOz5YHP6HxANnC0c+sMWnNr/41JGbFlflM7KHXWxCBDVRYcu2Ju885o5cQe
         uIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086751; x=1715691551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT1B7rYzwhAzoD/9cHWGyPtnchR/T78MSC/yWv1nfZ8=;
        b=kEWK5ABA5FrppHxPgwlCJW/XhLzfA5qciEK33eisn8BcJjrzXQMPFWY7R1q557zYQr
         5J+3x2L7fxNJ87bawS7gktVKTsqUisf2dE6soGjJ7m6qUQbv7hrw7U3RJ14DD7+URI5+
         BDwUohJt/JiZHRF9NgbBFP+70BwdDfhtAgT02vZr9rqG/fevc9dE5PPZYA4EBDn7dBeu
         AOIcn7v6GCsEEY+vAqbwKWFIDVRQd/COIuz7kxvh4A2wyVm/yE4X/iAvYt7oqi51MsEO
         81Ys0sY4s5Qgya6X8jAtB5hR13YBFTqM6gUGPYVdhEww6BfjYo7eOC0y6mbDXTSa6BkP
         RyuQ==
X-Gm-Message-State: AOJu0YyIouXQJzkoMM7YIdnmUjaa7Kwa/A02q6AWSc5GPYUMJrDD/eXf
	vRZzl3I0fmF4SLeZ7/zuuH4zETUgKLH21rvLiqqz9EcAEQ6twS+I
X-Google-Smtp-Source: AGHT+IGGD5Oo5GFLPzBEeVUZKMKQCO4DlAmndp71bVjTEEsh2VzPnRSwl2cDg17umVHVFicp+K5ZTg==
X-Received: by 2002:a5d:6987:0:b0:346:59e9:65b6 with SMTP id g7-20020a5d6987000000b0034659e965b6mr10889071wru.6.1715086750705;
        Tue, 07 May 2024 05:59:10 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 3/8] refs: support symrefs in 'reference-transaction' hook
Date: Tue,  7 May 2024 14:58:54 +0200
Message-ID: <20240507125859.132116-4-knayak@gitlab.com>
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

The 'reference-transaction' hook runs whenever a reference update is
made to the system. In a previous commit, we added the `old_target` and
`new_target` fields to the `reference_transaction_update()`. In
following commits we'll also add the code to handle symref's in the
reference backends.

Support symrefs also in the 'reference-transaction' hook, by modifying
the current format:
    <old-oid> SP <new-oid> SP <ref-name> LF
to be be:
    <old-value> SP <new-value> SP <ref-name> LF
where for regular refs the output would not change and remain the same.
But when either 'old-value' or 'new-value' is a symref, we print the ref
as 'ref:<ref-target>'.

This does break backward compatibility, but the 'reference-transaction'
hook's documentation always stated that support for symbolic references
may be added in the future.

We do not add any tests in this commit since there is no git command
which activates this flow, in an upcoming commit, we'll start using
transaction based symref updates as the default, we'll add tests there
for the hook too.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt | 14 +++++++++-----
 refs.c                     | 20 ++++++++++++++++----
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ee9b92c90d..06e997131b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -486,7 +486,7 @@ reference-transaction
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
 committed or aborted and may thus get called multiple times. The hook
-does not cover symbolic references (but that may change in the future).
+also supports symbolic reference updates.
 
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
+fields could denote references instead of objects. A reference will be
+denoted with a 'ref:' prefix, like `ref:<ref-target>`.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs.c b/refs.c
index e7b7c48d92..9d722d798a 100644
--- a/refs.c
+++ b/refs.c
@@ -2350,10 +2350,22 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 		struct ref_update *update = transaction->updates[i];
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+
+		if (!(update->flags & REF_HAVE_OLD))
+			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
+		else if (update->old_target)
+			strbuf_addf(&buf, "ref:%s ", update->old_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
+
+		if (!(update->flags & REF_HAVE_NEW))
+			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
+		else if (update->new_target)
+			strbuf_addf(&buf, "ref:%s ", update->new_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
+
+		strbuf_addf(&buf, "%s\n", update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
-- 
2.43.GIT

