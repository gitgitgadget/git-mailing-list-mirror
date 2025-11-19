Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3C2BE7A7
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586695; cv=pass; b=YRs3bJpxgGvkhgXAJJp3tzekQ8XdVNjdfJFsFdByx21u+JKiDo7IQEGFVlrXE05jz3i3TZG+5JRE9GnEvSHO27EBQ579huNOmBsF43Byp7wIwLuB5BdJhnVNVu8Do1XCtKc7Ez76fx8k5V2Fbtnp+byL7T5oG3nKTpCDsTonaNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586695; c=relaxed/simple;
	bh=n3v70NKwe61XCpGSh0h7HRYZ7FoenXPFdkKxUn8yHAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfCdsw0NJnKmU+zBGPqgT43CehLZ1aXJ/4cLyhgZLEs0dmEHLnX9dMIVkgLRE4d3ihqB8OQxBD7zMFaweehSG6FPdxTFqGOw3NnnqlyiXtA+fifbxkKb7PKJ+PWWo0wlgvtI9hqMm4PqraI5XRNyEJr93zCa+/JOXCQYI56Vct4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Qz8pwNuu; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Qz8pwNuu"
ARC-Seal: i=1; a=rsa-sha256; t=1763586678; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lX5KIt7oTiyPcMumxRhQGZ3dIegAa15PwxhNhgr+RdDfDw4UN89Vl41g/JwfsY+OscmQJ3k108F5kN2n4emxQ6OB0OoOwffHe0Giygd2mgg6YPjx43D6iD1JzU/Am7hh7YFrXjk/pQ/TiP09TpmcyE3IW0KeTYL5TQb9yZ5pgHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586678; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c4cq4eZbJss+tJX3Mh8LgilpJFJ/m8kG82TpmuCbw88=; 
	b=bgpJt0/4vUYzWLB1GgQSnlfWEnjbfufTwB4ANbyYBFzGxeJAmQCx2qF2nn23KrZBqLxDK5BDP+VBI02ZjaxgPQAC4bsLbvG6tyhtJLC2kd6TmdplFPXL0NQs8Uw10B/vDmElqomamxf7yh8Rig7tlTQLJA+CoboQNW7Y/LlM0cs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586678;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=c4cq4eZbJss+tJX3Mh8LgilpJFJ/m8kG82TpmuCbw88=;
	b=Qz8pwNuuyfqflhXnsipQDRYRY8MUCk0/3l+aaD5CG3M+1QxxP/YEe3ZoV0+9RqA9
	UuVdKCK7z1Vngi/i6PTKbzyQUM1gHPP7oivIeQPwLwCdlItXvySyDcoQbduQWecn+/C
	9h/ZhbR1NvJTv+HfMEJLxHGx/CFpemvneNr+kmOQ=
Received: by mx.zohomail.com with SMTPS id 176358667696713.72120988520328;
	Wed, 19 Nov 2025 13:11:16 -0800 (PST)
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
Subject: [PATCH v5 2/7] builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
Date: Wed, 19 Nov 2025 23:10:25 +0200
Message-ID: <20251119211030.2008441-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
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

