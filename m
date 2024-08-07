Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C34AEE5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035819; cv=none; b=FgAadqyvHw2xLJbkoyNDHT9sqCsxL9ht1sl7yPhckw2CDrOLfvYC4n2NZXyeVp2HnKeu1rgNZwgrjMibFdCD2RpO6wOJjxibm3dTUDWhi4YStLUpakynWywldr8uABX52HlYg20o26DBkO/ijMbJiEEX/xGgJN1Z72ILVAy3Q3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035819; c=relaxed/simple;
	bh=82LBgI+r1uoEbXpHhpXqwtsjlfx4Tj7PQr2ZiAaFQLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca56NZ6N4b2zh2650Djln8de/0Y0mvqaQBJkV+KKITIN+AOJZR3XxhPWLVIIDtzGyOYAmOa9vFjehp2Grho6J2Hfd0t+WvSqLks2UWH6fDQMG7Vvougb3P3pO3KC7SrcwS41UW41WjtoNipD2IGFKdZEMskrburryP4UDy/9mFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJryUXOq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJryUXOq"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso26597501fa.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035816; x=1723640616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMSNiupLF5UrDzBeRLBNNFi69PIu7pbmJ9KBAk2lI2c=;
        b=bJryUXOqWH5Ct5t7ggLLI/pNRwLq3eeLHebAnC8y5Bfc4YmUVqxBVf17hMDfy7D5QE
         P0cTxNX5y6D36tYRA7nDs8C6wBR6ZUl+ddA4J5rswodQlNgkQyYVqd3IHKLRoYzcrstH
         LtNu22RG3n6MA9aeQOCmKszVQNEjeIApcdwEDDEh2ZX0RyprAX77RS9HD7wgjT342Sve
         gMn4WU/dJ8jzgBDnfu71D87tLrsi0HS3/aBb6HYO4aRivTvXR4js0GpghNcAlFiHKMJs
         6aCxbxODpIxC1DR8Ro481yx8BHYy5LXQLAfKm7aGrKjQ/Zj84hCFawJITNRo7zWRX9QP
         t9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035816; x=1723640616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMSNiupLF5UrDzBeRLBNNFi69PIu7pbmJ9KBAk2lI2c=;
        b=LFPuJ7GXY68DuWpmoRj6JetHiRoKfhVo9qT1JvHp1A4WArlFd++VON7l2ojdSdPUG9
         1AVok0B/YD4guNfKZ5nk+hEnKaTPx9PeYYM0i0LIqX5m3FNaGCg4L58vJ/UHHEvXdYiX
         w+6FHJnv9UOUaWxzMydVHWCOr4/IB3eAuOToVXmd8zyvSEoMhE5ySUdjSOwcCU13e9wU
         cpH+stf1ZX5X3/t/PhZTo/OgTGvgSBLepYn6Rr9pgJgL12E/tQwAhCbtLIvfe8WIj3xb
         3QyIAhVGb4yurRumq7p5zAfJJa+UCgpThBrG09+6+9DLYk+lUryA903604wHtbZflbXK
         N+6w==
X-Gm-Message-State: AOJu0YwBHm3iP+taw8fTtwBmIvK9yMCkcx5lPcEm/T9e1s2r9L2QYY6P
	psEnR1iF1Enk4eybb0Kp/MJDhNcNav0CkbBDMWWqK8NZBl4b7igK8lLoSV9N
X-Google-Smtp-Source: AGHT+IElSG4A/KplUOljxJgf2+IiJ7a3BMc2sD7BI9CGb3w8j5RpCiGJUZvZ3K+Ff8SbmOhYmh5KdA==
X-Received: by 2002:a2e:9cc9:0:b0:2ef:259f:a569 with SMTP id 38308e7fff4ca-2f15aa872a4mr130087051fa.15.1723035815409;
        Wed, 07 Aug 2024 06:03:35 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:35 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 8/8] t7004: make use of write_script
Date: Wed,  7 Aug 2024 15:58:44 +0300
Message-ID: <20240807130259.28381-9-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807130259.28381-1-abdobngad@gmail.com>
References: <20240807130259.28381-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use write_script which takes care of emitting the `#!/bin/sh` line
and the `chmod +x`.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 046a5bd9bc..b1316e62f4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -974,13 +974,11 @@ test_expect_success GPG 'sign with an unknown id (2)' '
 '
 
 test_expect_success GPG '-u implies signed tag' '
-	cat >fakeeditor <<-\EOF &&
-	#!/bin/sh
+	write_script fakeeditor <<-\EOF &&
 	test -n "$1" && exec >"$1"
 	echo A signed tag message
 	echo from a fake editor.
 	EOF
-	chmod +x fakeeditor &&
 
 	get_tag_header implied-sign $commit commit $time >expect &&
 	./fakeeditor >>expect &&
@@ -1415,11 +1413,9 @@ test_expect_success GPG,RFC1991 'creating a signed tag with rfc1991' '
 '
 
 test_expect_success GPG,RFC1991 'reediting a signed tag body omits signature' '
-	cat >fakeeditor <<-\EOF &&
-	#!/bin/sh
+	write_script fakeeditor <<-\EOF &&
 	cp "$1" actual
 	EOF
-	chmod +x fakeeditor &&
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
-- 
2.43.0

