Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC31C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435E2613F2
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhEMVnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhEMVnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:43:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA62C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:42:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z17so9127657wrq.7
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WG0qe+gSoETGL9i0P2oF/y1xtJUpL+hsWEBG2Bdy/c=;
        b=Gl/0p1Hw+3h/hQQL+3CX8V+cuKTkA4Jktm5mwJqlpQgXRlGA53JaC3jVyU2VNJ+22C
         zuJnECDrm1EuS5gfMnNYNbEpta23zow1255t/mlWMaYg0HBdSG1SK5qKjlhMf9YtRYEY
         p4iZ+XAwPXdofQ5LAZnO+dbvfsFA2j967Ye25Pfe52yVm5reI+4dpny3jHFHV4tGafBE
         eDontg6GPytGs8b/Suffe3NQ1D1I6XjHG3FEoez98LGhh8F9wxWDs2v17yTcfgGvuK9T
         c8H9b9mbwBU0KNadmIcuKQ6mOEFnJpfrMQ8BUQqUQLjaFHXaxB851NQbSd3t1+yW0NjV
         oXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WG0qe+gSoETGL9i0P2oF/y1xtJUpL+hsWEBG2Bdy/c=;
        b=WuJ/fReo6naydm3Ym3emNUHwoz46ZMrWGQ6YbEWYCGawOELAM26HjLY+N/gdRW/eD6
         Cxl/ZczD/O12Qb26hSsVWyx/9PBxg0OIqqYGJ7jPnB0Bf0aG6GFfEc49kYD16JqCYY+z
         609MCuIyaH8HC80Pu8+e8cmFX4PzERprFAsj8weg4Z6RUeg0WxcYUVkzm9EEf4z3Gedp
         ffnFimr5qPlZhiEfY2b7+6M09CWb/rh5OoYJGhHVlUjc4ldNZ0bJoR+7PZ7k9E8V8FMu
         t9CiA7ajsBcGkOM4c79GFlqAqxREGf3yVeQT3glrNM+DY5qlDLAzYmdXja4I1onJG2x2
         qJHQ==
X-Gm-Message-State: AOAM533ar4OIAEzMqi0freeAcZReEAhNII4e1pXY4zCjbQvBaURMPBfd
        N4W9Q0X3tYRVtvQTZ54iq0oTrnTyvecJDQ==
X-Google-Smtp-Source: ABdhPJy0t5QRJ+/jkPmf8anAhrnwRMmQSBRhCrW7dn6XrwIX7rJRiXyJ7c56pK+T5Hk8Y9JSm2YJRQ==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr55164625wri.260.1620942119386;
        Thu, 13 May 2021 14:41:59 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001c07d070726df7f9.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1c07:d070:726d:f7f9])
        by smtp.gmail.com with ESMTPSA id p14sm4273606wrx.88.2021.05.13.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 14:41:59 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] prompt.h: clarify the non-use of git_prompt
Date:   Thu, 13 May 2021 23:41:51 +0200
Message-Id: <20210513214152.34792-2-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
In-Reply-To: <20210513214152.34792-1-firminmartin24@gmail.com>
References: <20210513214152.34792-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's really tempting to use git_prompt to prompt user for input, but in
most of the case, we must not [1]. Reflect this as a comment in prompt.h.

[1]: https://lore.kernel.org/git/YJTH+sTP%2FO5Nxtp9@coredump.intra.peff.net/

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 prompt.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/prompt.h b/prompt.h
index e294e93541..90eb3f08a3 100644
--- a/prompt.h
+++ b/prompt.h
@@ -4,6 +4,16 @@
 #define PROMPT_ASKPASS (1<<0)
 #define PROMPT_ECHO    (1<<1)
 
+/*
+ * This function should not be used for regular prompts (i.e., asking user for
+ * confirmation or picking an option from an interactive menu) as it only
+ * accepts input from /dev/tty, thus making it impossible to test with the
+ * current test suite.  Please instead use git_read_line_interactively for that
+ * purpose.  See 97387c8bdd (am: read interactive input from stdin, 2019-05-20)
+ * for historical context.
+ *
+ */
+
 char *git_prompt(const char *prompt, int flags);
 
 int git_read_line_interactively(struct strbuf *line);
-- 
2.31.1.443.g67a420f573

