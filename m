Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F9C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1499C206D4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBtXvwgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgD0M7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbgD0M7w (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 08:59:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F8C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 05:59:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z1so7288875pfn.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goT77AJfQYdT/5PNQ4aWJqWamT2/cVCx+Vc3AaJvc4M=;
        b=rBtXvwgMn7VsabYOl9NBKT0wPdeYIlEbVFt4AY6aEQYxjbdrv+wTJK+TojsDEwYzvB
         SXXlpr5YIa0XyuuXhos7C0kLBvy/1M64y0Pse6wRJdUEvrYPNJNCGu48sirU7yh3Jtr+
         iqAcJHnkLPXswRcUlmoVU8OcKidhyDLbuPInZHdybve3I+hwE8OVWjeYTAs4fnnBh9iW
         8H0vrLjRyMX6thvJgFNLxtxt2MHapICp4ITnaS8Aac3GuL4r9wrfie+u64ULaTGFwUp2
         zFhKQ6DusUfnJpc0Lz/26j2LatnYJQSMi7vLpJoZzRxCtFtNa+Id+r/nzA8gxFfkvmUS
         ol0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goT77AJfQYdT/5PNQ4aWJqWamT2/cVCx+Vc3AaJvc4M=;
        b=ug3/ct8t+WwaufGM7G8K1xGtGNrHcaaxBl9kYZBpw6AdW4fKDUt4N0ePY3VtkyMpZP
         +Y+MbKfWwngJHkmw/r/SRy1mnrxFNaQ03kf59dl2VPyN9PKbzmvCkLdmVYEPgUFaCe84
         9KQsz+8wZpHV3HmIGVZq9WY6qCfAFDy/UMCPW5aGSIoWV/Eee9IlORN3Ms8ivXqdDbGx
         /VIUtvhdq/S0RxzPHhU+KTiEJWNBirfNjDRupUsLAQFcXzFgYRI+RTpke8D4ztLs+y0+
         Vw/LxWM+H3vLDhb6EQJ4D1iBIDRHi3hL0xc22QDJwueGC7EP0xD8qzs0o5QprK5FSu9W
         gYyQ==
X-Gm-Message-State: AGi0PuZ7myKHEzr87+M7aLiYXiF6MIQGLTq8Q/r13vKtutqVeFMq5cjT
        1CQJBGRjBhTVKamclhMpNfG7sfIl
X-Google-Smtp-Source: APiQypIHn8WFMRORvWZEJSULsLWK4KAumRoesfB2eaksN45cKmRlvEJU/TnhqvQkDeboBLoOVhLXwA==
X-Received: by 2002:a62:ae0f:: with SMTP id q15mr23378212pff.181.1587992390934;
        Mon, 27 Apr 2020 05:59:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h31sm11617822pjb.33.2020.04.27.05.59.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 05:59:50 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3] git-credential-store: skip empty lines and comments from store
Date:   Mon, 27 Apr 2020 05:59:15 -0700
Message-Id: <20200427125915.88667-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200427084235.60798-1-carenas@gmail.com>
References: <20200427084235.60798-1-carenas@gmail.com>
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

using the store file in this manner wasn't intended by the original
code and it had latent issues which the new code dutifully prevented
but since the strings used wouldn't had been valid credentials anyway
we could instead detect them and skip the matching logic and therefore
formalize this "feature".

trim all lines as they are being read from the store file and skip the
ones that will be otherwise empty or that start with "#" (therefore
assuming them to be comments)

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v3:
* avoid using q_to_cr as suggested by Peff
* a more verbose commit message and slightly more complete documentation 
v2:
* use a here-doc for clarity as suggested by Eric
* improve commit message and include documentation

 Documentation/git-credential-store.txt |  7 +++++++
 credential-store.c                     |  3 +++
 t/t0302-credential-store.sh            | 15 +++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 693dd9d9d7..48ab4b13e5 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -101,6 +101,13 @@ username (if we already have one) match, then the password is returned
 to Git. See the discussion of configuration in linkgit:gitcredentials[7]
 for more information.
 
+Note that the file used is not a configuration file and should be ideally
+managed only through git, as any manually introduced typos will compromise
+the validation of credentials.
+
+The parser will ignore any lines starting with the '#' character during
+the processing of credentials for read, though.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..b2f160890d 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,6 +24,9 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
+		strbuf_trim(&line);
+		if (line.len == 0 || *line.buf == '#')
+			continue;
 		credential_from_url(&entry, line.buf);
 		if (entry.username && entry.password &&
 		    credential_match(c, &entry)) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..5e6ace3a06 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,19 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: allow for empty lines or comments in store file' '
+	test_write_lines "#comment" " " "" \
+		 https://user:pass@example.com >"$HOME/.git-credentials" &&
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
-- 
2.26.2.569.g1d74ac4d14

