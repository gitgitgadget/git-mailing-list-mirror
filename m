Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1D1E9904
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865648; cv=none; b=cwNRCbg2v1hA+XBcXWJlWPKqQrfuhpUj7XdNuEEQxWXYrOo8tBfRQMsHaEgBz8OkBFpwvPnDenGI+9hgrn/f68EBCZYAioFgiOHXf6VfTWSBg2pO8azjR6+pd3jIJihiuPYhs5OjrjhvvW8bE2u75f+Dw6VASYdPadqm3EL6O3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865648; c=relaxed/simple;
	bh=Rrwwea3bc3Uf5j4WAMLA2Zh4c4SXs8yrSaq4gG5c5Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKMGX3yvTdFivOXeeIq4KcuynHrfw82CjuwgATwE3Wp/0CZ67isVawAFdE5bZPYibBcUzQVU0FJIBrXXSkbeA+Q5/KjlCy37lARgSwe3G3HrsR96KGRKx+IrWq8xQPQuJMA045rDMOR5uXR6ozzYo5WcFBI5IwXtvbIV/HEt7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJqq2KUg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJqq2KUg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390effd3e85so1825126f8f.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865645; x=1741470445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHVTwt8xqBKWjUuDEEuRV045NoLIJDOfZRpRkG6vKZQ=;
        b=XJqq2KUgs0zcomFtMSDWdRtQcU6jTAkaRQ2P2TKuXHDHGCu0oU+2zOjTbcVuGMLKXf
         QfMog4FuEgbDQ5dqq2zesmQfjtrqFozUUv4UnHYoGE86ellsTm1zucBJIgq1RFjECZyO
         l5LXtsRuV7JPzZyO3pQNMJVmWlvG2+qaaHyDuah1/vTdphAuWfy6kAvvqN8RAwx6p78z
         YC7SV2wuVLayE9t9Dlv4btAiQdBFv3TB2ItGQLkQ11xZ4Ht8FB97DQ2y2c5F3zxXeC+T
         VG0A8soFj91MR0B6I293M/9W6oQhZGcgPg0ux/9SO8WjiOGOgbftUTBmILdgxkYiyDRC
         zJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865645; x=1741470445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHVTwt8xqBKWjUuDEEuRV045NoLIJDOfZRpRkG6vKZQ=;
        b=ID4yWp6sACVUHBbSKu55gaBsDC61VCR5C1Uee4RYdLivmoaW25hN0XtoKEXhHZPsEB
         eX3aijsnPIeiNjNowe4U8t1/Wm0Y8Lesci3+9VgwG3t4093hP53E+GPz1za6p8GImDGj
         T8nxkpkCg8+2/uN848rVZu8+z4Y9jQ/AcA6+78v4BJ8YJYCrNw+xQdoHmuM593kmEv0d
         yHCUx0OKJGA3iY8XGgxKHYpZTkuR1SgO75vweCwREgOgqAtAb/qMnVYRl4gY3q8w8GQN
         tORkd80TDGyMwJ9QJnB+lZtVKF6WqAatQymt6hMe93k7LqBVsvsBlEh3dc4QP9qn+uNs
         qkJg==
X-Gm-Message-State: AOJu0YwH31TMALzWhZ8ML4e3hKFjRS6ZqqelfS6gNdK9KM6GKwv7YNAp
	5ZofshVQ4OkYK75g7PoNzALPeq3+mJ6MXgHLlp09sfnLOmNdwfCpy0rEaeGu
X-Gm-Gg: ASbGncsO6DtqD02Pzapu7E/ROlklKNI8kRSybPs0S6zGAph5LXM/NnVaWYr175WGE+n
	7FHd69zq5ShcPLw66knKuxVcTTo2ypHBJDi3RpPkpEErZ2gxwH3cVn2ksMvxj7Fsp09iZGLdsl5
	Mx2+gpjLwN3hFNLh43O9XB5Onktirzh01tDq+3SLpoeTHTiug35+ZcRpuVxV7Bq2HYD4sqwXTEP
	zQ5ZH/UdgHnhtnRqeY3QOSBeAFiLie2TYzrKlcOpqr6Eit4+VlHNQ8CRuHDqtWnYVEYM+vbLj2p
	Y7lOBYMTea85jKFketWCa/C+xg94Yy3lwf1AVc+aqpbVagfyxANbQFDeSMqYAyLH7+JQM9r4YPZ
	sq9Nf
X-Google-Smtp-Source: AGHT+IHtogQCRzC91VurAExjo6FtIGXsj0tH3+MqKutSNA7sUtU6593HIBx8Hu9rHVbwyRSkko72CQ==
X-Received: by 2002:a05:6000:1848:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-390ed05acf2mr5946169f8f.5.1740865644612;
        Sat, 01 Mar 2025 13:47:24 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:23 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 2/7] builtin/blame: Add blame.format config option
Date: Sat,  1 Mar 2025 21:45:01 +0000
Message-ID: <20250301214652.536439-3-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Source the format string from the user's configuration for convenience,
in place of the "-F" option.

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 builtin/blame.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 437ac8bd73..891ac017f7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -772,6 +772,11 @@ static int git_blame_config(const char *var, const char *value,
 		}
 	}
 
+	if (!strcmp(var, "blame.format")) {
+		git_config_string(&format, var, value);
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 	if (userdiff_config(var, value) < 0)
-- 
2.43.0

