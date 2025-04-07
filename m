Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1921638A
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046714; cv=none; b=nyixX7W83zmR3fxLP1L+dI6GrNccqANqKTuyCBhJ2OiSFUjDoEmX0wRrsbBd5sqxEBZB2sDlBMVBeWx0nOv7s7y4VYu/Dp/jfFtb9n6ReMBfN02hz3wackz7YcIK2w9pkur4mAkc0zSQi8VLKVG2Xtfd2hBdq57ebES0IvD7xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046714; c=relaxed/simple;
	bh=WMGuvGoIpiwIhLsre++9ytwZeX3fAh/+rbStHpf1FLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCWN5yOjPIZ+lASHo2kUxvsILsjzE94hySRSHzcXAqg+BxruByOwV0TEGmL7Q36GMOO8gTNz2zfJ8phjs2h5u31/oh6rSDeOdpMI0t+VoufwlH2kMjqwNhatK4GHuM1fGQB/tNUhAewDnMy1YubQbRSpOep9QI8GNN3VIH1Yp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1/UljcM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1/UljcM"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so840543066b.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046711; x=1744651511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv4ms7Kz1hKDwH4hsfrfRh0tE2Tev//BGbvXQi2MC2Q=;
        b=T1/UljcMyNDB882azEZwEP3XgN2Lz9T22uwgpsYBMhVmMU4ShE26YdrJNPNMeOGNJE
         C/BFbZeph5Gz/Hvg7Ws86yPjOBXmtUT4XJxFSnh9DzZAQg5hroAuB/JXX+DxknMNPMoO
         +innNehj4Q1dTMwkK5CfRkF6SiXI0PsI7nSrD+h5BHr8FgWuwaJxPby/ZdglbyMAKwC4
         4scdAAZpkaO/kmNxr0pSD705mPo1MkhMAEnOr1lnCW8mfff46YGp5AmJbqfB7/mmK2KP
         /I5DZLusX3rJbYg1u5fsQtrcmd2Wy6sHGHypWwKgtAcRVtc9WfUQ6UuPi9Q8RXsp2Rdy
         XG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046711; x=1744651511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lv4ms7Kz1hKDwH4hsfrfRh0tE2Tev//BGbvXQi2MC2Q=;
        b=nxAfVfegK4JjzRVElSv2IfvnlhA/T3qQVwKQQDum+8vvFSqhz1KY9LDA9zVe70d3NR
         LxOZlJ2HDcVKwmwLitGrz33QkvgiZDOyTa9lIoHcXRUUjk2LAz1KJu04wTy9yYwUAQjG
         l6g2p54/o/yZh3KvV2CL65uco1iCI0qEj/CPhsS9IEof5dg/d6/IQHKMxWcuWPktQdRN
         374xlFlMh/pL0wJjDlV8FiqsXaHcBnKxbhhAvbGVBN6bl8J0fE2oy3LPGpdFrGPuNOTl
         BdLQonKM0HD46+7dbGHEtrA/w30+TlcvfmFhFO6h/w0Rw7I++GIE642HcFs2aj/rhYdt
         UpsQ==
X-Gm-Message-State: AOJu0YwfNHllf8GxG5cJOgjk0EzUIQleNzfAHlY5xaGbEwF6RqkL8ey8
	B6X+nY2gkSDlPgkzfHOyX+1Pqkv5xbhOlLByiHtDoMIPpOsKdFc=
X-Gm-Gg: ASbGnctUDNeMpoEOBQ4jPM/u6r1dpBA6LMugEMrnxeBy0gIcCgrrS67uVNxnqJExQgM
	mbkfAmm+9BFXL5y0OXDav0rqSQwiOq9MQoqF1paUVswEwM7mCojNN9kAafhPQ5w4KRXx/wpg07v
	zn4PgMXzSki09uPLm3AWJYQs1euWiYVt8BoFXFgnljF8tdlujcsFARgtsDffJLYC4bh3xLhWaWs
	zYT3xYNRwojZ7pPKVe9Sl1M0l8mQD4OKYggVJ03A2UgbvZg+2RR+YkSFW95maaT9wm6tTIRw2aY
	qW/d71sZ96eaJP+N7ylFZ2BlelUdqOOfVVnd+PQbtCCNW1ZizYuAZZaU2xbHtG09lQJoLQldaKq
	8d+0NQVp3AS98HcaLtSGheAs=
X-Google-Smtp-Source: AGHT+IEtjH0cjzcqUS37XL/5Yo+oCxKsgxT8KdsaY3Fqk/zwnQyQf/HR5OmRHSij92r706G/uidP1Q==
X-Received: by 2002:a17:907:3f9d:b0:ac7:18c9:2975 with SMTP id a640c23a62f3a-ac7e7771f7bmr822469566b.48.1744046710960;
        Mon, 07 Apr 2025 10:25:10 -0700 (PDT)
Received: from localhost.localdomain (generic-nat.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c0fb1sm790193966b.179.2025.04.07.10.25.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 10:25:10 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH v3 1/3] t9811: avoid using pipes to expose exit codes
Date: Mon,  7 Apr 2025 19:25:02 +0200
Message-Id: <20250407172504.50849-2-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250407172504.50849-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250407172504.50849-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the upstream in a pipe is suppressed
thus we lose any exit codes of git commands that are piped. In order to
ensure we pick up the exit code, we can write the output of the git command
to a file, testing the exit codes of both the commands.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..5abac938d0 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag >output &&
+		grep TAG_F1 output &&
+		grep -q TAG_F1_1 output &&
+		grep -q TAG_F1_2 output &&
 
 		cd main &&
 
@@ -208,7 +209,8 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git tag >output &&
+		grep TAG_F1_1 output
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

