Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D795246766
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680103; cv=none; b=Qn5M5A2SDL5zlzKrHsqlpcKn23FoqgbL/dfrJVfR2nlrGsPb0YN2Zu5Xe/couh+Ao4wDyyBpelxVmCx+NRlX+TkY827N+pnPYdC8B91OW61eDCHN77BHr78KqlQDk4sdJ9PL7UhUc5aUvZpKruwqxiHv8OUkeAKmE6PmFkj9+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680103; c=relaxed/simple;
	bh=DR/yC9MS44YmU/X/bJaJNiZeaobA1bGXnk5kYzs2HJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miekk1ZQftXmhn5u4COS9iSBOncnpt5HMBf60O9j8BRopcleAUYx3zqZLeIi5dJJKibAGqVK+PgRB8VkcihA13rERHU87i/ao2zltEIO4REGgFTqiPDE3HbCi6M9sVr8oFiSPpNHzol6LU2ACKTmpGw1ZOGhEb0gwKM6d0q4dnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=RTBKfJiZ; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=xGz1kCJy; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="RTBKfJiZ";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="xGz1kCJy"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 72CEC61322; Thu, 12 Jun 2025 00:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYcg0b/LsH1R0C3QAKa3SGfmgU6SC49+vdLw8Niquvo=;
	b=RTBKfJiZYKPit5VTJ0JH2c+Txi0Nj0GqYcOIeMVMuOBTtm27qyq+555sAw7hFa9+h8gPic
	RxBRkfyAItrVHNsBsP1WcVL0reSDgyr3MvlYS+5SV/YxR9qfm+Lva+8olbjBbBOPFcwFYs
	JSyURd27erh+m+eRHE21H8pwkkzrCmJv+/stCBKThLD1a8Q8migMShm9q+h730/oNSCO2P
	BwtwuAK6P59oG5R4CJGdUY4T9npiIoJV6LbnFkbAnGwl7KNxWUmWIWXvf2l/MMgRuZYYPw
	/Yop77jAj/D0ZPXJQf3PPqdeMAnGOCQnQ7kYkoMl+/Jg0gobbZTqam6rSaeoSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYcg0b/LsH1R0C3QAKa3SGfmgU6SC49+vdLw8Niquvo=;
	b=xGz1kCJya7L7TWsDDAWKi7wbGuj77B4mDY8fg9Pjka2XG7HRqKjieB2m0TBW04ccaRTeLr
	lyt8h/I4dDUM0aDg==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 1/6] Revert "bswap.h: add support for built-in bswap functions"
Date: Thu, 12 Jun 2025 00:14:37 +0200
Message-ID: <20250611221444.1567638-2-sebastian@breakpoint.cc>
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since 6547d1c9 (bswap.h: add support for built-in bswap
functions, 2025-04-23) tweaked the way the bswap32/64 macros are
defined, on platforms with __builtin_bswap32/64 supported, the
bswap32/64 macros are defined even on big endian platforms.

However this file assumes that bswap31/64 are defined ONLY on
little endian machines and uses that assumption to redefine
ntohl/ntohll macros. The said commit broke t4014-format-patch.sh test,
among many others on s390x.

Revert the commit.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 9e0f98e00b93a..b34054f2bd728 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -35,19 +35,7 @@ static inline uint64_t default_bswap64(uint64_t val)
 #undef bswap32
 #undef bswap64
=20
-/**
- * __has_builtin is available since Clang 10 and GCC 10.
- * Below is a fallback for older compilers.
- */
-#ifndef __has_builtin
-	#define __has_builtin(x) 0
-#endif
-
-#if __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
-#define bswap32(x) __builtin_bswap32((x))
-#define bswap64(x) __builtin_bswap64((x))
-
-#elif defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
+#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
=20
 #define bswap32 git_bswap32
 static inline uint32_t git_bswap32(uint32_t x)
--=20
2.49.0

