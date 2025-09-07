Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26218A6DB
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263230; cv=none; b=nbXptUDev7qprhNX5funvXKguu6j8A0mlYKVHOZHCNFnc8p7UiyVeyLpUjm1rrlPeMhRvLHS5n2YMLdLxIYHDJ7ttJ0zEj8Q6vtQ5C6ZkMLB1/k/EnKpr/d+x4HOOfDYTOnKhpf1u0CjYdsJ7e2LeqXyZMKa7hJcYJYTOHHRUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263230; c=relaxed/simple;
	bh=uHneG8SU9CSwG460rg5rxedDgUGF0LSXEspM57MhRy8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R8t4GmVXpC6YURWA7h7yPg85S5NmrNN6FeotvnHHhwqHf/ujuAbF4DDw6Fh3lw2BLZzRSFhBxNP2qw839+71gZi2GMuf7+UxMQr1K4oMMBEK8InGjoQDinfPdDYRhVLJW+mMSM7ObWsqiDwEJkVMeZGiuV2nIPafvgOCoJPuRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXWmDzFT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXWmDzFT"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so2253736a12.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263228; x=1757868028; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdScjvK+AfDQ14y9gFCV/+ytiitPCEKUvlcKkziaSgs=;
        b=GXWmDzFTIr/ZviQrgRSIzDfpd2fdhUbRPikYiSkWaPkoJWyl7Pev/lv/tG7wjNoCET
         +lAtNQcJFpNg+f8GMlrrOmIsPObK9eX8/Dv+8rGdtiSlUFSSWVjVxfpYgJ6LP7c76ybr
         7AEh2+7X9kpyL7zBTfHYx6dlm7QJzDkLgygl65O7OLR5VoGue0h1pyI3GqXl2gQPORPE
         slpd1pzLUsjwZTnSzi9CX/X3tzQmbLbyvE8Zz4anWqTe4oRD63HvwFE9b132GMqX20zr
         D1CheXOSQUixBHFvCNPOVym74qAKmKGabs2AJ+ImFEhJa7rPKSFipgVNvyYdDl3zOACd
         2QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263228; x=1757868028;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdScjvK+AfDQ14y9gFCV/+ytiitPCEKUvlcKkziaSgs=;
        b=I8wNWGfR2rxIR2856/Sk/4V0xa/AiHruD9lVyMZbZhrFYTGAm2dV8CfDw12JsBd5UN
         VxC9Ewa9dx/UGxiNUgSYUfiDD6+q64ZhQX7bvqfV+E9LRuD3QNQ+feT6KYy8SNinFMi9
         ImrFhM+QJJ4Grium3tZW4qqh3VO/Vl86tWM0/+fw7TbSLj9vazfP87anxUPvJdKNf1Vo
         SR+jLxxON0Hh86ijITSBxcqBNpQpEUv62lcsVXbkRnJAZhq8Jop4qABOY5die5JLRjo+
         HWo3xGNi4LHzeHdgE11fJKFZ3v3VOIk5OkXorqhH7SurewtwV4299YlAk1X/F1dmW4yD
         QxpA==
X-Gm-Message-State: AOJu0YwOCqzuDlxxPeivYDkJxOedln3IuJS3uM2jhB7fBDpOderlyRfv
	aCzmnznOSmiLCwFoXUEyjyE1xi6Na7xKB+cpCVOonlJ3nPKOV9N50Qqx6gnoco2w
X-Gm-Gg: ASbGnctEy4C8Iq1NC2bdPD/tXsDnIMl2r6vHUVVnP1jDW/39JlD8fme/pc33k9OXLv4
	l1gBuQmCXrBhs3n8nDQT0zIh/Bab2QUn51uke4rS3JPdKTqnQDQUk+y65FuVLEeDi8HkKfKmsqQ
	lBM2zQJT2BhovKCFXSuzE/anIcNH4bMWtA0oqWPUEdUS3cOVYdlHcDITwI607umS8P+yPT2BX0L
	bmHE0R6tAJRUGkkr9vss1qFoXU18hnBPB+q+MegCHS9Yw3XWw3Lm1c2XOFVHN38iMP3wZu1mBmt
	GZbrUq6i3aA5pVCX7MjKePzXWXYRzPYPC3YiD8n+bnyjW33WrNmNXWMIzHPwOlY+YucnhnJal3f
	P9Y36T8O3d+uoALnglnjCb+5evgXk
X-Google-Smtp-Source: AGHT+IGZnALisC4//X7Xvt/RnGecL9G7tnKthli0Pn/p+7Y89ByLknvtg1Fa2Yju/dOqwBP/dAkupg==
X-Received: by 2002:a17:902:e80f:b0:24c:829a:ee4a with SMTP id d9443c01a7336-2516fdc76a1mr79475675ad.17.1757263227890;
        Sun, 07 Sep 2025 09:40:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24c7f3b762fsm129635035ad.44.2025.09.07.09.40.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:40:27 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:40:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
Message-ID: <aL21eowK8MwmDX11@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Callers of `get_entry_index()` are required to pass a non-NULL
`exact_match` parameter to receive information about whether an exact
match is found. However, in some cases, callers only need the index
position.

Let's allow callers to pass NULL for the `exact_match` parameter
when they don't need this information, reducing unnecessary variable
declarations in calling code.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 343cf1ca90..bf358d1a5c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -29,12 +29,14 @@ static size_t get_entry_index(const struct string_list *list, const char *string
 		else if (compare > 0)
 			left = middle + 1;
 		else {
-			*exact_match = 1;
+			if (exact_match)
+				*exact_match = 1;
 			return middle;
 		}
 	}
 
-	*exact_match = 0;
+	if (exact_match)
+		*exact_match = 0;
 	return right;
 }
 
-- 
2.51.0

