Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47683CA485
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752457; cv=none; b=Ku/dh0ixJMY14MWVFk2eqrO3xkMqjmRhUIx+tA53gpyNZg+5/rc8h3WP5bwuv88rjRRhBKM022pl263d0mEd+7cvhCoT9E9qddVmdouvhhdo5nOUvwsvP69nNdUnava8z+EEKPTj0pw9Kj6Wyuy5nV+Rq9p2TIVbZJqheUcdXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752457; c=relaxed/simple;
	bh=w7Ii4ES4vpf2Tsf7ns8bHkP+Cdj53LqRgujcFqNk8Eg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lNgcefYu6MO04XLTQkdSaMiJks/aQVE9FYD7bazLD/roPftIhOjBDn5xCedZStpwwzQ8oQj+cZfO6zX4PIPpi7NAQ8fs1PaC3v4QFdTGZEae/q0PA/GZDuQP70FLfeHsWAE4EbRYw5hYXnbwGgnZg3uN1x7txh0rB8dEQgwbZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccZZKiHt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccZZKiHt"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd785a8783so64171885a.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752455; x=1774357255; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBjwf+bFpWSW+dTEKkQEFvDAIQTlXmKM5FtZ6RDz2XY=;
        b=ccZZKiHtcwkPx48AOYuiaEvn0ghNxzBYBRrtEjsBZaNSDszlyiDpZX+08vhNvN+mXU
         uVPlWd6D6X+dJqrHojYf8rV0dNRg7ut5Jy5JrUXjd0fB7UgyqS9xFXWg+JrR+dsWhcbr
         4A+WebSa8lPLWtdVh3nSX5+EA9QQxfetbz3+H70YxAxjpJFKoEhSc2lemyMqOJnSeJ13
         W+CObp//K4tR0cSZ3a/y0M/jsv1b9ss1aiAJrCV+t3foblL/6aMdtW5E1iq7g1yge+sa
         TJFhccgT5FknoimYDP//huBVvie/MTN0wKdZTch5XbqxmAOVPAUNUgFI8uhx4hDNs9bB
         fwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752455; x=1774357255;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBjwf+bFpWSW+dTEKkQEFvDAIQTlXmKM5FtZ6RDz2XY=;
        b=FwlRndoSKe88UKnZ2tdEuS3jeFBFhSleRcmugpswt/gIgbPVOEQxVNmOJaJhdsb5V3
         ZiKLuWdH5qmf4B4aEmWjnXXgIYkr/80wZjoTITcORD4tpqD5YCawQdj5N99FrljcOr60
         Yo7niT+/6A8NHwHj5kuvSMzo+P2+wPukKZp4pL6UisarpENJL6EmurQTpV6r3iHGDFIN
         XU84mdw+X1Kg8dCdWX0nzMoPpDUvd20B21p+/S4CcrRqtknVET6nK5+JQG61S00HE8IW
         6YjlOK3ZzIWqEpBROXi5v8B45rcZTHWufCZVChMLw6X6degFZKy0DjGOvYLIYD88UxlU
         9q6A==
X-Gm-Message-State: AOJu0YyPczJYjOcLFBoKFEbhrYrKv/nBYA5F3M/BadEhvdQQUHNw8fbf
	JbQ7KSj4E16d8kzls2TA6AxQ5jrhvwXrYUQzLb6ZWFtxSqeOvf860WASepHuRA==
X-Gm-Gg: ATEYQzxcCdOey8SQt+vKW+0Ox/M3PnAew7KIUNBsvhnNYMLJZQejFuwCM/CtEpUU9aJ
	vwDuU7j3a0JnY6Hjmh5YHKJo3ldkwf6RGG9HcSGBUfgv9YMv0k/F/vlxHOsRphhadNjZ9ASbe6A
	kGYuBwiadihzd5xAOLXfzwf48mFFzGlXJvz2XveVptpTlEw4ZIaWgS28+UNAdl8M9dB8gqX9phr
	p4FE1G/Uz8LosTgear6pxgmSHZfoS2sXpMaGZoC1+sXYmX0Abtf7x7P2gh62zQRLQHj71d5X7Ad
	TvIm2h683D8RGmdxUJjokYEQyLNACvyztoAfEZyGApjimq2gQpE7OywtIFRJzdpwen2VxH+2bCF
	mSTt2BkwHMzggfluSgz74wFhCQxx8M793jhN7G4YFe5JkprefaLse76H36ueDaHsV0k2+dACfSH
	deXLBxyAZqX3qlL04HMmtkbpg=
X-Received: by 2002:a05:622a:198c:b0:501:1795:9d52 with SMTP id d75a77b69052e-50957d6132dmr212208641cf.33.1773752439558;
        Tue, 17 Mar 2026 06:00:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.23.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4c018f5esm54170506d6.45.2026.03.17.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:00:38 -0700 (PDT)
Message-Id: <6e76be1d85e3d3e9ec520112e433d4859ac4f16c.1773752435.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
	<pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 13:00:33 +0000
Subject: [PATCH v6 1/3] strbuf: pass correct alloc to strbuf_attach() in
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

