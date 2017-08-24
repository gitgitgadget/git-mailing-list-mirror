Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082FC20285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbdHXTvW (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:51:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38370 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbdHXTvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:51:21 -0400
Received: by mail-pg0-f66.google.com with SMTP id t3so634270pgt.5
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Dj95X4Iq7i7bvLvujv91yfVciPF0QpurVMpclW1kmg=;
        b=dGaKvrp+CfE9KQQEywcE49OFwGXl7y6B31t8EKsH0HGYbSeLL4vKy5WCeJ7wtvm/tA
         4zgcfO8F8v0M21iyp4VzoaxTUzT9dlcsSdrKDUWgnLhjx/a491/8jLQ/xorQwEdhuBwN
         2M3UU/GHl0zvC4XhNet1R2BEULwhUQ0mmmEJsM7bRUy8Gkbx2Cv3+fpC2nP5CUHt0Ih5
         I7H4WNIwfc2A9vkoKShElqHExkSW9EcNL++aflXA0dPLaFQrUIGxBo2uw2Ewt/rsX6lF
         OcMaqgJms89ENU8pO8/x2gxWi2GZ1wObXPaqzC+rpy2ROxaijHN8qc1+ooi+mQOIuoAk
         Q9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Dj95X4Iq7i7bvLvujv91yfVciPF0QpurVMpclW1kmg=;
        b=d2PjRdAZnNyYud4va33lWTs34wk6Pao7mEFTLAW+76YkqOwI3voiVARx8WTnXMs9zv
         9OaRJpQb/oM+BxVJg7egcTM9UMmn3+OwrpF4OsqIe/9MD18bbK5oPm2f0W4O6IdZCb1Y
         HYTBNPvsVGe9A5Cy9XJvGzU3JowcP9V3K+RaDqwis0nl1iJDFkko+tBtOGBXGcoUd/Es
         wcC0d+KYSKGhydcvZ0iCU+jydihjchHbJx3LLbUKgsPSJwnN6evkNDtRZgacgJI1pTQz
         BUVzOyXYabnwbhIRmhkkXrke7Bg16qc43eNDU+XSMcRGuIwPS0HcEDnNQVzIRLm/XYwI
         Laiw==
X-Gm-Message-State: AHYfb5jdUv9+IbQ1JVgft4yUT5I6rLzXTQp8W01hNYysdbQ/pgBaf5vA
        xf63Mvw3zwd9Mg==
X-Received: by 10.99.147.8 with SMTP id b8mr7203569pge.384.1503604280817;
        Thu, 24 Aug 2017 12:51:20 -0700 (PDT)
Received: from localhost.localdomain ([27.63.191.1])
        by smtp.gmail.com with ESMTPSA id v2sm9074270pfl.21.2017.08.24.12.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 12:51:20 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v3 0/4] Incremental rewrite of git-submodules
Date:   Fri, 25 Aug 2017 01:20:47 +0530
Message-Id: <20170824195051.30900-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:

* The name of the iterator function for_each_submodule() was changed
  to the for_each_listed_submodule(), as the function fits the naming
  pattern for_each_Y_X(), as here we iterate over group of listed
  submodules (X) which are listed (Y) by the function module_list_compute()
* The name of the call back function type for the above pattern
  for_each_Y_X() is each_X_fn. Hence, this pattern was followed and
  the name of the call back function type for for_each_listed_submodule()
  was changed from submodule_list_func_t to each_submodule_fn.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/week-14-1

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: week-14-1
Build #164

Prathamesh Chavan (4):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_listed_submodule()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C

 builtin/submodule--helper.c | 294 ++++++++++++++++++++++++++++++++++++++++----
 git-submodule.sh            |  61 +--------
 2 files changed, 273 insertions(+), 82 deletions(-)

-- 
2.13.0

