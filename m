Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D54328B5F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423755; cv=none; b=tAOUdsTtR+YowWlXhv/q72q6XddYUo0QekjGX5nBCIhV6XpkveuwQ/10DOpMtdfkXUwhp90641Tl2p73+TO4X/yxTzoTvBsmXSX7sTOvPiz3EFsVPhiB9YmNertTEkcwH1tKxLrL+JCnwOCmc1rtokbrgcXz044uScB2Rt3j/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423755; c=relaxed/simple;
	bh=w7Ii4ES4vpf2Tsf7ns8bHkP+Cdj53LqRgujcFqNk8Eg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ub5JDB8Jjx2P7mfp6lN/VLpnr4zISNDrwPCYwBhtYI+wbaGRmN8jTjbhj8m7rnQJbFys0kZNAOo1L7cCN28vNXOZmXGg6mEhCWXaRsCj/sqnohbTZlRK2ujJIulfYljadMLV6V1jmaX5ZW2afA17LoaptMWByc1+IIAvqPccaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3PzkrwP; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3PzkrwP"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6639995eec.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423753; x=1772028553; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBjwf+bFpWSW+dTEKkQEFvDAIQTlXmKM5FtZ6RDz2XY=;
        b=Y3PzkrwPW2F7AKubL0RRY6H+doLK/nJEt7rg5JJYIstxug5dxgSSJkrYNlHneHYCI5
         LepcM+3Ln5Qkc381j3V+tLeXBIkVnrww/z/dn8Zd8tTitv7KNFa702y1ZqldTXnnNEp6
         /2DBIwF+XsX2GFnfFwtv2KX5fp9OVpiZ9yQ66JnAAQfu3Z6EwL1ky7XB82b7AKwRNrAe
         DDRFCl0NWQPZvQBhUKTLqKdhy0QYhEzddnvXJmehsU7ZlUsrDyiQJfOMlQ1K1R5ZNUt8
         qvBJdULJ3CVaYgdL16D2eJQdIdLnD5kfObm2z2jv0ATttgG/7yx/sGaiz+97cvkSGpVn
         BgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423753; x=1772028553;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBjwf+bFpWSW+dTEKkQEFvDAIQTlXmKM5FtZ6RDz2XY=;
        b=fWO290jnkwx9aFHPFThVZDBeiuT7bHrUtSlrIBqCUzKYTWEKW2iXRbupyYjQPb9mT2
         HIQi1uRAmjMKmNuPU0ZKCGkc6INvSziBAw9N+ApEBtRY97blInV8GXQgbzXOzm5dfJB5
         M6AaJFZA300OOjUlm7zRpZubtvrkkWsvxX4REFFNmXh7w70jkxKF4wNuZL1kCVzHQf5y
         97/JboTi+xTHRh+K+PTDZFDet0UYioR6mCcQxEVyx1gliGsXXcsn/sH/yUj+t2rKrOTM
         cjFaGR6k44Y2TY15PyrYdGKju6n/Lt3z9wRIw/EF/EM66Ql6g0P5KlEfcVjmxzqUwBen
         KB8Q==
X-Gm-Message-State: AOJu0YwuRMuAsZ3GwFA19JIa3rAJhDFfri24xPHsPR3HAltG9mTSOCbJ
	8wevnWFlGUc6xSSlHmKz0s+8tUcH2EfphnkjBiXRTNmQ8uOh0XuUAdQv3mCaCjqJ
X-Gm-Gg: AZuq6aIwYux5PAbOtRXDYZWPjmTTTcxboFTkEJX+XtbHzEFHRa97gO/h1A0/BNCzMKC
	RP4+oo3YJ1xsP8Z1KfmNLSdQqjPJebacAYWYB5U+m6zMfT/E0wjlQ182QndxYR9U9yPOWTNFUh2
	YI8BGpwYWx+yYtzxtMeDv3qMPbeeHPadr5264ggJfE9mq8z7b2KBF7bvSEnYUJiiR5SkGGQ5imY
	C99QKi9DAfNxu8mly8s/uPYzxETqIIyp+PLoGC73x31tDUAdWKoro/6n4103sz5Ghh8wYLsjAfT
	3LEx68CNBVrgyQimvotZsfVCNhEOoRpQenAjoRBrW5kSsHCvWKbfo4quOVyvGeoMEbzU+McbK2b
	pQsCUcl/ra8YAdU/Mu2whYE9toL+Ex/Nv/ePJJRUiip2hf+9+fzSftP5ZwlkvJVtSpxZYPJBOsk
	UZKBy2N3/G0/wM0NVv9+IoR4uGuA==
X-Received: by 2002:a05:7300:641b:b0:2ba:77a2:2589 with SMTP id 5a478bee46e88-2bd50147752mr1414894eec.25.1771423753241;
        Wed, 18 Feb 2026 06:09:13 -0800 (PST)
Received: from [127.0.0.1] ([52.159.225.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb555b6esm18903749eec.8.2026.02.18.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:09:11 -0800 (PST)
Message-Id: <a3386f5b56e808eec57016e192d42e05543063a4.1771423748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 14:09:04 +0000
Subject: [PATCH v4 1/5] strbuf: pass correct alloc to strbuf_attach() in
 strbuf_reencode()
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

reencode_string_len() allocates len+1 bytes (including the NUL) and
returns the string length in len. strbuf_reencode() was calling
strbuf_attach(sb, out, len, len), so alloc was one byte too small.

strbuf_attach() then calls strbuf_grow(sb, 0). With alloc < len+1,
ALLOC_GROW always reallocates, so we reallocated immediately after
attach even when the strbuf was not extended further. Pass len+1 as
the alloc argument so the existing buffer is reused and the
reallocation is avoided.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 3939863cf3..3e04addc22 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 	if (!out)
 		return -1;
 
-	strbuf_attach(sb, out, len, len);
+	strbuf_attach(sb, out, len, len + 1);
 	return 0;
 }
 
-- 
gitgitgadget

