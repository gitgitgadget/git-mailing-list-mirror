Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67255C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D02074A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 00:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqHytGRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgD2AeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD2AeD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 20:34:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977FAC03C1AC
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 17:34:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h11so155946plr.11
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLz4k/xkRuwHRDwhI1CcjMaynvzv7C0GaWVuznI19y8=;
        b=IqHytGROj0DZ07fLB4g09+/wgokhyipDCKqWq/zVs/XgH/wW2WOzgUTfyIL1V7t6XX
         zbDDlZYasBuiXfZWJnOKd2JrsgNLxoy4Oi2On1gL9G4YN1bXYGiLbL0S71itlgxnBAl7
         6hH5rjteU18p7dBQZNiQEEzx0RWW2YyWetUQVm2RtxJ94jypMAg34AYftw7f107q4zzj
         7NBJTFqJzvC0YDZ2unnwGp8op3z+MQfEYPDoWJ9itNSDxAw+jVfxN25bBOOJIdNlkbcE
         +H8EXHG79y8izUXHIShI29ONydE5ROFZmGq+VXvv2dK1kc6NMRUjl2rpvM/FeIxl/ea4
         KzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLz4k/xkRuwHRDwhI1CcjMaynvzv7C0GaWVuznI19y8=;
        b=KP+gAqA5t6As4GqFTp/pEhGUlonqbHqy61nUzp34ASpoSk9sWkKSRAexIXApY3eioG
         17eyCyK8uEmVOm1Gg+5ok/k9x3wbmQSfapRDg7d+zJcK8CzTu2ytEyqZ3GtkWVUiVI77
         CNZNWXSBROtwfNh7l3wnY6CHoLAkmmk2hlHej7jnm1oErNIVnk76OwLF3Nlw1CKyED1C
         K0idVSC9XhHp14OlXBIU05B7qD5UISsxOCPHcoWVmD6NxZFyDpbEGilWKAJiqMzro6go
         KAU8CgCwltwzJTaOjIXLHc9FZ+jI6xg6fdcKRDe7wLZxCsDfGK5iBVn6PFCvmm5l4b3F
         Xmcw==
X-Gm-Message-State: AGi0PuZnfvZmil5egNeg4vMsc4bYPNp57UyHRLEi8jRwSFjOV7ex4Ycj
        b0YNAfX06FvkaUoPBmwomfR7peQ1
X-Google-Smtp-Source: APiQypKwGYysaf9vvAE3V1nWTq0h+UWo2zyiXIq/LFstfaGDBVFzYl+kPRibKjvgsvoT/OZQxqGCYw==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr32205407plq.132.1588120440290;
        Tue, 28 Apr 2020 17:34:00 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id l30sm14078249pgu.29.2020.04.28.17.33.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:33:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5] credential-store: warn instead of fatal for bogus lines from store
Date:   Tue, 28 Apr 2020 17:33:03 -0700
Message-Id: <20200429003303.93583-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200428104858.28573-1-carenas@gmail.com>
References: <20200428104858.28573-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] failing to parse as valid credentials.

instead of doing a hard check for credentials, do a soft one and
warn the user so any invalid entries could be corrected.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v5:
* q_to_tab this round, with a single echo to make sure empty line
  is covered, as that seems to be a popular issue
* rebase on top of jc/credential-store-file-format-doc
* implement a redacter for credentials to use on errora to avoid
  leaking passwordss
v4:
* use credential_from_url_gently instead as shown by Jonathan
* add documentation to clarify "comments" is not a supported feature
v3:
* avoid using q_to_cr as suggested by Peff
* a more verbose commit message and slightly more complete documentation
v2:
* use a here-doc for clarity as suggested by Eric
* improve commit message and include documentation

 Documentation/git-credential-store.txt | 12 +++++-
 credential-store.c                     | 51 ++++++++++++++++++++++----
 t/t0302-credential-store.sh            | 43 ++++++++++++++++++++++
 3 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b0798856..30d498fe54 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -95,8 +95,16 @@ https://user:pass@example.com
 ------------------------------
 
 No other kinds of lines (e.g. empty lines or comment lines) are
-allowed in the file, even though some may be silently ignored. Do
-not view or edit the file with editors.
+allowed in the file, even though historically the parser was very
+lenient and some might had been silently ignored.
+
+Do not edit the file with editors as it could compromise the validity
+of your credentials by sometimes subtle formatting issues (like spaces)
+
+In cases where those formatting issues are detected during parsing a
+warning indicating the line found will be printed to stderr so it can
+be corrected at your earliest convenience, but the remaining valid
+credentials will be used to try to find a match as described below.
 
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..5324c56ce1 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -6,6 +6,32 @@
 
 static struct lock_file credential_lock;
 
+static char *redact_credential(const struct strbuf *line)
+{
+	struct strbuf redacted_line = STRBUF_INIT;
+	char *at = strchr(line->buf, '@');
+	char *colon;
+	int redacted = 0;
+
+	if (at) {
+		strbuf_addf(&redacted_line, "%.*s",
+			(int)(at - line->buf), line->buf);
+		colon = strrchr(redacted_line.buf, ':');
+		if (colon && *(colon + 1) != '/') {
+			redacted_line.len = colon - redacted_line.buf + 1;
+			strbuf_addstr(&redacted_line, "<redacted>");
+			strbuf_addstr(&redacted_line, at);
+			redacted = 1;
+		}
+		else
+			strbuf_reset(&redacted_line);
+	}
+	if (!redacted)
+		strbuf_addbuf(&redacted_line, line);
+
+	return redacted_line.buf;
+}
+
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
 				  void (*match_cb)(struct credential *),
@@ -15,6 +41,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	int lineno = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -24,16 +51,24 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
-		    credential_match(c, &entry)) {
-			found_credential = 1;
-			if (match_cb) {
-				match_cb(&entry);
-				break;
+		lineno++;
+		if (!credential_from_url_gently(&entry, line.buf, 1)) {
+			if (entry.username && entry.password &&
+				credential_match(c, &entry)) {
+				found_credential = 1;
+				if (match_cb) {
+					match_cb(&entry);
+					break;
+				}
 			}
 		}
-		else if (other_cb)
+		else {
+			char *redacted = redact_credential(&line);
+			warning("%s:%d %s: %s", fn, lineno,
+				 _("ignoring invalid credential"), redacted);
+			free(redacted);
+		}
+		if (!found_credential && other_cb)
 			other_cb(&line);
 	}
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..68b59e6f98 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,47 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: credentials without scheme are invalid' '
+	echo "://user:secret@example.com" >"$HOME/.git-credentials" &&
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
+	test_i18ngrep "ignoring invalid credential" stderr &&
+	! grep secret stderr
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
 test_done

base-commit: 272281efcc18fcedd248597b8859f343cae1c5a0
-- 
2.26.2.569.g1d74ac4d14

