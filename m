Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99021F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeFQF7E (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37216 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeFQF7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:04 -0400
Received: by mail-oi0-f67.google.com with SMTP id l22-v6so12207260oib.4
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=43cwhoHgM7qLwUqpRv5Ze3Maw7RvtYpP4ex6/IcaxAU=;
        b=KTHrUai2E8bvZFdu7pQwBdZMpoyiZQXOmUtxzjPKIgZ5SfHGlGh0gIk8O6Y38gRSTH
         Gh/cUc/Qa2JfJOUZYcAaBGJipeMjlc47rmi3qt6g0pB6naPOsoJucjIak3s6xeBMU/jU
         EhMJCLePpspnfMnihD367xh5/Q0LZ5rzsxYRfAvpuCSwJCL68m9ZW11kOrBA3pq4s8Vw
         RrvWsxFIplk1EhFzBQQw8q8z/0WkceMcphHh3WeRbxAs/lYqaKxYsS+9vkGJxQkQZA7Y
         LUenhfg8FQCUJ1AYseU4jf1jOVy2h48VGxvOMb4qc1AkhYFZmtrivyX7zntJBNJS0kKC
         GVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=43cwhoHgM7qLwUqpRv5Ze3Maw7RvtYpP4ex6/IcaxAU=;
        b=UuKuQGylaX32p2XFVR7osdb0syoUXN+qJuYzvzngLXtrscmWcPGLwKgEvM7BpIN7CH
         Dooj933KR4sPeaIpmGf2F6mYIhZ190uDQQxm+qn4+Ao4YPq2uDa4WRg+MxO9YWxxn/dR
         1ukFWWfO5VnsB5Y7w2Y5aAeZeEpIVXYXx0SoxW7R0dMS2Jm1ACM2JQIo+SDFwQ4B9xLX
         okbdxRdxLiDN+1M+yLjp2C79nKewhASJ6ClQ9wEj3igzhy9tr8hkytE42mNqXx4LX0L1
         /VjPk2HJzQ9wfGQtQvAzkF1SQ2sHxuH7ACjW8iLnhxhDHn95KuWbWMYuxwAz822XFUNG
         2c/Q==
X-Gm-Message-State: APt69E0JyseiR0xAz0fGmMuMfmp9AS2WhsGoyI0du0Jk+ed3abZjmzVT
        uARaV8ksUDEZ+AMWHVCiMT+Ycg==
X-Google-Smtp-Source: ADUXVKILGyrLn7nrt9QxNZw6a8vxeF6TVuS+nNOwQGO2LEiRv+9he2/4kWN38RXh8GRLtOAy0v6KfQ==
X-Received: by 2002:aca:b782:: with SMTP id h124-v6mr4615773oif.7.1529215143226;
        Sat, 16 Jun 2018 22:59:03 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 0/7] Document/fix/warn about rebase incompatibilities and inconsistences
Date:   Sat, 16 Jun 2018 22:58:49 -0700
Message-Id: <20180617055856.22838-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180607050654.19663-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rebase has lots of options that are mutually incompatible.  Even among
aspects of its behavior that is common to all rebase types, it has a number
of inconsistencies.  This series tries to document, fix, and/or warn users
about many of these.

I have a much higher than average expectation that folks will object
to some of these patches.  I've tried to divide them up so that any parts
we decide to drop or redo can be more easily excised.

No branch-diff; because it's a significant re-work; instead I'll comment
briefly on the individual patches...


Elijah Newren (7):
  git-rebase.txt: document incompatible options

Both Dscho (on a related patch series) and Phillip suggested changing the
documentation to avoid implementational details.  I instead made a separate
section with sets of incompatible options...but it still mentions the
different backends while doing so.  Does that seem alright?

  git-rebase.sh: update help messages a bit

Minor tweaks to `git rebase -h` output.

  t3422: new testcases for checking when incompatible options passed

The one unmodified patch from the first round.

  git-rebase: error out when incompatible options passed

Almost the same as the first round, except:
  * Documentation pulled into a separate patch (patch 1)
  * $() instead of ``

  git-rebase.txt: document behavioral inconsistencies between modes

Add another section to the documentation for aspects that ideally
should be common between all modes but are handled differently.

  git-rebase.txt: address confusion between --no-ff vs --force-rebase

This came up on the list not that long ago; fix the documentation.

  git-rebase: make --allow-empty-message the default

Address the easiest of the inconsistencies, assuming the am-based backend
has the correct default and the merge-based and interactive-based backends
are the ones that need to change.

 Documentation/git-rebase.txt           | 154 ++++++++++++++++++++-----
 git-rebase.sh                          |  25 +++-
 t/t3404-rebase-interactive.sh          |   7 +-
 t/t3405-rebase-malformed.sh            |  11 +-
 t/t3422-rebase-incompatible-options.sh |  69 +++++++++++
 5 files changed, 224 insertions(+), 42 deletions(-)
 create mode 100755 t/t3422-rebase-incompatible-options.sh

-- 
2.18.0.rc2.1.g5453d3f70b.dirty
