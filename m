Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D9EEC875F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjIGWUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbjIGWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B71BE2
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so16322925e9.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125219; x=1694730019; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLVdEbBLsQwGTTC+nUkYpJ5KWmtroxiICoNeKqfTQU0=;
        b=CDpq+4eLSwaUIKah0itUHKSQmeQpvPyYoglNtprdk6jSQ1qnh5QZQ6DUVKFR3Fxyxn
         CWNly4IK3L2PWObdDk+f4wm5r46UWrIBpMQ7gLdNIFozyJVXt2HjeJ+Tq5RtdJP3LKxJ
         0hKTCVvXEZUqZQU/b9lUtzq9A4KRbO3In0zgpBd4Q6quC4l1JIEloryBJvKEM9PXEDSG
         AYWsU0POQ4ESr3DQgWXS3QIYr6457WaIAB2oid7Ib12ztjZ0XyfRjid/QfHqmmeHHSB+
         N4xTqIVntXkwEzxSPUo6kQHVuqWzSW8IprmtJe8neiau6rIsyQGwmn4+yKako1KgEsPt
         ew4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125219; x=1694730019;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLVdEbBLsQwGTTC+nUkYpJ5KWmtroxiICoNeKqfTQU0=;
        b=CYioMVdA0fRAJL2uSRlgvfYFEjPuov4P1vMlCOaTKWuuIAS0hghfn1lpYQHYfpj2YZ
         95VRSoxVXSFNhsgp4m3iDg/T2Qq6M1AoExNusBB/MX8hNnmRC4YoeR37jZ0p77t3wWXm
         mnHio2bKMruvDh76GPEh39VK7gfj6zwH7T/ML23msnRqQYAyaYgSwrYmVx9U+TvoPEkU
         JJtbDcRx8wDyMdZJkmsWTSQMqXyAXTfZKp/vr6ADH50tD21d3TizvV22txbwDIWovNKY
         bj4Z+qMSfLjNZD7Nhj2UNetEs05OAIzkbQWBk+LyLsAivmLOYE9rJh4yLWskH02YeQPk
         qQ3A==
X-Gm-Message-State: AOJu0Yzt9cFUKFSL5z1B0QWu4TfXKZgND8uuY2vZzSTrvd5Ahq/vAmBL
        ICBxiJ77B4s9aj9CaODlf3kvjDOjhCw=
X-Google-Smtp-Source: AGHT+IEtNeracSmhpfW3xDF7x0ashKItT8HnPAH7TX8U94bdLcxGDcw7m3q/0OCIbQ6VtXtH012j7A==
X-Received: by 2002:a5d:54d0:0:b0:319:8a5a:ab5e with SMTP id x16-20020a5d54d0000000b003198a5aab5emr495696wrv.38.1694125219340;
        Thu, 07 Sep 2023 15:20:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d6983000000b003197c7d08ddsm433233wru.71.2023.09.07.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:18 -0700 (PDT)
Message-ID: <4db823ac3549c031b61b5a0ec0efd56b70d2a45c.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:07 +0000
Subject: [PATCH v3 11/13] trailer doc: emphasize the effect of configuration
 variables
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

The sentence does not mention the effect of configuration variables at
all, when they are actively used by default (unless --parse is
specified) to potentially add new trailers, without the user having to
always supply --trailer manually.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 62ba2b1232e..a288ff111cb 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -34,9 +34,12 @@ This command reads commit messages from either the
 If `--parse` is specified, the output consists of the parsed trailers
 coming from the input, without influencing them with any command line
 options or configuration variables.
-Otherwise, this command applies the arguments passed using the
-`--trailer` option, if any, to each input file. The result is emitted on the
-standard output.
+
+Otherwise, this command applies `trailer.*` configuration variables
+(which could potentially add new trailers, as well as reposition them),
+as well as any command line arguments that can override configuration
+variables (such as `--trailer=...` which could also add new trailers),
+to each input file. The result is emitted on the standard output.
 
 This command can also operate on the output of linkgit:git-format-patch[1],
 which is more elaborate than a plain commit message. Namely, such output
-- 
gitgitgadget

