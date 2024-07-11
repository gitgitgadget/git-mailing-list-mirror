Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3A15A85A
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686655; cv=none; b=RV6eD5GX0i+uxSFtZJ0LpwLiSONWrJ3xoOlX4cxMDYHcTbakNzskk8fRRdtgA5Pg1Mi+fxcVJM6KZcEYuFGbPMon4s9bzS7x+QDC9ShtirGV4GCEYGUkZ0AjaexPAJwHjALyw+xFhAWRoJDLLB74zr1ypjtZDJZyr0JiXDoB6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686655; c=relaxed/simple;
	bh=l/bCZ2nQCD51Vyf7/ppVO0qTgHjKql4gqWdHIKsfGBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erutsLQUTCcIcsaIotpsaL1cRzqEF8p6v//rX/bAbMPdNo8yFwzKkn4oeMf530U1eqoQDQMFjI4XuDrq3ABkd5vtvfA43NkF8BvXM++EAqeSbA48e3TpDhQIb0gjE/IuLnVd9GP37dqjtJIeVCQbKESHDS6N0JqXFVfifwWt1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzI8NQJq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzI8NQJq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4267300145eso4474825e9.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686652; x=1721291452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhPRA31PDZWjbSgGlA4xgt4ufhqIBBG2ud74E0XLVhg=;
        b=UzI8NQJq7jsiUi+mlBr/yFWxFOjQ17CAIFd1QDKbCV24NUH1blYRGXAbyi0xVOvVa1
         ZHEZbFKbPi+quKz+41ReRfRISGU2gfKnCLb/u0R5LO64sgth/Ae4tAuuJWNYSNztD9E1
         o6sGMSQL+mI7SXVf7DrYUZoElHlK9qknc3z1cCJ5RKUqjuVcAVSydygQRwLAvn/4F0wn
         gIxuoGIEzxhPQtaJtK9R/VBscqUe9eSy6E3N30ZoB6vTHvaqx5M5ZVW85/U6NwGgEgTy
         jMNHF+jomIVvFUTQgGT5wETzqeTjttkiCzvD+Mcm18XtPuhdjq0G6p3RjNyOtrhLjc3w
         feKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686652; x=1721291452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhPRA31PDZWjbSgGlA4xgt4ufhqIBBG2ud74E0XLVhg=;
        b=JsZU8plFKTs5T6UcXAUAagjPnU9pOhn0CQr1JCD+2ZaQtoKZxJXW4vg4WQz7w0hm6x
         Xa3x/hnthuc7JPca70fmc6IpvAGhOxl32rWuvGX/gN0ELiJEOAkKgj7DIFoD+thyEaKv
         X/AzWyowohsJv/5hf/RHMmgV4nj1pDxraJgqXWfqiBIDhZA+FvRqol/4vXZWTnrhmqoD
         Gi+ZZEedUbh8Hlbm2fkHhnTJMCO5ENos8FMKrbRpT/7GBKTuK9HmwSuJTlTFs4gDbM/f
         515DVIPBKsQjbiIfK8xPzI5sqDzCzsI6xqVoqu4+0ucsPj27p94mDL+Dmk55eiIvsbWp
         MMSA==
X-Forwarded-Encrypted: i=1; AJvYcCVcpuUr3FqPLNM5URVc28mqrrjVlqAROF5PU4U7MNKdZIVTUhSRTEDJ+xcLT9OogBq0GQ+99Nt607fnYU/e4+gCvIdS
X-Gm-Message-State: AOJu0YwkXRpm3iuv6C3YDauAt1ij6kiaOVMWFS742bRXd+G+vmbxXJSF
	vJTt5FIQau5TNfULE1IF4GmQMOGY4LGq2FbQA4eSYKy6wVb69QYW
X-Google-Smtp-Source: AGHT+IFzYQHLJsF7+bOoafb9E/M4Te3wPxgqPzAXGHZAOBPxoZko2v5Pv8UlQ+8He1I81TaZko323g==
X-Received: by 2002:a05:600c:4baa:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-426706c656bmr73012895e9.8.1720686651668;
        Thu, 11 Jul 2024 01:30:51 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 5/8] clang-format: avoid braces on simple single-statement bodies
Date: Thu, 11 Jul 2024 10:30:40 +0200
Message-ID: <20240711083043.1732288-6-karthik.188@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
braces for single-statement bodies in conditional blocks.

This option does come with two warnings:

    This option will be renamed and expanded to support other styles.

and

    Setting this option to true could lead to incorrect code formatting
    due to clang-format’s lack of complete semantic information. As
    such, extra care should be taken to review code changes made by
    this option.

The latter seems to be of concern. But since we only use clang-format to
verify the format and not to apply formatting, we should be okay here.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.clang-format b/.clang-format
index 914254a29b..8b75dece80 100644
--- a/.clang-format
+++ b/.clang-format
@@ -117,6 +117,12 @@ IndentWrappedFunctionNames: false
 # int *a;
 PointerAlignment: Right
 
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+RemoveBracesLLVM: true
+
 # Don't insert a space after a cast
 # x = (int32)y;    not    x = (int32) y;
 SpaceAfterCStyleCast: false
-- 
2.45.1

