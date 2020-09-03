Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672CC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4596B20716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="SxKSz2F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgICWeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgICWdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:33:54 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F30C06125F
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:33:53 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1599172427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=4STjFskyIz3F8pwkMJGTXl8L/dbTYHUnCfPuGvuCIQ8=;
        b=SxKSz2F4iyWHYdKoMZMo5o47jRVCGuD+Z9fWPpji93E13ZATcMcxQZ7ArdrTb3qmG8PbO9
        W+gHgeIOzpPk9ueElEy4Qy25A+wlC/jg2GpRfn53PLXwj7Kr7AGV6u0f5nouO7HRqEFbPd
        +g9hw0aX06Ax9ABw7j7lPTVFeacbtmA=
Content-Type: text/plain; charset=UTF-8
Subject: Re: Sequent repos ,, pull without checkout
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Wolfgang Graf" <wg@wogra.net>, <git@vger.kernel.org>
Date:   Thu, 03 Sep 2020 18:25:16 -0400
Message-Id: <C5E34SOYIUI0.BQMTEWUI28K5@ziyou.local>
In-Reply-To: <20200903083859.Horde.d_JTRsvdjC38RffOwMv54lJ@webmail.your-server.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the expected behavior. The branches in a repository (what you
see when you run "git branch" with no arguments") are different from the
remote-tracking refs (what you see when you run "git branch -r", and
which are updated by "git fetch"). You can't track another repository's
remote-tracking refs with your remote-tracking refs, just its actual
branches.

The part which may be confusing is that "git checkout", as a shortcut,
lets you attempt to check out a branch that does not exist, and if a
branch with the same name exists on a remote, it will create the branch
and set it up to track that remote branch.

If you wanted to fetch branches from multiple other repositories,
though, you would ordinarily add those repositores as remotes, rather
than pushing everything through a single existing remote.

Hope that helps.
