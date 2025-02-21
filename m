Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465A1DF98B
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160952; cv=none; b=ie7aMyoDz0txPWicrz6iCJF/geqeZkBdBB2ZJHpBexIKX4BXrCppveI5OzPlYDn0l7lgqluuPX/nsCpMWBSMaS1d6BNGOGPTpgLtvNsJtCk8wF/8VRRB1A81zrwgrgTUcqJfm5RA3GNYtbaU39IU0VjxbZxL6+RuGlI0RPzmpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160952; c=relaxed/simple;
	bh=cC0SkA9e8tjSUTrBgUkPIBf2ibAQc9IZ2q0qAQA987Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJ8KhLqGKAMWdJMcBb3dptHbZ4zQcqHw98AvxOKDsrkDfMNZIe1EyZWxGmDC4IdddsJTQD31lEY0ScyfpapOfvToRRZBu+6GG0qpjiVqBVK85kijn3hi4pWWAj3b0VV6ZrSrXOMLfbI0hf4CRbKALogXkAISegTamutJQ6q276Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rhelmot.io; spf=none smtp.mailfrom=rhelmot.io; dkim=pass (2048-bit key) header.d=rhelmot-io.20230601.gappssmtp.com header.i=@rhelmot-io.20230601.gappssmtp.com header.b=JjYwwyN+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rhelmot.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rhelmot.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rhelmot-io.20230601.gappssmtp.com header.i=@rhelmot-io.20230601.gappssmtp.com header.b="JjYwwyN+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2217ea6d8daso6649085ad.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 10:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rhelmot-io.20230601.gappssmtp.com; s=20230601; t=1740160949; x=1740765749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mu5tnYIvJAlPL1+ae1m402f85FgPP7IYa+DnCYAcro=;
        b=JjYwwyN+hXtsbC8q+z5O7Hk/GB+sYxJ8xLTOk7e20rIrIHUAowhBmoFgRyU2S7iRcY
         zcUA9Hk4f4zQwCMxqhM2m+LObGky9N7NUBxJRkZTdrs/xOOtpGj+V6EpQUzY3a3qfKjf
         XYl9+OX4D/j6kqDcmYQg6QmzXz+96Ma4wZ89pa27u5gG4zmSzHpv8XFkvmBG1tG96CHs
         8olLOi2HLvfV7TwNdVZKD9cUb1ENXLFL/YPJWYkUXek3mHxM/EPsY33GpUBqkUUI7lGJ
         e8N+yfVZvQY8JGnnkCCstBFx6LLRbAOWpKtz//VLD2PsNLxdz/azzAAYoJhyeT2/gasT
         IIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160949; x=1740765749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mu5tnYIvJAlPL1+ae1m402f85FgPP7IYa+DnCYAcro=;
        b=jWldC4WovsPg6rsA5cM9PepkgdPmdN56oBumSaEvnhEW4fbUpzHXkK5URqp1/WAuvo
         R3P2L89pTCCIs83INR+cUvkdHzs8jiqlnfjG14xFeiypWUgbJj1ZTQ7igUS9KdwSUtFM
         5VicwEx2qwkj0N1v7kcSm5bH0tZCd4ueEr33eXPA0DTKvSJriLXkU0PAxQ0/mxKkEx41
         cCsienUcjrGQSlLVFGq0z8yiKRaMstoeK9ftgrLS+Hzckv+lWMzsI1/oArEfwajYzyAr
         9zaL/jGcnnC0c76YDqZm4b3zf3RMyRIRqitPD5NQReVfQ2N8hX9Q7COiFMzBB7ULggc+
         E8Fw==
X-Gm-Message-State: AOJu0Yy3rP0s99pMrj02IQ+PGkDA8Y/PtGcEl8n9mKSLqbZRoB6hZLCN
	qSa8w9xNSgTEJBJy1+v+HMrwnAmF9KJsTjGvaSWmSfjrAtS/RHE/bzbhp4cjAxvgLCxZuJWqJKf
	9gH8=
X-Gm-Gg: ASbGncv0zqMryrq4LgG3pdjyH792vfqkDMbQrqwcJG3sdsRyo6wV2T2OxyIeo1y2LWt
	p27k/Pk8mfIqBPOPR6XR3QaIbuUKQY1kzQeyRhCgpL/qzoEJrGxPZv794ZemlNw7g9Amd+c075/
	ZXJ0BFC+eaeNXSOYQsE4muxAoz8ye0yjddw8sjiTTjoM4AIyCHlqcqG5dpnc76lG7CLhHwxqEnB
	Fs230xdeI/hLtejjy+yyxQi8PiovXsKfPwAT4qHABNDfvqYgKpAJ55pvjrFeNrVMUSR6bkriYly
	nSc8SpbNAv0hKRrPbhxXgQDI5BqeSUykDzLZ+cw=
X-Google-Smtp-Source: AGHT+IHa94qP3FiADvoES/9F/Jnts3I1Kait62QS/xR7XRqxJ9smymZ9au/nwktDxRD5GVrkEfcb2A==
X-Received: by 2002:a05:6a21:33a4:b0:1ee:b8d7:7b56 with SMTP id adf61e73a8af0-1eef3d9f0damr3032053637.6.1740160949107;
        Fri, 21 Feb 2025 10:02:29 -0800 (PST)
Received: from clove.vpn.rhelmot.io ([2600:8800:160f:4900:bb83:47ab:1e24:7244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addfbb144b1sm11427186a12.15.2025.02.21.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:02:28 -0800 (PST)
From: Audrey Dutcher <audrey@rhelmot.io>
To: git@vger.kernel.org
Cc: Audrey Dutcher <audrey@rhelmot.io>
Subject: [PATCH] git-compat-util.h: Bump _XOPEN_SOURCE on OpenBSD
Date: Fri, 21 Feb 2025 11:02:25 -0700
Message-ID: <20250221180225.3176533-1-audrey@rhelmot.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On OpenBSD, getdelim() in <stdio.h> is behind __POSIX_VISIBLE >= 200809,
which is in turn locked behind _XOPEN_SOURCE >= 700. Without this patch,
compiling on OpenBSD 7.5 or 7.6, we get implicit declaration errors
when compiling with -Werror=implicit-function-declaration (default in
clang 19).

[1] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/include/stdio.h#L236-L237
[2] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/sys/sys/cdefs.h#L299-L302

Signed-off-by: Audrey Dutcher <audrey@rhelmot.io>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f..f6902ca2e8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -195,7 +195,7 @@ DISABLE_WARNING(-Wsign-compare)
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
       !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
       !defined(__CYGWIN__)
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#define _XOPEN_SOURCE 700 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 700 for getdelim() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
-- 
2.43.0

