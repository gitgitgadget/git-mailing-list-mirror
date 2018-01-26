Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418A51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeAZMhj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:39 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:37113 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeAZMhb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:31 -0500
Received: by mail-wr0-f177.google.com with SMTP id f11so411098wre.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2F/fQmFzr7vwqHsfWN3aPIMLzH8dZ+yIf+MphB9r//8=;
        b=NbefDOTF5y4v6WFec1i1Bedq/zCe3cz7hfQoMo+7mfZEd/X0BUQ9BJ4Y7Ggt65qp4Y
         Qf30iXKW+zMwyP7qOoYMduNEb2tCdOuDpyP+SwGQ7v6hNBQnoBsEg/HF89aS5twACyfT
         Pm21DLjNLhvbWFe6Uy+8fmag/JgreGtja3EOzwteBbHtrP+noDR+Qba3tSWcl8HwER+0
         a86KzAJA6TjcqelEO5kdrBPrmeOAXDin0EWuGiKV/kibK0JuxSeHsIAf8pf4B/TBy8FD
         7T0L5Hbp7L4roPDS5r09Xj28yAj98Pi2wUBZAceIZmOv7Wl9sqgRk4r1L30RoIaPBlL/
         BtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2F/fQmFzr7vwqHsfWN3aPIMLzH8dZ+yIf+MphB9r//8=;
        b=kar+xY/qwTCpJWlDA7OqzrN6cdaj+amcQzHxDo04KhoJnbqCaeoXZgiT0p9dUjQ5J8
         pU5xy6s6z1/t9Gjp8A6Pk7L0qCiMSlwmWHmw0zDQhkZvKlJkuMr5WPf7Ok+op5WbcgYg
         HLNmfPcx1jwySn+mBjfjUGSUIF44XLHTPpUtxPat37SkqO2Hm92qUyWdYmHEfc9unaDm
         hAnwsP8X/5Rp4FqqPrkm43AvvZrk2LzS6kLECGa2WhjKOeESut4mIrd/psOp2pNVxvdy
         ckxf+tnODH53JIlBvxMSZtU66xzt8mnfadgHIiAMmC0dBblByiD9WhKCAxL1r1I8gf7D
         aoIQ==
X-Gm-Message-State: AKwxyteTris3Ka1n//osiaZp7YQETGJOwRnGSejcErFRCgSUU1v0WBt2
        GWovhODLy8nhrUieRNE0tnr3EQ==
X-Google-Smtp-Source: AH8x226cmUQgo5bBUhwenvc3G3MbRNk4HVnfxTCXUEWBKZ5RknOC12zP6QmH78+MbEuWO5eW3Ec4YA==
X-Received: by 10.223.139.76 with SMTP id v12mr11498043wra.95.1516970249703;
        Fri, 26 Jan 2018 04:37:29 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/10] t: make sure that 'test_i18ngrep' got enough parameters
Date:   Fri, 26 Jan 2018 13:37:07 +0100
Message-Id: <20180126123708.21722-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two of the previous patches in this series fixed two bogus
'test_i18ngrep' invocations that had neither a filename parameter not
anything piped into their standard input, yet both managed to remain
unnoticed for years.  A third similarly bogus invocation is currently
lurking in 'pu' for a couple of weeks now.

Try to catch similar mistakes in the future by ensuring that
'test_i18ngrep' has at least two parameters, not including an optional
'!' to negate the pattern.  Perform these checks after we made sure
that there is no data on the 'test_i18ngrep's standard input, so if
the filename parameter is missing because someone is piping a git
command's output into this function, then they would get the more
relevant error message.

Note that this is not quite perfect, as it doesn't account for any
'grep --options' given as parameters.  However, doing so would be far
too complicated, considering that patters can start with dashes as
well, and in the majority of the cases we don't use any such options
anyway.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

About that third one in 'pu': it's test '3b-check: Avoid implicit
rename if involved as source on current side' introduced in commit
fcd649216 (directory rename detection: testcases to avoid taking
detection too far, 2018-01-05) in branch
'en/rename-directory-detection'.

  https://public-inbox.org/git/CAM0VKj=qhJQJ7uJWbBouSTYD0frA1zp1gwXzMVXuTiF+C6GH+g@mail.gmail.com/T/#u

 t/test-lib-functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e381d50d0..b543fd0e0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -723,6 +723,12 @@ test_i18ngrep () {
 	error "bug in the test script: data on test_i18ngrep's stdin;" \
 	      "perhaps a git command's output is piped into it?"
 
+	if test $# -lt 2 ||
+	   { test "x!" = "x$1" && test $# -lt 3 ; }
+	then
+		error "bug in the test script: too few parameters to test_i18ngrep"
+	fi
+
 	if test -n "$GETTEXT_POISON"
 	then
 	    : # pretend success
-- 
2.16.1.155.g5159265b1

