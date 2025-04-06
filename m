Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DA137E
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968395; cv=none; b=uAbuM8w5I6PqGu88NKp9xg4PGk2pQaw9Dc12YvSzX21S9uxYr7YDFNjfQUqaODR2zC3brmSoaOYX+JH8umZ1BaMDY6EZBFiZqMzuaKROYo7GBqdT4SmuuL9fJFdOp+o7SsQunO2qBzzO/pgvtNAPvv9zui6S9xhDuIUGRAhdFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968395; c=relaxed/simple;
	bh=UQXOXZFPKz32spLJMrN2Bvq1awCw+L/x7F4cSXtvx9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqxihdNyOPkKLxDdO92ssl4w0LChwH9mY2Qw0U7SvuAw0z66cVxA6mR23C58GjpetyEDNkimiyliIgazCzwEhW8I769k26sKC6qLaf/jryFsGm55/x+wvkm7eapSQctFVHSl8HB3AAIhsfryIz58lA+RO37mE9I5dt5xKSaThiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=H9B8EzqT; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="H9B8EzqT"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqRupkLs; Sun, 06 Apr 2025 20:39:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968391; bh=GDmQdgy1XrzzI8HxCxapwf+A7H6WsB9/218TGTVDW78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9B8EzqTbKKQZOyKnl4O0iJHPZZwofWz56OjTiPWYd4RdPcPjgvXbLOLWdtRYEI2l
	 UPNu0QmqPKVQZnemGTvAlUeKHikG3YHjWqpjhoGoIvWY3pa6ycJ3lqtnMC7LQzErgh
	 j0QruT9GdTqhcmDup1neLPgZ6X/9ojqBVzogoLpQYdUo7Jyvj7CnCXH2xFlERcPjyt
	 DgGYjcITLHlS+EIZDcTnL0H0m9DBdyAD4HZfYMwQrVyV0TdJbe1aOMWAi8eTPkHgOy
	 Yfpf/jbWku+tPtZsMf8FYVzc79cktFzFjkjr9A43I5ydj16Z6Yu3Uc2/YbTLm8e0ey
	 02J8TR/ASa4Ng==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d887
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=5XmO7F8k-BOE0I3eWfsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 08/13] config.mak.uname: add HAVE_GETDELIM to the cygwin section
Date: Sun,  6 Apr 2025 20:38:34 +0100
Message-ID: <0a3ce7e80abe4dd83ac5e6fe1579e8e559406acf.1743859985.git.ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfC0ggZeylfbFT564Iarpq0VXG3GQZA12kC4iPzIRFbq6wHv3NO/WLMcCJV4PP960WMAtarWVucEAPGtjM4Ahr8Pp3GqMmm0kBy/YFby0tkVcGK4tF1cQ
 eJeGVgWhy8Siu8v4s7HSosqXsEDuJQmL//B8cfT2MgoPaLdkC3gwZkL4AjHPrIQkqZY8lCmPk0XP/iUA7jIYK072EWaC1Zr7DAA=

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

