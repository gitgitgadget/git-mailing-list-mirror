Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A711F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeF0NZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45061 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934033AbeF0NY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:24:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id i18-v6so1561293qtp.12
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IhgnBByzpJ5V1d7SqPb0SmXrUGVYvVVF+vW7u95LoZU=;
        b=a1PUEvGt3h6TKYAHvW2yxpZDsb095sDoZh4YNYqOKQBi7Ww0cH5y/E2nbxrqwtmoBE
         l1ZePXUB33u4qOATM2LKcEJZdF/d3iAxj/z29NI2ZL3R+G+t1EbvX5gSw5mDkduzPGhJ
         jjpY/KoorPSHXibL6MC0o1V5zlsuUzPYdERpLQj/f/JaQcNv/I4RfUO7UwMT/z9LFhbA
         ppXHybpVwS5Pxm+pkoEx2CPi/uzHsp07e2l0eo+9fU6YOvadEA/XPPclSo5WuOKJg6ER
         9zMGI+Vi+4HQipkhw9I2LlVkKpH6PluPuY4MWZ7e3aZQHo4iGwOAZ9S5nK7JPSmWON5p
         Irpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IhgnBByzpJ5V1d7SqPb0SmXrUGVYvVVF+vW7u95LoZU=;
        b=FmWkWanAxsvnFFtu+9XPoF71BVOwA8LxbFPtPq+gLa+paEzKewSQXW4HrVj46mA81U
         GAWLrvUSZH13MRBqaIlZXkG6C0y3PQY8TTc9d2fqdr1lwSzrgKDlc4Gp6NaBN+lSp4Ly
         o9BfruBW2pjuCgpub+p1Iq3jclJJE85jNu7CdvYduYHsZMyRR+zgzXvrLLD59OMJE60v
         FyIZNqCU4aflwnXA20MJXV9BKGyIS7W/DUtRGnKSXDnTMMjj7MG0BdPp2blqkGla9KIy
         CgXofKMulzIPQLq5Pe/PzIOhvX/f7Q8a8akxf8aK5O6gAPBC6kWWG7hEsXAaxfTHI4AZ
         S4Yg==
X-Gm-Message-State: APt69E0MUx//4Bhk3jZwEwCRwX6lgdINZsoLXHFlQ26b7cPTpFPNYQjr
        fvYsQirTM4h9A4iSo81Y6Kjenc726xc=
X-Google-Smtp-Source: AAOMgpeVQq46P69spq6glNcJkjR+W5cj1rGffPlWeSVIUe7b5XgybnYpkKFJboZ4CzO4lMpmtpIYdQ==
X-Received: by 2002:aed:35c2:: with SMTP id d2-v6mr5267792qte.219.1530105898958;
        Wed, 27 Jun 2018 06:24:58 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:24:58 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 01/22] t5318-commit-graph.sh: use core.commitGraph
Date:   Wed, 27 Jun 2018 09:24:26 -0400
Message-Id: <20180627132447.142473-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph tests should be checking that normal Git operations
succeed and have matching output with and without the commit-graph
feature enabled. However, the test was toggling 'core.graph' instead
of the correct 'core.commitGraph' variable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Junio,

I sent this patch as a one-off a while ago, but it seems it was dropped.
I'm adding it back here so we don't forget it.

-Stolee

 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 77d85aefe7..59d0be2877 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -28,8 +28,8 @@ test_expect_success 'create commits and repack' '
 '
 
 graph_git_two_modes() {
-	git -c core.graph=true $1 >output
-	git -c core.graph=false $1 >expect
+	git -c core.commitGraph=true $1 >output
+	git -c core.commitGraph=false $1 >expect
 	test_cmp output expect
 }
 
-- 
2.18.0.24.g1b579a2ee9

