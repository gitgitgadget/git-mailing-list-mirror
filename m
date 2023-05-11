Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BEC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbjEKVTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbjEKVTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E342D56
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3064099f9b6so5972235f8f.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839978; x=1686431978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX53ON7mzhZNh1r5Rt/vUAnbEJULUr8rQHsYs/xPHAk=;
        b=jqwNnUmcBagCoEwud68g61nEi2SQjbCLasllJOEk5VDyBoDDa5U+EIcy9/LTXuz4dm
         hkvrO8w7Gp5uar58zVrwTuBOdBm8cLd6bFnQwZ0Sv69/JK8QEcDRPzuECS/R1ejVyNZP
         8cv8uFCzItM4mLVGJQyKi9UOpMu3i2LLgtfBGu/UYKHDZt4D5uyOjSy9wM0/iPDRA95K
         aRgSpcfkGQBCak/XRmKmZxyH6rgM0bMDpSqAKoVyWGBZ0gQift2893L6AMiqB0Zbq+8R
         lQdfqfB6Yw8jz+4DR+7k0fTaUEJo6pL6Wjsopgj2gTNvIajhXmocN8/WO34lLH0Xj6gO
         n93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839978; x=1686431978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX53ON7mzhZNh1r5Rt/vUAnbEJULUr8rQHsYs/xPHAk=;
        b=Ja6ih/z8ZOD6bBSuCk4S6f5SF4Egv+5ajFc+pFh7Cv48B6AxFyOjPIkVm1MfSDdiSr
         tz7EzLQWcl1FBqIxX3B3WveOzhZGwdVWIOoaqXkn8r5EKUKdXPyVcHb1/rtfCw0fNmUB
         BdmBwKPnGQpZY7jfh0J2ZxKS45XmVRMgbSoArrpx4NKnxMEuk1HDUdsCegKfPVkuRbuc
         ixq3EjISxwASkb9VvkYXXEiuUZUQLyrzRrxNdlRUMrJcqjXJXc4By3lL7QCIY0Zbz8Qg
         0M4j+uV3kbaZRs5a0UzmZCbZ870UyECfni2rK5IMfGWy/uPf9uG6Eljswarg34ReCprM
         l7AA==
X-Gm-Message-State: AC+VfDwK+7b8xKP9QrZbX04wHz6URwfAXV78SVBckQSeeFWA2QmpU1PX
        KH7iFjepGWyJ2hGRl4NaD3FKChAEzmg=
X-Google-Smtp-Source: ACHHUZ5xzDyw0XHzRErVKE69RwaAsALgOGk5nN7n8N+D3Yo4zNmADipKbAkkYe9DXEx/N3uunjcK4Q==
X-Received: by 2002:a5d:5942:0:b0:306:2e48:6ded with SMTP id e2-20020a5d5942000000b003062e486dedmr14683964wri.13.1683839978548;
        Thu, 11 May 2023 14:19:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020adff985000000b002fda1b12a0bsm21703299wrr.2.2023.05.11.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:38 -0700 (PDT)
Message-Id: <5fabe166714ba98c2583c35f2b25563248e90a6e.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:29 +0000
Subject: [PATCH v2 3/9] doc: trailer: drop "commit message part" phrasing
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

The command can take inputs that are either just a commit message, or
an email-like output such as git-format-patch which includes a commit
message, "---" divider, and patch part. The existing explanation blends
these two inputs together in the first sentence

    This command reads some patches or commit messages

which then necessitates using the "commit message part" phrasing (as
opposed to just "commit message") because the input is ambiguous per the
above definition.

This change separates the two input types and explains them separately,
and so there is no longer a need to use the "commit message part"
phrase.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 35 +++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index cd4d724a0b7..58a7ea24606 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -18,17 +18,22 @@ Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-This command reads some patches or commit messages from either the
-<file> arguments or the standard input if no <file> is specified. If
-`--parse` is specified, the output consists of the parsed trailers.
-
+This command reads commit messages from either the
+<file> arguments or the standard input if no <file> is specified.
+If `--parse` is specified, the output consists of the parsed trailers.
 Otherwise, this command applies the arguments passed using the
-`--trailer` option, if any, to the commit message part of each input
-file. The result is emitted on the standard output.
+`--trailer` option, if any, to each input file. The result is emitted on the
+standard output.
+
+This command can also operate on the output of linkgit:git-format-patch[1],
+which is more elaborate than a plain commit message. Namely, such output
+includes a commit message (as above), a "---" divider line, and a patch part.
+For these inputs, the divider and patch parts are ignored, unless `--no-divider`
+is specified.
 
 Some configuration variables control the way the `--trailer` arguments
-are applied to each commit message and the way any existing trailer in
-the commit message is changed. They also make it possible to
+are applied to each input and the way any existing trailer in
+the input is changed. They also make it possible to
 automatically add some trailers.
 
 By default, a '<token>=<value>' or '<token>:<value>' argument given
@@ -36,7 +41,7 @@ using `--trailer` will be appended after the existing trailers only if
 the last trailer has a different (<token>, <value>) pair (or if there
 is no existing trailer). The <token> and <value> parts will be trimmed
 to remove starting and trailing whitespace, and the resulting trimmed
-<token> and <value> will appear in the message like this:
+<token> and <value> will appear in the output like this:
 
 ------------------------------------------------
 token: value
@@ -47,19 +52,17 @@ This means that the trimmed <token> and <value> will be separated by
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-after the commit message part of the output, and, if there is no line
-with only spaces at the end of the commit message part, one blank line
-will be added before the new trailer.
+at the end of the input. A blank line will be added before the new
+trailer if there isn't one already.
 
-Existing trailers are extracted from the input message by looking for
+Existing trailers are extracted from the input by looking for
 a group of one or more lines that (i) is all trailers, or (ii) contains at
 least one Git-generated or user-configured trailer and consists of at
 least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
-The group must either be at the end of the message or be the last
+The group must either be at the end of the input or be the last
 non-whitespace lines before a line that starts with '---' (followed by a
-space or the end of the line). Such three minus signs start the patch
-part of the message. See also `--no-divider` below.
+space or the end of the line).
 
 When reading trailers, there can be no whitespace before or inside the
 token, but any number of regular space and tab characters are allowed
-- 
gitgitgadget

