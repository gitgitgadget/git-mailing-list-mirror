Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28D19CCFB
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908713; cv=none; b=evQfsmIMd0Vt6MsclbE948UVdFKgJrPIzR97VKxOjzcoBVKKiZp1LKfarIx+OvGVpJLZs5SovePdP9bkhi7KLuMMN+KM+3GftW8WsJKfyYqjhOvDv7HBLwb2bKJca66UcvSoaKhhNp0CpeIIlsYs7csCAjvPOr/sYqrVayUiN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908713; c=relaxed/simple;
	bh=0lflxQPFqfShlqC6v/hrBsCFVROLzKokdRfkdeKEmj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIWhy8+7bWiP+2DCgLixahQmk1r66UeaUE6JO2cXjEZjMqr/jJ+7TeI+sqmiz5H9d4ysCj15dTTjWEUHBOk346qJVjBAuSy9+rW+DB7FPysTAxg7rQLzL09ZRLMICxg3tOlSJMNmM0PCY2k3yyIg+nd2j6i5teV4CHzCsTphK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YubxuDQq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YubxuDQq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so821579f8f.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908709; x=1728513509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zue9PetSSp3HCLMJmDhGHHmRnodAGBtpGV1/dS/Tark=;
        b=YubxuDQqwj4036Q87NjDbFsZkMYQhu63GFSQcoUQrcTaPTDUfcXhMTaKNDYWK9lhf4
         /y54nPTCGTJ3sJiZLnHGcG2Wj8xHUvkWFLl/+JMTcCFzsJ9trdb4962QMsSblTrhkQux
         LH5Sh8B+L1cXpVtbyFSiKcd1hTox2H8Iemifa2jiRipoDZdzh6SNnXKStDMjKs+yBXIX
         aRG/Hucf0MqUB+4L1gqf0zCx31klCQE+FDVkCuEkXswqi2Ln7o0X80+M82QNYfyhoPL0
         m8UmEPeKdjNEbhQd56dSLOWjLB0cvidTo/xuxYR0RX2y8pvaVnJbzkqGxKPe1O/iEpzc
         nRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908709; x=1728513509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zue9PetSSp3HCLMJmDhGHHmRnodAGBtpGV1/dS/Tark=;
        b=pzRo41Fg7B4reVHf/QPwJ9drP8/pyzWQn5yB1/oN6j3mvI/NYX4TNhQlXU23FDPXEj
         26+CORCkBi18cxdfl6ydcITAktnsknWVUtXfLkZQEo0PU9G9vJcPjauS2dbYsaJ7XdaW
         XkF64doAlpdc9LXXVB7UPoIUEQlgDMGkkKHVagytxAYT0yQlUe4eStrenVcGtVXhsylC
         2v5BV2f34gBWGAXI/fl8Xpf9TPMKcMoghcanBQa5NAuqwFXvWJJqgd5ZwaL/lXLFIRNR
         4uxMxtwU7bljN7SyugLtUBj6DxJbm78G5tdsSGVPi/DzcfZeFsh0JE64/CK+kj1JKukz
         Xy/g==
X-Gm-Message-State: AOJu0YyZL2sE3ZYUr665ZRSi/AnGkFz2z6ORWNfczA+qJZX/clLRrL8u
	dQEhI65LeUW/4icgtAyZQP7WF4cCYsVODWKvW/52blIdGzaA0TufuVL+BNjP
X-Google-Smtp-Source: AGHT+IF2k2ufxWkA30sKWSIYePXiHdvK0rGOCEX/3VGUJYIJ3JlRkNTB7mfXICbrXl4XHVX7xcpEsA==
X-Received: by 2002:a5d:538d:0:b0:378:c6d5:e2b3 with SMTP id ffacd0b85a97d-37d04a57a45mr591492f8f.23.1727908709266;
        Wed, 02 Oct 2024 15:38:29 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm29753095e9.14.2024.10.02.15.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:38:28 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 5/5] perl: fix a typo
Date: Thu,  3 Oct 2024 01:38:16 +0300
Message-Id: <20241002223816.14858-6-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002223816.14858-1-algonell@gmail.com>
References: <20241002223816.14858-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 perl/Git/I18N.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 5454c3a6d2..475e90a6df 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -111,7 +111,7 @@ =head2 __n($$$)
 =head2 N__($)
 
 No-operation that only returns its argument. Use this if you want xgettext to
-extract the text to the pot template but do not want to trigger retrival of the
+extract the text to the pot template but do not want to trigger retrieval of the
 translation at run time.
 
 =head1 AUTHOR
-- 
2.39.5

