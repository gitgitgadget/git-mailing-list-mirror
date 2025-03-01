Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCC1D9A50
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740826797; cv=none; b=ChOQtM9B1JM+7adXmpujlVVOenNvQczOF61EYBxRTiiPLn2ysbJqfVNYsPh5avXjNPTcBIu0YcorT4mNIuEFGnbRAH+H/kA6Z5efEpLOlONDvWxvxwcqgpvQbzSf5yPJo9lKozZ/uua3HCo7XJBYM9B+P2jl5B2vXKNl63E2aiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740826797; c=relaxed/simple;
	bh=YI3pAh/iXKdRgrSsyGgTwhYfMj3BIdDi7otTupWfxnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5N1C5vPNSQubKJmioP7WPCfgn59q0yo3UqsBSH9iusEGDAB4VOu/oCFxQpObi9U83WAU1r4Yw+3dscsyGhokQXDIFxOKmkJsfd7b/CvWzrDrirC4oFcTekLlVus6FmnKu91hymXByOFiGoXig4Kyt8eiR+z6ZP7CZQBOlEks0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOch5Lum; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOch5Lum"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223378e2b0dso43819475ad.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740826793; x=1741431593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKecv/8WBYXb0iD/DaG9AbKe4LbZSlaoPuhkmrQWiuQ=;
        b=FOch5LumVRVfIT8EF+PpOgyw9M6RDeyYfTssjYpzqTDtQ4Zs6U/e+bZ8RwwTBr/VFU
         kN9oYh1dpkEHtITWImLZDYQJkRKs6rAv+roRuMqlANsUkBdGfpaSmUf8j3A8p9mfDC/G
         Jpbm3P++5BRZKwvtvem4qP1YkzP88MpSbAmQaygixKFkMh0n1BEvrk7aOEbfPXUl5xaF
         PYsAQ+PVVUXuKzlJoHVeuLfoyKaT3B40Vp9fMt1c+YH7MIgkoKN1g/w3JdRRB0Jz3Voi
         3I7TpMeNNOUqCU701mrefZZQeRoaAADq4mxA98od0amIgRJ9TQAUjJb+U6t0vWDJMuzF
         p5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740826793; x=1741431593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKecv/8WBYXb0iD/DaG9AbKe4LbZSlaoPuhkmrQWiuQ=;
        b=ifUuH7X2y7Iq9Jt75AvB+c4W4AO+2LgsBR3aPK1WEoGKm25TnY/KzXVIeOjHJgKPxc
         v/nxup3r2mNQmgK3lQo58dfYBYNhAkB4Njqw7D2tISqPUDRcv8Q72zIo23/OjkNq+g/W
         k2SCruYart2KzmGyrEbR/xcnPxN9CBBlLxriLNwCty2Qha/tvK5TRO0JTGx//Ldiuw3U
         AtR50ARGklkb63y+wQDFgzeyVOXDQpOQKsmOCCH7Gbkb6wLUtd9PZ9GyznQIPKO/S93m
         hoKP9dkrfnoOqHfByxeFTQFtiAl6TgapfbMLoa8YBy1cwVKstMcP6PcPiHFFEfDR28wB
         JS9g==
X-Gm-Message-State: AOJu0YyPgqbE9Oq2nkn4fG4iPW71iiuF1sMxz0HuTW6L5j0+7lrKos/6
	Q2uzWQ3ncLsiBJf2bJwtiVuV7DvwceVf91u3fxEmRFrGnhyh+MIBf2IOkrxcobU=
X-Gm-Gg: ASbGncsTSismygZuZwynEIp62sLxe8G1DWXfPq/w5qfR74RU+o5f5mjwQnSuqg5a6tb
	u+xzYCNb9h/Zofpc4WB6D0+GBzGQJU/anaQ0qv81vsWUtP0ZWtpdyXAmN30iZB48Z/m2mN98E0A
	4UilPRDOBXWnfm2SQp/4hnbciOLBICO1ry7DWxc34pDMppP2yZ9mD+RWWyd0RY/XjoUjtVIg32s
	Lqn8pCJw85ojWMZu/uCr1oUeTb/2AhSW4iWnk2RsmE6hInhwf3/GmO8HBqnHm04gb5X+5UDkOeD
	CSFvEPFtgvKTz9OgdQ6KsiLlOCwyzAYe0TvGyGCemPP7ml8zYxpgy2Go3X6f/xvOYlAqiECePdW
	5fho=
X-Google-Smtp-Source: AGHT+IE9cgrDWPMN0K3a4pvSXlM/ym3DqRYqdkuMIGBlX/rcT5jDf9g1bIiR6bWp9HIcnZNwD1RKhQ==
X-Received: by 2002:a17:903:32cf:b0:215:a60d:bcc9 with SMTP id d9443c01a7336-22368f6cdbcmr116460155ad.2.1740826793112;
        Sat, 01 Mar 2025 02:59:53 -0800 (PST)
Received: from localhost.localdomain ([139.167.143.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5cf4sm46156505ad.130.2025.03.01.02.59.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Mar 2025 02:59:52 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] t1403: prefer test_path_exists helper function
Date: Sat,  1 Mar 2025 16:28:38 +0530
Message-Id: <20250301105838.1481-2-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250301105838.1481-1-danimahendra0904@gmail.com>
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -e does not provide a nice error message when
we hit test failures, so use test_path_exists instead.

Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
---
 t/t1403-show-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9d698b3cc3..12f7b60024 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with dangling ref' '
 
 	remove_object() {
 		file=$(sha1_file "$*") &&
-		test -e "$file" &&
+		test_path_exists "$file" &&
 		rm -f "$file"
 	} &&
 
-- 
2.39.2 (Apple Git-143)

