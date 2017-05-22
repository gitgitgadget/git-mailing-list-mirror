Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A555B2023D
	for <e@80x24.org>; Mon, 22 May 2017 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935090AbdEVV5l (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 17:57:41 -0400
Received: from sender-op-o12.zoho.com ([135.84.80.197]:17433 "EHLO
        sender-op-o12.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935114AbdEVV5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 17:57:39 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 May 2017 17:57:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1495489353;
        s=zoho; d=passcod.name; i=felix@passcod.name;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
        l=1169; bh=ev3I6ZWJb1cEjYYKDoN+Ql6Zb82FSWe2VtoMgP+xt1Y=;
        b=QaexNhVbK0X16tY5wYodxPcdOiBWBThIjYpe2MAriPCScV+C6nEqt+/QCkkFrkGB
        V5w7YMdqn9poDHILZX/VdWmHM7JzAH/Wlx2MVjpzfkJm356JKHyZXlBzvpwuSYBUQk9
        aBCRpaR/z71NYO74uKvPHl4GhBQ3Z94pZTrHLRGY=
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com [209.85.218.45]) by mx.zohomail.com
        with SMTPS id 1495489353415896.9971442508081; Mon, 22 May 2017 14:42:33 -0700 (PDT)
Received: by mail-oi0-f45.google.com with SMTP id h4so178569777oib.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 14:42:33 -0700 (PDT)
Received: by 10.182.37.70 with HTTP; Mon, 22 May 2017 14:42:12 -0700 (PDT)
X-Gm-Message-State: AODbwcDcUGtFBwv6mS7pTQPvVP3WqYXrKtSoluHHvhiujMSz9p/O1NWo
        E4pJQLSEp1ybyn6xMjh+Wo+NrBbKcg==
X-Received: by 10.202.98.68 with SMTP id w65mr13560548oib.173.1495489353175;
 Mon, 22 May 2017 14:42:33 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?F=C3=A9lix_Saparelli?= <felix@passcod.name>
Date:   Tue, 23 May 2017 09:42:12 +1200
X-Gmail-Original-Message-ID: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
Message-ID: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
Subject: [Bug] cloning a repository with a default MASTER branch tries to
 check out the master branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I created a git repository that, for joke reasons, has a single branch
called MASTER (in uppercase). Upon cloning this repo, git attempts to
checkout the master branch (in lowercase), which does not exist.
Checking out the MASTER branch manually afterwards works.

$ git clone git@github.com:passcod/UPPERCASE-NPM.git
Cloning into 'UPPERCASE-NPM'...
remote: Counting objects: 14, done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 14 (delta 3), reused 14 (delta 3), pack-reused 0
Receiving objects: 100% (14/14), done.
Resolving deltas: 100% (3/3), done.
warning: remote HEAD refers to nonexistent ref, unable to checkout.

$ cd UPPERCASE-NPM
$ ls -a
. .. .git
$ git branch
$ git checkout MASTER
Branch MASTER set up to track remote branch MASTER from origin.
Switched to a new branch 'MASTER'
$ ls -a
. .. .git NPM package.json README
$ git branch
* MASTER

Some platform information:

$ git version
git version 2.12.2

$ uname -a
Linux felix-probook 4.10.13-1-ARCH #1 SMP PREEMPT Thu Apr 27 12:15:09
CEST 2017 x86_64 GNU/Linux

Git was installed from the default Arch Linux package.

Thanks,
F=C3=A9lix

