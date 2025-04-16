Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9E24BC03
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845592; cv=none; b=jnsPau1FEuGCDApEY2THJsPK0GV5i3txcBRPeWtZEyD9odwiByZATukDERRvaNMbxKqnjZ677qt5hr6zKvPj8CHRRuCm3eKCOhHxaVZ7FhXxzi60qDFtY1AIVrznrMxLc/xRC2YVRu5OzRzDh6bs048q5w0fndINIl3knzScWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845592; c=relaxed/simple;
	bh=UQXOXZFPKz32spLJMrN2Bvq1awCw+L/x7F4cSXtvx9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvFiayU66VSyTRu2jnUTIaPLnLbI2fb4uPkJBUfD4c3lmDjHfvoUIFymRy3Y7zmNDQC7ZsL/oiWYAFJF4whdOratAKrw0Qonwadj18+HbUfaLxlxwVGUdx4JhXGtkaLyqOB65Tj3v0GKY0cjXnvAKwtnUULrPMKosWT17u9dQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=EsUB7bOB; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="EsUB7bOB"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2ou8KPk; Thu, 17 Apr 2025 00:19:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845590; bh=GDmQdgy1XrzzI8HxCxapwf+A7H6WsB9/218TGTVDW78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EsUB7bOBKtPvBG0tyeqNXPsxu/qideBPMc7tnUX5M+8QDQixBg/j9Oc4Qo//k7e0R
	 CKPezCLhvaVO4h49nmRzYOy/iJekcOg23FcZJr8X1PsdLuUVYSObOhBB1rOsfqTxFX
	 S5PQE6HLO/28KajY+pRuqw7C/Cz140Afpn4v43JWSwX7EyKRlM5Lo6FQ1lYSpEYQom
	 1uf0Cx3VMXipDfjdKgcuH3Z0Ymr3IE4R2at78ZlfxVtrn1RLygwZM4AqUb2lACrIGR
	 bw5W/qLo2qNukxAUHURH0raVLn9Qss3AgdOdzNCH8vVGv881+JXPbjr0zaLip5eexw
	 YDyTsSMFC905w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b16
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=5XmO7F8k-BOE0I3eWfsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 08/13] config.mak.uname: add HAVE_GETDELIM to the cygwin section
Date: Thu, 17 Apr 2025 00:18:29 +0100
Message-ID: <20250416231835.2492562-9-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfN/JAUvEIpIOD9OUIUpSo2FU4E9+f+nhHUYrcIWBMuQULN9uglhVYyhsmzzX5hX33EtSoVxO+nRzv9d0hF+Utw2XWU5gO25SavRYM1SnP4veZOVreZJH
 4M+ZaX/JlJlTBM++4IlnVKVC570SIyRlxqbI3/zHDrgRQcZOMwGGEf5h34s+bsDPgjAZfM+qrfcnJZw/A0a7KPFaAoEK0lhSgMo=

Cygwin has provided the getdelim() function as far back as (at least)
2011. The autoconf and meson builds enable the use of this symbol.
In order to have the same configuration for autoconf, meson and make,
enable the HAVE_GETDELIM build variable in the cygwin section of the
config.mak.uname file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index b6adce0bc4..1b3ba8a341 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -250,6 +250,7 @@ ifeq ($(uname_O),Cygwin)
                 endif
         endif
 	HAVE_DEV_TTY = YesPlease
+	HAVE_GETDELIM = YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0

