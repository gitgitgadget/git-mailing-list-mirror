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
	by dcvr.yhbt.net (Postfix) with ESMTP id 73ADA1F4BA
	for <e@80x24.org>; Thu, 29 Aug 2019 00:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfH2AHJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 20:07:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34355 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH2AHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 20:07:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so585091pgc.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGZjMhW9BQHFGamDWIc4N794e5Dwh/84G5afxZk91Lg=;
        b=B4xSBpDrpRgHKS/VSTSQThCMmGvvCXWreNkzeFSAMOgHakRiW4Um+obP/qQhf1SU49
         7t3ZksPmmFnfIGDCxKB8u37z/rzGtOihSdG7e6G/Ro3gxBkmZ5iyqd85G96Sk5PV89at
         HfItmtmzSAe5aym0hGn4oNci9f35mPxCZcnHf8bgsqFc29G5LPouTGhNSkQXL8FSio9E
         NyaTJ6Vjqit2k2LshxaHTzPA8ODnNSsnGxCBX/8WUqQTRz0YPQjQQhbhKB6/t9R24IeC
         5O+DZvcch2g7hpAoYaDICeliuaml/1/nU+VB/nX8kwoAd+OwLXWgYrB0iuI+rc5CzJEG
         Uezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGZjMhW9BQHFGamDWIc4N794e5Dwh/84G5afxZk91Lg=;
        b=TAKftrD9WNTK90UVx0zNzTl/L/hLy9iHrMRsFpWlQz/IbQBmbXLXJvyzMamrq89mL5
         NWKkBetq7pmlSATKnN9v16DEP4SxHYGjEW+ibU4Eyu+G0yI5pQcZVVzXL2MQ7nF7QWgs
         a5adR1nlDAiU+tpTdRv/zvWi+VhTx3fQCepZXRUsQ8UtY3g3HIpb7VkCJ1nnQ73vAmCJ
         khhN146cwE9FsLE0uAbnJ8sQDkZSAzmG3sKXSd4hZ+lrqToUWcEVbgiPx2iAPjJyx5ct
         t1AlqeswzlRV7nYC6gHCkTyKxqktkvQqzLO7jZAsX+fUSJzCf3EBWq6LOG0WwShLYbd4
         K0Mg==
X-Gm-Message-State: APjAAAU2BaCecXkCOgoAVC309fxR3kgw5wlnp5kii/gHLoXwonhpl9Ao
        fyAMOL8EldFKeB3KgM993m5PKHGd
X-Google-Smtp-Source: APXvYqwW+S0G2eb469BSH8qn2o8sHir7zlY9IxQT1NilOxhQIbH9dtW7h3rotvmCtvvctXhK0+TDew==
X-Received: by 2002:a63:f304:: with SMTP id l4mr5741131pgh.66.1567037228253;
        Wed, 28 Aug 2019 17:07:08 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id m4sm305531pgs.71.2019.08.28.17.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 17:07:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 4/4] t9902: use a non-deprecated command for testing
Date:   Wed, 28 Aug 2019 17:06:57 -0700
Message-Id: <20190829000657.26415-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g59c7446927.dirty
In-Reply-To: <20190829000657.26415-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190829000657.26415-1-newren@gmail.com>
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
2.23.0.3.g59c7446927.dirty

