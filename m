Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833EC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 04:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjECEsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 00:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjECEs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 00:48:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FD140F0
        for <git@vger.kernel.org>; Tue,  2 May 2023 21:48:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-518d325b8a2so4063910a12.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683089284; x=1685681284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6y75XGSVY6sd1bhNEcKQaOz5yNiZQ8orhdTXgyYq3A=;
        b=H/nPxDk/s+2WF7tjreWR4z8LVp06YpTrfKqWbOXP9+eNPU0nzWJek4mkCspS6oarLl
         nvVnTRamYmdikRMRKkPDJvpG8LjMbChHsH7Fu5+nrBokD/AK6vBnEZ+WDWg+ud5FN6Hx
         tCsbVoU09MHUqZEa3Tu25mCsqrP6bPSkgbKCTy5E1XoGa59+A4nCA2rD/gOrbBBy/N8S
         k4PpmsYDbn8fwvvEQpPw7zqKkVsZCAf84H1Gg6R6O3GGQo82QnteDRZMk8e2j4lGqCJa
         4sirykVoPFLiWqeDtWfsakiCV6O1AjHFrVlLZxblSY1CrEyCM47iV4BbjHwPUmgagSB5
         dyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683089284; x=1685681284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6y75XGSVY6sd1bhNEcKQaOz5yNiZQ8orhdTXgyYq3A=;
        b=Hl9Kg3e/jpNZNHn/2U8YzkMA1VeZLA8reVp3vVv4aCnWNbcamjLSenB2T88rpMscX2
         H0ItHC4VaL/O4FMQdgt7IfIGm20/f7DtLzJAuThv8WNiNJkLBVHd1kRzojvQEPk/JDTx
         4HN9iLa4qXgs39qdH2CdEITZdue19zS+TOjP67uhgJ24EVvM+5r7QfypOjoz6Kmwt/eE
         rfroWl2Qo96SozSM7GdM+WXBt3WhVBbAI4NdArkbSItpGlEGMKSCpSruk7iakMc9X+et
         aHahjnq+JpVf8CkeF4LjcPHA/78j0fIHPyptA7WsPXDV5NgVZrRut1ipVuTY9CFjNAcA
         GHfA==
X-Gm-Message-State: AC+VfDxA/qt/iAge3q7T0w9CcKEfhlSndzurFBF+wF6GryPBnfh70Kmw
        Nf9PrVOgO/XJ8Fl/+wbace0CZWoJEko=
X-Google-Smtp-Source: ACHHUZ4OyjPPvYALW5EqELF81T41c2/c96hY+md1yK1Y+l8WloDTmACoqFEyAaLtgP43DJ6ode0R0g==
X-Received: by 2002:a05:6a20:a121:b0:ef:dd63:1831 with SMTP id q33-20020a056a20a12100b000efdd631831mr28267081pzk.11.1683089283769;
        Tue, 02 May 2023 21:48:03 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b0063d642dcd12sm23320349pfg.16.2023.05.02.21.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 21:48:03 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        gitster@pobox.com, sandals@crustytoothpaste.net
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 1/1] docs: rewrite the documentation of the text and eol attributes
Date:   Tue,  2 May 2023 22:46:56 -0600
Message-Id: <20230503044656.221175-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503044656.221175-1-alexhenrie24@gmail.com>
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
 <20230503044656.221175-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
attribute sounds like either it does not affect normalization on checkin
or it forces normalization on checkin. It also sounds like setting eol
(or setting a config variable) is required to turn on conversion on
checkout, but the text attribute can turn on conversion on checkout by
itself if eol is unspecified.

Rephrase the documentation of text, text=auto, eol, eol=crlf, and eol=lf
to be clear about how they are the same, how they are different, and in
what cases conversion is performed.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/gitattributes.txt | 59 +++++++++++++++++----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 39bfbca1ff..02a3ec83e4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -120,20 +120,19 @@ repository upon 'git add' and 'git commit'.
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
+conversion: When a matching file is added to the index, the file's line
+endings are normalized to LF in the index.  Conversely, when the file is
+copied from the index to the working directory, its line endings may be
+converted from LF to CRLF depending on the `eol` attribute, the Git
+config, and the platform (see explanation of `eol` below).
 
 Set::
 
 	Setting the `text` attribute on a path enables end-of-line
-	normalization and marks the path as a text file.  End-of-line
-	conversion takes place without guessing the content type.
+	conversion on checkin and checkout as described above.  Line endings
+	are normalized to LF in the index every time the file is checked in,
+	even if the file was previously added to Git with CRLF line endings.
 
 Unset::
 
@@ -142,10 +141,11 @@ Unset::
 
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
 
@@ -159,26 +159,29 @@ unspecified.
 `eol`
 ^^^^^
 
-This attribute sets a specific line-ending style to be used in the
-working directory.  This attribute has effect only if the `text`
-attribute is set or unspecified, or if it is set to `auto`, the file is
-detected as text, and it is stored with LF endings in the index.  Note
-that setting this attribute on paths which are in the index with CRLF
-line endings may make the paths to be considered dirty unless
-`text=auto` is set. Adding the path to the index again will normalize
-the line endings in the index.
+This attribute marks a path to use a specific line-ending style in the
+working tree when it is checked out.  It has effect only if `text` or
+`text=auto` is set (see above), but specifying `eol` automatically sets
+`text` if `text` was left unspecified.
 
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
+	in the index when the file is checked out.
+
+Unspecified::
+
+	If the `eol` attribute is unspecified for a file, its line endings
+	in the working directory are determined by the `core.autocrlf` or
+	`core.eol` configuration variable (see the definitions of those
+	options in linkgit:git-config[1]).  If `text` is set but neither of
+	those variables is, the default is `eol=crlf` on Windows and
+	`eol=lf` on all other platforms.
 
 Backwards compatibility with `crlf` attribute
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.40.1

