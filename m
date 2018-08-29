Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E591F404
	for <e@80x24.org>; Wed, 29 Aug 2018 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeH2NmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 09:42:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50288 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2NmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 09:42:14 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so6793733ite.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHX+9AEaIggl56+VuoJk4RXFF1mYHI1days1yw4Po44=;
        b=Yg3kJOXGhqlri4DesQ9IfQwSjK3H67LUYWUF/ZhinxaV/I+JrFeUEvu3uxdUhztOtF
         lGBqfnPUHMeUPOpIgKMraGNNwnORaTfbMnZyYogAwp6pWXYJBHjMgKtbZ+U5QGP9J4TQ
         0LUXt1+t/Uw5be+e21bVR8avEUu0e22GeqEfcc49G0eJXj6YI4PlC5DnuxgAm+F/gpzw
         XeTCT74j6KFE6QfLdpp2DFO6Z4y59akbLjsPL4H02WVzUTH34P+nlw7ER4Bhvmdhdf6s
         iJcIPOMcS3ojqNqlHzT8nPpYKkngD1etFCi4sW+uRSRuKkTaAFIquTort8A1XJJAmQtB
         xDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AHX+9AEaIggl56+VuoJk4RXFF1mYHI1days1yw4Po44=;
        b=m4LXQ5sJtWxix5ecSxfhsw5RPTkbd3TDnXXqrXgkWTp7fPxk4hguK+Pv3tYa4/TJ6C
         oPJWsxssH/53sxEnfzhvZde58Brgq138wZFUmk8uvo1UORk5htTYmQavR6qnmIPdV3lL
         azFeI10iQmaErZEpXPf8+5vIXoyHLQGaCTsSB7h6GVpiGGSwPsKCL1Fd3QmnAbrb2cXA
         b4XxnsDmoSOQhjNHZHbangCg0oGbULSe2PHiPBZK704g7L8ZxROs3S2NeaMa4LjcL1DW
         shi6915+FiZz1a2Hq5nbXIrj8e3Pxb4W3xTICZWT8c9pE+aEyR/qnkMQo+vKzA8fRsJZ
         gs5w==
X-Gm-Message-State: APzg51D4Ra2j8fZ6eHO61nEgg0zGDf7Sb53FKpU+pExloAvKaFccwTUs
        lpX0oKezvSOWkRiAwbZaRcOqJ5SL
X-Google-Smtp-Source: ANB0VdbUj3o0bWHg0iRAasf1Ik3cC4xocKqUcy7GrQUDRKepeagD7NYMubGmWbyTXzgYc/dxidLtgg==
X-Received: by 2002:a24:b21c:: with SMTP id u28-v6mr4695770ite.127.1535535969114;
        Wed, 29 Aug 2018 02:46:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 7-v6sm1668847iou.36.2018.08.29.02.46.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:46:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] chainlint: match "quoted" here-doc tags
Date:   Wed, 29 Aug 2018 05:45:32 -0400
Message-Id: <20180829094532.41497-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.352.gb1634b371d
In-Reply-To: <20180815184552.8418-1-sunshine@sunshineco.com>
References: <20180815184552.8418-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A here-doc tag can be quoted ('EOF'/"EOF") or escaped (\EOF) to suppress
interpolation within the body. chainlint recognizes single-quoted and
escaped tags, but does not know about double-quoted tags. For
completeness, teach it to recognize double-quoted tags, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is an extract from v3 of es/chain-lint-more[1] which never got
picked up. Instead, v2 of that series[2] got merged to 'next' and later
'master'. The only change between v2 and v3 was to make 'chainlint' also
recognize double-quoted here-doc tags. This solo patch makes that change
incrementally atop v2.

This is built on 'master'. With the default "recursive" strategy, it
merges cleanly with Ævar's ab/portable[3] changes to 'chainlint' for AIX
compatibility, currently in 'next'.

[1]: https://public-inbox.org/git/20180815184552.8418-1-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/20180813084739.16134-1-sunshine@sunshineco.com/
[3]: https://public-inbox.org/git/20180824152016.20286-1-avarab@gmail.com/

 t/chainlint.sed                      | 8 ++++----
 t/chainlint/here-doc.expect          | 2 ++
 t/chainlint/here-doc.test            | 7 +++++++
 t/chainlint/subshell-here-doc.expect | 1 +
 t/chainlint/subshell-here-doc.test   | 4 ++++
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 8544df38df..1da58b554b 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -94,8 +94,8 @@
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
-/<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
-	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
+/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/ {
+	s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 	s/[ 	]*<<//
 	:hereslurp
 	N
@@ -159,7 +159,7 @@ s/.*\n//
 }
 :folded
 # here-doc -- swallow it
-/<<[ 	]*[-\\']*[A-Za-z0-9_]/bheredoc
+/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
@@ -281,7 +281,7 @@ bfolded
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
 :heredoc
-s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
+s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 s/[ 	]*<<//
 :hereslurpsub
 N
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index aff6568716..534b065e38 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -4,4 +4,6 @@ cat >foo &&
 
 cat >bar &&
 
+cat >boo &&
+
 horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index f2bb14b693..ad4ce8afd9 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -21,6 +21,13 @@ boz
 woz
 FUMP
 
+# LINT: swallow "quoted" here-doc
+cat <<"zump" >boo &&
+snoz
+boz
+woz
+zump
+
 # LINT: swallow here-doc (EOF is last line of test)
 horticulture <<\EOF
 gomez
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 7663ea7fc4..74723e7340 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -6,5 +6,6 @@
 (
 	cat >bup &&
 	cat >bup2 &&
+	cat >bup3 &&
 	meep
 >)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index b6b5a9b33a..f6b3ba4214 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -31,5 +31,9 @@
 	glink
 	FIZZ
 	ARBITRARY2
+	cat <<-"ARBITRARY3" >bup3 &&
+	glink
+	FIZZ
+	ARBITRARY3
 	meep
 )
-- 
2.19.0.rc1.352.gb1634b371d

