Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367320FA9C
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749986; cv=pass; b=OXdLETXVzKnsooQfDjNe5VXVl3xsOfUmh7zHvPNQr+IQuFv349h5uOFA73nYNpg6yIBYfeRLJrfmgEbRk7CppCIuHO20FFmHu7B6hBiwhBP20PQD/LqjywCSayaBrs6c54ez1Nqm0vvySmfCNxpZc1p77hGekRQyqe/De94G7wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749986; c=relaxed/simple;
	bh=PXYQZOmaelFWhn3OHDCXrCCL7jT1QH+ExbUWK2DxVPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7QmoywvecFa7+L9a+rftTQ+4OUqWgnhTayKNYI1hxfv2zN8uNn91wGuG6gwriT3DmAWSemuiNtvuxKNKaO628q+MjiMRb0OQCCfhi0pyTxbhJ4jjZc9qwsAqB5kgw9y4ZGYVZr0NeyOyZoantpU4HDknxWjbC8wXa3c9D7kc18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OK3je8qw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OK3je8qw"
ARC-Seal: i=1; a=rsa-sha256; t=1759749954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cDo5h1NwrUWd2wd0WCUR/PM5ypa5hKIp+GzaOC+Ip5DnXO8VoOCoTCjYOhS0hk47uNXn/7wgE25tUOwAJIRH5zSngPT8/u9iwPg9+m5dMGYJfgH/wcS588vHZeY2nEfPOGe4K4eQBfxVTn8Xlr1UU3PwfJXFOXtBDXyMkf9BmV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759749954; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VUFc5W8AuopZYeOjNl1USuByrYiLvQfn2wvP8Y3sahU=; 
	b=nC+J87RgJmzwSGd/cDiGUP9PXlO29oO9njHr5B4ghFjt8R9IRk9KsWk4fpcVbXlj/Q2s5DmYbzP7+qTRtVHTGx8b+XB15tgpaNj694ucvOf65QhTaQBPa0GDApWJrEvOvmxv3m15+njGI/ohjCByhnMcw1BLRb88rvdbXxuePO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759749954;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VUFc5W8AuopZYeOjNl1USuByrYiLvQfn2wvP8Y3sahU=;
	b=OK3je8qwEVU6xMf/twO9gXuW3hw37u2E+R+76SNWCjdZ5ymsG6H3GMnJDtFiMx4Z
	sYw8MhV7QrJA6tFhVXWbLYTQ8suQ6UEJfoKNuqUTCH18qlirWnSCMiW0QkQ7N38bIMG
	UkNEPck6PJVt6ggglYg8Tcwnl3NZQ1G0cYLp96iY=
Received: by mx.zohomail.com with SMTPS id 1759749952778781.6059057101666;
	Mon, 6 Oct 2025 04:25:52 -0700 (PDT)
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
Subject: [PATCH v3 3/5] strbuf: bring back is_rfc3986_unreserved
Date: Mon,  6 Oct 2025 14:25:16 +0300
Message-ID: <20251006112518.3764240-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251006112518.3764240-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
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
2.49.1

