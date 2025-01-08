Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08281FFC55
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361481; cv=none; b=fZXfdtT0y0dNwPnG+tdZkdBdt79I78y04cm7kiQGFXKFUnXJbFuWyenyvO3eV8w0cH6bgwX6jQ0lhzT9wF3CI+SnIVIFvMYMeFS26Q/c00WHtNmaSyjqSqv9dwxhtz4GoXzc0L/zpRL4VOHHh/8Xg8V8Z7Vpyb+P8B4y82mdMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361481; c=relaxed/simple;
	bh=vgTuS8o56AKp5VzJUizsWjJ9OmeEG1Tdy/sYeNbaRME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK6F36hKm7tnASIWZZsbKOyZY+Dha0MScWqjAUfv7MbVskFbXAC+XUFhtoGuKScMre9+0xPhOZoj+5SrzpYZ5Yw+1dz91mYs0E+aWwyLa28IvUld82i8rMeP9en/rILsqVCRxzkQlDBfp0lhTUL3Wef2O233hiuG3jrzOdWEAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpRCiDNi; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpRCiDNi"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8e773ad77so933356d6.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361478; x=1736966278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQm4MKMfp3Qk8eTKP3e/CJATv1QEIOwm5F3grdNGwVw=;
        b=cpRCiDNiClfFg5lnDLxPi+jn7X5ixEqBZlHa5If+BXZVEZbyoVxU//8YFp2PzHMdwr
         4UjVnvkODjWpbC5oDOswQqAjT8zeBlZJTDOHgVgLtdcstOAqSaZb1Uq6L5sic7aVKJwJ
         X3COl7f0Sr0Stn/sYPdz7+p/YQcuOoz/eyfxSa51f9raZBMvJsxdUKH/UlwxMgI0xMah
         TYjTsWDw0lQvcAygOtaUp+Bg2Qm3pyyrdWKjFTHGD6zVmMtJm2YejG1tWOrZU5dHCopi
         RQmmEY8Hl78/kDZIoB8mtp0WWc2EH4uZkOglF7hPWeoF2Zkj7u9F6KU5r5LT1DQ6pI07
         VLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361478; x=1736966278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQm4MKMfp3Qk8eTKP3e/CJATv1QEIOwm5F3grdNGwVw=;
        b=Ci3caOfsMhEsZtjg2KLYCB/6E5SDvRTr0tWBFJn+ujCAt9fcMa6iiLxpUcbKOFPNYa
         xco2tsnYuIrJjQ0+CrlPXj9oQJISp5hR2pwV3gAY4MSAXvsMay2DajJL0wkHQZ9MDqE6
         1oUV5cnl5OJXhgCRjEpvOV7R3JE9gOE6FZI4rnt3elygGVe9V1njaFtFR6jCSv7zj/rt
         NuvuJDBvpYwmUqFtZIh14ck5KAjjoEFw8lGTu6mAqffMp5GfucCFKCjRxUlgXHahpQ/L
         EiEP/a6m9gP8v1uJOtU+/BGRBUGdSzyrhb+3RW6/Z6xOjd981jO7pnAL1ompMRmjk0RT
         0Jcg==
X-Gm-Message-State: AOJu0YwHTCBCcLdCRO3JPgXxVRfme6O0EXCiFPygc2A7GH8w1wRaFpSy
	uBnGAeM/ExftMBiFbwPN9uEs9tzXBrPLao1r1kFyYcmb7I/IuU/KhpJMD6zKPGI=
X-Gm-Gg: ASbGncueeCEtMPUwqDYwEfDvyK3fJ+6eYd7Xxda4IuAOLdrthCPU2buVe/FGsXMTn4d
	9hMqXHOOZK9ue/yFpwAqSnXekcqr+sqmmD27BNtFukVeK5bGU4cnpPxadqeDmneQek2QeplNrLj
	7wo9FtKvo00IMeZxLSBcT6cHNaKBwvZ1PiIC+dET9WYQIt7KO0fX3KL7JpiFYjow13HTsqW5pfx
	ZOKL/WWAsWRWXb0XSxX83Xf/GnK5l50tjUtoWGiKryipCg8fenDKcN6qwU5wn/Vkm31EwxER1bD
	mIWHgfaN2Q==
X-Google-Smtp-Source: AGHT+IGDY3puPNEGfSxdv8k5uGznUhYnrB/0ryaj/OxHGFISDvUPywOy5Z0PWQNIdlbi1bx3b7QcoA==
X-Received: by 2002:a05:6214:27cc:b0:6d8:9f61:de8c with SMTP id 6a1803df08f44-6df9b24eaeemr63811126d6.27.1736361478391;
        Wed, 08 Jan 2025 10:37:58 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.37.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:37:58 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 1/8] git-compat-util: add strtoul_ul() with error handling
Date: Wed,  8 Jan 2025 13:37:32 -0500
Message-ID: <20250108183740.67022-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have strtoul_ui() and similar functions that provide proper
error handling using strtoul from the standard library. However,
there isn't currently a variant that returns an unsigned long.
This commit introduces strtoul_ul() to address this gap, enabling the
return of an unsigned long with proper error handling.
---
 git-compat-util.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..3bdb085624 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1351,6 +1351,24 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+// Converts a string to an unsigned long using the standard library's strtoul,
+// with additional error handling to ensure robustness.
+static inline int strtoul_ul(char const *s, int base, unsigned long *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s )
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;
-- 
2.47.0

