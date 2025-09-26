Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFEA286D53
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871561; cv=none; b=OLeh91h/RQ/folDHKMPSN9OTahl7MzKEaoEQAl4/EuRRyv94Yoee6KGec4dEFH3Pjl8Ex0gJ4TsLyqC36ZOvmHAHHIBSqlYlmT8Z0gkQkFvwndAdJWE/Yza4AbZ2+z8Z56u7z9q990FX0lf5EWkiegXo3RoIqrHfhu/TXl/2xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871561; c=relaxed/simple;
	bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsMmy+lCIygHZnYJcT4YA7MD1nBxkpgolsT5Fq30xz4zQ9ot9P8mPWqcmezGFB8LcNL7AYIRzzZNBljG1Ice0CsgjEL9JhYdIsSIwncBuTVBG1gfSdMvHzYAgx64hRhoHNbG4t+gdBm544i6fK1jm3zoTdvUXeWzACwL49hqBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqhQrUGF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqhQrUGF"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07d4d24d09so349942166b.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871558; x=1759476358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=MqhQrUGF5Ybf46ufs+ZjkB639sAJAanQLQbz2JN4K05g9uKTKnXI7wk/OIUsKtPlTJ
         TCZmI38kL8Yy93q82LpABilWN+aQP62oirWV2UIC7BrdPwubSOHJ2/hYEGHMEtIznIij
         UacZJz5jhm3gMdn6HYTyCst8by7ny5pTsioJ2uz+tknL6Km+P3/jG4oKa9TrfPWEX8gf
         XMt5MLVeyd/SxgGMRXbA8OtbnPBxPUDRL25QyPJ0sfphxh5lQy1Ky8yaIy5G+E5nQcPr
         GLqDqE+fVBALK7dx5S5bRNLkauPTGJdrR3eUUUQPWPOR1JcZr25bS/PRQVKUSYA2aj9j
         cG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871558; x=1759476358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=r/CQLkv1FESez9m+vDexI+F4GHEr0r9q89xhV1RXejhtBCJ1czVTvnXl5ZXW3sZx4i
         4Zk1ypIxMPKS/S7yjzgMpu91FGmvIt2cpD8cNFkA0wx/GD2CyYLyiZ99gYcbOHxLOx4N
         B4tzRrGmlL20UUuzUJYjjw+TzwI2KlNS9Feceoy24nQK4VWTvMxGTsutLVTZPmg6aKdK
         ++Q4qS3lvGEY/4yn3Vzv0npUhE1hcj6GjmhwdL+WufkQ0qLTZoUMm07AOVBpH+pJ5k5w
         JwpOfFBpFnu0I60B7If2OSm5W175Y6OZRd+9gPaQeoFm8IfzzKUqmx7bu59uKp8A6NRn
         U0lw==
X-Gm-Message-State: AOJu0YwvsyuX1ZbT/QUFKM/J+eOovcjyTficdw/2VxUI/fDh6UpX6gnD
	/0JVca7OEmL6BZUa2fZD3o68HV+V8AFEwCn4AYov66RnNhXJj3jQd2c9
X-Gm-Gg: ASbGncvaKeQhNPbqy3XTa6QbYZGlmiv1RZp52Ue3jVOAeC7Ca0VWECU+KHGRKzOZbhS
	piblKbTpQIkKWSSdGGPcA2wCjO535zKybyh5g2t6040K1+K7L95ITNh0qnj1voR8OFyNWcmvebC
	O1h6mfqJ0dQhhXRygQAHhhZ7fSaJwFErtHBHI1WPfMXvhPWXtD8UkJFqW3pCcXgGdIT4D5lghvr
	vd6QWk45CmTRDWQZf51NcU5vzLU/8hn8O8Ivy7o+usw6JZGix7OUKJe1+f/e9zXXjaxe1+hSlWx
	8bJ44cV6JmTOdmQwNvLuz+KK9RBBt43Oe7xnDE4UiucyE8O4KOX0X80cHnds+8vb3ehUSb6SBDb
	V7X3QsK5Lh4efUCz2Lamgzv5O0ycH
X-Google-Smtp-Source: AGHT+IFQPsvG/7YpMQcQ4YCPq4av+8rlg6eDUYgdIwSgc056RGdEg+HwH0K9OxCrRbl/Bn/CjY0KTQ==
X-Received: by 2002:a17:907:3d56:b0:b2b:c145:ab8d with SMTP id a640c23a62f3a-b34ba639af9mr658094266b.24.1758871557629;
        Fri, 26 Sep 2025 00:25:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:47 +0200
Subject: [PATCH v4 4/7] Documentation/fsck-msgids: remove duplicate msg id
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-4-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWQACwYeZx5sab7FV0HDdtOQ1mbLi/BHhnY
 oIPcuszXsiIzYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1kAAAAoJED7VnySO
 Rox/HmcL/RsHY5VVNWkVCLC7oypIFfoFgRFvEQHTlVB1fFKutZ9WCO+yEFk2ddF3TDL8F2c7nyg
 rtLtwZp3JVjvoQ4Rj4+nQKO5F6vYKv2aGoC4GzZDH2+rY22OMOCM2h4Nkg1sfFkZ6UH9RRXTkxn
 A/Rtiv4+4pxxZpV2DvGhWcWoCIYBGiDy7Wyc9xQa73H1+QGd99YayQwmP4xLR9sdLUhqzRohrk8
 8tq6gaAXEDCMIJfgmRmjkbt3HLQ6laafGJctatUWStZcrwjYuugcmx0ztjjumjfOP3yP55a/eTH
 MchYZxnfVIj5za71OYJz21eqhk9VfaVJX5KVJ07NzECdICzbmKnuXAI5R8seBy4vIh9dIIjf2Pk
 Z5ymOR+Z38+MOWZ1pmcVFfngEPiu4gTeuzBiJG8sGlRk/56ofXBTCyvh8LL2lTUFi8EC8qzMVwx
 WKp+8rpdp6EjCa/5/EwB+4yzeckc9QNm9lloUA5H6Pb8Qce1+/lJ2klAMlWxYKCXPiG6Oy8NKy5
 Pk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `gitmodulesLarge` is repeated twice. Remove the second duplicate.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..1c912615f9 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -104,9 +104,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 

-- 
2.51.0

