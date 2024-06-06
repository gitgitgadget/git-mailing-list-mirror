Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7813E04F
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715123; cv=none; b=FAqB6s1n2T4zKw17RI+ITct+tm7sB1+xPdlkeZxc4suONSKS13731dsJFgS5BTOfzipkTHnKiV3zldC5LMtMe+wpDNn6YJUgeRACDK5whz0AcvHVDvLFRVDLgVoCDs8iBwrmF5R3Qp3I2Dsu9r0a71Dr7e7uyEDiuek5l+oT5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715123; c=relaxed/simple;
	bh=WT+YMJFLaV8JQqozVknAistKWoae2mRP39yC6aRpTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlXaGDpHwSpA7epCh+vtUkM9iKEFcSYF3wAZy0lUgjQeQ2wt4EtiXHzQi1p0OQ8z9dOvKYO+scJW81Agep+Z7bmd8HOvJGcQeag1hqzajyuMgPM6cZ9B1yTC7/nThQVj+Dk8ZJxdPknRJJi0p2bJPUNtzhceiaKD/UkkLQDZPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xVEEbk9S; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xVEEbk9S"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b52b0d0dfeso770641eaf.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715121; x=1718319921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siAgDNIe88y82O6OpOl8MP25gkm1AbXZEjiTV7VdGgI=;
        b=xVEEbk9SRNQ8qMsxdVj+oypMvDidyavy0VnKZRObqbNG7boqr0X3g9kWrHQ0NCmZHN
         /NIep1KyO2ItFzwmFOM80C6fu+H6SMxN3p2TafX+gNnlVO7Eq/LU2P4MElF3GVGibfLZ
         JmwU6VySYT2iSmJ0dcP3kaX1OuqJUCt10it3CwEsAyMzoXCEKb1V+XhEDgdYmMncn683
         h7UWiM6Bm4z6f5ufBHU/CA9JFylqUISs6ffjuJgcfwbiTVb4F3odwL2SlKC+qmvytMDX
         z3nG5o/IOskyCkJBZGQHZUr6D+PPT9ojtHdj0Ikbs5TfyGkMvUTLrvNKlkQO2xTyjCRD
         QJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715121; x=1718319921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siAgDNIe88y82O6OpOl8MP25gkm1AbXZEjiTV7VdGgI=;
        b=Ox75CBOszIRUHEDdisUmbCGNUxOGjJcRdIelwHE9Ofq06cof64YEFCvbDYgEkrSu7V
         z3Fm7wjDL98J9X45oemWjaWwYGsTLZsdT1FkTCltm3+GSiah1NG3D12AO8VYuL39LFeI
         4PmTd2ILeefBZvOazp1JakkUY0RF5cstciDWTrzToNCQRRHYyfWIKUoLu170rWqpyVT/
         YrIvRl0XP9MarbKKRUHcguylWvmwJj8g63iaShZmfMGGERAojd2LQVim+lu4PxOV50go
         6OTsk+rkMcHqghbU88jVVq75YzP26doTaA5bYw2lVLVn/h2L9QKYJAYO6DdopqbqJmsT
         pcbQ==
X-Gm-Message-State: AOJu0YxYei2XkDz7BDA0+GAbvlKQU21rKTcqdluzEprlNKhHfY8OEvpv
	YtYwBcx9GbLy61b9ZBg3rS+QQ3omBfaVaCN9YAboNrjPUSeRu7FlnU/lU4kyLzNDa9nWeJh0VQy
	9NxE=
X-Google-Smtp-Source: AGHT+IEwdr73Xil/ClJTl4vVpjsb6TKDd69T8dcm72DSKLxwRI5Ytq/YxPjAEgQEYsKhF66X30LIVw==
X-Received: by 2002:a05:6359:4589:b0:19f:1f2d:8f7 with SMTP id e5c5f4694b2df-19f1ffbf65emr114539455d.29.1717715121002;
        Thu, 06 Jun 2024 16:05:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f983ea4sm10454996d6.76.2024.06.06.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:20 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/19] t/t5313-pack-bounds-checks.sh: prepare for
 sub-directories
Message-ID: <76154308d1d2ea2439b25f4efc359f0820afa655.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

Prepare for sub-directories to appear in $GIT_DIR/objects/pack by
adjusting the copy, remove, and chmod invocations to perform their
behavior recursively.

This prepares us for the new $GIT_DIR/objects/pack/multi-pack-index.d
directory which will be added in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5313-pack-bounds-checks.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index ceaa6700a2..86fc73f9fb 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -7,11 +7,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 clear_base () {
 	test_when_finished 'restore_base' &&
-	rm -f $base
+	rm -r -f $base
 }
 
 restore_base () {
-	cp base-backup/* .git/objects/pack/
+	cp -r base-backup/* .git/objects/pack/
 }
 
 do_pack () {
@@ -64,9 +64,9 @@ test_expect_success 'set up base packfile and variables' '
 	git commit -m base &&
 	git repack -ad &&
 	base=$(echo .git/objects/pack/*) &&
-	chmod +w $base &&
+	chmod -R +w $base &&
 	mkdir base-backup &&
-	cp $base base-backup/ &&
+	cp -r $base base-backup/ &&
 	object=$(git rev-parse HEAD:file)
 '
 
-- 
2.45.2.437.gecb9450a0e

