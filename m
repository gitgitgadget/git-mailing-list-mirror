Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E051820248
	for <e@80x24.org>; Mon,  1 Apr 2019 20:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDAUwA (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 16:52:00 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:43599 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDAUwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 16:52:00 -0400
Received: by mail-pg1-f182.google.com with SMTP id z9so5354243pgu.10
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9gqnsFc8EXx2L2TI7f54kgpVmhmVc09dxcAuCW7IF8=;
        b=uNjYXHWt1fhTCIVMFZ0wi7HUVh21xZmZp67208MUXUPmEodk8ZJcVMukbd2HrbTZys
         oBYE3coUKshMNx65zPaDPXzRRxyOjVHno+pT6t697ODr3Cq9TTYVwuVxqPUriKJM9HQX
         ROPNm8MLkyOB74tR63OmQYBivxz51ujRXpPOHsR/eYvhjLHiNI8Tla06mdxcIYjVtAFe
         qDM1ONSad4m8JJCNExQBTghPNGfR5c4nBOIIEY53vJAvVyCA5f/itaTWottjV0x474ja
         NULp+IYpQPGWOUKyr07DQN/C6m2xMed3iBfYL4x9K50+SZfOl2LTek5EZq05H2E2feqP
         fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9gqnsFc8EXx2L2TI7f54kgpVmhmVc09dxcAuCW7IF8=;
        b=k2kP4jWhJ9r5aTKpA14BMwOGArhjHhh2+fYq5I/WGJxugC7vRnrI6vd8BDAwkENL5K
         HV3USYSEizMTZnljSeK9R2vMB2RtSEfT21/dzB1UMpRhBI4/LjsNfBOc6fVZH3NeJKrz
         TqKZs/+GNjnmJ235fff9CxG5HXPQP/nqnUlFWQycCwoAnu1FIN1s852CjTBXbEjniDjp
         MUHfsot1a5TnwQmOU7Jo8b6rmbvFFHaRjQ04GU0uLpD8okayPZ7tSRgdjkePivIRZKQu
         ypQO6zkFE1rInYjQqkW2neCgHKR0rdjEpwcx/gHa6cC2UCIOg3It0/b60h2UFsqbbjmO
         1Tfg==
X-Gm-Message-State: APjAAAWjDlxILegR5VQFS/EaEYZ25g3+Hojt6s0Rkp4mPd6Ls22xpNjG
        fv2ygzsVV0yH5j8zRg2WJUu7GRrE
X-Google-Smtp-Source: APXvYqwRztB09gpxaIM/BK1YvmrUlE+BQUhEyccM9AMSrrpaYyPNbO7QUGtiAN6tuy9gmat/N2E0CQ==
X-Received: by 2002:a63:158:: with SMTP id 85mr63612100pgb.351.1554151919053;
        Mon, 01 Apr 2019 13:51:59 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id j19sm9608686pfh.41.2019.04.01.13.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:51:58 -0700 (PDT)
Date:   Mon, 1 Apr 2019 13:51:57 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 1/4] t3431: add rebase --fork-point tests
Message-ID: <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3431-rebase-fork-point.sh | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 t/t3431-rebase-fork-point.sh

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
new file mode 100755
index 0000000000..8e2483b73e
--- /dev/null
+++ b/t/t3431-rebase-fork-point.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='git rebase --fork-point test'
+
+. ./test-lib.sh
+
+# A---B---D---E       (master)
+#     \
+#      C*---F---G (side)
+#
+# C was formerly part of master but is side out
+#
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	git branch -t side &&
+	git reset --hard HEAD^ &&
+	test_commit D &&
+	test_commit E &&
+	git checkout side &&
+	test_commit F &&
+	test_commit G
+'
+
+test_rebase() {
+	expected="$1" &&
+	shift &&
+	test_expect_success "git rebase $@" "
+		git checkout master &&
+		git reset --hard E &&
+		git checkout side &&
+		git reset --hard G &&
+		git rebase $@ &&
+		test_write_lines $expected >expect &&
+		git log --pretty=%s >actual &&
+		test_cmp expect actual
+	"
+}
+
+test_rebase 'G F E D B A' ''
+test_rebase 'G F D B A' '--onto D'
+test_rebase 'G F C E D B A' '--no-fork-point'
+test_rebase 'G F C D B A' '--no-fork-point --onto D'
+test_rebase 'G F E D B A' '--fork-point refs/heads/master'
+test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
+test_rebase 'G F C E D B A' 'refs/heads/master'
+test_rebase 'G F C D B A' '--onto D refs/heads/master'
+
+test_done
-- 
2.21.0.695.gaf8658f249

