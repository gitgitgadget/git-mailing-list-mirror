Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB763DEAC7
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648149; cv=none; b=i5zdIF3y8LIr5fI2U+P20hKIrKW6bRXERM1IQiTh8NIITbwm46uPqcBfHNKMyYd6fBBDSOSpDq4nfGwU4+/MEVLUyYxxdEOcjcS/akf8L2348Ze1AJakk/MkR0WGZFBAwXm4JBjd3DA12S8AyT6Tw24saVn8aSFE9Eqa+wn0sEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648149; c=relaxed/simple;
	bh=Q0d/Ef20dtkIcmHwRxMxOenO8jPGAB86/tXyNZ1E4aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Awh26z+eSoeZ1WLpDgSJocqlmmzJnVgZONFDYN1/9t0oc1z8r1/2GfPbX4m5wOTjrY4DStOsMCezTn9k0/9s/3bvHp0/xU7jxsJtBdWMtXzRckJ4NUMRoaBDnjkvlbu6cyrIUqypg/JyNewxiBEF8laWO59ZPThHZ/fajutfhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLGi2Vk5; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLGi2Vk5"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4201180eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648146; x=1773252946; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=HLGi2Vk51g/0eGGpAs/j2T5TV3N7oc0G/7XmO2Yp/ePEq9ueX6m9r77I6Fg57v/B2c
         0i7zeeY0hULqfc1PO/f0n0BFgp7IRsb+m27OoESBsEpQ1MHmZwElyMvkc7N1Xh8XK1EW
         8e2IXiKRLJTn0bqaUYFCjvN3MWq/aUicyhBoc6hhGE6HpaBsX01yITrNwE62AWEC4ELS
         kOo/Xzx9v6wNtiJZCun1/ZmUJM6rB8xDQ7XHmo7KFzLfI8OljpPy9mzDqCwWxk95dHZX
         TrWT/kCLl2dRCWf8HfK47Zw1LAbRS7CqQlBTG7EZjwoLcHvUI2SXtkljRGR5qUHfbJuY
         AoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648146; x=1773252946;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=d8jpEBqmHRyT76Jh+czrVRGHFwRSV97I5qv7iTco/OrYP5YcniQa5LaUuQNordrDr4
         Qi2vAnDPo1k2sVRiRTIj9jn+p0GqFI6iyOJYEzyIuDpjkcXaBzZeIZyCqEm3QPsipFzz
         b7p7Xdh39c4exfrqC2EJUaQK6Hp78ELYr+gB3TEZrq8MrBhqoI9g/+41INNvCaOSIjUj
         kRWzb95RmxHjzSavbUWSaBRsiBgTBf4M4J0LJimlOuuYiodTXPkYx0Gnc+rBOB0HcXWE
         HrB13n3/IT2ZsgB4nc7Yppzc683IRWxZS3B1hc61jjKEfl5bM2eJPNlfCXiHK1qCrEdS
         Lx8w==
X-Gm-Message-State: AOJu0YwSZ8NPcvrAHll3K3arlSRQC7Vf012h1x/zfoD4uq/FsiY4P4Xb
	kcxCYCY5DniuQUPf1hjK4UdhV+yJdNBqcw9pnYfQWIiMjzAk6HAuU0k8lhSHMavJ
X-Gm-Gg: ATEYQzwzKCh05boL3RnbdVgcmUtkTpk+F8u35RfUU27D0/GBu+9LBSakOdSF4sQYOKK
	1yxO8rqZR+3P9CnMDOZ408bLdZ4KZnjp8QaXwfV5b5XEvBMEmgf+C3wf9ynmxDtyuOog/3LitCf
	PE9qxFuNNhisLfo0oigbv0MZEUwg9aO9a1OPOPuJEsVO5mKqFMhLGkulW3pWg2KORU8HF1ZlT+P
	+oykQn9LZIh4sb5mYGjp17tJFZjobVJwpqTFDAXhYBmhCQsBrFg277Ymj9HxX3QIibvJQd1R+Ov
	2kKtNyJml+X53kKneP/RNB/Dudj4VQwmrzIPG2tDUDFTwdkAMwymFsCI+H0p3reWSrJbSU6Y9E6
	FryiLUviF7hZqLxs9CiXCWQ9I0Xk0url5UjogCotQrcrvz+1Ga/7iZZzqXF8JZYRGm0oG/JRLrW
	lRy9rwA8tBHbpIGgX4hzsRI01xMQ==
X-Received: by 2002:a05:7301:9f06:b0:2be:1bd3:a0de with SMTP id 5a478bee46e88-2be3121c128mr1057725eec.19.1772648145710;
        Wed, 04 Mar 2026 10:15:45 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1ce921dasm5031789eec.10.2026.03.04.10.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:45 -0800 (PST)
Message-Id: <6c36c9e11e8d3ab55bb1bb34e3cff8c2fc118011.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:25 +0000
Subject: [PATCH v8 12/12] fsmonitor: convert shown khash to strset in
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
