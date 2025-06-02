Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D51F03FF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858264; cv=none; b=AePNKIPYn8JmQm+dgNgHBtgGNG9idqthy9mrC7CGM2yimN6n8lM8/anWMp1eN0RRIl2aAfG5sUR6KTwfDZji/IGwip95muMdHttr6nq6WM70Om89BQkpj0uNoYGjIYHdBB7nq6ILKEUeyg8FIScgvZU01jIsFclBkUwALchLxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858264; c=relaxed/simple;
	bh=Sma8KQuwFvSS+/OlDYdLQk0OgHggNIXDIUvpF+of+1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJILnCK40RZYh2bf2aFugXN2lxZyEHzGGzvs2DMcVCZdsad8fDYRaZciUlzAr98LxE/plQp9ddEskkE+V13dnpw0Nincq/5Ej+T4QhcdFmNdarpNpuKZW51MZBuOPlHC6taOVppFpKOsSG4zee+W2Z7E8BOMC2YXfBRfMAPaM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDP2Tw7Y; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDP2Tw7Y"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acacb8743a7so795405466b.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858260; x=1749463060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6e712+5gvVqgJKfjVJT9dbDLworGFOoIXfNeHc451Hk=;
        b=XDP2Tw7Y0k6grnxoMJ28oHyGe26/lRHoUv7zCsvnaF7muqipvYJR1k5WdQge/jXw0e
         gkr9d+4kW2YY6xMXaEjpXvrzNwlP7HqNXFaruBxUQ9CAb0eUEfdMZgzH38Fj55G8kuIT
         zSwWyilmB8wI4qIljyzcF55m3tTgY1vFOJ2OZvYttBg4CizbHEyhooFlLOrN9mmFe3y4
         ROq1bLKyCkfCbGXUcep4SWCEwCw8cxShcJ3yzDLUQJXQw/1eIfLkwpk4fGBRWKAHe2WC
         e2GFjv5F4+cJsTUH3aJlDYoHV1u2o3pbYJvZ+2lRBldHF8jxcUsT9Zy7woNPEGCouTWN
         TQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858260; x=1749463060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e712+5gvVqgJKfjVJT9dbDLworGFOoIXfNeHc451Hk=;
        b=F4V0dXZgzJ5vBUlyxrZWPo8Rj3u+EcvrePnkbj/OLO/MHyEchc0XC9f8XXlsqMbxw5
         lhQrKTNhbu/s/nPyL6hzdxmgHVQZrkCwD2Lvr/7XzGOPczWy3J+juh2uBHqeT04J1jqZ
         Q2tl0Z5UvN2KocQ5/W96XZXOwKBoavHvsfJOs2+6/ZKGrzmrOUf+Hk85+rgFENaFWWRv
         Z8uw4NZC3Kf8HJjGN8h/YURN8WgO5U3/DT2+6P22dYExEv2oWbGWrapO241Gs7fqwshw
         r2bmozYW7K1J57hbpTSJ7ES+bv5AYgh0PxGN8Ze2g0Vt81Wx08wymrryG5ilrocEREOt
         4qyA==
X-Gm-Message-State: AOJu0YyykzzTVzUEz15Tl1aZN8mIXnYiK7GPRq8zZ4m7fHFz+87Uwnj/
	YKV68PGnZkvGabATHA5PC5XJSQcyohAg7RVLIfnkUfL3YkZDNdwrjkaL
X-Gm-Gg: ASbGnctdM6wKnqw5ISVwgMCli9c6ubxoDW7c+On7NrXfRA0N01TCL8z3FVeJ9tAFaOy
	KtNXdBRGbb8c2ub/r5yStX94gBTA7vABK/epuQJsskl+oLbK+lTsNCxm8OLUB3hkZ3SQWA3dNd4
	CG/bbUL69EbOezjqCEtz4CzNPdeEOzUcpbf4SqB5wqHKMsCuGpWKbLW7kMogOV7AmITwVGoItyG
	qJxBg0vgxWsMkYqJkgjkeEzjuDrqkg0EnlPokeqB0u6dSZ0+zJQIUeokI71ZQybOLwY2tg9+mUC
	dOrgykBUeWT5fT2g33WxGl8h9XDIZCey8u4=
X-Google-Smtp-Source: AGHT+IGjNVR6LocB1hjJa1xpHapq6jvmikxYEeyQKSX3NNc4M5W1JrEP0o6u8KYFOBNVghG90k8ing==
X-Received: by 2002:a17:906:d550:b0:ad2:e08:e9e2 with SMTP id a640c23a62f3a-adb32daf0bcmr1025989466b.27.1748858259578;
        Mon, 02 Jun 2025 02:57:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:760e:bd06:5a20:3b6a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab2csm759665966b.184.2025.06.02.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:57:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Jun 2025 11:57:25 +0200
Subject: [PATCH 2/3] t5516: use double quotes for tests with variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-2-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Sma8KQuwFvSS+/OlDYdLQk0OgHggNIXDIUvpF+of+1o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGg9dZAD7jfd1RD0xrzsXyY/sNxTf0D+Ek1QP
 k/xaMTgpmMDn4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoPXWQAAoJED7VnySO
 Rox/BbgL/iyF329edn0Na1VZJ3h+eeamp0M38E4DuB+Zj2srBzsBd/gRJIDr2arHcK7qG5C3rhG
 Xf/NFEJAdivEF0vGVZRA5CYgk4VEE2c/zW8TjBzFMgFvW2RnK8nv8FnvZcEPInto5xNFNPQmajU
 UNWrz8zlBQKye+QTyLwBqx6+7F/n9PW2508hgBM6y1QtYbS0Spy4vkk1UliO5VnEkcBOe+6UQiC
 NViWJDcR9ShulawBJu6fBCINMbNDcrnB7W5H9Ni/onIMqJaMHxIb8VCdB6upJ8DcS/hyC6AlqWb
 yD4F3iC/DumuibtdK6FXVFpPlM9NlODAJ8/70ysZ1WvslJU/FRa5k73cnFy/Aehpc6PkZAYxehu
 5U9ZMJ/l+htKHjgEnn/5uMnsM5b4w5GYuloF0e6VqiJiqrdGLjVV70kF4A7Few2hk8KTZ9Elubm
 n5+d1lhZvTUJGLn6va4yTC/mcoQZMqbTz+E1GjCv5dWLeSBUgi1uKPY3lWksuvhTsgeIRF8msp6
 bM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Since expressions don't expand within single quotes, change test
descriptions containing variables to use double quotes.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t5516-fetch-push.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dabcc5f811..029ef92d58 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1421,7 +1421,7 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
 	test_grep "Server does not allow request for unadvertised object" err
 '
 
-test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
+test_expect_success "pushing a specific ref applies remote.$name.push as refmap" '
 	mk_test testrepo heads/main &&
 	test_when_finished "rm -rf src" &&
 	git init src &&
@@ -1446,7 +1446,7 @@ test_expect_success 'pushing a specific ref applies remote.$name.push as refmap'
 	test_cmp dst/expect dst/actual
 '
 
-test_expect_success 'with no remote.$name.push, it is not used as refmap' '
+test_expect_success "with no remote.$name.push, it is not used as refmap" '
 	mk_test testrepo heads/main &&
 	test_when_finished "rm -rf src" &&
 	git init src &&
@@ -1469,7 +1469,7 @@ test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 	test_cmp dst/expect dst/actual
 '
 
-test_expect_success 'with no remote.$name.push, upstream mapping is used' '
+test_expect_success "with no remote.$name.push, upstream mapping is used" '
 	mk_test testrepo heads/main &&
 	test_when_finished "rm -rf src" &&
 	git init src &&

-- 
2.49.0

