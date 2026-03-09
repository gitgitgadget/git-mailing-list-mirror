Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFD3BE178
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069006; cv=none; b=FnxzfBoT0D/9DQYpJHF/NCO5Z92al2MIpxTAPI8LgS2IYp+Z//f2LEiLlaBT+ZU6U/n+gpOyDuPM9RsdpdReB4PRSv+wgHR8VWXTzA4sBj0nVrdCvETBJrhuXzUmzqlVKTB9izcvu7GBmgQifIQcQXNqtZYSSqTT/8KH5veYDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069006; c=relaxed/simple;
	bh=bVsE8toEI3NeZO+jEiSxVILrW4NBRnT9Wo2QcLZHwmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B4xdAjWzZENOaF/p+cArFhxpBPIeZygvuf1Yylu2iVvJn1KL+jTYzQ00M5Ic0kNR+PnuTJGYvA+c6GHRhq/BLO3opk0CHhYhGtUole/4py/lEjQU/PpBqHzaqlzoMqzxC6h7Vp4iPKL7HyJsL3yGsfydP8Np/ZPKsKynvEahTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxovymQN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxovymQN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so140405735e9.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773069004; x=1773673804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8vl12ZT8U2TrMr9gVF0mbBgbLM1HsRdEyWLcpEUAjs=;
        b=FxovymQNFqkHf93KaAC8i/ToJX1d4ez/h4M5zTuFVRBem6OZHDyAEpB+6s6MOXdVTG
         fLvxGOJ247V0/9xa2HsA7/VOvzjK9dBk0piEK1ihT6z1ZWD5p7RqjQHhoHs6rR0k3qVQ
         iQtNrWONjLFWYluuP3qHNZ8R5vSMC0qW+GCoxpgUw0bGGGpDBhdqA5sX5vrM9DCde5kj
         WDRI/LYrWSDcBu0Ix7UT0Ras1+P3XBor6M/1WANugTCtgbtmowMfJk2x7vlTA0gRR7lV
         Vb+Wh6LD5INnAuOQo8CeDC3wpvrANifSp9xBQX5w11PdfDjFxJPhzWebWZmWlgS7dEnx
         UEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069004; x=1773673804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8vl12ZT8U2TrMr9gVF0mbBgbLM1HsRdEyWLcpEUAjs=;
        b=O64iDyfpbSE9bcT72lE2cnOcaEZqRqItpzA4PbHYVf2ZMDeDHfI2hxj3HPEepPuus/
         1di+1ecwRaOBrtHdIar1a7vYsHaJXrzcTNajQDZCRZO1QNq544A+nBWnooZDnvkVBl4a
         8TUEoAe8GVkz0aq+Aefvo91ySbILWR8EYlog20S0We7ipgMKQIf5KXl3ph3K3/DBwqUQ
         37linOz3AQjKsTpTGS2rpM0tYSiPSbDTQtCHeUI1yY3YOuQMN3ZtCqKk2NhkkaQlfs63
         E5DeD30YQ0G1DOCajJQMjPwFMwfVlAIYs65cbUL8yaVt+Yw3dw97jCCs7+jI9CEEvp93
         giVg==
X-Gm-Message-State: AOJu0Yz1P1/zzuz0BkJtZpMx7IiPAjqtIZxRaR/49wFrWE2k9D5Jthah
	h6t6RtZr0HAk8iQxSgVNyevk3a/SMJcgxcqPYMtWPSqPsz0bNcU8NAMHKi6VybhBktQ=
X-Gm-Gg: ATEYQzxdCfw6Afrjc8BKZyMgM92A2Phl4ibmODnflXaqMTaHNfoREPA9RyHJxRdEon2
	NbnDeFrzZk8887WBIegy8lakSAPG+R4Y7G0py0la+kofs03de6ySKAZiCEaB00lsh+tmvE+k6bB
	v/XmNp4B95AhZln9gtrWa3GUCsTN9XV9ODTWOMdn8hyDxQtDiYbSY1BmMRhcl0u8kTnL5PRmBUZ
	WUhlhxM7l3Pcr9zBBOnggs7PtjH1smFeAcNbXzsYoBWtF1GR0rS/yvYUaDP14LMqIxNowYtn2PT
	3w39aU5A3AYda/zVNp+oKMbuqD8ThSo5SNFj9syjK/5mkaTjSBfGOYUOQkn5/h7MJpMrNXyC1c2
	WDlIp0AL71k1MHSIZGwzLaEu5mQP0t4WUIR0nMLTGbDlwtU5X4fzEJF7ioRghrHXVoeWu57FM72
	82Yh00PwPQNk8QFgKUSPp/gALqTnf84/tCKV/3MIDE1+pPRUpAhCgPmZe2FQYcNnMCYjHFfqWTm
	+AH0CzRthJk/4Q1dXPufUTEMKJrnScF36UJIeqg87qbQKrV56KiUUIPag0=
X-Received: by 2002:a05:600c:3b01:b0:485:353f:c651 with SMTP id 5b1f17b1804b1-485353fc9b9mr88781895e9.22.1773069003109;
        Mon, 09 Mar 2026 08:10:03 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852e38c013sm383554185e9.8.2026.03.09.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:10:02 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH] t9200: use helpers to replace test -f <path> and test -d <path>
Date: Mon,  9 Mar 2026 16:09:35 +0100
Message-ID: <20260309150935.578465-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced 'test -f' and 'test -d' with 'test_path_is_file' and 'test_path_is_dir'

I've used 'git grep "test -f" t/t9*.sh' to find a file without the fix done as specified on the microproject information
I've done '9*' because the ones I've found first had already fix patches.
I've taken as example another patch sent 't4131' from Junio C Hamano https://lore.kernel.org/git/xmqq1rpodn25.fsf@gitster.c.googlers.com/#r

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a44eabf0d8..4507e8e6db 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
 rm -rf "$CVSROOT" "$CVSWORK"
 
 cvs init &&
-test -d "$CVSROOT" &&
+test_path_is_dir "$CVSROOT" &&
 cvs -Q co -d "$CVSWORK" . &&
 echo >empty &&
 git add empty &&
@@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
 	git commit -m "Added attic_gremlin" &&
 	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
 	(cd "$CVSWORK" && cvs -Q update -d) &&
-	test -f "$CVSWORK/attic_gremlin"
+	test_path_is_file "$CVSWORK/attic_gremlin"
 '
 
 # the state of the CVS sandbox may be indeterminate for ' space'
-- 
2.43.0

