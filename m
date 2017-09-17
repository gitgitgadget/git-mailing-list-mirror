Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A3F2047F
	for <e@80x24.org>; Sun, 17 Sep 2017 22:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbdIQW2X (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:28:23 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37850 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdIQW2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:28:22 -0400
Received: by mail-io0-f196.google.com with SMTP id 93so7463313iol.4
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QHshYaU/s8AhDg24iCbpQ9nXAkKQbkruQnJ9SuiqSso=;
        b=Hj5YmAfbVJ4OEkqFie8CFt2tbRxJhr80XyNCn9DtvZ7c4Gm8zH4yvgYnpYDFqGPnCJ
         A8gNKAhQheR5Mh7lTtL1XQOLHMkfDYyoY1u8U8RW1JwIcSLpiK6mG22t5sJcVGvwxuJh
         AsEXiC9cYclkmxl/E0aTv2CBhZ9xEUoWb7iqb+Nei5N20kmbRQww5lpDfkCYeLk9I+9/
         o68ZqCIaluW+py4nMXkXM6uH7yId6An/sIkZQD9objFdztDHe4PWZC8tegVd1F1vIs49
         Ngnk5diPE33yj04nRp1Q09oUIl55tqlsr2IBMY06giZSwnRcBrQgEGtMOEsjsKTC7ORM
         fGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QHshYaU/s8AhDg24iCbpQ9nXAkKQbkruQnJ9SuiqSso=;
        b=Hqf/Lc5FqtqaFbOqNM94g837vHMD+2F69I2ODCFMKtMV/co166PU46koOj4lZi4MhO
         EtTIdhKi+M3H5/qsZn7b9/GPFo8c+zKSzavl03Rbnxs9I4jjTDw5sJtG/MQHHxaXMQ6z
         1U266H8ZDHn2FrmkRP9I8Amr+g18+6Srlk5n+YfDYfhRxnbRL8OoJwD7jL1Bb8SVEXVV
         tnh4GsYRRxbQsvyy8tsBkytxbidy+vBHMCSZwlwKH582/MUyTxVuaYCZPNv4W0e/OnhV
         ibWDkFLQr7XZBVf9vjTUHsIswATkh4PKYqjgdR2W9DL6u8ah0imfKNk++8L1lO9YXrk5
         3sAQ==
X-Gm-Message-State: AHPjjUi35Mcm7uw9TPhn3VbCJHna01rh5ukGaxG9eCFm/Gcw511Onabz
        tco55iPvn09HKc7mlhY=
X-Google-Smtp-Source: AOwi7QBFt72DFBRA8CxWUk+rxZRfeKkgwhoACWfQfI/zNefRMhSoBr3clHrKNrXYexK7yH3b8GMbNg==
X-Received: by 10.202.74.143 with SMTP id x137mr32029988oia.236.1505687300932;
        Sun, 17 Sep 2017 15:28:20 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id d74sm6324438oib.30.2017.09.17.15.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2017 15:28:19 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     ilya.bobyr@gmail.com, Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/4] t1502: demonstrate rev-parse --parseopt option mis-parsing
Date:   Sun, 17 Sep 2017 15:28:14 -0700
Message-Id: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 2d893df rev-parse will scan forward from the beginning of
the option string looking for a flag character.  If there are no flag
characters then the scan will spill over into the help text and will
interpret the characters preceding the "flag" as part of the option-spec
i.e. the long option name.

For example, the following option spec:

    exclame this does something!

will produce this 'set' expression when --exclame is specified:

    set -- --exclame this does something --

which will be interpreted as four separate parameters by the shell.  And
will produce a help string that looks like:

    --exclame this does something
                          this does something!

git-rebase.sh has such an option (--autosquash), and so will add extra
parameters to the 'set' expression when --autosquash is used.
git-rebase continues to work correctly though because when it parses the
arguments, it ignores ones that it does not recognize.

Also, rev-parse --parseopt does not currently interpret a tab character
as a delimiter between the option spec and the help text.  If a tab is
used at the end of the option spec, before the help text, and before a
space has been specified, then rev-parse will interpret the tab as part
of the preceding component (either the long name or the arg hint).

For example, the following option spec (note: there is a <tab> between
"frotz" and "enable"):

    frotz	enable frotzing

will produce this 'set' expression when --frotz is specified:

    set -- --frotz  enable --

which will be interpreted as 2 separate arguments by the shell.

git-rebase.sh has one of these too (--keep-empty).  In this case the tab
is immediately followed by spaces so there are no additional parameters
produced on the command line.  The only side-effect is misalignment in
the help text.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t1502-rev-parse-parseopt.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 310f93f..910fc56 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -28,6 +28,9 @@ test_expect_success 'setup optionspec' '
 |g,fluf?path     short and long option optional argument
 |longest=very-long-argument-hint  a very long argument hint
 |pair=key=value  with an equals sign in the hint
+|aswitch help te=t contains? fl*g characters!`
+|bswitch=hint	 hint has trailing tab character
+|cswitch	 switch has trailing tab character
 |short-hint=a    with a one symbol hint
 |
 |Extras
@@ -35,7 +38,7 @@ test_expect_success 'setup optionspec' '
 EOF
 '
 
-test_expect_success 'test --parseopt help output' '
+test_expect_failure 'test --parseopt help output' '
 	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |cat <<\EOF
 |usage: some-command [options] <args>...
@@ -62,6 +65,9 @@ test_expect_success 'test --parseopt help output' '
 |    --longest <very-long-argument-hint>
 |                          a very long argument hint
 |    --pair <key=value>    with an equals sign in the hint
+|    --aswitch             help te=t contains? fl*g characters!`
+|    --bswitch <hint>      hint has trailing tab character
+|    --cswitch             switch has trailing tab character
 |    --short-hint <a>      with a one symbol hint
 |
 |Extras
@@ -75,17 +81,17 @@ END_EXPECT
 
 test_expect_success 'setup expect.1' "
 	cat > expect <<EOF
-set -- --foo --bar 'ham' -b -- 'arg'
+set -- --foo --bar 'ham' -b --aswitch -- 'arg'
 EOF
 "
 
-test_expect_success 'test --parseopt' '
-	git rev-parse --parseopt -- --foo --bar=ham --baz arg < optionspec > output &&
+test_expect_failure 'test --parseopt' '
+	git rev-parse --parseopt -- --foo --bar=ham --baz --aswitch arg < optionspec > output &&
 	test_cmp expect output
 '
 
-test_expect_success 'test --parseopt with mixed options and arguments' '
-	git rev-parse --parseopt -- --foo arg --bar=ham --baz < optionspec > output &&
+test_expect_failure 'test --parseopt with mixed options and arguments' '
+	git rev-parse --parseopt -- --foo arg --bar=ham --baz --aswitch < optionspec > output &&
 	test_cmp expect output
 '
 
-- 
2.2.0.rc3

