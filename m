Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B3197A67
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861044; cv=none; b=u8HdnaMDrHdpZI7FXCDTaVWu6/16QhLGaJFbSEijloX2wyLVcum2Dsr/o/zJBSjPkQ+YnNlcNFl48eRAJDq/V2PnPkYnWEuQT/BcyMg22oqI52N81WtWd3rV0r9CjKJMssELzy3BFzIOeeXfymvKqWe+wDG/wVEGjGp6olmdzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861044; c=relaxed/simple;
	bh=YG0zBWH3cYpX9T/1IZAJCUuJ4+rnpUWnsUU+Z9eekPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+UW1WoKeTw5tY2outapxOslP58PS5q92A16691M/Gzp7W8zfr6SxLqq0bLnDQBLzp7JsMqoXFWo1aX8cBJwd0d3h5sayWxnMKRsMBPdE+Js9fcge3otxRiCXCQTJjFgJP0KL6J+rOtf4jvelmtdR7XeAU9Xr3atI3w/ge1rTrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1svvJH-0078vn-1A;
	Wed, 02 Oct 2024 09:06:15 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1svvJB-008iEh-0w;
	Wed, 02 Oct 2024 18:06:09 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix unused-parameter warnings with NO_ICONV
Date: Wed,  2 Oct 2024 18:06:06 +0900
Message-ID: <20241002090606.2076645-1-mh@glandium.org>
X-Mailer: git-send-email 2.46.1.1.gad55fb22ef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The jk/unused-parameters topic enabled -Wunused-parameter. Some code in
some non-typical configuration lacked annotations.
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

