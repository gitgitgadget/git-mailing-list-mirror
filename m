Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A86225791
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671926; cv=none; b=QjFRckLmmUJZpfUxpW/e3rOPhl73LfPn2WyOWylCfah+UyjNt7MDZT/o3QZVNxxZP1dOYSZK9rf3VZ4qswkU3VNJYBoDuc/lfqqk6kuiwursZxXpbFWShH8WA65oA1qc4bCsblOnKpi4KSVHl/BRzFo2TIuDKOjFC++r55sTkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671926; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oQXCzQPWch8pZYoV3Knaugg0L0WNmfJGYkZm3YGLwR46spKoQ7Ogr0uGfXPdHOVN7RfLhKCbfrUwW8MrDmsY1ba5oKtj8uLVXeGjpGTVWHvbTfCgMK907vuoXJKMgruevLC3TdFeCmvI5Jx898+OKbX+dbeRY9/7X7sg57kdZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxccTuvx; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxccTuvx"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8608903eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671924; x=1773276724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=LxccTuvx1+2KY957ey+6q4bzenL/LJULFNncifaSnz05SuIT+5H8w6WoVoPLp+npUk
         0mU+EKCBBDV8Ym+hz66qkbSCZta+FtJKC8kzJcVe0mIlXaiOwI6LslumNSHeCS/2ktey
         PIXQ/0CN03U6SblU4l4XGz+nF1b2GJUuARQTuzw1x79QP92SYCJxIHmpFTYa9l9zvdqB
         Y5k7/u1uT6p5u638QWCHllkArc1wkMzokw6NaV/T2E/RGIHxB/q8P/sL6rJW3baiHgnA
         61umgC03kvy+itGEjsLMTlRAAnXYuBU7l5wdOV1baRJyJP5AP3DweA2Gy+zfLDH86BLN
         nxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671924; x=1773276724;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=xKTfyDNW++F3q0jhTh80PxmgNaQO70zPLjxPoCOX4EttW0+v21ADFotNHKEHsH5GEr
         pCW5Hp0HGl4v1COmtcqMuRh+nIxoQ/way81EZBsVkayEIwqIwq7t6n+4XxctJZdeOF3Y
         PVU9Pkh/LrnyFv7RrhOya2SkvpVGIiG0IjfiCz94Gt6CLmotxCyelILe7qRCeKKvBOPW
         1al6qUPz2L2nxM0XgIuUbIBxe2x/W8F9U9o7WhGT4OCM4yvKMCK3MAwuC4LNRGcU0HF4
         MBRI5gb09eYfTzCme0KbWm32NCSrg8muvxxeTd2lPMpC5nHc6JebXVEXJ1bt4ImKeUk8
         +69A==
X-Gm-Message-State: AOJu0YzhWhardph1L813aGGGwq0TiY+NcUbPp4svKRBnOrIHgjzufYcT
	FlR1OqRVHAovw1t2XAsSYX+yfLSs9K0Ra04nQKSoIJjrvLBI3yJiq88lBnCeEA==
X-Gm-Gg: ATEYQzy1bVHSs/VJg/zrcsT7Q+MzNAlAylNEhbo+lSQMcrAYfKVZzdWxX4F8r1mly/k
	MA0mu1nNowopmb7+lZ37Jj4YDPLOIirQWV5I85iu9mj+c2SLs4Ey7CLN1BPMss9H1AaPZzuuauv
	CAKFE9jqBV9EwbJArcXi04kSHw9a2i75O59IF3NXh8yhKZlgAoyOzFGZWtA7iQehiQ2vrmLBkOH
	L8lYq8hMNU2sbihRT/WcGjDeErQcK1tgioA81hxknvfpF8c7WBOMyJi4cSy5bOM5x6MWW2BNbbo
	mKudmSCqXaBsExTWeELO9/jJF3ez1g3LfBA3LKntMjn9SEwkA3pWcdUKpQdukKYsUzSz8Cciodm
	foj4paXcvbb3RJxn6geL2luML0kSlYOXyToHqhu+6jXAU1rQeaADneXvCvt+WqTfK6uj0s9m5Bt
	TtuE9LMO+cwCrSnESAH7ZHUzVt
X-Received: by 2002:a05:7300:f193:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2be30fc1403mr1300532eec.8.1772671924036;
        Wed, 04 Mar 2026 16:52:04 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be3734fec9sm1550368eec.21.2026.03.04.16.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:03 -0800 (PST)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:49 +0000
Subject: [PATCH v9 01/12] fsmonitor: fix khash memory leak in do_handle_client
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

The `shown` kh_str_t was freed with kh_release_str() at a point in
the code only reachable in the non-trivial response path.  When the
client receives a trivial response, the code jumps to the `cleanup`
label, skipping the kh_release_str() call entirely and leaking the
hash table.

Fix this by initializing `shown` to NULL and moving the cleanup to the
`cleanup` label using kh_destroy_str(), which is safe to call on NULL.
This ensures the hash table is freed regardless of which code path is
taken.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 242c594646..bc4571938c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown;
+	kh_str_t *shown = NULL;
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
@@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		total_response_len += payload.len;
 	}
 
-	kh_release_str(shown);
-
 	pthread_mutex_lock(&state->main_lock);
 
 	if (token_data->client_ref_count > 0)
@@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
+	kh_destroy_str(shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);
-- 
gitgitgadget

