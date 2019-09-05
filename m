Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE3A1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfIEPru (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46876 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbfIEPrt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so1993993pfg.13
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlQc7CmT3RDD9vt6BSyxrPkfE96V55LflbfO0LsQ0Ic=;
        b=iyK7GZUql3rNEZJp0eIiCKiU7Bj8mU5amG1pJdUxcmHpOpA5fLhze8nHIcOSa6cJzZ
         HaYisCUHj0qS6/hvVy0BMCfxV9TTpIM0rxR83miAHRymVhqoSobSN5TVojKieEGZqPyl
         Ai1omZ3R7+dInQWicLsZaZZKakfEQEekQvDA4dC4kGKGNZwEKEQ3GNRQekRhiU19s9Xy
         n66DYr7ub5QMTPqfDWKiIYzTM3eecqUM/NYKwUQiDxVz/Rd+bjSH6PaaszutNupJR2of
         bVA30FDeNgKx23JAsD4eWCA8z9VLf0z1hQ6S5kaGXzl8k3/AaLrA8A98waZOv+ufagnI
         WZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlQc7CmT3RDD9vt6BSyxrPkfE96V55LflbfO0LsQ0Ic=;
        b=YJnvOr/cEKxP9x1RHIgOGeqaYDqeYmOHGREElJmX0eT5evzJvk8S4NbJ74xLr6zzcl
         2U2NvevHqirByxa7v7amUWgF6StrcaL8DoevPq1CUBxhPrKA6chbDEG3AaTWrMgeC6u0
         6oZOMwuYFgmjeQJREzdn9u+Hqy+S8XAMMnldYhjZkKOORdLKBGjrCE0xgrwVPveR47xC
         XFK4H5A1cON0L5/Dboq8VIIvVRR95S8npM6r5RpW59sOhE3v+0nXczTU1+eYvOuOXvdl
         O9+8Npbdo+dVyp7zMGdrTdOvHCptPVKNUZ38FwUKYzOoWMcd2DgnxkFxFYaSlPDQW7r1
         BwlQ==
X-Gm-Message-State: APjAAAWsXNin86QPh8MwIQjuJvyTFPKsC3fDXrF9tIIrG+KppWgIAP8l
        dvfhoUa23lWrbKbtpubGXXmjQBNC
X-Google-Smtp-Source: APXvYqygI34Jlg004Xfm92wZlt+zFh2ZpWfiBVG0eXweDaqhDltxRNEUGuLJSG0kknv552/+hoCEkg==
X-Received: by 2002:aa7:86c8:: with SMTP id h8mr1397572pfo.241.1567698468786;
        Thu, 05 Sep 2019 08:47:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 08/12] git-clean.txt: do not claim we will delete files with -n/--dry-run
Date:   Thu,  5 Sep 2019 08:47:31 -0700
Message-Id: <20190905154735.29784-9-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears that the wrong option got included in the list of what will
cause git-clean to actually take action.  Correct the list.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clean.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index db876f7dde..e84ffc9396 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -35,7 +35,7 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f, -n or -i. Git will refuse to delete directories
+	unless given -f or -i. Git will refuse to delete directories
 	with .git sub directory or file unless a second -f
 	is given.
 
-- 
2.22.1.11.g45a39ee867

