Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1D22A80D
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671943; cv=none; b=RXLb6AwSwItWcjiDns2gopydWrhLbHeIAQ4Ud+VVL8mJ9fVXXdUBy1BJPs/2YqiydXQ3j657My3BRd4bm4oo2lMxT89AAteNd8vt3VgHkxM4VM1Yswxvh9LQOpaw4wamrWau52U2J1UWQ0c47k/K3nWfkOIavoTkpSeNzxbs+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671943; c=relaxed/simple;
	bh=zWNzExDQDpllDbjXRZO+uHXwmYibKapVL6EwXj9C7IY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VM78KXK/6GhpKN4RH3ZNC2p6UWTDWPxNK64iskonR0NZ8qGDq71GtzVp1X9KWYaxEyxbbE3AhsO9aa8vWQ5bY+11d40J3/vut+L6HG7PVsnI27K5gSGXB9l6rLJO8dp1PwlSNrAQdWQKgn5sUWZodU4VcRqdQUgfoA+oPnrn1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5hHDMt+; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5hHDMt+"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270adc5121so9396596c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671941; x=1773276741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDeiv6howeC2ELq4Mp7JxtU/RGYCudmcQdK6m6JarKg=;
        b=m5hHDMt+0mJ++LFDnXjw5/oC97ghto/itKnaUaFmFxseuVfjNQyQMLY0gdOpLId2/N
         zUQlO2BljygowP1tfyAah08iYupzCZw/ZlE/Cl947v+ApMd113kiuPQIBvtVLpDpKIwN
         h27JjssdBAeLn6YtvQuX//kYOyxqbnrU6cEa2JeI87R8USINK3OI/YbHQhU6/g/KVi3J
         NTTaEFLquA0JQKejPh3Tp2PEKKCzydqf7jsLiYItODUTBxn3/wQeSc5WNwho/Bp5lY5s
         rTMNHJ9lGlng+oxrNJWU71RhoJDQdbdvbwzAC0AYX6+CRl1+RdN43JMBkTVP+hH22cm5
         +LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671941; x=1773276741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDeiv6howeC2ELq4Mp7JxtU/RGYCudmcQdK6m6JarKg=;
        b=LPOch2Xfb29pR+ethfwTWa5v7gKXjwmdXVnHPtM0OB8gPz6fsd2+I6U/xDyKIdOwzm
         4H27mZW/EG/YQDNVuGKxVs5Ox5LDPqxcG5N+gLcfQxHOxytRXtT9BIYxnZ4MGE0Rav4D
         XWilr9TWolArdrpJXlVtp8oqbwTDrlLliay8pxtZZUXQTRD2ydCBo3SIIuGhBs5kfPov
         RCc0yvL4lyruCVhAWQjUmsMXKvVQaIc87ReyJmWyw/JCu9FmpZHQJeZeonSoTKBvV8m4
         uR9Q6505fQk9Jb3qlZbQu6Jqm11SGJiWEnIhI00TsmmnFwJWAMWsbZnq00/6e2URFepJ
         w0yw==
X-Gm-Message-State: AOJu0Yzy5AEiaPr//Jazz74IFpJHVMtHeT+UBP2LmEh5LGphdNSEbPHH
	7ko1a/Ko/2UrZiOsCS/F9lJIFrad3o6h1+m/09xlT13UwKGKfd48lNOLqatrxA==
X-Gm-Gg: ATEYQzz1DQh03LhaN12iD3Mtz8gZ9nPtkyNYceCe1OejYY4ocn+AmXPLKzvD1nX2s28
	bykU3PLBFHyPunK0Mww1XLilnT6uwzCZfO6raNuDYUwly8VXBxPSSO/JVWVW9/d+BO4Cnln0zJX
	WtVaYOR9qJnDYbxeJ3N6maXziDg5dTGahuD3Lmg5FpQl3d3yNcC44ejkROAZnYy4NhZ2zJmo/On
	mkjSjoKmRL+Bvw4DaR9I4HBUjjA7K0LwrqhJF6Mq/ZLuBukuw6Ja5U6lyp9YklAQWwRSYgLtx2Z
	EiGtBfjVhbym/SlH0/Nmb/UZ7JeMr892apJkyWZC6rr9/EH8rK3SceEJ9pb11sGLL5KAkM9/xJd
	lMefpbW5MNbUhF3RKWTJ1h6p9E2zR57Ywc6DmGMMHSDCbT8IfxoSHH49kZ6wxjLYmdecGT1Tknu
	dySDXeNPl5p0fzRDfl+3ldEnt+
X-Received: by 2002:a05:7022:618:b0:123:2d9d:a90d with SMTP id a92af1059eb24-128b70ab137mr1498232c88.17.1772671940794;
        Wed, 04 Mar 2026 16:52:20 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm23830566c88.6.2026.03.04.16.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:20 -0800 (PST)
Message-Id: <e603fc7ddeff63705da093fde0dc3687219b1ffc.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:52:00 +0000
Subject: [PATCH v9 12/12] fsmonitor: convert shown khash to strset in
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
index 299de2e4e2..b4b2a304e5 100644
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
