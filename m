Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8633ADB6
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420480; cv=none; b=uqNjd/lB3E9rUdCg6PVFwJUY0x2XIoGZpn+qYs5GDJOnUoKP8wz5i+xWKnRlk0p4ykgoUgHVeMfa/cVHK9YBDHBoU4Y+t1nlCdm27S+xCB/2b2JJxTTtLjRgvOzZKxCZm4p4Tn6eVO1vy1dssWLO8NOLDPKFv87lx407kCGDWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420480; c=relaxed/simple;
	bh=qYGUgo3GCZ8yVIzKsn7jMxLG79rSbj4CVQhXFYPM/3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLLi++3/WwILtIwuz/TaFJ3TxsFbtMoafJzGZnJ/kv2faApf/kxzLcmgIP955PqJ0MMRk5cvfw0hwSjKTA09aC9/ildHthLuE32TdtT5s6hlDVTi67+nhRcC6WlKDVdecExYLSLq8Hx/VXVahcNwWvFe/9C14TDz1X136oVWoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=egJoIyq+; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="egJoIyq+"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso87158d50.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420478; x=1769025278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHWDqEv3StzsJiah2moamgu56bJqJxdzudIzAVgs9xI=;
        b=egJoIyq+2zp6/VzIwIty++bWpGPI945vV/rTuoWnZVmYICuyOBW8qd0qqk2KKKn9Kq
         r05Lck1OWJNz7f32qTqXB6f+4Om3mwYsdws9oeM7ZTFneOkV2Rh1mpBGa7qmTwD30M0Z
         ls+Qvq0zoj6DoorSUhEzyT1kMoVK2evgPU8c6I8FB08HaRxkrULXoRd2Cw0r9xlnfpfn
         St3tMOceF2L+8JiCvvI0lngQM7cTFMJoQ4J5Wpf713wF+zXNmwWV1Hi6bhAdb0YGMa/D
         KJUGigpRSj/VXa4ZQPgPsiJM1ei+3Ts4zwd/AYzGlreacof8sazIR2Y5a/WpjwMcUiiJ
         I6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420478; x=1769025278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHWDqEv3StzsJiah2moamgu56bJqJxdzudIzAVgs9xI=;
        b=UVQCnWYYji322ErMFyLMic/LTUxtiI3riCVInhCQPlBCYiHGid3FqBJ8M1XwcWxPJk
         vd1Pm6UF949tpgpiBsxONxUwvLqXR+38iOuqW4XeIPh/O2v0CiLAEzVr3iCZ1t/wBJ+6
         9fMQZhm34myyiXRLr5Ql/gH0eL3SNiofyiSqFCy51TwIyoWv4VXd0r7qltTaQ6kVdWNc
         gZ1pq75CKE6BgIDJ/Dd+CmFGiwg2Hkv/Sf4BhLyfCcirFmoE1NpgYc+XR+gPAysteqOZ
         eUSDKoy2kANYsvjcp7dqR/FDmBH+RxNlQpSzAlEH/JKHiGF1taMx661JGCBJLpjsf59m
         nchA==
X-Gm-Message-State: AOJu0YzR8UqKB2RsPg2lhci+soKpGw2ELvU4IhFkQ97ICDvJpbBbg+ze
	mrcgpTc7Ydxr6GCbKEB9lRkde1MOCCuNKLmVe1WIipD/tzn8xxoyeB97pccAvUrqApzJt46aqKO
	LErQL1n8jjg==
X-Gm-Gg: AY/fxX7dUSE7rQJc0u3S/4jofQi6sIiYzGPCuOkRXK3GZkmA8fINbw/xsogURIHa/A2
	+ERl9wcbQzMz3+vkRo48tPVz9MgnNpzYjCwBkY36M7AGkbb0cWvr2dGWK0CcHIiWXobBAOMd3Vh
	E6LRgznLLTpyjTfKMcRtMk+uZZnEjV44p9ocmUIvNzmdGzvISAkyi/C5xZ+YHQgl/ZkMTVLam1s
	cfwO1rLYAe0QP8iJ6M8gCfkfXbVTqKLuYr3NBImCzavV9p0TSl2ip7lEDJV+vzLK5CHvmMDT4KT
	1Btad503ri622i03sBiqm8VOUfsU9ooZy8YVLANN/4/xlpCOVQRGke95C0TFH1gKPT0UBaIzuKH
	cOPEPgUbiK16hHhGhMEtnHlV3AjNAq4RyESsywwgq/fPyn+JEFG0bMaxUBZfFF0MeH+iK//KXJ8
	FSrzThZlDG7nEUTiezOF/L8Oy6UVA3qWRh0J3t1xMLUgcXhsWOObpMBcVoJOnzFJe6wX40QrWOz
	n90nDLHI12hgdX4Jw==
X-Received: by 2002:a05:690e:c47:b0:649:3b9:9269 with SMTP id 956f58d0204a3-64903b99399mr2545959d50.74.1768420478044;
        Wed, 14 Jan 2026 11:54:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c500esm10857402d50.23.2026.01.14.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:37 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/18] t/t5319-multi-pack-index.sh: fix copy-and-paste
 error in t5319.39
Message-ID: <ff599c11f68859a6189a5b67a174784e90fe4a7e.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

Commit d4bf1d88b90 (multi-pack-index: verify missing pack, 2018-09-13)
adds a new test to the MIDX test script to test how we handle missing
packs.

While the commit itself describes the test as "verify missing pack[s]",
the test itself is actually called "verify packnames out of order",
despite that not being what it tests.

Likely this was a copy-and-paste of the test immediately above it of the
same name. Correct this by renaming the test to match the commit
message.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index faae98c7e76..efeab4d22b7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -517,7 +517,7 @@ test_expect_success 'verify packnames out of order' '
 		"pack names out of order"
 '
 
-test_expect_success 'verify packnames out of order' '
+test_expect_success 'verify missing pack' '
 	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
 		"failed to load pack"
 '
-- 
2.52.0.457.gb599f1ad4b0

