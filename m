Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8D137E
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968389; cv=none; b=plLH0ocD1a4x3yD5oFqhZJhQT1q5HxDBXsRQUAJmc3nPcgQDTYGYtwg1CvrTIhXHGbixqsgi80/twCCENfx96/CFa57Wsg6LvQHL+oXejjwKFk1Kfoxf78xFVfGpR2zfQL7yRna/1TJxSNj++6bhWCrRIUQjYevkEYdluAnhZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968389; c=relaxed/simple;
	bh=I/0VnMuucEZsmbE47irgCHluxlQ5+l7dYuOIAiYNO/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilLxgd8dS8yQIJvTtxNRs1WsBrvhZZaKISXtTDWijWwkWvePO28k25/Id58upilBumRpbdmKUNFYd8awYTEnSRfg/KN48ZPCUa1Ag4a/kftIrFqDvMWqv+1oNjvyO0Vg6M6gkAKBAdoH0Poc77qzD267iFMvA6bAc17mGw2qbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=q36v0xbh; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="q36v0xbh"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqJupkLh; Sun, 06 Apr 2025 20:39:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968383; bh=pTOMTzddpb0+LQTrQeh3eQbPeIgu2b4ujjH0adO6eOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q36v0xbhfOSLFBayBxQZx3ObREKHt7dwpwaee7dL7nYIU1uNHQlOXJJyXTI1fodQT
	 YOzTf5zmpObuIdA/tnHzhXx+ZvpYFM5b6RxeBrOsENFa6hx8oo6SPqedP5aTErr8dH
	 hfJhTk2nEBGxkaX5KOc7JGaZiY1me7pa6k43FsYGUY1pqg2bRe1S7oGqbTG68WUCdh
	 jk71JGL6Aes14jSp/yrhhaS4N9eHKTd8UUmEAlWDW6vIejox216DtOmEyy6YkcoD/I
	 ELaSrXH91OfYiQYM0jQMED4p3incAy7duKZ5P/iJmoSigexnazCns1G713uPorluq5
	 eXHinqXsMRqsQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d87f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=fVsHCq2i0Zt6NT_ZDjwA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 06/13] config.mak.uname: add a note about NO_STRLCPY for Linux
Date: Sun,  6 Apr 2025 20:38:32 +0100
Message-ID: <8c76671f0e7dbfe2fba6a57b80bae974e75a7522.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIXNXLHSbZFCyie+sZJqmooRf8Be3Q2sbPqgx5+cES6N+YI27+iSA4j3sqiCv/duZOlkmBLNWJ7nucng5mNA4MGB36GkBd0nunLu8uzOngrszdiRoDVl
 txotfKRYm+DRJ2gqhuAhgwqxYusCKvHGPGPoBvNyajb2Xr7G8Ja33wVNJYXimELKze4eqSyLedsVXbE7BwJWUJczyBogVHziz20=

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

