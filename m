Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A933D4E8
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426370; cv=none; b=chIlwaelTKkW5FF5Jrw8q4aYYBeNkaJq+olgUnrg51n/hqOtoTHOoA+SHBORZDmGU4g5FveMqx1q8rIMWDQwCQuV46nAFrd3Qnc0EUggNgKSQYgildVDDg3rrc4J07zhooknejwP5CrLvtTVEmh1d2YneIdlK2PfwbkW+aUyoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426370; c=relaxed/simple;
	bh=fFeWvlXssRP+vfmKH/cdX0hfQipR23qVg5r27JuU1Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFYsiNQQcpy7SZWAv9CHlNXXUQN3rmRJpgm/0aEo33yUnNp2f336ff0pqpseb2KDzhXSHBBHmVQj0C8SR4AJn/jg0wFH+dwjoNyDbZ0+zvQpeHxtODFBD28FuF8AKa+SRpg2xJSrun3uo8+iiBTy4a4w+syMtolusl+m6J6oKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=S3Ad+lkj; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="S3Ad+lkj"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6EAA63F380;
	Wed, 18 Feb 2026 15:52:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nh6MfvW5Wh2C; Wed, 18 Feb 2026 15:52:39 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 81A563F7E4;
	Wed, 18 Feb 2026 15:52:39 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9950B210A;
	Wed, 18 Feb 2026 15:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771426291; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=uwyc1Gx5XroE/N8r19W+AuS7q120CY0ae1DTFfSWPs0=;
	b=S3Ad+lkjTA9+pgkdbeHLWktaIahKOsLe3By8hUz1ivH27wP262kVV4XhX9jlI4WNvzst7F
	ygnZ3nn0yMcrEXz6A7D7jCN4b2O+fyRrK46eJimBOfd9O+HiDjxqwpehdYWVQP/YiJe98+
	2VvBDzPRvwhqfgVnELO2ywMU0Ujh5A8URsFR6hXW4qS1w0Dj4Q1U5t1R/PlIRH0H5MmGLt
	Oa3gLY83R/gxjqflMZcocuKUUdG+Cl+xG3otQsus+P4+ImDBppuSXJbdyYcEFk34865auY
	nsEP+ugE3pNnCXMzL1fJCTB7v6VkhgRDWc278JK8+uWINg8pl0iZdAzwgT/ppw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v6 2/4] alias: prepare for subsection aliases
Date: Wed, 18 Feb 2026 15:52:12 +0100
Message-ID: <20260218145214.581460-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.122.g3abf75d576
In-Reply-To: <20260218145214.581460-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218145214.581460-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Switch git_unknown_cmd_config() from skip_prefix() to
parse_config_key() for alias parsing. This properly handles the
three-level config key structure and prepares for the new
alias.*.command subsection syntax in the next commit.

This is a compatibility break: the alias configuration parser used
to be overly permissive and accepted "alias.<subsection>.<key>" as
defining an alias "<subsection>.<key>". With this change,
alias.<subsection>.<key> entries are silently ignored (unless <key>
is "command", which will be given meaning in the next commit).

This behavior was arguably a bug, since config subsections were never
intended to work this way for aliases, and aliases with dots in their
names have never been documented or intentionally supported.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 help.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 5b1b320d02..691af219bf 100644
--- a/help.c
+++ b/help.c
@@ -573,7 +573,8 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 				  void *cb)
 {
 	struct help_unknown_cmd_config *cfg = cb;
-	const char *p;
+	const char *subsection, *key;
+	size_t subsection_len;
 
 	if (!strcmp(var, "help.autocorrect")) {
 		int v = parse_autocorrect(value);
@@ -588,8 +589,11 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	}
 
 	/* Also use aliases for command lookup */
-	if (skip_prefix(var, "alias.", &p))
-		add_cmdname(&cfg->aliases, p, strlen(p));
+	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
+			      &key)) {
+		if (!subsection)
+			add_cmdname(&cfg->aliases, key, strlen(key));
+	}
 
 	return 0;
 }
-- 
2.53.0.122.g591c997fb5.dirty

