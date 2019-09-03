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
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B861F4BA
	for <e@80x24.org>; Tue,  3 Sep 2019 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfICSzh (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:55:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42394 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfICSzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:55:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so8251787plp.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDfzBQ4yMY7wrK25OdUzD9w7Eo0VTBNSqL//XYlgdbg=;
        b=LhZznwK9hhiyfhQrmkjl27pO7QBYSpjdyXEL0EZJs+xXiq/1S530FNfxA3Nj2s0ZwO
         O/PQjGNqUcWpJ42a9TOo2OEIaPRLC7LkIq7k0HWEiodrmOz9KlFBA6KPeyxw7OGsVPvJ
         98zMntMfqnZDbLRJc8JQCZnYFem9TlC9HvQBYEjXs1MwW7q5CitK4t4DtkCp4uBj++KC
         h3bcunYWpB2rTiKEs5vPxzr5CZLpxPmzT4GwUkTk0CH83kZn/is7h4OQ26bEK4aecgBM
         e/v17/Ejk7qfMIESnCfQPePlrrKS2fuNrHplqvLplf1nPMwwm7icoN2iSD+9XHYvVVS+
         C5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDfzBQ4yMY7wrK25OdUzD9w7Eo0VTBNSqL//XYlgdbg=;
        b=mRihmriNTuoJM+H/5N66aekGqFTGid8N7ySm57XX4PxEMMSJkGBnaEJJvTmcj7Ax7f
         JbAnVSHOdwaqIEzoYOTwXM1lmz2Z+A6v6IdCa2G96OozfiI39CmyW4ikFUJWXY8781PF
         EiUpyJVGgMW8yxaU/TDX88TCKOw07HFawel3RpA9e7T89i8iH934sfa6fx+e3VQb1lvD
         kIwqWcHpMqgD4pNjknf34cC6j5FpOXL8FUdkGz7nCgNoKIYomaDqQKzWpUEfjDsEXa+S
         vjbEedC891LbsJCyV/7rYCyUNLwSkm+y8OZK1EN7hdLWUmAeqwIri7O9y6sAnhkFgfv+
         gQkA==
X-Gm-Message-State: APjAAAVLmUwcreMz7JgVlH7tXWOtJlhsj0SYZ8RLH/9IAvHUOamhaxGW
        oHCLdPkjlZNGUFXfV19ZST4=
X-Google-Smtp-Source: APXvYqxfh9Zf2dCo4dyBFAsGG4goVtPFnWC6e94W/K2cwonQBpa8CYir7SeKZRqUoplkmPkcHDAMRg==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr36041837plz.90.1567536934593;
        Tue, 03 Sep 2019 11:55:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 136sm21283855pfz.123.2019.09.03.11.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 11:55:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 4/4] t9902: use a non-deprecated command for testing
Date:   Tue,  3 Sep 2019 11:55:24 -0700
Message-Id: <20190903185524.13467-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.39.gf92d9de5c3
In-Reply-To: <20190903185524.13467-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190903185524.13467-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t9902 had a list of three random porcelain commands as a sanity check,
one of which was filter-branch.  Since we are recommending people not
use filter-branch, let's update this test to use rebase instead of
filter-branch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9902-completion.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 75512c3403..4e7f669c76 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -28,10 +28,10 @@ complete ()
 #
 # (2) A test makes sure that common subcommands are included in the
 #     completion for "git <TAB>", and a plumbing is excluded.  "add",
-#     "filter-branch" and "ls-files" are listed for this.
+#     "rebase" and "ls-files" are listed for this.
 
-GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr filter-branch ls-files'
-GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout filter-branch'
+GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr rebase ls-files'
+GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
@@ -1392,12 +1392,12 @@ test_expect_success 'basic' '
 	# built-in
 	grep -q "^add \$" out &&
 	# script
-	grep -q "^filter-branch \$" out &&
+	grep -q "^rebase \$" out &&
 	# plumbing
 	! grep -q "^ls-files \$" out &&
 
-	run_completion "git f" &&
-	! grep -q -v "^f" out
+	run_completion "git r" &&
+	! grep -q -v "^r" out
 '
 
 test_expect_success 'double dash "git" itself' '
-- 
2.23.0.39.gf92d9de5c3

