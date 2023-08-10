Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97139C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjHJVSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHJVSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84E2D56
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so11582015e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702290; x=1692307090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fjyB+/Ev/pPz12OjT6v/5ek1rXsiwDYWApg4s4ExgU=;
        b=LWMl3Xfm9BviYUdW/fbtQ8XRUiJkFVrqwYnlUXV02/VC6q9kxhY5fbd0xZNnky2iWx
         tAhBi0yrPLPHDbYmBSQTt774FRxsHhL/lwpBxBnuxGXZdU0ApbpuIFOxe0haAMDazsB4
         0W6O49NqDPZ7W2YZv5PiccDN31VWb9ehnBJ4efcqw0CTXoW1ihUM+gtNMNyk2vVJtbFA
         z3uwO1AAjToGbSxDbwnDuwI7d7pUFuxxRlSO6hHYIEy7G8xvSEsQGkmb5Ep1ecK6bgJM
         u6Qr6vRiacosUei+4DuwIsDD7YpbGMDUOoyXWNEND1RR+Cev9lwsxH9QUmhfe5NBj2sJ
         w+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702290; x=1692307090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fjyB+/Ev/pPz12OjT6v/5ek1rXsiwDYWApg4s4ExgU=;
        b=ktwwYDsBxO7yij5odJS4ziTN5FeeARsBrQ3Jrt8guSOQo9weobEkzNHrkZalqFNREp
         9noQUQJChDieG9FSbXzQDuxhh47uGZPxwqu6dcJhHgHYuA73RmxcnmJfIms3xTnALIxQ
         YmTo7NedEzCDyy5HKHIkxFKGvS7TMFuTuZ7hFwcPOGFz8700VcFb2WafjpUI+DYHxTZ9
         TwiBwnCJyqcaoNrNYCIMaHFkJ+IMuiWOh3B99cmA2ypxEeqhh4hozAA0hdO+4wSsXRhi
         Fds+/RLbP8tPcSTybdRnzFXz+AfnpvOqF281MI8NhxPvC0FYrK1S1i+ET6J8CUve7/87
         yW8Q==
X-Gm-Message-State: AOJu0Ywt1YALHF5FkkoFgRtchq/p6hvjl1pvT/sq1tRP7K3uJ9lDK0I4
        SAZFembzKUHxl4LaojzVF7e9FCDBMG0=
X-Google-Smtp-Source: AGHT+IE56mq3dwD0or8LcyIhde9dGfO/Cv2xd8qfwsZvmPnk6mpDncjAZ8SexMHFXIhQn8W+dcFqeQ==
X-Received: by 2002:a1c:7703:0:b0:3fe:159d:422b with SMTP id t3-20020a1c7703000000b003fe159d422bmr32115wmi.32.1691702290474;
        Thu, 10 Aug 2023 14:18:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fa95f328afsm6114059wmr.29.2023.08.10.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:10 -0700 (PDT)
Message-ID: <a08d78618bac70c4bc72fa5c88fae08d9ed3ce52.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:18:00 +0000
Subject: [PATCH v2 10/13] trailer --unfold help: prefer "reformat" over "join"
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

