Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3332D4B47
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606777; cv=none; b=OI3MYj5D6iqtQhL7H0MfQJGE6hfnI18XS9pxg1b0ii5qbQSBidqGK5aUZrB1U7f5EpG61CCi+fhtdJC1KB7DxUFFh/QSuz6+ru7QLooCbzGf/9YkgT6lhB+BBxPujEfr/HAdHQeDEBCTsao5xSZtan31uROuzYXOrfjR4OtoD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606777; c=relaxed/simple;
	bh=2Ah0d3tEupXx1XuJxiZSles2IjUOe7//L5FPdxuQAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3SFVeW1Z9aqjONIJr7aVWJZNXYmpFnxOFtxEM7kSDdDEkLCrpnwx5c4tUk+gwN2rvWKRRNUpxkugeEKpsJ3Wqvgn78sjHE+6b0sTiGtSLqPzs1LLGFhSa2/REqiFIWMiuQ0B2LZ6ni0219GrUeA3haVD7xMMcoERIWjOGZJx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=kWIucAZR; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=AWTD+r/M; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="kWIucAZR";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="AWTD+r/M"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id F10086048A; Tue, 15 Jul 2025 21:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ah0d3tEupXx1XuJxiZSles2IjUOe7//L5FPdxuQAN4=;
	b=kWIucAZR3fwFSdGCFieEi6xkE59YCDKBi7On4ZAsy4BTd4eCcv9DECl4CoTP05+RvfYqqd
	lRbsfZh16WROQOEbjXb+3tbJhKXtz4cDG1F86zPzzZh5SoqKSWuuAG7ewK1jZQsAJFwpJA
	dhXc+nuOEzySRSDfonFFjjZGxWLPcgIJ0KP9M4UQuweQAHpXylYr4neu1rm3MpZlUdAeiV
	MitmGh5gFP8XxtPKQn+rhPFmHPQRcvQOGcYIrdo8vOZ15tSIVqoQKGun4hBXYIZUZDaYkZ
	V1yfZP5IusrpccQh856MTW5jrLkpyu7M/J9OVUq6EJCl8knIrIdKQ4zMhocEIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ah0d3tEupXx1XuJxiZSles2IjUOe7//L5FPdxuQAN4=;
	b=AWTD+r/My5BROkRKF3sKyse0m5L5BXkzM6jGqSEjCn8VP5JedA69YZBAIzIxyNnZk2u/Jp
	/uo4sIftpJXOd/Ag==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v3 2/5] bswap.h: Define GIT_LITTLE_ENDIAN on msvc as little endian
Date: Tue, 15 Jul 2025 21:12:27 +0200
Message-ID: <20250715191230.12081-3-sebastian@breakpoint.cc>
In-Reply-To: <20250715191230.12081-1-sebastian@breakpoint.cc>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Microsoft Visual C++ (MSVC) compiler (as of Visual Studio 2022
version 17.13.6) does not define __BYTE_ORDER__ and its C-library does
not define __BYTE_ORDER. The compiler is supported only on arm64 and x86
which are all little endian.

Define GIT_BYTE_ORDER on msvc as little endian to avoid further checks.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 0a457542dd76a..fd604d9f7b74b 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -81,6 +81,10 @@ static inline uint64_t git_bswap64(uint64_t x)
 #define bswap32(x) _byteswap_ulong(x)
 #define bswap64(x) _byteswap_uint64(x)
=20
+#define GIT_LITTLE_ENDIAN 1234
+#define GIT_BIG_ENDIAN 4321
+#define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
+
 #endif
=20
 #if defined(bswap32)
@@ -122,7 +126,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 # define GIT_LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
 # define GIT_BIG_ENDIAN __ORDER_BIG_ENDIAN__
=20
-#else
+#elif !defined(GIT_BYTE_ORDER)
=20
 # define GIT_BIG_ENDIAN 4321
 # define GIT_LITTLE_ENDIAN 1234
--=20
2.50.0

