Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA723BCF4
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024716; cv=none; b=KMZ0CvkeSVfCfuqm+vAUnlh1kjVaVtHrj3gd0HqiDggSpLikxpdcyJ5VEYLNqbkgEJdpf4yzyWP9m4zNSJRsGufCQP/NYtwLrOIVEqfH7inp08NRAcDY7z0JuGFz70YKgAjdK8ZmUgctJhKI5G9I5joA3kJHyQRkwt2h5O1+izg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024716; c=relaxed/simple;
	bh=yFF5Lpjr4xHZWcLMyFgofAAD0ZrbgCf7lKDnG7ls/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAi2z3m1qFY9TYTmMbPXFc6BxfSpNIv+Xevkx8vZ9oK1wJPb+QnLyBth23w0myiX3NcBISSoEG3h4tndDu0y4uW+7rbaLRwN7prS14HGGvyySwvu1VNh4Ir818L60mFWCuILuuZdngXKKPbZPSm6Ou6STbUaMIHtwATSNhN/aLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbZFw2XB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbZFw2XB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so688826166b.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024713; x=1744629513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpTCC4ro5e3S3B4/6+FgFa/Zev8emrtv7xc5Mg5bG7I=;
        b=IbZFw2XBCuBF16ZKzGHozCphWvnbtn8OkqMZVtCfS+qb3cWwXLUq3wi4JGvaTjmYlJ
         o4FmLRkf/K2kuJofG9aSTLZUsEOYQYt8k6xUdr8IrKNeHHh+tw+HAHV1lqS3hHQ2oyFQ
         YHxE6dbZGqdDvdDOpl+1zcpZLgB3YvSJjfjTQnFaoCDCCnmejMoJ0HqBvdrHO0WsyGy7
         x8SAwpi/jz6JZysPzgOS0fC4FUZi+akLkQIDzJ3RtnygE9KguF3Pp51asq2zEztmOHWF
         C41XyH6wN+n+M4Xd9JzD6JOeUH6WlrGtabMW3aKXtFh5p2HKjkDlGb3yxXvy/IottFUC
         FE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024713; x=1744629513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpTCC4ro5e3S3B4/6+FgFa/Zev8emrtv7xc5Mg5bG7I=;
        b=tvyWAzym0Z/wJ5XtjrZusdRWhjGFIA0/rMQQCWb/Cc2JP6Y0rLWzcKoiDB1aXkEHd8
         xaKVWo9KmeWL3x5GoW4OUr9D3ymBzCw6XqrHtiaEmm082NRstCh/9wFHkcc4wpt7chkA
         B0AXauUMnqXquTTdE1ra+xGmWmu6OG47GTwDKUrtjt93MGR9B82QpzO5D7doXBdTsU3t
         0fYMby8uFvQNU+5THdcV7BbtXRMDsD348/u37XeQQcQ5VU95woy6WvbapIYOIz8uaSUl
         J6h9zdapo8RfZDuh7fZ9O01V2ahZLj6MWBtk+rgpVY+xRs5Ex0IvR0vD0pVnY0PBUCSS
         770w==
X-Gm-Message-State: AOJu0YzxnCwT+JpcZZlDlZp+SYHir2PmTPq9J1SZxcRC+vg38DIO0Xv0
	INFSvlKgmG4WQ2fkrzkCgN+e//IfyJYkJNyjtXLSnleUmjuc6m+DrPFg87MuGQ==
X-Gm-Gg: ASbGncsEZtY6OthzP2MkrFm1JKqkDl4wslwn4tXuS/n4BbMj9PvNL4w3Z2RhySqEMVn
	0PpLv/yrcSA8w4BG3/lifxNap7+Ku2zSZhS6P9O/THHJWptMgYKGQufYLm7Y6ROxANS2nGpVO0J
	p64Zp0SYpOxtZK1Zky7QTQXmEZZ48vWBxlk4ibNNblekwfbt1Ca3w69YF4JTdgES/vy0gNffSKU
	sM470NBAiT6J6fxdxCIMzYQEcOWHuK1TrJhuvpS7/ipRWAk5qldOR96YobY+dP3tbwviZLhrnDR
	/p2PvkLU0SQszELUHp5Dj5cUqF/gF6W/lgh35Y4xVt5k6bza6pwWeqXNQ6vS6WnUwrwe8Gxd3VQ
	OYBL7ccUaM0vkW63xpK4naPpi4BG1G+CaV3QBf4vux3WKg/5IlKM0CGLJXTlpgT0J7N5g6WG4MU
	By2ZlBv0hsmjVeJmsyhTZ6ang=
X-Google-Smtp-Source: AGHT+IHMgOlEEcZBswjSipfrw+UcLL49ByB29ZUn32j9K3jfHFXadWim51N5WbsNtGZzM9P+uwgmlw==
X-Received: by 2002:a17:907:971f:b0:abf:3cb2:1c04 with SMTP id a640c23a62f3a-ac7d185c2d5mr1057040166b.9.1744024713024;
        Mon, 07 Apr 2025 04:18:33 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084f17sm6613826a12.61.2025.04.07.04.18.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 04:18:32 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v2 2/3] t9811: Remove the -q quiet mode from some instances of grep
Date: Mon,  7 Apr 2025 13:18:23 +0200
Message-Id: <20250407111824.46518-3-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250407111824.46518-1-anthonywang03@icloud.com>
References: <Z_OEAxJENE_mGkVa@pks.im>
 <20250407111824.46518-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the `-q` quiet mode from some instances of `grep`,
as the lack of `-q` on the `grep` on line 99 implies that its output is
required, when that is not the case. This change ensures consistency and
avoids confusion about whether the output of `grep` is used.

---
 t/t9811-git-p4-label-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5abac938d0..e69dae55dc 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -97,8 +97,8 @@ test_expect_success 'two labels on the same changelist' '
 
 		git tag >output &&
 		grep TAG_F1 output &&
-		grep -q TAG_F1_1 output &&
-		grep -q TAG_F1_2 output &&
+		grep TAG_F1_1 output &&
+		grep TAG_F1_2 output &&
 
 		cd main &&
 
-- 
2.39.5 (Apple Git-154)

