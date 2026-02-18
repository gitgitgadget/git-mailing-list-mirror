Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9A32E14F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451932; cv=none; b=VX2JCBY29/r2d7IA2hQ3gyEqiEuFqu6Y07Fri17psdWWjwSj639q1etH/dXC1MZjMihYNn+UljFDVZd2BIsM/Wkbrw0v5b3zCp0efPwgnuyZettpkOCgFBZ7tKs00O/YuZSb3o9X/LfrwP+cawzq11uPQdoVWlTk6DCbMHggfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451932; c=relaxed/simple;
	bh=QXKZya3lxnIH5zncVWxxqnNSpRHrAifwOCaFOK0riSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+qni0ZNvfjRrSiSmnf8CjCrQWSQmhoAJ1jzwaVVVXea+Txf5m9wbEfq3yYPxGz8tFaSy6ZjrlKMpVPiGtO4H/ZXjHFDUfsZY3sPSy1rEzzl3rVEzzHauDGAQ/hVueBCg2QgErcHaM3QGs8e1QFM7LsaYNdIRLxmFvwy8MROFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=L/eUIL1F; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="L/eUIL1F"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0ECAD40EB6;
	Wed, 18 Feb 2026 22:58:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BJn6CNRKoIW; Wed, 18 Feb 2026 22:58:42 +0100 (CET)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 216F840D12;
	Wed, 18 Feb 2026 22:58:42 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21078B20A7;
	Wed, 18 Feb 2026 22:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771451853; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=M0SP12vmZNLgYZ3KifcwNUv+5z+2/MgaOEdWUFw0s3Y=;
	b=L/eUIL1FJIQKVkvbrPiZn4pKOJkfD6LdUqlLFo5DqZizE8NCH/V9fmBvqByh8wn0aCqbsf
	kT+OviYXQeMWEUov/YkwNugs61npKoE6K7+h99Il6rEX4/4qOc97stlCK5L9tKvvgN1jT/
	AC6I5DTVtH+OTLpuGq8JZJLxDMGuAE/ljnSruDR4O06D0/vIb3KRwjToZaEGFOF4n2ui0d
	ECC2SD7+noVCwBVHJqy/75UswgJrmAymM0wpEsvjKDRX5HKWNJdFO0s79CtCv0DxYVYo2v
	GVOi735aFWQkLDSTldysXZxwURZdX8OXJ7DXd9SYg6fWJKAfzKHK1/fe/hOijQ==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v7 2/4] alias: prepare for subsection aliases
Date: Wed, 18 Feb 2026 22:57:35 +0100
Message-ID: <20260218215737.1181147-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.122.g3abf75d576
In-Reply-To: <20260218215737.1181147-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
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
2.53.0.122.g3abf75d576

