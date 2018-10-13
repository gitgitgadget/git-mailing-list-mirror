Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE6E1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 08:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeJMPrV (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:47:21 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:35521 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeJMPrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:47:21 -0400
X-QQ-mid: Xesmtp6t1539418263tga15jkg9
Received: from localhost.localdomain (unknown [218.82.50.250])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 16:11:02 +0800 (CST)
X-QQ-SSF: 01000000000000F0F5100600000000Z
X-QQ-FEAT: Ngtn/3KK5epdAwBfj58j8dRKXRi/BLlLTlGgLC0pGJVebl8WmVcwq5vaz0Kgr
        rftP1s+mQrDWB1/AovDNdEiRpxLTADgsw/0EF8wM+YdgkdrpoTLh3JQ2+8ixjgKVXEGIa4k
        CUcYn5YC7eOv8WKakstz9HQY4qlf1cg/UBCQ5ORa493aHSVMy/tpxsI/QyB+Ld4RNUm+xwP
        Evst1gE4wEJKUKl22nEMbYTLEi77H3BMttEIVmQoMQqjEnwYPNw5LjMTkOqlg2zHm0kuhcu
        IVNN+K5VTuKyc1
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     git@vger.kernel.org
Subject: [Question] builtin/branch.c
Date:   Sat, 13 Oct 2018 16:11:01 +0800
Message-Id: <20181013081101.6602-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:ls-a.me:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I am learning `builtin/branch.c`. I find that it will call `branch_get`
before create and [un]set upstream, and die with "no such branch" if failed.
but `branch_get` seems never fail, it is a get_or_create. Also, it was
confused that getting a branch before it has created.

builtin/branch.c #811

    } else if (argc > 0 && argc <= 2) {
        struct branch *branch = branch_get(argv[0]);

        if (!branch)
            die(_("no such branch '%s'"), argv[0]);

        if (filter.kind != FILTER_REFS_BRANCHES)
            die(_("-a and -r options to 'git branch' do not make sense with a branch name"));

        if (track == BRANCH_TRACK_OVERRIDE)
            die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));

        create_branch(argv[0], (argc == 2) ? argv[1] : head,
                  force, 0, reflog, quiet, track);


