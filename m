Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88EC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHJVS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHJVSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083F2D58
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31956020336so324032f8f.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702291; x=1692307091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLVdEbBLsQwGTTC+nUkYpJ5KWmtroxiICoNeKqfTQU0=;
        b=kWr5WakBqS4NHGTgYQZpjs1BR+KEYXyRMGedSKc6KtRRwC9e6JQBKRh//ycxMOgGme
         PC/wluE05QFwh72xhGdCMN3/XlLCocVVBcl2ndAOoZgMQEl6lrK6kWoOkp/guY3MCTRE
         bTOvh9GdPV9Qg6tMIR/QQlnpVwTK/WmXoSWKC2fN/g1GQNwEDv2GYvGua3YjPqnhyCGC
         Wsy33q7AB+mXo7j4i5sYPSsPeVR0w7GT/GaltKbHkiU+4WKcv97m2qWi6dm3TtHdkhDm
         Gw5qBhN6qmjpUJQgEvbbpJPbQpmSG2lAzqSg0I1SN+UbgTP2PvHd3AsO1mcQ5OQA+Uqi
         RYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702291; x=1692307091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLVdEbBLsQwGTTC+nUkYpJ5KWmtroxiICoNeKqfTQU0=;
        b=OlMpc6DN9jkWHAQYCmlfAOsVBebck9KmPnsOy3lucvhHaYwqWcUlVqXiQbfwGvdeFA
         zoZKbUkedYrXwyqW5aRGyF/8Dk38W9MRcPqQt93dJbZu/YfMaaB106+FxI3jBDfb/77i
         iAIKp6Nh0r6HpZ6l25gxNnWu3mjSnoeGQIQnYwLExQrjTBE2HzQZtkHj407oun5/Qbd4
         gx58CphbX8V4SZHL4VFQxakfSm4Dnrmh2F62NhSP8f90wu8RretC7vB6ONHe5nT9SXXH
         eYGv1eodea4UmcH8p9a8+izksSAhQeM8TxoI/CxZA6X8e5DqUq5GodLRdWIjWx8FoCeR
         fDJw==
X-Gm-Message-State: AOJu0YwySo3g1Roq6YKe8bZ4dz+QZ6TDWd8QNcsnBY6A5xvp+vhcK8gK
        MyIVYWcnABbpKrI4RribnCOnV385ohk=
X-Google-Smtp-Source: AGHT+IFkxZNPmKyxEDMyQFW20r8YQfKHxho5Tl7jhgnZcQVUi9AGb/ZaeqZOIxg6Hd0jtOcRhLg7Aw==
X-Received: by 2002:a5d:6386:0:b0:317:dcdd:3fa1 with SMTP id p6-20020a5d6386000000b00317dcdd3fa1mr2642982wru.34.1691702291134;
        Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13-20020adfe30d000000b003113ed02080sm3224938wrj.95.2023.08.10.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:10 -0700 (PDT)
Message-ID: <4db823ac3549c031b61b5a0ec0efd56b70d2a45c.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:18:01 +0000
Subject: [PATCH v2 11/13] trailer doc: emphasize the effect of configuration
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

