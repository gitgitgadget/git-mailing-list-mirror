Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87232D450
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748923; cv=none; b=frWvRCGprlyc7djA7A8XDRCVWVtEbCB5oNKCn/Ov9t5O4pKiUbSDXV6Hfy+7IA69aofp0pDmbZMVkgKRs9BSNV7syXXbbmLk7Ayq3mjIIqIDC7NpIjFV6kZF+r6XsGu+CWT1nvapbw2VdjEp81pu4ET8t4xrilOOdf0kyW5K6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748923; c=relaxed/simple;
	bh=cuW83Sj02hnxNUprnwbW+JkCLpdq0Z1hqV0MqSY+MVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmOzR4hlAC4UPvf6unZWrXX95mqSUaUcPfaRqXEOYH44n5ek+FXgTsg1Gev+mKRbyFvdFyA1A411whSIKVyU8MN8fAryW7nOdA+Z97zLfJcmJkEDUayzV68R5FN2mzEDFUsYuQCspnfONTLqg/lDp+eqCx/DOeJlM3X0a/Vq+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=pvDCwoOg; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="pvDCwoOg"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CC543407EA;
	Tue, 10 Feb 2026 19:33:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrRxsxg5iAZn; Tue, 10 Feb 2026 19:33:22 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 780EF40282;
	Tue, 10 Feb 2026 19:33:22 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0DF4B1E34;
	Tue, 10 Feb 2026 19:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770748345; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/GDdIFvLIWwarWtPRLiOCEaEBzVm1vBn4UHhbXmkP/E=;
	b=pvDCwoOgokIPaBej9mhZi3calEDOH4gd7QDVTaj0Q89z+Yn1GIEb51RRQnwdI4A0kPdLUU
	JSqSSpnTM7W4EXNKCi05/NsPsgGGI8qgpwHRugaViB/gfU9rqJKrhehAUghL8KKKtgHx/Z
	nYczVIx3eqJ6SNY7+Q2STsje3VgA5hyjbMCy+f4FQKdFcXLHOaP+b5EUl25Crak3q774vd
	FdKPcoxgHWfPmvFe6sB5v9s+NYrKLVU/b68CHwGb8+VyiACPKykdiECLI3SjpovYHe6mvy
	QYUDDcpGlSZ26trxwVl7wOYPZFlpGYXlMvSbJTAbY8nnmk8TZxN1Jt8qYajYUA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v2 2/2] alias: support non-alphanumeric names via subsection syntax
Date: Tue, 10 Feb 2026 19:31:10 +0100
Message-ID: <20260210183110.1151072-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210183110.1151072-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Git alias names are limited to alphanumeric characters and dashes
because config variable names are validated by iskeychar(). This
prevents non-English speakers from creating aliases in their native
languages.

Add support for arbitrary alias names by using config subsections:

    [alias "förgrena"]
        command = branch

The subsection name is matched as-is (case-sensitive byte comparison),
while the existing definition without a subsection (e.g.,
"[alias] co = checkout") remains case-insensitive for backward
compatibility. This uses existing config infrastructure since
subsections already support arbitrary bytes, and avoids introducing
Unicode normalization.

Also teach the help subsystem about the new syntax so that "git help
-a" properly lists subsection aliases and the autocorrect feature can
suggest them. Use utf8_strwidth() instead of strlen() for column
alignment so that non-alphanumeric alias names display correctly.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 Documentation/config/alias.adoc | 44 +++++++++++++++++++++-----
 alias.c                         | 45 ++++++++++++++++++++++-----
 help.c                          | 12 +++++--
 t/t0014-alias.sh                | 55 +++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 80ce17d2de..17a548cd64 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -1,12 +1,40 @@
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
+1. Without a subsection, e.g., `[alias] co = checkout`. The alias
+   name is limited to alphanumeric characters and `-` (the same
+   limitation as configuration variable names), and is matched
+   case-insensitively.
+2. With a subsection, e.g., `[alias "name"] command = value`. The
+   alias name can contain any characters including UTF-8, and is
+   matched case-sensitively as raw bytes.
+--
++
+Examples:
++
+----
+# Without subsection
+[alias]
+    co = checkout
+    st = status
+
+# With subsection (allows UTF-8 and special characters)
+[alias "hämta"]
+    command = fetch
+[alias "gömma"]
+    command = stash
+----
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
index c66a6095bb..cfd313ce5d 100644
--- a/alias.c
+++ b/alias.c
@@ -17,21 +17,50 @@ static int config_alias_cb(const char *key, const char *value,
 			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
-	const char *p;
+	const char *subsection, *subkey;
+	size_t subsection_len;
 
-	if (!skip_prefix(key, "alias.", &p))
+	if (parse_config_key(key, "alias", &subsection, &subsection_len,
+			     &subkey) < 0)
 		return 0;
 
+	/*
+	 * Two config syntaxes:
+	 * - alias.name = value        (without subsection, case-insensitive)
+	 * - [alias "name"]
+	 *       command = value       (with subsection, case-sensitive)
+	 */
+	if (subsection) {
+		if (strcmp(subkey, "command"))
+			return 0;
+	}
+
 	if (data->alias) {
-		if (!strcasecmp(p, data->alias)) {
+		int match;
+
+		if (subsection)
+			match = (strlen(data->alias) == subsection_len &&
+				 !strncmp(data->alias, subsection,
+					  subsection_len));
+		else
+			match = !strcasecmp(data->alias, subkey);
+
+		if (match) {
 			FREE_AND_NULL(data->v);
-			return git_config_string(&data->v,
-						 key, value);
+			return git_config_string(&data->v, key, value);
 		}
 	} else if (data->list) {
-		if (value)
-			string_list_append(data->list, p)->util =
-				xstrdup(value);
+		struct string_list_item *item;
+
+		if (!value)
+			return 0;
+
+		if (subsection)
+			item = string_list_append_nodup(data->list,
+				xmemdupz(subsection, subsection_len));
+		else
+			item = string_list_append(data->list, subkey);
+		item->util = xstrdup(value);
 	}
 
 	return 0;
diff --git a/help.c b/help.c
index a450d57987..16abfe7bf3 100644
--- a/help.c
+++ b/help.c
@@ -21,6 +21,7 @@
 #include "fsmonitor-ipc.h"
 #include "repository.h"
 #include "alias.h"
+#include "utf8.h"
 
 #ifndef NO_CURL
 #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
@@ -108,7 +109,7 @@ static void print_command_list(const struct cmdname_help *cmds,
 
 	for (i = 0; cmds[i].name; i++) {
 		if (cmds[i].category & mask) {
-			size_t len = strlen(cmds[i].name);
+			size_t len = utf8_strwidth(cmds[i].name);
 			printf("   %s   ", cmds[i].name);
 			if (longest > len)
 				mput_char(' ', longest - len);
@@ -492,7 +493,7 @@ static void list_all_cmds_help_aliases(int longest)
 	string_list_sort(&alias_list);
 
 	for (i = 0; i < alias_list.nr; i++) {
-		size_t len = strlen(alias_list.items[i].string);
+		size_t len = utf8_strwidth(alias_list.items[i].string);
 		if (longest < len)
 			longest = len;
 	}
@@ -590,8 +591,13 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 
 	/* Also use aliases for command lookup */
 	if (!parse_config_key(var, "alias", &subsection, &subsection_len, &key)) {
-		if (!subsection)
+		if (subsection) {
+			if (!strcmp(key, "command"))
+				add_cmdname(&cfg->aliases, subsection,
+					    subsection_len);
+		} else {
 			add_cmdname(&cfg->aliases, key, strlen(key));
+		}
 	}
 
 	return 0;
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 07a53e7366..66631ad40f 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -112,4 +112,59 @@ test_expect_success 'cannot alias-shadow a sample of regular builtins' '
 	done
 '
 
+test_expect_success 'subsection syntax works' '
+	test_config alias.testnew.command "!echo ran-subsection" &&
+	git testnew >output &&
+	test_grep "ran-subsection" output
+'
+
+test_expect_success 'subsection syntax only accepts command key' '
+	test_config alias.invalid.notcommand value &&
+	test_must_fail git invalid 2>error &&
+	test_grep -i "not a git command" error
+'
+
+test_expect_success 'simple syntax is case-insensitive' '
+	test_config alias.LegacyCase "!echo ran-legacy" &&
+	git legacycase >output &&
+	test_grep "ran-legacy" output
+'
+
+test_expect_success 'subsection syntax is case-sensitive' '
+	test_config alias.SubCase.command "!echo ran-upper" &&
+	test_config alias.subcase.command "!echo ran-lower" &&
+	git SubCase >upper.out &&
+	git subcase >lower.out &&
+	test_grep "ran-upper" upper.out &&
+	test_grep "ran-lower" lower.out
+'
+
+test_expect_success 'UTF-8 alias with Swedish characters' '
+	test_config alias."förgrena".command "!echo ran-swedish" &&
+	git förgrena >output &&
+	test_grep "ran-swedish" output
+'
+
+test_expect_success 'UTF-8 alias with CJK characters' '
+	test_config alias."分支".command "!echo ran-cjk" &&
+	git 分支 >output &&
+	test_grep "ran-cjk" output
+'
+
+test_expect_success 'alias with spaces in name' '
+	test_config alias."test name".command "!echo ran-spaces" &&
+	git "test name" >output &&
+	test_grep "ran-spaces" output
+'
+
+test_expect_success 'subsection aliases listed in help -a' '
+	test_config alias."förgrena".command "!echo test" &&
+	test_config alias."分支".command "!echo test" &&
+	test_config alias.regular "!echo test" &&
+	git help -a >output &&
+	test_grep "förgrena" output &&
+	test_grep "分支" output &&
+	test_grep "regular" output
+'
+
 test_done
-- 
2.53.0

