Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26881C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 03:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0985206B8
	for <git@archiver.kernel.org>; Fri,  1 May 2020 03:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxt8iWnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgEADWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEADWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 23:22:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB5C035495
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 20:22:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so3217362plp.6
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nt0gCdVHwGWOuDgs+LrxozggfWt8xZyo4udjV1Emh/k=;
        b=qxt8iWnX9xWm4Z9Xy/v7MCYH9OI1xIcLWHQBoDaYzR9lRCEIt9LiGE59IhVLsodP0H
         pDhm5t0qezJzbsOHiCkevocBkMWvBXNdBxjM+zZC1s6U0NdOv+uE12TRLVLlGKaxlv6t
         AaLG7+YNF4fjkRm0NviBTzBIM0NV/sU30NRPIx4AquM8Aw5VHirLCo2+LaydU7Tn2w4c
         SAa8w6CuMbKqwjaIvaf3om2uzMMW3rJlj/5ikiq8YVrPntKqtjDUJG0DRju3WZDFLKDt
         72WoqSBV2jMrTESDKPEW3Spsx7fbODoC/ynEiOwSbZzpZPqSfNBhXyR8nNXL1hL/6ual
         9xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nt0gCdVHwGWOuDgs+LrxozggfWt8xZyo4udjV1Emh/k=;
        b=kBPa8Mnpr+9yFJwkHP5sXAwOigQRfKQ0MhkpI+MCjExSG+iKL7PPD6Gqo3RFrRp/1x
         MRPVqI6+TQ4NKjcLmj00V8y8lp9rDSRLTWGaJW9+2IdO5/1Mhj90dodPEGbzX095JyJv
         DbHqYvn0vXQeNhRs3zJBwHrsvGmVVeBd1AMjnGaXw0Q7/++FHoU2kt1T+2WFw/q0L1Ew
         wSEhpQFKF54NjCqgEIUtXkUMzmVfsHGJN4xEv9bO5vgOat+lWChA6RdC1aw+kWmjANCB
         BvraBZDO1Tn+2Pcw7TgXLDis09yFvumhdt3CGIrtSNcA0m9T2O9I8PsSjrfx4gyDO4Zf
         +dLw==
X-Gm-Message-State: AGi0PuZNz9Ng3s1Dkl6dsEzcJH+kkSbrsJ0UjvH7jWfhN4clLaIH8wNW
        5ISISULBjxANiRfLAFg3wUER5P6T
X-Google-Smtp-Source: APiQypIWhTsaQdSmnLRcyxYU5NfwLPreD+ukW/Y7CBiLxh9wanI0sPC9MccLRbqysqxUvF5ML0sHhg==
X-Received: by 2002:a17:902:dc83:: with SMTP id n3mr1212861pld.133.1588303364518;
        Thu, 30 Apr 2020 20:22:44 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id v7sm981920pfm.146.2020.04.30.20.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 20:22:43 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v10] credential-store: warn/ignore for bogus lines from store file
Date:   Thu, 30 Apr 2020 20:21:52 -0700
Message-Id: <20200501032152.12160-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.2.gf219a08795
In-Reply-To: <20200430160642.90096-1-carenas@gmail.com>
References: <20200430160642.90096-1-carenas@gmail.com>
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

Warn the user indicating the filename and line number during get,
for all entries that were processed, but continue parsing until
a match is found or all valid credentials are processed.

Warning during store and erase operations has been suppressed
for now by adding a PARSER_VERBOSE flag that is only enabled
during get operations.

Make sure that the credential that we will use to match is complete by
confirming it has all fields set as expected by the updated rules.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v10:
* insted of trying to use broken credentials in DOS format, make
  sure they are flagged as broken
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

 Documentation/git-credential-store.txt |  18 +++-
 credential-store.c                     |  32 ++++++--
 t/t0302-credential-store.sh            | 109 ++++++++++++++++++++++++-
 3 files changed, 150 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b0798856..18ba8b6984 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -95,8 +95,22 @@ https://user:pass@example.com
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
+
+Note that because of deficiencies of the current implementation, these
+warnings will be only generated for the entries that were processed
+while reading the credential files during a get operation, and so they
+are not comprehensive, and will require you to use an editor (or
+better a sed/awk/perl one liner) to edit the credential file and remove
+them.
 
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..c2778eff8a 100644
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
@@ -24,16 +35,24 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
-		    credential_match(c, &entry)) {
+		lineno++;
+
+		if (strchr(line.buf, '\r') ||
+			credential_from_url_gently(&entry, line.buf, 1) ||
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
 
@@ -62,7 +81,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to get credential storage lock");
 	if (extra)
 		print_line(extra);
-	parse_credential_file(fn, c, NULL, print_line);
+	parse_credential_file(fn, c, 0, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
@@ -139,7 +158,8 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 	struct string_list_item *fn;
 
 	for_each_string_list_item(fn, fns)
-		if (parse_credential_file(fn->string, c, print_entry, NULL))
+		if (parse_credential_file(fn->string, c, PARSE_VERBOSE,
+						 print_entry, NULL))
 			return; /* Found credential */
 }
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..00608e365a 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -107,7 +107,6 @@ test_expect_success 'store: if both xdg and home files exist, only store in home
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
-
 test_expect_success 'erase: erase matching credentials from both xdg and home files' '
 	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
@@ -120,4 +119,112 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
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
+test_expect_success 'get: credentials with DOS line endings are invalid' '
+	printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" &&
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

