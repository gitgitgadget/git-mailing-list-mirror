Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C54AEC7
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878348; cv=none; b=KTeZI+2Jhiv4r3n9xZ/LtJfCPof/DPF3jxf5ups7CzCkDYm0s/XPPUWsoMQYM3Mt29CUSYxbk6wRuw0veqQXkqj0KVIsN9RhCEu9BDDz0qZ9JBG0qzFOguG2WY9ATKd49CBqeo+oUDBlBloUzZyKeTsmiRa2yDuIujvFBoWKrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878348; c=relaxed/simple;
	bh=qnKiJD3CT3wf1ILX9c41YZiSgm9Sf2RyaaT2vpZ7mME=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=auGrUAp/AUq2ZMapgSCRXnDCaNtldhLb+YS33Dd1qSzHsPthJPKUu69J+keKnEwUO9MGxiPf4jjwUJR0k6AM0CaVpRNZkGHNXZjFCvhg4UtXS14pCHjwaKiZFHKEqeR3Q2mOFNru3DQkaWkEIHblUJIcI9HXf2iTUGryOP1q0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW7nEZxH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW7nEZxH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-417d092f39aso1866215e9.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878345; x=1713483145; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfXXZp67ctZjTXCIGvshqxvVtrY4WlSznM9j9CDoBJM=;
        b=YW7nEZxHmTP5sdl+LSsbthAwb3wf0og6dJYiglJb7c9OuW6sgZQcucDhYDkr3AD1E7
         Qw+NZ1t4ZRIdBsnEmGJ3z1Z/CXFApQhO/bSdHx39FpJYq02nmmoodn7E39Gd51zZti52
         g3XZ//bvF9MqFTlLX4DAkOzMv/F+EBPpswjKVgI4/aOzg7CO1oziMHH8rZ2Q1XwU2j2u
         yaCf/VBYgBxV6i4Mv2IdYLoX3JeO8uHst7AaqTKD57a1Ov3NJrAmeRuNyB8XN4uQxq+e
         +f3EynDNfjZdx87wly/WdNocbZD0QE4Ew+EuWFWcvdzhgQloi4/vhY/bmb3VM/LESvAa
         UpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878345; x=1713483145;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfXXZp67ctZjTXCIGvshqxvVtrY4WlSznM9j9CDoBJM=;
        b=REzFK3b02ERk2s87QJtlQ2XupCDK0c/nU7XfbzbC/H1R9o2qhf93kBK7gx34aKgjcr
         wQYyGUKeHQHRAEnvGIsGWBCEoxekh2d9/xLrTScavEX2NFUtOY4dwca3sQaYadLLGBTS
         nF3Tio9VvgSecsKYmtXDJBDiHsv6wntarCVqpn+ROYrB2k/YpFKsNzgFsAhNtbnPG9qv
         c0lkClt0XvbP5GHwqyapKt+Z0YKLPgKu+k3RBzPJlQC8NZXL+v65x0T9U0CK9NmhJj7l
         sF5yK/NYrt5ulMef3Y9sm7Zif6uSB1aSZVTNoYo9BuvB+5ZrhCeXzTWK/aQzNq9ywt64
         eIkQ==
X-Gm-Message-State: AOJu0Yw0n+LMEuXaML72Sw1zzrJogCakaojnO7ya9RbM56uWiB4vUaPn
	235rE2uhoX+Idts+lvy4fkbCDkt4nY42pxzHbp/366tNnm6rFOYGLUsyIQ==
X-Google-Smtp-Source: AGHT+IE7GTvo8JBfQdrz2CmnYWfYGJZB3M9XaqTvE6M51Db4vVv0xGTFM2Keaq5s0UiO5gxwkIvZXg==
X-Received: by 2002:a05:600c:1c23:b0:417:5be9:1319 with SMTP id j35-20020a05600c1c2300b004175be91319mr915068wms.12.1712878345222;
        Thu, 11 Apr 2024 16:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b00417caec4135sm3752837wmq.4.2024.04.11.16.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:24 -0700 (PDT)
Message-Id: <44470a5d70edb60bd4f573f6b214e7ff5cbb4c05.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:15 +0000
Subject: [PATCH v4 4/8] SubmittingPatches: quote commands
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2226c09e6c5..f1c0d1483bd 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -403,7 +403,7 @@ Before sending any patches, please note that patches that may be
 security relevant should be submitted privately to the Git Security
 mailing list{security-ml}, instead of the public mailing list.
 
-Learn to use format-patch and send-email if possible.  These commands
+Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
-- 
gitgitgadget

