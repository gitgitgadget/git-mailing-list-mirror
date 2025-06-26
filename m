Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38E29008E
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931563; cv=none; b=ajx+QU1hk/IOGUiedrthL0GJ4myutuHxxTONLh8UCu1/+vm7FLNEbj84zf6YVGYYr7RAq7CVIv5LEBkCHshJW5Y0Rvrr7fHycdAiDqYzhtFPOqDdjl3dHQ4Lv6y8v+6VaM3rNC8XQqiu65UbeYjfOcJgSpwM3H+mgd5+ZLgRFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931563; c=relaxed/simple;
	bh=vG/e9Cz754PuQ3f2VUHG7gnGtSnljUrFEp9Iy7F8R6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzKe3r9DILsDPWcuoHloOowTBlxKi7rYiGjrkcBF+GPrXr+dZY9MVX0FBmPKTPfInxmbpUEU8jludnbYftrgTlFfbmBztvy1el2Kg60Jqtuq8/IGhKdU0ZIhqPtPnL1AhUbvMoyxV1Xp/doPaVwB+EoOhn0O9P11FY26JpqL/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEKygc7M; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEKygc7M"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso861813a91.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750931561; x=1751536361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+ZQOqLAcIiH2Fq8VAsRmiwIBhkkCXBh+PeTyV31YxI=;
        b=GEKygc7MkkN537pV8CXKo3N/cD7jQGrX9TaNDcrFFPCuzzQBO/sDYVplT5d/ciQq7o
         FN98shepvkrm92RrM4KR4ElXARmEoKx5Zj5yhxEC5EIsPPm1L1VtSz67jmtMFwrfRYIh
         KlIau24c7pBRdON93DBSILsKQw53YTvCkcckyY1MGnN7iWD5CXHT8eQTL9H/vmE4/urJ
         98VavyHto4U6kd8q8GRP3PIjMP6YkywIYVLkggv6UVrZfivMrwwb4u17H78OG/SGaasU
         q/moBRHjrOgYevqX/72XFsNXLOX2G62csXdF891/K1zm1jqvb+DeRtPnP+p528XN3Fjh
         htuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750931561; x=1751536361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+ZQOqLAcIiH2Fq8VAsRmiwIBhkkCXBh+PeTyV31YxI=;
        b=XElwkZV0a1mfuTyjLN5coEczPG3DyNRxeEYtZFWicCJfg3jcizfJAoapTEQscYofBI
         eCG0gyJ2ESewna8etV+H4CgHW247qsUt/fhr79Cw4nmlRywjALxUl05veKmZzzfiKWRk
         kg3fNCbQij7SKsesyJ/SylEChG/uPda71tF3shaUZCbL73RaPvG9B4sS4NrJRMjmzN6O
         yAiE6a+ztmFly2S/or/f44/3tj8ogut3tzMEcRlXPi+ZXTgOLI++7cr50y0KXCaRWHYZ
         K1WID/rlqSODjw6nKp17hWmH/1nza3Era5LC1HqVRauqNpdhUHSwKDtKNMhlt9j05T/L
         DvKQ==
X-Gm-Message-State: AOJu0YyKyJgHmgZZm1vLOuyoR6lKY7RKFxha8XAbAHNEaASWnCeO/c6m
	ppIwohmltJkawDfH3W+G/6h/eEy0pahi7B/SvCw/ngzcrI8maQFHqUP+KCM52Q==
X-Gm-Gg: ASbGnctQx3UN3aI0It4hVBCMa+uTVLKl9MBZ5lku1yVxg+xM4N3IPwn+9HdquE0uXHK
	BO+/RDCo0UUzndx3/NNiEcfeLa50kX6nUQS2mZnYEZQOINusqjNs5mQru9aoQAkVGExzsrSOo1s
	B6a6knIJO/29IKkprMBcbHgb4n08o/emGmUuO5mqfEEVflo4PCSgh8yQdIC3HCvy6fRI9dAqQla
	JLrKPRXqz8Hd4pv9gtAxieKKC88tbHiG+20A4PSSmA+h7iFuCgoHjooAEJhglp+p+xMmaEuNW6+
	etVDnRKpAH/lXhQayxhZlSe/9hXla+CwaJfMZpxYULdgvObiSBhWPPRWaQRZcQ2ZVld6Z997U6Y
	eVi8ITtYKvB/9ha7G
X-Google-Smtp-Source: AGHT+IETjoFKEwNY7x4uxy8R7duX4u1QXOWaqg4bMzcZxGqLorAo9PKZEThEmokDjtQdAx2dqOam9A==
X-Received: by 2002:a17:90b:2c84:b0:311:ab20:159d with SMTP id 98e67ed59e1d1-315f26974afmr8500707a91.19.1750931561380;
        Thu, 26 Jun 2025 02:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5426bfbsm3750617a91.24.2025.06.26.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 02:52:39 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] daemon: remove unnecesary restriction for listener fd
Date: Thu, 26 Jun 2025 02:51:39 -0700
Message-ID: <20250626095139.70751-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.132.g8e5a977e07
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
2005-07-23), any file descriptor assigned to a listening socket was
validated to be within the range to be used in an FDSET later.

6573faff34 (NO_IPV6 support for git daemon, 2005-09-28), moves to
use poll() instead of select(), that doesn't have that restriction,
so remove the original check.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..99741f0b45 100644
--- a/daemon.c
+++ b/daemon.c
@@ -990,11 +990,6 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0)
 			continue;
-		if (sockfd >= FD_SETSIZE) {
-			logerror("Socket descriptor too large");
-			close(sockfd);
-			continue;
-		}
 
 #ifdef IPV6_V6ONLY
 		if (ai->ai_family == AF_INET6) {
-- 
2.50.0.132.g8e5a977e07

