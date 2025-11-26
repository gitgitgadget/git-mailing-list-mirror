Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60632938A
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160240; cv=none; b=ZkwiIX22vw5a+28AwwveMLXnBJhiBbOJmL20K8IqCfjYRarfH/DKj9EfTzckledd4y1NB//jRN+6Mni9BQ5R8qn82WVUQbpuwGh2NjJYUP4M0J/HunDYCCYfKlUvHHLvS5qzE2+0pwCWqDezv/WaPhXOf/h/NNbQBYsQsJ6l884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160240; c=relaxed/simple;
	bh=HwK8eK75hCWjVV8B+uxSwXBq84clzv/rzQL91TNxCMo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MUwlUJbTw++y6zGDbWA4DOgk59K+IcQoWlyZWENWbRG9xqGSMGwDfaH2Je427TpsIpHAi/EIofskUsrxTSayQUFRDw2bU/Nxgrnz5+KztSiXbKaPl7FxqvtupMN14cU2nz78dOff4Z/47ULEHfP4nlu5Tz2dLMpkLDPMK124sMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAIC6rYs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAIC6rYs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae0acso104265555ad.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160237; x=1764765037; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIgdZBUA/eWakJJmihvSYER8RurhuMloewbqipIn/NU=;
        b=PAIC6rYs2DMXdTBnkAkV2+rYxNiMkmr0atFcNWDr4B6LZnFoWVeW1GJoZ85y0dLTH3
         o0nZKoJGVsT7EKxfMDgzNLrca+5AZzvyISGwn37teXI7X15M7LdxkugoKKzobJ3n41n4
         JYeUhYF3eN3969zKBmyzoaoO51NSQZBV6EH0A9Fj6lSKo7LSqTIq4C5iaMnJrWmTBzXX
         XoIMTQVONKUPpjQewbRTuOA9CFSCob0ey1Y9rYKaumirvmcKW/lVrSN3r5bXmpZQKHr3
         h1HG1tfP27xK2dSRYYQEgg089jNXS+VMrbCrEFu4Qlumjmkm/VlJdmaynsvFGtLoxD2S
         q2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160237; x=1764765037;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIgdZBUA/eWakJJmihvSYER8RurhuMloewbqipIn/NU=;
        b=Y893KyiYkQKc2FX58cnNKTPkIzGpUC4b//4+VBw5mDSpFXNZJkSM2Jf1jjWpSMpws9
         7+yKyblw6mgu2cc0A0mmmmuqlvpbyC3s3o1qIfckqs7CauxbFKFCQcjfKokXqdIvlHNt
         7S66I5GpNRVqwuAkd4gWe/Axma9mIt/srY0YI3lpiDC7yzCAd/MdWq/qxhZnXcCfICSI
         VlKXArPp5TNFxh2Wy2+3KLdyYZdDJprPbpd4fpR1zK34yRAUtVnGhRksSYp3QLdiLrxU
         DohmjA8cJnn0MT0tll6/gdDXF7Si86N9b+TBDs5LG1vOuPQqY5bO6/hoWGuqGHsX3dxK
         F1Ww==
X-Gm-Message-State: AOJu0Yxp1w6g5VnZJx4lWMMOGm2UeJ0WLo273H+xbe3Mv1xlI0lJEl0R
	aAN2Tf4EUllRPstVZud9kQCjsk5TRT2NFGkY+YAYXSwatmGwCcG5hk0bmicPCA==
X-Gm-Gg: ASbGncve67sm8JuU4YhVireiPFOTU+6YPuqTKnT3Q7yyNQsdi2J8oOagX9712Y3wmky
	O6FV150vFLpFBxXqNSz7EiWFLbEg5QmjOJRsNN7nBwii6urEvkPO+Ao4tEZlocW7M35yXOKvoWK
	bosOp6mbp7zq6nAUqh9qye714iqdH7YyNAM6xs9XMtf1dizi3gfu4HVCMaZmkVLZqdEcsYgcecY
	ZXGRCuBRc0pgCO8gM4hN9JT1FzDIdHmccwEk9zHrQ2vAgk8izGMphQGZ6perhqOMghVQtvj1bR7
	IBQmnb82qeLirGACgi+h57dn6jlfslOFuenqW+cQFBbrXcxaaJx+28QX0YGeVq0yr3SCHC0K5Ls
	jHcz93evxt8Ofmd+WEI3a1gz7df/BdDNthqYBEEsh2h554cX195gQwacuVJv+DP6Bj5b/SSklEv
	1zuKZYJWHAtPoMsVU=
X-Google-Smtp-Source: AGHT+IHRHGitLmsWsYo/etohMeRnuCd/FMIIJ4VXfSt+QWjRhCiqYO1XLwGPnhDoaRUuu5ExRg6qhw==
X-Received: by 2002:a17:903:360c:b0:298:450d:6926 with SMTP id d9443c01a7336-29bab148b39mr75411415ad.34.1764160236748;
        Wed, 26 Nov 2025 04:30:36 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2c018bsm198061975ad.98.2025.11.26.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:30:35 -0800 (PST)
Message-Id: <adbcc0251faba4f86dd7da1f01e312fc38c4ee26.1764160227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 12:30:27 +0000
Subject: [PATCH 3/3] http: add trace2 logging for retry operations
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
Cc: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Add trace2 instrumentation to HTTP 429 retry operations to enable
monitoring and debugging of rate limit scenarios in production
environments.

The trace2 logging captures:

  * Retry attempt numbers (http/429-retry-attempt) to track retry
    progression and identify how many attempts were needed

  * Retry-After header values (http/429-retry-after) from server
    responses to understand server-requested delays

  * Actual sleep durations (http/retry-sleep-seconds) within trace2
    regions (http/retry-sleep) to measure time spent waiting

  * Error conditions (http/429-error) such as "retries-exhausted",
    "exceeds-max-retry-time", "no-retry-after-config", and
    "config-exceeds-max-retry-time" for diagnosing failures

  * Retry source (http/429-retry-source) indicating whether delay
    came from server header or config default

This instrumentation provides complete visibility into retry behavior,
enabling operators to monitor rate limiting patterns, diagnose retry
failures, and optimize retry configuration based on real-world data.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 http.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index 212805cad5..f318e2fbe8 100644
--- a/http.c
+++ b/http.c
@@ -23,6 +23,7 @@
 #include "odb.h"
 #include "tempfile.h"
 #include "date.h"
+#include "trace2.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
@@ -1944,6 +1945,8 @@ static int handle_curl_result(struct slot_results *results)
 	} else if (results->http_code == 429) {
 		/* Store the retry_after value for use in retry logic */
 		last_retry_after = results->retry_after;
+		trace2_data_intmax("http", the_repository, "http/429-retry-after",
+				   last_retry_after);
 		return HTTP_RATE_LIMITED;
 	} else {
 		if (results->http_connectcode == 407)
@@ -2338,11 +2341,15 @@ static void sleep_for_retry(long retry_after)
 	if (retry_after > 0) {
 		unsigned int remaining;
 		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
+		trace2_region_enter("http", "retry-sleep", the_repository);
+		trace2_data_intmax("http", the_repository, "http/retry-sleep-seconds",
+				retry_after);
 		remaining = sleep(retry_after);
 		while (remaining > 0) {
 			/* Sleep was interrupted, continue sleeping */
 			remaining = sleep(remaining);
 		}
+		trace2_region_leave("http", "retry-sleep", the_repository);
 	}
 }
 
@@ -2400,10 +2407,15 @@ static int http_request_reauth(const char *url,
 			/* Handle rate limiting with retry logic */
 			int retry_attempt = http_max_retries - rate_limit_retries + 1;
 
+			trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
+					retry_attempt);
+
 			if (rate_limit_retries <= 0) {
 				/* Retries are disabled or exhausted */
 				if (http_max_retries > 0) {
 					error(_("too many rate limit retries, giving up"));
+					trace2_data_string("http", the_repository,
+							"http/429-error", "retries-exhausted");
 				}
 				return HTTP_ERROR;
 			}
@@ -2418,6 +2430,10 @@ static int http_request_reauth(const char *url,
 					error(_("rate limited (HTTP 429) requested %ld second delay, "
 						"exceeds http.maxRetryTime of %ld seconds"),
 					      last_retry_after, http_max_retry_time);
+					trace2_data_string("http", the_repository,
+							"http/429-error", "exceeds-max-retry-time");
+					trace2_data_intmax("http", the_repository,
+							"http/429-requested-delay", last_retry_after);
 					last_retry_after = -1; /* Reset after use */
 					return HTTP_ERROR;
 				}
@@ -2429,17 +2445,23 @@ static int http_request_reauth(const char *url,
 					/* Not configured - exit with error */
 					error(_("rate limited (HTTP 429) and no Retry-After header provided. "
 						"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
+					trace2_data_string("http", the_repository,
+							"http/429-error", "no-retry-after-config");
 					return HTTP_ERROR;
 				}
-				/* Check if configured default exceeds maximum allowed */
-				if (http_retry_after > http_max_retry_time) {
-					error(_("configured http.retryAfter (%ld seconds) exceeds "
-						"http.maxRetryTime (%ld seconds)"),
-					      http_retry_after, http_max_retry_time);
-					return HTTP_ERROR;
-				}
-				/* Use configured default retry-after value */
-				sleep_for_retry(http_retry_after);
+			/* Check if configured default exceeds maximum allowed */
+			if (http_retry_after > http_max_retry_time) {
+				error(_("configured http.retryAfter (%ld seconds) exceeds "
+					"http.maxRetryTime (%ld seconds)"),
+				      http_retry_after, http_max_retry_time);
+				trace2_data_string("http", the_repository,
+						"http/429-error", "config-exceeds-max-retry-time");
+				return HTTP_ERROR;
+			}
+			/* Use configured default retry-after value */
+			trace2_data_string("http", the_repository,
+					"http/429-retry-source", "config-default");
+			sleep_for_retry(http_retry_after);
 			}
 		} else if (ret == HTTP_REAUTH) {
 			credential_fill(the_repository, &http_auth, 1);
-- 
gitgitgadget
