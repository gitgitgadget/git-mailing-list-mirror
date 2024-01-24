Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED04168AC
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078891; cv=none; b=XIgZ/gFjeY4OkVVYHI7BpvAIkbOEeDwY+DUHlFhF2hdZcp7jHz+IPoDawXBaqYYHXpYvMh75cPDdLg/pLPY3tLUzpOKJNnIQGpRt8AtVjltvDtmhqSFgZwFW4BT1jAipNYyKp8QLUXOIuxcjs4A7Ac229RhOgyH41Wan02TN8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078891; c=relaxed/simple;
	bh=/eMyJNQksJ+WwLooeMaKwdts/3lIg2fvIcP1hG39W3c=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gaxmWwWQ3KTrJrLIOK9V6d9lR4yoWei9dnxrHLkeA8ejChE3bHg5eboXm2lXil0+An5I5mMeGGssNW/6oGh7sT99B7kvpXmzKiTG9FPo4xYIrgcFTn6lTE0oOE74nog/3a8P8blsVB/bDbB4LXxoj3ZZI4rw4g8p4iK8rp/xNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeCZZWuY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeCZZWuY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337d58942c9so5371316f8f.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706078888; x=1706683688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaFF2W0gFQ6nyUPlu2dOTdZeGaTFx/6zN0tIlmo2TYY=;
        b=UeCZZWuYD9yYZBYrth9hOjO0BXnNgScNdT0e9Y0nSGzdprqba3ZM/RAdHgh2VS9+8a
         glcOx2ejsSo7EVTQHqPeLC65BqZa0yPWi7HjSR6n+IAoerEDZw8yug9uwz4ED6QlKNOU
         UfwdfIpC10TOPqf7LUwz4i8/dBchjqrA8PUuLopB7Cw1qHTFZ1cCDnagtjTj8yELDls0
         9jkNt3UHr5It+C9yiJfDCN5rdJFFlJnO1SVt1CgP9c38UBbOetPWNqm2UcSALsKIs97j
         qPMDnWBHbeUSP8WsAayv/pTZYdlCMgiyW2sm9ZB4M77X+5zq2barHa4IAcLdim4881TL
         kq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706078888; x=1706683688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaFF2W0gFQ6nyUPlu2dOTdZeGaTFx/6zN0tIlmo2TYY=;
        b=oZiFIycT5WJUqbvM3aCdtlsPjFTOL8/Gm6fvZuZqUPOR2vlAEQv3HRJjiz02vnkRr3
         cjVcRF+/a/qOJKRZIskmpHwNdEQAETzxSuFkmaD8TgTUlnN4C92+q39V9JDOSOPWtiSL
         YyVdvEmgSHsNq9Di7OFCrPRKiNi1HbylfFKs4DDLOL8GzzFPrRimsMjzXflPu1M0xVT7
         SZiEFm1rJAD0K3ai/uMTJmtWdsDafEkHsCgpAAhi/HDt+Ys0qTLcBQHR5QErBkJAnrvQ
         SfmiRxcopTmMJT+89h2KLb1AHbknxM+iyUAsnxN7lSyFnAYB7QUreTYfl2WShDA2yYJS
         5CbA==
X-Gm-Message-State: AOJu0YyMc2hjhmXOoVyMEpnMYYaSUeBv9AuqWTn0ygn4vw7+h3uHkBfW
	C5slKX5gwwPbjJudDvmd65sR7tXSyBA0Yc6eG6pe0kkroHX1hVNpfjaJQo7l
X-Google-Smtp-Source: AGHT+IEvf8UtFUeYY2M1NdrV/qnmJU5f3y/aT3TYiYguD+7m4333jpju5/3mPxu8ZtR/gDlB9jQnGA==
X-Received: by 2002:a05:600c:1c05:b0:40e:71e3:139d with SMTP id j5-20020a05600c1c0500b0040e71e3139dmr802661wms.154.1706078887787;
        Tue, 23 Jan 2024 22:48:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4f06000000b0033930068ca8sm8129462wru.21.2024.01.23.22.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:48:06 -0800 (PST)
Message-ID: <0e117198d0144fa4ee6ccf01ec31a099eaf8121c.1706078885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
References: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
	<pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:48:05 +0000
Subject: [PATCH v3 2/2] patch-id: replace `atoi()` with `strtol_i_updated()`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

The change is made to improve the error-handling capabilities
during the conversion of string representations to integers.
The `strtol_i_updated(` function offers a more robust mechanism for
converting strings to integers by providing enhanced error
detection. Unlike `atoi(`, `strtol_i_updated(` allows the code to
differentiate between a valid conversion and an invalid one,
offering better resilience against potential issues such as
reading hunk header of a corrupted patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/patch-id.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b9706..2c00d45cb2c 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -29,14 +30,18 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 {
 	static const char digits[] = "0123456789";
 	const char *q, *r;
+	char *endp;
 	int n;
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
-		*p_before = atoi(q);
+		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
+			return 0;
 		n = strspn(q, digits);
+		if (endp != q + n)
+			return 0;
 	} else {
 		*p_before = 1;
 	}
@@ -48,8 +53,11 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
-		*p_after = atoi(r);
+		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
+			return 0;
 		n = strspn(r, digits);
+		if (endp != q + n)
+			return 0;
 	} else {
 		*p_after = 1;
 	}
-- 
gitgitgadget
