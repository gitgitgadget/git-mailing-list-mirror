Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75232ED37
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844734; cv=none; b=pmXy9JJl4UkDXSca+eQ85IeWaRdtvEEF4HYafb/FeD7TtxdRXdazRU2Zqn+kv4DiRam1jvu9W1qIYDbuL1771f4DdaDZ5z6FQa0q7xM2TTOKRzA9rOUjefUc9s+rS6BGsOjQ7oF9/vT3fc8d4GLm27brG+R6YRMrLMz3KxWWzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844734; c=relaxed/simple;
	bh=uT6HeIaJihFfcinimvtDvRFpV3HPBncYoTzBrvP/ANM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgrSQPXyWpzGnn7TMA1oRCBnmzy1rQeTYK4/9oB3QoP+KDSXKYI94iNziSpVcid9C6REljo3YJRWzFrS0bsQq5Nv6QYduupTEkCLCEh/8x+nJvgnbThGwaU8Uu3jAUVX21PGxBc8HnKD081VqipIekyDDBEYjVrC+0m5mEPANn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=ZJqOXVKr; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="ZJqOXVKr"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DD95340AA3;
	Wed, 11 Feb 2026 22:18:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i59Wq4IxbEDb; Wed, 11 Feb 2026 22:18:49 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 28ED740A93;
	Wed, 11 Feb 2026 22:18:49 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B87F3B1E34;
	Wed, 11 Feb 2026 22:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770844670; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3EoQGRaYVtqCAfl9B9QJtZvudRi1fdKZTirG+Mez7yE=;
	b=ZJqOXVKrJnY2enqbzPe+Hy9chxQ7oUD5SNVVumAJrUDLEFCh1ztVw1XQeC7wk6AXvAoswT
	dOoPzD11z8OQxsARoADJXsRIO9NaqnqKGeG5GJGUi8usEmrPIZg/MwGojuvPNcN21IIDay
	TXD8i+3EDuMtNwsvOzuwOKoE5n4HVfpV2ScJXe+5CcbfT0V+6wSTG5lJFZddNnd59gIc1F
	tk1RWVjvT2shJWVxL56Ah2MvaAWhZEwfFgLFFz+uS+nxJCU91B9RjPw1DwszipZRrvwrcs
	7J92mVy9v7soy4q3hvpxVe7r4Bo1JOIgKw874XvncKzi1ouaRqpzfqs2nXBMLA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v4 2/3] alias: prepare for subsection aliases
Date: Wed, 11 Feb 2026 22:18:09 +0100
Message-ID: <20260211211810.278806-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211211810.278806-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
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

