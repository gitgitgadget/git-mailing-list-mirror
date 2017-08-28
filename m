Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93091F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 11:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdH1L4W (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 07:56:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32780 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdH1L4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 07:56:21 -0400
Received: by mail-pf0-f196.google.com with SMTP id c28so185679pfe.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iSLQfFIFKjxwHsOzgTzykmRXc3GHjVqbKNjo2HiPHvQ=;
        b=XoDET+ILSy10b/D7VQP49oex8P1FRE1UznCh++3uW8ZqQJ1wlLK/zkEzMPLVv4+BHc
         7iVhOufNn2lOj3VdHP2GTQ/S89RTkSDQwn5YMWbLdjUPn/3Y9hicAWFmaULdr6QG8a5K
         CpKleEF2YvSWXmKIrjDQXcCtsOj/qyxThJ8X2IE4noNESci94aWcJ6snm2TrHoYTNFTX
         hoXl6cZcCI/NfIWSV9r1+FD0O+hdWtjbKjifl9rnOmhGP7iiS1rwQ/8T0TqLAgCDPDP7
         3NIE94G1x0V8N/GZ2ZIMk+5AVDYx9uIDnGFlitqSjY1EdpBHXYe3zVQyb6oZpSxvsh1S
         1OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iSLQfFIFKjxwHsOzgTzykmRXc3GHjVqbKNjo2HiPHvQ=;
        b=Dx65ukxmSGam0FrytC1J3Y1Pf5MkPu21pDeqn85b7KiWMYiW4mlmpp4UdOhbf4+PxC
         604bi7EE+sZGxHjzDqC04k3PMjRqm00E6s9uDUqae2fVQpvfse3p94PgNLSNx4wVp5v/
         119YK+Lvyg2MQhb8wkBwrAcWQrfenEWDSI+POXhAXyZ7/QmnuVbkguoqjsEFP1rs6Pvz
         hqlRM7FBu93E4ZDTtllWk8N85ti7FnZBjOpvZfT4qIJwdWJR7F92+ov+auMvmnUfR3sp
         i4TaZZXWUv68rgFLnDV10rfRK8tmTT7xInYoTX+lAUW2JI7XgOkYigcEtOkXruwXLtd+
         hibw==
X-Gm-Message-State: AHYfb5jTbaZenT1uJmRUAXGWIcDMfcoYmtUs/c+AgE3Yw3WwW+/lwUnm
        qivffdeZBPx20A==
X-Received: by 10.99.2.18 with SMTP id 18mr340433pgc.70.1503921381122;
        Mon, 28 Aug 2017 04:56:21 -0700 (PDT)
Received: from localhost.localdomain ([223.176.49.60])
        by smtp.gmail.com with ESMTPSA id h70sm748608pfc.92.2017.08.28.04.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 04:56:18 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 0/4] Incremental rewrite of git-submodules
Date:   Mon, 28 Aug 2017 17:25:54 +0530
Message-Id: <20170828115558.28297-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v4:
* The patches were adjusted to recent codebase.
  Also, the gitmodules_config() was call was removed
  from the functions module_init() and module_status()
  which was essential after the merge of the branch
  bw/submodule-config-cleanup.
  Since it was mentioned earlier, I even tried basing
  the patch series on the branch nd/prune-in-worktree.
  Conflicts occured while doing so, since the later
  branch is based on the master branch with the HEAD
  pointing to the commit:  The fourth batch post 2.14
  I think there won't be any conflicts, if that is changed.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/patch-series-1

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-1
Build #167

The above changes were based on master branch.

Another branch, similar to the above, was created, but was based
on the 'next' branch.

Complete build report of that is also available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: patch-series-1-next
Build #168

The above changes are also push on github and are available at:
https://github.com/pratham-pc/git/commits/patch-series-1-next

Prathamesh Chavan (4):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_listed_submodule()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C

 builtin/submodule--helper.c | 289 +++++++++++++++++++++++++++++++++++++++++---
 git-submodule.sh            |  61 +---------
 2 files changed, 271 insertions(+), 79 deletions(-)

-- 
2.13.0

