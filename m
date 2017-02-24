Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CD2201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 13:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdBXNRA (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 08:17:00 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35158 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdBXNO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 08:14:59 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so3086950pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/2MJXxlzVSM52+2c7aBOU1RTJXgk6I+Jb+hFMhDtTQ=;
        b=LW3gLb9G7ym+M5y4dRk+sOUFE228NlYXmTOK/v3x3oDivb/vnRck6PVdYiAosjK7Rz
         JYYAHSQbM995kC06YPlIJepUSrOVt2rJfmGB+8Lb+gENxODMJb9Lx/6pWZ38Ywzipn6/
         E1oKBNFqEj4otzdFDjdBFGBMZSvRHuF91DrTs7fRC+kUWkEilGteKOVhBcOGYsMEQByB
         rePdh1LSbk6AGtogTem9GaSQVzCOElMHQneOc78bDN4/QclBc4pevL9hiIHCuttSimr8
         DSc84go7dBW7tIEvbk7/OSrirGRYAlNhgWh8nSb1yF4FxU7LcaILKgQXOfnj/ZjNbFgE
         15qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/2MJXxlzVSM52+2c7aBOU1RTJXgk6I+Jb+hFMhDtTQ=;
        b=JnGP3A6AFSaZKvfcf6aUwiGHXJUyaaxioRt69VXd746qpeNUkN09hEhFZqiMCl8ciL
         aYBs5bWaaJQnNPnh3F2oMtFbXlycd8VxjPsDi79CEnhKhWdXNNS6PSInUoJCMwBEXB5H
         fh4/HzZFr0n/0im/PTp7kep84vPbxisalnTrGQabiMiywogyqUwGRLZWR96v9/6+GRZr
         Wl7ZOCcdENcWvnF3FtNPpSNzy7cNITXfUfnkRsU+FUxz/aFQo+7B8EsoekWsLhPTvOFi
         qpCz5XtwKW60DSVx/w0dkZrrxqu2/okalfl50QYhJV3l1kbdvFbT0jMhAOWCU0cMLbIN
         PE8w==
X-Gm-Message-State: AMke39nhkuDghr/a35gjdAHxXBcorBWpdtTePGA88f+XGDKyA6lhNraGv+kKcG+PiPSnHg==
X-Received: by 10.98.62.219 with SMTP id y88mr3411846pfj.62.1487942097371;
        Fri, 24 Feb 2017 05:14:57 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id p66sm15260165pfb.88.2017.02.24.05.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 05:14:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 24 Feb 2017 20:14:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 1/1] config: add conditional include
Date:   Fri, 24 Feb 2017 20:14:25 +0700
Message-Id: <20170224131425.32409-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170224131425.32409-1-pclouds@gmail.com>
References: <20170223122346.12222-1-pclouds@gmail.com>
 <20170224131425.32409-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes a set of repositories want to share configuration settings
among themselves that are distinct from other such sets of repositories.
A user may work on two projects, each of which have multiple
repositories, and use one user.email for one project while using another
for the other.

Setting $GIT_DIR/.config works, but if the penalty of forgetting to
update $GIT_DIR/.config is high (especially when you end up cloning
often), it may not be the best way to go. Having the settings in
~/.gitconfig, which would work for just one set of repositories, would
not well in such a situation. Having separate ${HOME}s may add more
problems than it solves.

Extend the include.path mechanism that lets a config file include
another config file, so that the inclusion can be done only when some
conditions hold. Then ~/.gitconfig can say "include config-project-A
only when working on project-A" for each project A the user works on.

In this patch, the only supported grouping is based on $GIT_DIR (in
absolute path), so you would need to group repositories by directory, or
something like that to take advantage of it.

We already have include.path for unconditional includes. This patch goes
with includeIf.<condition>.path to make it clearer that a condition is
required. The new config has the same backward compatibility approach as
include.path: older git versions that don't understand includeIf will
simply ignore them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt  | 61 +++++++++++++++++++++++++++++
 config.c                  | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015346c417..6c0cd2a273 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,56 @@ found at the location of the include directive. If the value of the
 relative to the configuration file in which the include directive was
 found.  See below for examples.
 
+Conditional includes
+~~~~~~~~~~~~~~~~~~~~
+
+You can include one config file from another conditionally by setting
+a `includeIf.<condition>.path` variable to the name of the file to be
+included. The variable's value is treated the same way as `include.path`.
+
+The condition starts with a keyword followed by a colon and some data
+whose format and meaning depends on the keyword. Supported keywords
+are:
+
+`gitdir`::
+
+	The data that follows the keyword `gitdir:` is used as a glob
+	pattern. If the location of the .git directory match the
+	pattern, the include condition is met.
++
+The .git location which may be auto-discovered, or come from
+`$GIT_DIR` environment variable. If the repository auto discovered via
+a .git file (e.g. from submodules, or a linked worktree), the .git
+location would be the final location, not where the .git file is.
++
+The pattern can contain standard globbing wildcards and two additional
+ones, `**/` and `/**`, that can match multiple path components. Please
+refer to linkgit:gitignore[5] for details. For convenience:
+
+ * If the pattern starts with `~/`, `~` will be substituted with the
+   content of the environment variable `HOME`.
+
+ * If the pattern starts with `./`, it is replaced with the directory
+   containing the current config file.
+
+ * If the pattern does not start with either `~/`, `./` or `/`, `**/`
+   will be automatically prepended. For example, the pattern `foo/bar`
+   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
+
+ * If the pattern ends with `/`, `**` will be automatically added. For
+   example, the pattern `foo/` becomes `foo/**`. In other words, it
+   matches "foo" and everything inside, recursively.
+
+`gitdir/i`::
+	This is the same as `gitdir` except that matching is done
+	case-insensitively (e.g. on case-insensitive file sytems)
+
+A few more notes on matching with `gitdir` and `gitdir/i`:
+
+ * Symlinks in `$GIT_DIR` are not resolved before matching.
+
+ * Note that "../" is not special and will match literally, which is
+   unlikely what you want.
 
 Example
 ~~~~~~~
@@ -119,6 +169,17 @@ Example
 		path = foo ; expand "foo" relative to the current file
 		path = ~/foo ; expand "foo" in your `$HOME` directory
 
+	; include if $GIT_DIR is /path/to/foo/.git
+	[include-if "gitdir:/path/to/foo/.git"]
+		path = /path/to/foo.inc
+
+	; include for all repositories inside /path/to/group
+	[include-if "gitdir:/path/to/group/"]
+		path = /path/to/foo.inc
+
+	; include for all repositories inside $HOME/to/group
+	[include-if "gitdir:~/to/group/"]
+		path = /path/to/foo.inc
 
 Values
 ~~~~~~
diff --git a/config.c b/config.c
index c6b874a7bf..ad16802c8a 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "dir.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -170,9 +171,99 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static int prepare_include_condition_pattern(struct strbuf *pat)
+{
+	struct strbuf path = STRBUF_INIT;
+	char *expanded;
+	int prefix = 0;
+
+	expanded = expand_user_path(pat->buf);
+	if (expanded) {
+		strbuf_reset(pat);
+		strbuf_addstr(pat, expanded);
+		free(expanded);
+	}
+
+	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
+		const char *slash;
+
+		if (!cf || !cf->path)
+			return error(_("relative config include "
+				       "conditionals must come from files"));
+
+		/* TODO: escape wildcards */
+		strbuf_add_absolute_path(&path, cf->path);
+		slash = find_last_dir_sep(path.buf);
+		if (!slash)
+			die("BUG: how is this possible?");
+		strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
+		prefix = slash - path.buf + 1 /* slash */;
+	} else if (!is_absolute_path(pat->buf))
+		strbuf_insert(pat, 0, "**/", 3);
+
+	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
+		strbuf_addstr(pat, "**");
+
+	strbuf_release(&path);
+	return prefix;
+}
+
+static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
+{
+	struct strbuf text = STRBUF_INIT;
+	struct strbuf pattern = STRBUF_INIT;
+	int ret = 0, prefix;
+
+	strbuf_add_absolute_path(&text, get_git_dir());
+	strbuf_add(&pattern, cond, cond_len);
+	prefix = prepare_include_condition_pattern(&pattern);
+
+	if (prefix < 0)
+		goto done;
+
+	if (prefix > 0) {
+		/*
+		 * perform literal matching on the prefix part so that
+		 * any wildcard character in it can't create side effects.
+		 */
+		if (text.len < prefix)
+			goto done;
+		if (!icase && strncmp(pattern.buf, text.buf, prefix))
+			goto done;
+		if (icase && strncasecmp(pattern.buf, text.buf, prefix))
+			goto done;
+	}
+
+	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
+			 icase ? WM_CASEFOLD : 0, NULL);
+
+done:
+	strbuf_release(&pattern);
+	strbuf_release(&text);
+	return ret;
+}
+
+static int include_condition_is_true(const char *cond, size_t cond_len)
+{
+	/* no condition (i.e., "include.path") is always true */
+	if (!cond)
+		return 1;
+
+	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
+		return include_by_gitdir(cond, cond_len, 0);
+	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
+		return include_by_gitdir(cond, cond_len, 1);
+
+	error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
+	/* unknown conditionals are always false */
+	return 0;
+}
+
 int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	const char *cond, *key;
+	int cond_len;
 	int ret;
 
 	/*
@@ -185,6 +276,12 @@ int git_config_include(const char *var, const char *value, void *data)
 
 	if (!strcmp(var, "include.path"))
 		ret = handle_path_include(value, inc);
+
+	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
+	    include_condition_is_true(cond, cond_len) &&
+	    !strcmp(key, "path"))
+		ret = handle_path_include(value, inc);
+
 	return ret;
 }
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 9ba2ba11c3..f0cd2056ba 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -152,6 +152,62 @@ test_expect_success 'relative includes from stdin line fail' '
 	test_must_fail git config --file - test.one
 '
 
+test_expect_success 'conditional include, both unanchored' '
+	git init foo &&
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir:foo/\"]path=bar" >>.git/config &&
+		echo "[test]one=1" >.git/bar &&
+		echo 1 >expect &&
+		git config test.one >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, $HOME expansion' '
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
+		echo "[test]two=2" >.git/bar2 &&
+		echo 2 >expect &&
+		git config test.two >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, full pattern' '
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir:**/foo/**\"]path=bar3" >>.git/config &&
+		echo "[test]three=3" >.git/bar3 &&
+		echo 3 >expect &&
+		git config test.three >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, relative path' '
+	echo "[includeIf \"gitdir:./foo/.git\"]path=bar4" >>.gitconfig &&
+	echo "[test]four=4" >bar4 &&
+	(
+		cd foo &&
+		echo 4 >expect &&
+		git config test.four >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, both unanchored, icase' '
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir/i:FOO/\"]path=bar5" >>.git/config &&
+		echo "[test]five=5" >.git/bar5 &&
+		echo 5 >expect &&
+		git config test.five >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.11.0.157.gd943d85

