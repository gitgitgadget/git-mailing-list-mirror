Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5EE1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeAZMhf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51291 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeAZMhb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id r71so1001023wmd.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8xygMV0IGlI8uTLEgexzNsp36b5BnRK8Fgrf7Zp9RI=;
        b=l6Vd8KmWuprR3um5h2Ey2xPlPEeXLFfx4RfDLF7L9bM04Aow4y49E5eobFWfWn8apX
         59YGJ0e/dLXG3Der0Q15m/9OAbxTcQLe5NYJMIR8Wh9JqjzDWNgE7p+vQM2dNZFUBbH8
         h5JrNTZbcCG7Axy35zrjdKLjTVdOESE/9a0gppCTvEM9SaC8TOqn6+t7DPpo+UugBybQ
         DAgI75AYsJSn2r0sIWxAWck2WLa8TS7OUxaikhGoOOpSLZEGr0LVe4iCM46lw5plquHi
         ErTXN3czqXkdvty8w2pLj0hZSzWEei/QcJy8eeSN80QWeU4xxWavm4663ODWob3kefiK
         U+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8xygMV0IGlI8uTLEgexzNsp36b5BnRK8Fgrf7Zp9RI=;
        b=Q9jpKuVC/Rh2a+Vzii8gQ95dlqWn4g1n966F8k5C8+AtVxTsceqmHkBNai4iOevblJ
         ENnCyIi5Bs5EmsM8gb+M44iclxbsYOEKjBhf/sK0Tymiagrz2qF2jQffMlwwSgHwFty7
         Pvd3EO86r9kLPLuX+4bBzpqFnL+Xt8fH/PGkXX/8uhCBbyA/tmaVVbOHG33PnCkrARJ0
         M3Moax0OISjleLDMOUgb9CHNPvwi4dUfGlFC4vhUKkDQsKMjAXomnd/u0Xi8io9MqkEk
         L+HDtjs9QK4IC+PKXe4muHkmdLGeQ31+4/5uL1Ejcjk4k5zoT6zbrQH2z1p2Cp41qrNh
         TV/Q==
X-Gm-Message-State: AKwxytc/KwRGGxhHI5/KNbgeCmym47RQJWcbdLBhBa8Tqn02zAlDFM7i
        r2ncDaXOmzG8HLXLWyIRBJ+Icg==
X-Google-Smtp-Source: AH8x225LNrnDdaYf2hinAPz07NndUZSyHOqEpsFhRpVnitkm5omwI10v8S0vEoScw8BXIGlqT0DnnQ==
X-Received: by 10.28.145.84 with SMTP id t81mr9417584wmd.25.1516970250636;
        Fri, 26 Jan 2018 04:37:30 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/10] t: make 'test_i18ngrep' more informative on failure
Date:   Fri, 26 Jan 2018 13:37:08 +0100
Message-Id: <20180126123708.21722-11-szeder.dev@gmail.com>
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

When 'test_i18ngrep' can't find the expected pattern, it exits
completely silently; when its negated form does find the pattern that
shouldn't be there, it prints the matching line(s) but otherwise exits
without any error message.  This leaves the developer puzzled about
what could have gone wrong.

Make 'test_i18ngrep' more informative on failure by printing an error
message including the invoked 'grep' command and the contents of the
file it had to scan through.

Note that this "dump the scanned file" part is not quite perfect, as
it dumps only the file specified as the function's last positional
parameter, thus assuming that there is only a single file parameter.
I think that's a reasonable assumption to make, one that holds true in
the current code base.  And even if someone were to scan multiple
files at once in the future, the worst thing that could happen is that
the verbose error message won't include the contents of all those
files, only the last one.  Alas, we can't really do any better than
this, because checking whether the other positional parameters match a
filename can result in false positives: 't3400-rebase.sh' and
't3404-rebase-interactive.sh' contain one test each, where the
'test_i18ngrep's pattern verbatimely matches a file in the trash
directory.  Note that the absence of a file parameter is not an issue,
because the lint check added in the previous commit ensures that
'test_i18ngrep' never reads from its standard input, consequently
there must be a file parameter.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b543fd0e0..1f1d89d7a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -731,14 +731,31 @@ test_i18ngrep () {
 
 	if test -n "$GETTEXT_POISON"
 	then
-	    : # pretend success
-	elif test "x!" = "x$1"
+		# pretend success
+		return 0
+	fi
+
+	if test "x!" = "x$1"
 	then
 		shift
-		! grep "$@"
+		! grep "$@" && return 0
+
+		echo >&2 "error: grep '! $@' did find a match in:"
 	else
-		grep "$@"
+		grep "$@" && return 0
+
+		echo >&2 "error: grep '$@' didn't find a match in:"
 	fi
+	(
+		eval "f=\"\${$#}\""
+		if test -s "$f"
+		then
+			cat >&2 "$f"
+		else
+			echo "<File '$f' is empty>"
+		fi
+	)
+	return 1
 }
 
 # Call any command "$@" but be more verbose about its
-- 
2.16.1.155.g5159265b1

