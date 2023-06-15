Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E7EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbjFOCyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbjFOCx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E48B26A9
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fb7be435dso3654491f8f.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797634; x=1689389634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qqv650L8XotgZ0aR4Jqb6NGuW3Hg6cdUtqyWLiBjzU=;
        b=BE2248QGrKlDAvFm9MxkCySzLJaMU8axaZoSVG2s107qScw9hwPAY9Ycc9NqqdDjvT
         OM9o1CXuF8HK3Cq/Z25VqZkgq9NID2wiQ1AXz7JonsPB3rMFcm6nFsYWDWhvuUqsozi6
         ONoxYLVIdLGCUd11tmozh0UxpqsE457F8XaXhtUMTe6oRKQ/WhkdF0caT36lhkwIxYM3
         tCm+I/o0yDEsv4vaM7+Lt42a7MMTp3HBXKrt+GFr9SWFxOuHppeojErq5itSFhSnQ1ZK
         LkDaNGsZ2QA5SW6U7P7WO/2fikaQkUpyfiW37++qQTQANmMd7ShK2N/4kVmuXJOKwO6k
         pAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797634; x=1689389634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qqv650L8XotgZ0aR4Jqb6NGuW3Hg6cdUtqyWLiBjzU=;
        b=lv4rz14lDvyfYMwsfw8HFmb5DujPe/X2+it4H1qDC495Bqd2knqHyulai27/WH81+e
         euTrCOWpsUtvlew2b44LNyiaggSONsu5tFC0gf1kjumPzEyYEPtXO8lAzoH+TInbuHvp
         T8+Gh4GcH4K3JyPcyyn8cT6QIVLl6zeGnWw1mBvMkzQc2F23TePcS4Ut5vZHvtfk52id
         Py5yO5R2A6gcUjLK8yby1UtHY19MTlyD9ZWvCa81mD/WaZma2vzbp4uePagWniUGLQpT
         hoUL5dNwM927fpSwEHMs10S6HNBl1MOJSiD7CQEwZ7TyF6Cv5Ur/IWPKvJ/GHwT4hVC6
         AhRQ==
X-Gm-Message-State: AC+VfDyMBeuYVCE3b25wi5cjt6a8XNJaLvmRBD78lHopKkRYMugFMfL1
        usTQ0HxTikl/QtC7ceDwoI+hkAn+kFk=
X-Google-Smtp-Source: ACHHUZ7lqKBrR02G/8tVsN14I7n/5mfLBwHPG27pG1D0Zlad9iaHM1nh3UJ59jR2rgu7TT07dyMLFg==
X-Received: by 2002:a5d:484f:0:b0:30f:ca58:39ca with SMTP id n15-20020a5d484f000000b0030fca5839camr5933167wrs.31.1686797634499;
        Wed, 14 Jun 2023 19:53:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d48c4000000b0030903d44dbcsm19593274wrs.33.2023.06.14.19.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:54 -0700 (PDT)
Message-Id: <6b4cb31b17077181a311ca87e82464a1e2ad67dd.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:45 +0000
Subject: [PATCH v4 4/9] doc: trailer: examples: avoid the word "message" by
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
index d0a0b303880..58a9c691492 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -83,12 +83,12 @@ OPTIONS
 
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
@@ -102,7 +102,7 @@ OPTIONS
 --if-exists <action>::
 --no-if-exists::
 	Specify what action will be performed when there is already at
-	least one trailer with the same <token> in the message.  A setting
+	least one trailer with the same <token> in the input.  A setting
 	provided with '--if-exists' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-exists' or '--no-if-exists'. Possible actions are `addIfDifferent`,
@@ -111,7 +111,7 @@ OPTIONS
 --if-missing <action>::
 --no-if-missing::
 	Specify what action will be performed when there is no other
-	trailer with the same <token> in the message.  A setting
+	trailer with the same <token> in the input.  A setting
 	provided with '--if-missing' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-missing' or '--no-if-missing'. Possible actions are `doNothing`
@@ -178,7 +178,7 @@ first trailer with the same <token>.
 trailer.ifexists::
 	This option makes it possible to choose what action will be
 	performed when there is already at least one trailer with the
-	same <token> in the message.
+	same <token> in the input.
 +
 The valid values for this option are: `addIfDifferentNeighbor` (this
 is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
@@ -188,10 +188,10 @@ trailer with the same (<token>, <value>) pair is above or below the line
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
@@ -199,12 +199,12 @@ the closest one (with the same <token>) to the place where the new one
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
@@ -276,37 +276,37 @@ EXAMPLES
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
+body text
 $ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>' <msg.txt
 subject
 
-message
+body text
 
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
+body text
 
 Signed-off-by: Bob <bob@example.com>
 $ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>' --in-place msg.txt
 $ cat msg.txt
 subject
 
-message
+body text
 
 Signed-off-by: Bob <bob@example.com>
 Acked-by: Alice <alice@example.com>
@@ -329,7 +329,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ cat msg1.txt
 subject
 
-message
+body text
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
@@ -337,19 +337,19 @@ $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.
 $ git interpret-trailers --trailer sign <msg1.txt
 subject
 
-message
+body text
 
 Signed-off-by: Bob <bob@example.com>
 $ cat msg2.txt
 subject
 
-message
+body text
 
 Signed-off-by: Alice <alice@example.com>
 $ git interpret-trailers --trailer sign <msg2.txt
 subject
 
-message
+body text
 
 Signed-off-by: Alice <alice@example.com>
 ------------
@@ -377,14 +377,14 @@ test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
 $ cat msg.txt
 subject
 
-message
+body text
 $ git config trailer.help.key "Helped-by: "
 $ git config trailer.help.ifExists "addIfDifferentNeighbor"
 $ git config trailer.help.cmd "~/bin/glog-find-author"
 $ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <msg.txt
 subject
 
-message
+body text
 
 Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
@@ -401,14 +401,14 @@ test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
 $ cat msg.txt
 subject
 
-message
+body text
 $ git config trailer.ref.key "Reference-to: "
 $ git config trailer.ref.ifExists "replace"
 $ git config trailer.ref.cmd "~/bin/glog-grep"
 $ git interpret-trailers --trailer="ref:Add copyright notices." <msg.txt
 subject
 
-message
+body text
 
 Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 ------------
@@ -420,7 +420,7 @@ Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 $ cat msg.txt
 subject
 
-message
+body text
 
 see: HEAD~2
 $ cat ~/bin/glog-ref
@@ -433,7 +433,7 @@ $ git config trailer.see.cmd "glog-ref"
 $ git interpret-trailers --trailer=see <msg.txt
 subject
 
-message
+body text
 
 See-also: fe3187489d69c4 (subject of related commit)
 ------------
-- 
gitgitgadget

