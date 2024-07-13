Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD894502F
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878326; cv=none; b=t7aotuqHwlCbr/ubb5ZJYwb9ef8rMWMFPGEwQkWMNCe8W15LxwYnn2Tzydosytcs5WFvSFdSdMIasKaQDfBlppIrz9P04zoDQxxxWwV1PCdvkxjN8O5NpW4ja/m16CSf2+M4h3VAsPyyDDwaUwfteYFmXv6QtT1W+SmcEPpw6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878326; c=relaxed/simple;
	bh=c57a5FZo8oc1XwZXmAykTqE3C++vUFM1nNGdVk7APJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzXjcHz6+eLM9c3Jkyb910m9N2a7HuQeyqqKA2kZU9t58R3rowYEvgVhxFSz0jtKVIZ5n9bdWgrs442i9CeHwTGnASunB/VIqmXGl3PVZ+eoSQITAolXeRBJlx6jQijct0KXjzXNM+geFwAQq4s5Lws4V0vnjfNqI5EBpOKSvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1GooAO4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1GooAO4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so1499289f8f.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878323; x=1721483123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=Q1GooAO4k4NPGIuUlWP1F0cknktGEXAl1L42W1KmP844hgOTcMmWAWWVZlh7/n5riB
         VU+dhJ+D36+5VFp42c5y89Dn3U6aBvIYCkjbOArA7aK0dWcG2/B6pWtnOl7ZdBdA3bHl
         X+FGxGlVXZlwjpdWrrPaWRrMBgJRGmKI+4ak+JN0ycBlCfuPSUUzJyMaE9/XN1xYSe27
         7udrSw5melP4eFOhlkkdkFjYUDnlKiALXbXSY8atALAgfelWLrJWPkv3HKd4cHi2xRDm
         FzBNfNlP5dLnW4RqP8j9VtECxtktzPHsB/poXFidi8MExtNsLAFE64F9VXeVmrhsdRqF
         DkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878323; x=1721483123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=m/1EMeyb2Pdp6fQwaEsFGokvJx7kaWvqnWOEU4lHoLRQ9KScxgR3e7rHncrbqze/iI
         xXa7ZWzEbdCYaKUKwSxKw8s76tfN2OaJhZPwUQQyK8Po8EwP7NP1UUWGZ4TikKh8pChG
         Jc7r4zUk6wnPC3LScF6Wo8QfIl/Co+7724P+gErKVtMFuKf8eT0VHtIJHUnuP9KdXlSQ
         ik10jAuVaLO2VUlt8DHE3VFlcVoR3PusFDYq9mY0CVPIUsRBS3iQjkEAc6jJyr/boAXa
         uz94koObz1NEIl2Jv99kd/2uePCJVUGTubZ+R2cP1kDMS/Pj23gml8oCCNYMUnN6jq/f
         5WBA==
X-Forwarded-Encrypted: i=1; AJvYcCWj1as8DyX/x0DVX4aiZNXMHZuHK+/tUTH/xzrI0vorAVFrT1bbjQv1q8ro9S1BKJTSlAhLLuTodnTvPWmGgdx4aniA
X-Gm-Message-State: AOJu0Yz24oITo3cy9X/9zetkKfGGqv7vk84noCksE7uwyON0XcLRkwDs
	tLAaaMH/6a8vyI9s6Yu3ZfeUP6AwKAZGSBB+1T+efFvDACz6iXdi
X-Google-Smtp-Source: AGHT+IHcUfQ1u9Lc2P+Jz+2xR+fUkCVlda6M/yzfdzjqGfNnNKiF1zoN8B8dZvU7lvj+8Pv0q6F/Bg==
X-Received: by 2002:adf:fece:0:b0:35f:48e:fe59 with SMTP id ffacd0b85a97d-367cead9455mr9592571f8f.66.1720878323549;
        Sat, 13 Jul 2024 06:45:23 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 2/8] clang-format: avoid spacing around bitfield colon
Date: Sat, 13 Jul 2024 15:45:12 +0200
Message-ID: <20240713134518.773053-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
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

