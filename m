Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30271D95A9
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330837; cv=none; b=fE5tTHTJlXno4MtIYi8LgByvj/3pj+PHZGc1gQCDD1NM1W/TDUwgQjY1LN5BJSrnycF/I2us8cv/0o/qVkpdmlpR4KyXFEMxAOedOo0SMo3xT/s3I1TmQZTONLKLofLskyoszLYm4Ip3d8TYQB8s7JYvwpLOtR997MPTy+tXRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330837; c=relaxed/simple;
	bh=65jF1Kbg8pmJoPHIj9oX2H0kaQiQ1E4nXq89L/GPzWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mag/lbV3oMhDjM6wIaVAB2UmlI0o53/m4En3iR9xxfif/t11dCUsPfrLVwmww7ljp0OOUerHOr94TcN/XWFyVELV/+nKGbbkA1lzZwlX060FJYEMxhGvRD73nDgogrfyIkPavfWmn7jkjNXSHlUW1LAZsE7CKi+qfWw81uWmY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irc5wZxj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irc5wZxj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220bff984a0so3723525ad.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330835; x=1739935635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUVxVdfdEGtwV6OWjbDz6WqfhYfQoLL9SeacMktxfpA=;
        b=Irc5wZxj2cX+jGhLLy5Er3c0MQicHMnmGV/ezGDmxj6pcD9CX2UYLIY8HFzNw/Upo8
         3JTcvUs693LXlfBgA0ksDrhl+KG7Vy8Z5yC+x4IFcRahPX3zKo/KMz8ycWsauxlzSrRa
         YGBtAB1qEsEmkGNGtB+dELM6d7s4E8YbGRr7vEbjnluCEQADWP9xqtfaKVIV5NUGSe4k
         NYdfZGnDES25gmuHS9cBFAtcYDz7GNDWUK0zN0gK+zrSyJHJWl3m3REnMwdSlBQdXjZz
         ZEWATZxMzbdn8FMKGIOTY+K2rkMu19ClMaWN2MBvMA8pXEtiqSv9qw7ewQc/rPlySC76
         KIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330835; x=1739935635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUVxVdfdEGtwV6OWjbDz6WqfhYfQoLL9SeacMktxfpA=;
        b=jPo54drF8PPvky/gCbm0XxxzTR6lCBgD30DK1w2xim4tN1cW5Qo2cATMqXp1YvfCby
         iQzoDL+29ABRhBw5G6mZTZRchl0osg4g1KEuTMKEz1dT81EUSOU8Z6ctoMMEajB9HHb8
         oYNzYlQ6fIVTyBxWSjUOS+UcuEW/7HeU2HN+XPus+ii5fvaVC1HvXbFnEgU4w5DRlPJW
         TfLWJ22xpiYnx/oYLubJr3/nX0x9RBEL1hGKtzuCgtaCZg4FYKMAUFY8QESkdITCAJN/
         srQrIqNohS4pbyPZwkkGFETgWzOkRUjs8LmY4sCTOBRk4+iFiDgSNIxOh5WuDzr7Y3dV
         Hzkw==
X-Forwarded-Encrypted: i=1; AJvYcCWryGJ7xSy49dNenKuAK4x6JHNOjFGPRxNZaGaRNNVa0wSS8NF8KEGx5zeIl/rf6ILaGW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7vclOjuuVBB2dOL5fLOpKjmB5k9RU1tS8PRPtksETONMCs2Y
	mnuTgEVOuAn2LPWgGX9+MxOa27mSjTkookvQSAiWb83LIfuVZql8AsKbNMF3Yk0=
X-Gm-Gg: ASbGncuCort7gZSs7jT0OI4u96rc1LUc2z8LqkUkYlBON+e7GXaD2dbImiwCbp5urjm
	ASPti15rhy4e65B3C9WuOfCOgl7/7dO1NPQedTp3UN9LKBKgm+WoOeu03RaaY5cLKe4eX7Z1diJ
	CSNjb37lVxk+vlubwdpeVDkb7xT1+NCJDEapWJJDpl/vNnr9RoPaDB3ZgafXQ2MJPIsoJGsbvE5
	9fgVftrvCQav9NpLf6ZHQS3ydrc+h2Gb0RHfm2cnFkQFg5Hs3AoqrocFjj1m0/8aFbMFoj4Hiqs
	yznn/tIaf6JxwqpRUwCpsKZ1WG1i2an00NXIclE=
X-Google-Smtp-Source: AGHT+IGqfjqOWZU5wUZQ8AME9ldC2kmGZpaMVLwCnDE7igeY3+P3o32YFs/kq01gqkLtVwnP+0qPSg==
X-Received: by 2002:a05:6a20:9145:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1ee5c822982mr3300450637.31.1739330835058;
        Tue, 11 Feb 2025 19:27:15 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:14 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 02/10] diff: -G description: Correct copy/paste error
Date: Tue, 11 Feb 2025 19:26:46 -0800
Message-ID: <20250212032657.1807939-3-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current description for -G is incorrect, seems like it was copied from
the description for -S.
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 019fb..bd9db 100644
--- a/diff.c
+++ b/diff.c
@@ -5866,7 +5866,7 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("look for differences that change the number of occurrences of the specified string"),
 			       0, diff_opt_pickaxe_string),
 		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
-			       N_("look for differences that change the number of occurrences of the specified regex"),
+			       N_("look for differences where a patch contains the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
 			  N_("show all changes in the changeset with -S or -G"),
-- 
2.45.2

