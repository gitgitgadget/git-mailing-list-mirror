Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB77C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D52075B
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYpw3lG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgEBSRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgEBSRa (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 14:17:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900CC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 11:17:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s18so6284245pgl.12
        for <git@vger.kernel.org>; Sat, 02 May 2020 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgaxNaySz9d2aHYXjOJitFhMXHRRSWvcK3xlIElF8mo=;
        b=oYpw3lG9yfdsA2PQoWbfVL7JPjfVcNMXyC1Tp/8SgaaWxIuEzxR4pxLani5HVHW6z9
         5o4sLeACZo5oPYdWQeOXv3wBRaq1G4KLlYmBw1Fi0S2bZyxLpjl+YmlJzzdQO5Hbt7Py
         HZeDcvRldric4X1GTsB/ARX69NPi+KPx2L14nWZ2WUWXmeOBsEFNk6f2ObIKATXaOU9S
         asEgkI3x/d08pveCtkFV5BvZ7lXGbIeHbRQ0orjZ4WBA9yU5kkgPD/CNgNHIRttnK9GM
         EE/+8q39B08u5ewIvZCjUBDDjRIWhcXOGyJi4o6YzPbTuXyzVJFjr3Pn48NEiStQRlpz
         T+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgaxNaySz9d2aHYXjOJitFhMXHRRSWvcK3xlIElF8mo=;
        b=iQ454GLGlrdxJm9lUw1Y4nurwi1uXRwZxUhMSCbG/UJA7pFvxcYJuGozAI44knHEeF
         IkYxnsi7lwidLschVcxzDKK5KVk7CLekZgyglvud9ZRF902gGyOxCFSBWdYMgxCIQik+
         y+B4qQEfZ0a7z3NEccX/PcIMiitSB++ZZViUBwb5Sh9CzA2/wpBV/2ux5sesFTAYmJdy
         jXcnyrH4tx17YGk5QQ1yqY+dwXcWpEQyjpF682OH2VK/j11ZZfTwp7NdjnKjnxMRV/vr
         4SppDSe73AGY69J/iLVTCfMC37MdSLa9MdZgLPCLsgL2suTHq8Mj7fADFBb1JQQ5CR1X
         dQJw==
X-Gm-Message-State: AGi0PuZ5r4VK6pTKDnB6ecmsHke2w9WQddSJ727S13i2YGSZoYx2jzE2
        tgzx8j7xNQeQn+cmZN4TlfZdFYxj
X-Google-Smtp-Source: APiQypLpnLqBcS+vXuQJx0E0sI8UMDFJBo/BMmvejFjpaKtAebzy2JwDg6kspU6q5dablzBNciaZSw==
X-Received: by 2002:a63:e643:: with SMTP id p3mr9805301pgj.332.1588443449192;
        Sat, 02 May 2020 11:17:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t5sm2204760pgp.80.2020.05.02.11.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 11:17:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v10] credential-store: ignore bogus lines from store file
Date:   Sat,  2 May 2020 11:16:43 -0700
Message-Id: <20200502181643.38203-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
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

As a special case, flag files with CRLF endings as invalid early
to prevent current problems in credential_from_url_gently() with
handling of '\r' in the host.

While at it add tests for all known corruptions that are currently
ignored to keep track of them and avoid the risk of regressions.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v10:
* go back to v4 but with better testing and commit message
* make sure broken CR characters are ignored early
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

 credential-store.c          |  5 ++--
 t/t0302-credential-store.sh | 60 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index c010497cb2..fdfb81e632 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,8 +24,9 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
+		if (strchr(line.buf, '\r') == NULL &&
+		    !credential_from_url_gently(&entry, line.buf, 1) &&
+		    entry.username && entry.password &&
 		    credential_match(c, &entry)) {
 			found_credential = 1;
 			if (match_cb) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..9fd0aca55e 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -107,7 +107,6 @@ test_expect_success 'store: if both xdg and home files exist, only store in home
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
-
 test_expect_success 'erase: erase matching credentials from both xdg and home files' '
 	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
@@ -120,4 +119,63 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+invalid_credential_test() {
+	test_expect_success 'get: ignore credentials without $1 as invalid' '
+		echo "$2" >"$HOME/.git-credentials" &&
+		check fill store <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		protocol=https
+		host=example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://example.com'\'':
+		askpass: Password for '\''https://askpass-username@example.com'\'':
+		--
+		EOF
+	'
+}
+
+invalid_credential_test "scheme" ://user:pass@example.com
+invalid_credential_test "valid host/path" https://user:pass@
+invalid_credential_test "username/password" https://pass@example.com
+
+test_expect_success 'get: credentials with DOS line endings are invalid' '
+	printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username for '\''https://example.com'\'':
+	askpass: Password for '\''https://askpass-username@example.com'\'':
+	--
+	EOF
+'
+
+test_expect_success 'get: store file can contain empty/bogus lines' '
+	echo "" >"$HOME/.git-credentials" &&
+	q_to_tab <<-\CREDENTIAL >>"$HOME/.git-credentials" &&
+	#comment
+	Q
+	https://user:pass@example.com
+	CREDENTIAL
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
 test_done

base-commit: 49458fb91d61461938881559ce23abbb1a2f8c35
-- 
2.26.2.686.gfaf46a9ccd

