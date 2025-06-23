Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571522F74F
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669569; cv=none; b=hm6r52UcOamFpGCHHo8hoXse8OA+nbsZDwdeFDV8IAFBSSlZFmyNS7Ix76GRY1miinVmfHgnCcODFGCNfs/7DARQNidqAm98cDOsufOGfBgj6vmfvEmAUAe1H/kIOdRbCylUkfQ3zWzCRLFVIZfQs19CDZiQUkXkpkyQq7TJKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669569; c=relaxed/simple;
	bh=Ig8txRb6UJ9KTNMy4LsP8H/jlwSgc+kQfumI9ncavB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0ndo7SXN7lDS6ib4k/S7GNhtGHpRebBBhYHj2YcHxJMj52QzArwTiykdaRYpur/Gx3cNZ3DKOCuSUQxWPhIH5IWESzirouPjR98xKM1MTWGhL5RyrECPiY/bmeji1frLYWA58u0QVpBCpLOKNuuug/a5u+VspBkAyK+KwD2EZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkHnBkbQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkHnBkbQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2960368b3a.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669567; x=1751274367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JhxDuT3rvN0T0etIi9yFwxauRx6Q73FZ7bU5Pa5CLc=;
        b=QkHnBkbQm+aCyRbW/Mqewj67cZuagdWtq58TpbH4CKoc+t05SuCFVhM6fHpjH8zhBW
         mZ+6GDp2XUn82RJE5jmWPXzN4WaPaGQiL9x1FM69e9x7Oq+qGjenGfb8sqyEraId0Nbl
         mfOSxHJOL7k7zgvS8jMFfmWmOBq/ITyBpVOfkr+po7PU4TuPkDMxIi4dD0UCU3OYEnuP
         Vzf4s6Jl0Vma2MyAcE0Ct51GyZ2DmCop24DWhexxohPTm9XW12UIm2l/aTErGzVTnOLL
         y2moHRxRK+TaVDadWo21phTjPxFT3AiqdfQaqUgTWWNdbjXnq4sVh6tF3+0XlWP3EYcu
         ko8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669567; x=1751274367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JhxDuT3rvN0T0etIi9yFwxauRx6Q73FZ7bU5Pa5CLc=;
        b=WtXKhVgXDGorQeYeknyEYdfl1/zvtyuwbop7lVieTJJmQwVw5V0NuimbT4JmJbqMRh
         RrV9j2gNomBzF5T25wLN36s6ccNtyupILosPnJ2gxHvPTzYzLrz7ZExR5eUSUeiCwcMi
         1SKCsmzQR0r0zp1+WDAsUsRhHP+MQzpyiqUTc+Vznmh+QN3hvlqDSbUNshTTP/85XqTZ
         +RhgJ0iCbHPTG5IxDnS6susgOsjT1MSR3RAHHVWjtYM/dniWmBt3qkxlC+VWvhw5HnSQ
         sbY5ifupuQGeD7Q4imKac/ZU3AC87Slj/tenMQK+y2voEnwURTyrj3nhcaTP8r3Cqn8c
         yhiA==
X-Forwarded-Encrypted: i=1; AJvYcCWL/AKosdJ7u2C6c7DExSJT6zN1EJuBZStCx1zqo9Ndg+neOT0hExLSsCiT30o758L4bPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPB7ris4byE9IsGIajS3nzRcjkTly1N/+m9LLtY6f+qZ3+hYL3
	jRJuSs/JUTUEM+NhDYqthP2CWP5Vd6kSoG4s5clL8sgqLCjpV6I+sW0coh+NNg==
X-Gm-Gg: ASbGncs766Uy9X7m21kc9lOU8oNQGrqDLIg7dLK5cDd39z65vIXD4Pj72Cltl4Z2MKh
	LKQgbYTl2a3LNQnXqzJrJXGG4sCYF/NLkWGvp7RPla/2jUSfTWRzGhctzPz0///82Z3JvcvrQnV
	aSfy7SgNAhvEM9nhC28q43sYvP4fmTU4SM1lL+Xdi46pT2sS+YmczdQudA5kk1S2GKQNCd/IyBa
	7rFepHSXEYGHdXU9/GUgjU/qKxz5pzAJImnA9+k2AoPNesv/69CC8h5vko6UrEID+u+r9PExZ04
	pHG5LLdnwhKc2sILAsXzK0qG4ZysSMQdAupMC2tnI+ZYMXvxRozOl6O9+tBgdQp0pCbaBdhUz4E
	gvXMeYOmbruIBnI/Nipe2LA==
X-Google-Smtp-Source: AGHT+IGAU3Dq4nrQCT+Af8wWbmoXgDvphrrB0olUT8QVSrwLW7hw1I00Iw3GpIzAWX0ozJ2vdx6ViA==
X-Received: by 2002:a05:6a00:1882:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-7490d7befa8mr14574851b3a.20.1750669567204;
        Mon, 23 Jun 2025 02:06:07 -0700 (PDT)
Received: from dwmfdoom.tail99f6b6.ts.net ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7779179b3a.83.2025.06.23.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:06:06 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: j6t@kdbg.org
Cc: derick.william.moraes@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2 2/4] t4034: add tests for javascript word literals
Date: Mon, 23 Jun 2025 03:35:47 -0300
Message-ID: <20250623090538.154858-3-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <20250623090538.154858-1-derick.william.moraes@gmail.com>
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
 <20250623090538.154858-1-derick.william.moraes@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for javascript word pattern.

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 t/t4034-diff-words.sh     |  1 +
 t/t4034/javascript/expect | 26 ++++++++++++++++++++++----
 t/t4034/javascript/post   | 16 ++++++++++++----
 t/t4034/javascript/pre    | 16 ++++++++++++----
 4 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 0be647c2fb..5bf1294f27 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -328,6 +328,7 @@ test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver javascript
 test_language_driver kotlin
 test_language_driver matlab
 test_language_driver objc
diff --git a/t/t4034/javascript/expect b/t/t4034/javascript/expect
index cc5e1253f6..98b057c48a 100644
--- a/t/t4034/javascript/expect
+++ b/t/t4034/javascript/expect
@@ -43,12 +43,30 @@
 <GREEN>0B0010<RESET>
 <GREEN>0b0001_1101_0011<RESET>
 <GREEN>0b11111111111111000011111111111111111n<RESET>
+// Floating point and exponent notation<RESET>
+<RED>3.14<RESET>
+<RED>0.5<RESET>
+<RED>1.23e3<RESET>
+<RED>4.56e-2<RESET>
+<RED>7.89E4<RESET>
+<RED>0.12E-1<RESET>
+<RED>5e2<RESET>
+<RED>7e-3<RESET>
+<RED>6E3<RESET>
+<RED>9E-3<RESET>
+<GREEN>3.15<RESET>
+<GREEN>0.75<RESET>
+<GREEN>1.23e4<RESET>
+<GREEN>4.96e-3<RESET>
+<GREEN>7.89E8<RESET>
+<GREEN>0.11E-2<RESET>
+<GREEN>6e3<RESET>
+<GREEN>8e-2<RESET>
+<GREEN>7E4<RESET>
+<GREEN>2E-6<RESET>
 // punctuations<RESET>
-{<RED>a<RESET><GREEN>b<RESET>} (<RED>a<RESET><GREEN>b<RESET>)
-<RED>a<RESET><GREEN>b<RESET>;
-[<RED>1,<RESET>2<GREEN>,3<RESET>]
 [<RED>1, 2,<RESET> ...<RED>params<RESET><GREEN>params_v2<RESET> ]
 a<RED><=<RESET><GREEN>=<RESET>2 a<RED>>=<RESET><GREEN>=<RESET>2 a<RED>==<RESET><GREEN>=<RESET>2 a<RED>!=<RESET><GREEN>=<RESET>2 a<RED>===<RESET><GREEN>=<RESET>2 a<RED>!==<RESET><GREEN>=<RESET>2 a<RED>^=<RESET><GREEN>=<RESET>2 a<RED>=><RESET><GREEN>=<RESET>2
 a<RED>+=<RESET><GREEN>-=<RESET>b a<RED>*=<RESET><GREEN>%=<RESET>b a<RED>**=<RESET><GREEN>&&=<RESET>b a<RED>||=<RESET><GREEN>|=<RESET>b
 b<RED>+<RESET><GREEN>-<RESET>c a<RED>--<RESET><GREEN>++<RESET> a<RED>>><RESET><GREEN><<<RESET>b a<RED>>>><RESET><GREEN>>>>=<RESET>b a<RED>>>=<RESET><GREEN><<=<RESET>b
-a<RED>&&<RESET><GREEN>&<RESET>b a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&=<RESET><GREEN>??=<RESET>b
\ No newline at end of file
+a<RED>&&<RESET><GREEN>&<RESET>b a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&=<RESET><GREEN>??=<RESET>b
diff --git a/t/t4034/javascript/post b/t/t4034/javascript/post
index 9d66c9dc91..12165198ad 100644
--- a/t/t4034/javascript/post
+++ b/t/t4034/javascript/post
@@ -22,12 +22,20 @@
 0B0010
 0b0001_1101_0011
 0b11111111111111000011111111111111111n
+// Floating point and exponent notation
+3.15
+0.75
+1.23e4
+4.96e-3
+7.89E8
+0.11E-2
+6e3
+8e-2
+7E4
+2E-6
 // punctuations
-{b} (b)
-b;
-[2,3]
 [ ...params_v2 ]
 a=2 a=2 a=2 a=2 a=2 a=2 a=2 a=2
 a-=b a%=b a&&=b a|=b
 b-c a++ a<<b a>>>=b a<<=b
-a&b a|b a??=b
\ No newline at end of file
+a&b a|b a??=b
diff --git a/t/t4034/javascript/pre b/t/t4034/javascript/pre
index 9876514042..43d5908e09 100644
--- a/t/t4034/javascript/pre
+++ b/t/t4034/javascript/pre
@@ -22,12 +22,20 @@
 0B0110
 0b0001_1001_0011
 0b1111111111111111111111111111111111111n
+// Floating point and exponent notation
+3.14
+0.5
+1.23e3
+4.56e-2
+7.89E4
+0.12E-1
+5e2
+7e-3
+6E3
+9E-3
 // punctuations
-{a} (a)
-a;
-[1,2]
 [ 1, 2, ...params ]
 a<=2 a>=2 a==2 a!=2 a===2 a!==2 a^=2 a=>2
 a+=b a*=b a**=b a||=b
 b+c a-- a>>b a>>>b a>>=b
-a&&b a||b a&&=b
\ No newline at end of file
+a&&b a||b a&&=b
-- 
2.50.0.rc0.62.g658f0ae201.dirty

