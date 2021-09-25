Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28226C433EF
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099C360F9B
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 12:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbhIYMYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhIYMYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 08:24:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8BC061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 05:22:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j15so6957543plh.7
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Oczm57cMZb1j6uAT/PjxefJ7mmmCFmV3ZCP1zWDpz4=;
        b=nuS/wN7hCmZ0VZfLuEk5ySy4tx8DsILPQSakMITOqzTsQM4DbrcMJZ2x7zrwXBuodp
         patVRnlItray0VedR9Z5fcRkqX0ysVNSlMHUDEB2+pLfFp3i4mePRGJMkuYrxQTXRXhz
         sf8HJHiflPIpkKM27VmRdqhaiPxCK2fODEJ3gHMV9TZKGyMPXDgHLiE92XdmcY7iLB7v
         g7vz7XV2hpEl78SnO2kt8JLFHRvAuS7YYLpxUurvsVtprTT8h3GFsDcDpBSAicUdQAAm
         5BWN/ZPpFH4h9M77R2/EsnygdofYU/ezboTzViir3fFKwRp814+q5beiLIDDBQ8D9eUD
         oDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Oczm57cMZb1j6uAT/PjxefJ7mmmCFmV3ZCP1zWDpz4=;
        b=Nl/nTAvU9AoWyAC14ErWOGbMEkM2fH8o7cpAKAfwvPLgYwmsn7XXHfV8R6DpKorXe5
         11X2S1d7Hxvkc8WW+A5dOsbSAdHwvLkvmK7TwoghPKmA+OMJcCBSwvXtjq0Vwb4CkK95
         zHPySG0I+uNHTJWIjiOMm6wMFhjvkjarsFWPibw1lbe3nluYMqY08xed4AFC2R0tQoEP
         myHYfT63xQh1ZTi1UstQxECWo8DgX8nV0CvjtpUtU2P9M4MkHEj5fZ4JW2WLfnqHyLMB
         //9gDbbH4jm9UJMR3XHcgqPVD0d6CyC79JsVrsaRnkixmvPpPfjcmlRWGu+TVRU6yyrc
         6Ojw==
X-Gm-Message-State: AOAM533I13UKSQBX9zxxcR77L6FxkZWDzQWSwjLBxFV/VayRdoDQllU3
        rriqD7aGyO3NHq+IrCc1M1vEg+6hlhIKwA==
X-Google-Smtp-Source: ABdhPJxLHgX7gpTPmW6pIVXnL+sMJZW9wY1w1h7PIs1ZAxWOExdlRbMBC+gWLiIU2vjnsYo266MM1w==
X-Received: by 2002:a17:902:650c:b0:13d:baac:1da5 with SMTP id b12-20020a170902650c00b0013dbaac1da5mr13927061plk.20.1632572575696;
        Sat, 25 Sep 2021 05:22:55 -0700 (PDT)
Received: from ubuntu.mate (subs09a-223-255-225-68.three.co.id. [223.255.225.68])
        by smtp.gmail.com with ESMTPSA id w1sm1651633pfj.147.2021.09.25.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 05:22:55 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     th.acker@arcor.de, bfields@citi.umich.edu,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] git(1): Define "porcelain commands"
Date:   Sat, 25 Sep 2021 19:22:29 +0700
Message-Id: <20210925122228.1090901-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description before list of porcelain commands doesn't tell what
"porcelain" term is, nor the accurate categorization (because it only
says that such commands are divided into main and ancillary commands,
although there are also tools for interacting with others and trio
reset-restore-revert).

Define the term and say the proper categorization in the description
paragraph.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6dd241ef83..fb6d7d860d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -221,8 +221,14 @@ We divide Git into high level ("porcelain") commands and low level
 High-level commands (porcelain)
 -------------------------------
 
-We separate the porcelain commands into the main commands and some
-ancillary user utilities.
+Porcelain commands are user-facing, high level command interface of
+Git. These are built from plumbing commands and expose SCM interface
+and human-friendly output. Most users run only porcelains unless they
+have absolute necessity for plumbing commands (e.g. scripting).
+
+The following description divides porcelain commands into main
+commands, ancillary utilities, tools for interacting with foreign SCM
+and email, and similarly-named commands for reverting changes.
 
 Main porcelain commands
 ~~~~~~~~~~~~~~~~~~~~~~~

base-commit: 99c99ed8259bf070cd8ae7b51a94904b7cf5c161
-- 
2.25.1

