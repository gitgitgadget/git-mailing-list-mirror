Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1C30F52B
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693745; cv=none; b=L5CEtbVhFH3tzSUu6WoXykJEktmIMKRD17/NLfjGziGbJAldFR85ZNTvZYKP055+RlVDVA1OEIadDWs2DbdwPGtZ/5ZJ9f3VtnNI5H0nf8k7NDLUD1ImKfjhNEcciQgA7Q/gk6di1WCa5i48QXqSU4gaPZFHtqxnekKBVPiS4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693745; c=relaxed/simple;
	bh=Q0d/Ef20dtkIcmHwRxMxOenO8jPGAB86/tXyNZ1E4aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dDscP5O7CfVN2F2OhaCLG9lDKx5kkvxS0MTlF+4RjkzCHZujMQOhxPr8LhC0wzRJwtVE6vTFcHV3qi/dJaeSA5uT7nm97l5Hc97VsW6pQTqYzRbcZk9rGDC0acOpcMNHR/poXovRTwIKy0ggDx8bcei2VRrHDNy5iRH1G7DZNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLQH4uAG; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLQH4uAG"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1273349c56bso9439366c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693743; x=1773298543; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=XLQH4uAGQSNelahe8+EsVwM5q1RHxesfMWrhuJ8rrvTQi6vBMOm7a+daYtuTTgY/L5
         Glo0QhjuYnP8aU6QVoUlEY1WKX3xcbD6cbdBCGVqJv/MDuwNnU+exm83yeSmb5Umzy5g
         iqbHSXO+hbcGjSC0GPuM/wAORGFzaydLy76pIuQJLyKmg1FkjrVEd8zUY5X5SZoiwdeB
         JyQEgR6BW2PPuPL6VJwvo8/6xebQ/KkyXFJAs1fdgXb2zim8WnP1MawUoaYrkgOR52K0
         eopdc4spVNzzvZYobKE/aCwFvta0Ot5QS8iXDK0N/3tPt5KJn58umg8YddVwhTQrRAEC
         I+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693743; x=1773298543;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=j0+peRaw1e6LiYYYBdcG4jNYY3trWwA+thusgAECdgXvHOGGczmVCAk92VkjbWOPoN
         dzACEWSnNLmavCoJj0jpqh5xtOgRDBbwkYPILr+S6AauUNV0awG8ZsNUSic5n065zBo+
         L7j9rzsy/zPgS3rAL7sLZmetqnSxtmOlOtuXrXI8kY2Az8ykWJ3rFkXO+BxWKcgS/QAv
         GnnDn4zP7pTqC6eTSdRTzf+Fvgvns42RZegweVcHBwUYjSWK54O2n8fwRNONU1OvbkxB
         GmiZ4hgB4NdCHG80VnEpLDhCUBw53lRRzPecwNN1ZlOuD7J/verdAFFx6783F80ffjJv
         EXAQ==
X-Gm-Message-State: AOJu0YwKGjVq2U0uvdLCXBWQqmtF07QvUmXUSs1erVHaDhIE5C/QXW/m
	HmoxMdnR96PaRzAKvYCBIBTxDNTm/gVM3p2lm3Ke9BzhDJVls+6HSlMb3Qb5Tg==
X-Gm-Gg: ATEYQzx5Jvw9J9z6GDo9Suig/Lq3BV/yA1w5mSrG1kV3fTYuWWEf8o0/57JlArOZzpY
	tjvAidVh47EbLWwtA9AGuwUhzfxq45w0Rfa/+LjceFv/RTy8W5igHRPwaSDO+Ugl9/sLJGpG1hM
	yoI4/tmFDd/jAlhop2eUpCa4j/INZrq6qqPJNYrA7uvt6HkltZQOvGTKb7utQRZahsEMw2nAWlA
	rSz5aTmOlTdBTdzpHzKsuZmGQZ2Jt5nSA5eckW6Nyq9ZRptxhikdGW62US1SvxXVXlQBit72mwM
	sU96SVf/O2oZp34RN0bnovzhp6gdKD0pnh0H1SmAe9bfvByyUEzA5MtbBGY6eGjDX20t7OJSzYE
	kFo7aNYIh4viNZMRiE4gpIGLN/515TxOclCBP7ebZxXqLNCKnYV5G2+FmOKXoac/6psoP5uoUPy
	uYCPX95rF4NQIHpJPEq/jMXOrfqw==
X-Received: by 2002:a05:7022:124:b0:124:11af:7b42 with SMTP id a92af1059eb24-128b70e189fmr2169714c88.33.1772693742512;
        Wed, 04 Mar 2026 22:55:42 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279e9950cesm13243541c88.7.2026.03.04.22.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:40 -0800 (PST)
Message-Id: <8fa6a74e0df89452b25f8755fcd3290fcd8f1e2d.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:12 +0000
Subject: [PATCH v11 12/12] fsmonitor: convert shown khash to strset in
 do_handle_client
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Replace the khash-based string set used for deduplicating pathnames
in do_handle_client() with a strset, which provides a cleaner
interface for the same purpose.

Since the paths are interned strings from the batch data, use
strdup_strings=0 to avoid unnecessary copies.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 53d8ad1f0d..f920cf3a82 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -16,7 +16,7 @@
 #include "fsmonitor--daemon.h"
 
 #include "simple-ipc.h"
-#include "khash.h"
+#include "strmap.h"
 #include "run-command.h"
 #include "trace.h"
 #include "trace2.h"
@@ -674,8 +674,6 @@ static int fsmonitor_parse_client_token(const char *buf_token,
 	return 0;
 }
 
-KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal)
-
 static int do_handle_client(struct fsmonitor_daemon_state *state,
 			    const char *command,
 			    ipc_server_reply_cb *reply,
@@ -692,8 +690,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown = NULL;
-	int hash_ret;
+	struct strset shown = STRSET_INIT;
 	int do_trivial = 0;
 	int do_flush = 0;
 	int do_cookie = 0;
@@ -882,14 +879,14 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	 * so walk the batch list backwards from the current head back
 	 * to the batch (sequence number) they named.
 	 *
-	 * We use khash to de-dup the list of pathnames.
+	 * We use a strset to de-dup the list of pathnames.
 	 *
 	 * NEEDSWORK: each batch contains a list of interned strings,
 	 * so we only need to do pointer comparisons here to build the
 	 * hash table.  Currently, we're still comparing the string
 	 * values.
 	 */
-	shown = kh_init_str();
+	strset_init_with_options(&shown, NULL, 0);
 	for (batch = batch_head;
 	     batch && batch->batch_seq_nr > requested_oldest_seq_nr;
 	     batch = batch->next) {
@@ -899,11 +896,9 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			const char *s = batch->interned_paths[k];
 			size_t s_len;
 
-			if (kh_get_str(shown, s) != kh_end(shown))
+			if (!strset_add(&shown, s))
 				duplicates++;
 			else {
-				kh_put_str(shown, s, &hash_ret);
-
 				trace_printf_key(&trace_fsmonitor,
 						 "send[%"PRIuMAX"]: %s",
 						 count, s);
@@ -973,7 +968,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
-	kh_destroy_str(shown);
+	strset_clear(&shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);
-- 
gitgitgadget
