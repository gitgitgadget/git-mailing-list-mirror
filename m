Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB1C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 18:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjDCSp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjDCSp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 14:45:27 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 11:45:26 PDT
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F1A188
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 11:45:26 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 333BC112ABA; Mon,  3 Apr 2023 14:36:26 -0400 (EDT)
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
Date:   Mon, 03 Apr 2023 14:29:55 -0400
In-reply-to: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
Message-ID: <87edp0ak45.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hongyi Zhao <hongyi.zhao@gmail.com> writes:

> Hi here,
>
> I want to revert a previous commit partially, as follows:
>
> werner@X10DAi:~$ git log |grep -A3 -B5 -m1 texstudio
> commit f18fbd1e16a1ca4215621768d17858c036086608
> Author: Hongyi Zhao <hongyi.zhao@gmail.com>
> Date:   Sun Aug 1 20:01:02 2021 +0800
>
>     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
>     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
>     modified:   Public/repo/github.com/Dushistov/sdcv.git.sh
>     deleted:    Public/repo/github.com/goldendict/stardict-relative/bigdict
>
> More specifically, I just want to revert the following ones:
>
>     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
>     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
>
> Is this possible?

If you are comfortable with git-gui and gitk, then I would say just
revert it, then click ammend the previous commit in git-gui, and click
to unstage the changes you DON'T want to revert, then commit.  If you
want to do it from the command line, then git-revert, then git checkout
HEAD~1 -- ( the other 4 file names here ) will get back the other 4
files then you can git commit --amend.  Alternatively you can skip
git-revert and instead git checkout f18fbd1e16~1 -- (the two files that
you DO want to revert), then git commit.
