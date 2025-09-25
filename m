Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB802F7AA6
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799842; cv=none; b=FxngzycFpI5vZJ2Y+d+kRlzOHNf6FvHtZPmlCpqFqHhrqlzVGhQqmy6d2Relsi0RCSWkPPN8ZhGA/ppI8Bkj5YdaQUoSIh1xEJqfGWSPhit4OEh5tZij7FWlHL1T+aJoVbjXPNYr7UYDgpoGGuiCscPSDT5eQvR5GBsaTHPQRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799842; c=relaxed/simple;
	bh=FT/DhZUgLmDtCppa/mfNImUMxrQKGybtzZzQpHIpxXo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qlfHjAoUv5nw4N7ghyjpH5RIrrCyMYlULKiuTXRR3l3YrXRh2A97SMcqxe17Da7id0d5kaAIeU+gWy5dVWI/RtJOp0o9j6iOW+9vsA0toJctflx5cY4uRwHw6QufONhd+3cfTGZD0Yf5KYqvpR/C3ioZmLx9sDB8Y7BWa5gi2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnb3fNuy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnb3fNuy"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57bffc0248so708197a12.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758799839; x=1759404639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vgLB9nGQBs12VJpqbvzIJVo9LAgRVLEY1iaAz6g3zII=;
        b=gnb3fNuyPQoX8oUp1Y8tXv6ePXVwKihdcJ0Ay5lodVenVkAzILrjzNwEuPFUuhonJw
         5AIxiEIkABG5z+hRPWHu8fyGOWABRFcY0M05QQVgFpPlttuRoVKa6jKy9mlhLYTeBCak
         npg1KIkNuLziWvI78YDcUY5azgWgueZareE9iN2enf0oem6oy1dMWdsvbRWGXnVxHqJJ
         k//9NkgbGhRw8Bxa39iIqX+yG09/Kapq/a71y7p16Xy98w0I5UWj1bK3WXyPAf6toxta
         oh+QQhm54/lJn8aHb6yJBgIfP0UdhPKhXGu0CsNYSVpNnkX0Xww+lt97dwSayBQSWptY
         7SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758799839; x=1759404639;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgLB9nGQBs12VJpqbvzIJVo9LAgRVLEY1iaAz6g3zII=;
        b=c2ElEGdIyXoaQOdHjn16ufg/DDqOXHFSk+hQnV72vZvpWj0qKFb0I7lHi1U0dbMq6c
         ZI8HEdLLSw8w9zFdP7Aijrs4PbHcBLampV/rhH6oS3QtxGe2m6kvAzg8djF/TaPKpSt1
         /4vefmwZJH61NVweKvzmvvUYW6FWMRKTYo8T/WTvvbPYpY2XsJb9h/daCFFAYh5qLta/
         a4kH5IILxgbmw3NVQyeBckQqL4NEqXJKUc5FFlLNlQeuYTXrG92QMPSTEK9/T3UwFbCL
         MYBYuD2s3qC3Z1sNCSj4Gfvhh1ZYaBz7SzYdQ9ZtYGp49sQ4Ik0C6w6jnTlvN6wDCCYe
         4rsw==
X-Gm-Message-State: AOJu0YyvBinLA7AunQw9UNCWGsDg4hPZdkSUDQAO3booYCbOxYAPR4tU
	/VbRZGs0ddlAgo+efDe4sX4hkwXC0CjwW1HN0TB5k9txSa5TznpIgUszyqUyqQ==
X-Gm-Gg: ASbGncuXSPpHTJjv2bMev/VXs4rnXGrg9CeNW045thlLyAwcpG/seCtfO4sdJOAFn2X
	5VgjGFdjnwAirtWi79krpH3sM1AcMEYOK4df7o5jrcIuizwSyKKEI6oCgAX4zDgTu4yLeFbjQAx
	ixRhtSfAA8e8TPkdLtTMJNAGVSxwgCGksg0xTqlR/KBRgQKgH64CiwOHW+1aLGHyH5zjiO4mMlM
	tFTgaCyE5AiqFTcervgPNOyxnFeKZ/2tAOiB7aU0Et7gy11EnCeh73AfELOaUgt8WMUDrB9ZzZ5
	+SjV9q9z49zEur6ZWRhQAyqS1Y3Kh9nXvlkBij39Ssd3Nt8fjcfqE4d7Gav6SET3LRoks17ysRC
	A1Q6ZplD6Pksl0Rm/6ZgaNyfAXsU=
X-Google-Smtp-Source: AGHT+IEoeqKhDo+Wlu3h4sRua4AfY4e411UPWORAkghoEoCNDzNAC+etoF6QiqZtpaF+z2CW11NZuQ==
X-Received: by 2002:a17:903:388e:b0:269:7840:de24 with SMTP id d9443c01a7336-27ed724ef12mr23112255ad.21.1758799838943;
        Thu, 25 Sep 2025 04:30:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.210.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm22040655ad.108.2025.09.25.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:30:37 -0700 (PDT)
Message-Id: <pull.2062.git.git.1758799835693.gitgitgadget@gmail.com>
From: "ions via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 11:30:35 +0000
Subject: [PATCH] po: fix escaped underscores in README.md
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
Cc: ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Remove unnecessary backslashes from language code examples.
The underscores in "ll\_CC" and "zh\_CN" don't need escaping
in Markdown.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
    po: fix escaped underscores in README.md

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2062%2Fionnss%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2062/ionnss/master-v1
Pull-Request: https://github.com/git/git/pull/2062

 po/README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/README.md b/po/README.md
index ec08aa24ad..d7757bed4e 100644
--- a/po/README.md
+++ b/po/README.md
@@ -13,9 +13,9 @@ We will use XX as an alias to refer to the language translation code in
 the following paragraphs, for example we use "po/XX.po" to refer to the
 translation file for a specific language. But this doesn't mean that
 the language code has only two letters. The language code can be in one
-of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
+of two forms: "ll" or "ll_CC". Here "ll" is the ISO 639 two-letter
 language code and "CC" is the ISO 3166 two-letter code for country names
-and subdivisions. For example: "de" for German language code, "zh\_CN"
+and subdivisions. For example: "de" for German language code, "zh_CN"
 for Simplified Chinese language code.
 
 
@@ -126,7 +126,7 @@ you add a translation for the first time by running:
 make po-init PO_FILE=po/XX.po
 ```
 
-where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
+where XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
 
 The newly generated message file "po/XX.po" is based on the core pot
 file "po/git-core.pot", so it contains only a minimal set of messages

base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
-- 
gitgitgadget
