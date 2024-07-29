Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C61E49E
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722227596; cv=none; b=lMKMNHr5PWA3UZ0fZ6ETXHHDLUH33tYSl/SgXuwxGHDh+5liC2POnyGfCREU4UcKtp6RSBCBmHU6i0ec6iYgomgR4+0i45KypObg4EzQcuHfeclVIN5VsaYx4HijBPJeW5KBiRJInnQWNfVFHlpydCZ6b0SSPj79HiCTBBWnZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722227596; c=relaxed/simple;
	bh=zKgXk/OPzozKCOljz+PDjfZ7pZQTZIVyx0D0A1sA66M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5uOdSrTueiCwzZQhaOnMAAOpHmS3ZTKmTJVzb2Q8SKKlKhmS5RdpODOJx21wTN64OQjJQTuwJI+XBn4R0y6aepkl+J1YqwDQtVVh8n/ptwGj//VgBDVRHHy1QK2NJjuPi8dFePkrhbZlQOCC1abW3l5ZXLSwo20O5IsNLOH45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/DroRwG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/DroRwG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd78c165eeso22149375ad.2
        for <git@vger.kernel.org>; Sun, 28 Jul 2024 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722227594; x=1722832394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeC8ivV4jwB9Mle8Dve3/aam/pSOrks7CK3DbMjEArs=;
        b=D/DroRwGiREOtcjrfcxlTbzaiOedePYF0I4a7uEEO9tjax03lSvgYvBwKgsvXMlUky
         Oi9x0lM4TOnK9H2I45f1ui5EMh4XHbUZjAoN6teD9Yxh8TadxTOQuemYNibTvVihhwPW
         L77xed1gEAqnuFDbfqKPPaBLLcSzNRBAwejC5KqZuFVxvFZfj5QRSqKh1LfeX0SxSYxb
         yz32caioi4y09PHhf4FsQJJwCrxs9aB4UsZm7zYpC8vqYWiCFvhGWPNBmFU3UBpGSNDi
         uk7S1STUPk0bdO/c5vR+kBqMMZRKXXPgiLC3ROf0urhfboiuCbRLGibmwDASzKAWA6oE
         Px+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722227594; x=1722832394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeC8ivV4jwB9Mle8Dve3/aam/pSOrks7CK3DbMjEArs=;
        b=jdbgpELlXxMLYQcODcbr12Qs4ersIt8W4OyWh0Za3o3/NP4buQ1Vrev8+RINqVUh83
         uJJf++E0tBlQzkcuzUu6ycOkJ43fy/KMCKY3+Cn2g1J1Eqa15h4TSRmu4FD5sEbA2I25
         TtEXRIWR/cXk8Q1cULKaaSkSYpnIe7wihc1L2+3iWyjfgIpDF4Sgl3f6LGFhCDTxidje
         tmzJmz2Fs/gFPiX+iFKue6hDFQ+CHiQuXl9Nmk2zQolyyI0yXI2tEVmYJCi8zPMLPofj
         KOYwZbXDYE0bXsZmxETdeEJpiKAkSsVn6GD9j6gTCwEbjxG71zuLIdTuiz6zgfG0rd0H
         Dcnw==
X-Gm-Message-State: AOJu0YyAz+oaySR+SnuvsKAOZsRhW2HzIyRMV+HYkPFpK00RkG4zGNCv
	+A0QDQN+9r2EsEfrSiHOUAO6pLiLPGAKK2PXUyFN4aBCC+uEMMcbNeRuCw==
X-Google-Smtp-Source: AGHT+IEegT7R6RXF8rgia8Pn8igr4QuMh1NJcBig0wvg/TIZZ6b8u1FevoW5OGJADC1zWbScR+hJrw==
X-Received: by 2002:a17:903:120b:b0:1fc:369b:c1d1 with SMTP id d9443c01a7336-1ff047dd5f8mr105097965ad.3.1722227593997;
        Sun, 28 Jul 2024 21:33:13 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:380f:c446:d83a:d769:20cf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7f62fsm72573135ad.19.2024.07.28.21.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 21:33:13 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2] unit-tests/test-lib: fix typo in check_pointer_eq() description
Date: Mon, 29 Jul 2024 10:02:48 +0530
Message-ID: <20240729043303.3486-1-five231003@gmail.com>
X-Mailer: git-send-email 2.46.0.rc2.1.g1fdd4dfe68
In-Reply-To: <20240729041435.7618-1-five231003@gmail.com>
References: <20240729041435.7618-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment surrounding check_pointer_eq() should explain about what
this function does instead of explaining check_int().  Correct this.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/unit-tests/test-lib.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 2de6d715d5..c59f646fd9 100644
--- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -76,8 +76,9 @@ int test_assert(const char *location, const char *check, int ok);
 int check_bool_loc(const char *loc, const char *check, int ok);
 
 /*
- * Compare two integers. Prints a message with the two values if the
- * comparison fails. NB this is not thread safe.
+ * Compare the equality of two pointers of same type. Prints a message
+ * with the two values if the equality fails. NB this is not thread
+ * safe.
  */
 #define check_pointer_eq(a, b)						\
 	(test__tmp[0].p = (a), test__tmp[1].p = (b),			\
-- 
2.46.0.rc2.1.g1fdd4dfe68

