Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FB31F461
	for <e@80x24.org>; Sun,  7 Jul 2019 15:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfGGPnP (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 11:43:15 -0400
Received: from m42-6.mailgun.net ([69.72.42.6]:36097 "EHLO m42-6.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfGGPnP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 11:43:15 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2019 11:43:14 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=ojford.com; q=dns/txt; s=k1;
 t=1562514194; h=Content-Type: Subject: To: From: Date: Message-Id:
 Mime-Version: Sender; bh=Mn6qRyMM29GXo/Ady440NjbyfLfRzuDFWrKbLajanYc=;
 b=QZZy9w1RqhYWWeH+kzJYsP9lLiJOUI9+cbUxTJmdPxs4FQlZkNyApGMr76Bkmc1omGGClrh0
 qCIEG7sw8fbhcDxSogA0rC5Cmx+WkVjT+majJUlAABgjIe1HFV+6ddQHehcB3E7FBwfcIQSU
 g3b+F7t+4DzVoh0G5YhYH5dt7uc=
X-Mailgun-Sending-Ip: 69.72.42.6
X-Mailgun-Sid: WyJmOTkyYyIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgIjMzYWI2Il0=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com [66.111.4.227])
 by mxa.mailgun.org with ESMTP id 5d2211e5.7f95e34df660-smtp-out-n01;
 Sun, 07 Jul 2019 15:38:13 -0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 03733213CA
        for <git@vger.kernel.org>; Sun,  7 Jul 2019 11:38:13 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute3.internal (MEProxy); Sun, 07 Jul 2019 11:38:13 -0400
X-ME-Sender: <xms:5BEiXcFu47nnzSrC6AajbM_nI76vgunWjH7FZli_KlzVZqlpIp967w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfeekgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepfdfqlhhivhgvrhcuhfhorhgufdcuoeguvghvsehojhhfohhrugdr
    tghomheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehojhhfohhrugdomhgvshhmthhprg
    huthhhphgvrhhsohhnrghlihhthidqieeiheekheejjeeiqddujeeghedtheeikedquggv
    vheppehojhhfohhrugdrtghomhesfhgrshhtmhgrihhlrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptd
X-ME-Proxy: <xmx:5BEiXdOY7g1fm_i6gqa75meGL1KyE6j82snchWWnvt8ckofUQ2sVxw>
    <xmx:5BEiXVgDHNz1iYgYcnSkoQvu69msbm55fCC7npAm9QpqW0Gx4ePNjA>
    <xmx:5BEiXV0EYFwaEo-4EsKpAgCMr5dXWGxtQbto6DiV_bi9ckghed3JMw>
    <xmx:5REiXQTniGoCFXL3NhJ-FKjdVus8TOHYFoAahX7uJ9wyQ5LiqCg8Og>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C0705318009F; Sun,  7 Jul 2019 11:38:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-731-g19d3b16-fmstable-20190627v1
Mime-Version: 1.0
Message-Id: <2cf30314-d9a3-4be3-80bf-46f283010e5d@www.fastmail.com>
Date:   Sun, 07 Jul 2019 16:36:45 +0100
From:   "Oliver Ford" <dev@ojford.com>
To:     git@vger.kernel.org
Subject: rev-parse's show-{cdup,prefix} inconsistent when pwd symlink
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git rev-parse --show-prefix` gives the symlinked directory, not pwd:

```
$ git init
Initialized empty Git repository in [~]/git-test/.git/
$ mkdir realdir
$ ln -s realdir symdir
$ cd symdir
$ pwd
[~]/misc/git-test/symdir
$ git rev-parse --show-prefix
realdir/
```

That might arguably be desirable, (though not in my prompt) but I don't think this is:

```
$ cd ..
$ mkdir realdir/2
$ ln -s realdir/2 symdir2
$ cd symdir2
$ pwd
[~]/misc/git-test/symdir2
$ git rev-parse --show-cdup
../../
```

that is, `--show-cdup` gives a 'cd up' that is incorrect for where we actually are.


Apologies if I've just missed an option,

-- 
Oliver Ford
