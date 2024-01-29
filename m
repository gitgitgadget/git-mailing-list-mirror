Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0679157E72
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562518; cv=none; b=JZkRs1WcBBRnYN+1hqwKiDkDJ2Aukj8lfnAloU5A8xYXwEii6doD+rkMxr61KRIX+IH8d6snugCTguXpgsPrbR4/QWeIcrILQLfnukMvCFffa5heaubo9gFNFmOdgUXhPwkVuEuh8wsL75/NFDty7NfrJzknz/SbuR2JKcN1DAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562518; c=relaxed/simple;
	bh=fxNDPOkqNw3PVqKg53u0K/eLN3soeFhs1YHr+shk9mU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DHFy7RaDf8MbQUP+GTdRAXtXqLEEAOU+9dE42HVTi/EizrNtcRej9ea3qHmjAn9jbafzDKRn4NDxOCws8UV7XtJCkG/3Fbf8qoY0NKNEfCrBtJldEMtrgwdXqv5fWYbqKtoJEj9Vp59TINyBTNBqvoXsa+Y3ZgbPwqoe6StkJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c03+k+Yc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c03+k+Yc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eec4984acso25552925e9.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562515; x=1707167315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjNb/0U1GW8AfEhJ/HJ0Yg/Di8d9jKHHq8wRoOIOEeg=;
        b=c03+k+Yc10zh5Qce623P+RMZti/XC01SLuy2d+DLoByCh7+pr8kox0y/m1QkTkR59g
         EbS0NMv936UTe/ra7cm/CD4H+sSFv3KpbO6RTlBjnLzdtrz1tQ3/bWkx8/pzktuJta+U
         KzfoYOETRaoAQ3Fv9A/lTo+IEmJ3A5hg4lE4RxyLhDFHT/oZUrCO4AqwH2CgqEsGkR4A
         LNOXEwMVkiq4OS38iOXwSTNqegW71Nlb9AaeDhu4jMtFExTeW/gy+A3+DolMz6TBa+GO
         MPyjbhLY+hCu1lT1UUcXcL/SWDAvhWORpwOqy6LSM9On77w+Ms0beiANSoiGtnm3WyUs
         6Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562515; x=1707167315;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjNb/0U1GW8AfEhJ/HJ0Yg/Di8d9jKHHq8wRoOIOEeg=;
        b=WalqhnWTbFpEbuKJsiRuoQpBiiS82Qw8qA4KglIukU3ZjSUH+kST1sBOdk8Doh9y1N
         DM/wr+ySYlw5mCj0qNr/tteaQweR+hq5CyQRuBMUw1sQYGSvd6UHrHEi7Y6ANnXFpjqB
         9QWRKVbJpiCAONExn57SXy/hevaghuTPTkRzK1uU7/MC1qiQJJgqcgkWuIZIDpPw9LKB
         V4kgMh9k9hpM0MkrMaAQ1l61SnJMx5pv+La5+4bfMTtECF+xzHLAsVY/nJ6zN6uKrNha
         1tDeB1GQmMN94YTGrO4lscBin+HkGA0Mk7YQyIy9EssUN/uYP3PrMU4kgg+EUC8YrVWR
         I9fQ==
X-Gm-Message-State: AOJu0YzTFA19pO0Ltyjgr1zY52/AATlgAxM+xKRMf7gvT0AFpzoyFbYx
	vA/zjbUwBZ+7gwS2bxQh+a5F+vg7LeQUV9lKn3nBVAQeAicxNf7MTBez6rDY
X-Google-Smtp-Source: AGHT+IEVO5mqIDapybdpbQEZ/L/d7hfTQsUbBpgi9A/6inZ6auAbDwoDlPk0YQJM30+MovNEZkEswg==
X-Received: by 2002:a05:600c:3b28:b0:40e:e2eb:bea8 with SMTP id m40-20020a05600c3b2800b0040ee2ebbea8mr5828550wms.0.1706562515246;
        Mon, 29 Jan 2024 13:08:35 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b0040eee4931c9sm7928192wms.48.2024.01.29.13.08.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 13:08:34 -0800 (PST)
Message-ID: <dc7e07fa-a1c9-4515-a903-380ce9fb81c7@gmail.com>
Date: Mon, 29 Jan 2024 22:08:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] t6113: mark as leak-free
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
In-Reply-To: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This test does not leak since a96015a517 (pack-bitmap: plug leak in
find_objects(), 2023-12-14) when the annotation
TEST_PASSES_SANITIZE_LEAK=true was also added.

Unfortunately it was added after test-lib.sh is sourced, which makes
GIT_TEST_PASSING_SANITIZE_LEAK=check error:

   $ make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=check test T=t6113-rev-list-bitmap-filters.sh
   ...
   make[2]: Entering directory '/tmp/git/git/t'
   *** t6113-rev-list-bitmap-filters.sh ***
   in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true
   ok 1 - set up bitmapped repo
   ok 2 - filters fallback to non-bitmap traversal
   ok 3 - blob:none filter
   ok 4 - blob:none filter with specified blob
   ok 5 - blob:limit filter
   ok 6 - blob:limit filter with specified blob
   ok 7 - tree:0 filter
   ok 8 - tree:0 filter with specified blob, tree
   ok 9 - tree:1 filter
   ok 10 - object:type filter
   ok 11 - object:type filter with --filter-provided-objects
   ok 12 - combine filter
   ok 13 - combine filter with --filter-provided-objects
   ok 14 - bitmap traversal with --unpacked
   # passed all 14 test(s)
   1..14
   # faking up non-zero exit with --invert-exit-code
   make[2]: *** [Makefile:68: t6113-rev-list-bitmap-filters.sh] Error 1
   make[2]: Leaving directory '/tmp/git/git/t'
   make[1]: *** [Makefile:55: test] Error 2
   make[1]: Leaving directory '/tmp/git/git/t'
   make: *** [Makefile:3212: test] Error 2

Let's move the annotation before sourcing test-lib.sh, to make
GIT_TEST_PASSING_SANITIZE_LEAK=check happy.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t6113-rev-list-bitmap-filters.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index 459f0d7412..a9656a1ec8 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -1,10 +1,11 @@
 #!/bin/sh
 
 test_description='rev-list combining bitmaps and filters'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
-TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'set up bitmapped repo' '
 	# one commit will have bitmaps, the other will not
-- 
2.43.0
