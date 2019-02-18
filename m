Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4BF1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 14:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfBROnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 09:43:20 -0500
Received: from forward100o.mail.yandex.net ([37.140.190.180]:47245 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730366AbfBROnT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 09:43:19 -0500
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2019 09:43:19 EST
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 62F284AC03EF
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 17:36:27 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback7j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FN9OT2tJ4K-aR20DAFf;
        Mon, 18 Feb 2019 17:36:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550500587;
        bh=xNhQOh+g6qYwQS98NUH/xS1ItPNetXaLl73fnVq1iqc=;
        h=Date:From:Subject:To:Message-Id;
        b=VWfK4DU1hXFLuNUAmapHCk5g0YiCybs3s4CT26lA6lq8t74/uQs6o2ZRsb6dYAcQs
         3IAfNnijsila0Cl5zIZzkLvaBySg1vuXZOWIjXH0rKAK/wsCyp4wpwitH/vov8lf1j
         CBLMENc8tPcdpe7UYvzLykxzlJ0cgklGfD/Dw1Sg=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id LUdXrzK3yl-aQZ8Ob2F;
        Mon, 18 Feb 2019 17:36:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 18 Feb 2019 17:36:26 +0300
From:   hi-angel@yandex.ru
Subject: git gc fails with "unable to resolve reference" for worktree
To:     git@vger.kernel.org
Message-Id: <1550500586.2865.0@yandex.ru>
X-Mailer: geary/master~g2c4fe9b7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Steps to reproduce (in terms of terminal commands)

    $ mkdir foo
    $ cd foo
    $ git init
    Initialized empty Git repository in /tmp/foo/.git/
    $ echo hello > testfile
    $ git add testfile && git commit -m "my commit1"
    [master (root-commit) d5f0b47] my commit1
    1 file changed, 1 insertion(+)
    create mode 100644 testfile
    $ git checkout -b bar
    Switched to a new branch 'bar'
    $ git worktree add ../bar\ \(worktree\) master
    Preparing worktree (checking out 'master')
    HEAD is now at d5f0b47 my commit1
    $ git gc
    error: cannot lock ref 'worktrees/bar (worktree)/HEAD': unable to 
resolve reference 'worktrees/bar (worktree)/HEAD': Invalid argument
    fatal: failed to run reflog

# Expected

No errors

# Actual

error: cannot lock ref 'worktrees/bar (worktree)/HEAD': unable to 
resolve reference 'worktrees/bar (worktree)/HEAD': Invalid argument


