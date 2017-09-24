Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8BD20A26
	for <e@80x24.org>; Sun, 24 Sep 2017 12:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdIXMJP (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 08:09:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38438 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdIXMJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 08:09:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so2457794pfj.5
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsKcX/1I/bAFeU3Ob1HZoqb+Sq7cNfkupK/st5VvHoI=;
        b=WfzANkIzPZFf7xgSXU7jTXD+lFiQALJAaaLO2PLiWkj3mAnF0OZwV5oFFHMBcMXfwn
         s191gv0sLHGDcupQWInZOCrcfvS8CSobzMmpCFS73SO1mzLSmqRkLIYx1OUZdS0cZucA
         9rp1rSI/p6JhVoHa/ZVOrzAu5F/Rk8WMxO7dHxQBJfkY/L65oxBZdxWq6lwd2M08KX+l
         o5RRLr6xtPT1TZwy8gbra6YI8oEI272bgEPQBUu1RsdpWUaINGFGwueuqv+cBzOhyzAj
         iXfhcHA4meTH7aCP0jOkFbMLguAI8odVnHmmgYxlO13fAxN9UOB1UfFCXLaaX/zoQwGz
         1Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsKcX/1I/bAFeU3Ob1HZoqb+Sq7cNfkupK/st5VvHoI=;
        b=N2sFcZfJgB/Aa8P6zdQE+zQ45KwE3AbmMfJo5oIz+stRb7TEd104vKzLTbhI6IWr/l
         VlnETzjtpw3LlsZ8/3kDghMCQLx7QPST1zWcYREMiq4KX4/V8k7lMmP251xw1cMRCsc6
         ponCV8zIA3+ZaNDOLa4by8XZVd6EtPC/rEWTUnDYQ2KoXX4YQUzoI3e/7VyKZixTilev
         d/dyuctb5M58bcvrD8YhMMHbbhjZab5maNnxwyRogwQRTe+MCUuSuN0UYscOiS1LSTu/
         mOy6OXGijgWDDc7MLkTc3n3OE9jBNLPMPcEihC6n6+72FApWLw7G2xMmsE70/4cxgFG+
         pHRg==
X-Gm-Message-State: AHPjjUgV4hZTy8c2c33qW2Fa/UrIZHmNXe1LHtLrZUlhm6+Y5JQ4n7TM
        3hvXUZO5udBybBR8Giq8dMg=
X-Google-Smtp-Source: AOwi7QAITDJNejkMxpsXapilWbrjFuZGieFzjFegquX8rappfLmLlbcN70YuWU8i6iDfBiqcQT3yKw==
X-Received: by 10.159.216.145 with SMTP id s17mr4577078plp.35.1506254952109;
        Sun, 24 Sep 2017 05:09:12 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id 65sm6908123pgh.31.2017.09.24.05.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Sep 2017 05:09:11 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     hanwen@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v5 0/4] Incremental rewrite of git-submodules
Date:   Sun, 24 Sep 2017 17:38:54 +0530
Message-Id: <20170924120858.26813-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170921161059.11750-1-hanwen@google.com>
References: <20170921161059.11750-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v5:
* in print_status() function, we now call compute_rev_name() directly
  instead of doing the argv setup and calling get_rev_name() function.
* Since we no longer use the helper function get_rev_name(), we have
  removed it from the code base after porting submodule subcommand
  'status'.
* function get_submodule_displaypath() has been modified, and now handles
  the case of super_prefix being non-null and of length zero.
* I have still kept the name of the function get_rev_name() unchanged,
  since in the function cmd_status(), it is used to get the value of
  the variable revname. And in the next commit since we do not require
  the function anymore, we reomve it from the code base.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/patch-series-1

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-1
Build #179

Thanks, Han-Wen Nienhuys for reviewing the previous patch series.

Prathamesh Chavan (4):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_listed_submodule()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C

 builtin/submodule--helper.c | 265 ++++++++++++++++++++++++++++++++++++++++----
 git-submodule.sh            |  61 +---------
 2 files changed, 247 insertions(+), 79 deletions(-)

-- 
2.13.0

