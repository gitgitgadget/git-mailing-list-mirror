Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5458208
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920741; cv=none; b=T2WvZPnVJ17KUG28veSAtAP4oLW5dfhL1tP/5f5nOCQ13Acxo8w0aZ6BAZbx6jSrfI/IFq8mk/vX0OrEkD3JxoOEak4ULzOAlJlbKoyd5WFguRbxA7SijkIzlo0z1P3yDrYa69nQjSfHQhvh9kzZaim6c0wMYUF+pI36HbAv0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920741; c=relaxed/simple;
	bh=+A2x+78oJ214aJwVUgpGyqAaZEeS8ctgMXyCJfoNOzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+iHPoGlNMNUnv4s0rMh84jbm7+IbmK7g+HrADPJn5b30k2BV/2+keXKcmbiEkJHXdWsbXEYSHBTBwrCzEYa4dIv1fOte8G1sbq71b0P9446DXc8i9bTSvcrN3lXXBOXO0IdNdbmhj0PgbIoti2pSusrZXVYks0FplC5cOHO8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvFgw2qr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvFgw2qr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3394b892691so575354f8f.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920737; x=1708525537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHyLuG/A0kwiPsQ/I3b17OCMQ+Vhva0X8aSEWeqHOCw=;
        b=dvFgw2qrDMoLipQg9I60PAWr+X9hoZkA2n1CtEcs68ais3/q+eH5ZIe89V5CsoY5nb
         RvZfAmhCo0F+aQBAqtGMqPNsOukj63oQRJY+4MmL+yJPH70Q4e8LKjSlMl1ByqKiZXLn
         btxRoxGv70foYGzbZJeu3OXC2Nkv+EqXTGTV2J/Ycn9tAaf5Sy5aQiDL5YxrMiijswGa
         JejQdZZaefBkZHeWVBzOERAVrjQV/oYK9ymk7/B3Sjctp0JrMzE+8bnI4JOA0Z604GSJ
         0j9gyRWWJF80AnBEJ/4XUO2FRTqsTWTQQMMoZK6xp19w8cUye4rTEZcFlqTQfGwsbzW4
         iRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920737; x=1708525537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHyLuG/A0kwiPsQ/I3b17OCMQ+Vhva0X8aSEWeqHOCw=;
        b=vkWqnECidGBfagzhd7rcTN+fApRNjodjbTlk/b+d0nKh95ZolRGcaZILWIGIQbAXzP
         mxPG/Ts1TQ76d6GHXf7773zagQduaOqolXc0fLnBF2jpR8fX4OkbUa5RwjC9SeLmmmsk
         54s0LubYmFNiH55Na5+cf+KhSJX3r3kn4Wh8YHWoeyGiJnsTjbPBBjSjSYERjDyNcJdO
         YAzeCw0f1q0e4zHaCaXW/1o3SYrpxTw8jcFjsRFxpX9z/wJT4eYSg01607s6ZeA61sNX
         6rTLZwcVjrhN26iapoXVg3WAgzxt+DCF4PEO5Yue76B+YV2RxVBcSr/ffCBub4EC/kiZ
         AzxA==
X-Gm-Message-State: AOJu0YwSYjU5rn8DrgBLEhiZOVD/IHElOur6KOaoCGwAfHTwIuGbY3lf
	ct7OVyQn1HCSeWNIE2ZAAVDfq425Eln8PuGNfhSLqedGIYH0z+2UOHcLa+cB
X-Google-Smtp-Source: AGHT+IEGvrcK7DBX6JROA/owPEIeNaNpMw0pNGTRz4KDD5Ghrr/9+5TBvroo1PEYl807G8Q7MQFFXA==
X-Received: by 2002:a5d:4243:0:b0:33c:d5da:7970 with SMTP id s3-20020a5d4243000000b0033cd5da7970mr2073153wrr.6.1707920736785;
        Wed, 14 Feb 2024 06:25:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaDxJprmqAp4GmOga4tXreeNWRcylF26jq5lwil0eZoR+zZPG/a0Chs8or4tqlAF6ZfCT28BCwhZRedIm4O3Be8ws72XLJ2Afxp0xJvB3rV6f7qmNuTUhfayy/0PH8eOWb4Fk2mo10fHaevH8b15kZh5Md6ki4u4OJ2HHy8PT92ElTGKBTNm8b1eMly2xkYa+RgJLWrJo6iKTSwoOAdBn5wXCrDF8cVyRqAUwmZtN9
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:4d2b:b120:8137:3062])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b00411ce6def3fsm2146871wmp.38.2024.02.14.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:25:36 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/5] t6022: fix 'test' style and 'even though' typo
Date: Wed, 14 Feb 2024 15:25:12 +0100
Message-ID: <20240214142513.4002639-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.51.gda36843b44
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240214142513.4002639-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6022-rev-list-missing.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 211672759a..5f1be7abb5 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -46,9 +46,10 @@ do
 			git rev-list --objects --no-object-names \
 				HEAD ^$obj >expect.raw &&
 
-			# Blobs are shared by all commits, so evethough a commit/tree
+			# Blobs are shared by all commits, so even though a commit/tree
 			# might be skipped, its blob must be accounted for.
-			if [ $obj != "HEAD:1.t" ]; then
+			if test $obj != "HEAD:1.t"
+			then
 				echo $(git rev-parse HEAD:1.t) >>expect.raw &&
 				echo $(git rev-parse HEAD:2.t) >>expect.raw
 			fi &&
-- 
2.44.0.rc0.51.gda36843b44

