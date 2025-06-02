Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFE1F12FC
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858264; cv=none; b=DPuXx4yZwBectx5bd4T6RIJwpJv2b6JnbLmtFX0Ri6GtZjI5SC4J7yk5KvEw8GdbeW2ETFRzbkHHOjEX8zxRuYzHv6NMn3Kr9G/Tj0S2307cYTnx3Vn//Tmqo+m2GxN14x1s2AUtiDah6kb/ob3N57/dFK7aieIXFK/YZ465q6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858264; c=relaxed/simple;
	bh=jzrannj2RNRcSCy3SCb0uRSfdvr2tSO8Hzd1++6OVBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CF3T0a3DvBs+aMRPsu0PEHGiF0Vxtt6tFAypiFoKT+pJeWcUaA779IkJTarBSfWWueA0IbXbuDYMkyHXt/lNl458sXDTbqmTJdXeH71OyHIGOMaRkOUrnZVnuvNhUosxSlkxwkHTpmFUYQSRlcH3SWAeYwxsu8PljGyZILSTP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLrby/Fh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLrby/Fh"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad56829fabdso665121966b.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858260; x=1749463060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJL+7Lr7beO5nuHfel2QfbnTrbLNhefwuEYVavdYK5M=;
        b=CLrby/FhIuLSOVmKxy9M6Mh2t2sHpb4RO4k/bijDH5H5kBaWNhl+8kSvI1QpPEqOY0
         865r7HV+sQr4J/1g6a7Xeswk96qWhbaVrbht1IjJGoFEdXlHxejFVIuqVyEE+w2iyuO8
         cP9uYHD6zVdTrLSufhPpoewz2EsZtwz+9khzKNMIzt/q/d9CvRGOtjs8t25xffgXRdR7
         9fnz8/cPhzS8p2ZjW3Mf4fVhoQDVpBmM3Ti75nC/NqTCxXEGU2KfY920eDUQgniKB8tl
         ng5QlekI4Wt29AlzNZsb4mD6bJDuQeRYW5EplF1lrDwJZYrO2n396oKlKFSMwxVyjqkZ
         4qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858260; x=1749463060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJL+7Lr7beO5nuHfel2QfbnTrbLNhefwuEYVavdYK5M=;
        b=H0KnXTKeCARIj1u+qpI8/LcV55LnQbX/5mpRvKMWR+YItnhiPtc4nfB+O7sGHTgoFz
         9D8U5TvQIsL2uwPJD1rpUoJXYIvHMmHnJHj1nFTlZI+LSUmQY7++4RzJs2iJ4NjAXmh+
         4+5XHuUKqtq6XbuId61eRanvmRjw9zaZ+BwRQvgbjnQsNvmoByv/3cQE87fKpmiTcEhf
         sHveksE8kbRI4yjb8caclaq3Q3FQML0tn54zxKJh9XdSdICpwCDG/BRqzJnB6xYvwbg6
         JUSWgsgew7EFmrTecJUAoGo+oet7/zMZ0tZtYIGE7GECIhsdJcoWNZKwkyFArqr/PfxL
         VL9g==
X-Gm-Message-State: AOJu0YwiazeFBE7Fb3wDICUHxhrk0ifR+b9/sC8W/+8qyvT4WFokIiqR
	wHFSP0VtvtrXHBP7e63oMdqr5egUQr2vUy3qko8WIruITiS2QIJ44WwX
X-Gm-Gg: ASbGnctuLNVEkiiJbfZGHxdrNIGjRSdXDRTfgqsHxZc8DOfsZHb8FmvcQFdbW1/t+zj
	IJAnqi/pAjb0IWlo/t8YY8OgSkv41EaP2MeZK0lFLxrOKV41I4Kmp1nN3JryQxboGPYGP6MXNyr
	Ik33v/OiKEpD/WoU2CSOvW+eStfp/0fcaL/Iu5tzHYNmJgYCRxKIbMAaYoTzW4bTfvO730cY+UK
	NQUAM/bDWIQ1Q9l34CHWQvJkaPhudqi37BPx1kAH2daw/VWA+jBbX1SAbZmjcxl7YAsuEtkZxRj
	ObBlqJlp4072biDZynEvuWcrkmI6YzVVVvw=
X-Google-Smtp-Source: AGHT+IEIVFY8rT2QvodtWQ/yGMTMKSn097rX5koHA0kTxV7ojdVEklkwt2XBWhqBd3DOpgbYQ7wUCw==
X-Received: by 2002:a17:907:944d:b0:ad2:1cd7:cefc with SMTP id a640c23a62f3a-adb493de4fdmr736911466b.13.1748858260298;
        Mon, 02 Jun 2025 02:57:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:760e:bd06:5a20:3b6a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab2csm759665966b.184.2025.06.02.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:57:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Jun 2025 11:57:26 +0200
Subject: [PATCH 3/3] receive-pack: handle reference deletions separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5501; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jzrannj2RNRcSCy3SCb0uRSfdvr2tSO8Hzd1++6OVBc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGg9dZAFMmH69D4j+e9DeTt8i8KMhXWFcirLl
 je5w2L938gJOIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoPXWQAAoJED7VnySO
 Rox/vJ0L/2sejwxKKzYPUMUcXEeISzH332D+z6YsL2p3e4uRO6f0tBcRw6to/hT0RFBAK8xYgPu
 EeUrDKXBnDef+xgYWgg/aJiWa/wcNvajOfn09g+PgkfZHEMCIwbQrdebxNGBSf3m0/yFBMPGkz0
 C7ndq0mGMEXveiTKwpOZwKqaxboH+z8YTvNPtFgIvEFCYrtSys5KmoiLR3wJaHSiYWmN6V0Ak7n
 Y/rC7YuzAaJVEzz2WGnZG854xgj1mjXmv4E1yMiGiL7qyWpkMQDpjrmPXIvDPzeOHRUgxlF+b1Y
 cNYILUph8Vl5buff9Wx5wtcUAroA36QVKKs2NfSUoNxGJWnDpJtfS2lF1ejCazZX8kaMl4EN6/w
 GX26ac3FAOYSKHPwcDS6XEDuzmKDNV2zAm8V7DLBQgENTtbdcOmnfZnXbR6D6Y/Dvnb4v+rhTb3
 fpoWSIeTXwUoV3qQDpB2/d+pdwFwVH1MVd7S97MtRTurWwTL4a1XltNh9Iq+wGLgbHiqRh8CO96
 Do=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
we updated the 'git-receive-pack(1)' command to use batched reference
updates. One edge case which was missed during this implementation was
when a user pushes multiple branches such as:

  delete refs/heads/branch/conflict
  create refs/heads/branch

Before using batched updates, the references would be applied
sequentially and hence no conflicts would arise. With batched updates,
while the first update applies, the second fails due to F/D conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by using
separating out reference pruning into a separate transaction. Apply a
similar mechanism for 'git-receive-pack(1)' and separate out reference
deletions into its own batch.

Add a test to validate this behavior.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c           | 23 +++++++++++++++++++----
 t/t1416-ref-transaction-hooks.sh |  2 ++
 t/t5516-fetch-push.sh            | 17 +++++++++++++----
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9e3cfb85cf..7157ced2a6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1860,7 +1860,8 @@ static void ref_transaction_rejection_handler(const char *refname,
 }
 
 static void execute_commands_non_atomic(struct command *commands,
-					struct shallow_info *si)
+					struct shallow_info *si,
+					int only_deletions)
 {
 	struct command *cmd;
 	struct strbuf err = STRBUF_INIT;
@@ -1879,6 +1880,8 @@ static void execute_commands_non_atomic(struct command *commands,
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
+		if (only_deletions ^ is_null_oid(&cmd->new_oid))
+			continue;
 
 		cmd->error_string = update(cmd, si);
 	}
@@ -2024,6 +2027,9 @@ static void execute_commands(struct command *commands,
 	/*
 	 * If there is no command ready to run, should return directly to destroy
 	 * temporary data in the quarantine area.
+	 *
+	 * Check if any reference deletions exist, these are batched together in
+	 * a separate transaction to avoid F/D conflicts with other updates.
 	 */
 	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
 		; /* nothing */
@@ -2058,10 +2064,19 @@ static void execute_commands(struct command *commands,
 			    (cmd->run_proc_receive || use_atomic))
 				cmd->error_string = "fail to run proc-receive hook";
 
-	if (use_atomic)
+	if (use_atomic) {
 		execute_commands_atomic(commands, si);
-	else
-		execute_commands_non_atomic(commands, si);
+	} else {
+		/*
+		 * Reference updates, where F/D conflicts shouldn't arise due to
+		 * one reference being deleted, while the other being created
+		 * are treated as conflicts in batched updates. This is because
+		 * we don't do conflict resolution inside a transaction. To
+		 * mitigate this, delete references in a separate batch.
+		 */
+		execute_commands_non_atomic(commands, si, 1);
+		execute_commands_non_atomic(commands, si, 0);
+	}
 
 	if (shallow_update)
 		BUG_if_skipped_connectivity_check(commands, si);
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d91dd3a3b5..b2aaa1908f 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -119,6 +119,8 @@ test_expect_success 'interleaving hook calls succeed' '
 	EOF
 
 	cat >expect <<-EOF &&
+		hooks/reference-transaction prepared
+		hooks/reference-transaction committed
 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
 		hooks/reference-transaction prepared
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 029ef92d58..34eb3a5a07 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
+		refs/heads/main $orgmain $newmain
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -808,8 +808,8 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
+		refs/heads/main $orgmain $newmain
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -868,10 +868,10 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
-		refs/heads/seen $orgseen $newseen
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
+		refs/heads/main $orgmain $newmain
+		refs/heads/seen $orgseen $newseen
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -1909,4 +1909,13 @@ test_expect_success 'push with config push.useBitmaps' '
 		--thin --delta-base-offset -q --no-use-bitmap-index <false
 '
 
+test_expect_success 'push with F/D conflict with deletion and creation' '
+	test_when_finished "git branch -D branch" &&
+	git branch branch/conflict &&
+	mk_test testrepo heads/branch/conflict &&
+	git branch -D branch/conflict &&
+	git branch branch &&
+	git push testrepo :refs/heads/branch/conflict refs/heads/branch
+'
+
 test_done

-- 
2.49.0

