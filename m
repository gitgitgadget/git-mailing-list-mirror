Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED42E06D2
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464909; cv=none; b=bM951UeGdaOHkBEkygbeXpA2ubyKJmCXWenav6mrrKTd8OlLi1feO02P7NYlJlcqzNzu4gnSNJg3woiOoEIKxhj6s7yrFesGT9OoyKuqrg5d78ot9VuYdZDbbLznRdHoiGsHufMTSnpp+xVHnGXuINWslye9ViFQbforb3oQdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464909; c=relaxed/simple;
	bh=z/I+SHm7iz4UVbE29Kv28lQnyEo4tdYrgLWMVXM66r8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LTGdZuysTlBJFBfGu+Sqq49t6D6olxZyqlypJxxQHkBD12HdPwRsjVF9eQPiP7bAX7yEaD1QRDs6OnGvMGzGylwpG4NMeADjTUqHUx+dEZ7nYq0sLqJvoVsB7GnOS6h+wFlpY5Actet99YxLj47uTrSIA6nHiCAxbtwp5ddNUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uwn287o2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwn287o2"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso2918699a12.2
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 20:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766464907; x=1767069707; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm3HZIpy6WCSJAHzvf7btzbdWz4fA0XK903OlbnwQRM=;
        b=Uwn287o241Q+/m9vATqrYL929+8E0NRwVcWPxRowrCcg1v8CE++5lMXtOU3gpI+zyd
         QmyhG3PFatkFjULsYP8ZnMlgRovEQRQYgD6LXPyQ8Dwffq4Lmqw0F0LxP1xUbm3Gjzsb
         vAAR9rF//cf7vOQc83J49AmxPHAlbQxtuYITfsw0djOUbdiPN4Q80qMPj1+uIZdxH3Nt
         kludR5SckDEOGewE5DdfrCGsx+czN4ssHZpkBapWFKOxgTw19fUf/JdyIJ8jNA0yQ1i0
         SYPzuDo4Ivx4HEstzpw9pjIae1DBtHOzoGrmGX78sHImuWljJy+NAYseRw02P/T+SxMk
         XZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766464907; x=1767069707;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm3HZIpy6WCSJAHzvf7btzbdWz4fA0XK903OlbnwQRM=;
        b=Bdl+t8oFnHWHiW8KFkjKIpdpbVnhvNbpFm/f33uJgaEYvPkGztvE5UgeCROamVLKMd
         xzIqQC50pg56y89vOOFG/Z6fYL9XNkrNKW3kAtODVsn0e+5oiqWvtUf7dXig4f/6zqz9
         8W35bNKu3Iqr2vP9bGUUfef5IlyZX2H6rTLLSjRnA7pfLsAZbuilfaZCcA+pL8XqTdKF
         W8TMFN3TzIJx5PJwA9ghJ/zQX0hMVFg0ab6tUnC6yED09sLlUbypHs2czi98sFwCKFGX
         Gcx8MMwMthcICFW292tLMGu6XaZRA97haWaiMZWJ9GI8rRSpK75hyX0zrY9nIW3B5vYl
         DeUw==
X-Gm-Message-State: AOJu0YxV19+51XWswptsJFr7jSjaDEOhHWHB2DVz7bMt4qed49xzvwIl
	NLVO+6XnGxuItDPqor6ryOwJYOjO29G9nofCIr/OI2LyMpkBtzxY+xMAOOMqMVJ1
X-Gm-Gg: AY/fxX67aMNMzWoGbz8O4Gqk4tOtGqX0BicgaSIIrv0w5LAz8ZzEROAo4vamA8/Q46t
	QJnjOOHTQD5vft7uSFv07bWzRgzBSuestpTn71s6IEApmW2oSd0EjSb10RXou/PodOtfsFdSqmq
	QCXm+/h16py4n5nhkT/3qltjt0fgWdx1DWde25gaXZyKj5GXm7KlH6Zz26XZJAZBWtIPKljpbfn
	S72mZiVSg4UXnnf1ao8fGDNL19MX0OxoxrNhCVHtvTQ/qnGW+8NxtIjVQFTNRFaxfWGt1UDilN+
	wAzeMJlBVjAn9Emhgr1rQZ7X+iz+EBmCjnnbFUkM+WxDnlZUgkATOSzqLv7mASeuTBhuWTncaUD
	73bMN2cEMhklam4VCZ9Sp5YvjYIOEWsRAd65btg/yLI8cXcEnXwXu9Q+M9l1neWVIiqwr6IryGs
	ApSFLMaJfT0Fdjhw==
X-Google-Smtp-Source: AGHT+IGyi4+Xceg8xONdkh+KYhrXdH+qR3ATcbkS+TXPGBO3wK3ONEl3usxnVJ3qwRkQ5zj73wOfuA==
X-Received: by 2002:a05:7022:6983:b0:11b:9386:8273 with SMTP id a92af1059eb24-12172312cc6mr13234592c88.48.1766464907087;
        Mon, 22 Dec 2025 20:41:47 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.198])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm53537705c88.4.2025.12.22.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 20:41:46 -0800 (PST)
Message-Id: <pull.2139.git.git.1766464905719.gitgitgadget@gmail.com>
From: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Dec 2025 04:41:45 +0000
Subject: [PATCH] xdiff: fix outdated xpatience comments referring to "ha"
 member var
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Yee Cheng Chin <ychin.git@gmail.com>,
    Yee Cheng Chin <ychin.git@gmail.com>

From: Yee Cheng Chin <ychin.git@gmail.com>

The `ha` member variable was refactored to separate `line_hash` and
`minimal_perfect_hash` ones in 6a26019c81f. However, there is a
stale comment in xpatience.c that still refers to it. Fix the comment to
make sure it is consistent with code.

Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
---
    xdiff: Fix outdated comments referring to "ha" member var

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2139%2Fychin%2Ffix-patience-diff-wrong-ha-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2139/ychin/fix-patience-diff-wrong-ha-docs-v1
Pull-Request: https://github.com/git/git/pull/2139

 xdiff/xpatience.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 9580d18032..ec65932e21 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -92,14 +92,13 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		map->env->xdf1.recs : map->env->xdf2.recs;
 	xrecord_t *record = &records[line - 1];
 	/*
-	 * After xdl_prepare_env() (or more precisely, due to
-	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
-	 * is _not_ the hash anymore, but a linearized version of it.  In
-	 * other words, the "ha" member is guaranteed to start with 0 and
-	 * the second record's ha can only be 0 or 1, etc.
+	 * The "minimal_perfect_hash" member of the records (AKA lines) is a
+	 * linearized version of the hash.  In other words, it is guaranteed to
+	 * start with 0 and the second record's minimal_perfect_hash can only
+	 * be 0 or 1, etc.
 	 *
-	 * So we multiply ha by 2 in the hope that the hashing was
-	 * "unique enough".
+	 * So we multiply minimal_perfect_hash by 2 in the hope that the
+	 * hashing was "unique enough".
 	 */
 	int index = (int)((record->minimal_perfect_hash << 1) % map->alloc);
 

base-commit: c8d76f7325e75c6f0549fce29ea4f3d97eb079cb
-- 
gitgitgadget
