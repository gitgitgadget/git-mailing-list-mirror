Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C645AEB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjFOCyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjFOCx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAE26A0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8d0d684f3so12908315e9.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797634; x=1689389634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39VXbuFirTo9uhsb874geNnZ+aer6eAP80SdCvcwMMg=;
        b=EcmJBtSE/q6Q3kSPrhD3Q2rOQqvzOYpJI+7lPkuo6RpNyKUEuejGcCc+5Xc/bVAcnl
         XPT7F6uYRZ4LNtXvFRXCspl2D17DDIk4vFK7Z5SVSar5KVo+PfEXURbuFQLJg7wVklea
         uaiKxC5uWwCsQdc4DBwaZg2FlSN6op/BPt3alAwHfIJ4FQKwRdMMeJrjITwGtwI1wWy6
         MaKulFVWm4bwKqSixL1wMyRhlTrT2jtLwztAN2uykw0LMRUt4diUn77NM6j68LtFJ2zy
         X6LBidZVTEboz0zw2kuKXLbqPGji0OwUyiRrx7R26mR+6sNAxDoV8uR95eSXxW5Ifwgf
         AV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797634; x=1689389634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39VXbuFirTo9uhsb874geNnZ+aer6eAP80SdCvcwMMg=;
        b=hFO0MCuFzC3LL4v/fMdLz1rhR4xAukksRDvI/G9JDiGA0sgQwECTMb3uLbp7aDGwUq
         KN158cdXi9U3xZmgppyERJabA3xoe+Rvmv4+kJoFnfNFiHxpaACRTIlV8nqGkRZjAiVH
         sUl6vW/2EYV6nLXk6pyeaB5d5E0JweHBJBBaLW9158fB4YWBTOB2XNrz5olsY5lFFNOS
         6u7T6rZFlrIV9mFpMUxCTrvH6JhcZbhkmSMB2Ly8ir0AUZCy9yG67gcl72gbDZb6olKr
         A34iDtaJHGIaPmT4v0ah7KCnwEACDcOyCgDXj0rKuX0Rs6KxbLGbPcfLMBOuHMZUdgUr
         hgbA==
X-Gm-Message-State: AC+VfDxApRGyL/+niq9YMW2y0UhD4InuGBAi8t1v08Bt8r1eFTW6YvzE
        oIoTlP8sXYeLlyj4jtNXtqgdA2UuyOs=
X-Google-Smtp-Source: ACHHUZ4qLprDK0uFW/jNh0ilihYBQvAnkrCcThQGREFUoBNj0N+5fMLzYKZoO0UnJOGVl3Bk//xkCg==
X-Received: by 2002:a1c:f70a:0:b0:3f7:3280:810b with SMTP id v10-20020a1cf70a000000b003f73280810bmr12241493wmh.19.1686797633895;
        Wed, 14 Jun 2023 19:53:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c314400b003f1978bbcd6sm1340526wmo.3.2023.06.14.19.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:53 -0700 (PDT)
Message-Id: <3c85477d791d04b063e1f041c138c307e0ee495f.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:44 +0000
Subject: [PATCH v4 3/9] doc: trailer: drop "commit message part" phrasing
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
 Documentation/git-interpret-trailers.txt | 36 +++++++++++++-----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index da8fec7d5fe..d0a0b303880 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -18,17 +18,23 @@ Add or parse 'trailer' lines that look similar to RFC 822 e-mail
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
+For these inputs, the divider and patch parts are not modified by
+this command and are emitted as is on the output, unless
+`--no-divider` is specified.
 
 Some configuration variables control the way the `--trailer` arguments
-are applied to each commit message and the way any existing trailer in
-the commit message is changed. They also make it possible to
+are applied to each input and the way any existing trailer in
+the input is changed. They also make it possible to
 automatically add some trailers.
 
 By default, a '<token>=<value>' or '<token>:<value>' argument given
@@ -36,7 +42,7 @@ using `--trailer` will be appended after the existing trailers only if
 the last trailer has a different (<token>, <value>) pair (or if there
 is no existing trailer). The <token> and <value> parts will be trimmed
 to remove starting and trailing whitespace, and the resulting trimmed
-<token> and <value> will appear in the message like this:
+<token> and <value> will appear in the output like this:
 
 ------------------------------------------------
 token: value
@@ -47,19 +53,17 @@ This means that the trimmed <token> and <value> will be separated by
 
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

