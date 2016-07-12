Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76751FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbcGLQot (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:44:49 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36026 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcGLQos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 12:44:48 -0400
Received: by mail-lf0-f49.google.com with SMTP id q132so18868990lfe.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 09:44:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWAFciHf5dZfv3F/2+4ERijxkINvCkWfHC4FDc2eNuo=;
        b=D1RZSRfn1P7W+mvONeXCZA9IuqCsilXmW5PoHGKjDaraDZp4s6m74CPgOdxeon8wNZ
         ry6MEAc2Gkg++nJbarbxMSuuwLMC8WjNodfn27tl+yZBFt77zlg+Jw1VCUBPWFijAvCx
         OHP7Teas3PQD+ukuE0jYQu11+DOQoETdEPZ/HGyqPTfJQm7E+5uniTlSNRhH4NG9VXZP
         ejjfs1Qbh1cZB6W2MAmpI5AHfk1vCVNjlOpUFGcoEX5Nn7F++hue6jjuhzjTvRV6Vhq3
         jyARIpc5UNehcVK/Cyiy3TiXpJFHhO4cnJkjpsq/Jsbv2HcjS2MOM98sUXmEalBNoA0A
         JG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWAFciHf5dZfv3F/2+4ERijxkINvCkWfHC4FDc2eNuo=;
        b=hZt+9ouUB+trtOSVayrogYXbGNZWJbvpRbdE6d9TvkjcslQQYp0j8xW1DCtrRkW6Jq
         NcWIzDyC+v4l6KHm6DOCyby4qUd/DAdsTK0aPD3xiRUUeoMYlSNA8vH9gK8IHy/dbX1c
         P46yuvcQA2F7o1IygWJqNHzsfbyKKuL9swxlzawIRpAYw9HVlGvjIYVWI+acBjgvgi91
         /pLMCgRKIDn5ieb6mJlCyXa9QkYcslwAedzt1H9MOys9lnvd9nqwWNfehTmgL+Kz3B4r
         eZWhMmd2DvNDWT3lCGSEcF/+uQ3yxjKzwNprLAxd43YkYvg057N24NTp8BhuLdzQzZQ7
         c4eA==
X-Gm-Message-State: ALyK8tKI4HJ0s3UNTJa2Yt7u6h5ZDu7tZHA5555WA2M9z6ix1MANWjpEPt1VJx72sRNTXw==
X-Received: by 10.25.24.233 with SMTP id 102mr1726950lfy.187.1468341881336;
        Tue, 12 Jul 2016 09:44:41 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id o7sm6463947lfg.45.2016.07.12.09.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 09:44:40 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sschuberth@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] config: add conditional include
Date:	Tue, 12 Jul 2016 18:42:16 +0200
Message-Id: <20160712164216.24072-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160628172641.26381-3-pclouds@gmail.com>
References: <20160628172641.26381-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Helped-by: Jeff King <peff@peff.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v3 fixes some memory leak and typos. Most importantly it no longer
 depends on core.ignorecase for case-insensitive matching. The choice
 must be explicitly made by the user when they choose "gitdir" or
 "gitdir/i" keyword.

 Documentation/config.txt  |  48 ++++++++++++++++++++++
 config.c                  | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 t/t1305-config-include.sh |  56 +++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index db05dec..18623ee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,43 @@ found at the location of the include directive. If the value of the
 relative to the configuration file in which the include directive was
 found.  See below for examples.
 
+Included files can be grouped into subsections where the subsection
+name is the condition that must be met for the files to be included.
+The condition starts with a keyword, followed by a colon and a
+pattern. The interpretation of the pattern depends on the keyword.
+Supported keywords are:
+
+`gitdir`::
+	The environment variable `GIT_DIR` must match the following
+	pattern for files to be included. The pattern can contain
+	standard globbing wildcards and two additional ones, `**/` and
+	`/**`, that can match multiple path components. Please refer
+	to linkgit:gitignore[5] for details. For convenience:
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
+A few more notes on matching:
+
+ * Symlinks in `$GIT_DIR` are not resolved before matching.
+
+ * Note that "../" is not special and will match literally, which is
+   unlikely what you want.
 
 Example
 ~~~~~~~
@@ -119,6 +156,17 @@ Example
 		path = foo ; expand "foo" relative to the current file
 		path = ~/foo ; expand "foo" in your `$HOME` directory
 
+	; include if $GIT_DIR is /path/to/foo/.git
+	[include "gitdir:/path/to/foo/.git"]
+		path = /path/to/foo.inc
+
+	; include for all repositories inside /path/to/group
+	[include "gitdir:/path/to/group/"]
+		path = /path/to/foo.inc
+
+	; include for all repositories inside $HOME/to/group
+	[include "gitdir:~/to/group/"]
+		path = /path/to/foo.inc
 
 Values
 ~~~~~~
diff --git a/config.c b/config.c
index bea937e..ff44e00 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "dir.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -168,9 +169,102 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static int prepare_include_condition_pattern(struct strbuf *pat)
+{
+	int prefix = 0;
+
+	/* TODO: maybe support ~user/ too */
+	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
+		struct strbuf path = STRBUF_INIT;
+		const char *home = getenv("HOME");
+
+		if (!home)
+			return error(_("$HOME is not defined"));
+
+		strbuf_add_absolute_path(&path, home);
+		strbuf_splice(pat, 0, 1, path.buf, path.len);
+		prefix = path.len + 1 /*slash*/;
+		strbuf_release(&path);
+	} else if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
+		struct strbuf path = STRBUF_INIT;
+		const char *slash;
+
+		if (!cf || !cf->path)
+			return error(_("relative config include "
+				       "conditionals must come from files"));
+
+		strbuf_add_absolute_path(&path, cf->path);
+		slash = find_last_dir_sep(path.buf);
+		if (!slash)
+			die("BUG: how is this possible?");
+		strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
+		prefix = slash - path.buf + 1 /* slash */;
+		strbuf_release(&path);
+	} else if (!is_absolute_path(pat->buf))
+		strbuf_insert(pat, 0, "**/", 3);
+
+	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
+		strbuf_addstr(pat, "**");
+
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
@@ -181,8 +275,12 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(value, inc);
+	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
+	    include_condition_is_true(cond, cond_len)) {
+		if (!strcmp(key, "path"))
+			ret = handle_path_include(value, inc);
+		/* else we do not know about this type of include; ignore */
+	}
 	return ret;
 }
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 9ba2ba1..83501ec 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -152,6 +152,62 @@ test_expect_success 'relative includes from stdin line fail' '
 	test_must_fail git config --file - test.one
 '
 
+test_expect_success 'conditional include, both unanchored' '
+	git init foo &&
+	(
+		cd foo &&
+		echo "[include \"gitdir:foo/\"]path=bar" >>.git/config &&
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
+		echo "[include \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
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
+		echo "[include \"gitdir:**/foo/**\"]path=bar3" >>.git/config &&
+		echo "[test]three=3" >.git/bar3 &&
+		echo 3 >expect &&
+		git config test.three >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, relative path' '
+	echo "[include \"gitdir:./foo/.git\"]path=bar4" >>.gitconfig &&
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
+		echo "[include \"gitdir/i:FOO/\"]path=bar5" >>.git/config &&
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
2.9.1.564.gb2f7278

