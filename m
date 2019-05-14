Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730321F461
	for <e@80x24.org>; Tue, 14 May 2019 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfENVLC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 17:11:02 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54623 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENVLB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 17:11:01 -0400
Received: by mail-pl1-f201.google.com with SMTP id 61so321173plr.21
        for <git@vger.kernel.org>; Tue, 14 May 2019 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uzdUejCGyE5iId1yrUQPOKFbOC1aKEuHXKtaammMnrI=;
        b=VE5a0N3N0T+7tVhu2ALUGjDrCsnvyAD6bnYvudM7PeZOvH5z6FKGESYe1vpF6UpVhZ
         FfhUzOZvhs/E1kecp3m3Y7KR2roB4tX7sX1BzBGHy5gHlwglBWIQoma2rbmpC/FY2uqD
         y4WXjUx+/VVlyIV2LAlVLXqsmfsITzFLIj3FxyvOGT1+jItbwr5zhf97mO/I32znx8az
         P8Ay50Ay0XMoAt2TDZDXWuQPzFM5LhOdqGu9iotujkhAogZhq2CdfFUUbC6c2OJlwnVe
         peAXco/NxuAGQUQW1GSc8RPW26QTJR8V3FZmRKgZ2hEK6K2h4jNXqnvC5LNJHKHUKOJS
         OmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uzdUejCGyE5iId1yrUQPOKFbOC1aKEuHXKtaammMnrI=;
        b=qe1KlItPamIC+B7p5sOc8tlz2+7iCBvCVfRL5o9fKK9sEZpM8hXNyM6ad7uzlK6ICT
         kA227CO7wEf/j3ynv55a2tghF+nZXNvl3hTkYSnVatZ/B6HPDUQd7BotCVxCt5FpZjNB
         IM8F+aym9aTL3nOfdSPVEwE0Oxqr/tOiMwQne06NIrVw4UwWiQFweqG/u1cC11XaoNsO
         4gQRgo/3nF+3ABlazMaTN7LbGt7M0J3xq1clSzw1BSdSASlyo+gr+0HRUaKbPEahYx7C
         L6s2Y9uICgT3qHh1OjcSaNxB7owtJMuwYixkLoxnEDGy+cGwdukhLX2/elkSLCwfgW+c
         smOQ==
X-Gm-Message-State: APjAAAX2gWgzBC+2tjUjnMNu0ghnKflh8ODleiGNYxqjeIN0MuyHPbse
        yJ9kxJqHbRA1Y/EaI6nDtspbhbpS8E984F9PvfkvnE0p4843jVQqoGYU23Jzw3r+4zdXLKlyQjD
        gKaPNj0s3tG8yLAzK5Wgkf7STrBMp9U27gA5QELl6UjllqWFaY8F1+gH2L1wrjXmDYHQ+jfvsIB
        3f
X-Google-Smtp-Source: APXvYqyuMMJG4zugvVPKKsO8nLzTchmVY3uxxKZCEravu0LHQ7zWuEB0gZNRusjPxOC0+fTlxwkYEfBq8/BB6I8KbbkR
X-Received: by 2002:a63:dc15:: with SMTP id s21mr1732503pgg.215.1557868260936;
 Tue, 14 May 2019 14:11:00 -0700 (PDT)
Date:   Tue, 14 May 2019 14:10:54 -0700
In-Reply-To: <cover.1557868134.git.jonathantanmy@google.com>
Message-Id: <991a3aa27dd7fe67adbed2e03502790932b5059c.1557868134.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1557868134.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 1/2] t5616: refactor packfile replacement
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will perform the same packfile replacement that is
already done twice, so refactor it into its own function. Also, the same
subsequent patch will use, in another way, part of the packfile
replacement functionality, so extract those out too.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5616-partial-clone.sh | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9a8f9886b3..7cc0c71556 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -244,11 +244,25 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-# Converts bytes into a form suitable for inclusion in a sed command. For
-# example, "printf 'ab\r\n' | hex_unpack" results in '\x61\x62\x0d\x0a'.
-sed_escape () {
-	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)' |
-		sed 's/\(..\)/\\x\1/g'
+# Converts bytes into their hexadecimal representation. For example,
+# "printf 'ab\r\n' | hex_unpack" results in '61620d0a'.
+hex_unpack () {
+	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)'
+}
+
+# Inserts $1 at the start of the string and every 2 characters thereafter.
+intersperse () {
+	sed 's/\(..\)/'$1'\1/g'
+}
+
+# Create a one-time-sed command to replace the existing packfile with $1.
+replace_packfile () {
+	# The protocol requires that the packfile be sent in sideband 1, hence
+	# the extra \x01 byte at the beginning.
+	printf "1,/packfile/!c %04x\\\\x01%s0000" \
+		"$(($(wc -c <$1) + 5))" \
+		"$(hex_unpack <$1 | intersperse '\\x')" \
+		>"$HTTPD_ROOT_PATH/one-time-sed"
 }
 
 test_expect_success 'upon cloning, check that all refs point to objects' '
@@ -270,10 +284,7 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 	# Replace the existing packfile with the crafted one. The protocol
 	# requires that the packfile be sent in sideband 1, hence the extra
 	# \x01 byte at the beginning.
-	printf "1,/packfile/!c %04x\\\\x01%s0000" \
-		"$(($(wc -c <incomplete.pack) + 5))" \
-		"$(sed_escape <incomplete.pack)" \
-		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+	replace_packfile incomplete.pack &&
 
 	# Use protocol v2 because the sed command looks for the "packfile"
 	# section header.
@@ -313,10 +324,7 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	# Replace the existing packfile with the crafted one. The protocol
 	# requires that the packfile be sent in sideband 1, hence the extra
 	# \x01 byte at the beginning.
-	printf "1,/packfile/!c %04x\\\\x01%s0000" \
-		"$(($(wc -c <incomplete.pack) + 5))" \
-		"$(sed_escape <incomplete.pack)" \
-		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+	replace_packfile incomplete.pack &&
 
 	# Use protocol v2 because the sed command looks for the "packfile"
 	# section header.
-- 
2.21.0.1020.gf2820cf01a-goog

