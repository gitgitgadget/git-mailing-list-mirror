Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A60C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 02:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7E120679
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 02:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpAaC8eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKXCB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 21:01:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKXCB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 21:01:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id p14so9714772qkm.10
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 18:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7gKQ/S45JvSK4JoglTGkuOdKNcTpsO+P7YFAIveLCk=;
        b=WpAaC8eA+wp34L0Y6sp/cXpoaZH2Bm+U4QQyZZpGqRXVmDLAFjvwbky2dRxWvDI4U+
         PD6wY8cJOXD/hS/vhtXTFy2gKpW1jzOGpYJ0EKfskYDMS/gmB0bIaZZltD1KH3zARnZ2
         OGHGra1zQCzbwIcGEtEypzCl5qO/40vwMcKtl9o3IlA6Ja+JiPHYgjEWDVxXq/D1X/9M
         NHfRz7hG3w5ySag5k4cYqIkLfVnbMBb8asdXijfBdkMcADpIiPtPqTzdl5xY4HVyDUch
         TR0RrTPxkYfP7JnmwINRquGB/qtMWzECok0WekKJz7XfhuBc4lputxwE9hLzMoXvDUNO
         vDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7gKQ/S45JvSK4JoglTGkuOdKNcTpsO+P7YFAIveLCk=;
        b=gq4HLmwoWHSijimgVd/txBHxlTEqtXMl4RtFXrwkyPe216heDnzB2WCkKxPBJ0CsvO
         +iAlWJ7+1+hvLGuk1IRCFe02cwULL8TCN1hhgUp1yk+HbRnb/yqiCaHWRWyLQlAjRAvj
         Fuveca5pao2xAeMoIiteM1tycsIdzW0VjxiPPHbjUQ5LfqRKcebctCShsD1RaoJ4w172
         08TaKAYQJialK8OHW/p3JeYQrVtMNCywMQUEhg13uK4lQqI919UGHrxnZ6oKXwuWL8TQ
         7OnMrYRX4NG24He43iC1soWAs5kMISfAPEEcB/vifdfuHQGUZyg9OFvJ5N8Dte+aC/QA
         /nUw==
X-Gm-Message-State: APjAAAUGiVBEsPvVH/k/DR8ZuDUjKhimlXq4uG6UqGQBvHU3YE04QJXz
        GSA1WbmBQBFapIOBN73UsA0=
X-Google-Smtp-Source: APXvYqxEFRnamnhGewKeFoaJObcGuzwVmolQ39UmwucQ7xEQsrq0peP0CcuxySFhgRzPAZGC6ubN3Q==
X-Received: by 2002:a37:4f83:: with SMTP id d125mr13238372qkb.205.1574560916641;
        Sat, 23 Nov 2019 18:01:56 -0800 (PST)
Received: from localhost.localdomain (modemcable059.83-201-24.mc.videotron.ca. [24.201.83.59])
        by smtp.gmail.com with ESMTPSA id 184sm1098893qke.73.2019.11.23.18.01.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 23 Nov 2019 18:01:55 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        levraiphilippeblain@gmail.com
Subject: [PATCH v2] doc: mention that 'git submodule update' fetches missing commits
Date:   Sat, 23 Nov 2019 21:01:35 -0500
Message-Id: <1574560895-60251-1-git-send-email-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
References: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git submodule update' will fetch new commits from the submodule remote
if the SHA-1 recorded in the superproject is not found. This was not
mentioned in the documentation.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes since v1 [4]:
- Added my signed-off, corrected my email address
  and shortened the title of the commit message
  (I had actually done that when I resent my patch in [1] using submitGit, 
  but this dit not add the "v2" prefix)
- Added Junio's suggestion [2] (which was applied in [3] on top of the original 
  submission [4] instead of the revised one [1]), and squashed
- Added Helped-by trailers
- Rebased on v2.23.0 (as was done for [3])

[1] https://public-inbox.org/git/0102016b72a55a7d-fb4ecdb7-9f2b-4204-b888-0000f209c3ff-000000@eu-west-1.amazonses.com/
[2] https://public-inbox.org/git/xmqq8sobdzul.fsf@gitster-ct.c.googlers.com/
[3] https://github.com/gitster/git/commits/pb/submodule-update-fetches
[4] https://public-inbox.org/git/0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com/

 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..4beb569ae5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,7 +133,8 @@ update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--forc
 +
 --
 Update the registered submodules to match what the superproject
-expects by cloning missing submodules and updating the working tree of
+expects by cloning missing submodules, fetching missing commits
+in submodules and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
-- 
2.23.0

