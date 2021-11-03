Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E103C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B20B610EA
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhKCU1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCU1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 16:27:19 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Nov 2021 13:24:42 PDT
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC0C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 13:24:42 -0700 (PDT)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout01.mail.de (Postfix) with ESMTP id 51BE3A1B13;
        Wed,  3 Nov 2021 21:18:09 +0100 (CET)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
        by postfix01.mail.de (Postfix) with ESMTP id 37B62A03C2;
        Wed,  3 Nov 2021 21:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1635970689;
        bh=NfeJEQ8T8Rt5YDDz0g8p9BprNC2nbITanGZSMqpv6V4=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ko+LRaT4dIm7r7gMnUFRuZeDFU9EQI35E3bPtcDP9aifLAHTR586LVaDJi9bsHFpp
         h+VqrKsRdS8IiNkUYn4Ntmao7Q2v1ZzS7Nabo61lqctgzP61qIGRvg5VKLAoguQtd9
         c9yvRkZ/tyevaKldmlcqbpadepOJi7HV/zoOuVMFGg4gvU7QqBP4ue6jZMK3Oc1EfO
         aosJQF0Rsbk2R3jiQ2BirCu6df6TS9PAHd89SLnNJ0WdyVTyyuNnu6k611mTLUErgw
         /O1dCdV9Cpvv5UnUnirZzECepgkKefAkqJBycHznF73arLD1k9+OMFRrJG2lolOd1b
         XwAqG9ZBZeZqA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp01.mail.de (Postfix) with ESMTPSA id DEF18100123;
        Wed,  3 Nov 2021 21:18:08 +0100 (CET)
From:   Stefan Moch <stefanmoch@mail.de>
Subject: Re: Git Checkout tracking behavior with <start_point>?
To:     Cyrus Vafadari <cvafadari@gmail.com>
Cc:     git@vger.kernel.org
References: <CAMd+_QCDN5UwwC=ZRcT4Y3p1x7kCQ1TEVf5321Ykx4xrhv-YOA@mail.gmail.com>
Message-ID: <10455b65-377f-5bd5-fd7e-c6cb44d2f82f@mail.de>
Date:   Wed, 3 Nov 2021 21:17:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAMd+_QCDN5UwwC=ZRcT4Y3p1x7kCQ1TEVf5321Ykx4xrhv-YOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3803
X-purgate-ID: 154282::1635970689-00006BE6-EC76D05E/0/0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Cyrus,

Am 03.11.21 um 16:08 schrieb Cyrus Vafadari:
> I'm new to this mailing list, so I hope I'm doing it right!

Welcome! And yes.

> I am an avid user of this pattern: "git checkout -b my_branch
> upstream/3.2.x", using "start_point" to build my backported patch
> against an old feature version. But in this case, the default tracking
> is against 3.2.x, rather than my new feature branch. So, then, when I
> push I specify to update the tracking against the new branch name.
> There are also various default behaviors for push, which I won't
> enumerate here, but in the end I need to specify tracking.
> 
> I'm wondering if there is some usage/pattern I'm missing?
> 
> Or is this an opportunity to add a gitconfig for "tracking behavior"
> of `checkout` with start_point? If there is agreement that this could
> be improved with a new config, I'd be happy to open a PR.

There is already a --[no-]track option[1] to the commands that
create new branches (switch, branch, checkout, worktree) to toggle
this behavior per command invocation, and also the configuration
option branch.autoSetupMerge[2] to set the desired behavior generally.

Example:

1. check if not set, default behavior / your example

   $ git config branch.autoSetupMerge
   $ git checkout -b trackingtest_1 origin/master  # like you did
   Branch 'trackingtest_1' set up to track remote branch 'master'
   from 'origin'.
   Switched to a new branch 'trackingtest_1'

   (as you noticed: the start point is set as the new branch's
   upstream)

2. specify --no-track to prevent tracking branch creation for
   command:

   $ git checkout --no-track -b trackingtest_2 origin/master
   Switched to a new branch 'trackingtest_2'

   (no tracking branch created)

3. or, configure the general behavior (test without --no-track
   again):

   $ git config --local branch.autoSetupMerge false
   $ git checkout -b trackingtest_3 origin/master
   Switched to a new branch 'trackingtest_3'

   (no tracking branch created)

4. verify, what we just did:

   $ git branch --list 'trackingtest_*' -vv
     trackingtest_1 66262451ec [origin/master] Git 2.33-rc0
     trackingtest_2 66262451ec Git 2.33-rc0
   * trackingtest_3 66262451ec Git 2.33-rc0

   (only the first one has the remote tracking branch set)

5. to set the new remote tracking branch of the same name (and
   create it in the remote repository in one step)[3]:

   $ git push -u origin HEAD
   Branch 'trackingtest_3' set up to track remote branch
   'trackingtest_3' from 'origin'.
   Everything up-to-date


When you create the new branch, this happens only in the local
repository – it is therefore a separate step (push) to create the
branch in a remote repository. As this normally (without -u) would
not change/set the upstream for the branch, this has to be done on
the first push with '-u'. Using HEAD as a shortcut, you can push the
currently checked out branch without specifying the branch name[4].
If there is already a branch with this name on the remote
repository, the push will of course only work for fast-forwards,
unless forced.

Rethinking it: if you are doing the 'git push -u origin HEAD' anyway
– maybe even as first step after the branch creation –, or you don't
intent to fetch/pull into this branch before the push, you can
forego either using --no-track and setting branch.autoSetupMerge.



Stefan


[1]
https://git-scm.com/docs/git-checkout#Documentation/git-checkout.txt---track
[2]
https://git-scm.com/docs/git-config#Documentation/git-config.txt-branchautoSetupMerge
[3] https://git-scm.com/docs/git-push#Documentation/git-push.txt--u
[4]
https://git-scm.com/docs/git-push#Documentation/git-push.txt-codegitpushoriginHEADcode
