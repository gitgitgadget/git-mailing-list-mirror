Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF4C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjEKVT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbjEKVTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C41B30C2
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f450815d02so19037115e9.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839979; x=1686431979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9dO7Gs9CKGG6mYYiCrAJWyCRj0ROdSDFr4usoKEOQs=;
        b=TclkJMd0zCWLZQYgdU9bCA4Do9EV0qg3pn6qnEyD8BTkFiFwMZI/Rkr2m5SEs+Q7tp
         OCD6fUDnIJpQUomlNYTQ6eFejcVkFOS5CgRz+vYGwrqP7b5jcUvcPW5K5xKF9Khz6eE+
         zN39VIBUbnU4MZzzCILP4TGtxIMBX3hFLp6k+PaVXdP33MSNIOJHoI9PabmfRyZSKLOe
         dyORmp6QwEJKTS/HhSn6a0X322kqLGGJTXR9fKMd0WHqmCdKnmiqqhJpm7J7aVxi+CGR
         UXGh4LW/YGxOziwZdNp3SKfMqZKsUIKpyOuP8DOPx+muH5YbpTCYkDuJAzdurju8KVYo
         svtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839979; x=1686431979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9dO7Gs9CKGG6mYYiCrAJWyCRj0ROdSDFr4usoKEOQs=;
        b=NYRvlK8zC6qMjwNpi7HZfohyyP/RHVDuwAL3fA1OPq3+sWQdTpsEujE4VbrdUYsCf1
         4WWpGk6pUdrmnuyEAcRCu/S+CBGT0K2a+cjyXBu8VPfbxD3XxzZzv81GjZcYsPqLOoGY
         2fS7ykJzZL6aEPX7Kx8enfUQZmqN7jEtDBUMLeJgEdBH9MhWN30ai7WYX9rslpqQJ8wS
         nqNK6yCuHp8YJuimMblGp96CjoG+MPy6XK8A2V76wltJWNenQXmchv3Xdbw85NLOYXfM
         A3IpUZNOwCwwa3rdoLMFB8sxpR8GUKvToFdBv0HT9xQ5WDspmobG1t0fKQOUdCeBOxG2
         yI7A==
X-Gm-Message-State: AC+VfDzPSFaRrhrrWilLxz9aoRMmUaZAEuI24GNnzHE0FeAezCrvue8V
        IIdpw9Vl74f0t5iEwqLB1YX49mkpBr8=
X-Google-Smtp-Source: ACHHUZ40OyjC+JFMdjQAD8hsQM0r9BOkpJCU2GSftZUQ5ni2zagN9q0SAtFaCrk+mRlLSMa2V7ekRw==
X-Received: by 2002:a05:600c:3657:b0:3f4:2267:10cf with SMTP id y23-20020a05600c365700b003f4226710cfmr11154324wmq.32.1683839979323;
        Thu, 11 May 2023 14:19:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a1ccc05000000b003ee5fa61f45sm26626088wmb.3.2023.05.11.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:39 -0700 (PDT)
Message-Id: <783a0b1e00309e9bcf13494908d99317df72f0d6.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:30 +0000
Subject: [PATCH v2 4/9] doc: trailer: examples: avoid the word "message" by
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
 Documentation/git-interpret-trailers.txt | 42 ++++++++++++------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 58a7ea24606..8766edbf4dc 100644
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
 $ cat msg.txt | git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>'
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
@@ -366,12 +366,12 @@ $ git config trailer.help.cmd "~/bin/glog-find-author"
 $ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <<EOF
 > subject
 >
-> message
+> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 >
 > EOF
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
@@ -391,12 +391,12 @@ $ git config trailer.ref.cmd "~/bin/glog-grep"
 $ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
 > subject
 >
-> message
+> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 >
 > EOF
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 ------------
@@ -412,13 +412,13 @@ $ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --ab
 $ git interpret-trailers <<EOF
 > subject
 > 
-> message
+> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 > 
 > see: HEAD~2
 > EOF
 subject
 
-message
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 
 See-also: fe3187489d69c4 (subject of related commit)
 ------------
-- 
gitgitgadget

