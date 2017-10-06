Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACC51FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdJFNY1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:24:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33325 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdJFNY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:24:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id m28so16694022pfi.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53hS5/wISu4VIqIH+QNH2xUp8oINr2LmFlntm/Xid28=;
        b=WFrajlWKEEMyGE7FoCDmneA2rX8VrCsi3LcWZXbLauPi4sSGojydSUMzqotpab8qPh
         nuw7+XFByL6ls8pTKKevyzFuFIqzBq8bWb8RXIUZFf84QvCPOlEd47ouaOXiieQ2W1Ft
         EptH2kJQs0NumNdNMlhwXQT60Wzkbh9ya+RXA7wqYtlcqM2SO5mZiDNJSYvszUyFfUHM
         nXMTO1AEdYh2AIau9J062bEf/qxaad91oSJvB2PGIpY2Vd1esYLLdRIfBQ5YAEwHFcUt
         esJ3lFmKzQnspFpSO5OJqEaJcRoGFWF3+uGgoQ/7ga9Lt58uJc+rVLUrrDb2ePZhhkLz
         eKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53hS5/wISu4VIqIH+QNH2xUp8oINr2LmFlntm/Xid28=;
        b=plnqYhgeU2PILROHXQJcK3grgpcboBfUgIZsJBr4oq30JceDy30GuVlimOcs/DHwBP
         J5ft/npKnyrSOyJH5jBEQYh+tGeVxoxVHmqqr0g+OUurdRHiWYFW774O8WIRO1LQwtj6
         +WhL4GdnUEYEfNmPNMT2S6O92ouyrdBKD/aY9N398NDv0vl4DS97z8l2gVFClGY2hggD
         7CGwvP6Qwl20fnlGvmJtyJn3U+h3wHAayb5iO9AJawup4pp7H+qP4+zIeHTY9WDZGwnk
         u19n7poMgx1OD9dDOuU+0BH2wF9y0SeuKBLJcyOj+R+zsPp+aJjdk7wlMk23wCaMJvAg
         sZ2Q==
X-Gm-Message-State: AMCzsaWJwWNPc7P4lwLye7BrrzK1rZb5usxcAwTOHkAuooOjVK4vsq59
        svG8eC5nPJXq/4/648wSTmF410F1M8I=
X-Google-Smtp-Source: AOwi7QDv7eQzcQUCEV19MBsvtc95MgU9WO10bOo0hpuPsLrhHb7LngQwmCQc99BROMB98bcbeEKfHQ==
X-Received: by 10.84.241.201 with SMTP id t9mr2006536plm.154.1507296266415;
        Fri, 06 Oct 2017 06:24:26 -0700 (PDT)
Received: from localhost.localdomain ([42.110.180.199])
        by smtp.gmail.com with ESMTPSA id b23sm3770939pfm.148.2017.10.06.06.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 06:24:25 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v7 0/3] Incremental rewrite of git-submodules
Date:   Fri,  6 Oct 2017 18:54:12 +0530
Message-Id: <20171006132415.2876-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v7:

* Instead of using cb_flags in the callback data's struct, 'flags' is used.

* Similar changes were applied to the CB_OPT_QUIET and other bits.

* The function compute_rev_name() was formatted in accordance with the "make
  style", into a compact version.

* Call to precompose_argv() in the function status_submodule() was dropped
  as the call was unnecessary.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/patch-series-1

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-1
Build #190

The above changes were based on master branch.

Another branch, similar to the above, was created, but was based
on the 'next' branch.
Complete build report of that is also available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: patch-series-1-next
Build #189
The above changes are also push on github and are available at:
https://github.com/pratham-pc/git/commits/patch-series-1-next

Prathamesh Chavan (3):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_listed_submodule()
  submodule: port submodule subcommand 'status' from shell to C

 builtin/submodule--helper.c | 273 +++++++++++++++++++++++++++++++++++++++++---
 git-submodule.sh            |  61 +---------
 2 files changed, 257 insertions(+), 77 deletions(-)

-- 
2.14.2

