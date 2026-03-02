Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E53FFAA8
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461340; cv=none; b=qn1dYh5Rhkr5KPkL1Ka6H8nUJRceDJ26TYg8BNGPUwe2/LYDZgpLjcvEj2UhW31FnTCIE/L5ZJusFdyYhYaFKHJicTpoEALeJv3o87RhfmO0eZQkTCQtmzfu7nsa8wSbby1Nf2Tvju8QpH+teFr79i2yPR5V2bFAj1MCAEEXOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461340; c=relaxed/simple;
	bh=mOCz2xOvkNTjEwHDKQd4nV7VNNInhZ1cTQguLR5OCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPJNkZzqGaUTFmmRZmDnR6oG6/ontnBjlYy01D4S1AuB67SnDBeWB1PzqpFSTwRMmO6tXJfY3u63oxHmJ99Ms4I17qH76dnaOQYH/Pl1c8Y5Lnzqd4E0Enmux5IrXKy/kp6RTT6pIwp5koarHIMDMKdXVHu83aeGxCeNnpEuXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri9ChVBy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri9ChVBy"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6e1f417918so1290176a12.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461338; x=1773066138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQodJtzGCkugPfART5Na7RYlr9mtG4IdQg2otfYUaAM=;
        b=Ri9ChVByOxzCO25NOCShajRYZr3tJLWurBM+Dd02+/TbVw3hH3NTV8RE1Fs8AKZ5cE
         tPyxYF2BZUq3MPacb/VnslTNwBxKLQSZZL0ItumNvKP63bgb75ya50xfHE6Jnysko2wi
         thQRl9Y4WjiJp5yx8TLf4EjDtn6kciGwL2OMQgY9thP/SaamyJ7eSX3YcsBa9A/gqC9S
         WYNvaTByUMfNUE9GFj2IYm0yLg4A9uiI+LjsIbXN1H/lOJL7Vp6fCDRP+yhbsXxe3Uf7
         romP0xnox6ttwrghSbByMFlE1ZXc3Z9KMl41hoTfEm3TeVsC7UAbgtQeZCcCF08I6UeN
         y7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461338; x=1773066138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQodJtzGCkugPfART5Na7RYlr9mtG4IdQg2otfYUaAM=;
        b=VBgN5Msj7OfMOJx9hOl07cNlCFEhwEvkAb9ka3b8SLnO2wauvIQV/mrc8yuKW+D/Kx
         wHrUsVX+iRzDxN89yDoqPboQwEBC3WOrws+eUE16/VK0RR4Dn+44WQqU8NaTrSoWv+re
         a5oA40fHBnBXATEACZ347qzz2k9N6LQc2Oi5YxZsxkEgyq5Y027Z5y9BrnriPEcNf6u1
         /0Eyosg+v3tjzIXrRJjZLwk/kJFNhkajP8xC/PKN5lZDYTEky5rj7LPkrfUZtBVaq2x2
         DzX1DdxkxX62H3koJj2U+9ge1ub9k/ssr6azf0EA1lkNQuAnLQIc6oxioVrgWLOLbGla
         0MDA==
X-Gm-Message-State: AOJu0YwS807cjvbtUG666TFX9JwurV3WjXdy2gQfjRhATw87W1EHq7Lb
	25ZjoMFKBnPNVT5MEHvRfXhTz+PSI+u0Qh09NxPCrm3VpDeAYEqjx4WqGQUOxZS+
X-Gm-Gg: ATEYQzyebFNhwnnChCx5JFDi5Xt0WNHTiXHs6o0KCjetQsfC+l+zcGrp2natAq5F+8I
	seUvPT7xDk0BsnbZH7Jwp8BoKgMz4u8h+bDYUtV0m58/39MPuxvMfUwNMcrGJYX+9PT2+flVHSH
	w3AgYwi0FOKLCshnms7eg9oaP/JZXAci66XcvSNMRLuCidiiYAEfmUnpRZTIhWkEGd3T2pb5p71
	CSdXzhXyufJdCp3Lfu2t/eKNA2Ahyym/kwFXUJ7xeddCGk8zxSn4BTWHeCZ5OZJHe+vKBfQy3Z/
	v2X2+g7Kv5OF9r7DrASF8M0loAHBPwzZa5gyIeHeVM8ycxrdEM5MgjlOP4bSBW/8fLO03CEal9X
	6OWpXgqfWmUyTwkH2rW7dBVZ6x7jDJv+A2k3Uc46QoNrxhHc+iHyyNwvKIvAkijUQevs9DvDLVA
	6hKGe7EYpf5XQ4RMkcw7B0TNVg7lb2067/pzVLs9Sct2X20It7/6e0Wp0mx49Kx8NYlbhSXoNyM
	gHpAwlzx7ZIkaPA+2nn+I724eEqhzzGpTkStvakh9I=
X-Received: by 2002:a17:90b:52c3:b0:359:8eaa:7f42 with SMTP id 98e67ed59e1d1-3598eaa81e0mr2856603a91.18.1772461338274;
        Mon, 02 Mar 2026 06:22:18 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm11329843a91.2.2026.03.02.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:22:17 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 3/3] path: remove redundant function calls
Date: Mon,  2 Mar 2026 19:51:38 +0530
Message-ID: <20260302142138.712273-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We fetch the exact same setting up to four times.
We fix this by evaluating it once, storing it in a local variable,
and referencing that variable.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 56be5e1726..5cd38b2a16 100644
--- a/path.c
+++ b/path.c
@@ -741,18 +741,18 @@ int calc_shared_perm(struct repository *repo,
 		     int mode)
 {
 	int tweak;
-
-	if (repo_settings_get_shared_repository(repo) < 0)
-		tweak = -repo_settings_get_shared_repository(repo);
+	int shared_repo = repo_settings_get_shared_repository(repo);
+	if (shared_repo < 0)
+		tweak = -shared_repo;
 	else
-		tweak = repo_settings_get_shared_repository(repo);
+		tweak = shared_repo;
 
 	if (!(mode & S_IWUSR))
 		tweak &= ~0222;
 	if (mode & S_IXUSR)
 		/* Copy read bits to execute bits */
 		tweak |= (tweak & 0444) >> 2;
-	if (repo_settings_get_shared_repository(repo) < 0)
+	if (shared_repo < 0)
 		mode = (mode & ~0777) | tweak;
 	else
 		mode |= tweak;
-- 
2.53.0

