Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98C19539F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024566; cv=none; b=KmNI4uRgNLwkGq3v0KaPkBrh9zBBmAJA7SrX+jasxuUa88XmwpYqT5tVBzfEVQq7UppTr9tqaXzpfqAjVS1HgWyYrusz/+WaFLH+YRyrrfMoTnCwuWu7s9SNa1aYJruadLWEK59Uy1ZKoeRB/0yywLpkPwUbDQHs5aRZFWNhGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024566; c=relaxed/simple;
	bh=bL8VSI/kPoXKUqA7KlK8sK5tQ7o+Trrh6e/zC76/wgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQt54AftSLg9thB8aZlBXVoYKMS73Ntb+KghqFKFYLOsYLvoQrSVFi/qhVghjVCxxWsgdjAqX10Oy9B+d9/5Z4gcij6WeRd/nAieQ/NlDOSCADkdSpYl1FvE+Oa3fqrgbDUHp93lGhfpMDKBMsqYn4v0Q4KjkPrze8CE7h1M1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iitFGayo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iitFGayo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaecf50578eso179914666b.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737024563; x=1737629363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mbo3uevmHZzZ4NPsGtHNcIjYB/AlAjkq2ns2LSEvW8=;
        b=iitFGayoc6Z9AZDe1rH18TJlzwlnimyuAyEXvgyNjQjraqkWGHt76UAZTUWxHQSJBY
         4wuIpg2XH5xw0JI5oILfTS7Prk7VKAMU14ic4m7Rjvx747gAT1y1+zSQrwJ5lYgC2TbE
         nDWG/U2hAz5kxqMMxL7fZ1XKuyK9DdLq9SEzOL8k2BcIYI0TAFaygvvmoiWM7HbOyOmu
         Xj8QNZlqbwufRV0pYK1dcxt73dkTXv/Cptt0GLu8uRyE3wsENh1QRTCkO7N0muw4hixG
         zTbubpfYl6TC44c/6g/VjRdfhKp8Hg2tRQYPCaQ/8OxhsxSbhDHLUQvm1+wd9lKa4Bkp
         B0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024563; x=1737629363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mbo3uevmHZzZ4NPsGtHNcIjYB/AlAjkq2ns2LSEvW8=;
        b=cyZLQcKu0GuToU7JukeeFp6XbWKwtWdKPvp7zXNOrpiOCTGVrYVQX88f+DTNVofKWv
         ksp7bwe9LPzvZVqDYyDqsF+Xyf4W5Ubzc5aDqv4IX/7bqtXzG8UcaON3gxATcxESRW8t
         YG4ZxFfc0zx3BZIYN8HuiZqzKcrHrn3yx3k3jzFQIFZb4JNtuXRkZVgeXHM8VAcbhwE8
         cbSiWAl3nvPfjf1en+sXWYs0wwzgWKS4d6OSCC6HCtwyHBw+t1B4xNsfY5gQW5AS7OeQ
         8jaITBjmCLFRkXNdOeChxmcIWDuloj7ufG/k4UJWuAF82guSVlgHQATl5v5lEx8MbI+Q
         mPGw==
X-Gm-Message-State: AOJu0YxebmBkodA6KngABF/oQj6dy7cj3kda5NxIj/tZnVA02OG/nKq5
	aVR8PbsHKyg/bd+CqeBwNuS5g40VeU+4msoWtQqWjN81U3f6jU3R6O1VBXx5SjGGLQ==
X-Gm-Gg: ASbGncvYh0HgJLCwdfRKzYmsSUqmq2h3+tcia8MrrxjEb4o+XTy3rGvTMNcKUNJw69N
	4Xet6TibUjmvweTrqRp/rnJUvCFD3OGsdtTZlqnil1hgLA11I2YdBfti0oaQ23Rv90yKbO4gHUC
	+EP3p+uy4U0GqG9Y+/KvNfePAmEqIJfn5I8eNxVIo9xli1xNa2hPwqzrOcEr7zl2dTSv40zTqRM
	Q7A2yWBiyXqPiPvOIzX0cXsXk2u01o6BODTUpBYflBWvodQVTqWXmhv/zSOIDakLTFRig==
X-Google-Smtp-Source: AGHT+IE634iUWuPOG5WVWYUpA3PXKT9UFDYE90pScPcAk0byxMmSsXnt4PsTxUuk2jJFm/Yr9m9aMw==
X-Received: by 2002:a17:907:d87:b0:aa6:519c:ef9a with SMTP id a640c23a62f3a-ab2ab70ac8cmr3287567566b.53.1737024562952;
        Thu, 16 Jan 2025 02:49:22 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9646be5sm901203966b.174.2025.01.16.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:49:22 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 1/4] t/unit-tests: handle dashes in test suite filenames
Date: Thu, 16 Jan 2025 11:49:08 +0100
Message-ID: <20250116104911.77405-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116104911.77405-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt script to translate dashes (`-`) in test suite filenames to
underscores (`_`) to ensure proper extraction of test function names.
`generate-clar-decls.sh` does not pick up dashes in filenames such as
`u-mem-pool.c`, which prevents the scripts from being run. This will be
used by subsequent commits which follows the same construct.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/unit-tests/generate-clar-decls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
index 3b315c64b3..abf6a2ea2a 100755
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -14,6 +14,7 @@ do
 	suite_name=$(basename "$suite")
 	suite_name=${suite_name%.c}
 	suite_name=${suite_name#u-}
+	suite_name=$(echo "$suite_name" | tr '-' '_')
 	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
 	exit 1
 done >"$OUTPUT"
-- 
2.34.1

