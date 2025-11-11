Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89833AD84
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867637; cv=none; b=gJuCrRjl9Qiny6gRVFCKywp5REg214M5f12ucBENIgw2VMbcik4u3WdzkuYc5BlkGIFRBqm6U1qlI4GC1ojPrjlhC9Jy4Hn+JUqgaJBoaXLkNTSM9Gb8aUC7Vb5bpXmxj/jaOqLSuEk1rSocXnaM1z5rclYyOBV8SKofrFutcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867637; c=relaxed/simple;
	bh=73pB4oYNgQRJDLgnruHtbeR4aJnx5waP+FfEgyXlB6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdSWIK1wLOD/4IncvSWYLMoHAwaJgyolCpXlF/eaefoTa5OcmyzXAtkRBSNONmnTUmCb/0+tyCkSpjh14jG57LUEoD1AXbaqfNQ05vChzCexV5/Ntl55Kf8enykl1f6Ny/lX+xCqMSSl3fhWjGOTcpDMXOSgaEdQ+IV4WSfA23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyn/sg/N; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyn/sg/N"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so20114715e9.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762867632; x=1763472432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJb/HZWVW/hYmSfvuzQydonUHHMGA4T2ZCj+rvcNBPo=;
        b=Gyn/sg/NmasL4FnleXoETPSEMVRTNiHEhchlRpCFTAy/dsOUxRs+c/X+bFJPMk0PGI
         h8eTQuBL3lVLZ9ZGfcxBOsyLX/A3ITIcl0iP1FKUL4wk7mc9cZmxdD7THfGH68a9L23W
         nCxJJSqaH1kPhAADRy+8SJGNpmmrD41RgbuHk/ek+CPGw2H5vBrllqL4o8ZjLRA5gB88
         7NTxMmeBhqIECbsnDsrEt28pOAoErrUk1Jyj5FDbiagBsAOCl7YLLUcOd+YPR64xbwQY
         sLXnoxvplZ9F4EXdXXBTEy/qkDODJ0GWcRBOZtYTaPLqnjOUMLez4Z6axd2d6j7ht5pD
         21xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867632; x=1763472432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wJb/HZWVW/hYmSfvuzQydonUHHMGA4T2ZCj+rvcNBPo=;
        b=nEvSmKhQiSHNppaR1ND+Anbmi92RM7KGOXzRDDvyNT6N/WGJ8wSYFt1EuM2jJwesZx
         5Gg1X0bFRwSV0FYUuGQyo4D3drlhH419GpUt022T7rNcY25Sv8na/Rryr98mJJ4qkqS/
         pZ09uB+4miShvA9kypoD3Te/6CbbAct03oqGMJukvINVKHl4shJiVEv7NFlc8pLEx+i6
         GnssHPBist+HGALNlX3SMGnmiuxudKkQZV6U5wF1FxzTOMjMQJNYhrr/7qscwZ6+INhC
         wx5NpN01bC630Ps5EXInpzhL8LuFNk6CjRrBtTtali7skTPyAfZxmXNrvpYxujTu2tnK
         NEFA==
X-Gm-Message-State: AOJu0Yy33dU+++C4rl9jeqFhq3v1OdjMUSb3fv0dGxYR5p7HdNZa6+Xn
	Lw2zQdaM4IC4SAQE4jIoLz0+IQ4Wu2RkdFQ+HPIfwxoIe6InqAT3gswq
X-Gm-Gg: ASbGnctLjJFDBqg18ZVbg8IRjKH6aZhBwIpsBTQcymDxWo+T8S3TIw5/qXYj2J8x2ZX
	AZt+PS67+CoskLVgBckhrVMFOnUMLy15+ZG9/q6IDEfc9AOnElVovQSsIDDdBgqX+eOlySMLQ1S
	YAVAQuQ6UfJNC05lyiAXIP4CTF6vIIIPSgIjwBhOmMZw8yQ/dqCio44raaTDtwdLpr1F8Xmozun
	CiWeRPO4m0p9lJ69fdXWwtPuzRIv8tfimSmZuArSEX9jqfeAreyHatyBThW4N4K/7hNnyGUtuMq
	gvmMGJFCUToaCvPzXYqWfbNV8YJHae7kE+506sff0gdswQcgwocKUTsh8AqIP9asnwk+cDFhYGi
	VVq25O2/U8dLR7baRxK2DmaJvnodSxuf71nBa+z6S/zqSavwWkaqlir1uk6zNJigggDVKlzji/I
	ZK
X-Google-Smtp-Source: AGHT+IHuRFWNmWZQmk+yCW19u12ucVT7sLdoW9UfEf/YHJoBUEn+hRnzgB8uH8/FVA7zCdHu951r1w==
X-Received: by 2002:a05:600c:a49:b0:475:dd9a:f786 with SMTP id 5b1f17b1804b1-477732ab2femr112400115e9.40.1762867631873;
        Tue, 11 Nov 2025 05:27:11 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd521fsm300794715e9.6.2025.11.11.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:27:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 11 Nov 2025 14:27:08 +0100
Subject: [PATCH v4 2/2] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-fix-tags-not-fetching-v4-2-185d836ec62a@gmail.com>
References: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
In-Reply-To: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 David Bohman <debohman@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 jltobler@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5227; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=73pB4oYNgQRJDLgnruHtbeR4aJnx5waP+FfEgyXlB6A=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkTOa3PfZROMJK00esDfcOpFsqCVH4eB7mkS
 XGXilTk4JoEwYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpEzmtAAoJED7VnySO
 Rox/E90MAKHpD4/fESau0XVVuIv1ntYHi0lgoRpY/JwvHm398L3TqvBHqlEOyVSqvdGURswUhz2
 8yAc1CX1OQx3X92jCOpbEu6aEixlTPdclTBSJZ2LkGCnzZOilp6TOhetTUflTjVbmRq113pZjxT
 SIcxcpLJmorfaHtErA21RpzWIJXc+rRNkkSO/w5aCSARAzejd76ZHXPcGzr22KevokRLyxw6vCN
 ciUy8nuNPp9NsZqveL6rRw0ofTNIn0Q4loyx0Nel85z7MAOSnpvAtna4LZsSYygXyuPQgSxQ7lG
 Hrjl8y/ISy/JHI1LsruR1mxExYPHi/W5pFt+BJOGrQauLJOOG0ESI9ntinNMw0/rcaonlXj2r+E
 Ay3Ckzs2LSzb7tmVTwIyomjWM4xbFaoWgzeVtx7e090bl6qv+Id1eTSLChKsdfuuVyXGiskL5zC
 7lJmDZ6Det8UEZd3zH166O+qjo+bqXE7SXvYLa6oQMhFnCOr/nwlZZc4997dhJtdmert82Pr4d+
 Gs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
updated the 'git-fetch(1)' command to use batched updates. This batches
updates to gain performance improvements. When fetching references, each
update is added to the transaction. Finally, when committing, individual
updates are allowed to fail with reason, while the transaction itself
succeeds.

One scenario which was missed here, was fetching tags. When fetching
conflicting tags, the `fetch_and_consume_refs()` function returns '1',
which skipped committing the transaction and directly jumped to the
cleanup section. This mean that no updates were applied. This also
extends to backfilling tags which is done when fetching specific
refspecs which contains tags in their history.

Fix this by committing the transaction when we have an error code and
not using an atomic transaction. This ensures other references are
applied even when some updates fail.

The cleanup section is reached with `retcode` set in several scenarios:

   - `truncate_fetch_head()` and `open_fetch_head()` both set `retcode`
     before the transaction is created, so no commit is attempted.

   - `prune_refs()` sets `retcode` after creating the transaction, so
     the commit will now proceed. Before batched updates, `prune_refs()`
     created its own transaction internally with all-or-nothing
     semantics. This was done since all deletions were made without an
     old OID, which meant they were assumed to never fail. This change
     allows partial deletions to succeed, consistent with how other
     reference updates behave during fetch.

   - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
     cases this fix targets, both setting a positive `retcode` to
     trigger the committing of the transaction.

This simplifies error handling and ensures future modifications to
`do_fetch()` don't need special handling for batched updates.

Add tests to check for this regression. While here, add a missing
cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  8 ++++++++
 t/t5510-fetch.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f90179040b..b19fa8e966 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1957,6 +1957,14 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
+	/*
+	 * When using batched updates, we want to commit the non-rejected
+	 * updates and also handle the rejections.
+	 */
+	if (retcode && !atomic_fetch && transaction)
+		commit_ref_transaction(&transaction, false,
+				       transport->remote->name, &err);
+
 	if (retcode) {
 		if (err.len) {
 			error("%s", err.buf);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b7059cccaa..e62190d5d7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 	)
 '
 
+test_expect_success 'fetch --tags fetches existing tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-1 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-1" out &&
+	git -C repo fetch --tags &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-1" out
+'
+
+test_expect_success 'fetch --tags fetches non-conflicting tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+	git -C base tag tag-1 &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-2 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-2" out &&
+
+	git -C base commit --allow-empty -m "second empty-commit" &&
+	git -C base tag -f tag-1 &&
+
+	test_must_fail git -C repo fetch --tags 2>out &&
+	test_grep "tag-1  (would clobber existing tag)" out &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-2" out
+'
+
+test_expect_success "backfill tags when providing a refspec" '
+	git init source &&
+	git -C source commit --allow-empty --message common &&
+	git clone file://"$(pwd)"/source target &&
+	(
+	    cd source &&
+	    git commit --allow-empty --message history &&
+	    git tag history &&
+	    git commit --allow-empty --message fetch-me &&
+	    git tag fetch-me
+	) &&
+
+	# The "history" tag is backfilled eventhough we requested
+	# to only fetch HEAD
+	git -C target fetch origin HEAD:branch &&
+	git -C target tag -l >actual &&
+	cat >expect <<-\EOF &&
+	fetch-me
+	history
+	EOF
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.0

