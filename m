Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44854E1DC
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bxKqW1d5"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78314e00350so394242385a.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704909343; x=1705514143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUW3EvxsaOgQnm91hC/Mf09e44n4GjdPJiii+Nt+qXk=;
        b=bxKqW1d5Tc5PkhUmlvnuzVfCqC/EjGuW/dZQjJo6rVp7QO9Spozx1QX9ZG+9T2eT5w
         NuFcrNa2i4POcFGGJL4jYClYQcHstTVaOv3mBD//hbslzkjJQtTVib+z+MaaVS0FBt94
         YOGPFm6zaYW7FKh+/l6KeHvQRBCu8BCOKEBFL8s6q/xWI5XGHasD9HREZASh8GiyPZM8
         9z5h6fU3HbJescu5xyKgG2Aau23IPQIaOcZPTptuYdjitjKZCs4WAscHKLftAcS9uu3X
         1PWUWTuFix6cRLWUWnIGZ/eDWq+cvqkcw8JE5CbaSLFPJK4vDVHh4bt+Bk18cd3IoQ65
         G6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909344; x=1705514144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUW3EvxsaOgQnm91hC/Mf09e44n4GjdPJiii+Nt+qXk=;
        b=FsPP/MVZOxywxWRFQ+Vm4yZN5exwmTqq4gdlW1em9JYED02tgr2xrR7kNLKsdiFDvT
         4A5X15S21tmUcD2Qtn4Gvpa5T17duWjT5rMt0RRWXdqCkOPNU80K0tNNHg6Px2k1owY1
         b+P4jzXxXaFQabQkjO135ZxcEZhgxpiAHViy39D91JMZMtR9mwupziVJ0DtmneBh5L/8
         bLJQVsVbLV5wkN9Rfgylsaa3LQtHEk3SsIwq+mTH0Iplm3KR6KR2NizsQAVcJAZG4/BI
         VTszxAMH065O9kQyta3E99lVipcNIwX94pWI9kdaBTkYqPlQXOgIQESCBkBoGeadUf3A
         kOyw==
X-Gm-Message-State: AOJu0YztSw9QiqV13SfE8+BRpM/14iGe9AJ7XZ0T6+tFvRpdal2NQZKz
	xsbfq25Hn7JlybrnW/4C4P1bClSsGnvOB+HE6RgwlJ9l+GvbQQ==
X-Google-Smtp-Source: AGHT+IHH/5Lh5CLlplVF24gILFyBXAD5G5I8+mGv0yvQphH1z/sZR67M31FI/UB/68ac8yB2jmy+SQ==
X-Received: by 2002:ac8:7c52:0:b0:429:9a70:9932 with SMTP id o18-20020ac87c52000000b004299a709932mr1681078qtv.85.1704909343736;
        Wed, 10 Jan 2024 09:55:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cp6-20020a05622a420600b004280cad48basm1937124qtb.77.2024.01.10.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:55:43 -0800 (PST)
Date: Wed, 10 Jan 2024 12:55:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] t5325: run expected-to-fail `index-pack`s with
 `--threads=1`
Message-ID: <7d0017342d4f9f81a1ec74ab02aac0d3d44d38ff.1704909216.git.me@ttaylorr.com>
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
treatment to expected-to-fail `index-pack` invocations in t5325 with
`--threads=1`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5325-reverse-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 431a603ca0..dc3d2235e8 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -64,7 +64,7 @@ test_expect_success 'index-pack can verify reverse indexes' '
 	chmod u+w $rev &&
 	printf "xxxx" | dd of=$rev bs=1 count=4 conv=notrunc &&
 
-	test_must_fail git index-pack --rev-index --verify \
+	test_must_fail git index-pack --threads=1 --rev-index --verify \
 		$packdir/pack-$pack.pack 2>err &&
 	grep "validation error" err
 '
-- 
2.43.0.288.g906e6a084d
