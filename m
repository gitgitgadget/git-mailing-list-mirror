Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3073C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6BA2076D
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOuyuMwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgD3QHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728498AbgD3QHC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 12:07:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBE9C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 09:07:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so885358pjb.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W84zTMZEOjazhwXoglfzIFSSSegoEP10UMg4Bx2XDDE=;
        b=pOuyuMwOyk8J0Qo3cFf+V74JPkRkJVmWB+tCrtZFrwyhyGN4usSaRC/eJCVr3IT6om
         faUn+1vPT1L63aFCbjFpeNRjSzca69yYuE4OSi3W9+8eHvpMyYEGUh7mQn6RG197L/YZ
         f0dvl9WJmSuP/OpmqgyFppFNvJXVuKCjlGQ8qxhGSkDsoHBkfKjpcgL4WJ5hjVjCYpOa
         rv9ALeKanndjGg19OKcpdf1MoYkLYJ6gAQz3av2+mdsQmkivtc7kfuyfa+6P/7UvKbzr
         gZnzbYYrtG5eLnnHaqB7cQcNdljRovRZJkVL9NrXJVydLJrsK7jGR3gqSaYO974UT729
         nWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W84zTMZEOjazhwXoglfzIFSSSegoEP10UMg4Bx2XDDE=;
        b=dJii17sXOaymq3E12/VPXHYVr2BwNt3P4E99XmX1cDNVuACu/JrNjiEotVcKEwjwXU
         82fJQq+YybjjO+yyQTaTckQxdHprLYZa9oC8t1AHCkOkMM9cPs/gHMb6K+fJTb6kUld5
         xgdNKssqrLvQ+m6OW/gMcQk2gYW+BfGI6yqefjjKqIUB7BzJIvC0TswsNV4BGudvLsQR
         HtZs5ro3HW7Dp/mwNSypgL5fpx/Nty4NrJCIN0yaQkTRFdvHGxjIa5KIVHt1STM4CdRq
         6Y3hFva2Oplx03cyTf3p5cpCDrpg4jbUl1skvtKtkBHJe6QhP6GduAHLa3ALDbNvZk+P
         b0Nw==
X-Gm-Message-State: AGi0PuaDNfSLqs0uXbOcG8K8KWW2GX2gIOD5e5ZZIxYmVV5E6AOjBqGi
        2vI5jPBtrmHmpKj1CgXHCmttO5x7
X-Google-Smtp-Source: APiQypLy0MuwbD7mOq6BXlS1fy8+n1d47U0e2nVuAmokz3HoWsKm63hHqjsPamgYt6fpKA43e+S6eQ==
X-Received: by 2002:a17:902:5a0f:: with SMTP id q15mr4408732pli.155.1588262820923;
        Thu, 30 Apr 2020 09:07:00 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e2sm255236pjt.2.2020.04.30.09.06.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:07:00 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v9] credential-store: warn instead of fatal for bogus lines from store
Date:   Thu, 30 Apr 2020 09:06:42 -0700
Message-Id: <20200430160642.90096-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.2.gf219a08795
In-Reply-To: <20200430011959.70597-1-carenas@gmail.com>
References: <20200430011959.70597-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] failing to parse as valid credentials.

Instead of doing a hard check for credentials, do a soft one and
therefore avoid the reported fatal error.

Warn the user indicating the filename and line number so any invalid
entries could be corrected but continue parsing until a match is
found or all valid credentials are processed.

Make sure that the credential that we will use to match is complete by
confirming it has all fields set as expected by the updated rules.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v9:
* use strbuf_getline() instead to better handle files with CRLF
v8:
* only warn during get operations as otherwise line number might be
  incorrect
v7:
* check for protocol in helper as suggested by Junio
v6:
* get rid of redacter and only use line number for context in warning
* make validation more strict to also catch incomplete credentials
* reorder check as suggested by Junio
v5:
* q_to_tab this round, with a single echo to make sure empty line
  is covered, as that seems to be a popular issue
* rebase on top of jc/credential-store-file-format-doc
* implement a redacter for credentials to use on errors to avoid
  leaking passwords
v4:
* use credential_from_url_gently instead as shown by Jonathan
* add documentation to clarify "comments" is not a supported feature
v3:
* avoid using q_to_cr as suggested by Peff
* a more verbose commit message and slightly more complete documentation
v2:
* use a here-doc for clarity as suggested by Eric
* improve commit message and include documentation

 Documentation/git-credential-store.txt | 11 +++-
 credential-store.c                     | 33 ++++++++--
 t/t0302-credential-store.sh            | 90 +++++++++++++++++++++++++-
 3 files changed, 124 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b0798856..d5841cffad 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -95,8 +95,15 @@ https://user:pass@example.com
 ------------------------------
 
 No other kinds of lines (e.g. empty lines or comment lines) are
-allowed in the file, even though some may be silently ignored. Do
-not view or edit the file with editors.
+allowed in the file, even though historically the parser was very
+lenient and some might had been silently ignored.
+
+Do not view or edit the file with editors as it could compromise the
+validity of your credentials by sometimes subtle formatting issues,
+like spaces, line wrapping or text encoding.
+
+An unparseable or otherwise invalid line is ignored, and a warning
+message points out the problematic file and line number it appears in.
 
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..b1f5b2dea6 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -4,10 +4,20 @@
 #include "string-list.h"
 #include "parse-options.h"
 
+#define PARSE_VERBOSE 0x01
+
 static struct lock_file credential_lock;
 
+static int valid_credential(struct credential *entry)
+{
+	return (entry->username && entry->password &&
+		entry->protocol && *entry->protocol &&
+		((entry->host && *entry->host) || entry->path));
+}
+
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
+				  int flags,
 				  void (*match_cb)(struct credential *),
 				  void (*other_cb)(struct strbuf *))
 {
@@ -15,6 +25,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	int lineno = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -23,17 +34,24 @@ static int parse_credential_file(const char *fn,
 		return found_credential;
 	}
 
-	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
-		    credential_match(c, &entry)) {
+	while (strbuf_getline(&line, fh) != EOF) {
+		lineno++;
+
+		if (credential_from_url_gently(&entry, line.buf, 1) ||
+			!valid_credential(&entry)) {
+			if (flags & PARSE_VERBOSE)
+				warning(_("%s:%d: ignoring invalid credential"),
+					fn, lineno);
+		} else if (credential_match(c, &entry)) {
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
 				break;
 			}
+			continue;
 		}
-		else if (other_cb)
+
+		if (other_cb)
 			other_cb(&line);
 	}
 
@@ -62,7 +80,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to get credential storage lock");
 	if (extra)
 		print_line(extra);
-	parse_credential_file(fn, c, NULL, print_line);
+	parse_credential_file(fn, c, 0, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
@@ -139,7 +157,8 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 	struct string_list_item *fn;
 
 	for_each_string_list_item(fn, fns)
-		if (parse_credential_file(fn->string, c, print_entry, NULL))
+		if (parse_credential_file(fn->string, c, PARSE_VERBOSE,
+						 print_entry, NULL))
 			return; /* Found credential */
 }
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..05fd2785b9 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -107,7 +107,6 @@ test_expect_success 'store: if both xdg and home files exist, only store in home
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
-
 test_expect_success 'erase: erase matching credentials from both xdg and home files' '
 	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
@@ -120,4 +119,93 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: credentials without scheme are invalid' '
+	echo "://user:pass@example.com" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
+'
+
+test_expect_success 'get: credentials without valid host/path are invalid' '
+	echo "https://user:pass@" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
+'
+
+test_expect_success 'get: credentials without username/password are invalid' '
+	echo "https://pass@example.com" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
+'
+
+test_expect_success 'get: store file can contain empty/bogus lines' '
+	echo "" > "$HOME/.git-credentials" &&
+	q_to_tab <<-\CONFIG >>"$HOME/.git-credentials" &&
+	#comment
+	Q
+	https://user:pass@example.com
+	CONFIG
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	test_i18ngrep "ignoring invalid credential" stderr &&
+	test_line_count = 3 stderr
+'
+
+test_expect_success 'store: store succeeds silently in corrupted file' '
+	echo "#comment" >"$HOME/.git-credentials" &&
+	check approve store <<-\EOF &&
+	url=https://user:pass@example.com
+	EOF
+	grep "https://user:pass@example.com" "$HOME/.git-credentials" &&
+	test_must_be_empty stderr
+'
+
 test_done

base-commit: 272281efcc18fcedd248597b8859f343cae1c5a0
-- 
2.26.2.2.gf219a08795

