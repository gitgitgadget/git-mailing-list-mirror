Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244455886
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290573; cv=none; b=aTM3DpGcYJAUY3xaDY2SwW1mwntfdw0ZJG0QXIkkJ8ryOZEXocavsiaA7QE/a1qYuju2ouJbvXlNZws9NdTq7jiwnvSgAVIRvUKPr7A6LvYZ/a0f5UKy0pMo3yqr4j38fJPvW57zVFgqszbb5GaZaNFLQPwd6UxjCJXlqITb0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290573; c=relaxed/simple;
	bh=c57a5FZo8oc1XwZXmAykTqE3C++vUFM1nNGdVk7APJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS8q6IjKmDC8estF8/8QsrD6t96dGRKTVeyOqXOAojn/YzjpjAiOuc4oN3utxi2EYu4K1IKSz/FAngPqsEKgSdBCm/lYsxRXj7dmD0sfMgHvnty/WzxTxVSyRMhTEajuF3s5a4clH5+cAwiZjPFUP+gzHThOQRA4xff5VewqArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdNMjT26; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdNMjT26"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368440b073bso245635f8f.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290570; x=1721895370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=TdNMjT26TIZm6LnyIDrXxutiyLMFg9G7+weDNGyV47BMtwh6WA4//8CIYQu7iNB+e7
         BjuXZoajyIA02+iHKT0FsvLe3XYB4ZYc7ujXJXw+1LfQe+cH8idZoTaW7IBYscIdxl7D
         4xDtW/H3m9YI6F0AcJ285uovOkYl8kP09pXyqhWg8926+Ubl5mKcxPwCIXI+DNnsxwgg
         qbPgAQV+1F4Sz3Ss2xkAeZBWaeEzAh15upvYcWXN/+fgC5ytcmbeE/g4fKJXxhOztWsr
         ltBBVLdZN+fBRpfLtFfUIe6AQ5ZuIJu6JrhctReVt6LZ8i09kQbDi4W2T/nCTZIe8n5r
         deDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290570; x=1721895370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=K1h9MYuLH6VvzO/NZpSfskinSABZ3HGzPiPAXJMJeF/EXS6/TfzJ9nMBGZ2RMtn5Mw
         AHIkmp6JXAg0KnRdaIRueTKfZjDKbPFeWLDUZVwLmgE63Cx4tbHjg/w0YQeupaTwcFli
         CEv9+DY/kADfFVXmR8hOQd4JcW2v0Ravrinmth+EjV/PpZFtPhFGHft7WcLQNwPvAl6B
         7dkdBakVksPKONT9n1WHeU1DGLXMsGIjd3iz3vi6sJ8HcJwvvLR3JRdL2v0kdkjZhUcQ
         vkk4oe/iIEsW4PKd11evXfmlogBnCahmIizHPDGHewBqCFIJuUDf2RJEkjP6l0tRi+KR
         UPNA==
X-Forwarded-Encrypted: i=1; AJvYcCVpzD8Ai9mFZCrQokf77ralWt7gyvrHJ3F5jz4IUCD85q5E0V3k3XQ+UFQMAMN/LD7coXQz0aMYxvrLNy9O5fgmXUUm
X-Gm-Message-State: AOJu0Yw7eBw8cXGOkIHlD9jDk+SpNwkd6//83vxG4GZ355a8dDjU4BBC
	8oA07dcoBGOxiWF0M27TOYxgrHaxDRg4AwG5N3RdI4mgxUhkQ3SN
X-Google-Smtp-Source: AGHT+IEZVfkzM/OPQrp+gws3Pd8voF01Gl4YOZj1Z5CoYTgVlL1WBbtiAJxF68hI/zPwnIvAVSQKvA==
X-Received: by 2002:adf:f583:0:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-3684b378973mr1125401f8f.3.1721290569949;
        Thu, 18 Jul 2024 01:16:09 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 2/6] clang-format: avoid spacing around bitfield colon
Date: Thu, 18 Jul 2024 10:16:01 +0200
Message-ID: <20240718081605.452366-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com>
References: <20240715093047.49321-1-karthik.188@gmail.com>
 <20240718081605.452366-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spacing around colons is currently not standardized and as such we
have the following practices in our code base:
- Spacing around the colon `int bf : 1`: 146 instances
- No spacing around the colon `int bf:1`: 148 instances
- Spacing before the colon `int bf :1`: 6 instances
- Spacing after the colon `int bf: 1`: 12 instances

Let's formalize this by picking the most followed pattern and add the
corresponding style to '.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clang-format b/.clang-format
index 5e128519bf..803b274dd5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -72,6 +72,10 @@ AlwaysBreakAfterReturnType: None
 BinPackArguments: true
 BinPackParameters: true
 
+# Add no space around the bit field
+# unsigned bf:2;
+BitFieldColonSpacing: None
+
 # Attach braces to surrounding context except break before braces on function
 # definitions.
 # void foo()
-- 
2.45.2

