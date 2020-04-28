Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D57C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011F8206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0eAz3My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD1KxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD1KxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 06:53:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2DC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so2031492pgl.9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbZPo6+Z6Jy5bqNmnxr4gauO3cCT1QRZ2xCgTc+iCpI=;
        b=k0eAz3My/33APph0Meq5E04q0ymIuHo+EKi2znbf3tjPgIY56as086WU8gx/TJrTEw
         2l2nyp5eEE8zFRsggqu8/eGF3HjIEqQS0Y0WbzVV3rSXW7KvYXzVIIMl9tzA0t7hJ5Bg
         d5Gmp/Imei6VRCBgGUqH6x9qWCOV5q6NUAFkW99IH+svF3RBEbie4T+n93nWoqweNqVh
         HOBoWXSat6WC4dc21xFLnBMwRwRhVooEMUxHt/y7/s2JC9j3zovEF5W1nmDGj0pP2ESN
         Hkk42StwsAKwDVD2T9JrJX2QTwX7vIYa3CfoceLcZngCMTi2D+5IuRs+zUYNsEwA7TnU
         QeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbZPo6+Z6Jy5bqNmnxr4gauO3cCT1QRZ2xCgTc+iCpI=;
        b=rxwCBx9WxDxuTW+DiKPAoMjZKPKBsRn01WPtTCjTHiFJ4tv5Txk5bNBpwo2zwR2fOd
         CfwZVugVrcEUK5uoIaY2+xaxf6iyJy1zzJ8nC3PD4nZwEf+5FGm82h66fShjTYnAKmzN
         Ue4R/WAcsZQpEQhlkcAJIoTP4R5sxgsaM0PXTykxb3wtIP7Ws7fOiNjeMGDg4bQeOgXA
         dY/ZBg9QHMhxBQCL+iFw3EQPdPRBjSyscQowLSBCj34pUC44RYkclU0SYfkuu6bd/A2O
         gO1RMwj2de2UgHxKosWzgmlltOc6C2Cch6izF02QkJqDsd5cxA4ndBA4ehkIqaOSN3tK
         pZGQ==
X-Gm-Message-State: AGi0PuZPPVWAC4eTA+OhGDUzzqo0jZitflHKqed/gAyWDvcd37G8mtzY
        vjSFX08BJpDRC9k4XqenaR3QmUTaS8A=
X-Google-Smtp-Source: APiQypKAKQqiN7nOPlknhhLmlotoiqGDMSO+cxJNTjWQIKu/HVx9tSGzMX8p136mjR/MCTlHfZAm0g==
X-Received: by 2002:a62:6dc3:: with SMTP id i186mr27485784pfc.273.1588071196202;
        Tue, 28 Apr 2020 03:53:16 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e11sm12513436pfl.85.2020.04.28.03.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 03:53:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        Carlo Marcelo Arenas Belon <carenas@gmail.com>
Subject: [PATCH v4 3/4] git-credential-store: fix (WIP)
Date:   Tue, 28 Apr 2020 03:52:53 -0700
Message-Id: <20200428105254.28658-3-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200428105254.28658-1-carenas@gmail.com>
References: <20200428104858.28573-1-carenas@gmail.com>
 <20200428105254.28658-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Helped-by: Carlo Marcelo Arenas Belon <carenas@gmail.com>
---
 credential-store.c          | 4 ++--
 t/t0302-credential-store.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index c010497cb2..294e771681 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
+		if (!credential_from_url_gently(&entry, line.buf, 1) &&
+		    entry.username && entry.password &&
 		    credential_match(c, &entry)) {
 			found_credential = 1;
 			if (match_cb) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 94cdcb9e56..4e5a73cb99 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,7 +120,7 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
-test_expect_failure 'get: store file can contain empty/bogus lines' '
+test_expect_success 'get: store file can contain empty/bogus lines' '
 	test_write_lines "#comment" " " "" \
 		 https://user:pass@example.com >"$HOME/.git-credentials" &&
 	check fill store <<-\EOF
-- 
2.26.2.569.g1d74ac4d14

