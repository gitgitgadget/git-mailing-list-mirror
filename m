Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0B1DFE20
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449090; cv=none; b=AGLe8ykqtfBr+nTcAq6OhhzfZkhxs/12n5Bek2xKHDWGA3APgguggJkgfItPvWRQ240Hb6gKO2aafN0jhh1b9UcTp2kLSpO9FlmgAPJHPIdg+/noXWkowNJW036uiZRWRZfFW2oNlAfhLVsCvuRMLFD29WVijV8lFU6k9IlewEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449090; c=relaxed/simple;
	bh=dVxV8XiJD/DirFNN9Ve0QJXQKDtfDZMGWhZIWqMYd44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnMbllbvNHEIbDRM0FoB8DIkRCeHYTSzwdQHWMcYpSfJ5au31VyiGy+dqQGaTazTdDOx7r7jhLLQSQ4pXI5Td3ePSj+wuGKt354tqHRDyrBxxZ2tnDS7Drjj1U6fqxl7ZLBfHeJulezs2bTqqSpfqqgNA/FkVWxe4iMy8xVeQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWZPd9tU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWZPd9tU"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso4003893b3a.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751449087; x=1752053887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZRSieE6WQaq1va4WtJ30fiOLbNx2xdzfk21rXZF5/0=;
        b=IWZPd9tUawUmozXOWApIqeWKPskF8UnMJYToWS4mATsD9Mp5SUwFWPE+ADa0R+LSlC
         geJHJc7ZUx6r2Rq0nt+pJbF8I2QFG/GoTocUM25HNq1FRSn4Zsx4RdX0KNiHs13pCd+0
         1P60Mea3M/qVNrB8yL4fTLTJeIjrCMScFgwo/J7efsvRQh/laxNJCSscwsQi1pv0hZpW
         ba8SuqHqql1ARYQeJpKfd0EzbSnwcKN3nRoA2Ns1n0o/kfTdJRWBGwLWYPY15r/QtHuF
         vwtRkFw86ywRarBXrR9y0iNYL7SevyaVIhC4mDFkahFHuRvBIJrSTuSosG+0ehQ0V22O
         fQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751449087; x=1752053887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZRSieE6WQaq1va4WtJ30fiOLbNx2xdzfk21rXZF5/0=;
        b=tpIt+LiciTv36977rni7Oz2onMLLy+tWacwOn4Gu/nzRYvPfRWaMJzDpUvPvyMBDp7
         nKngB7T4IeIPHYZkmHfOjXn/+TXxEirp5M4wour+FWAaLTDOcHuSlqrpvRrMVCGqjkbd
         ujLHP2xd4z/78C+tdaP+19Vdv60l8Bgntf1MvPjN/vonsh2HGclJv0q9Yd0iXfQXjCVO
         UphvgxvKxUVhfTPlAIVGx04oKtIZ6Ixq8Bm4EnLMH+hjyRQVAtL4cuSS0cP2NfVFxZim
         WIqkzFJ6dnnqgrPYbS0YoXnU7THi8Sk9iS9goDw8X9i5z22QZkzW031RePprLYrNB5zf
         VUhg==
X-Gm-Message-State: AOJu0YxNdeWg0+QXHF4Dh1zZVAYKm01ZB2d5beiRs8SkMEtW+kdMAGFJ
	TycgRdU8VMpeFybhO1I1PCKmk1adV6sDFvUBo0KB3XEk6nYBLiBzuco2onCeqA==
X-Gm-Gg: ASbGncvlI+dVkleCf+vBWyJsRfBU6EEEG+vKPKMkWUZg+Ya63/C0EWZxI1K2Un9GzKn
	yGii+t/qDUkfwJItsyBqqhMMOhrJSepCAsJZoo+iZa07vECJ0giCIWHDYeHJ++LhNtPNoKL9RQF
	rHKl0zvfLJ5hAKlrQn0iFlr3a7raPKgCblAU16Z4Zxx20HR0npoDZFTfIeud7L+tA8uDixSD3X4
	BxJ0N2ywTvgagD5DtvTXfDY4yNhUmHVmMRvQSUKuqId1Ic6PDrtyuJvhu3y3yrLTnsyS1abUXq5
	RZ1iO0lyuzy7eRPeuPc1Zi4UYWSBsoyM447lKKobzWvr89mvxY/LyK3SqscxiWZV9K1t86KUqlI
	Lo077zz1aKUFBfbIOVA7OOczlXtQ=
X-Google-Smtp-Source: AGHT+IEtfNjkwakZ8O0Hlm7KFuYhifGLLTsCtAEYpaoF38Ru8HyYb8ixRbGBUYSleu7obXRsSe8arw==
X-Received: by 2002:a05:6a00:10c2:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-74b50e5c6b6mr3878780b3a.4.1751449087485;
        Wed, 02 Jul 2025 02:38:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5579d28sm13501895b3a.107.2025.07.02.02.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:38:07 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: brad@comstyle.com,
	sandals@crustytoothpaste.net,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v4 1/2] config.mak.uname: set NO_MEMMEM only for functional version
Date: Wed,  2 Jul 2025 02:37:35 -0700
Message-ID: <20250702093736.36074-2-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.147.gafe0d4ec5b
In-Reply-To: <20250702093736.36074-1-carenas@gmail.com>
References: <xmqqv7p0bpdl.fsf_-_@gitster.g>
 <20250702093736.36074-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FreeBSD 6 introduced memmem(), but the implementation diverged
from what was standard everywhere else (including our "compat"
fallback).

FreeBSD 10.4 (went EOL in 2018) corrected the functionality bugs
but kept a suboptimal implementation until FreeBSD 11.4 (the last
version of FreeBSD 11, that went EOL in September 2021).

Let's draw the line to require FreeBSD 12 or newer, which allows us
to drop the special casing of FreeBSD 4.x and rely on the platform
implementation of memmem() unconditionally for all versions that are
still being supported.

Suggested-by: Brad Smith <brad@comstyle.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168a..2b434df9e5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -273,16 +273,13 @@ ifeq ($(uname_S),FreeBSD)
         ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
 		OLD_ICONV = YesPlease
         endif
-	NO_MEMMEM = YesPlease
+        ifeq ($(shell v=$(uname_R) && test $${v%%.*} -lt 12 && echo 1),1)
+		NO_MEMMEM = UnfortunatelyYes
+        endif
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
-		PTHREAD_LIBS = -pthread
-		NO_UINTMAX_T = YesPlease
-		NO_STRTOUMAX = YesPlease
-        endif
 	PYTHON_PATH = /usr/local/bin/python
 	PERL_PATH = /usr/local/bin/perl
 	HAVE_PATHS_H = YesPlease
-- 
2.50.0.147.gafe0d4ec5b

