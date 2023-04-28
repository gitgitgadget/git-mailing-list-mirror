Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC84C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 04:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjD1EXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 00:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjD1EXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 00:23:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61210CA
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 21:23:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517bdd9957dso6809391a12.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682655789; x=1685247789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+otn1St/hPwcyP0yFfELJfkuYIkFqwTQGYHzhOb1IM=;
        b=nNMP/n4gN3DLKK8eW8UHojZuB14vyV6hMag95MbYP4ZBAPR10Tz2rqpSnc0UkY9/Q8
         I+Yi6RMdW6+GCEQ1uck5g99VF4RdqGREM6nnt+fu+05hOemL9h12UNRr50jjtU5//AAy
         1RXwhsVbun0t7+AVIGQbbok50MKA0x2GMOQKffKWeK2bFLUy1f2j+WBdGTrJtNfXsTqd
         FJYKDabZRvCoahxdrtyeIHCTx02JbkOS9cODIh5LglNmRWNqRX+iiyuHyAxW/FV56pLi
         9O1Fve2SF9uywE1xKcU+G5bh36AFt/UtQuqJeNvl0KAIE3dlAF2rCXy40zOE0O2VxLd3
         feSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682655789; x=1685247789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+otn1St/hPwcyP0yFfELJfkuYIkFqwTQGYHzhOb1IM=;
        b=eXNLd3HiT/agAxEeeSEChvJdsmB5b9izluAnQo1Z2n3yDMvw82dINX3rsjV/C/aMVc
         hdf1ZA7ivSQbGHqW60DbNTUA3R0OvD28C0ggP1x/7+63/cn9fJMWn66wY3G1N5re9ZQQ
         qbyDm+1bnGy59n0vC+L3leUpocqzFNo7OagN35B/SWNcj3Cxri0YwWu9qnXphQGTVC31
         QyETMyef2xiEihLl73PmGhblYFFjFprx+a/LZ/Xu8gX63zelP509CnMrHnpXNitC+TQ+
         u0pBTUz6rt83FwRG8134WVpLGXSsHRZ2K1HVlej9uJesdivceFtxQvCqCfVZ4YbRQtar
         ZZXQ==
X-Gm-Message-State: AC+VfDwL6t66FfaW+RPcBVicQSBJPf+lKo9qOSASDMEGwfY1pcWEFODL
        pFb7LlY8LToFT9GBSN3VKSURIDiyZJE=
X-Google-Smtp-Source: ACHHUZ7c/6s/6Cf0O/PMgUZ3d4ltNQRufOjL3OPhAmDEUlyuVxlkMocTdf0/axX6/hpmgxyEEgkb2g==
X-Received: by 2002:a17:902:f552:b0:1a9:2c70:e1eb with SMTP id h18-20020a170902f55200b001a92c70e1ebmr3852969plf.36.1682655789204;
        Thu, 27 Apr 2023 21:23:09 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id lj14-20020a17090b344e00b00246fbf416dasm552409pjb.14.2023.04.27.21.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 21:23:08 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] docs: rewrite the documentation of the text and eol attributes
Date:   Thu, 27 Apr 2023 22:22:21 -0600
Message-Id: <20230428042221.871095-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421055641.550199-1-alexhenrie24@gmail.com>
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two sentences are confusing because the description of the text
attribute sounds exactly the same as the description of the text=auto
attribute:

"Setting the text attribute on a path enables end-of-line normalization"

"When text is set to "auto", the path is marked for automatic
end-of-line conversion"

Unless the reader is already familiar with the two variants, there's a
high probability that they will think that "end-of-line normalization"
is the same thing as "automatic end-of-line conversion".

It's also not clear that the phrase "When the file has been committed
with CRLF, no conversion is done" in the paragraph for text=auto does
not apply equally to the bare text attribute which is described earlier.
Moreover, it falsely implies that normalization is only suppressed if
the file has been committed. In fact, running `git add` on a CRLF file,
adding the text=auto attribute to the file, and running `git add` again
does not do anything to the line endings either.

On top of that, in several places the documentation for the eol
attribute sounds like it can force normalization on checkin and checkout
all by itself, but eol doesn't control normalization on checkin and
doesn't control normalization on checkout either unless accompanied by
the text attribute.

Rephrase the documentation of text, text=auto, eol, eol=crlf, and eol=lf
to be clear about how they are the same, how they are different, and in
what cases normalization is performed.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2: rewrite completely and rewrite the eol documentation too
---
 Documentation/gitattributes.txt | 58 +++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 39bfbca1ff..bcea84f439 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -120,20 +120,22 @@ repository upon 'git add' and 'git commit'.
 `text`
 ^^^^^^
 
-This attribute enables and controls end-of-line normalization.  When a
-text file is normalized, its line endings are converted to LF in the
-repository.  To control what line ending style is used in the working
-directory, use the `eol` attribute for a single file and the
-`core.eol` configuration variable for all text files.
-Note that setting `core.autocrlf` to `true` or `input` overrides
-`core.eol` (see the definitions of those options in
-linkgit:git-config[1]).
+This attribute marks the path as a text file, which enables end-of-line
+normalization on checkin and possibly also checkout: When a matching
+file is added to the index, even if it has CRLF line endings in the
+working directory, the file is stored in the index with LF line endings.
+Conversely, when the file is copied from the index to the working
+directory, its line endings may be converted from LF to CRLF depending
+on the `eol` attribute, the Git config, and the platform (see
+explanation of `eol` below).
 
 Set::
 
 	Setting the `text` attribute on a path enables end-of-line
-	normalization and marks the path as a text file.  End-of-line
-	conversion takes place without guessing the content type.
+	normalization on checkin and checkout as described above.  Line
+	endings are normalized in the index the next time the file is
+	checked in, even if the file was previously added to Git with CRLF
+	line endings.
 
 Unset::
 
@@ -142,10 +144,11 @@ Unset::
 
 Set to string value "auto"::
 
-	When `text` is set to "auto", the path is marked for automatic
-	end-of-line conversion.  If Git decides that the content is
-	text, its line endings are converted to LF on checkin.
-	When the file has been committed with CRLF, no conversion is done.
+	When `text` is set to "auto", Git decides by itself whether the file
+	is text or binary.  If it is text and the file was not already in
+	Git with CRLF endings, line endings are converted on checkin and
+	checkout as described above.  Otherwise, no conversion is done on
+	checkin or checkout.
 
 Unspecified::
 
@@ -162,23 +165,28 @@ unspecified.
 This attribute sets a specific line-ending style to be used in the
 working directory.  This attribute has effect only if the `text`
 attribute is set or unspecified, or if it is set to `auto`, the file is
-detected as text, and it is stored with LF endings in the index.  Note
-that setting this attribute on paths which are in the index with CRLF
-line endings may make the paths to be considered dirty unless
-`text=auto` is set. Adding the path to the index again will normalize
-the line endings in the index.
+detected as text, and it is stored with LF endings in the index.
 
 Set to string value "crlf"::
 
-	This setting forces Git to normalize line endings for this
-	file on checkin and convert them to CRLF when the file is
-	checked out.
+	This setting converts the file's line endings in the working
+	directory to CRLF when the file is checked out.
 
 Set to string value "lf"::
 
-	This setting forces Git to normalize line endings to LF on
-	checkin and prevents conversion to CRLF when the file is
-	checked out.
+	This setting uses the same line endings in the working directory as
+	in the index, whether they are LF or CRLF.  However, unless
+	`text=auto`, adding the file to the index again will normalize its
+	line endings to LF in the index.
+
+Unspecified::
+
+	If the `eol` attribute is unspecified for a file, its line endings
+	in the working directory are determined by the `core.autocrlf` or
+	`core.eol` configuration variable (see the definitions of those
+	options in linkgit:git-config[1]).  The default if `text` is set but
+	neither of those variables is is `eol=lf` on Unix and `eol=crlf` on
+	Windows.
 
 Backwards compatibility with `crlf` attribute
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.40.0

