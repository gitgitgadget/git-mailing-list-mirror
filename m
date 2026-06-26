Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184E3F6610
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479297; cv=none; b=ivSEj+W4zNbTYPx26il3k4UFwqh1W+121TLH+6vJJwkva1chPeFQrXIlLoz7aTAqdgDNTjQ678S1wcJelq9iRC3aHK3TbLNnjnuKK68S+haFJ/wRfAjLDUlXFmf5OWgooaVhtvxxxrvaolANuu6CCoGuSe/i4DlHNlAaejEfR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479297; c=relaxed/simple;
	bh=lhstnYmL/4FLn27RxwEUNlvThyKWzQ4EtRj0eK9AEFQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nGmMT1UBRZa1tkGduLWBS8KO5nenG8A9Eksu1SuJyqxg8gXzVzEspOOX4sjQX9XCSfeWB4fA6Oyz4jJAzlDyvBBYEf0jDXJsKPkSgGLpS8vh4mG4UnFlOlZgVCXJGjnDMzNTo2fnSiTpI3o31OBF1wIAHettmHGgHTeGA5Q9uqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTIr7B50; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTIr7B50"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177945a279so8499911cf.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479295; x=1783084095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBfw0kziubA3OHkR8IzGZ7SChzPpNsFK21Tt/rClHmk=;
        b=gTIr7B50MP+u0s0MsfVufitks9rvW44R9/Od4th82zNVFP0y9B3LnX0rvlJEJwNRs8
         FYZG6wFoPIQzScsj40RtaLQzViTW04ddzYmuS3z3BeGM/AhVGn1WRJ/CrfDK8t6Whqus
         DLwqr30IzcmnqHn723zO1bMmn38NRsQWAAqr92CViJmab+rMnogTngI7oBOuTbtKreCN
         kufJCMdLT4yD8W3vaQHGADQASQ+T6ssWBToNupxDnYK1dR3M5vhVBc3n/D6R9sNI/jTH
         Iobf2p0q1KZLhQRhlmmk44QYnPHV3q8Y+uJILStv8SBiK1CASa0L2VE/jzBE8JrIAltX
         yf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479295; x=1783084095;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBfw0kziubA3OHkR8IzGZ7SChzPpNsFK21Tt/rClHmk=;
        b=OsEoGL34qEFJhuST6eTMEeQXEJw21k8htCSMBOybQgfDf8qTLQSSTMt62n25yEB68P
         AeuSsNNMDP9cpz0I3Uv99HfNY2QgPerdm0lckTDm3kM86rVAvqCgI9W/ddibDkZ3I1A8
         Duz4A6K3bJDIcxsvTHiIvfWwAYsIgOCmcS+WKhhOwN8/GcK+6kpnRaKzh5y5eCBR39XY
         OesJmdbphBy3ZUA4aAfjNu8e+d4c7LJYhPJr602Cr2jssZp+r08A88XJ3PBnFqaN/3fj
         FFj4Q/taJ2dkm/AA6txRNb1nmyqDFpB5DUip9CcAD/WREPlvCZqUQWtxbIoECQ0XfrOA
         ITlQ==
X-Gm-Message-State: AOJu0Yym4AX3m0pE8SRuzsUHtqZxGV2jHbURslJTkv3YqFlAMX783peb
	V2RqaauC/tZ4ChAkU0bSBPl/vNOCj+vtwjZY/Fnv1oMUpCWl9Mv9fY3uvVRElpPy
X-Gm-Gg: AfdE7ckJG01Ev+W2kJF+DDDgCZS7UHY1vQFKbsDLWwqcKHrCqDrrO6Bn5d0wAZfpMZ/
	pF3u+tks0kBgBJ3nS6A4UZngF0S6hCRmR4JoxGATxTz2tRwLDnFqJNQW3f0vNJGIPS3Y6PHCW9j
	Go6BggHXkGtVQsChWyoxTtwnAnWduafwpYaDno9sWmUU+q0JHMIdvMqkj84z2l9WmEqSiSOdj0K
	4TFYJd1ccp9Lz2k9M4ZvZi5s8GF4/9dBoteQlQAU68sAEKO36zXWVCXxlidbbvU0wcVu9O8JeRS
	jcUbkBtZnjF3Dp8DQJ/ndpWoyvjU1UVOyz6zJOr7yRrRXQ3BQnHoiE+H4dFmk4boXfjVJWl4pQR
	zryWd6FvV+gaeDLFmdKaLoiioxadTEGuleAnAAMGMFTgWWmZ6HXszOSRGyec43mEh3wFFdFTrRU
	QjnoaV/VHPth0uDw==
X-Received: by 2002:a05:622a:308:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-51a8b646c31mr4461431cf.11.1782479294810;
        Fri, 26 Jun 2026 06:08:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a514b4f5dsm94723431cf.1.2026.06.26.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:14 -0700 (PDT)
Message-Id: <e6181bf3c108148ad1c6c9f2a62712dfd01bd779.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:08:03 +0000
Subject: [PATCH v3 6/8] commit-reach: remove unused nonstale_queue dedup
 wrappers
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

nonstale_queue_put_dedup() and nonstale_queue_get_dedup() became
unused after the previous commit. The core nonstale_queue functions
remain in use by ahead_behind().

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 0f29b143bd..ee0e0fdf6e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,24 +79,6 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
 	queue->max_nonstale = NULL;
 }
 
-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
-				     struct commit *c)
-{
-	if (c->object.flags & ENQUEUED)
-		return;
-	c->object.flags |= ENQUEUED;
-	nonstale_queue_put(queue, c);
-}
-
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
-{
-	struct commit *commit = nonstale_queue_get(queue);
-
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
-	return commit;
-}
-
 /*
  * Priority queue with per-side commit counters for paint_down_to_common().
  * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
-- 
gitgitgadget

