Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4941E871
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407288; cv=none; b=ZlLFqGezlRlJq86qb8j8X89Y2v7EE2VV4L9WWxMh/0OXL7hcYnJJJW1UokdFNRjg64uyxJN/lBqtinU3yVu/H5ZF+tJbeSgWn1VAohLYnHj1BufCEo5UZRmJvSNUL/GtLzHpdHpW/Pmo6dL51mL2IXBs6SZ4remVbWiEJhj4skQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407288; c=relaxed/simple;
	bh=uTL0lV6X36dMh2lBn1rywQSUjKe0jQBlSLvs8zcHxRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3kQ6cqoesmhxULGCktkblrzIpPg3+49khDQ+lzOlxx0nJVZyRl2/SgX4r1A4ySRuRKhOX6fDr/OWF8Lx9PMBW1MFBJDQgZ++xO/Pdc1MA6tm0MMfcJrMv32ZXMVT9sPkMUg8u7qUJB/R61HM2W8hFS7Z7A6Q0b4/aYtaoDitb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjYqnl0c; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjYqnl0c"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so2167727f8f.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407284; x=1741012084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wzwlxq3x8IVBvvI4EmbrnmTOMawTyIzojBlHL/pFT8=;
        b=NjYqnl0cKLmdCEHzRmuaksj8ijWW9nnc13Wsi7kjaCglU+1qXqJ9Rhj96j9cLrTquQ
         VWYRlAA56Lv4YAoD/lUqJwECb8U/SuQXc1KsV+vsy6Bt8zq/cFs4+3Min3NzsQTGZTwd
         /ZN6UY/oeUtB6neJowhSIS3/0I9Y98c/qTGfD1QDM8Y1lfyVbYOwZww3Jrl1I7eDL6rP
         Ei042nLWbG2MfpW2r5H1+czdVk2HyheE/tzdwXT2XyTViuQG7ISSGXgZjligVVDOi8hn
         Pi54dpwh+4mcRTZS/Q5GPIsEx/Mfrsnb58E3N9sIlh1kfJhjaR0rE73J8OoU8STr211N
         5bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407284; x=1741012084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wzwlxq3x8IVBvvI4EmbrnmTOMawTyIzojBlHL/pFT8=;
        b=q6g6AZuE7W451p5kW0Slnr14HC+DNtUTMLXnUuaUV6Q8EctdTTHwfKJpBnrt3sai9x
         hwf4isARqkaWGvMdaWGOs1CL4r+byXi3/yTlmdNjfJYgcI0L6sqbZ1u1AenU3GxHmEMr
         dK5cLXowHnFStCtiiuqOFale2PxH8dfckRtW5cXEICzLWr6uymcN+IkWXArYSpFI5JTl
         rOXOmhbR30Ok1A+1fNnADBGKOfxomZWkkRWij43R1svNAoNNFoFKs0Tp7bTNswF6V6fq
         cQYFo+EHJwd08haZlFljLFPsni48ljStN8zeoTjVGZUZZGYHdrAdtMSLAF5ZvxyzzQFW
         B6wQ==
X-Gm-Message-State: AOJu0YwhocCK2lQKMoxhxoV0497olsXbLUp/I1bCNTAwq/sXRYsx0rXA
	IyHi+B/Z/sedUaGJADLfkkALNdhstDwH3A2s/AkAZIJVC7tV7AMRDtAYVQ==
X-Gm-Gg: ASbGncv5O15k39OFF6ZY+JAfRuCSms1KXl30Mx6fCI+eDqxy/P4j6eReIbhdUBjBcLU
	bvPkCLtoBvAM2UP5UZmuGIaMNv5fvScmHoKxXUdrEz/zN+ujwsHFrEl4YxgatMNH0/uJ2gKDEIY
	8CbRFp/lUouYJG5WTtSvWxDvLfrz4xHcZw2qlZO7mzkQu0UIwBe7XCp7aSbRTqiL919ygjLLVx2
	mLskZjGOHf7xYjRZoWWsQ7s7PLhVdMpKCcBUTLiVmQHeLUt3xSXv/dhe+uuqSbe9m6r+k70PyKr
	OtMzNfNS/B75PQ5KXMewerppjRsrL0QX0dgiCHTN4bjcSyOjw6rJX6Bht0dA
X-Google-Smtp-Source: AGHT+IHL0yHd1JcO1s/gKhbqzABpm1dBgv1XRcXrAGpNc8NOYsEg46m7EyryCs5TLMnwAkLMcOi1Vw==
X-Received: by 2002:a05:6000:1fa3:b0:38d:d603:ff46 with SMTP id ffacd0b85a97d-38f7d1ffbfemr7789015f8f.14.1740407284424;
        Mon, 24 Feb 2025 06:28:04 -0800 (PST)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:29b9:ffdd:d750:1ffc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm31713125f8f.73.2025.02.24.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:28:03 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/6] git-fast-import.adoc: add missing LF in the BNF
Date: Mon, 24 Feb 2025 15:27:39 +0100
Message-ID: <20250224142744.279643-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.401.g48e0d4203c
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 58a2eaa51a..8e0de618c0 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -437,7 +437,7 @@ change to the project.
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
-	('encoding' SP <encoding>)?
+	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
 	('merge' SP <commit-ish> LF)*
-- 
2.48.1.401.g48e0d4203c

