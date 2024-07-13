Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527413959D
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888145; cv=none; b=EXaBoftyT9dW+/MadrCIaReiZeJNGiUjbAT6MBdNmnNDjRaScarSvvKS3RsL4eqlet91WQANvRQCxxjkJNDMxRu60mz5k2uIJ9cqnDXuJuz6xetkn4QhWYZ8K4M/g11cDVfvah7MvaMVZR40c+Awr4GE2rX8WgJuYOa/WvI0w2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888145; c=relaxed/simple;
	bh=u/mUbXoWse80an1cUQRtEGq3Am/K5ByZ+4HyhCEAyy8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pMV+zTY1PPl6FJ6X80sRQw+KhgINMpgLI4gjWs7u2Qn9+BmqL4pqxleyCosfN7zHZQy6I13yOU+J/HwRj0Ut5E4EmIv/TCO6on801il+Paj6BwrVCZ0elfWVwgkcuZZAwp61GHZt75XvKpYScQb5qp2iAQz/Y5w0PgI60l3r4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKHIOYjs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKHIOYjs"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso2637719b3a.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720888143; x=1721492943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VJkjHzI21PObLvGWahoz1IagNeod6Y4+R9kwSZb2IIQ=;
        b=ZKHIOYjsaCXMYQkabLRhF6L/2+zl05WTrBABcIcFm19Nm2TQXZKLLDgZIOIRlg4ar6
         rZDonr4w5cS1YN4PJ8jDX1SE/M6obTp6O8gWSsT3dzHNYY0j99M9CjwkQGOsx4b4LnML
         zz4iwj5KYrbhv0jC2jHyZy3LU6ed9ouvCjtypHXqta3c24+LoGsSQKxgL8AetJAiLRoP
         juUnvnhCyMWx93kxHGi/c7D8gaixjggOuK9h2XKKJSGhoAgLrxqhhXpYGPRgS55MXKNt
         u3fi17QI8A9w/LpSAYN8Dul7nAiFOrx97TsBHMaG1picTtHwQxUD6sBnEnnvr1H2jmr9
         8l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720888143; x=1721492943;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJkjHzI21PObLvGWahoz1IagNeod6Y4+R9kwSZb2IIQ=;
        b=PTAMOXJfVIzTdv5uNOjnoeymy8IijMJCLczMVct7u4bUDfKw3ygV7S1+No5RLPeo2v
         0T3HHNS9ncDKQqNli6D/E6penPxdH6/9Dy5/GEY5GViz/5VIBnw5wucuCfcC89l5mIRT
         LyE/qHGpj8fwmS0GL2gMhnlWelRyVCvAmeUIRvuUZqZEoEr56s5VBAmPehMz51pmxEOC
         JMnOCHiixisgb3OczQljpwLT9uRYDDCDYJMEvvHfHu2C729VuWBW4iZz9J3ogq5OCNKd
         M7C0hBGt5Mn0hqLsXjfEwAb7EkqtoIWa8LoQUBKXF7dKwPs9yXN4gjxorr4vS283LOwP
         nyUQ==
X-Gm-Message-State: AOJu0YxgjowVg7g4DPxM3xyGlk/kte7Aq3d+OUtiUzlr+Sxuz+4KvOr7
	PaInTQcnJC39iCCcRG1hQHGJZvgK699KpffXPd7Auc5DWBu9pofeG+xAMA==
X-Google-Smtp-Source: AGHT+IFMNoqsj2lWj6z2RlHvQ4YcK96rwD4t3lqN1c8bfgeW5KQCM9K7mMa3vOMmdf6XBWL3xqGB4Q==
X-Received: by 2002:a05:6a00:2daa:b0:706:6b0b:9573 with SMTP id d2e1a72fcca58-70b4356fc81mr18048561b3a.19.1720888143278;
        Sat, 13 Jul 2024 09:29:03 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e32b6bafcsm1065089a12.5.2024.07.13.09.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 09:29:02 -0700 (PDT)
Message-ID: <429f8fda-8f6b-4cef-ab79-27e5d7b56fac@gmail.com>
Date: Sun, 14 Jul 2024 01:29:00 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/4] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Language: en-US
In-Reply-To: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac1..6daf3a6be0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -575,6 +575,22 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.45.2.831.g9e4974e3d4
