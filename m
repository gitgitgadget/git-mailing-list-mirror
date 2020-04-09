Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE64C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15120757
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8EWoiND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDIKgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:36:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42600 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIKgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 06:36:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so10869360ljp.9
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyYQgT+Z7a7TELrg64gMiklHEmWC8Wt5LZyxyKrmcGY=;
        b=W8EWoiNDeekWFCVXP0WnTx6NAPCG0puDaGEwf6XMNjNsn2UiqRTCnNLjc+mJHedVkR
         xo790N/Y181SAKePvjSsuK/J6gNmHqGQoGul1kHg4+6jQW+ZQG1u41Lb2lkjrw3LoYyX
         cY9yY62QG/YWwZS38PEJK32DB3JLtqL4uxgK6tm0ctKX8qKm6axyJ4pl+8+cUTGxHgb4
         fuzn3eAT6rI8siKHxa/1lFygRynIPHPjP/Dh5E+GA6ACUfvlsS0sucfJIVuwAwYzg0LH
         pHSiDbuLfW6NoN2+40wDTkehCqk6Tjm+D5axe0JUdD/AOfcEQg16y/YH34pmAvP+3kmF
         OP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyYQgT+Z7a7TELrg64gMiklHEmWC8Wt5LZyxyKrmcGY=;
        b=kxFExWd8EbC/rI09ZSJ4z1VTD5/v8xuE6DhAWygP/Iea+BNsuTbqlzg53IEd9nEkPW
         BOAZgx+Drjh61Imi14Po4EMxJ0ODVxKSgXqGQLGfaF3iAMXSmWkIDL0ap2Qs4OotCDP+
         qppDssD92xEIVZdywbPIx0cLObpMi42RzICqkygEPMomYDLgW4oczFfDnc6e/j+lb8ZO
         jSl0o/ZHgjpVjDwU9z1ZCs107q//D4gwiX/dldzx5MpUE0gg7ADRQ/WvDde67wl9bwQP
         bDhhM9TbHL06wb3yDsPXid9mEqdzG8pQZW1LqHdOkBkSCh0fEn00kk9uOaOGAdF55mnG
         Rzgw==
X-Gm-Message-State: AGi0PubTFXzplncLIDbsQkkJtyaB4vkTurYXiXWASP0aIKJDOWD1rGlu
        lU3L9QfA1UeXnc6LRfXJhpnwbWuc
X-Google-Smtp-Source: APiQypK/y854AQpJ6ZOEXmmbPKSJ/nLnU6BtbGRhz8N1JkXh1zg9UX7oMb3Cc2vGx3f9SYpIst7KUQ==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr789543ljo.218.1586428573033;
        Thu, 09 Apr 2020 03:36:13 -0700 (PDT)
Received: from localhost.localdomain (host-189-203-22.junet.se. [207.189.203.22])
        by smtp.gmail.com with ESMTPSA id b26sm14607137lji.8.2020.04.09.03.36.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 03:36:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] config.txt: move closing "----" to cover entire listing
Date:   Thu,  9 Apr 2020 12:35:41 +0200
Message-Id: <20200409103541.23743-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 1925fe0c8a ("Documentation: wrap config listings in "----"",
2019-09-07) wrapped this fairly large block of example config directives
in "----". The closing "----" ended up a few lines too early though.
Make sure to include the trailing "IncludeIf.onbranch:..." example, too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Not sure how I managed to botch this in 1925fe0c8a.

 Documentation/config.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2450589a0e..74009d5402 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -220,12 +220,12 @@ Example
 ; affected by the condition
 [includeIf "gitdir:/path/to/group/"]
 	path = foo.inc
-----
 
-	; include only if we are in a worktree where foo-branch is
-	; currently checked out
-	[includeIf "onbranch:foo-branch"]
-		path = foo.inc
+; include only if we are in a worktree where foo-branch is
+; currently checked out
+[includeIf "onbranch:foo-branch"]
+	path = foo.inc
+----
 
 Values
 ~~~~~~
-- 
2.26.0

