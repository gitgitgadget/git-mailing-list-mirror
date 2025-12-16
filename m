Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A234106C
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899238; cv=none; b=Z6SSmABPSW27ttjItQRJXLqoMzT9rItuiutcnoofEKiJFbfLBb+1l8J3eSOmAW662aKfhGn85M00WpO+LqppcTrGGcI25cD1uTC7vz1ms3MGzjAfamWDUI4of70oH0YbyX6RPDnBRfGhDnM5Z1+koPYDa3+F8slJFS5Ve2YiStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899238; c=relaxed/simple;
	bh=UCxF5BSlPEd8lje9cjUOVmYSqou3fa1vtxxR1hrfyoA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I7DUsXa/M2e6/if33kdlI3g/4JT2owNbReIwYXoZO3XVUHRmJ544POev09gYALLXk2Fc7HdUWCJg1OXO7OgTVQiMtf4cfh4yIXkurHUV4Z4rusKRa3OcWAvDzdH+bkAsNvacqABh7s1OvcF0w5yyzjzganSSMuZuxt+VdQkm8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLghLsv4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLghLsv4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a3eac7ca30so364444685a.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765899236; x=1766504036; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8BgOEqwXfv7Mb/J5M7PE33J04ler+hffyPoAnYj1vo=;
        b=nLghLsv4c1452RVGhSKuzj4KtXqZcyJVLdaSIgDwoDUNbaQv5OD1JMrcDbVaB/iy2m
         IQfwqsGsvdcXN3l8tNUffnIrECIwJU9BxbndkcX/WkNFhmQhxROMqzrDIfHunchGezoP
         th42wgN0qF065SgYVLs2q+MIuPP/LHlWJ3G3PLF2UUlOgeDEp2cVwoxp5V7Kf2fHtZ7J
         uB6Fqol1nQFwLU1lOVOuE3gZXW3WHFMRDK8ovjEEgWJdaF9AhcQTyeUwBN0EDxULMhFq
         LlzZT3ZKBzdUxb0GUwwDtcNSEtTkIxZCo71FB/lOJjwHG1EMu7bs7R45ryJNkZQYhGOE
         HEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899236; x=1766504036;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8BgOEqwXfv7Mb/J5M7PE33J04ler+hffyPoAnYj1vo=;
        b=TaD64wpffnnaywXxSAGW+F23edC2F9ayL0wanwzWu5bL+3VS390WVUBdBxIM2aFiyC
         p0zLbrQN+GlalAeuZEPgw8BSwaRm9yctEEpj75Oas38JzMCwnQ0MbtOgVzpEJlelU+eL
         CXzEqxJoN1t60Tvmzm30VRw41QRymXWSinzfNXSh/AwPprPZS6peZIFqkFyrWsAXOz7L
         78ZKQ9sw+52ox1eTZ7H9ja+m4yTc6mt1zF0nQQzzbawOCWrf5+0/YQD7Z3W4iY2IJvmS
         kgAalPNCIoj5SAmkNbjejvwi3K01sLma2ntmBBECZTyh73ZMD1zZhHY3o+Hym8o3U6D8
         BUOQ==
X-Gm-Message-State: AOJu0YziCAJU7rqW7da3mrsccDYEAjmUKizYDAEoiTrn19Jb0Up3W6IC
	N1qJNcdl1kfLLBNQi+CPdHrFOUmZyJ+CkSUvwrZ0Kb4GNHatB8IT/9H4W2+SoQ==
X-Gm-Gg: AY/fxX72sLQ49qzvlhn44Hp/m8gLLSPQMAU3Cm7hHAM8da1ffGY4qg4NoL+NTsw0KZ8
	xH7i2/fJC4IKceEmGRlvLKMOGWGNI+90Lej+HMqhx4RocukIUTu4bLLINKyS790QOvalxB7+bBh
	MVgegh4HtB/wVsRiXNc4yAijTL1b8EVGYMN/JMqe3ZFlDng0gloqgtI71y66v7No8D+DLz63HnO
	ASlEQuMo1+BbDCS88MJMaf+gEiTFJOs8KEComBJQFqp6sCWeH2QvRvLsEDdCGyzgnpQw5+Nm9HS
	2T5roWk3tDD7EFEVad55fz0yUUQ4Wp1q8sEAYqnD7XLLxgWa1MKM1pH1Ce9/kyhIxMMZpVx9GT7
	Yp3xS/k830/4B0/Vzcrvs2vT6p9Sb4apEabzIMD1aqfKy+Ae3QLdWCTM6RYnFgVfYMiUHXnrp2T
	QcV8/SetQiGw==
X-Google-Smtp-Source: AGHT+IEMTOJ5xQLQIDiudmGKqHPxXE+3WslOce/ed+SBu4SrFRXqInoHPNA4Ulf5rCeszh6oSGDNpg==
X-Received: by 2002:a05:620a:2685:b0:8b2:28c4:7ecb with SMTP id af79cd13be357-8bb39bd6531mr2021144785a.23.1765899235382;
        Tue, 16 Dec 2025 07:33:55 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be303e7f8asm206359685a.1.2025.12.16.07.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:33:54 -0800 (PST)
Message-Id: <db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 15:33:48 +0000
Subject: [PATCH 4/5] strbuf_readlink(): support link targets that exceed
 PATH_MAX
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

The `strbuf_readlink()` function refuses to read link targets that
exceed PATH_MAX (even if a sufficient size was specified by the caller).

As some platforms (*cough* Windows *cough*) support longer paths, remove
this restriction (similar to `strbuf_getcwd()`).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 44a8f6a554..fa4e30f112 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -566,8 +566,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
-#define STRBUF_MAXLINK (2*PATH_MAX)
-
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 {
 	size_t oldalloc = sb->alloc;
@@ -575,7 +573,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 	if (hint < 32)
 		hint = 32;
 
-	while (hint < STRBUF_MAXLINK) {
+	for (;;) {
 		ssize_t len;
 
 		strbuf_grow(sb, hint + 1);
-- 
gitgitgadget

