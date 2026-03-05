Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42171A073F
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673385; cv=none; b=TkxzJST+Nx4hWaxKtEoeCyqaaN+MQ2n3m1wtEoElbH5JSZNbm/Kw6wU26CeNKScuQO1n6eH1IaHSeHEif5F2Its/6LrMcJ6ci5i5XHMm6uMxNRZ7ox5QpUh0kDJmyg6OPruA4GM3nn9LAn4G2d7MUi560+2ltz5fGF/RlrpAbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673385; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OJTNBxz/ynfp9hexx1ikbJD8fSQAyBAFPT7sGKU7GQ7ntzeRYz2JK8N3cFfuMWhQtvZnYbJ6sVKyHweedmWEcFf7wcEDgAFEm6+lo1DdgJb0IVzY1B+NLUmmgZRc6apesBxyX15JKp/dxF4oHF7SK0lwj4qFPvfO2SYqlbGadjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR/2pIgK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR/2pIgK"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c70b5594f4so768944985a.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673382; x=1773278182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=gR/2pIgKGu0HWzzG0GmC2RHxzbDKN6WLUClwELyKvXjcs2kbFU1+dGUMwu1sLDg/AI
         /zTI0KYOodinos20Bz9JmjbJwPQmkGuOANwClgxccqNhpg20ZAW641wswTwklEeLfMR/
         upwqwTDqTOlEVu5E62aubKzT+vtX9GzbsHVnMYio8zXh7rGKOGrYjHFHajHonVMPJEJu
         y7vgslHCZW5lbLcDOrSzlmT0n5DkECabpxd2HPnx+mQ1iUZ2CJiZ0/XLyw9tLSDLDpIN
         d1cbNfOF4G8n9wPAG7WbsadoZzDo82HwUaGgW+2J2Cv8P7b3kOHiCYZhsgcepr1YGASL
         dUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673382; x=1773278182;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=CWq++mcixzUylmNeaXyhgS3rUSGrDpZZ00Oo7Ul/3De3uKdjwZkfacZLNrzaJOkLRU
         R4rBiUl0Vx1ivVoNjRLJm1CkyL461hrfG+Kc4jMau8VMzkWUZnMf7Zr83+iugOx9BoU6
         DO7X5Tc7q7PH3qBo3u3mMVmuk0TYiS/Tg79NEuoiDew7lILtLyiWkMWSVlbQVdFp8f6S
         9sJkMP09Ycn0DaaOPaIe1TqljCqrWkxBO018JIyV/1wVALUzUZ5okEIXASnBE+QJ3gC4
         ib766GOm+ra7omYt1io7mfuLmiT0TQsT86pit1GEfDcMErmenZvf6LuDqHOx5VGdt0In
         ro0Q==
X-Gm-Message-State: AOJu0YxM0LbSKK3+LcUIjHlMvcpzJfW9VIcxR6M6khyVJjSJ+IhbMMaA
	IrJbwk1u7IDWw+AOIg5eR9UCVS6PBTV89ck93y+su9UF82HZdBtUtrXYwMtXyg==
X-Gm-Gg: ATEYQzybAqyUyg5rmas1gkby8Bb2AY5WWZlZnX0+0WkbpJ6gOfhVgw2CqtLKmJlBCzD
	Hji8KoqrUKw0fhEybpW10osQY74jufzTufkYqGE+FwRXrLbO8DZUW1EnuSwGAm+kM7R/y5qFmaT
	3WSZycEZArJ6fRqJHDg+2QV+u5zX0aCxoa0hWtuqn5NS/OQxJWKAnpff+HegZluTeEaZuqyazGS
	x1NRfNNj7Ge2wzXpH1ZX3O49L5DNQ2zQhHE1gofvEy5iPtQ7iR65Q8zsrvyUG5sAlSTSnKndzNG
	HrApSi1lS1HgFJty1tgUEXks45/V+T8sFIHz4BaCj2yQeXr/I5vS213kNvayQcW+Zfm7dMQHOMK
	Zdf0jrSyiDMryxT3+ugU0gCHVxTQeJx7Rx5ayCz0OIqXV23tKVEiYANAoO2X40F1t5a7FYr8t+4
	z1nl2r7iz3F/yn6oSK7GDdKuM=
X-Received: by 2002:a05:620a:3195:b0:8c8:e139:b08e with SMTP id af79cd13be357-8cd634f63d6mr74371485a.33.1772673382070;
        Wed, 04 Mar 2026 17:16:22 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a20471119sm20793956d6.40.2026.03.04.17.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:21 -0800 (PST)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:07 +0000
Subject: [PATCH v10 01/12] fsmonitor: fix khash memory leak in
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

