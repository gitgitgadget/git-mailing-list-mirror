Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBC153BE8
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817898; cv=none; b=AX7zeCUZhFjEx+H7JoIv+z016FfP0GJ8d3jWXyXpy+sb4mIeHz0F1v2L5oELcKZh7NW5lssT/hqZAPIhZAcrBvPMcy90M52+3JUTMO7uHUPHW9jBF65tJrEvWKk2L99C1oYw6RFlrAsFeRWeUFY/CugXmN1S2OUZF1ElTSEgF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817898; c=relaxed/simple;
	bh=Xb4Oh02eUQY2WOblaYYgsytwBHgtxm+XFssS+c+TJzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg3JaTkiPcMl+TCVN6HV+JzLaoljj36KmN+9nzxtpTPMjKIiUR0mpFMJIvYZoxbMv4dMeMqCBCR9IiwHC/uVMZtuL01VMX20iDoYPJnQIj2mmXOnH14rhKSoH7fZpuGzFHJiP1fiEUtOB8POzJDYc+FmNHm4nUE2EQ60Y1B+ZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAo+fewq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAo+fewq"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc681ee0so3219596b6e.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718817896; x=1719422696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A3sk9lITjXshu2VtwQxj/eXexcG7SU2UmH3MJCsyaU=;
        b=EAo+fewq0722dJguruOTmkxp0vjLBMrBIo3VTBQTJur/CgswkPWLXSLgZ180p3FhKe
         bGvnh6m6K1bvrymt/1CnOm75kNkkiKRroYQ2jl8LChVooNq3fA6nrNJao0j52do1bMUk
         UpQt0WaSevb061ti+R1NIRtZRKk/X9K4GVIamt4u4Be+eibYzaxRzfJEUzbLDbd3OiZX
         4fGfcnS2MLabY1JuFKLU7QWUdzbVHoGUxFA9d8zmLUf2TKv7JpZEE3fIWMKJyDPAYQzm
         tvLVuF775R7rEo0/1EzSK7I9wI258aAssoHusFuFlxltW09kC7J5d2Lqw7PIEip+vfS7
         wcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718817896; x=1719422696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A3sk9lITjXshu2VtwQxj/eXexcG7SU2UmH3MJCsyaU=;
        b=GgCzqSlKegLuQZvubpkNohxzOc1vSdUdM+mI/OCgbhCiSamQO2N1nu1zCNit9Puutq
         G26Sc6UaLsNyaz55s3uG6XR6nu7OEKariXDJ1jQoK44MQdn/bRZFXIBBYB5MW+tyzABa
         oNH/6daT+W6TYWRYKmyQohQHiY7NDDSEWhKr2RbIc2UkqUd7Q13NtOE2FWWGZz/uCDw6
         4eKOVDT3Wzbvvr/qdrDyij/5WDcvyN5N4vnuA1Hy5shoAEkUQDnlXYQIe4DoR2RsbCCd
         UZNdoGM/oRzUcNILPHrZO72AM7XBJVqw1LGWSCl1cZ9Cw4rvdX3uOB/W785U9BtXcCCQ
         164Q==
X-Gm-Message-State: AOJu0YyDTOMtlPFj7yM7YkRYY//P+vqF1UMSDBil/din7cggbVIwIu10
	MOdWP9HdKDlESl375wklqqErZiD07D0opKhs6vKz4s7OPbUA5Ot2ekeEsA==
X-Google-Smtp-Source: AGHT+IHBtHVZ370EWAwXAI3QaWZHW44R8SvfO0oOnt7YHSB7hK8s+Q+8pvH0Zb7PfJ+jd0izL2vXoA==
X-Received: by 2002:a05:6808:1293:b0:3d2:2a9c:8b70 with SMTP id 5614622812f47-3d51b9b4a55mr4130778b6e.15.1718817896500;
        Wed, 19 Jun 2024 10:24:56 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:3da2:1b6a:eaa9:b88f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fd334bsm66683371cf.69.2024.06.19.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:24:56 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Date: Wed, 19 Jun 2024 13:24:21 -0400
Message-ID: <20240619172421.33548-2-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619172421.33548-1-randall.becker@nexbridge.ca>
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses the OpenSSL supplied OPENSSL_VERSION_TEXT #define supplied
for this purpose by that project. If the #define is not present, the version
is not reported.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 help.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/help.c b/help.c
index 1d057aa607..ce55aaa2c0 100644
--- a/help.c
+++ b/help.c
@@ -757,6 +757,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
+#if defined OPENSSL_VERSION_TEXT
+		strbuf_addf(buf, "OpenSSL: %s\n", OPENSSL_VERSION_TEXT);
+#endif
 	}
 }
 
-- 
2.43.0

