Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FF2DAFDB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169914; cv=none; b=dziNecXOgWT5o8Sg6JhFOIDBZqs3JG5tdJB5DSCZkGN45BmSJpXoqAvnZUNKKHLtHZYYTY+Gy/CrVGmJeB9n4GDG6tJX9Sn305O61UqWiB4rXZNEqUiHn+zbU39rs9chYFfWJewo0KBhFqg3gGRvbxmqSzHZvE6DNDxlRHnQrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169914; c=relaxed/simple;
	bh=sk0U82/3FavnFIrHJyV/o9nX3WL1xxy2dUr+aRpZzag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXu16fIdOwKTBbTHuDASy8JAqRmfxCzVYpoqxYAeMB0xZUbad2cg3bXsDCpIskNST9qxYJuU51igvtdyC5s9by4JkEbUKQe6DTwIAGiT8hvnX4+Yim5UZ0nsrQnmXuwGDvUrmlV2PyQtRDy1N7g4EZ38waui1O1zQks40kDnwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb8n485Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb8n485Y"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74264d1832eso6559401b3a.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753169911; x=1753774711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZfdG28L4t2BMprclNeK4kINg4VjJmW7A5DUE2OqEws=;
        b=Tb8n485YKAnBda0jbjAOIGZDXG/pJSE+7UfKm2O4VQG8OXQHFcQZ8MtPooAufN2wBL
         UBxYbaf8faKKg2kOBzW7V8IDwq6Z7L+p9t6lB0iy+NTKAMdGeGBXkzNvqHVqNd6s7/8x
         ystJBG0YvIdVLjt7ObH5IgQfDWhwwXNPOB3kOojjZJut4hhw1nGKwTKCygqMO6UYnsRw
         beY/iqWPEwMU6wg5RvFQRyzg0UlhSJ0M8fFA++cH/0TgpBPYfjy19vtZK4kTPHD+IYoz
         IdssddJnxX9Gm1DNthZwvlQksxOHEPAD79bREdTiQuR89DVgwoJhR9kV6f4vBUWDu78i
         R8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169911; x=1753774711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZfdG28L4t2BMprclNeK4kINg4VjJmW7A5DUE2OqEws=;
        b=NnkWLHABJaWJBJKNm4+JONsCGxvbY5v6fZsAziiOnrqnPTKQs1gP+C1j9+iOcHSsaJ
         k5CWE/rsQ651NQ0NdPiT4+dzgslnm3omr9p6hDjZgrWfwopRS3KPtZIVLAj/OAPNyfIx
         zikv5pyVdCI3/xOGDSWeZqpBfsC/w25JizrrlyHvWDT+LgZFA3PIIuo9XyDPKCFavrku
         DoCEgP4Zr7ENxg/GO7177Q6HcfvOUSpVEgWKAxF7d9cMgDMejTPokju+3xWdhtgwZ/3k
         E5BtEtOxFM+iZAY9jEHYFC7I4CsxQgKin7Rp9uN3m1ceC/WJrHC7VsIbrsTxSuimC6ei
         3hxw==
X-Gm-Message-State: AOJu0YzZeely2cEAerTP+cglPmwGWHlLhsNUx8qaYSgEVBzOxOf/3JRR
	/nObHTdRw1kTPNbgEu42tsFBrQ4FKY3AKWMeMMYNVW87IAXQHXkOh4YTxPTwV/3P
X-Gm-Gg: ASbGncsOJXKWB5SNVR1bh0eIbTAr+HbwU1z09JIneDgTmHzNvj5PDb4/2SSDQVVM2N7
	fpWL0rrEc+D+VcOtfaiGbsPDF/NM6lRIuLD1NSkbJ5i8mMU+W0QILyiYfkaiRdfNTBkNGQRWrmT
	a5WL2ckWruMzU0xs/6Pin2h+v3dOlNk24HT3YADEaYU+eRQps/GK6OzfSoarDnsOctQSuDO9Pa6
	HaBqQ7YQmpgPMk6zcqU90dC7s2aE9zxNdryknTbJw9R7xOGx+j/PhXEwh0nJbdGzMQzYybF3x+T
	JFeOwomopQi8h/B+KVlUZ+G7k/Vy1A0Og+XtzPI0ggCRBol8742A1APvnrcKXpKwb50YyREGuJ5
	QnxtTh20YmXnDFjf/dqX66rB8waJmBZQT5Q==
X-Google-Smtp-Source: AGHT+IGjDHj4nV4a/ZiusN97yT4pYCdwZr9FHW27eEEE9UDDR2mVKIVAEz3toEJN7Ml2UajHm4+ZoA==
X-Received: by 2002:a05:6a20:9392:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-23810d55d86mr38313793637.7.1753169911530;
        Tue, 22 Jul 2025 00:38:31 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm6393713a12.32.2025.07.22.00.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:38:31 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH 1/4] t/helper/test-truncate: close file descriptor after truncation
Date: Tue, 22 Jul 2025 07:36:31 +0000
Message-Id: <20250722073634.1080217-2-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722073634.1080217-1-lhywkd22@gmail.com>
References: <20250722073634.1080217-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a resource leak where the file descriptor was not closed after
truncating a file in t/helper/test-truncate.c.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-truncate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/helper/test-truncate.c b/t/helper/test-truncate.c
index 3931deaec7..104bc36cc0 100644
--- a/t/helper/test-truncate.c
+++ b/t/helper/test-truncate.c
@@ -21,5 +21,8 @@ int cmd__truncate(int argc, const char **argv)
 
 	if (ftruncate(fd, (off_t) sz) < 0)
 		die_errno("failed to truncate file");
+	
+	close(fd);
+
 	return 0;
 }
-- 
2.34.1

