Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484C2459DE
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845583; cv=none; b=urQ59wfmqOaO5pNb+kdKUwNJ5i+e66mOYY1ZiLqdvdwCSbJpWslDJvUQqPtC3r2Ft6zeneQ1VdPPeP+LiYjcy0hayAgoWSpBShSA6RGXlFRAuOSEaY/1UaVHUqABvBbTs4yQnWj8lW3WJrUz6j/ptEepdQ/hGzhLt8EOdz55mRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845583; c=relaxed/simple;
	bh=I/0VnMuucEZsmbE47irgCHluxlQ5+l7dYuOIAiYNO/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJGL9SnG+UvSjt5nLav7bI0k+wOTG3tCGBZkMQoZb5yHJ9fsk6B8YBm2i+818IxVedC1zN4QiNaAsTmiFGdg6qkCvmShH9qSHxauNRbdIaWR5EL8qL1NGrD226fmlKa/bqrDX+fKQslBq3iQhubdxONzxDwhxg8HmfJTuRn4NmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=N3L3c5Aw; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="N3L3c5Aw"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2eu8KPZ; Thu, 17 Apr 2025 00:19:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845581; bh=pTOMTzddpb0+LQTrQeh3eQbPeIgu2b4ujjH0adO6eOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3L3c5AwSAImNlNqDWj1bt+jQLLI1HWSye7x1grcTVz8U4fXoxi58lD0NDtfXs9cz
	 uYz+6E9P5xTVEfwmyzkGkmHqbnOQSVjHLgcZgyJHyaLFTflfCCPZRZPPj0xNYHgPvK
	 GjAoN7KR23/PhkSNUS1uce7hBvS8VSlM89DFCmyDkIosfmswGoWD8nHknhyaGoOouF
	 eFCS0fG44E1x7DsQlAbhPDjvK/JsgZYUMeCD2m1tYdlkq6bfDlXedilFjFF3RUi2sw
	 iIzfLvSvbou99IVqIw6tQqQOs+zVhZSatb5WnmnbxjM9Mi4K6Hc+puLefQJrU8HrnN
	 Bpcs000EaOr4Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b0d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=fVsHCq2i0Zt6NT_ZDjwA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 06/13] config.mak.uname: add a note about NO_STRLCPY for Linux
Date: Thu, 17 Apr 2025 00:18:27 +0100
Message-ID: <20250416231835.2492562-7-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMUGwBMZYHzy7CYifTmjcwXRNPA6V6bPmo20ZpUGxMTR1L4yU27gGoF5M6v3pxjiSwCyiDK35UfjO2gFCYBG9FAtXiTLXeGAvkc8/h3CCCX9uPgH+Lyx
 YMunC5Sbag+/WUqX5fQWFhgJJj0FZd8d0kw98/byOZNmbBHD3FgrU5lukPe2zqby1ts7HMJ0d8EtpudeUGV12kjgyW7dHSz2ew0=

Commit 817151e61a ("Rename safe_strncpy() to strlcpy().", 2006-06-24)
added the NO_STRLCPY make variable to allow the conditional use of
the gitstrlcpy() compat function on those platforms which didn't
provide the 'standard' strlcpy() function.

Recently, in the summer of 2023, the strlcpy() and strlcat() functions
were added to the glibc library (v2.38), so some of the more up-to-date
Linux distributions no longer need to set NO_STRLCPY. For example, both
Ubuntu 24.04 LTS and RHEL 10 beta have glibc v2.39. However, several
distributions, which are still within their support window, have an
earlier version and must still use the 'compat' version of strlcpy().

If the meson or autoconf build systems are used on newer platforms, then
they will be configured to to use strlcpy() from glibc, whereas the make
build will always choose the 'compat' function instead. Add a note to
the config.mak.uname file, in the Linux section, to prompt make users to
override NO_STRLCPY in the config.mak file, if appropriate.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 88007c4f13..ae6ba15586 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -48,6 +48,7 @@ ifeq ($(uname_S),OSF1)
 endif
 ifeq ($(uname_S),Linux)
 	HAVE_ALLOCA_H = YesPlease
+	# override in config.mak if you have glibc >= 2.38
 	NO_STRLCPY = YesPlease
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
-- 
2.49.0

