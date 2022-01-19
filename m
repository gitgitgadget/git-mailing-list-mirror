Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB0C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 09:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbiASJpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353139AbiASJpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 04:45:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5C0C06161C
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:45:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c9so1607392plg.11
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IkmeTjWkTJMR9Lfv0GYdR71nAA52DYS9Xw5HKdfNQX0=;
        b=Z+Fg8napZzBA/887Yywboz0dywzdaOnlvPiq8SaXiYKmxF/lCXEzpLGLZ84Quj9h3E
         V10BXdYzNMH7PWHLs9fmyJr5yv2xJ1WToIHmfgMn4i9w7+OztDNloprHdOO0C2+qdFRE
         L/vd7xKiHmV4VXT3oHszY67jQCruBUmEoxFLQDzaEsV/j7AnvHS+4RsDTgJccK5WVuvA
         MzaAcux1AUyKqp4Nj/u5F7vY8e57ju+pxeJr96gn+sGcnzFR2qvQNAwus6X6Zgki/NqE
         D/J7FOt14cE6ptEtFZnl2PI6fq6wKexPn1Q6TAz7WPh18yslugIJriGddSI014C14Z5A
         pnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IkmeTjWkTJMR9Lfv0GYdR71nAA52DYS9Xw5HKdfNQX0=;
        b=B8KqLeaoHmckbOV2SNGPxmv9MfcciZqx/Un7JgKz3h/8Dx3W+2RnwL8kmuZaPnvQRf
         VyqGSBnkwbpT1JkfRXJNNoqGLNKTF8iD99hIacGLjcHg3JOYEeSzsdOP/pl6WPsrx4ZR
         ZA5b2p+5wEQnh7Fzb88r5y/0HQDFQNUxaaMStCUaj5ztpOunx0wwiv04JU5NClB5m1W8
         nKW7qSc9qMdfNugMDKAhzqJyj/Sl4p2xCRzVUbKndWf9plTl4d5txGwzI3WOCWhyQaJt
         MmxebtsP5oDZGJsS2Yjo4+lLq7ZPlNl8hJmeAaOPlAVzp/K5saZQQ3vo1Vt7Q/PPDJSv
         PcLw==
X-Gm-Message-State: AOAM531oDTnCeRXZwcsFzrBvRGz2Oe7GBsQ+WjHEeBp2TbBSP4OrB8YP
        WqHjVa7mP97sN+RDxHK6bRjyH15ja1I=
X-Google-Smtp-Source: ABdhPJyxXtXvV4r8+etWD96p9PRjuFtgsI4puW6NUzsgK62MhL/RvapCoNWCRdgsWy20sEgq+eQi0A==
X-Received: by 2002:a17:902:dac6:b0:14a:7b85:2350 with SMTP id q6-20020a170902dac600b0014a7b852350mr31494003plx.22.1642585503085;
        Wed, 19 Jan 2022 01:45:03 -0800 (PST)
Received: from ubuntu.mate (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id b9sm17035350pgb.17.2022.01.19.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:45:02 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] advice: refactor "action is not possible because you have unmerged files"
Date:   Wed, 19 Jan 2022 16:44:45 +0700
Message-Id: <20220119094445.15542-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119094445.15542-1-bagasdotme@gmail.com>
References: <20220119094445.15542-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor action names (cherry-picking, committing, merging, pulling, and
reverting) out of the message string.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 advice.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index 1dfc91d176..4c72856478 100644
--- a/advice.c
+++ b/advice.c
@@ -175,15 +175,15 @@ void list_config_advices(struct string_list *list, const char *prefix)
 int error_resolve_conflict(const char *me)
 {
 	if (!strcmp(me, "cherry-pick"))
-		error(_("Cherry-picking is not possible because you have unmerged files."));
+		error(_("%s is not possible because you have unmerged files."), "Cherry-picking");
 	else if (!strcmp(me, "commit"))
-		error(_("Committing is not possible because you have unmerged files."));
+		error(_("%s is not possible because you have unmerged files."), "Commiting");
 	else if (!strcmp(me, "merge"))
-		error(_("Merging is not possible because you have unmerged files."));
+		error(_("%s is not possible because you have unmerged files."), "Merging");
 	else if (!strcmp(me, "pull"))
-		error(_("Pulling is not possible because you have unmerged files."));
+		error(_("%s is not possible because you have unmerged files."), "Pulling");
 	else if (!strcmp(me, "revert"))
-		error(_("Reverting is not possible because you have unmerged files."));
+		error(_("%s is not possible because you have unmerged files."), "Reverting");
 	else
 		error(_("It is not possible to %s because you have unmerged files."),
 			me);
-- 
An old man doll... just what I always wanted! - Clara

