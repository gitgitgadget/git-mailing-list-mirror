Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31351990D1
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478277; cv=none; b=bOD0ekADn0ao3to/64Z5cs68z8ZoGsh9+8NuFJjkjxtRyq/2L3m4UsgZP5kUvHhW0/Bw5z1760rz7LHEa0V5VZr6oeva5XE28qceoks512UsCykOqtzHOFra6C9MujTVtbr2CaXLctpPNgfq1lhHzNH3YieVzNrv7+W4XQHYBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478277; c=relaxed/simple;
	bh=LJH0cXYbFTonO9Zu+PA1/nKmbt4HEXQbpqw2DhqCR6M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKO6ylFs9LG88QRzSC1Ku63I7g//9WvNN5uVlYECAjyC2c9Eb852n3R0vaBUXlpufR1rG9brPpEZstIEzHuWsNw+JcwOHW6YqvmQhFDmJmGAx+BlztVYcRnBkhaJShIlD/QT0VQMB/OtOjPeICvOeJTEJA+Ub5wrImP2m32geCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2f9MUsE; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2f9MUsE"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso529241.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478274; x=1729083074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqup1YDOyJ4x3b28qxI/cCxkTLBX+87HPrp73Yp1XCE=;
        b=T2f9MUsEl5s9HQHiy1Qn4nmUG2oJrRABLkvdtsxuzO74gbWigd4fy/YWubDYygh+Pl
         YJwfzp5dnWmtgKWxvt4AKv6YzJwumEPja0eoBfZTbDU/MUPErndKcm9muToAzRIyQqti
         D4OmWjYF2MKrdUEw9hCPuwtkHly7bCClL+kn1UI1zvC8jx4LCfWjcNDRf0r+C0R/JCoN
         m/B/+oXE6MoHni9a5Vy30FOp4Fpp5sbKgSB6y0rNFv8SHtxVTGQynsRbbtqBXDgw6mnz
         xZ+oecqebFtWYtk2XZW1N3oFHoVyaIRKPJg0vYY3xiS+5PahTu/Dkf9vjEzppzbZHKDS
         VnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478274; x=1729083074;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqup1YDOyJ4x3b28qxI/cCxkTLBX+87HPrp73Yp1XCE=;
        b=Wc/MzhB1HRxIq18Vh93Gf84yBRjwm0rLTBPAw6DzXxQtmadmMtowpqZe/n813B9Jg6
         +keJR46pRM8Y4kroOm2OMlhcc3bmQHC+7mialbV6v5eHUFrVNUG1Udh3snninoZaRAXA
         FDLdUsvfLlOVQgI2vSB9hNvb7PEVH7B8VB+ruBA/ZPBM0zVtnU639T9/H4Jige65CoRu
         Tdp/66PlwIvIEUKzL1ZxY4tDgxhgBs8PKMYOXCAz1BtPud4irgXjUgBFZskfHXbk1sZ7
         1l5kXsKIBS9W656klNtNlKFjIzgtJoj4mV35sf7NBXgkGqlwCfH5+onnQSF0jqYz/1/2
         rhZA==
X-Gm-Message-State: AOJu0YyIzPdmANhZtub7EmnC6roe8ErZ8nyIhn0T10nfAgkoPiYUzM4u
	Ehhpau1X67D2UmQkNnnJSpfTPxenZNtk0yXX83LZ5qI1hzYFsD7zDFKor31WvDSJjeRbknKM7gM
	E3DGlGfsr2PLxIfFnIEPwuKowx1zIcyAs
X-Google-Smtp-Source: AGHT+IHICevJA7Vv2HzdELO9FtHTrFMNL+uFuVov2hNbntkhj8EwetZbRbUaykFIiCioSbVe62gWE4/6BNke92uB19k=
X-Received: by 2002:a05:6102:a4e:b0:4a3:c4cc:7095 with SMTP id
 ada2fe7eead31-4a448d7bc2cmr2739332137.15.1728478273610; Wed, 09 Oct 2024
 05:51:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 05:51:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009125109.24422-1-karthik.188@gmail.com>
References: <20241009125109.24422-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 05:51:13 -0700
Message-ID: <CAOLa=ZQrCxU_tUcFsrAjTxq2ufCNk=zox-fsa_KMenyCJr5gUg@mail.gmail.com>
Subject: [PATCH 1/3] clang-format: don't enforce the column limit
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The current value for the column limit is set to 80. While this is as
expected, we often prefer readability over this strict limit. This means
it is common to find code which extends over 80 characters. So let's
change the column limit to be 0 instead. This ensures that the formatter
doesn't complain about code strictly not following the column limit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 41969eca4b..38910a3a53 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,11 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+
+# While we recommend keeping column limit to 80, we don't want to
+# enforce it as we generally are more lenient with this rule and
+# prefer to prioritize readability.
+ColumnLimit: 0

 # C Language specifics
 Language: Cpp
-- 
2.46.2
