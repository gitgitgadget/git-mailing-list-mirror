Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D1E131E5A
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985157; cv=none; b=rahfihSSwG+4R0sumtEMmhjDKjpGFm6ajGqxlTzd85EdbIoGeOnwCKLkpG4bC88aMYT/0MM3yCmNFsm1pw5xWUkEzCQOtQiE3xrLEsSSuRwxVmHV2pBcCqSgNsyvijTd2q9R107qVHxxbgOuwDuUaCELIy27nJfMgLDoGfnxCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985157; c=relaxed/simple;
	bh=F2DABo68YA6h+iO0327kr6Cdg8vWdEdwSfhGnoc54qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQdxi8/xd8L0y1T4OV7zmaZdNWKA6yN8ml218qNdi0exuZoTYk7CPEm6/nSb4L9EA2RVwRLT9itj5Zt3fmq1vmyN28kuCuuocIMUiyTbZsrB85Q6Tn2E07kBpzQnp7VSx1wf//QrprvXMdBfuQnPDRnt07IGcZwFLkN+NdWCMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2h1gpWJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2h1gpWJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e7ed64b5fso6461381cf.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985155; x=1709589955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlcuZrkEu3L2vyc03QFqijscR9qs1gNw5FIB7vTxre4=;
        b=S2h1gpWJWFxMPZYSyCZsd5KqfM6yxcFsdQ83f1mLoX56Db8fYkJYTUdMdKGwI+UEc6
         qoiPHJAUo3a9VFPoryU+vfW/pdFaeSP8OYgBpiS1hWnQztE0/hPc8vqRM7feQBDztUuz
         lFhweddYe2hGZNtsAn8YfC1LfrN7G5S+ly25uNpqwYa/IxFevTH60ZEgorxvwv+rNscq
         zGsWpJAvKhFjycLOZgWoXVOy8UQCDrdocXVdFuEMALJtbi7eMyRWdyN3k+aW460SdYzU
         2+Afdsvs+8VNAUXJsquVQs0wxpjpd+r3ig+ABBPXoW4cZ/rcLuofFpvEyoJCPkCULNS/
         4siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985155; x=1709589955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlcuZrkEu3L2vyc03QFqijscR9qs1gNw5FIB7vTxre4=;
        b=ZtEICvMihkf9ZXZd3wnz9RgZMwpJRgSLcLrPwlYi2RX9lK+FJ9+Wu3GphuuAKTCJLL
         REtloXj/MOUJ1D3sxB83N4qq2ymavKDiXSGCGxyHEiE8yC7esy4h9PFm2udFuHcE6on4
         TlyQpUy92Cx5aopLyghzPXyLe2pdhMWm/gPwiMzSOJILlBRq+fhOWmVUbYIub0dpImlZ
         wM7/8VKoZeqRLvfg1YW1lJGFea2N72kNqAPfRntbfh+pc9igDb9rr7oNvbBDBSjhkjLg
         YYkQIrOoVHRKLLmuYJKxuzqOxgkfiNwgZNIQHvUFtWS3Q7dZw4qWD2lTXpRx3aZGHK4e
         lfSw==
X-Gm-Message-State: AOJu0YwhMFiTD3lAnN2/w0I3A0RUojduid132v1lDg2X7ePN7SaXRmSb
	/bUcfJwFcNbrmAMfotJck/mpFy03Dk1JkOledSK6vhNSjG4+YbmOngxKApRJ
X-Google-Smtp-Source: AGHT+IE5Vy8sFZFwNSBwVIBWdhgt3iFOPsogcTFMOGnJhp2mFg/JuETXITkctgdiZYcFvOktNbggCw==
X-Received: by 2002:a05:622a:14c9:b0:42e:4340:735a with SMTP id u9-20020a05622a14c900b0042e4340735amr9482858qtx.64.1708985154828;
        Mon, 26 Feb 2024 14:05:54 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b0042dce775a4bsm2911696qtr.3.2024.02.26.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:05:54 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 4/4] builtin/unpack-objects.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 17:05:38 -0500
Message-ID: <20240226220539.3494-5-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240226220539.3494-1-randall.becker@nexbridge.ca>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change is required because some platforms do not support file writes of
arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
maximum single I/O size possible for the destination device.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e0a701f2b3..6935c4574e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 
 	/* Write the last part of the buffer to stdout */
 	while (len) {
-		int ret = xwrite(1, buffer + offset, len);
+		int ret = write_in_full(1, buffer + offset, len);
 		if (ret <= 0)
 			break;
 		len -= ret;
-- 
2.42.1

