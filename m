Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9E345752
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658977; cv=none; b=f/yujcsEmuIcUCV7v9QA7vIn9CU+KKOi+7S+z+skC/Z2kTiHZwfDq9UNIUFB3tfuNEbzhi/1Rvset1xuD3HOErjkZ7AWwK/gTro8nCHBftixMWSWe3BLbB13VxzQrIeEGDIEnQE226r72J82JcAL9n2HH8lF4SnQ2hRhpcfH/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658977; c=relaxed/simple;
	bh=Az1EmpzrTGdgPcCaxCDlwyTjp9E3IbkaWag1J0HmTQc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nq6Cacp70mehK665ndMzI/K44/xknamFbv8jxi4uWzOkWu0zwLnCLJQghTNBBngfLD5KcSgEaPuRupul/K1pG93M9gCMJtGWK52x237VOduFkjOoSUD7lNw7+wI2CJjh6ZIWOH7QjFBXLq1qf8QLwiq7IIq6+1VzQBM5Hzn5I4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQRuU7yS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQRuU7yS"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a58057d7baso90887626d6.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658974; x=1776263774; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0xpe4rdiGBjb6BuGD+QuyBBDw82WfvfL45Lch7FTAA=;
        b=rQRuU7ySQRTTpu6q02qvbGAhOHYAtkbuCmw9nEb8hcSt/Hc+M3NA4jE+bgXvNXnvX1
         y/bFZ83z3RfN+RxYHgkYKFgoazzKb/FaM0fR+dlflSpg7+Ilfl4WwrnNSgqwE/w9PfVm
         hbh3g0ThsKSUWO3Me8U6E3hUnUKPf5ih6coE+WYoIi8NDnxAqKjM30RzdvX/0nJkR+iP
         vzDZihGCCEU7bsGa+pyl3g6jsojJLnvm6pDa/BLdiryqTJobD6Ri9hhYs6BvCpaCHi++
         9dTNPanMK4YsUkecuZlbUYU6rLs8hMWCLZqURUmTUPmmug4O7/WjNKNFoyPvXqQWEEsz
         gjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658974; x=1776263774;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0xpe4rdiGBjb6BuGD+QuyBBDw82WfvfL45Lch7FTAA=;
        b=TuUSP0ZEIoQQVGeuaBTX2JNc8YN6R5+GusJYRJZRblURR7qKA92oo4qnd8aVQG9fec
         hUyCtQixp9b/9Zr393f7T9Me6XowYNOHClsXxL1mYqrpVng1hWjoOfz5gGSbnkyBEt6M
         6hKS1whVtLSEcKi4VfltNjpF3mPAy3JaGoTUn+yIpGYV2WBdJxwiVWImqavLchg6LxvF
         iYC5aQv+rfny9XF0jnjzTjyTXb3NSbVTh6GJxHD3fWR+aC2ceVS8NtMQNnVWTGfVLCyX
         xw3evIuxXrFzNbpyIQkpoorWICOjHIJaqcEriSdbE/kfZxdMoq5XHtjUNx5Vw7r7PsUw
         BVsw==
X-Gm-Message-State: AOJu0YyPbSghOv92GvWzXAngOR/hb3GqYVxi0qICCHgud0l9mASB1uRa
	E8qunp1rXKzi1iDiRoKaVKmaUJGR4PkifP7o8tOMWZiDR3t7FzqFDL+ISKJsnw==
X-Gm-Gg: AeBDiet/TjyukOYaOXWlnfMMUsuYY2CVMTCr7LGjcM6gqhi9O2qxaGzDxi8cHLTJYNF
	jAOf4S0Dys20COBKnNco2sXT010UvAvmIL0LXFs9QApa3ZflXlmj8yYmKHUN5b3UgLPShZUzSeX
	aToW9euSoEDh2+qEyGM9LGayVIFt6yylgVGyksc35YqKpA3p/VSiFbkJJTGDmWhw2QdVn60F5NU
	z69ZJT2ILONFKXBtieYeHTCRaKLqMkRfoOInxLNEi1DYz1MLfEw9ebXVAcYsarYCmtjaP8qhWUf
	WQem56uJ7w3g3H41d3ykT1lqdd0/onh9VF76bm2TNuINK9Hh5WqW+vemx27ufEHqGBZXdv92BcF
	ESftEeU+eKy/z8rEw0sqFq4EKkvcWbKD3qV/5RN6uWa/SCRcEpGY2MAqgmApcv0yyd48dBxThFB
	83Npf7qYxWhhYDIwDQETAh+YvO4JY=
X-Received: by 2002:a05:6214:c8c:b0:89c:dd02:75d3 with SMTP id 6a1803df08f44-8a7020bd02cmr340181876d6.9.1775658974440;
        Wed, 08 Apr 2026 07:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac72035009sm3314316d6.21.2026.04.08.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:36:13 -0700 (PDT)
Message-Id: <540a5682b4ab1b7d0b0dd3c3c388c6a9f0eeb587.1775658970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 14:36:07 +0000
Subject: [PATCH 1/4] t5516: fix test order flakiness
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    jonathantanmy@google.com,
    chooglen@google.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'fetch follows tags by default' test sorts using 'sort -k 4', but
for-each-ref output only has 3 columns. This relies on sort treating
records with fewer fields as having an empty fourth field, which may
produce unstable results depending on locale. Use 'sort -k 3' to match
the actual number of columns in the output.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..ac8447f21e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
-		sort -k 4 >../expect
+		sort -k 3 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
-- 
gitgitgadget

