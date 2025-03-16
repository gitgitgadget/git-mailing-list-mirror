Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA814F102
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742101787; cv=none; b=LU/Ijma3roQD5cQUaAeDcHrUOgovqQoQT2V6kSGxCPjtdAmp2JSGmMdrxYDm9A2LtV6IIKRm6QeEaNvQt316qF6p0AzHzYcFRKXzGNubrj9x2VJgYXKTc0MGOQ9dia/wCnSf6DE9f4mLHaydodfwYKcetMduBquU3YjSe7VoMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742101787; c=relaxed/simple;
	bh=6ERi2DjVXBTZ2mV8oTTpm8eRGn543RDMfGmxQtftu3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFkrCrXIO1dOo2RpUGBPy0pLh9wN4AraJc0i7xlrQphvAHGRLybMw7aUt4usDMjyG03PQxID4W51t+kFIDMWWL/nKJ6LkpRWF++9DoE2SdwMCbsictuBWQzkgDFvzf+K1gBbEUvsGFx/ckE3Ij5KWvLx8krG1oEYHJFefnjHpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3M8MPTc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3M8MPTc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so9287715ad.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742101785; x=1742706585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyarXf1lc5SQfULRi3R/DqI7JF48ZlHH2ECLvpSyPAo=;
        b=Q3M8MPTcPqpoZ5afXVdq/0ogNvi+V1bbp1a2NN3bzMsp1KRbkkEGVC8apCurXbLr4G
         R6KPGh8aR77WqLPi0LRziDydVal1iivtdGWzmnEjMyG42BOIAUiwifGpnfjcp+osUnXw
         mRz6sx1GKk0sowO/Z2N1YxyuK0V6Fq65Vyjzsc3JNzM0jRzv//o0xgmZgfMEn/573oYW
         GJGAi2q8XL/0FRriN+ZlkaI1xokP4v3M99gkNDa70LuG7lcqJQRlzhVCZn+auXYw3afy
         SysQOGm0at9I4dkGzba3LZcRfJqMCVooZfnCS4b+d+OgJe8wha6yTEttvOAaTTxratuG
         N6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742101785; x=1742706585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyarXf1lc5SQfULRi3R/DqI7JF48ZlHH2ECLvpSyPAo=;
        b=AWrT3IOm1kIsbcKlVg+pECbe4X2fpyKbN+XSG5a9v7vBsHAFchhgOWSYcNeKWQ0MYq
         BIzsVGbz03j3e0mf7SMIk3LRyzZ3dKwGFfC/gkkpEQlSez/xc5feaXIdWDHbJImKtJYV
         n9q584jyiGn+VbDT4OuGoMX/EpJSm4k+BZ4xfFqajQ0ZrMJ/lkOHURkraYy/lmI1Hk51
         DfNkcIyC+Tbdq1qcA5ZGD9gDptOZIYguAJwhRUqIf0MZGualU++21OLpUN4VWY2Z1sVu
         kaNVw99G59wSlpy/1NwIUyTFI1PMAd/Vkb3ezHKV0KtvFh6OJiAQRrd6zW/qQHRrIz9t
         4OZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKqwH9+mew4GyYbaHytCw/iLAkYhaFEMOBeVuTSH7CVX9kkKLvXBCKzG3y+k9QFdiEi0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RK30PhQt3cBRvuMgsk7Kl3INVFZ8kqv6ggFU3U9wjNsaiEDa
	77lUZ0w5+CJRkIwCsgfDLnRA3tuQytpxSf5HceBL0yS6nHcn6uy1lrYv4qAS
X-Gm-Gg: ASbGnctWSqAJiuMBH1VGpGDKYjxK7OcT6KYh/von3iNp2YIO0RTuY0befGkDHARIBus
	ZE0Vg1by+7WuOshfE4A4pfr5DtGpxUGbeTnpp19P6pWQR1GQ4xoKpkDgAkvv2T1sqYx5PM7R9MS
	ELH0j5XeJqHcp3onn//Pzw16JIDysLdaGLuOq8WaNV7Rhq4IdBxewa4fSijaC1ciueJcOsAz6Bd
	kpbs0lF4LjcNfxrMThJ6h3QA6pmUlBHTnD3kFIaQpUZL/orUeOT31dhNytsdKfrO2iqJ4lOaS1A
	0JHHH/nHsgMM1B3kCS/H4+4Se3V9CYTTtDNzqxd9oxgvcYr4tqA9
X-Google-Smtp-Source: AGHT+IFFP8Hn47/WEVjZ7KyyGPANhzwb6Jt53ae1CM0fxxIsPug6oouQWtqNSN2zZf8UyIvxGpF/UQ==
X-Received: by 2002:a05:6a00:806:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-73722397d67mr8929065b3a.10.1742101784840;
        Sat, 15 Mar 2025 22:09:44 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511cfsm5216002b3a.45.2025.03.15.22.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 22:09:44 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: gitster@pobox.com
Cc: 05zyt30@gmail.com,
	git@vger.kernel.org,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v4 2/2] Error handling for SMTP status codes
Date: Sun, 16 Mar 2025 13:09:20 +0800
Message-ID: <20250316050920.3264895-3-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316050920.3264895-1-05ZYT30@gmail.com>
References: <xmqqsengn1ms.fsf@gitster.g>
 <20250316050920.3264895-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change further parses and processes the captured exception information
based on the previous patch's unified error capture. Specifically, a
three-digit status code is extracted from the error information through a
regular expression, and judged according to the definition of RFC 5321:

- If the status code starts with "4" (temporary error), only a warning is
printed and success (1) is returned to allow subsequent retries;

- If the status code starts with "5" (permanent error), a warning is
printed and failure (0) is returned;

- If the status code is not recognized in the error, it is considered a
permanent error, and an unknown error message is printed and failure is
returned.

In the absence of an error, the authentication result is still returned
according to the original logic. This change makes SMTP authentication
error handling more refined,

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8feb43e9f7..69ba328653 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1454,9 +1454,30 @@ sub smtp_auth_maybe {
 			$error = $@ || 'Unknown error';
 		};

-		# NOTE: SMTP status code handling will be added in a subsequent commit
-		return $result ? 1 : 0;
-	}
+		# check if an error was captured
+		if ($error) {
+			# parse SMTP status code from error message in:
+			# https://www.rfc-editor.org/rfc/rfc5321.html
+			if ($error =~ /\b(\d{3})\b/) {
+				my $status_code = $1;
+				if ($status_code =~ /^4/) {
+					# 4yz: Transient Negative Completion reply
+					warn "SMTP temporary error (status code $status_code): $error";
+					return 1;
+				} elsif ($status_code =~ /^5/) {
+					# 5yz: Permanent Negative Completion reply
+					warn "SMTP permanent error (status code $status_code): $error";
+					return 0;
+				}
+				# if no recognized status code is found, treat as permanent error
+				warn "SMTP unknown error: $error";
+				return 0;
+			}
+			return $result ? 1 : 0;
+		} else {
+			return $result ? 1 : 0;
+		}
+}

 sub ssl_verify_params {
 	eval {
--
2.48.1
