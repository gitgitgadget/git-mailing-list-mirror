Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C8EC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbjIGWUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbjIGWUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568631BC9
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so16389455e9.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125218; x=1694730018; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fjyB+/Ev/pPz12OjT6v/5ek1rXsiwDYWApg4s4ExgU=;
        b=mtrYAvVYgXj3SU4qTrKyPmk2LqhOpej+JNuCTCsxENnvx0UDqgE6SbhlaRn/Mu5qkn
         MHOjCLRVhdlsg3oNCGBJJ94RSSJUGAz4ZqlDTDHdb7pqZ1DVlRFUnceuhjrLZuV1owNP
         xnBynsZOvSzGrZrc7yb997W5afGbuiWjKAPE0T8F7sI56jvXG70xSZWV0WZj+YmgxEyd
         4kESlHdYOn/MY3hUhffHnEtyGPnwPXT4rxhHsaNviRbWZtAnQDDmXRse4pXNQotTPzWe
         EhYeWjflqubSPgZPKRQPWbrCNDstD1mO5c+B6K5h9O5r13JcFO+y/FVO1nh3zKlfSMhD
         vTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125218; x=1694730018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fjyB+/Ev/pPz12OjT6v/5ek1rXsiwDYWApg4s4ExgU=;
        b=wnE2PqAmIrEcAYzY0RDXiSKaeqIcs/lJbyuCOks23bUzgBZicN5PPYnhZmGGu7NnPl
         cOgsklg/4XsNUFhatXBbX8EyAkdoMbf4nqOF6UujufAyU05i2rg0mi6lh8kVU8iyl/ER
         r1EpLcxll5IDgczl/7M/OaSZ8gvE3u8FSeRc7d4v9zxk6BjHmhEs47R0UlBxV/k9apGk
         AO9fAsoPtQZm1Cd5uhBeCswxVKrgByJkwwy00VyUQsB3G/qK/fxB5R/Fw6sBKxTxZhJ/
         5yT1/F24xSN6FOtfCiOn2LZRaYsm8gidzFrrdfDmowufCppmj8ZZ1RD1K3nMnKNGG3rf
         Y9aQ==
X-Gm-Message-State: AOJu0YyjbLtaSthlF6jAeT0DmC0uok4+rwgw7Qa1G5JNacy+JY0t1cBb
        C1YnQwbWhcec3AHi4GuxO9R/hvTYK2E=
X-Google-Smtp-Source: AGHT+IFODvbGy+5mHgTbauKYbDeVhkaGa74fEcBeL4+SqDQx0fxAibKbqr+JvaFyadU0EIGk1Vj1VQ==
X-Received: by 2002:a1c:4b0b:0:b0:402:ee59:ff49 with SMTP id y11-20020a1c4b0b000000b00402ee59ff49mr761363wma.9.1694125218454;
        Thu, 07 Sep 2023 15:20:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003fc04d13242sm3611848wmi.0.2023.09.07.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:18 -0700 (PDT)
Message-ID: <a08d78618bac70c4bc72fa5c88fae08d9ed3ce52.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:06 +0000
Subject: [PATCH v3 10/13] trailer --unfold help: prefer "reformat" over "join"
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

The phrase "join whitespace-continued values" requires some additional
context. For example, "whitespace" means newlines (not just space
characters), and "join" means to join only the multiple lines together
for a single trailer (and not that we are joining multiple trailers
together). That is, "join" means to convert

    token: This is a very long value, with spaces and
      newlines in it.

to

    token: This is a very long value, with spaces and newlines in it.

and does not mean to convert

    token: value1
    token: value2

to

    token: value1 value2.

Update the help text to resolve the above ambiguity. While we're add it,
update the docs to use similar language as the change in the help text.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 builtin/interpret-trailers.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 2d49445b1c3..62ba2b1232e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -155,8 +155,8 @@ OPTIONS
 	variables.
 
 --unfold::
-	Remove any whitespace-continuation in trailers, so that each
-	trailer appears on a line by itself with its full content.
+	If a trailer has a value that runs over multiple lines (aka "folded"),
+	reformat the value into a single line.
 
 --parse::
 	A convenience alias for `--only-trailers --only-input
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f70c5df8d4b..832f86a770a 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -106,7 +106,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.* configuration variables")),
-		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
+		OPT_BOOL(0, "unfold", &opts.unfold, N_("reformat multiline trailer values as single-line values")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
-- 
gitgitgadget

