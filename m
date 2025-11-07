Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667412DAFBE
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528010; cv=pass; b=Ch/tTwNClR4KiOD2Wa2gdeQCXkeqITyly+9j5OD4cGakcetPeRAlSiaoBX+SpxyVBSQVncXZEXaS5O9vjI95WwIyuM40OTcM3P0Z2PqOu+GUyqreg+QPrsauTG4qh7gGl4fAQjTRZARgmVqu5kxDQt35rDRLA6msrXeGzMXQTX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528010; c=relaxed/simple;
	bh=n3v70NKwe61XCpGSh0h7HRYZ7FoenXPFdkKxUn8yHAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJE0oCuCwMHrMt8nwcmmaV4n+Mv46JV2LyseAH55znNI0nz1DJ6C2zhY3Me54bWhMpeVzdZPS3HWelwg9FlLARzp1aCNfgos9jG5NiQXeOs7sq7jUdj+iEfPIF9AvGx3wz9u/Cof2uk66HtTbG2m2JNk5JXfOTx/z3rqwmgq9Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=J59eQQGy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="J59eQQGy"
ARC-Seal: i=1; a=rsa-sha256; t=1762527985; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=La1Wl+xgZwCOtq2Yro6SQitNQwIpMW0/ohj1rmZ3/vTSa7eDnqzS2BrdTHmqq/j5hBIrm6GeCUI6iaEMOP2O+YHDMO6c9dvgzrmoPyOKW2Uc82IgebxG4zW8yP4nymW8D+krWMB9e4GslY8og76HNy7CpI3hcMYZn6YgmjjIc+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762527985; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c4cq4eZbJss+tJX3Mh8LgilpJFJ/m8kG82TpmuCbw88=; 
	b=bHB8TRzfq+Is9DxlwQRpl8/iNkp+RO6L1q6gXhhCUvoAgaj1zw5aRCg+USSAbG+YHgctBVMIeyEI0gSkZ+keSRsPUcvFIcAokdchq7L8sWKTgcBfGl4PvNj0HPPbDxnnIC3B5iQFM6N1HOT0iMHnlcxEUWvrgN9hDPgAkiPl91U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762527985;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=c4cq4eZbJss+tJX3Mh8LgilpJFJ/m8kG82TpmuCbw88=;
	b=J59eQQGy9BPQ2JeHeaZ1P9+ECv6pWUZ7YV3QcFkdgYExw/4eZh0Mx/PcJBKqlBiG
	AEYx4RWSsdYIYSRsObnOWkOccABIEWs3kwttO1YtOZOnA8HRJGBLC2GJYo5BfxijvF9
	O0AZ0iH5LmT3mRzgzNkjcWjTH5UtPb6+vwsOfkuQ=
Received: by mx.zohomail.com with SMTPS id 1762527983272205.67254580696954;
	Fri, 7 Nov 2025 07:06:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v4 2/4] builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
Date: Fri,  7 Nov 2025 17:05:45 +0200
Message-ID: <20251107150547.3272180-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107150547.3272180-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

is_rfc3986_unreserved() was moved to credential-store.c and was made
static by f89854362c (credential-store: move related functions to
credential-store file, 2023-06-06) under a correct assumption, at the
time, that it was the only place using it.

However now we need it to apply URL-encoding to submodule names when
constructing gitdir paths, to avoid conflicts, so bring it back as a
public function exposed via url.h, instead of the old helper path
(strbuf), which has nothing to do with 3986 encoding/decoding anymore.

This function will be used by submodule.c in the next commit.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/credential-store.c |  7 +------
 url.c                      | 11 +++++++++++
 url.h                      |  2 ++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index b74e06cc93..bc1453c6b2 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -7,6 +7,7 @@
 #include "path.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "url.h"
 #include "write-or-die.h"
 
 static struct lock_file credential_lock;
@@ -76,12 +77,6 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to write credential store");
 }
 
-static int is_rfc3986_unreserved(char ch)
-{
-	return isalnum(ch) ||
-		ch == '-' || ch == '_' || ch == '.' || ch == '~';
-}
-
 static int is_rfc3986_reserved_or_unreserved(char ch)
 {
 	if (is_rfc3986_unreserved(ch))
diff --git a/url.c b/url.c
index 282b12495a..0fb1859b28 100644
--- a/url.c
+++ b/url.c
@@ -3,6 +3,17 @@
 #include "strbuf.h"
 #include "url.h"
 
+/*
+ * The set of unreserved characters as per STD66 (RFC3986) is
+ * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
+ * components without percent-encoding.
+ */
+int is_rfc3986_unreserved(char ch)
+{
+	return isalnum(ch) ||
+		ch == '-' || ch == '_' || ch == '.' || ch == '~';
+}
+
 int is_urlschemechar(int first_flag, int ch)
 {
 	/*
diff --git a/url.h b/url.h
index 2a27c34277..131a262066 100644
--- a/url.h
+++ b/url.h
@@ -21,4 +21,6 @@ char *url_decode_parameter_value(const char **query);
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
+int is_rfc3986_unreserved(char ch);
+
 #endif /* URL_H */
-- 
2.51.0

