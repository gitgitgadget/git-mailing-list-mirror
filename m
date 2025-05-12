Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6A29D0E
	for <git@vger.kernel.org>; Mon, 12 May 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747015826; cv=none; b=CljOgFXIzKxUT7alAbevI97E802A5BxtSBi82z1WT+2RIZ1KzR7Ycccw4SDJMAuRijCJxrWGFe3fFNo+1Ukb2RGyPyNfHu8q7AD/MAZZWFlquiFE8QI6fKsaI9nd8fT6Fm+HaC4fAzg4x4iYQyo33CXKtAos5uCskRWERnz/KHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747015826; c=relaxed/simple;
	bh=aTshTXGcOf0yGeUQlX0orRNOEBEA1eo8iaPHRSI3+1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sz4buvWb1kUL+XwpPKmsiWM0HzxFum4kfQlKyxci1XW8UXsAouJ/VCyJf8gBnRaa13+W+nZ7KmJT58xHzpYvv5c9Lk09Fnz7rPTSIw4FmTy0QbnPjItTOfW6NQXI7fYlL5pTrqeVCE0taurRXXcKYDbKSmnPOV/+WFcTn/aErK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IydpPewf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IydpPewf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376e311086so5497906b3a.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747015824; x=1747620624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j2Q+LxR4XinO28CM2ns7v6CPTp/sAFv23X+EchOv1c=;
        b=IydpPewfFyRGAlKG+TB6D7dB94JmGkCGrnBfNKIiYMj6at+xqQ3FQJsee/XbB3fRcy
         7vHgyJaWFqGmFNGnRcOVetVA/VKK1WuJYSrQ1l5OHz3pNKvvk1kBjMXAWv+Yn1NGGV0r
         EUlzQ3SduMiP7kXvVKR1GiYD8oo3KEPg91a4lh1vyjaY/haY6CIJ4nvZRpnKTN06yxQE
         vjS6y58Moi31JIGcDQUwMnBQhVjfrNw9e7iBC6kmi/W8IcqQ7PKZqQwuYSfgvIOwfln6
         0owpENITjvUnInTzNXVLDmBcs/s5iESVKe6o4fS+jec85LHct0INpkmzYuT7d8h724NS
         T44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747015824; x=1747620624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j2Q+LxR4XinO28CM2ns7v6CPTp/sAFv23X+EchOv1c=;
        b=GeUsrOOfICILSV8+rN4Wa/WnZbKNOq9Xi7kEBrpy2xyHH+e2o30B38Uu4wgqINQdXM
         cg41ALCNeh0lfNUJft+H+kNoRO408qDCRVeBpiyL664jba0GLUw8qJcb/Tw5QXL48v14
         s2QYxVu0AF15/UxarVGEFdXJs87wSwupSvi+arrJHiJ5VRoAtCdwdSThsJngbofVe7jx
         yk3Bj8eD3Yc/bb680Cd9G62KeqjuQGHPaIQdS1T3pkIj9E0/Lfzjw7DGbqXpEFx+8aNX
         XggfNRsQFE89wOKHzEtnI/xr3S+DWfFCNBfDFsSRe/0ptDP6FiUq9GU3QmwKRMIOZg4U
         iteQ==
X-Gm-Message-State: AOJu0YzQ2etil92xdmyFaRyz6CN8P7jqBi8BezUU0rNAbN4HaimCcNUM
	tM1qMS48D/dBTVS819L9HTdbaJ4bowIjIY+5+Wp9LJJIndQBVzKncWXSjvRr
X-Gm-Gg: ASbGncuTGFmJGL/t1YVVp7eukRyl2OVCd0AfD7Nuu6YNs4UaKqFkelrRx6VmHibFdWy
	pwAHqgV8Kg0K1+uRTFWEMBb2gzBY7wcdNhvQY9Et/SmcHvzHq6N454slfpcAYQ6o8/jTUd083T+
	7U28GPYjn9E3dTJ4XG5zAXpG3gH9ojhLZg/tncQioJCDQl74wHg0+RZda7Xt+ajtupoXGhwRmmr
	7Wsi6v50jkzSGetW60wGUj57V5S/WvZp0qnz6uVjumU4HEFJCMg+812SWtlA3RE5VlAj9sldJPK
	Ju/v+vmeXmyQp3mnQbmITnoDT4kL9u0af6EFEq7SpBqTM1g44ruRWAJkt4MOQIQEjp8h7C56G1M
	FovMKU4siWKa/h6TCBN89GXiIOv8=
X-Google-Smtp-Source: AGHT+IHi6YYTnL/eQK+1uGSLkoO+/XCK66pxpiGEgrSrq0ELSaopHMUyNqdO2xpCtkfl6xIuEBG2XQ==
X-Received: by 2002:a05:6a00:2347:b0:73e:23bd:fb9c with SMTP id d2e1a72fcca58-7423c038fb4mr14959122b3a.23.1747015824177;
        Sun, 11 May 2025 19:10:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:e40:9405:a1de:10d2:a65b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0cdd7sm5212185b3a.90.2025.05.11.19.10.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 May 2025 19:10:23 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 2/2] json-writer: describe the usage of jw_* functions
Date: Sun, 11 May 2025 23:09:35 -0300
Message-Id: <20250512020935.73140-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an overview of the set of functions used for manipulating
json_writers by describing what functions should be used for each
JSON-related task.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 json-writer.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/json-writer.h b/json-writer.h
index aa513e86cb..8b7470af67 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -28,6 +28,34 @@
  * object/array) -or- by building them inline in one pass.  This is a
  * personal style and/or data shape choice.
  *
+ * USAGE:
+ * ======
+ *
+ * - Initialize the json_writer with jw_init.
+ *
+ * - Open an object as the main data structure with jw_object_begin.
+ *   Append a key-value pair to it using the jw_object_<type> functions.
+ *   Conclude with jw_end.
+ *
+ * - Alternatively, open an array as the main data structure with
+ *   jw_array_begin. Append a value to it using the jw_array_<type>
+ *   functions. Conclude with jw_end.
+ *
+ * - Append a new, unterminated array or object to the current
+ *   object using the jw_object_inline_begin_{array, object} functions.
+ *   Similarly, append a new, unterminated array or object to
+ *   the current array using the jw_array_inline_begin_{array, object}
+ *   functions.
+ *
+ * - Append other json_writer as a value to the current array or object
+ *   using the jw_{array, object}_sub_jw functions.
+ *
+ * - Extend the current array with an null-terminated array of strings
+ *   by using jw_array_argv or with a fixed number of elements of a
+ *   array of string by using jw_array_argc_argv.
+ *
+ * - Relase the json_writer after using it by calling jw_release.
+ *
  * See t/helper/test-json-writer.c for various usage examples.
  *
  * LIMITATIONS:
-- 
2.39.5 (Apple Git-154)

