Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59128727F
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613370; cv=pass; b=M6+SIIlDfghJ/4bNlzo2Foa7Gzgw0waPEY73qgBR9rZ3+lBh94Ng0eVpuDxuMnG7KV7Sm/8/30si1PVEXau5EPjfvJP0RyKnolf8f3Z/upKlNc0ZR8OpVzKnyoT5YJ2eXvo7VrNc/ypFb+NVEkvZeRlmqVicEOIvcrzbGKRd0cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613370; c=relaxed/simple;
	bh=Dsp10BViORKUocAaol8JwCYHBjkMiWZMLR8mm+JeWEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWyiPKti//kFEPvqOFyXkPFX6PJeCVNlZu+WwiKpexd21zU1Pjp7n5DeYZqH3y1bHdKZXiEFyo+Sc4GVA8JZOAbzpv3kQfXsmusRMNGA91gY6FI3NrgMnA0ZEirtdL07nQLO+yeGcwMfQ5JRGE3AFFmR2FzHYJjfbaGmLzME26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=T7cRONyf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="T7cRONyf"
ARC-Seal: i=1; a=rsa-sha256; t=1765613355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mmdQUBlN/KxunpcqHG1ks8pIVNoHrgRHk+1qdH1FhApppfUCU25lyCe+7Ezf3cQFRUPkV+wp5RwZet1zEScaKWr0FHMDGAZE0GNvD9K7mMOCcu8Ny2s0/kx4KG88uFQV46JqcbNFDmGlajjhRH9uURFlnFmH4KwtV4kxHs54318=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613355; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6tL2I7roLPNU+zsghwkt1hlH4utinv4q5aG2Oe5MF+k=; 
	b=MlfOt3oCfYLZ69XEPIPxua/1Whj4kXisct8zlGqse0yO6xZt3WEEVpw1S69NJ+kiqPZVJVVRIWcZMT91hupi129o/5P1Q0LxU0bimfw7EeiJcXMn+w+ffl3rxihW9kl6L80CSLAjwff6JyWYmiiWINCYnIQibfLhmCeHGenS0vw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613355;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6tL2I7roLPNU+zsghwkt1hlH4utinv4q5aG2Oe5MF+k=;
	b=T7cRONyfOf0Tgon7d5N/Ymr2hDQ7Vu3h0TvWlQbgdHf94BKWgZDi8OyRaUkyL9nV
	bAHxTPvFTopuhP0zEXkD2BQJkBpkRncCRYwQCngW6ugDiU+ZXR3cYol27WFC3XrYrz5
	G87VXRKXmHB9KbhM75YTNywax4wRzJtvC8NPnv/4=
Received: by mx.zohomail.com with SMTPS id 1765613354540312.01626057263627;
	Sat, 13 Dec 2025 00:09:14 -0800 (PST)
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
Subject: [PATCH v6 07/10] builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
Date: Sat, 13 Dec 2025 10:08:13 +0200
Message-ID: <20251213080817.347922-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
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

This function will be used in subsequent commits which do the encoding.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/credential-store.c | 7 +------
 url.c                      | 6 ++++++
 url.h                      | 7 +++++++
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
index 282b12495a..adc289229c 100644
--- a/url.c
+++ b/url.c
@@ -3,6 +3,12 @@
 #include "strbuf.h"
 #include "url.h"
 
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
index 2a27c34277..e644c3c809 100644
--- a/url.h
+++ b/url.h
@@ -21,4 +21,11 @@ char *url_decode_parameter_value(const char **query);
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
+/*
+ * The set of unreserved characters as per STD66 (RFC3986) is
+ * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
+ * components without percent-encoding.
+ */
+int is_rfc3986_unreserved(char ch);
+
 #endif /* URL_H */
-- 
2.51.2

