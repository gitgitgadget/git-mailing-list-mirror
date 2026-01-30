Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5B331A6A
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787389; cv=none; b=Btsvdhk0vkUdpXXB9XjB/7SDZ7nWO9yY77cGZ1JF3xpwDfhzx1/YcBlnM3Qkyd8LRGFwOtvybF7h213bMOLhlaShi5BeC6Ou2qTxb7va6gtON8/fynGy7AlOsdKDuueb6sHeIr9pY2AijEbqDOxoG4o4zcBTVQ/twLG0SlSMwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787389; c=relaxed/simple;
	bh=3lwXalhxd12rVu14ZZiuvcEDH2v8vQhV0fYTRaTToNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3Ak6oJjL0VnVXXDWgph/FQFVd0uW77NwGIsEbpv452bl3q6id1qxU7FMCriHkqexvZj0s0YKc2fH6ruZoUtgh6S/74QI/nbiEeSw0/i1y2xbRIAzJBMvIWJ6Zg7BNQlFY+cX7v6ke87UShQRJ8+RTyyUlE5ukiilFzSy0k/gec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS5tbz77; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS5tbz77"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f47610542so1303793b3a.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 07:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769787387; x=1770392187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YniyITx6IG33nUNuvvxoZ35Y8eCPlYrpDRipcxQ32Wk=;
        b=mS5tbz775kAzp4KfDZymgqQhUYT6JFfkWCsVlARVmo2vx1UfhNLvTlYKhYk0Ji9q/c
         BTwA56kpZVRgolsHXV6g1WrKm3BadU/V3l/zdNcMHaEWLAU5jDcf6T6r0H1INKGpEwBA
         qA47EHj78rzWy0sy81ao2XNOSM0L5MjW3+ZV14+Rc4mYu5Itl5NMYaA10EbVVvmMFUIJ
         WWmwGSLEVfpLIWP/XYl2CPrZ3k/5oZrjg3T8NicUweVZifaz5unVQXkW6MtN77StZDv1
         fOureU5ZCehjwZo/eaChvXr92AVoH1+/Eqcl8bKb9vVQb6EzRJYuoki12ONddczFU4ea
         sl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769787387; x=1770392187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YniyITx6IG33nUNuvvxoZ35Y8eCPlYrpDRipcxQ32Wk=;
        b=nJmCwjeAW0LAb2QXwiVKRbXnjUadSn9o6lJogOt7DmUTpz4kRJuP5otbdU+VGDHGk7
         3pQuc9iOcxPRwR0+TWHi3wUuvV5N9Sz4lMGS3S5NqVZpF96JF25TydjvfIa/E3d8tmB0
         A02grNtGpfyXOTjn3j2dVBsRrVPvR1j53UqVHOFAq0DCAhLyg0KFEOU17Hlx/lKvVUhD
         40ImDX0lu4CLCYVCR4Ya9AGdUu317pxNrwjitJ8L4zzpLq0j3fhbrxszOzK1iiZwUEtn
         3Xt7IOyYjarkz5ZsRjacjawn0odkHgmn0sQelANG6e0PLJgPARVWjVw8iluYFGqSZzB3
         SDeA==
X-Gm-Message-State: AOJu0Yy02UXyJmjaXh5QI50eHEgcpqDXOacFUWZvvSODVxh6R59KkITE
	ZDLaeIvbXuLj5yhrKRwH9SjmEJS6XBrXa0oVwgDpAikwFFFA/veJjUvPtieo4Q==
X-Gm-Gg: AZuq6aJnZp2JdTFSwQvLUmkEhBhbi5CJ4J+PiswUHj58r66v4O2IdKjXNSnsUONWXL7
	bk1LGITwqBGRqEWuWik3O79iAiO48tLmqyc2dJZdYCioFY+QV94c7axMZ1LOrhu9LTrT9HBnBOL
	4wyAHJfqma2GjyT3t1sqgzQMsJvRRhBAwEhPtarD1rk7bzKmGq/LRqjwzMokEWV7CpBtYEcLx//
	upVUfj5pykSQYdoETdOzX9Kb8xSo9MTYkC27uxSPN1kEvEpBXnnNsGx2In+6flpWBpsSrmQ/VNF
	847ndwsYTzWr+xGKwJFId3Mz5bQblgXmiRSust+XTsp19uIfUj09+WVyBoIijryu1ifLRpPZ/CK
	piPwo0yOY3Ws5CA85iY8mNg3mkgvwn/9OnChLxEvCQ9vqx/sMd5fePzkEnseAJqfCuaUJr1nuzr
	mHONukmkaz0enpNBIjflCIuE9NLwycKTX0GrSHL9lwBG3x6Q==
X-Received: by 2002:a05:6a00:14d1:b0:81f:4675:c2a7 with SMTP id d2e1a72fcca58-823ab98330fmr3000982b3a.55.1769787386967;
        Fri, 30 Jan 2026 07:36:26 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3c46:c24b:c90e:ca5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54d4dsm10033713b3a.67.2026.01.30.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:36:26 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	sandals@crustytoothpaste.net,
	gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 1/2] show-index: warn when falling back to SHA-1 outside a repository
Date: Fri, 30 Jan 2026 21:01:23 +0530
Message-ID: <20260130153603.290196-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'git show-index' is run outside of a repository and no hashing
algorithm is specified via --object-format, it silently falls back
to SHA-1, relying on the historical default.

This works for existing SHA-1 based index files, but the behavior can
be ambiguous and confusing when the input index file uses a different
hash algorithm, such as SHA-256.

Add a warning when this fallback happens to make the assumption
explicit and to guide users toward using --object-format when needed.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/show-index.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 2c3e2940ce..45795da2da 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -43,11 +43,14 @@ int cmd_show_index(int argc,
 	/*
 	 * Fallback to SHA1 if we are running outside of a repository.
 	 *
-	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
-	 *       the index file passed in and use that instead.
+	 * TODO: If a future implementation of index file version encodes the hash
+	 *       algorithm in its header, enable show-index to infer it from the
+	 *       header rather than relying on repository context or a default fallback.
 	 */
-	if (!the_hash_algo)
+	if (!the_hash_algo) {
+		warning(_("assuming SHA-1; use --object-format to override"));
 		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
+	}
 
 	hashsz = the_hash_algo->rawsz;
 
-- 
2.52.0

