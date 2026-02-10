Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05B1946BC
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762502; cv=none; b=blhKYVf0E0xvABb8+oRwdUuaTPhoR66feTL/r2gneAN3VTh5+oCJnuUxtIFvybCJ62LX4hBYJ+scY7jEq3UCysfmRirg3Drrv4REuEsy6zsj12rwmO5kw6DJVsd1819LDfF8cNZTC9pp9+G+b+1ync1/8LKVs1PGe64DvN1wzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762502; c=relaxed/simple;
	bh=uT6HeIaJihFfcinimvtDvRFpV3HPBncYoTzBrvP/ANM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAqjyHGBPr5Zp6Ghwnx9fjyp+oyyWPRchdJ9Qw6TwDIuXDlbZPTOpYzqfEHUDXh4SsKwT5ZvPViKMU4d+uWnRMO9HpKvpHQfG28bNjvUxoiNY88HJxSAiu1pgeCHTSoo7W1AlleG2lccs3B9Z9tO4VRp2WSsNtiFWq+KZCAgKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=mZuJzanp; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="mZuJzanp"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3D9B640824;
	Tue, 10 Feb 2026 23:28:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOFy4LdP2S_j; Tue, 10 Feb 2026 23:28:17 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3D710400A7;
	Tue, 10 Feb 2026 23:28:17 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 787DEB1E74;
	Tue, 10 Feb 2026 23:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770762440; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3EoQGRaYVtqCAfl9B9QJtZvudRi1fdKZTirG+Mez7yE=;
	b=mZuJzanpxcQhoB9OZCQ2TSmUL9HCkKgsN5n/xHLt3oGil2ZLo5s+P71wL1CtUTqitfxofS
	jnTnMSJsHKoXG/6uPhQ28kqbkYoN4I1RDLB+FxStwmwHDroyXP56xDaLvogN9tTfQynP6Y
	QQsSYESdkGDkrSi3wAv2JatIpeFv6sLPMfsYx7Wa/5cGhkLLIRb78EBghtQfDom5WXuDNY
	RW9zcFBHuBhD0RJGHl1TUIXyOH7YcSCQHMATuf3s1VsOKEO5d+QM8Xj7n7zRhcXSDZVxFO
	Y9gXGhdq2HpNbmR/LGkn1aoByjMa5+XZn8urZLLq6un2mAWDBktu2EzvtH/vKA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 2/3] alias: prepare for subsection aliases
Date: Tue, 10 Feb 2026 23:27:44 +0100
Message-ID: <20260210222745.78575-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210222745.78575-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210222745.78575-1-jonatan@jontes.page>
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
index 0bdb7ca10f..eccd0c22f8 100644
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
2.53.0

