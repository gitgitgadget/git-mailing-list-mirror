Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8730BF72
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380265; cv=pass; b=AnynSw7FZwIjbupGrttNPhtyaNpZeT0yg3BUc9D4zT/KdgkWeWLpcxSc53AMtVQs+evWArLzPBU1f+Bbs00hhsh7T570+QtJhspHmvPE2osVF2I/+aTv+jEOyGqKxDNR/Z/o1z1nR8VNpFmn8rTB4fYu5tD2EM0oR0+3hq6Fi9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380265; c=relaxed/simple;
	bh=dvXiyjXQoxjz7beusTQLyBoEADDdULdcFDr3aNYZdjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjhvYVHA2C1jAQf0EeKabPATPbXQzWL88ZOg7jKIWOGWl5BGuj0m7dSI/IxcMeMpUOy3FchehiO3Gs1WEHu9IylbCobAW9UsuI8iYBEKK3JXqDXFlYlu2jbqLaW4OK16UeNR1B0vPuL2ErHcEIWccDOoISmvlLLbavCFymazhJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=C3ASKOiy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="C3ASKOiy"
ARC-Seal: i=1; a=rsa-sha256; t=1755380249; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k1XWL9y4lxI5WOj0hYq5F6Ym1vid4P6Eb7iVFRYgg0w3SMLCe3Jl/iG+Du0D8y08emcEEQQbwcQMhJqI/dKo0ewYe/uaQCYjTKn5ymkajA3LbnB4T7ZAcVLr18yUG4z5JT0AHPwjayZglqLc0ptLvyrYdwmwgppsZtOR/3UpGK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380249; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/0pkFdFhW5K5R5fcGRfan56ngA1QUUc6Wqy4qGeJKZk=; 
	b=HWorlcKjqCUepm7biugCDHf9TFKRCEVlBXLtintA3pRc69c8vHcenfAgOC0p+mfN3Vc3WDhBJXOaVy0ZPMqp/s9mRDAjm6V8NFxJO0CkxBF1wICzKu2548FjeyX2R7dSgLVOV1rYRvrfCiczHQhCIUbOKii9QremtnNDk1fLvuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380249;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/0pkFdFhW5K5R5fcGRfan56ngA1QUUc6Wqy4qGeJKZk=;
	b=C3ASKOiyaFE6Ext0ZPNUws8fTGq8edMYhnoBqSKtvEQKJPUuzGZXZagCJLOeNhMZ
	H63PY/NZ59mHQP8Y3Och4G/LkmGYfz1c8wgar23O7h7px88U2QcuiqOh9FZ06YYOUrp
	fGNTFjv6a2KobMNKkPGUqF/7VqbQiFjGvT+KPQBU=
Received: by mx.zohomail.com with SMTPS id 1755380247402802.8027116273249;
	Sat, 16 Aug 2025 14:37:27 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 5/9] strbuf: bring back is_rfc3986_unreserved
Date: Sun, 17 Aug 2025 00:36:38 +0300
Message-ID: <20250816213642.3517822-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.50.1.679.gbf363a8fbb.dirty
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Commit f89854362c ("credential-store: move related functions to...")
moved the function inside credential-store.c, making it static under
the correct assumption (at the time) that it's the only place used.

However now we need it to apply url encoding to submodule names when
constructing gitdir paths, to avoid conflicts, so bring it back.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/credential-store.c | 6 ------
 strbuf.c                   | 6 ++++++
 strbuf.h                   | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index b74e06cc93..0acaf1cc82 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -76,12 +76,6 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
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
diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..e8d84cbb6d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -817,6 +817,12 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 	}
 }
 
+int is_rfc3986_unreserved(char ch)
+{
+	return isalnum(ch) ||
+		ch == '-' || ch == '_' || ch == '.' || ch == '~';
+}
+
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
 				 char_predicate allow_unencoded_fn)
 {
diff --git a/strbuf.h b/strbuf.h
index a580ac6084..5139269039 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -640,6 +640,8 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 
 typedef int (*char_predicate)(char ch);
 
+int is_rfc3986_unreserved(char ch);
+
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
-- 
2.50.1.679.gbf363a8fbb.dirty

