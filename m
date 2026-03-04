Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F03D75C4
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648133; cv=none; b=RAItGq4g701cJYR72znqJ92ZPkmsoo0VA5k5xvsCvOCLAmvhsGAuTP8FzCXr32ECsGoN4j8og1zl3In4ulUXJawvUT012tmjmK3ZFrjqle+nkV2hTt4PJOy/oauXKTr0AvFKH+lkET2slXrKPVT9s7gSIwiZ7j46ikpTDuRl+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648133; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c4n9LW2ItcZHkA06PUzCBHQJ2yWag3wirtjwFgPwe4z6xjoryRsTWoCKCoh7EwbRiEdjKKO1vPwKJG01V7BqQSXjRwad5E7GAOV4Ihg+feqGu8YzS3gsD4QEZPz1Ak1RzTD9eDeatIWS1ZEwIHEKCXImWu2XYwfPtwbkynr8Jyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkk6YNcH; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkk6YNcH"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5890200eec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648129; x=1773252929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=bkk6YNcHUTyLX7MElGq7YiEJucgcHSQaT8O7mYGuITWqzr2raStxAmL1xivZ/qW7L4
         RPoYz/L4sW8wuoOX5ocXqTDJEzE9oG/bAz8+1oHozqgiQ/crwTvdU+V/uTiiQjoIfXHl
         5JyhpeHCcVwXxqBUKYoTHLKcCIyYikO5HN5eNQJ8Ta5aZHbxlo0raf85CdIfLmfsvKp4
         hskEwTjYR2p131AhX71Tt/EUJA62QmJPxqwhKt9bP18WeE3EvE6tzODRgYsD+ox3oouo
         KUuWzTiYDQT5yHFEADfvfT+sDdL/AxvTwYVd6+Z5LUnP1Uy46bmnSqy8mTG4Z1+WpnLh
         D09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648129; x=1773252929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=ecA4TMp8x5lgI2eMVKS0LsfrQbhYrRAgt/2juJj0hFJslI4eYev/df7wBQGuuz9zD1
         2Iv6OCv9D3dP7zofroRM6pQfDw0NOrMgG7cNhywAAH/U8oVUMp4loOqtZlc7A3xuB9NM
         MIgexnN1T1CsFHxDpzPZRxANCtqK1AubGr9JqmqS9b3lTyRsfMx1n+lf2T24Xqbs62V4
         zeNxr1XR8GRE6poHvh0fWmYBIlgM3iLm3hla+AR8zFMNKwnPjdXCWICj8G/YgefDiedE
         oRX4h6OC2LVz6hwTIFew/eQhgnDZFU+GlSoIAFG1gB6xNzYOcZFYFzhntdpYXxLWM1ii
         9PQA==
X-Gm-Message-State: AOJu0YxnsHcfmHyKtDT0o1DCjJRjGSMam1tpYhG4lW8WmQkehMb01d9W
	ZTpfXNulRf6OgnE0AVdfEehOWQf/gk83DQguaHbEH1Hjpiu3cX7/dzjo9hzrGQ==
X-Gm-Gg: ATEYQzx7SCkcc8fC637zXVQv0XSxDW/QZEVT55iTiBffgCVEVwMHjk7s50YTfXwo4WB
	ZKzrQEuGxpMCUWeGEoEWmfifjkBLtWSsbRLrVWIp5fTfmDY5S24QBBhGCHiXJoDsQYodYprC574
	jgrh1Xz9TfsMjSkh61K8Mh2r1uSnWwCkLsuscytxdaG1hB1nrGmntt+sIdbzmSTzddVF3F20426
	up5kB+RbZ9Bd5TqlQnPKsS7k2QMTg7iKAtfkVz6/QItZ5fTrQRanvsEJ/t3Yo8MCsCl4g6umFdz
	lmrjP2Qp6lFsXcTFQJRdnkt5wojEg69Sl2z9Hv6pclaUV6LhSpNuNuNpEuoYdrcdGXTOSS02iSw
	p+6mN9g48+vmSiGv3JMVbL7xSagRGZ1LCdeJ7gOoDVA23o/deKK+W7A51ILhn2kEoqCRf3CGaGG
	YEOExFEgJZMu8qImDdCaUU6+cHPQ==
X-Received: by 2002:a05:7300:ef97:b0:2ba:6c38:c79e with SMTP id 5a478bee46e88-2be311bce57mr974302eec.28.1772648128985;
        Wed, 04 Mar 2026 10:15:28 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1e02f95sm15466177eec.13.2026.03.04.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:28 -0800 (PST)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:14 +0000
Subject: [PATCH v8 01/12] fsmonitor: fix khash memory leak in do_handle_client
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

