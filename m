Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EC30CD8E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340160; cv=pass; b=AeZkgh7AhrvF0kU9UJ51yPmZasO6nutnBYrtSEs2s9KulIT9dO/kos4eIunCi4IsHoBdNEpmPV0XrxsTeVPSc3L19U+Gh2A8MJojp8KvhbYRQXhzuok1ymaomvKDlBiX/NDGtypPSLsJnE4bfFPnOUsWyJYWJRR3FKpDAIJ0K+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340160; c=relaxed/simple;
	bh=gU/lyTbUzeYSOIErsdrXab+LrZnDH1ih46ho+SlN99Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4FfosTGnMZKm60Gxvsj2qm2jFSUnq/I5vdTiBmzp1h/4Lvh2eh3/zhRBLieNQfOjH/2UQlKP1kFc+OPTCT45Vrs3DNotLk2SqDCUrIfD4P8Z15UlhXXyCRE2/+UyuVZuDh0AdUnwDxl16+rWwXzREhEkNfLzob2kMObp3/HS0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=dn6De196; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="dn6De196"
ARC-Seal: i=1; a=rsa-sha256; t=1757340139; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ao3tr33ZS5Ac7rzUAmhWf+oCYE4bVDvenD4iE/18ek64m6H22nf2r5TEDP2KotYFmp5EqZOT3XsGchvWhvRCl8XniGTGJBk+8L/2r4mTHJsF0e7EmuPU1hGPfuHkUEoTG4f1NfnUCpDZsdaogMTI5a6vgP07YOfDW0xHPuGIgaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340139; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L3BJXSwH1gdc5+Nc55+c+iDBNmNqQvjXXIdQaDwlrCc=; 
	b=K9PKjhuJV80bzvgkyBbHj8zsMjZ9CM+lHXBoC5joU17a3M/jK718GGex6lvFVyBu1UlZwVWfgvyucfivG/b/B831xnbiVHs9FuxHlSdz3lmQxnyXejWpUpRX0uFtg3db/i51l6x3dTAvR70dlonVsyZCt15VXlaAqTppJ4nuO1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340139;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L3BJXSwH1gdc5+Nc55+c+iDBNmNqQvjXXIdQaDwlrCc=;
	b=dn6De196+SbfOni/Zx3lKxZCE0m+lYOlmwDAP7fDy3NOpoaHMIyf+k+9vxpk8rbi
	Zz7pbhVe2KedDCha7h2wd9noOzyli+rjB+YpXJzDa2vDEFBO397x3UaJ2onan0RDWxm
	XKNVVy58FrfmfUJ8/zp6iJwnPURlZS/tWqeP28LU=
Received: by mx.zohomail.com with SMTPS id 1757340135488715.7774541253283;
	Mon, 8 Sep 2025 07:02:15 -0700 (PDT)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 05/10] strbuf: bring back is_rfc3986_unreserved
Date: Mon,  8 Sep 2025 17:01:12 +0300
Message-ID: <20250908140117.262205-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
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
time, that it's the only place used.

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
2.51.GIT

