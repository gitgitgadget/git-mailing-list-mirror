Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D7320899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbdHWTj1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:39:27 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:38613 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:39:25 -0400
Received: by mail-qk0-f175.google.com with SMTP id k126so6063243qkb.5
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=giUsKIU0A1GD8X/+qB2x0QwZnZh0ruEdd1x1+mHkviw=;
        b=EmDGt2asATxUKlSTYsOIAVSfAWUbHOgVJxxDFNrgDL1UKAHdSMcBU6jM2tZtQuWCSj
         3UX6RbeE3wLERMEsJWliRveNICmCpvMLgT5IfYPA+ZYqg39ym9NXr/MDkCaBTfrV/FqE
         N7qVAPiwFsnywn49UtE2wZGn5x5oLh3HFQSsZCqX8AhQD8XvnniXj1TVM9jrZiPzuVK8
         KYol6sutf7VCirU0vcvNR1+QnkPrBH0zn5xJK9wiNCJNx0xeqYj5SPbNT9Gs59m7hOYS
         xRw5jGqRT5/b7kxU7gOUPvsap9vyVxXVfqqwLv1hylDAPGQupOkpaH8wEFye83T9Xgd/
         ArPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=giUsKIU0A1GD8X/+qB2x0QwZnZh0ruEdd1x1+mHkviw=;
        b=NQF91a9o6IfgMy6D5ncsIHYrW34TSXXb/nprafHvbAIL1JmG4BQJ9WHa0jXEDuyPPe
         dD+lX7Pu+KF5gDM5HetF6bRgxuu1kK4ft/kQIf8v1r1QTAWo70KcggYND3eYG6s+j+q0
         i/k/av09xiNNXLXIEwtB/XcSkeWfjO8N999Epgintp2xE4ADyosbPRrYMFMq1Qip46VP
         iz99RxRrdADfDQHEMKjehSEyKiPC+3LcmFucsc+hEHzbUm0GGZNrUEfc76sJ4+foYKJM
         CPG1QAdlS+uujgxreNfE53nLP1+qLotRUlSs/px5VqUe13ZqN/9WByLygfTA25tBsVtg
         rtjA==
X-Gm-Message-State: AHYfb5hYW3OvoOZgs2vj2SKblwm+67cgFrZflfaWQWcxOlJ4hh6Bdi9W
        pr8oiY+E+kDFyswna/HWKPWyq6KMLsFK
X-Received: by 10.55.151.67 with SMTP id z64mr5108520qkd.5.1503517164385; Wed,
 23 Aug 2017 12:39:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.129.34 with HTTP; Wed, 23 Aug 2017 12:39:04 -0700 (PDT)
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 23 Aug 2017 15:39:04 -0400
Message-ID: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
Subject: Should rerere auto-update a merge resolution?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi List!

Let's say...
 - git v2.9.4
 - rerere is enabled.
 - I merge maint into master, resolve erroneously, commit
 - I publish my merge in a temp branch, a reviewer points out my mistake
 - I reset hard, retry the merge, using --no-commit, rerere  applies
what it knows
 - I fix things up, then commit

So far so good.

Oops! One of the branches has moved forward in the meantime, so

 - git fetch
 - git reset --hard master
 - git merge maint
... rerere applies the first (incorrect) resolution...

Am I doing it wrong? {C,Sh}ould rerere have done better?

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
