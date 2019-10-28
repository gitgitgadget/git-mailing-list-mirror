Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544781F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 16:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbfJ1Q36 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 12:29:58 -0400
Received: from renault.us.lt ([79.98.26.146]:36166 "EHLO renault.us.lt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730838AbfJ1Q36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 12:29:58 -0400
X-Greylist: delayed 1615 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 12:29:57 EDT
Received: from 78-58-194-223.static.zebra.lt ([78.58.194.223] helo=arch-usb.localdomain)
        by renault.us.lt with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <kipras@kipras.org>)
        id 1iP7Tw-0007Z5-Gg; Mon, 28 Oct 2019 18:03:00 +0200
From:   Kipras Melnikovas <kipras@kipras.org>
To:     gitster@pobox.com
Cc:     dev@kipras.org, git@vger.kernel.org,
        ungureanupaulsebastian@gmail.com
Subject: Re: Re: [FR] Allow `git stash create` to include untracked changes
Date:   Mon, 28 Oct 2019 18:03:05 +0200
Message-Id: <20191028160305.169851-1-kipras@kipras.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <xmqqa79lbpte.fsf@gitster-ct.c.googlers.com>
References: <xmqqa79lbpte.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@kipras.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
thank you for the info.

It seems like neither worked:

export GIT_TEST_STASH_USE_BUILTIN=no
git config --global stash.usebuiltin no

The untracked files are still not stashed with `git stash create -u [some-argument]`, but are stashed successfully with `git stash push -u`,
so unless I'm doing something wrong, this also doesn't help, sadly.

Also, if there are no modified changes (only untracked ones), then `git stash create [-u [some-arg]]` (the non-builtin stash) will not even give you a commit object's name, thus it probably does not create the commit object at all.

Also, the manual page of git-stash(1) not mention the `--include-untracked` option - this is why I posted in the first place.

$ man git-stash
...
git stash create [<message>]
git stash store [-m|--message <message>] [-q|--quiet] <commit>
...

---

Is there any chance to

* get the builtin stash to support `--include-untracked` option?

* figure out if the legacy stash also works as intended with the `-u [some-arg]` option
	* when there aren't any changes, except untracked/ignored ones, the commit object doesn't seem to be created (printed) at all
	* why does it even require an argument?

* update the manual page for git-stash(1)

* check if everything's fine with `git stash store` too, just in case:D

Is there anything else I need to do to get this issue reported or are you guys taking care of it?

---

My stuff:

$ git --version
git version 2.23.0

$ uname -a
Linux arch-usb 5.3.7-arch1-1-ARCH #1 SMP PREEMPT Fri Oct 18 00:17:03 UTC 2019 x86_64 GNU/Linux

Thank you for your time and support:)
Kipras

