Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F392E7F17
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710781; cv=none; b=E7LjV1ANuudowIg6hmX+NO1v7/VEMz6EP7kJe8jzUDWQN3EtPyt4RUruvo/msEqgrDQ/+myFPonjqZL86Zn1OKJq3Zqi4FHfh1nESBuFCHEbnfHBHYmroYiJ6C/zLOZPBxROI0q5A8zfZr9tJBqeSnRlZCUk/54e5vetM5PD8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710781; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pkprnh9vSy4zqB0r0+V+5TFpKmO++R9C1azCQmPRsk5bwAb4miqdtVCNfI3Ugq4ivNmzhTlbibhWLTE3YPH2iZgLKkoQ8IFC3Op2YBjTyd1a6pZ/E8eLRQG6V6r2aFmKevpTbnDN9fQ33Yd02qKsGLaf0a8qugdSyyijA7EAw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLIwItkr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLIwItkr"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89cc797547fso6219416d6.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710779; x=1776315579; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=XLIwItkrc4DewvCEZe+WV3H4V3mWsEq1IEle827xHe4dv0/zypz+9I73Xxx2reqWE8
         o+tJgFOrKi1e9OnvC2nTrCesj8pJLum+Od6OZcnyZ60hTKb09eHxGN3W4IrVm1JIpz72
         ghpnOYOX1iqfOA859Erc4x0R83eeJAGoqM18x0oWCeT65MrGdWvAwbq3mQFOMUN73aVe
         sAQF1ocqbBnsHPnlf6YD8l+ZP56/BrIJoc4YV6bQoMFa07KcdE5zFR4Xg+vWePeETN/O
         dtzYuhwu7x0akdImpfEtPGtEbA42PkmI3RrBkwbwEJYydz00C6Ad0PSaniH/S9pSsx3P
         LsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710779; x=1776315579;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=qJNm6fxhj9VTomN3+slfwl+gcFUVsiDn9LJZaeElIMysX1LmM5HFvqNkKg/27b6CW7
         VOKN2aYu540u8I1q06exnibfvIKc1lQ2zRbPQc/lk9651JwTRN8/hUt4FIHtxbgW/IqR
         4ATuq+2d8LyAxlKXnAFMeMLIaxqW+eJkvmF3IhM2RvDM3KVjBDVmq6S00Vq40DbqQ8uL
         mfwnC0Njp//nRaoEFNeIuhuLnGeVwyLPm5F5A9tPoSC1JECe9wtCaxM5DuShrB9Hgh8L
         AlczyHnK6WQkbX9Wg0Tt3d4LUY655FXtY+i2rCLP9fZRU/3aqqnLpTUOn87sfub+HzlD
         s81Q==
X-Gm-Message-State: AOJu0YwtTvSBqQDGUNlX3N7lbtaxrh878s1pbbJr/bcyAVWxMcblVAKa
	KcgQlsGj3Rmfs59hqsArG2OR24MFZOvYa0ia9ReKDSlapKnMs6wcDAmOIfmQQQ==
X-Gm-Gg: AeBDievduCpyUV1wi6FkD8mrhvK5xRYqJCIxhpxW3Bf9aNzoToLNQrDt2UH1Hlo+Lj5
	cKpEmZ4r1mi1dzEYl1trfLroHjKqfr57HkFuBMWoiClbRvOHGe+izfNPGQE8YRt3n9so7AThn2m
	Z+YDDljienSNXAy8P5c/abWdr72RwjuW0Y0IV6wK+zAAyclLLNdAB01ScNrPBspw726hJYu8zrD
	8IjBKeEZOWEGQppKFQrA6p5SS6KsusH2FwCuy+Ynhow/AU2zDlp12CNYC5TtI/YQqSLcIz2FMNz
	7Fa4rpOkE73kBaZbkoK6PGPkvhDsg8lNAvotJAQgqZFUqMs8ZadektjZOpiVR0ns5lK0yl15DiA
	VnZNhRDh4AV8yPi2r/OTbxITiFez3GISjxefABIMc4OU0mMUIjVBQ1nZX9QM21QiP/lqs8De70z
	bdMtpFu+IqbMFkHeWDtaidHNA30vo=
X-Received: by 2002:a05:6214:4113:b0:8a0:44bd:57d8 with SMTP id 6a1803df08f44-8a7048cbcbdmr387546816d6.50.1775710778862;
        Wed, 08 Apr 2026 21:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac4c10cb96sm64087276d6.39.2026.04.08.21.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:38 -0700 (PDT)
Message-Id: <1283d259684c0ce1484d533d78076d059106d84d.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:24 +0000
Subject: [PATCH v14 02/13] fsmonitor: fix khash memory leak in
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

