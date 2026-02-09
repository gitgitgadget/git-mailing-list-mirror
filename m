Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B612B94
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674530; cv=none; b=KETmHHBmlk35yXrpYxYEUOwndxRoeVzhkAEOJKmUWYSsSgyNDj9MGELIw76eMbSyP/9hzxDyoIT0kg4DvvHUoEgz+k7c+2LHoiKN+EwxpSQODKNrpAKGhgaaZB9eQRr32Hmm/RQw0P+IX/UiFEOjhgHHXTVPmRyN/2MS40kV44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674530; c=relaxed/simple;
	bh=PQZRenoxJ1zO+fmcJJV58wzWLzAwnPLnuApPAwaYZio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYGDt4R5Jlhoh+KLG9bR+bAAXh4lvwtZEv7U67SE3AuTrSweWeIVasfRDzHQZxcp3qGWovdIiC4n8zLwmqFiwiNc0EHliTr2BCHCTuKgskGtaCZNVzQ3DS4EPLCHD/cffWvjx53etOySqXSAPz1R1blBR7t+vozjKK/kP7gXOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=cxQGDdBo; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="cxQGDdBo"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 186BA40936;
	Mon,  9 Feb 2026 23:02:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zboFdyYkFJPQ; Mon,  9 Feb 2026 23:02:05 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C74E640915;
	Mon,  9 Feb 2026 23:02:04 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBCA2B1E31;
	Mon,  9 Feb 2026 23:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770674468; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pdH1Zj+XsGv4zz4tu9FyPxhsq/kyzE/idfdttRS/0nE=;
	b=cxQGDdBowu6qJS7JsCXIARfZG4rC/2KvYymdDsAzgUMeFzJQhFIa5rptz/lbKz3HkT4Po/
	JddcJym4glP8nW7/vExsFuqb7hloEkD06+KJTglJ+jCS2RakOzH0fRDCyLpYPQhlZrYv2i
	Q5NAfqRHePRI3Psx6v1itxn3OitHdOKbdLrvI6rQrY0KZvE/P9+KcXZA2ptebovznHIsio
	TYL0kxdKm/Pabf5sBvXZz/SM04zkp2FuYZSbz5eYNUehhDbbSVlaYaIm47EuGOmE4mB5Ll
	ims1wRV5isAxWebLwAEf8mIQ34Kjspj7PHtrqiOEeiRZBKODMCzBmWhA2hxpXg==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v1] alias: support UTF-8 characters via subsection syntax
Date: Mon,  9 Feb 2026 23:01:15 +0100
Message-ID: <20260209220115.461109-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Git aliases are currently restricted to ASCII characters due to
config key syntax limitations. This prevents non-English speakers
from creating aliases in their native languages.

Add support for UTF-8 alias names using config subsections:

    [alias "förgrena"]
        command = branch

The subsection name is matched verbatim (case-sensitive), while the
existing flat syntax (alias.name) remains case-insensitive for
backward compatibility. This approach uses existing config
infrastructure and avoids complex Unicode normalization.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 Documentation/RelNotes/2.54.0.adoc |  8 +++++
 Documentation/config/alias.adoc    | 53 +++++++++++++++++++++++++-----
 alias.c                            | 38 +++++++++++++++++----
 t/t0014-alias-utf8.sh              | 44 +++++++++++++++++++++++++
 t/t0014-alias.sh                   | 32 ++++++++++++++++++
 5 files changed, 161 insertions(+), 14 deletions(-)
 create mode 100755 t/t0014-alias-utf8.sh

diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
index 20c660d82a..8cb00a21bb 100644
--- a/Documentation/RelNotes/2.54.0.adoc
+++ b/Documentation/RelNotes/2.54.0.adoc
@@ -7,6 +7,14 @@ UI, Workflows & Features
  * "git add -p" and friends note what the current status of the hunk
    being shown is.
 
+ * Git aliases now support UTF-8 characters in alias names through
+   subsection syntax: `[alias "name"] command = value`. This enables
+   aliases in non-English languages. The flat syntax continues
+   to work for backward compatibility.
+
+ * The new subsection syntax uses case-sensitive matching and
+   the flat syntax remains case-insensitive for backward compatibility.
+
 
 Performance, Internal Implementation, Development Support etc.
 --------------------------------------------------------------
diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 80ce17d2de..feba1e2022 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -1,12 +1,49 @@
 alias.*::
-	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining `alias.last = cat-file commit HEAD`, the invocation
-	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
-	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored except for deprecated
-	commands.  Arguments are split by
-	spaces, the usual shell quoting and escaping are supported.
-	A quote pair or a backslash can be used to quote them.
+alias.*.command::
+	Command aliases for the linkgit:git[1] command wrapper. Aliases
+	can be defined using two syntaxes:
++
+--
+1. **Simple syntax** (case-insensitive): `alias.name = value`
+2. **Subsection syntax** (recommended for UTF-8/special characters):
+   `[alias "name"]` with `command = value`
+
+The subsection syntax allows alias names containing UTF-8 characters,
+spaces, or special characters, as the subsection preserves the exact
+bytes including case.
+--
++
+Examples:
++
+----
+# Simple syntax (ASCII names)
+[alias]
+    co = checkout
+    st = status
+
+# Subsection syntax (UTF-8 and special characters)
+[alias "hämta"]
+    command = fetch
+[alias "gömma"]
+    command = stash
+[alias "my alias with whitespace"]
+    command = "status --short"
+----
++
+After defining these, you can run `git co`, `git hämta`, `git gömma`,
+and `git "my alias with whitespace"` (note the quotes for aliases with spaces).
++
+**Note:** The flat syntax `alias.name` remains case-insensitive for
+backward compatibility. The new subsection syntax is case-sensitive:
+`[alias "Foo"]` and `[alias "foo"]` are different aliases.
++
+E.g. after defining `alias.last = cat-file commit HEAD`, the invocation
+`git last` is equivalent to `git cat-file commit HEAD`. To avoid
+confusion and troubles with script usage, aliases that
+hide existing Git commands are ignored except for deprecated
+commands.  Arguments are split by
+spaces, the usual shell quoting and escaping are supported.
+A quote pair or a backslash can be used to quote them.
 +
 Note that the first word of an alias does not necessarily have to be a
 command. It can be a command-line option that will be passed into the
diff --git a/alias.c b/alias.c
index 1a1a141a0a..f0c5f12fdd 100644
--- a/alias.c
+++ b/alias.c
@@ -17,19 +17,45 @@ static int config_alias_cb(const char *key, const char *value,
 			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
-	const char *p;
+	const char *cmd, *subkey;
+	size_t cmd_len;
+	int is_subsection;
 
-	if (!skip_prefix(key, "alias.", &p))
+	/* Use parse_config_key() to handle both 2-level and 3-level keys */
+	if (parse_config_key(key, "alias", &cmd, &cmd_len, &subkey) < 0)
 		return 0;
 
+	/*
+	 * Support two syntaxes:
+	 * 1. alias.name = value (simple, 2-level key)
+	 * 2. [alias "name"] command = value (new, 3-level key)
+	 */
+	if (cmd) {
+		if (strcmp(subkey, "command"))
+			return 0;
+		is_subsection = 1;
+	} else {
+		cmd = subkey;
+		cmd_len = strlen(cmd);
+		is_subsection = 0;
+	}
+
 	if (data->alias) {
-		if (!strcasecmp(p, data->alias)) {
+		int match;
+		if (is_subsection) {
+			match = (strlen(data->alias) == cmd_len &&
+				 !strncmp(data->alias, cmd, cmd_len));
+		} else {
+			match = (strlen(data->alias) == cmd_len &&
+				 !strncasecmp(data->alias, cmd, cmd_len));
+		}
+
+		if (match) {
 			FREE_AND_NULL(data->v);
-			return git_config_string(&data->v,
-						 key, value);
+			return git_config_string(&data->v, key, value);
 		}
 	} else if (data->list) {
-		string_list_append(data->list, p);
+		string_list_append_nodup(data->list, xmemdupz(cmd, cmd_len));
 	}
 
 	return 0;
diff --git a/t/t0014-alias-utf8.sh b/t/t0014-alias-utf8.sh
new file mode 100755
index 0000000000..d55b5a7213
--- /dev/null
+++ b/t/t0014-alias-utf8.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='UTF-8 support in git aliases via subsection syntax'
+
+. ./test-lib.sh
+
+# Skip if filesystem/locale doesn't support UTF-8
+test_lazy_prereq UTF8_LOCALE '
+	test_have_prereq !MINGW &&
+	test_set_prereq UTF8_LOCALE
+'
+
+test_expect_success 'setup test repository' '
+	git init &&
+	test_commit initial
+'
+
+test_expect_success UTF8_LOCALE 'setup UTF-8 aliases' '
+	git config alias."förgrena".command branch &&
+	git config alias."分支".command "branch --list" &&
+	git config alias."test name".command status
+'
+
+test_expect_success UTF8_LOCALE 'UTF-8 alias with Swedish characters' '
+	git förgrena >output &&
+	test_grep -E "^(\* )?(main|master)" output
+'
+
+test_expect_success UTF8_LOCALE 'UTF-8 alias with CJK characters' '
+	git 分支 >output &&
+	test_grep -E "^(\* )?(main|master)" output
+'
+
+test_expect_success UTF8_LOCALE 'alias with spaces in name' '
+	git "test name" >output &&
+	test_grep "On branch" output
+'
+
+test_expect_success 'list UTF-8 aliases' '
+	git config --get-regexp "^alias\\..*\\.command" >output &&
+	test_line_count -ge 3 output
+'
+
+test_done
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 07a53e7366..b19a8a5061 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -111,5 +111,37 @@ test_expect_success 'cannot alias-shadow a sample of regular builtins' '
 		cannot_alias_regular_builtin "$cmd" || return 1
 	done
 '
+test_expect_success 'flat syntax still works' '
+	git config alias.testlegacy status &&
+	git testlegacy >output &&
+	test_grep "On branch" output
+'
+
+test_expect_success 'new subsection syntax works' '
+	git config alias.testnew.command status &&
+	git testnew >output &&
+	test_grep "On branch" output
+'
+
+test_expect_success 'subsection syntax only accepts command key' '
+	git config alias.invalid.notcommand "value" &&
+	test_must_fail git invalid 2>error &&
+	test_grep -i "not a git command" error
+'
+
+test_expect_success 'simple syntax is case-insensitive' '
+	git config alias.LegacyCase status &&
+	git legacycase >output 2>&1 &&
+	test_grep "On branch" output
+'
+
+test_expect_success 'subsection syntax is case-sensitive' '
+	test_commit case-test &&
+	git config alias.SubCase.command "log --oneline" &&
+	git config alias.subcase.command status &&
+	git SubCase >upper.out 2>&1 &&
+	git subcase >lower.out 2>&1 &&
+	! test_cmp upper.out lower.out
+'
 
 test_done
-- 
2.53.0

