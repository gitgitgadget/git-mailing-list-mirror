Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3030E829
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693721; cv=none; b=bDLwV4Il2qn2bYamEwlwI2G9X1CX+6GnjxuenMKLo8pz+bvtvRQ8HVFgxEWbuBKILKiZaiwEPYeEz8aJK/hrDpwvcg0evxKx97ERUdVk3QNrmK7KGss9Btvv30GgdxhEqT+XuYjyWgMGuNNOHkBH8bVZ7LMwFVJ642V2f30dmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693721; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FJV9zyZNgvP7zDASowXQocpj6TSU2a/qss5/Y7UzIX2DGr0cbRruzobsDB8Z0beuMtasw7JVIQXGF9dypAHEa2mIzMAu0hIZtOlrR7NRjRLVBM5BnLTuu7irNGgOn82qYtyDM1lBt/y0BuWGiQiZBPXKpYbNz0b5IqrWyfwiWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR3rUVN4; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR3rUVN4"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12776bebe9fso6339006c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693719; x=1773298519; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=LR3rUVN4jBS81f1Sb6vuCk1Q31GX0//RGOA38A5E3ptlPaMJQ4HQJ6vspBEZJMbbp6
         /NXQ50Js+wQ2oWWgF6d+Bwb6GytdranA2mCCUGB/4KP1i77UiwhhD8pryzvMIbdbCXMu
         jKPD1D3q/It+agHmMX5yipaZfx6XklQNENriZIcZXNe6OuJbE2W936HeOzcuK/WUcQNT
         O2N7VByyZxzPhtkIWUyrIUqw0/piJ5Wt+HQFiiKXGiSFHUe9rK855Szy8IL4M8SHEAx1
         mFyOLJfYFo/sqlsDIq4AiQtk3DN8C9w4+EgggeUIZe0FWRHKmjq/fCzzoJeqpgd6ZRkj
         ybIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693719; x=1773298519;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=wRmORNcQof5BPN1H1W1Q9EI8xlvKV0tCXJ9fIZlimnXUF18uCU2Z9AiX9NnL30GF6D
         uMA7Vjhc9FvZRDMMhKqsnZ2s8Oh8vLl4vXfU4ejHlbRL9WhD88kDfrPD+6FZAzjZsPpF
         M+VnHNOytEqNwHxW+hUDnUsC4Vx4BPItAvhfV8gd36HO334WObHxGPvXzlv7d+mgM6Ni
         3i+C+u8wGXJJRM9+aJezJn68Am+VaWe1sME0h2tu1HvjlHKLtUlvULUhORWYN75w1UFj
         AKj5FPeeIMphvevuH3Ltgbz8tcmZSAwKsAKSskgDGBydM5PbXWpCfxjwezMv/WxBptuA
         ZL/g==
X-Gm-Message-State: AOJu0YyhBFI26T7k7HMcX/PMkYdCGAS63qT+Ef+jeASiailsfPzaA++q
	tFfDtUzFT32okdLDIKD4c86OTogyYyieWI2PhOZLh1z0qsqvrlmt46gIYnmmlw==
X-Gm-Gg: ATEYQzyBnTWPpYKE5mH1MUyE5F4oI/9BKsienZWOgH8hgRdRXKHa4MgtZFVUhcnXpvC
	uJIh0E5rdELSdBd0p31PuBAdyOrokGAONRIJMZHKDc6swVVTOxBp/TDRZiu6UrpL9aCT6By8sss
	DUZ6Qbtos5Bf/7BL7EvZ/DAAbeZN0QjuCvsFytLA9pqyGpPG0iH6haKyYOpHMg2V9WiBvba5POp
	+41vbg0C7SGV8x8TvK09rMDr8K2Ja156tzVBoBC83dE5d5Vq2hejYFC1HNi7WcCfyu900LTFk2z
	lQloYh24QlI7YsyQGJa4Wq5d0DlkifhlM6qOxfuMXQeWvxqsQmudlO//+Jscc/r+GNkmycLsdry
	uGdu0N8kBRzMSwWwqWsP1rfNZ7QXkclUgDGdKuRnyexgZ5Afoe/IKJq7378LSJaJpb2B8k5QYge
	YZyOYh8cnceQhuiMlD1nzGr/pXNQ==
X-Received: by 2002:a05:7300:818b:b0:2ae:5d3b:e1ba with SMTP id 5a478bee46e88-2be3109becfmr2138321eec.23.1772693719152;
        Wed, 04 Mar 2026 22:55:19 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be03fc6fcesm10384571eec.1.2026.03.04.22.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:18 -0800 (PST)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:01 +0000
Subject: [PATCH v11 01/12] fsmonitor: fix khash memory leak in
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

