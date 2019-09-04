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
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E681F4BA
	for <e@80x24.org>; Wed,  4 Sep 2019 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfIDWcw (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:32:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33909 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfIDWcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:32:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id r12so338801pfh.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 15:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNdB5m4iZiRf04slxg1K+gKg6z+qXglVHKL3xS4Wm4Q=;
        b=VBCBDwYKelXYQ5pFgL7PGwemLXmb72GMd2Op3LTL/LTlA595DzotcTaz4HPssf4yA+
         E+ASJyiSMePHSi0o0ev9VhpOTvle+sWENG6Us8qryS7tFugRNWoRHxd8UMQ5vB3iw9G7
         PDVllSBT/WCXM8mgg8STKsqqOXMHyginUFRLfSofmkjzy0mNtfg4pMZQ6/lSYxbU0Iix
         PHFDR2X4ymoh/tt6vl44mGa1WYnx1Qjc72ckIo4xc/WPUCHj2/uq+OPhrpaSa1K0tnPg
         WdP/Y8wld0r/COWoCjZLDLZsyw0vzce3Ve4G+vj0FsosqDZA0iasBoqyflMtW2fX9DBK
         eBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNdB5m4iZiRf04slxg1K+gKg6z+qXglVHKL3xS4Wm4Q=;
        b=eFcjZzP3jQXwG8E/qQBO25KWZFL22LucMssDZMCWV+lc9xRtrKBj+oM5Fl3S/5mdPR
         5RLZOCO2EnIfzy97n2nE/RlXurpoWZaXozFZWl6kQnA5X3zVZcUPUjSjGpI2FGoE1y8z
         y528hrIybAqvYLBHsHS5aE7kP7FXIpTgpwFBn9PQfYjsfxZQHaIcq8gjnpVEj9+cFUMT
         gdGbqkgp0W92PXHqfd7ORwQtTRg809LcDtd8hsFDGHv+vtUHpy9yYUVP7oFuQ+EBpX8L
         WoCoh2+GXsNntUBoxoZBNuyGBddmm1XZImw+nYxyGYZ98Q1PmT+QDIE6M7LAgqEjEcUm
         9/JQ==
X-Gm-Message-State: APjAAAWgdwciQaN+gGnKnIj1e8/3a/USz173UDyZjmRUq0WNK76XH8N5
        NciiBes4NnTEQ6Kfx0NoMuA=
X-Google-Smtp-Source: APXvYqzqvNZh5bU0EkEqBOIEAzlezIHOyPrqZZzPyFGClA2mhpwEhy4qaczxXEFY8BsGGTLRzgj7Nw==
X-Received: by 2002:a65:4786:: with SMTP id e6mr376362pgs.448.1567636370857;
        Wed, 04 Sep 2019 15:32:50 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v12sm135898pgr.86.2019.09.04.15.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 15:32:50 -0700 (PDT)
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
Subject: [PATCH v6 3/3] t9902: use a non-deprecated command for testing
Date:   Wed,  4 Sep 2019 15:32:39 -0700
Message-Id: <20190904223239.571-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g19edb94ec2
In-Reply-To: <20190904223239.571-1-newren@gmail.com>
References: <20190903185524.13467-1-newren@gmail.com>
 <20190904223239.571-1-newren@gmail.com>
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
2.23.0.3.g19edb94ec2

