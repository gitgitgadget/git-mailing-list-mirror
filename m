Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9232F691F
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044029; cv=none; b=WMqa17a6fEfwi8WEs7lYXH93yGqEA/5twCXPkvHSpWKPwpugI7vShYYdxKNpL5KOSLeoVBXPUS3qG9ErVNUgQQaFWphNFd73JEK5NiCp3cD9efJq1l2s9i3NEkszfErXnz6ZTc3x6oJrZDBIBz2Lg0WaT8ou7Y5k9WcZSGYeY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044029; c=relaxed/simple;
	bh=i+2cvglCb8AupgrZ43jYTA1CjQvvaAmNyNR4HnnrQlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4OFN4S08Om3l8SDeIVgi/5e5su1sViE34V5UNoDYzsU7FX3CM6yDltaqbNtlnDzH4UGJqYPFxO/HBq5NNFSBLNlrEXKyPmzInh7MRYu9fV1QgSDCzIlNcXBeoQAobuYT6j+rX4B1JTYzOCRLqG2Dx8D+vRuyTIs5sLxlS1Z5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=leV8v5XU; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="leV8v5XU"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 011623FBAD;
	Fri, 24 Apr 2026 17:11:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYFiPniY5mwP; Fri, 24 Apr 2026 17:11:36 +0200 (CEST)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 861B63F870;
	Fri, 24 Apr 2026 17:11:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 527CEB21EB;
	Fri, 24 Apr 2026 17:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1777043327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bdnfmWer6n+0mKFF2EwWVswbHsfvO23Yx2q7mBuKcmE=;
	b=leV8v5XUAEEzUPQYUgQNcAHf3Z1CT14cyWrkhICovxqpNkh9IQ2o3p8CR3meF+zD3XeSpO
	54RTn5EpF3fewQMBNtH5UB4Ira15Q1gmmTmkeTF8n+RB5m+p7KzBv3jVfJOwQmMArHb3Lp
	dPQYIh/OZlDEeQeCUl8SYdma7bxd4aDnTA1XjGZuWSIkf3zX+qbJsdlZR47QLDb045VluJ
	6Lj06p4Jspsg8hrDg65+3dLtK1BDxsBSeqgIZrwBZ6KKPplSujos/9o+NH40WBn7k7kTWT
	BKSi4SfVyvLymFid4ocqnfvw7xcIBmydheMJE1LBWETYygqwGOdOOPVZZXNJfw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	rsch@web.de,
	michael.grossfeld@amd.com,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH] alias: restore support for simple dotted aliases
Date: Fri, 24 Apr 2026 17:10:48 +0200
Message-ID: <20260424151053.917066-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Historically, config entries like alias.foo.bar expanded the alias
"foo.bar". The subsection-based alias syntax introduced in
ac1f12a9de (alias: support non-alphanumeric names via subsection
syntax, 2026-02-18) broke that behavior by treating such entries as
if they were subsection syntax.

Restore support for the old dotted form by falling back to the full
name when the final key is not "command". Add tests covering execution
and help output for simple dotted aliases.

Reported-by: Michael Grossfeld <michael.grossfeld@amd.com>
Helped-by: Jeff King <peff@peff.net>
---
 alias.c          | 16 ++++++++++++++--
 help.c           |  9 ++++++++-
 t/t0014-alias.sh | 12 ++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/alias.c b/alias.c
index ec9833dd30..e737c49edd 100644
--- a/alias.c
+++ b/alias.c
@@ -34,8 +34,20 @@ static int config_alias_cb(const char *var, const char *value,
 	if (subsection && !subsection_len)
 		subsection = NULL;
 
-	if (subsection && strcmp(key, "command"))
-		return 0;
+	if (subsection && strcmp(key, "command")) {
+		/*
+		 * We have historically supported the "alias.name" form when
+		 * "name" happens to contain dots (e.g., alias.foo.bar to allow
+		 * "git foo.bar". But our parsing above would split that into
+		 * subsection "foo".
+		 *
+		 * If we do not understand the final key in a subsection-style
+		 * variable, fall back to treating it as a two-level alias.
+		 */
+		key = var + strlen("alias.");
+		subsection = NULL;
+		subsection_len = 0;
+	}
 
 	if (data->alias) {
 		int match;
diff --git a/help.c b/help.c
index 3e59d07c37..46241492ce 100644
--- a/help.c
+++ b/help.c
@@ -592,14 +592,21 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	/* Also use aliases for command lookup */
 	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
 			      &key)) {
+		size_t key_len = strlen(key);
+
 		if (subsection) {
 			/* [alias "name"] command = value */
 			if (!strcmp(key, "command"))
 				add_cmdname(&cfg->aliases, subsection,
 					    subsection_len);
+			else {
+				key = var + strlen("alias.");
+				key_len = strlen(key);
+				add_cmdname(&cfg->aliases, key, key_len);
+			}
 		} else {
 			/* alias.name = value */
-			add_cmdname(&cfg->aliases, key, strlen(key));
+			add_cmdname(&cfg->aliases, key, key_len);
 		}
 	}
 
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 68b4903cbf..5144b0effd 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -128,6 +128,12 @@ test_expect_success 'subsection syntax works' '
 	test_grep "ran-subsection" output
 '
 
+test_expect_success 'simple dotted alias syntax still works' '
+	test_config alias.simple.dotted "!echo ran-simple-dotted" &&
+	git simple.dotted >output &&
+	test_grep "ran-simple-dotted" output
+'
+
 test_expect_success 'subsection syntax only accepts command key' '
 	test_config alias.invalid.notcommand value &&
 	test_must_fail git invalid 2>error &&
@@ -183,6 +189,12 @@ test_expect_success 'subsection aliases listed in help -a' '
 	test_grep "förgrena" output
 '
 
+test_expect_success 'simple dotted aliases listed in help -a' '
+	test_config alias.simple.listed "!echo test" &&
+	git help -a >output &&
+	test_grep "simple.listed" output
+'
+
 test_expect_success 'empty subsection treated as no subsection' '
 	test_config "alias..something" "!echo foobar" &&
 	git something >actual &&
-- 
2.54.0

