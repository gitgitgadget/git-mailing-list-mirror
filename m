Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBB4C98
	for <git@vger.kernel.org>; Sat,  3 May 2025 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746245852; cv=none; b=MeIF3+DO66JwFG3Zc0BiPmOaWFkjogjCMtsD4NldgZEevPRB8ZxL9+R2bWbCChgMPN2Lg4nkZMVALMFSgSySBdTDIlsX228hkxJwRse/K6F3E7uwQ+kGWKr8X6jSaGS9SyqVYXuknec93LaMmCfqWBQiYPz+gbBe29757hzJwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746245852; c=relaxed/simple;
	bh=v3De2a3WkEbo7WmPRzlrqys4ArYXuxVnsQPSmU3gurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC2K8bcky/XkP+p/9PlJr9jCwxxzYyVI7wro+E5gLqpa5Xb57N71Le2vu6eFcieeCxhcUMmYyl97k27a8t181OZJUcmDnrQglPJU4Lc9fsu20MAVi9B4MhSs+07ER5l99nzWEePrTvqxi0rAJvzZbQ889V6yMQuqID0A3AZeDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewUrJf1Q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewUrJf1Q"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c33e4fdb8so29028215ad.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 21:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746245850; x=1746850650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVXWW/RkDgFZDOUtGHXZKXh6HXkVsusxlWfpJE48G/8=;
        b=ewUrJf1QtU7Qy6IPQb8ijXQxyUUNu6rG1aPBXK+AVg84eAX+lVtpf1Xj5crdwXX0dk
         +4gQL3IMXwf3PQFZSu1kfW7DcMYuz0q8+GK9ya1jlkG0SiZTKDCr9dns3OPToraBakBO
         p896aDxLBjTgJ+xTRdYs4Wk6euuHp3QRkT7BXTLDL3bYCOI2k9L2gZn+zdTmaDH8vRQV
         GuaNWLV6WHA94jHjhU3LpErFIgpJoCSuwV/NI4unOL+xO/F58jDlo6kX049CB6UU8P1T
         XfU5KRHR3W42pU7pras2dcJ2qfW8yOS6L6ae9wIswareBizu5qe2/r1O+YmEhLSOM1/P
         dRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746245850; x=1746850650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVXWW/RkDgFZDOUtGHXZKXh6HXkVsusxlWfpJE48G/8=;
        b=eiyM3ZD05sFbWZVZFxchL+J1UlMc5wRLjSmvzs5k+N9BodMvoMciIFg+8usS/bKH6c
         yxAHDjURNJ2wf5RT0JolLqoetYE5FPrdGhQcH2FyGlQEUg5x5SSuhOyDbBD+WH1bW68x
         VRpTCQOkH8dasoOg1oP0FEDHwX1iakiVCEYskdvSClPYkZ3Zsu9Ym/NXOhBfFlsWzPts
         xyJ35kWxpU+sQ1d1ydumOv1mdlsBqc9zCWDbKTtLZTqKp43HYKgCb/lZCA62NyC9cy6Y
         hsWJfoHiBt8iZaybGFgrMd59Cj53H+qNSA/RCOCGcUmBuAFykWE2um5ynl+twSc/Yc5T
         WOAg==
X-Gm-Message-State: AOJu0Yzk1P0r51Fcx/yEoNznax2LSBMPt9xIOYnSv4dJwXzLs0DxkSSN
	e+zhmryLu1p5DfXzYUbqhVTYo8Soh26TWN09qbXv7Ra0kwC9JoBfGIqQlR8C
X-Gm-Gg: ASbGncv5jvY1UzHmjnYfM9Xv9+HQ23AA7DSdpBYq4RyeiBheSrZz8dwfNl6/sFC8soV
	Z+PFONaBXfgnKTzbFvUfWuGQc+Xjdsxmg2SEFTxMS2/o8bApMzDNYWh747JinEqcCoyRaZIGOMp
	+1y8gb5Xlmbr3MWhAUsPpnCbIhf39Eg7HGOLi7GmVAAvLAdfnoUg9At+AyoUi09qe04dyK2cj0Z
	LH4xg32343kj9+Qj5B11C32DJwdWzM5MwQ/2/vkLTqIAuYYqHbmHgGsEwA3M8HLSw35E5713evu
	FmqNdcRS7RrDMKl1Fa+i2sCo
X-Google-Smtp-Source: AGHT+IFY0Y0wUvceoSax+/lZzj+u7EztYc1PYtw69uw10NIxAuWttqoCrubgl9zIoNAKMaRSfYyQ9Q==
X-Received: by 2002:a17:903:f90:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-22e1030c7a9mr83751535ad.5.1746245849719;
        Fri, 02 May 2025 21:17:29 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::4bd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e9df5sm16132485ad.82.2025.05.02.21.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 21:17:29 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: shejialuo@gmail.com,
	sandals@crustytoothpaste.net,
	Collin Funk <collin.funk1@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE where POSIX uses ELOOP
Date: Fri,  2 May 2025 21:16:51 -0700
Message-ID: <20250503041718.42195-1-collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502233403.289761-1-collin.funk1@gmail.com>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
symlink returns -1 and sets errno to EFTYPE which differs from POSIX.

This patch fixes the following test failure:

    $ sh t0602-reffiles-fsck.sh --verbose
    --- expect	2025-05-02 23:05:23.920890147 +0000
    +++ err	2025-05-02 23:05:23.916794959 +0000
    @@ -1 +1 @@
    -error: packed-refs: badRefFiletype: not a regular file but a symlink
    +error: unable to open '.git/packed-refs': Inappropriate file type or format
    not ok 12 - the filetype of packed-refs should be checked

FreeBSD has the same issue for EMLINK instead of EFTYPE.

This portability issue was introduced in cfea2f2da8 (packed-backend:
check whether the "packed-refs" is regular file, 2025-02-28)

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 wrapper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 3c79778055..f74e3f7747 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -737,7 +737,26 @@ int is_empty_or_missing_file(const char *filename)
 int open_nofollow(const char *path, int flags)
 {
 #ifdef O_NOFOLLOW
-	return open(path, flags | O_NOFOLLOW);
+	int ret = open(path, flags | O_NOFOLLOW);
+	/*
+	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
+	 * time this errno occurs when O_REGULAR is used. Since we don't use
+	 * it anywhere we can avoid an lstat here. FreeBSD does the same with
+	 * EMLINK.
+	 */
+#ifdef __NetBSD__
+#define SYMLINK_ERRNO EFTYPE
+#elif defined(__FreeBSD__)
+#define SYMLINK_ERRNO EMLINK
+#endif
+#if SYMLINK_ERRNO
+	if (ret < 0 && errno == SYMLINK_ERRNO) {
+		errno = ELOOP;
+		return -1;
+	}
+#undef SYMLINK_ERRNO
+#endif
+	return ret;
 #else
 	struct stat st;
 	if (lstat(path, &st) < 0)
-- 
2.49.0

