Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3F3C945A
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109154; cv=none; b=ZA6cq8o3Zz9+KHvr6NYR3kVcvpCcmqTrdY4s+pslRkP/vdzSlDkcfc4Q1PG/w3HivJMHLhDOCIiWKdWizZ6EVaL63kmJmA1sSt5Ev90HeB5MUzlwptOp8tcaDWaZjTjH2kUnWqOwFqGCOaH68muAcJjgBVCyuRsX4w1AY5B2Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109154; c=relaxed/simple;
	bh=GpctcVfvABnkFE7+LJzuCd5zRVxTojrxGO+kprXw534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLBKXpsM6+cvsWuFa+h/LRLQ4xcV0bno/qrjPWqtvj5SrgXp9S5FIzbez5+a1Hzk79JbKtahDC2fSVGDMXxYwZcZiedcnT2uC7+zFkqKm2QoVQHJLrOQEgR6ShEmjUT/xrDfcvGQOPwwxhjcn+dAUC1pH0UUipOjQ1a8BZGOfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE6q7GUF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE6q7GUF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1463733f8f.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109151; x=1784713951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQ/55N/3UITj2aDUmhVqJ+/Dm0RvOshB7nYEs0KYrpE=;
        b=aE6q7GUFjW1MWCf1Svl/6RtobsJjdY1xY9bODF0PR/BQfcsCtI+X13ECRStuSl1wXJ
         7O2BKt90ey8v/LEmA0eWSy5vRNibDx16dFWbUCig0l5VGx5LlhUi1AmDr/6JtoYXEZf6
         dDCNJal+0DQltOkzCB9TPmRpAqP3f7bzOurVQ/UjsrQvEYZzREvElmktB1hk5eERwbbm
         VM+ZUpJf7M1TG/rIuW2IItOx2VWu1AKbjBewmCT1s0MrUJU/kX30EQUOYCpm2nZ5FTx2
         aYltrJqPaAoNVtZotKKQ8aXUq74wmJWTGhGHyVyDNIAvJI5nFkC+EuIdaIEXpHk6pFDy
         N6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109151; x=1784713951;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQ/55N/3UITj2aDUmhVqJ+/Dm0RvOshB7nYEs0KYrpE=;
        b=P7a5GQ5Gvr1JVYpwpvz/ppy2o25M177L0AuOpYSr/yByxs0Y1shFT6kveY8Dnad4vq
         QvzutVNz4GBCjXBYkH0U0rkujr+nkVWtYwtTZGHuCkKYyphTGKfYIdsFCSoJRyOiXPvr
         BEZtOCfT64FuHa3J1uwRttT197NyfeBRJ/LzffSecxnyhYHXRj13HMEFG0J3jrA8io+G
         gKxCQntRLzddfWnJVtyXhdvIcTlu1BJOu+h9hWQW3AydCx0A4aKUOpVaDdckg2ixKvJW
         Gto6oagwIJY6/VZIAyFzWHi8TAlzIMT5BmNYYB8rq0qwZLsnolZu3b+BAVb9yJigmuJ7
         Er5g==
X-Gm-Message-State: AOJu0YwTxaz8yTVA3fXVmhSCRKXwwzdAp663DmdMqO+Mm5sCfBDBH8bt
	nwJsx203wpqyDT+AbSifolMGucGP3yYIZFfyP0N0AqxaOOda/h3S8fiMHFtsflse
X-Gm-Gg: AfdE7cn9hbUeixu2rjmua7JLOEbBwq6z/C+LTLmk2CIv13SrhD/ytwpR6xmxhE3aNmd
	q78w+U9fqKrEpG60rDwtqONYeQ4eH51foEEtSqx1Npiu0nx1qB/lboxxaLQLomB4f3UWDvIqwPd
	AYpmdAG131mheA6gW6ve5DZKMb8sXw91QLQNamZtMhm5DsxQbXGNBE3q6Wc8jZfrGJj2bh23jrJ
	+qT49CE4ngxt9TzwSp4cA1UShRfWWx8zvgMGvhM5jhAb6qVyaboVkbYSJ7b+pc7ZJOgy75zViQ7
	msPKGmmkID5LDwWmW+vnXJc6umZlMa5rLLAJCogQgQ+ZyINoIfgl1ZNtdqEgNPoEpI/AQ0HffNB
	+HIwSa/z8iKisJ88pKpvpjUB1g/O9kW89cr2NIyfOVO9XOcC40fGBrFYQ1gMhvYLXaGOstYCotN
	xV4p0MDNz7tWZifW5XK1PdjnWOOBmb/Y6bikFebaopbB/r4LvCvH/cc6S8/qQC9hGolwzjV9p/e
	/c04r/FUEdljY/qvYt6WiDdab6AapdGrrcAzUYwUdowzjXFEPbn/nkeHxP4mkstnU0D02HWFGPq
	8LmYiX/84zO03WKYYX4yrO7gFh1FrXPuh08QCs//h+zOiIZ1b/GKVgcYbY2VavB7tidxgxkxt0j
	OBT8l5FZErfxrfDtGK4fm
X-Received: by 2002:a5d:5f46:0:b0:47f:5292:60f6 with SMTP id ffacd0b85a97d-47f529261b3mr1193337f8f.6.1784109151240;
        Wed, 15 Jul 2026 02:52:31 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:30 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v18 04/13] fetch-pack: fix hash_algo variable type
Date: Wed, 15 Jul 2026 11:52:12 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-4-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hash_algo_by_name() returns "unsigned int", but the variable that it is
assigned to is "int".

Change hash_algo variable type to match hash_algo_by_name() type, also
make it const because it is never modified.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f13951d154..eea72b2500 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1395,7 +1395,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
