Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321C29CB22
	for <git@vger.kernel.org>; Tue,  6 May 2025 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493796; cv=none; b=tB5Ve9QBl1tjgNnTvRE8Hv1xODrsm0GtGDrcqCuEqlK/T5aiGz3ad9gEyGvyPzM50CHHHstRkTjnraTfyDy0C/9poQUw32eTTbbtOUpeBVXLPFsAw6C+u+cMhU9oEcKGM0QM7EiZPZzsABu+pWtAOxHDbFjqJ/3uCoHsc0sII/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493796; c=relaxed/simple;
	bh=6dfvJmAZ2TAHLG8ZeuzX0QQsICmMH8Jo6TVrzaNBpUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSscvFmusUqo0Eujo5yEJuqGRbyViRT4Imex0n11V9d9wKoSOTlDv3YOeMQUIAz3Sys+aXJr4MuYg1WRY6uW9J5HSnum/F+jcaRNtAm1TZuiEO5PiJjtPeAb+R9XDoM1l63NS7VbMJz/lpsjoTXc/sTs5JaRw/13io5f3gL6EB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7YbYVCd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7YbYVCd"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso59759055ad.2
        for <git@vger.kernel.org>; Mon, 05 May 2025 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746493793; x=1747098593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlb8eFl6Kta3g31vZ0YdUyURSBdZtbaJP/R61ET4vks=;
        b=i7YbYVCdDkGv4UTTLg0LZTZsCmeDojKAyXt8w8mmXauCzXS6IlezqHLbWt8gVijrnk
         fsi7Ah4b0QnU4BDck4bBTKXhAJn1W/FCvhR/sqOH6TSma/OJKyasBaz5asGsH5mCUlRN
         RZglAmbabllo3TOPVQTeITFfBzU2TkG3g7dWLK56L2qidont1hK19SMcyXWFY0djfO2p
         +D9PdzXFqmLJ+G6SfwbJqX4KImyR1tW2KdA6RrDbMcLaJnX3LlWz4EFd0seVard2cn/P
         v2ZM1CDM+YwVrsTD/ZU66+rvzfgryftg2VOaUDGOLo85Sr83j4G8rF4yo7rLaPAf2/kL
         TQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493793; x=1747098593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlb8eFl6Kta3g31vZ0YdUyURSBdZtbaJP/R61ET4vks=;
        b=gqBUA9gUXxWGGYpqw2jHITf1VuEEzKqqen6Ugw9YpSuHaZtAW1wanxMNZooo1KpLxj
         MeKr/amqL6/RjHJQVrf5MgZQ6S0ugGeXsXKYL22A+SEzqxMoRrbn9vMJj7CdP+enAhJv
         zKi/BFuZm7uREhzayYW4Hc4KDiEcxc6es2BUlW9cjFo5j4/c4//L85d+LeUGcC7XYGaF
         ibJ0cuVoSAEsGxkNEVojJayvruzHBSJ5/NC7/cb0V4Haa/GvdHW0/6AQaggcZsAQ/iLN
         mqms/JybtQsg9UKdcg37jIPvOTzBUL24sGLKpRr9m0ldiBNt54CZzGL/VKC4m4pJQsFu
         zC2Q==
X-Gm-Message-State: AOJu0YxQ2Vp4Z/VcIjJIjiiirgA8nFDn5Vc7Zd3zdLiKX5NULMRV42Vu
	5GYadxbSnhSzuKFDUa0LHjUPfYnXl33Bdvi5//KyQxo2PYMvJIKowY1uDAmd
X-Gm-Gg: ASbGncubXiu5Je2oJ+vHNBA5UPKI3loutaTIYO9MCZDMDuv1kjb2djHgpOqjtZ3vjl2
	S+P6P7uekdGiuPIBN/8or6Ujj8EBc8zorPQoz+PsSZqHu4TaE9naoyuXaZtCPqdMmb4VAmwWIdh
	fpa25ViGJBQgck8Gt3Du7D0i1F+miLQGfwYDLZjT4zHKDYrNb8RMLpafHRrRulLBDos9wimPmkm
	uzatso+Lhf/eX0od0ScbauZY5p+okm9VJqNtU2vKUzB8y++zN5kIs90Ih/6zmt+KmBHE34XdDFc
	TNOO6/92olf0W9JRjhklaFvM
X-Google-Smtp-Source: AGHT+IEbFGkdT1uXeR0ppVYoLVJptV2vUMwlfM+XMMd3IzBc6HvbhkKmeXLWdavMVURnRllHhP2vvQ==
X-Received: by 2002:a17:903:2385:b0:22e:1791:2e5a with SMTP id d9443c01a7336-22e36388959mr15055185ad.35.1746493793533;
        Mon, 05 May 2025 18:09:53 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::16aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm7851476b3a.98.2025.05.05.18.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 18:09:53 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: shejialuo@gmail.com,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH v3] wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE where POSIX uses ELOOP
Date: Mon,  5 May 2025 18:08:59 -0700
Message-ID: <20250506010946.212068-1-collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503041718.42195-1-collin.funk1@gmail.com>
References: <20250503041718.42195-1-collin.funk1@gmail.com>
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
index 8b98593149..38fce5327a 100644
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
+# ifdef __NetBSD__
+#  define SYMLINK_ERRNO EFTYPE
+# elif defined(__FreeBSD__)
+#  define SYMLINK_ERRNO EMLINK
+# endif
+# if SYMLINK_ERRNO
+	if (ret < 0 && errno == SYMLINK_ERRNO) {
+		errno = ELOOP;
+		return -1;
+	}
+#  undef SYMLINK_ERRNO
+# endif
+	return ret;
 #else
 	struct stat st;
 	if (lstat(path, &st) < 0)
-- 
2.49.0

