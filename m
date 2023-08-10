Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086F3C41513
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHJVSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjHJVSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E02737
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so12641735e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702293; x=1692307093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaQKnhilHgzeldzskwOlhP2/oK6pbLd0hrP+iKwL+fk=;
        b=scmTNr6nNoWXM5mf5drP9vg1cCl1F2ID2egWfPtu2Fc8IVh9ncB01N54p088PXM607
         ZWwFtPaaw+rewCfkg1dkPF1gBlr3oOGCvBQHDD6L9QuySyqrJ17ovaGUkCNM+LkIOEdr
         vlGzTdAlrDsFxbbSoLh2RxRRqgAyGQ/f2y0Iq1cxqI5uWSIIWgMdEkn9H8k+nwunyeKn
         Q/LmZiryA4eEZYaEH1uZfObIKUqcq2Gcf1CeXPYBrU8JgOyD3sMKAJ7alggI/3NIJghi
         fmsD0ScIGQmpqpXXZXa+pZXZ6HiZnxU3osTpA8Ey5EYzn3MpL2dC2Ym37sq7LtvzyKMb
         2bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702293; x=1692307093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaQKnhilHgzeldzskwOlhP2/oK6pbLd0hrP+iKwL+fk=;
        b=g8x/2dfBkMPUwuIKtyY8vvNRmH8LmpgIK/0/2VRWbE0oyg28oR9rvKc88oUp3aX4SC
         EHjx6tq3EjdCUYLcMFFVe7IP3sKldgwsWWlv7WwuEOgkkd2zOg7udjcXd7Wfe0Cn2Fga
         Gsd1ZUdl63ejDrQPBiPGKD/QGskfO4k5EaIm97nfCIA77zWeB42q0WLBuErpWZXtO+CG
         A2JIdS5YL5oZ2g7VvjHBCBR2HlKF6mPI91GjSDiDmKvs2t5ARtCY5FqdfN/Cah7KMUdb
         l4J8cIKt2m6PnzByN4hbIUeQj03P8kSYOKyKo/ho4TqHUA+HbXtTqcaRm31cQXm0yW5s
         V7uA==
X-Gm-Message-State: AOJu0YxRLA2LeoO2UStUQMGOoN2XFvwQ4JSguaoGeTwHUyFapx+WQSM8
        XdbYCEO/YzCWXzv+1+v0OXSGtI+CkVs=
X-Google-Smtp-Source: AGHT+IH2JrgGkEBQvKOr8w6AaWxRkCZBhFCvyXfEtGNTtHC5HFsNX+Hnn233JiNRmyiYuaYKEYoMDg==
X-Received: by 2002:a05:600c:234b:b0:3fc:521:8492 with SMTP id 11-20020a05600c234b00b003fc05218492mr64319wmq.5.1691702292383;
        Thu, 10 Aug 2023 14:18:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1-20020a05600c214100b003fe215e4492sm3221888wml.4.2023.08.10.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:12 -0700 (PDT)
Message-ID: <7b66cf29d295ae2420c9f5d1469e1f02d490e559.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:18:03 +0000
Subject: [PATCH v2 13/13] trailer doc: <token> is a <key> or <keyAlias>, not
 both
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The `--trailer` option takes a "<token>=<value>" argument, for example

    --trailer "Acked-by=Bob"

And in this exampple it is understood that "Acked-by" is the <token>.
However, the user can use a shorter "ack" string by defining
configuration like

    git config trailer.ack.key "Acked-by"

However, in the docs we define the above configuration as

    trailer.<token>.key

so the <token> can mean either the longer "Acked-by" or the shorter
"ack".

Separate the two meanings of <token> into <key> and <keyAlias>, and
update the configuration syntax to say "trailer.<keyAlias>.key".

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 136 +++++++++++++----------
 1 file changed, 76 insertions(+), 60 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 25433e1a1ff..418265f044d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git interpret-trailers' [--in-place] [--trim-empty]
-			[(--trailer <token>[(=|:)<value>])...]
+			[(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]
 			[--parse] [<file>...]
 
 DESCRIPTION
@@ -53,22 +53,32 @@ are applied to each input and the way any existing trailer in
 the input is changed. They also make it possible to
 automatically add some trailers.
 
-By default, a '<token>=<value>' or '<token>:<value>' argument given
+By default, a '<key>=<value>' or '<key>:<value>' argument given
 using `--trailer` will be appended after the existing trailers only if
-the last trailer has a different (<token>, <value>) pair (or if there
-is no existing trailer). The <token> and <value> parts will be trimmed
+the last trailer has a different (<key>, <value>) pair (or if there
+is no existing trailer). The <key> and <value> parts will be trimmed
 to remove starting and trailing whitespace, and the resulting trimmed
-<token> and <value> will appear in the output like this:
+<key> and <value> will appear in the output like this:
 
 ------------------------------------------------
-token: value
+key: value
 ------------------------------------------------
 
-This means that the trimmed <token> and <value> will be separated by
-`': '` (one colon followed by one space). For convenience, the <token> can be a
-shortened string key (e.g., "sign") instead of the full string which should
-appear before the separator on the output (e.g., "Signed-off-by"). This can be
-configured using the 'trailer.<token>.key' configuration variable.
+This means that the trimmed <key> and <value> will be separated by
+`': '` (one colon followed by one space).
+
+For convenience, a <keyAlias> can be configured to make using `--trailer`
+shorter to type on the command line. This can be configured using the
+'trailer.<keyAlias>.key' configuration variable. The <keyAlias> must be a prefix
+of the full <key> string, although case sensitivity does not matter. For
+example, if you have
+
+------------------------------------------------
+trailer.sign.key "Signed-off-by: "
+------------------------------------------------
+
+in your configuration, you only need to specify `--trailer="sign: foo"`
+on the command line instead of `--trailer="Signed-off-by: foo"`.
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
@@ -85,14 +95,14 @@ non-whitespace lines before a line that starts with '---' (followed by a
 space or the end of the line).
 
 When reading trailers, there can be no whitespace before or inside the
-<token>, but any number of regular space and tab characters are allowed
-between the <token> and the separator. There can be whitespaces before,
+<key>, but any number of regular space and tab characters are allowed
+between the <key> and the separator. There can be whitespaces before,
 inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822. Example:
 
 ------------------------------------------------
-token: This is a very long value, with spaces and
+key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
@@ -109,8 +119,8 @@ OPTIONS
 	the whole trailer will be removed from the output.
 	This applies to existing trailers as well as new trailers.
 
---trailer <token>[(=|:)<value>]::
-	Specify a (<token>, <value>) pair that should be applied as a
+--trailer <key>[(=|:)<value>]::
+	Specify a (<key>, <value>) pair that should be applied as a
 	trailer to the inputs. See the description of this
 	command.
 
@@ -118,7 +128,7 @@ OPTIONS
 --no-where::
 	Specify where all new trailers will be added.  A setting
 	provided with '--where' overrides the `trailer.where` and any
-	applicable `trailer.<token>.where` configuration variables
+	applicable `trailer.<keyAlias>.where` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--where' or '--no-where'. Upon encountering '--no-where', clear the
 	effect of any previous use of '--where', such that the relevant configuration
@@ -128,9 +138,9 @@ OPTIONS
 --if-exists <action>::
 --no-if-exists::
 	Specify what action will be performed when there is already at
-	least one trailer with the same <token> in the input.  A setting
+	least one trailer with the same <key> in the input.  A setting
 	provided with '--if-exists' overrides the `trailer.ifExists` and any
-	applicable `trailer.<token>.ifExists` configuration variables
+	applicable `trailer.<keyAlias>.ifExists` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists, clear the
 	effect of any previous use of '--if-exists, such that the relevant configuration
@@ -140,9 +150,9 @@ OPTIONS
 --if-missing <action>::
 --no-if-missing::
 	Specify what action will be performed when there is no other
-	trailer with the same <token> in the input.  A setting
+	trailer with the same <key> in the input.  A setting
 	provided with '--if-missing' overrides the `trailer.ifMissing` and any
-	applicable `trailer.<token>.ifMissing` configuration variables
+	applicable `trailer.<keyAlias>.ifMissing` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing,
 	clear the effect of any previous use of '--if-missing, such that the relevant
@@ -187,11 +197,11 @@ used when another separator is not specified in the config for this
 trailer.
 +
 For example, if the value for this option is "%=$", then only lines
-using the format '<token><sep><value>' with <sep> containing '%', '='
+using the format '<key><sep><value>' with <sep> containing '%', '='
 or '$' and then spaces will be considered trailers. And '%' will be
 the default separator used, so by default trailers will appear like:
-'<token>% <value>' (one percent sign and one space will appear between
-the token and the value).
+'<key>% <value>' (one percent sign and one space will appear between
+the key and the value).
 
 trailer.where::
 	This option tells where a new trailer will be added.
@@ -205,41 +215,41 @@ If it is `start`, then each new trailer will appear at the start,
 instead of the end, of the existing trailers.
 +
 If it is `after`, then each new trailer will appear just after the
-last trailer with the same <token>.
+last trailer with the same <key>.
 +
 If it is `before`, then each new trailer will appear just before the
-first trailer with the same <token>.
+first trailer with the same <key>.
 
 trailer.ifexists::
 	This option makes it possible to choose what action will be
 	performed when there is already at least one trailer with the
-	same <token> in the input.
+	same <key> in the input.
 +
 The valid values for this option are: `addIfDifferentNeighbor` (this
 is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
 +
 With `addIfDifferentNeighbor`, a new trailer will be added only if no
-trailer with the same (<token>, <value>) pair is above or below the line
+trailer with the same (<key>, <value>) pair is above or below the line
 where the new trailer will be added.
 +
 With `addIfDifferent`, a new trailer will be added only if no trailer
-with the same (<token>, <value>) pair is already in the input.
+with the same (<key>, <value>) pair is already in the input.
 +
 With `add`, a new trailer will be added, even if some trailers with
-the same (<token>, <value>) pair are already in the input.
+the same (<key>, <value>) pair are already in the input.
 +
-With `replace`, an existing trailer with the same <token> will be
+With `replace`, an existing trailer with the same <key> will be
 deleted and the new trailer will be added. The deleted trailer will be
-the closest one (with the same <token>) to the place where the new one
+the closest one (with the same <key>) to the place where the new one
 will be added.
 +
 With `doNothing`, nothing will be done; that is no new trailer will be
-added if there is already one with the same <token> in the input.
+added if there is already one with the same <key> in the input.
 
 trailer.ifmissing::
 	This option makes it possible to choose what action will be
 	performed when there is not yet any trailer with the same
-	<token> in the input.
+	<key> in the input.
 +
 The valid values for this option are: `add` (this is the default) and
 `doNothing`.
@@ -248,34 +258,40 @@ With `add`, a new trailer will be added.
 +
 With `doNothing`, nothing will be done.
 
-trailer.<token>.key::
-	This `key` will be used instead of <token> in the trailer. At
-	the end of this key, a separator can appear and then some
-	space characters. By default the only valid separator is ':',
-	but this can be changed using the `trailer.separators` config
-	variable.
+trailer.<keyAlias>.key::
+	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
+	prefix (case does not matter) of the <key>. For example, in `git
+	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
+	the "ack" is the <keyAlias>. This configuration allows the shorter
+	`--trailer "ack:..."` invocation on the command line using the "ack"
+	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
++
+At the end of the <key>, a separator can appear and then some
+space characters. By default the only valid separator is ':',
+but this can be changed using the `trailer.separators` config
+variable.
 +
 If there is a separator in the key, then it overrides the default
 separator when adding the trailer.
 
-trailer.<token>.where::
+trailer.<keyAlias>.where::
 	This option takes the same values as the 'trailer.where'
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <token>.
+	that option for trailers with the specified <keyAlias>.
 
-trailer.<token>.ifexists::
+trailer.<keyAlias>.ifexists::
 	This option takes the same values as the 'trailer.ifexists'
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <token>.
+	that option for trailers with the specified <keyAlias>.
 
-trailer.<token>.ifmissing::
+trailer.<keyAlias>.ifmissing::
 	This option takes the same values as the 'trailer.ifmissing'
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <token>.
+	that option for trailers with the specified <keyAlias>.
 
-trailer.<token>.command::
-	Deprecated in favor of 'trailer.<token>.cmd'.
-	This option behaves in the same way as 'trailer.<token>.cmd', except
+trailer.<keyAlias>.command::
+	Deprecated in favor of 'trailer.<keyAlias>.cmd'.
+	This option behaves in the same way as 'trailer.<keyAlias>.cmd', except
 	that it doesn't pass anything as argument to the specified command.
 	Instead the first occurrence of substring $ARG is replaced by the
 	<value> that would be passed as argument.
@@ -283,29 +299,29 @@ trailer.<token>.command::
 Note that $ARG in the user's command is
 only replaced once and that the original way of replacing $ARG is not safe.
 +
-When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
-for the same <token>, 'trailer.<token>.cmd' is used and
-'trailer.<token>.command' is ignored.
+When both 'trailer.<keyAlias>.cmd' and 'trailer.<keyAlias>.command' are given
+for the same <keyAlias>, 'trailer.<keyAlias>.cmd' is used and
+'trailer.<keyAlias>.command' is ignored.
 
-trailer.<token>.cmd::
+trailer.<keyAlias>.cmd::
 	This option can be used to specify a shell command that will be called
-	once to automatically add a trailer with the specified <token>, and then
-	called each time a '--trailer <token>=<value>' argument is specified to
+	once to automatically add a trailer with the specified <keyAlias>, and then
+	called each time a '--trailer <keyAlias>=<value>' argument is specified to
 	modify the <value> of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
-with the specified <token>, the behavior is as if a special
-'--trailer <token>=<value>' argument was added at the beginning
+with the specified <keyAlias>, the behavior is as if a special
+'--trailer <keyAlias>=<value>' argument was added at the beginning
 of the "git interpret-trailers" command, where <value>
 is taken to be the standard output of the command with any
 leading and trailing whitespace trimmed off.
 +
-If some '--trailer <token>=<value>' arguments are also passed
+If some '--trailer <keyAlias>=<value>' arguments are also passed
 on the command line, the command is called again once for each
-of these arguments with the same <token>. And the <value> part
+of these arguments with the same <keyAlias>. And the <value> part
 of these arguments, if any, will be passed to the command as its
 first argument. This way the command can produce a <value> computed
-from the <value> passed in the '--trailer <token>=<value>' argument.
+from the <value> passed in the '--trailer <keyAlias>=<value>' argument.
 
 EXAMPLES
 --------
-- 
gitgitgadget
