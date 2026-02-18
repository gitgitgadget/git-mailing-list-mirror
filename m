Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933B3EBF02
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449619; cv=none; b=Ps1HDkptVJ3E5AHr5PvR/v3g1OhAkLD3EVj6ftdR6Kn+ZZTLJaEtvadlgVceUAcY2rYgLWYwpfc48DgU/IGLEHmN3jTvnk/MdLIFT3CXHCNc6Gy3MsA+CP6Y7onp4YEu1x/X46V/C2P2aherGum4quFQP3AyHra3Jmqtkf1CHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449619; c=relaxed/simple;
	bh=3pK6duStGRlqfbmNEhgJ2TpC5Eb0Wljx0IeZXTLgh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrFRHPA3FIUXy93D2FnhaPoAJp7wBtJvseevrbpwu+3IHn7F1ZTxEOcUhqqUXVDwgpEitewTvbQHAn2/ZsQIakieHtwUabZKimb/kyr+vpttDqBaUu15S6ABR9KsgIUxWFBKqrlwYDXQY2pmb15u2/WtezYYqTXiATEav8wuU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkoByUaC; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkoByUaC"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5fa26e497feso115871137.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449617; x=1772054417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEvaXiGurTnSUNvKLKHpKgwOnvSRSdl6BrAlY+eHVIY=;
        b=DkoByUaCuchpKv32G6yJWVBanixNi7Hvc+Gmc+jCH5pYeeCnxShPtErRxTGAxcAx2Q
         XZXTGaMgdClt3wte7tf//ywp037yChTdLWwEGaIxhZ+PmAULj+/kfELKAWlGWFzlrnxR
         b3Ig1IUYnsVTh2DHtSZ440vb3S/G9/gu3f80C6lPK8qpMG1Pc6T1OHnoarw5CP4ByR5r
         zI7WFoZtISm6XXLcS36dFnnUDnnT7FyqhkKRGCzo4vto15b/WjM2zydYyY26e//7olLs
         oRF6xjhdQ+yWPe2W5z/2XFVI2Sqjx38W5B++OfmK+XDNEnWBgKCp82F4qSWC8hdyb1As
         9PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449617; x=1772054417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEvaXiGurTnSUNvKLKHpKgwOnvSRSdl6BrAlY+eHVIY=;
        b=kmgX939NPLW4jpmR6ZHkOdmtrMbfa0S10tw4bULzAYGj/ivGrd3rkeCZmaEPHI0z3N
         Do7V1LMFD3Lgxkxw8ie4xhk/Qg5x6hdn4dSxjlf3GzA4VblfjsWuf0Gy4jVfWTU8L3RM
         zajI4qLlB7ChGhSk8zv2HzGBw+Ivs01qET/9Mc8d/07pZll2B1irFWFY+pIt16DiJLLP
         apnT8h8brm47awEnYeiAp+V2n4mFwOQLaoA2l69cjLzWsPRwk9T820co/5tCQILZ3gEc
         w7ZNC3cRnTgNmJUVfNma3wfXGD6yFxUaSYZOdYqjKslDO4ySSA0b1m+k+a29WEXTWiRR
         g7BA==
X-Gm-Message-State: AOJu0YyhCtfEYMR2O3RSA1VDSEkuOmnIWjdQ2S8+Xyxq/tm3P9SW7b/Q
	8KDAUlXG2wrSKMabxYVM51iXIjTPjbSIJqyt1+2JsIoVflMF8kbw7Im1zp5/IO0q
X-Gm-Gg: AZuq6aLoGVS9JwsxSAo7I5Icoz7ZGeNIqiVKGKAIsTfJDyViMSG3ZGAVWEoo9dwBMl3
	C+xTJCB/i66yCISiU/pjXPy7wq9Ul628sDYBrn595rM21Eny/gsx8K4GCQCEAlD+HSeVgxeOeeO
	0Taxw5QoGeQFACwtMsBtvDdQLmFo54bCZfLeAU+76Tky+sO1r14a+6Dlr445JS6UuI63iqytjmX
	z2yUF4CWGJL/Tjc5ceh0ayuVVm4mLETPjKvvh1C6eB6ya2FxDGiM6JvBSmelTz00czAmrvszZg3
	KJELO59ZVqFTR87tYT6Dv+hGWX4ettiM9iHSzr+sYJ4XKXv+/uBhwPgpjiOSvUFreLfIDktQ1PR
	C2g8iu2+Kw7ZRRB1guy3J5wtn79zFCj1B0k5psXpm/1OrSaAHw5iX89e1NP2IUsklWERTM3EteG
	gyVAOsWEuozynMFDIHcS7ndOwUU2iqjpmteQpa3j9HGao+ZCyWAthjBZD8TfVeEXnUtw==
X-Received: by 2002:a05:6102:3052:b0:5f8:e509:aedf with SMTP id ada2fe7eead31-5fe7fc3fe82mr1148096137.17.1771449616871;
        Wed, 18 Feb 2026 13:20:16 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.20.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:20:16 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 7/8] Documentation/git-repo: replace 'NUL' with '_NUL_'
Date: Wed, 18 Feb 2026 18:08:43 -0300
Message-ID: <20260218211845.96009-8-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all occurrences of "NUL" by "_NUL_" in git-repo.adoc, following the
convention used by other documentation files.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 319d30bd86..f76f579b20 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -40,7 +40,7 @@ supported:
 
 `nul`:::
 	similar to `lines`, but using a newline character as the delimiter
-	between the key and the value and using a NUL character after each value.
+	between the key and the value and using a _NUL_ character after each value.
 	This format is better suited for being parsed by another applications than
 	`lines`. Unlike in the `lines` format, the values are never quoted.
 +
@@ -80,7 +80,7 @@ supported:
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
 `nul`:::
-	Similar to `lines`, but uses a NUL character to delimit between
+	Similar to `lines`, but uses a _NUL_ character to delimit between
 	key-value pairs instead of a newline. Also uses a newline character as
 	the delimiter between the key and value instead of '='. Unlike the
 	`lines` format, values containing "unusual" characters are never
-- 
2.50.1 (Apple Git-155)

