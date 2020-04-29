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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C84C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92C920BED
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8HbJx2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgD2UgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2UgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:36:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A9C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:36:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so1263574plp.9
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wzq92Z+/5gPHtd54m1SvDtOj8s6st96aeBfBD4oBUMw=;
        b=L8HbJx2jsRLB3yZWrZq0Q66p6GpPN3EG8pSl3ehhFTvEUoSpML7xIAYcXGM0Guad+4
         qUkCReb8V9pFS1PHNmD7g2y9RVV9IrcKzCQNRh9YC9WhRSeJ5S3UwtvFIvmTl0WRM/nJ
         80HQ/mTmt57aLZQHSZ4kushViJOD+knTTRPII5XfwkSQw6FnQbXeIqcm11UwwdbDsi5I
         rhOhZic3uBRlHeDm36s4VoY5uX0Os2S8ChHGdzpW8L/idbLXENv0InwSyE7Rv0zB1uYw
         VKrMD75BTPEaxtiUoHUoyzY5FLbOtaCqNoyJz7rxO79WDdVROKy5HRy+6aX/QVhVhhc5
         D9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wzq92Z+/5gPHtd54m1SvDtOj8s6st96aeBfBD4oBUMw=;
        b=c/XpF6HopnY1GoGTaYIU2P48DnGxQD56PNuZSwMuUpJEA1a6faLvpQpWLSIX0eT2lp
         8yBVUrG/uKC1oNn2HqFC28LUJxyD1wH6JhoV5U+RyiszGscYSKqV/XaJF0gNbuYvPf9Y
         eAgcAg5Lp+4PZvv19drmrfu2aIU04L+FUivIjy52gFLL9+huF7VR4QOI2w/uqv3HgvxR
         1JeiUWVx28Kbno4D6ffrsZSgTKg5okDJwyVHVsklf+H1UWtFDLXhzo1qa9+zAG+J4nwk
         WKGcYSxWAMp98ztuRUuBiAtJl5gqJa+1r/eY4TE5Lj5RpU5Cir4vxrxZgaz2cBcxSzKh
         L56g==
X-Gm-Message-State: AGi0Puafq+kVkXBUsXmVOqltyhnImUfeaBPamwiDyoFWFsshOuvaXpkn
        /X6E2a7Jo/fzSo2CxfaXmP7brVQU
X-Google-Smtp-Source: APiQypKhgVcgdF4AEozDi8dNeldf9T9hKh3gD8bfKsQHJA+ROhU2gqNEaZhdnyD4vLHB5de9vfYoRQ==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr137197plo.335.1588192570870;
        Wed, 29 Apr 2020 13:36:10 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h14sm1816404pfq.46.2020.04.29.13.36.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 13:36:10 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v6 1/2] credential-store: warn instead of fatal for bogus lines from store
Date:   Wed, 29 Apr 2020 13:35:45 -0700
Message-Id: <20200429203546.56753-2-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200429203546.56753-1-carenas@gmail.com>
References: <20200429003303.93583-1-carenas@gmail.com>
 <20200429203546.56753-1-carenas@gmail.com>
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
 Documentation/git-credential-store.txt | 12 ++++++--
 credential-store.c                     | 22 +++++++++-----
 t/t0302-credential-store.sh            | 42 ++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 10 deletions(-)

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
index c010497cb2..1cc5ca081a 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -15,6 +15,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	int lineno = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -24,16 +25,21 @@ static int parse_credential_file(const char *fn,
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
+		else
+			warning(_("ignoring invalid credential in %s:%d"),
+				fn, lineno);
+		if (!found_credential && other_cb)
 			other_cb(&line);
 	}
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..801c1eb200 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,46 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
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
-- 
2.26.2.569.g1d74ac4d14

