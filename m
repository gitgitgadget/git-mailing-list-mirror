Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89930AD1A
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498999; cv=none; b=Kvk0EyhLbVm0F/hHnz5n8yr/3Z0vdQjVPDXTQOy2Cmucrx8hO5Z67iIopm0jsAFVhCt+D8fHNigtFoqwqYYiYHRD8TdLmtw1Agr1bqlVRGaOmMW7UdZz1arrWeB3Jz111ULvMwQJpkRlvZDDxjomrXa5X0d5JWEt0aeuHnygEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498999; c=relaxed/simple;
	bh=bHw0nj7CxT8xTJb4OKl8rhNBc3p6jFlop4tpCsn5bus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mezfiRy2zi4LcbPf+qsz4xC01MZkzeMvNMssLA6S/+IHfXlSLAW2CePH2nw6YFc/JZ7EeK2kUtblq4Sjle3dR9Q0BU6wZMl7fY92uGB1yKmBgMb+h/uyET9qyAhXfd/fSly3ONYLcqtWsmxak7r72KMtBQZl6Ym7OEJBfyFt1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1/Pop6V; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1/Pop6V"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ba55660769so4090371b3a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763498996; x=1764103796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajy6a8VQnC3jEx4jK+HfIOLPv2ziX4Y+Pn6sHWSOQwY=;
        b=P1/Pop6Vq8vXfSBRcPFqcmj/gdTEViZ4eI5Q5zW1/l5ffDuLujWisIV9b8t2mH1LQk
         mne073xGY7eJlvDg4s9LWF6sprY/nuISrEYI3CWM6++gpKKusUD2FoK7oOu1OO4cuL2b
         6DGRiiJXIyyGSGJpmPj7Y6RxoBmnI6LAFvCjR6YOwROAK8TbjY/dP1OvUfzDllsLQbq4
         5RwKW/8Adap91QRsj2fK0PHA/7A9vqx/isxVt2D/f92PAzcvSZoN5FIBrjIe0sAFoSNw
         ldanlsizFri4fYvfwYKnOxN19ozLqVBroWJdrQtoDLwT/66LPKxqFfleJ+J7YU2duwb6
         kK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763498996; x=1764103796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ajy6a8VQnC3jEx4jK+HfIOLPv2ziX4Y+Pn6sHWSOQwY=;
        b=SCqTd1cpUzq3prJHEWEqW9v1kt6lSXMMY3tnlN4XUmnlSXaxrm4LKuO3RcvxukH0Y+
         loHkI2GYR5PylK9SCj3+z8ax25zCYBKFaT+CLzIqU8HuvY3myDXGqJkECyPDIjuDCAJ6
         YjHfxC/dQYhTrPhlqZw4d1BAIrHPyVjn03jjpkKpvnOESWR9pS/vnYlZSmeCzXFZudYc
         LGerZOoeXDacNqIl2X353FTa5sUNkkw1oM+fdFZ+tNZMJMDgCwOdVa86XSocsyr/5MCc
         89EkrfEPUWRuxb7wW9Yom9X5YkqZniqMEehpaPF98UNmeeD0tCQZdbgMBG0bv+XDfbRU
         Q86Q==
X-Gm-Message-State: AOJu0YwtSER7EE8ArbyUD7lZBl4bBWYRlyUpWN3o1587pz5+CX13eIuN
	dhED2kuNr0vDERdVg6SCTqSVWZQW9hx/bfPU0RAZU+W+ZIHVxveYggRbxVYjvA==
X-Gm-Gg: ASbGncsPgFWyZG9bAhh83LWldQ59nPG4mkYe3SOzCXoVCfm4SFEk8e3n9mOUmjFbI61
	yQ+MG6vqAtab0Xne1yXliH3XeWloq+gEQyoettbEnI9F4VuahlCR69IqRdNBTG9MKkL0OClA6Nu
	MeTllpeeHMIEcH8JclInhdO5r4kJLe/ByBA1Vt0s6V5sp9iXD/+1I0kl+VciLJ+J8ia4hj3r70+
	nkyQEI6hh3pv5UZQTo/H660Ol+5aPdCb181RL17tr4vsxLYHPeUxz9ziLg49cRQhbK6LpFETOgI
	swHlsTD3bqfmXeg72scy+d+ZM2BdYEBFW9zU66XvyE/ax5eFKUx7tUVjgXEeSbcxgRglTkKZkn4
	D1U5nlVQFqHn2dTIZ0TGexhuVcsfH1TfIFTuUsYnaokJL0Xv92cqbeIM4Tr8Bvl4PrqtczmiG88
	jtpEnylz87/+IcWZVkzIWfPA2reNW+Q8se0S5LhgPYFPfUTuMiKQdqwTVNLbPW/kxz2rwulSK27
	JXrxgVXnGIsEtTx
X-Google-Smtp-Source: AGHT+IFcJ2t85TE4UneQW+xDvhMgCO1PBXm03dmTXFYHIwYKgYzWJWV6zQvvA0ikIegY6gGZDWKPzg==
X-Received: by 2002:a05:7022:e803:b0:11b:9b9f:4283 with SMTP id a92af1059eb24-11b9b9f445dmr4945663c88.24.1763498996284;
        Tue, 18 Nov 2025 12:49:56 -0800 (PST)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm61892214eec.6.2025.11.18.12.49.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Nov 2025 12:49:55 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v5 1/2] repo: factor out field printing to dedicated function
Date: Tue, 18 Nov 2025 17:37:03 -0300
Message-ID: <20251118204929.43597-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118204929.43597-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251118204929.43597-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the field printing in git-repo-info to a new function called
`print_field`, allowing it to be called by functions other than
`print_fields`.

Also change its use of quote_c_style() helper to output directly to
the standard output stream, instead of taking a result in a strbuf
and then printing it outselves.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 9d4749f79b..f9fb418494 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -85,13 +85,29 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value)
+{
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		printf("%s=", key);
+		quote_c_style(value, NULL, stdout, 0);
+		putchar('\n');
+		break;
+	case FORMAT_NUL_TERMINATED:
+		printf("%s\n%s%c", key, value, '\0');
+		break;
+	default:
+		BUG("not a valid output format: %d", format);
+	}
+}
+
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
 			enum output_format format)
 {
 	int ret = 0;
 	struct strbuf valbuf = STRBUF_INIT;
-	struct strbuf quotbuf = STRBUF_INIT;
 
 	for (int i = 0; i < argc; i++) {
 		get_value_fn *get_value;
@@ -105,25 +121,11 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		strbuf_reset(&quotbuf);
-
 		get_value(repo, &valbuf);
-
-		switch (format) {
-		case FORMAT_KEYVALUE:
-			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-			printf("%s=%s\n", key, quotbuf.buf);
-			break;
-		case FORMAT_NUL_TERMINATED:
-			printf("%s\n%s%c", key, valbuf.buf, '\0');
-			break;
-		default:
-			BUG("not a valid output format: %d", format);
-		}
+		print_field(format, key, valbuf.buf);
 	}
 
 	strbuf_release(&valbuf);
-	strbuf_release(&quotbuf);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)

