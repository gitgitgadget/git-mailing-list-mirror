Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3093C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjFFCIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFFCIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD811A
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f623adec61so56904165e9.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017307; x=1688609307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsp3S46+y10MzDMDNcm8gZvewP5Rzxp4yVLzLAVHzgg=;
        b=UKt8UQLNgI9tpkr4snpONAp3QfNoz0LBspHB/8pjfpkWazEgJkux98KbUXNG89aCO+
         +90XkVxUmvNf7a1nNGAYrG5ufmIyAF4p8n3zt4NlvQQ5nRiWV9ESBsVMixJdkGuta7u8
         POy7G/ifmUtoXhxXVV52ykl6TxRzRZRcgATP6u+WYyGbAmUyQm9WBHEv/osNklfT8usB
         yQn87abq95BLJjEq226Tljj+7+Ed9iU3FSGwsRt3MtQth5bXtAY9Ucd8V8hk1IfdVww1
         s9hGqsonpNbVpQKKWTkFdW6nDjgf+GrC2r8wIq3BG6EQIk+I38zaKgALSPyhgJ6ZHXVc
         3SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017307; x=1688609307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsp3S46+y10MzDMDNcm8gZvewP5Rzxp4yVLzLAVHzgg=;
        b=fRwJ6bV4Go0XlSNcindZaaPfIJA9wcDGfv3KVDJYN1y+q0zbXUGJzdp/FewgX4vlcz
         TtwL51knuN0UkoKhXj/cUn6YXNkjcniLf/I5TE4IsbgAuiPMUEXoDZuJVfPMyKz3Wc7L
         W1bS8e4ZxtGS1jyU452xYFgMJsyrq8SxCAKHODxHFDNT0BuWefMKZowsEWRDLpMyyNsM
         BNfmBLTu5P7fEBUEu87RFpf47RA9gVM2WIWO/RJW+ny6+qII4kGc0mWDHPvCBwAWAdiA
         itBUjvra0eaZQFtLGKuYfOfjxbwMMWt4xrh/aZZnULLMpYSXHyIRcYblzCmphVPNPPIo
         3SVw==
X-Gm-Message-State: AC+VfDya/2jOpJQPp4Du0Buq56qIOt2DlweEPlusggcVnrfMaZ6IU8Rj
        bgwI2nwi6SjRquIdXoXCMmecLa3D5pU=
X-Google-Smtp-Source: ACHHUZ4u11M99V7t4tKuZlUS/rQ6EwYLIbg9i8e/xaXh5lLGVuwUQe/m89Q4CPEjmXqj/cgjD4wdaA==
X-Received: by 2002:a1c:7203:0:b0:3f7:371a:ec8f with SMTP id n3-20020a1c7203000000b003f7371aec8fmr665930wmc.15.1686017307541;
        Mon, 05 Jun 2023 19:08:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f182a10106sm12373997wmj.8.2023.06.05.19.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:27 -0700 (PDT)
Message-Id: <52f7d29f509070a17a32a6f1c888588cc87e6cb9.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:19 +0000
Subject: [PATCH v3 4/9] doc: trailer: examples: avoid the word "message" by
 itself
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Previously, "message" could mean the input, output, commit message, or
"internal body text inside the commit message" (in the EXAMPLES
section). Avoid overloading this term by using the appropriate meanings
explicitly.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 50 ++++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index ffde97a6c3d..011ed0c3590 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -82,12 +82,12 @@ OPTIONS
 
 --trim-empty::
 	If the <value> part of any trailer contains only whitespace,
-	the whole trailer will be removed from the resulting message.
+	the whole trailer will be removed from the output.
 	This applies to existing trailers as well as new trailers.
 
 --trailer <token>[(=|:)<value>]::
 	Specify a (<token>, <value>) pair that should be applied as a
-	trailer to the input messages. See the description of this
+	trailer to the inputs. See the description of this
 	command.
 
 --where <placement>::
@@ -101,7 +101,7 @@ OPTIONS
 --if-exists <action>::
 --no-if-exists::
 	Specify what action will be performed when there is already at
-	least one trailer with the same <token> in the message.  A setting
+	least one trailer with the same <token> in the input.  A setting
 	provided with '--if-exists' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-exists' or '--no-if-exists'. Possible actions are `addIfDifferent`,
@@ -110,7 +110,7 @@ OPTIONS
 --if-missing <action>::
 --no-if-missing::
 	Specify what action will be performed when there is no other
-	trailer with the same <token> in the message.  A setting
+	trailer with the same <token> in the input.  A setting
 	provided with '--if-missing' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-missing' or '--no-if-missing'. Possible actions are `doNothing`
@@ -177,7 +177,7 @@ first trailer with the same <token>.
 trailer.ifexists::
 	This option makes it possible to choose what action will be
 	performed when there is already at least one trailer with the
-	same <token> in the message.
+	same <token> in the input.
 +
 The valid values for this option are: `addIfDifferentNeighbor` (this
 is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
@@ -187,10 +187,10 @@ trailer with the same (<token>, <value>) pair is above or below the line
 where the new trailer will be added.
 +
 With `addIfDifferent`, a new trailer will be added only if no trailer
-with the same (<token>, <value>) pair is already in the message.
+with the same (<token>, <value>) pair is already in the input.
 +
 With `add`, a new trailer will be added, even if some trailers with
-the same (<token>, <value>) pair are already in the message.
+the same (<token>, <value>) pair are already in the input.
 +
 With `replace`, an existing trailer with the same <token> will be
 deleted and the new trailer will be added. The deleted trailer will be
@@ -198,12 +198,12 @@ the closest one (with the same <token>) to the place where the new one
 will be added.
 +
 With `doNothing`, nothing will be done; that is no new trailer will be
-added if there is already one with the same <token> in the message.
+added if there is already one with the same <token> in the input.
 
 trailer.ifmissing::
 	This option makes it possible to choose what action will be
 	performed when there is not yet any trailer with the same
-	<token> in the message.
+	<token> in the input.
 +
 The valid values for this option are: `add` (this is the default) and
 `doNothing`.
@@ -275,37 +275,37 @@ EXAMPLES
 --------
 
 * Configure a 'sign' trailer with a 'Signed-off-by' key, and then
-  add two of these trailers to a message:
+  add two of these trailers to a commit message file:
 +
 ------------
 $ git config trailer.sign.key "Signed-off-by"
 $ cat msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 $ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>' <msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Signed-off-by: Alice <alice@example.com>
 Signed-off-by: Bob <bob@example.com>
 ------------
 
-* Use the `--in-place` option to edit a message file in place:
+* Use the `--in-place` option to edit a commit message file in place:
 +
 ------------
 $ cat msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Signed-off-by: Bob <bob@example.com>
 $ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>' --in-place msg.txt
 $ cat msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Signed-off-by: Bob <bob@example.com>
 Acked-by: Alice <alice@example.com>
@@ -328,7 +328,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ cat msg1.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
@@ -336,19 +336,19 @@ $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.
 $ git interpret-trailers --trailer sign <msg1.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Signed-off-by: Bob <bob@example.com>
 $ cat msg2.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Signed-off-by: Alice <alice@example.com>
 $ git interpret-trailers --trailer sign <msg2.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Signed-off-by: Alice <alice@example.com>
 ------------
@@ -376,14 +376,14 @@ test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
 $ cat msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 $ git config trailer.help.key "Helped-by: "
 $ git config trailer.help.ifExists "addIfDifferentNeighbor"
 $ git config trailer.help.cmd "~/bin/glog-find-author"
 $ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
@@ -400,14 +400,14 @@ test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
 $ cat msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 $ git config trailer.ref.key "Reference-to: "
 $ git config trailer.ref.ifExists "replace"
 $ git config trailer.ref.cmd "~/bin/glog-grep"
 $ git interpret-trailers --trailer="ref:Add copyright notices." <msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 ------------
@@ -419,7 +419,7 @@ Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 $ cat msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 see: HEAD~2
 $ cat ~/bin/glog-ref
@@ -432,7 +432,7 @@ $ git config trailer.see.cmd "glog-ref"
 $ git interpret-trailers --trailer=see <msg.txt
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 See-also: fe3187489d69c4 (subject of related commit)
 ------------
-- 
gitgitgadget

