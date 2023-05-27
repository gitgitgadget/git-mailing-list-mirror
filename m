Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF2C77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 14:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjE0OAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE0OAu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 10:00:50 -0400
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 May 2023 07:00:48 PDT
Received: from forward1-smtp.messagingengine.com (forward1-smtp.messagingengine.com [66.111.4.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7BDE
        for <git@vger.kernel.org>; Sat, 27 May 2023 07:00:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailforward.nyi.internal (Postfix) with ESMTP id EF92A1941517
        for <git@vger.kernel.org>; Sat, 27 May 2023 09:53:51 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Sat, 27 May 2023 09:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685195631; x=1685282031; bh=m/aRq3ObJML4DhtsAq6VQkp4U7BW3rO34bp
        SjVqH6Vw=; b=CO0GXnyXcGCfkE3ydq2trWUe0tf/McLVFZXgLOuVKpfijVU+ujM
        Q3sbdro0FmDdffMyw7AGVYmWrnWjuIfZ9J778GENiPgJ2HJJ0U5XCAt/PZsGm8Pc
        X+6n2NiCj3situmrXZcOuSIGYlihDZS0BQDD1h2R0KpG91uf7UZo+hs/xakTJMnG
        L2koFK+QU0DWEYdnK97koBVix+Yb03wmaDkXImjBEDJPET+pKKDTUqC6nXBNjBpC
        0PoyeyWYVTDbiVi07cMkUWILQwEqe2oxxx6a/hH5pLvJFqNDuyEptyYdN3hkcuE6
        bQRz24tU1ogPTt5ykuV8+srSBRqYsH8KXqA==
X-ME-Sender: <xms:bwtyZEdAUdlgLiGjBUUhH2Vy8rPAKK7rn8xWqa5M-IQsbtMQaozO4A>
    <xme:bwtyZGNEwqJgdsY5cfHmCUeafICIaIcVRPR66HutZq3mDCE8bIFLn1ebOeq1-JSRu
    PwPL7KW1x87xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedflfhimhcurfhrhihorhdfuceoughusghiohhushhjihhmsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedugeegffduleetgeetfeetfefffe
    fgveehveetvedtudeuveegudejleeiieevhfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpeguuhgsihhouhhsjhhimhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bwtyZFhozLJiKq8jRNPV6E45nF59NBRNkSz_4bTEjfq_kHNm9rfiYg>
    <xmx:bwtyZJ_pyoxPcdv4TCxRf5CPHY122qGM2FrLQ_fDu-IpocsQbWLb-Q>
    <xmx:bwtyZAsXIr1Q4mgRn1t3V3Ba1fb-uCgCG-0cGd71lSv-SJPUwP6_9w>
    <xmx:bwtyZNXpk809LbiFFCyBaoa1-lSeVoZnV7BGn_J4TK8qsy9nsHERfg>
Feedback-ID: i5b2c416c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B6C621700089; Sat, 27 May 2023 09:53:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
Date:   Sat, 27 May 2023 15:53:31 +0200
From:   "Jim Pryor" <dubiousjim@gmail.com>
To:     git@vger.kernel.org
Subject: git 2.40.1 tree-diff crashes with (glob) magic on pathspecs
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ mkdir test2
$ cd test2
$ git init
Initialized empty Git repository in /Users/jim/repo/test2/.git/
$ mkdir -p foo/bar
$ touch foo/bar/test
$ git add foo/bar/test
$ git commit -m "first commit" -u
[master (root-commit) c6eb1c1] first commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/bar/test
$ git mv foo/bar/test foo/bar/test2
$ git commit -m "second commit" -u
[master 2bacc0c] second commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename foo/bar/{test => test2} (100%)
$ echo "contents" > foo/bar/test2
$ git commit -m "third commit" -a
[master 13a1b11] third commit
 1 file changed, 1 insertion(+)

$ git --no-pager log --oneline -- ':(glob)**/test2'

What did you expect to happen? (Expected behavior)

13a1b11 (HEAD -> master) third commit
2bacc0c second commit
c6eb1c1 first commit

What happened instead? (Actual behavior)

13a1b11 (HEAD -> master) third commit
BUG: tree-diff.c:596: unsupported magic 8
error: git died of signal 6

What's different between what you expected and what actually happened?

git tree-diff crashed

Anything else you want to add:

* Also get the crashes with ':(glob)*/bar/test2' and ':(glob)foo/*/test2'.
* The `git mv` does not seem to be necessary to reproduce.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jun 21 21:18:39 PDT 2022; root:xnu-6153.141.66~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
dubiousjim@gmail.com
