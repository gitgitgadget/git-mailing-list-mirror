Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D680231854
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680104; cv=none; b=DJ1zGXxXFFE9Jiaa8yHrpdmSM1AASn/pKXiWBO0kJ/tnyx77EVAWPHusix09Bq+W+jRhv+gGUwwZ+fj9YeBLaFh9osoUuP68brkmjZHMtaVS9sSiLM28TH6M0bVdgreqoSdM3N6GfRk27Kvg/frgU8m5fDfsycIh98ByBnqgYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680104; c=relaxed/simple;
	bh=kwoXdcQs9wQ7NwEpJ/ms7L8PlIo9ddDDsdS2qng4gyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBk4BlQiypKF8WsDZC6pOezP8BSdWX7A6qYGwDU9Vb+QsBJ1oldbQ0/nxFwiDdaID+Wm88sNo9prOVOErQ4Pj21YL6z/iTVo9v2RU23zYwQFyN9wq2rcvr929c3LIhFd4ysJ+IHpMXPJejnyA6+td4TXZO4qq3rHdK1hKYniL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=EEcMFXSl; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=Hgfid0GV; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="EEcMFXSl";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Hgfid0GV"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 654C36131E; Thu, 12 Jun 2025 00:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwoXdcQs9wQ7NwEpJ/ms7L8PlIo9ddDDsdS2qng4gyc=;
	b=EEcMFXSlybiSm2oM55gWkVlK6ZrWotwohUWwfslSOJjrA9dG/bsGrKKiuMC4vGINnuqb80
	DFmPyE/3Ftzi0lMlIEVRTTUWlVPfgdsou2U3N3fK4LliTF3RZMQd+WY8L9RFKpAyYRzFhk
	beWxf55Yvqwutkr+ZC9Ak1/5Z4SABzkvRMT4aIMnUSF/cuiie5QUs8e8dAkQWgLHyShvfI
	c7lZk+a3d9DkfwRwE7Xl+O3qb1ZJlooX7A4VAIO1u608QnaK5leSia71zYtAjrRnf+oDD8
	O005Ky4u5HhOnXuW+QkOmaSCTR2M4XSvJDiOC/jAw7hqpUlirp+4xUVFrmY81g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwoXdcQs9wQ7NwEpJ/ms7L8PlIo9ddDDsdS2qng4gyc=;
	b=Hgfid0GVNTJB0WlnPdrmT+f+/bRHgu6r60dOHRiQqo+N9o4lI/4fCX1sOoLaqhDmQFae5P
	c4N90G0Sja5hWxCw==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 3/6] bswap.h: Define GIT_LITTLE_ENDIAN on msvc as little endian
Date: Thu, 12 Jun 2025 00:14:39 +0200
Message-ID: <20250611221444.1567638-4-sebastian@breakpoint.cc>
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Microsoft Visual C++ (MSVC) compiler (as of Visual Studio 2022
version 17.13.6) does not define __BYTE_ORDER__ and its C-library does
not define __BYTE_ORDER. The compiler is supported only an arm64 and x86
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
2.49.0

