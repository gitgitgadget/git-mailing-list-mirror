Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1E39A06A
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615785; cv=none; b=dGrmArByUnLGtSMmUjTm12auH4qYMULQPh2rkrZx+ynCE50eigGV9jEJjHg5DUeJqeKj4knFNItggvTfLH5DV3aMkMEpdM4A5t9nQoufQluJgV+atR+3pt3W7Dfx6vui1vDGR4IlqVbVq0VGc1eApPhXhVnFVLFH9rCu7g+E4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615785; c=relaxed/simple;
	bh=4uJWnHVsV1TdL4gA+G7hxTVvtbeNIjAtZ3AacwY+0DA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E5xtglbjTRnrcnMhg3uq1TlDlk/n7Wcyr1W+ie9hubLO1Zc6AAL5DM5EMToVUFjtN4HTsODDN2TjdEzYLgU+Z2kQG6+YsXrrq4p9t9Z2pbRIj5fCIPlHby1DP74s3w0PGDetTkrbMwByxTjo2WyNbsn955e3wI1iGnRq7rf/Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szqLZZNe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szqLZZNe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso16494175ad.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615784; x=1784220584; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Oiwdp60r49JH/GsjUWAsYx8cv8tRH7kiWs5Ck9UUXAc=;
        b=szqLZZNeNaFLZu51/e4Cz8SIk3A+vzRjpIVA4N/cIbTSWbX9esGcZfnG5+DvFX8IIz
         FrQ/bz8iQmFzf3OfmK/HQwOibshF1lCxvS0yxHgjJgiRWaJLWHP8+1a6QL5cSSgY91Rj
         oaq5iWvWjwwCRDsymkQAJ/k/gbC/O/fXV3iXHewIwIgfiGkZLKrer3nSGW3uafWTsk5o
         btD8mMQlkZoBLmrUwHGkzrDV48kNY6aizccGH69BepGBMb7XVaLrFVGz3gRsav4Fv8Sb
         7BylZ8Ap4JIDUF3uqhZfbRpIj+YwLza6MPBwvaAmU2p48kxie2Qcr4KLIuQONyBSfEWn
         e0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615784; x=1784220584;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oiwdp60r49JH/GsjUWAsYx8cv8tRH7kiWs5Ck9UUXAc=;
        b=g+xeqz3uiH/dQ7yvn/C5WLe3dO97/9f3e3MsEhmdAvDvNZwGzLqEtqRnF8o7EcG25K
         SzpzCDsBZRSZMxQfNcRYzpMLpbxXKmoPIb2QNN6awj7WTm9PpxdF2MtTCJi2wmP3qTLr
         VLu1U7s52d3QUxJpdizmE7lG0SKb/Js7qBgHMGnn19YzHwTwOJL7eg7JdBw5J2Wy4DKM
         FM09PZtpGlkYd2cb7OzYdmT7zugHfacvmmApaAeMcluK0kVC87c0xMDM0ypaGRnTitYP
         qJ64S67HXslTxO5EsQcobPOT2yAKLLS7O2Bh/tXBq8Q/jdjqSXv6D+GL1KHumpidshMI
         djrQ==
X-Gm-Message-State: AOJu0Yz4xp1FKaJg67Gb2n8TTa85fZtZdoZeJJNm0/2wgqoxknmleFnE
	zZA8ZNY/nlVZCW8yi0hu6Jfqh3MLb2FzBCEssRRmDv+NbIdkGfm1laz3SrFWHA==
X-Gm-Gg: AfdE7clgOKm9+wasTzRO/m2/GjxG69YMle2/+XVPTinFSH3ZqJ+eTs8j8UngOnTLJts
	GGyP6H9p5xvhBIpFTHR3fc9PtORLSOucgJUgoJ8Nbfy4+kwVaFhbuc7l/UuR4bHwZX1B8lqkkIf
	RYOoFqBAbqIjn0mm9ZcUO/hcwhnpdkdds6LDKUvxzETCK7sc1qnTzrrn2OFVKSdB9sNwksKXzJe
	YLDOBu2XB6kL11In9fs2qRVa8vvSWo7habdIQl7G53Nf43r45z6yWfvTbVuGidpDaVFIo1/ugPm
	bOq2xWLFF3Qq5G7yanA8V7TGxZKT/EJTKd0LC93hVKx4oPyrdvCSJeB+ZGqshVnbOL2tBHRwYVw
	ev5ldSWKqHD1SAAvDoi+Hx5//kFo6gKJWQDh8llz31VefbC5j9Ubaf695d35sZABwEy0F+bbHAJ
	MOiUhhg9ONDXSCJQA=
X-Received: by 2002:a05:6a20:ac44:b0:3bf:a8fa:a7b1 with SMTP id adf61e73a8af0-3c0f0c2f4c1mr23503637.37.1783615783789;
        Thu, 09 Jul 2026 09:49:43 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm38360500c88.8.2026.07.09.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:43 -0700 (PDT)
Message-Id: <69c2c21f05a2aec95f1ef61f861051c289b03dd4.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:28 +0000
Subject: [PATCH 01/12] diff-delta: widen `struct delta_index`' size fields to
 `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Preparation for widening the delta-encoding API to `size_t` in
subsequent commits, which is what lets pack-objects drop the
`cast_size_t_to_ulong()` shims that 606c192380 (odb, packfile: use
size_t for streaming object sizes, 2026-05-08) had to leave behind in
`get_delta()` and `try_delta()` because their downstream consumers were
still narrow.

The struct is private to diff-delta.c, so widening its fields in
isolation is a no-op at runtime: the values stored continue to fit in 32
bits on Windows because the public API around it still truncates.
Splitting it out keeps the API-change commit focused on caller updates.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-delta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 43c339f010..b6b65d7607 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -125,9 +125,9 @@ struct unpacked_index_entry {
 };
 
 struct delta_index {
-	unsigned long memsize;
+	size_t memsize;
 	const void *src_buf;
-	unsigned long src_size;
+	size_t src_size;
 	unsigned int hash_mask;
 	struct index_entry *hash[FLEX_ARRAY];
 };
@@ -140,7 +140,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	struct unpacked_index_entry *entry, **hash;
 	struct index_entry *packed_entry, **packed_hash;
 	void *mem;
-	unsigned long memsize;
+	size_t memsize;
 
 	if (!buf || !bufsize)
 		return NULL;
-- 
gitgitgadget

