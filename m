Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77E19CC28
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258545; cv=none; b=QhlRuf9V1g2EL6e4DdQAqsyHsRAt89COgrIBHHGY6ulsGwGFRsSiscXVzGREtHumycCEskCMutK9jXYLiKZVcS37TFKHyiJm2GVXnjwGmN2FBmqKvhzcxh/Lns5W5f9XGtx3W0brUQm6MQQU+nWKHyWV3YK0BsNkQ+wOSItGa7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258545; c=relaxed/simple;
	bh=pVxFVb4cWH0lekJ0Bb9aZG5jrXiSUorjX1oTgJ2VwxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFk2sV8tWFwh3ctXdXQRjlHGOgkjhCppbPqlFs9x4NlBqfm60i0R80Iu1oDuHn26jT/Sqel+QT1KAhHLnog02EMFFF38rilfeRnLpr0t316/aHj30ctiMgd9xH1+cDFkCzAOj4n/doCF0j7w7/ZOVi7fWgLtvWzs6FcvDBWQfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=lopxJnol; arc=none smtp.client-ip=213.80.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="lopxJnol"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E5BF23F62C;
	Mon, 16 Feb 2026 17:15:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V2yPCSdlvgZs; Mon, 16 Feb 2026 17:15:35 +0100 (CET)
Received: 
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id F2DEC3F86F;
	Mon, 16 Feb 2026 17:15:34 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D09FB2082;
	Mon, 16 Feb 2026 17:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771258469; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YG9ezlqltcVOPT7rVO5uHAgC8czW1y7s4PUNkfilPtQ=;
	b=lopxJnol6iZqL+ZOF4l2ASCuVbOcSjEAT+WD3L2IOtsdyW5sdwoM+iw5T16uNUbqTpKxGk
	Yh9bs28rkMU6EVwGuBeYivny1BK9diEbdMP6h2t4EWbJLTzmLuDclSX+WK+4q9+2aKuGBB
	4tI+7YUFTnCD1SOvQgXejZFhMvEgDPPYhgCPEU1jT/co9hgdvq0qs9Vvr/YmydKN4fz2Kk
	2oyBqGPxza7ZCHTkpxF41HvmM7oUEAr2RRyU/UufXVnHGYxqj30tjT5Mczozi9xuc2Rhd5
	bqJZ/eZXK3ScMHoSvxHsevayvo6gx/ChYAO/XfaC1zZy1C5FH4rJ7b0Jd7N5ug==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v5 2/4] alias: prepare for subsection aliases
Date: Mon, 16 Feb 2026 17:15:11 +0100
Message-ID: <20260216161513.2533141-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.83.g660bbd62ee.dirty
In-Reply-To: <20260216161513.2533141-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260216161513.2533141-1-jonatan@jontes.page>
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
2.53.0.83.g660bbd62ee.dirty

