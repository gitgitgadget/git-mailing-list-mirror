Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1C1946A0
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899323; cv=none; b=TQWggR63QZe3NEdCfCNqpY99yaPUG4EGc0Andr0ncfTJBf4FsTtxMcLYgWBNMtiStv1j6FO2/wz8d9UoXF86rrUjE5vNWA671uGgY5zF0yUM3SCJMfm7Tkh7TZTP2klbTrctOZ9ZPWRhDZJMh9HLEAdUkCx0zDtWEjAW3uH8rcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899323; c=relaxed/simple;
	bh=XiKkietu3oO87WrKu3lfrUiXIlWVXliAiTYQLQJjDao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fkvr5vjyx8xNDbBIbf+QBarQxDO2S/T9tNjSNyyUqGp2PYheesufHmFpar0mgsJa4OCzaRr0Rxf8UG6Ki58Vwl1LXM0LEJbrcnvl4Q0Dab7WTBiPu4Ij+giZ0s8EYc0lTz5SmiY7X6zzM0kQn9NJjOp5C11FUHac5Wrmf7h5yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1sw5Xo-00H7RI-34;
	Wed, 02 Oct 2024 20:01:57 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1sw5Xj-008uSc-0Z;
	Thu, 03 Oct 2024 05:01:51 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix unused-parameter warnings with NO_ICONV
Date: Thu,  3 Oct 2024 05:01:40 +0900
Message-ID: <20241002200140.2123584-1-mh@glandium.org>
X-Mailer: git-send-email 2.46.1.1.gad55fb22ef
In-Reply-To: <cec3d068-38d3-4802-b2d0-77644dd425c3@app.fastmail.com>
References: <cec3d068-38d3-4802-b2d0-77644dd425c3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The jk/unused-parameters topic enabled -Wunused-parameter. Some code in
some non-typical configuration lacked annotations.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 utf8.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utf8.h b/utf8.h
index fcd5167baf..cce299d274 100644
--- a/utf8.h
+++ b/utf8.h
@@ -33,8 +33,9 @@ char *reencode_string_len(const char *in, size_t insz,
 			  const char *in_encoding,
 			  size_t *outsz);
 #else
-static inline char *reencode_string_len(const char *a, size_t b,
-					const char *c, const char *d, size_t *e)
+static inline char *reencode_string_len(const char *a UNUSED, size_t b UNUSED,
+					const char *c UNUSED,
+					const char *d UNUSED, size_t *e)
 { if (e) *e = 0; return NULL; }
 #endif
 
-- 
2.46.1.1.gad55fb22ef

