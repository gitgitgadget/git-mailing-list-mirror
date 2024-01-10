Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C444D594
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yyHBOtqd"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-680d4584a81so35561206d6.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704909338; x=1705514138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2dOkZsTsOFQEblTAxi1gmTvocVfTF9neXhlvxTQtV4w=;
        b=yyHBOtqdv77FVewkv/9DSHu1B/3in6zqqkq4NK56tCiDT5EEXoyn31GrV8OJxi1z08
         P9lVMwx1RQEcegWD+7tOD5ckQbKcBZPKoZ+5xjBAxG37Wc4BU0beLOcAQPv38j/1qbI0
         cBbranYIPFOuw+xifnARzOARilz0E1KZJc+cPexN0SptLK/Hm7W/0Ge67ABBr1PCZkY1
         wopsPTH2JoyqUn6lTcbVmsnmU/FKQdZsZOWusxSNkRFeTk/+1z+9BonE5KFxflHgpxIC
         PXEeGe7pPh8eUg0Yxt7yt/gkoj0jlysh/gWX/Ht3rguAgJZ2ff+yXLV/+1TJjNa6kt/X
         2frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909338; x=1705514138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dOkZsTsOFQEblTAxi1gmTvocVfTF9neXhlvxTQtV4w=;
        b=toizYX71jTROHNhXze4fNypRbCd/mOQ04oc37lB61/gDEDaU4jhiuxRv+23C3IvfHc
         AngVODwctBM9ZIFn81ZpP3i/nKlH/YtVe9DqRHW+sH8t/WSzU/iZ9xZTLUY3vrEatj0f
         znlMAEQaMDP/e49NZn0ywJCZaqqvQleShGuXYu8EG6qYc9VD6KJ9uxrbOznMqYNl+kyw
         dq53dVLgCSMxWQb4V9xGoUwZHrLlVzayRFVIqQManvTdSBpeAhgMK3TJ+naGO/hGdOJC
         Y5qwFKxDWcae+LOIEnbTJcVVi2Q09MJphc5f1N+PSPijObdOf59vJsivLZIcwPEEd+5f
         VuEQ==
X-Gm-Message-State: AOJu0YxfGB0pqtaaj6xUqqVw4lmBBKgFIJpiG/FP/1a4zcmy/suj7en5
	/2pmG1ykPuYNyaH6oEYNMfia8/HZnjmXYQdc4ChyGv3mea0gsw==
X-Google-Smtp-Source: AGHT+IGCVZUVOZdnOcK/Qw/f582bd53Swj6alHBS5hSQ8zmEhos//vWmAzbugDTTRb1TI11Tqt157A==
X-Received: by 2002:a05:6214:29c7:b0:680:d2a6:8282 with SMTP id gh7-20020a05621429c700b00680d2a68282mr612794qvb.24.1704909338259;
        Wed, 10 Jan 2024 09:55:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfd83000000b00680c7c14d4bsm1883571qvr.129.2024.01.10.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:55:38 -0800 (PST)
Date: Wed, 10 Jan 2024 12:55:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] t5308: run expected-to-fail `index-pack`s with
 `--threads=1`
Message-ID: <0170befabd160bd98a32372f14b5e1e9bbcb1069.1704909216.git.me@ttaylorr.com>
References: <ZZ7VEVXSg1T8ZkIK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ7VEVXSg1T8ZkIK@nand.local>

For identical reasons as in the previous commit, apply the same
treatment to expected-to-fail `index-pack` invocations in t5308 with
`--threads=1`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5308-pack-detect-duplicates.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 655cafa054..5df552a42e 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -76,7 +76,7 @@ test_expect_success 'lookup in duplicated pack' '
 test_expect_success 'index-pack can reject packs with duplicates' '
 	clear_packs &&
 	create_pack dups.pack 2 &&
-	test_must_fail git index-pack --strict --stdin <dups.pack &&
+	test_must_fail git index-pack --threads=1 --strict --stdin <dups.pack &&
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
 
-- 
2.43.0.288.g906e6a084d

