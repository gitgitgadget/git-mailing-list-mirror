Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57538F643
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642012; cv=none; b=WSfA7RrSvY8HDAjDOusHINzUy0iWDc0sW75GdFrmBZArkgj/M0JIxba3mlJbss/TdRoOJ2/b25XTuBoPOK8GkThJqaAj0O5nD40orLFKqWZmd+IlaFqyMp7x70SoSfZAakie2C5jo74BEJx76Vcxajy1CVbDVLJ90t2JO0IJWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642012; c=relaxed/simple;
	bh=x8gx/n5BZBBLqTpI8Xr8uWIhqLPFE1FrMhwhS9bBNHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv4GRbHCO8pp4se7qcGi8QLIAgnRYORlCIioY94K8roKDjUk8xzAgSxfbk5a/wbz1vlTCZUsdc+znqbUSPoaqWxpWGgJ1IENAqDH04NDzb7mXSnxVr2NBEpAgL+LEJKW5y03aa9u0xxkkrMfveiVdYBYUADyksRokHNoJjNS4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=O/8JZZLL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="O/8JZZLL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a46260385so27064417b3.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774642010; x=1775246810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMKQqZ8U+KIZqMM4QIFwuuTEEr9dpIBkIaLZ7AunDiQ=;
        b=O/8JZZLLC54G3J3zJv5xheAA2ZJB+0QNdLEILpow21eqwNQJH/VZaOe9XPSe3mAJRg
         eFO+SBzxNdEF0/wN6Qr40n/SqLB/rvfseCLxyXFU4cGhMuniHZko43dvSonNB5Jf4UyO
         OiGqoD2dhddY+dPmHKJbURBdlEztzQyOqPka1kRan+KfEZXCGqOqrkXJQC3aUoAZZjdJ
         KMJyz5+e+VflZCdrMSJCu0DZoZ12mUYl1r6yfF04gj5Xqtelo/29w2zqpXNtAVTZ1Jqk
         TgM84U3YvzXX3s6qtSXGvYDhuyLzjJS9tmokyld0U2ydPXHc1UsnDYgDytz4K8oInwyo
         nr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642010; x=1775246810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMKQqZ8U+KIZqMM4QIFwuuTEEr9dpIBkIaLZ7AunDiQ=;
        b=MhwV/9gAfFEIgeEnOQYD4jC6Y6eALkkYmjpCeHtwWJ+dkiKIHxusBgAD/mq1SfbvDI
         KiYbunMScHtx8iR2AnO3lEhKKyc+rl44pGI8rWl2wS6lULMgSbw2PdnSAYpKy4cCAxaH
         cCuOPjbZWyTAmeuvikzjL3o1cSnVyTP6/hIVnlxv886f0w6a8C45rT/kxoyEz2Z/6dol
         dvhuWvPk+b5EKxJ2y85hqVCMRchWp6A2FHk0jhrg72M0JSkJPXc07WKtPUNiVs46QnCU
         61vIG+bveJtgk+NNoZ3GOPho9OwV5OySua1OptLnTlW8T2Wdhy9OQPC7WflVfiYNVm7Q
         x3Xw==
X-Gm-Message-State: AOJu0Yzv3LoqhO5ca13BdDDMmWCabhDUGT9GAdw4HXM6fG4QrHbku/ui
	LIOxtCP99cR41ImIg8BWfQgKdtNiRCbUHAXHqWELuclI9uIeKqaQXs68AqfxUtdci5CSmiy2whM
	oL1/qB20PNg==
X-Gm-Gg: ATEYQzxCvuR+7mXrttMeMV7MrzvsdP8lV3+86iKvcufZfU9KkmCoN+HhsJKh29tIW1b
	a70WUInlLELVJFzlI3HcOSA6FelklGwTVdEFIlR/YZSzuFCuM1t4yffRbDalkmKUVSKRIBGlCUL
	nu4VtG6KO8Y70lirQ/RoJxWxVv1Onj8EtLXlbY/rp+SDtfpYbwZEH4/Xapm3Zn02+Og5zcJ6Nbs
	x5DzcKHQfuTw6i+FKyV99w1AUogtDTKCnkSHrO8ta0hlGA4F/KcXs2VeKdi4LmrkYl/qBcFU45g
	DOWZ8JpPToz4Kfjb5p71UtiGWu6whQoZCERAyDCr+/21CAnbpcUcKFF2ct5l//ujXqgSBNlx/UY
	eFSobaVdGPzes+BZf3yc7jKQGRiuVlIG/262NOaL6f9msBKHJZGPqjBxjw39hP47DH8lvW61AOk
	4Imq0vglws0NWIcDx7L9zmLt9CpBfq80uc/anyn+mALzXO9VjQdpOcvz1gHN/SIEWcCrQIQRVUj
	Yb2rnG+/ZR1FU0zA34K8+/2+0z2KQ==
X-Received: by 2002:a05:690c:389:b0:79a:3a33:93a with SMTP id 00721157ae682-79bde0b0492mr40603487b3.37.1774642010046;
        Fri, 27 Mar 2026 13:06:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f2f3sm30247b3.30.2026.03.27.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:06:49 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:06:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 3/5] t7704: demonstrate failure with once-cruft objects
 above the geometric split
Message-ID: <5a5090f8da2d3df3b64bd8a79649102b5a80f7b3.1774641999.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774641999.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774641999.git.me@ttaylorr.com>

Add a test demonstrating a case where geometric repacking fails to
produce a pack with full object closure, thus making it impossible to
write a reachability bitmap.

Mark the test with 'test_expect_failure' for now. The subsequent commit
will explain the precise failure mode, and implement a fix.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index aa2e2e6ad88..77133395b5d 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -869,4 +869,26 @@ test_expect_success 'repack --write-midx includes cruft when already geometric'
 	)
 '
 
+test_expect_failure 'repack rescues once-cruft objects above geometric split' '
+	git config repack.midxMustContainCruft false &&
+
+	test_commit reachable &&
+	test_commit unreachable &&
+
+	unreachable="$(git rev-parse HEAD)" &&
+
+	git reset --hard HEAD^ &&
+	git tag -d unreachable &&
+	git reflog expire --all --expire=all &&
+
+	git repack --cruft -d &&
+
+	echo $unreachable | git pack-objects .git/objects/pack/pack &&
+
+	test_commit new &&
+
+	git update-ref refs/heads/other $unreachable &&
+	git repack --geometric=2 -d --write-midx --write-bitmap-index
+'
+
 test_done
-- 
2.53.0.724.gb20b077944a

