Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ECEA1F404
	for <e@80x24.org>; Fri, 12 Jan 2018 10:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbeALKhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 05:37:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37248 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeALKhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 05:37:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id f140so10810152wmd.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 02:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bB4YTmHIxFTAMpCrsJkFaQlg9cw8QkiJGrenf+pyhKY=;
        b=RNBoV8XGVRFn4JOjKLw62TrGo3Yq6w6Xkfkn5n2MMVbB8kyR3de25lp1kUF4srw/u7
         CnvvrbE51C9sAMMWLCLLhJ0xWrHxldkNoaVje9V+RcwX71V9tIfmpA8UeSusHEQuGIaK
         crTX4gPT6tSnQOmYwgpFYjuGtEvAYvOCQ9YXh1dkEdgHgT1KNxhV5u/HxRSz7Aqpw8nM
         7SHdBbAOacn2YJ1uxRbDsrB0oxYzFx8JJrykE6RJSMnQqSsNqb9hbZT5lHs3VW/hcLZb
         IggqQPP/Rn9mRY+Jk31CnI6D5OxWH3Kx3Oj4VRafhBnGGoW8ZjukAPkLh8DcpybY7+AZ
         sjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bB4YTmHIxFTAMpCrsJkFaQlg9cw8QkiJGrenf+pyhKY=;
        b=HFNhl1McCg82v+H5Y9SfD53HiKSuHps1mFtKie5RileNgOHuo82svtpPd9ejBVQNaW
         Tx5IasibH2rfDgZNW/KPg+ydIngHHkVtaATqOPYyiXGa1tp2L1LX8B7phRJnUIc/0qyk
         c/u07FP+iLsFvco9akJqaaHLOlI4OcIKPNTz9ZltXRvZU13Nw6kXMWGNBP3xFfg7Oo63
         Bq377nXP7ojOgkU+nVm0W4InKQOmfyaIKEzQYFWz6N8aUCJetY955rD7Gvbe8en8sePO
         FZtw53xSxFPaFXpmmipIk0IOimwBiU8VoCv3eDvMgSYp315T1pz3M0bVQlmZXrABtzA6
         pLRA==
X-Gm-Message-State: AKwxytfDsOiuldUdjkWj38fFkpyMNlUQkHaw8UE1zMjc3OmqtBI+iCCy
        kAOrCcMgOEr7xj+cSyDKI97iHSEZ
X-Google-Smtp-Source: ACJfBotPStcxAj/clisxHAJ2U7JArNEUpu1K27/rw0Mhevw9IH9bJIcK4b0Buiy/t/Wc+TN4OltVqA==
X-Received: by 10.28.144.7 with SMTP id s7mr3869341wmd.89.1515753451002;
        Fri, 12 Jan 2018 02:37:31 -0800 (PST)
Received: from greyhound ([195.145.21.250])
        by smtp.gmail.com with ESMTPSA id p29sm2253991wmf.20.2018.01.12.02.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 02:37:30 -0800 (PST)
From:   Christian Ludwig <chrissicool@googlemail.com>
X-Google-Original-From: Christian Ludwig <chrissicool@gmail.com>
Received: from cc by greyhound with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1eZwiH-00072J-96; Fri, 12 Jan 2018 11:37:29 +0100
To:     git@vger.kernel.org
Cc:     Christian Ludwig <chrissicool@gmail.com>
Subject: [PATCH] tests: Deduplicate code in send-email test
Date:   Fri, 12 Jan 2018 11:37:24 +0100
Message-Id: <20180112103724.27002-1-chrissicool@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the wrapper function around the sed statement like everywhere else
in the test. Unfortunately the wrapper function is defined pretty late.

Move the wrapper to the top of the test file, so future users have it
available right away.

Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
---
 t/t9001-send-email.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4d261c2a9..81869d891 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -6,6 +6,12 @@ test_description='git send-email'
 # May be altered later in the test
 PREREQ="PERL"
 
+replace_variable_fields () {
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/"
+}
+
 test_expect_success $PREREQ 'prepare reference tree' '
 	echo "1A quick brown fox jumps over the" >file &&
 	echo "lazy dog" >>file &&
@@ -296,10 +302,7 @@ test_expect_success $PREREQ 'Show all headers' '
 		--bcc=bcc@example.com \
 		--in-reply-to="<unique-message-id@example.com>" \
 		--smtp-server relay.example.com \
-		$patches |
-	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
-		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		$patches | replace_variable_fields \
 		>actual-show-all-headers &&
 	test_cmp expected-show-all-headers actual-show-all-headers
 '
@@ -554,12 +557,6 @@ Result: OK
 EOF
 "
 
-replace_variable_fields () {
-	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
-		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/"
-}
-
 test_suppression () {
 	git send-email \
 		--dry-run \
-- 
2.15.1

