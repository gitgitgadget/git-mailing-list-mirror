Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07533F59D
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728210; cv=none; b=jJX3HJpUMQt0QMBb6Vsm04Bg18ecTFg1US/iA2ziTh57ZOH13UWyIHTJ9rFhjUhrSPsZYOSLvUD3a5nmRxyDO3XEXexUP+Mtj8nlCkiwmIypGFphc8+ZA2VD/HDB8vG1HXrzaQKd5OTOMtqouIgGZckN8bf5rdingL3XkZOx1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728210; c=relaxed/simple;
	bh=nrv5EbVNLh8nIz6EzkttYACkCRJaGWhzCetUQ7M55uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbevxbr8ROxYerNke7I7JNQ0DJ3PIrQvhCYz0wwdaioJ9HV7DLhckHQa2+POd7DkqbZFWuPwCy+mWNYPLFopLTk2bMSpYqwaqAgnyB9eDLDylDYwGMzepYENoS1HH2wWqWl5emAH3HE9VGzpz/dWRc+di/QqrR3e6IRCKjymEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9niHxJ1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9niHxJ1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1061229a12.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728208; x=1775333008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1DYtIXkJxE6AHJoBcZr1kIS+Kpm2Dqw6+N0sm1G+Nw=;
        b=l9niHxJ1kWomOFDY4OKY7aO6lihzU4plLOmHQib2S7itAdCfSXWzoL460XQ5bPmKZo
         Kun+7vUPKSBSAKSM7OF0UOnqA7FDtMXW6A9TE6VyCVlTkXC026ZQKsq37yh7SfebQJMn
         7yI1GJ9yaFS2EdxBFaBb2OgIDfQzG4B2wQy+pLJoNLFGgJ6XBE1D5faistABeAy2Ex/F
         d0Vx4A0+v+GZqWd0B1eqaboxYEy8lNyDxtpndB92d8urGLLEg/ZMR1VFaZRtDIyH3DnZ
         8odNCZRq24kibcMmGs7f3aJo6KY6OuRlXdJjuTzSJC4XA5JhQVPnS0o32Z8NBWl2up1F
         FhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728208; x=1775333008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1DYtIXkJxE6AHJoBcZr1kIS+Kpm2Dqw6+N0sm1G+Nw=;
        b=N5oAmdlmiOZkmzWNaA59MN8HO31Kcsa20pNgxlcdCq7Wu5G/nNX1ja5TQYBoirD+W9
         IWu+RGkq3DvjkH4sSOcRlt2RH9gWngCpgWYZbLJ8ibhDC1kUXJoioyohyK0pgj2nYbzB
         a4DrOjXXEOQuxiZ1SteC9EVUPi2iug130cG+QSYI4ioE316ofaSKc6x3BEv6OOgFwRCM
         qCvVS/SUKagLt+wPRtV500u6FJL0TAPROkGZO5kUzfx/4dsjvvlSBqcRUNqFoEo0nfhp
         Bzxoz+K3GKHR211OfnaAyiQM2UnPonZKQMma+B5JO2BtA37arEIPUtncVzG6H2uH95W1
         zSwA==
X-Gm-Message-State: AOJu0YxV9glyPPd98oXwC4/m0ufit+dyd5PVKNMc7Ha+r5HMkfJYlJ4I
	uOkhk9td11CcMch9gpDBNm1M3xmQH5R2RK1SP0OOa29Tenz7Qzl502qQ4EaRpWWe
X-Gm-Gg: ATEYQzyv8H06ZnVwNA5UFJCWkm1xcbgnHS3JKKxtmr4OcWsP9UDH3c1BeYSe/TwX/90
	PrJsszK0Ik/DVQu6Hz+TiJcGUMn38VC0a6nujrjRDjUIRwt4/auT4m375A8xeNVqWZhdf0Ml9lx
	77o7fOzCrjSrLpTk0qSyz9Me2e9Hr5BNRv7zM67odf8vtuq87XDvTfxuurnh062p+W6heCMht5d
	XLg+fX5YLsWTngUUoiw9+90SDRvn7zWkPGhnzD2qKREjrfmH8Sg8NrghaI+D2skXHeLdSsnDTNZ
	lR207zrsDm1CzqfuwlFRvozQ3d4IZ/BKBzdNaNKjIi6RyoIyyXioLpgCILx5L2/IYMk8N8jm/f3
	4s8nc/M8ybmIExMDP0qy3bWEsTH84F4C58rp2kqcQkz4D6+vCTPAitHep4OuSX7OrhFudcufbDS
	N3dAQ9ZPn8iHtqMmQGmTItOr22aBOtJiAA1RDwBnAzZofk7pDIGm9pXRQTdbaXgY3Pi1PRGSorF
	li2c0qA7A==
X-Received: by 2002:a05:6a20:6a10:b0:398:aaac:a09a with SMTP id adf61e73a8af0-39c87c0a213mr8193825637.48.1774728208277;
        Sat, 28 Mar 2026 13:03:28 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:28 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 14/16] t1400: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:53 +0900
Message-ID: <20260328200255.247759-15-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t1400-update-ref.sh to redirect git-cmds output to a
temporary file instead of piping it directly to not hide the
exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t1400-update-ref.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b2858a9061..9f34359eb0 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1404,7 +1404,8 @@ test_expect_success 'handle per-worktree refs in refs/bisect' '
 		! grep refs/bisect for-each-ref.out &&
 		git update-ref refs/bisect/something HEAD &&
 		git rev-parse refs/bisect/something >../worktree-head &&
-		git for-each-ref | grep refs/bisect/something
+		git for-each-ref >actual &&
+		test_grep refs/bisect/something actual
 	) &&
 	git show-ref >actual &&
 	! grep 'refs/bisect' actual &&
-- 
2.43.0

