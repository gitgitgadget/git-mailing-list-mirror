Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00D156F46
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686652; cv=none; b=rpadRE7vuB3Rz95KRSEopc7KirIxBd+fqqnSIwzWyBz5h2oqYT9ZCJOIWUn7cpdN34Lfg9fqb+Tjenrn2m0Gr6V8P9AZdGfWrQizq/0wslWrGOsLj7UPOd8AbbFfgJRvbc4FlPH+QeIvekRgJI0I7sU5tKiw4Jbxb5BGce3O6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686652; c=relaxed/simple;
	bh=rYLSmW92LWpGMgOgvTXGMYv9BXgMYJjw8OEXTDbrCZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLUEeg85imFN59RwuUUST67RwTT+wN7ekUeTTwTukrNp53v+Bhd5vzeyja41VvdktlOZXkUnRZnlzc/2bkM8Y9dKXoLQ4m4tWPb5envdRittSSHIf1OQ94+9Xxti5244w0cL8Cj+pS5iuuPw43GnWpA6NsZ7PqkieLuwRK0lgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M00YYXR+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M00YYXR+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3679e9bfb08so333363f8f.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686649; x=1721291449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgCNkYwb6YHIDARQWCtaR6yrWUTjYfwaSb3ScX0X54Y=;
        b=M00YYXR+4kCJJQq8fMFa8gRppxfMLsFQgPN7LRL1hwRvm1BKSlH7p/zXcPT6X+Xx9B
         bC1ni2SxD7yGW5S2jSHda2V7WFJh9RdheiZ9fVAH++aQOM/2XQ+oHV3aAFdKx40yyoZT
         dpRqoCe0MaWsIOzUfD0O8LcCx/gY5teqjPApbuk+ZJ2A8Uye2k8apjFMg8DUSkBVE5c2
         XIkfusK4q7Ui94MnxqXgUJX7OWGBr9LSj+zoyzKMJD2fAW3yzUaAhMfUQWWlnRUjWVJo
         RN1vnYNmm+GjZdzGn268WHT8Hqd2lU9LjNrCO1GeTP79VjKwOr9x/Xh40uti5fxfHEW9
         Y+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686649; x=1721291449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgCNkYwb6YHIDARQWCtaR6yrWUTjYfwaSb3ScX0X54Y=;
        b=H0+B+vHLsxHxKvQDVvCBVUpgUGX3gm8717D3BKYqkgOtaI9e0bquQln+jLLeO7SKzm
         2H5n9DU01BsQu7E9PWS+EQ+Zsmvlp//cIGuj3oJ71wguiUv0/tyT2K+XbinxXfw8AKx3
         7tqVBIwwXVjE1v+8Zx8D5AG2WDNAfw1EuEXH/tqIkfr5Unaw/lE4ryPjLELQvcxjwyGT
         04IxRGcHml4MKq4Na+v+xeySN4VWKxOebninXiaFd3kI8jHQOzIvp1EnrY9lA6mMO+tm
         FbPUKFKLbZ0xuNHd7/anciszHDvfXGXFADF7ldciZ3Y92S232qZ0384aP7uDI9Sgr5XN
         pl/A==
X-Forwarded-Encrypted: i=1; AJvYcCUCAd/tPKa6vL7T9LyYjtkmFbN7O8pm2CxDqLdENFEuYTKbeHgVSaOJrQFuPDlPz7ymHQApv/8Rr0YkLrXYDYU05+Oy
X-Gm-Message-State: AOJu0Yyt+JnCAQzO69Dc8prA/60/huXwaq3x7JEb3k+crVARL06sj6+w
	O0bg1D8A1eS/Gxa5OSUnYbY7xSFMNxaOuV+ikcdPXMeaecmyP55NYG90WpcR
X-Google-Smtp-Source: AGHT+IHBzACZGeug1Ofyf1aRTDFrqoKOZUEd27BeUTreUikOdX3aFlzXnED/ygkVEAiGLfj/viNeNA==
X-Received: by 2002:a05:6000:1f0d:b0:367:8fe2:7d8b with SMTP id ffacd0b85a97d-367f05051ffmr1571801f8f.31.1720686648906;
        Thu, 11 Jul 2024 01:30:48 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 2/8] clang-format: avoid spacing around bitfield colon
Date: Thu, 11 Jul 2024 10:30:37 +0200
Message-ID: <20240711083043.1732288-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
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
2.45.1

