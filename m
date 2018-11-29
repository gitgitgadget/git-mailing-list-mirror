Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6394211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeK3CFJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:05:09 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45775 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbeK3CFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:05:09 -0500
Received: by mail-ed1-f54.google.com with SMTP id d39so2113709edb.12
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=aPT8eGeR3I0T67e6Bc8WW94/NH7n0QaUUJSo1CwNMgQ=;
        b=S5LVauEBxX5lezn5v28TBl2kUO8Oy55FcYUs//nDxJJpClKQ30YHfFm0278TKFuMkJ
         dJZ4zEB+f9IZVwfWzyRZCh46Mlqb2NPcGREvHuRZ/lSmyIe74WwluJG3cY0IBS96nN4u
         +Ja5i36vzTi+cE3Gi+zEaYIaa6NRGJlGESykec+O7JaAKAArx9rZ8ap8yhfj4wPjsLxb
         pykYR1OqSw0+jj3zjsMTr3TIYmfprOlAFMyeKRqlDUK6ky4oeziup8iefzASa1CCgMZv
         xfIkT9jPx2IOjBNVCkxXBk+EK0rtca5MqJUUtcG1FYZzUZ0QwfqJOmR4OPCpnRi0sAb5
         GKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=aPT8eGeR3I0T67e6Bc8WW94/NH7n0QaUUJSo1CwNMgQ=;
        b=NlgVuKMBLNBgtgMFuI7bhuHo3l0fLLa5uOj7tA1D84aHC/2GJpia4b1+B/DcGfDP3Y
         huXSBCdu7gnEAPhIKe1WIZQyoI4iW05Rap0wGyFY9ppj8NVmDxp5PxTjrOJSzcCFAxyV
         luFdzx+plCzyDhDPpgUvlm0Olnf5hu7Nt0TeALa2/0YCBEjKwsdc55MVK+MDRRYHZgC8
         BmEHLEuwfVdhfNosH52UVqjj5bhhJWZenKJUSWAXj6tATWcMoHtyJhYgBribkZYJ9zok
         uH8oGJZJfnxVJr1ykt6OLHtlOZZriqa5uhFKYVwz+mvseqRqIxxEyMsN9RDe/W9Bt81N
         lIig==
X-Gm-Message-State: AA+aEWZpK5ju+zNyYIKsxuFnG3ZQ2Ovd5I+QLnWJMUULaicZ2Y5i1KSn
        VfARKk5Oh5Bu8TNsp5J6yf3Ogll2
X-Google-Smtp-Source: AFSGD/V7MEgT57ys0eHiaQH/8X+xnAKY5ls+aLxGLRBAXEgO+L+vRFPXKEeN/LG0YJzVVl+RANijEQ==
X-Received: by 2002:a17:906:a301:: with SMTP id j1-v6mr1859451ejz.188.1543503568480;
        Thu, 29 Nov 2018 06:59:28 -0800 (PST)
Received: from evledraar ([5.57.21.10])
        by smtp.gmail.com with ESMTPSA id t9sm650854edd.25.2018.11.29.06.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 06:59:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: How de-duplicate similar repositories with alternates
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 29 Nov 2018 15:59:26 +0100
Message-ID: <87zhtsx73l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A co-worker asked me today how space could be saved when you have
multiple checkouts of the same repository (at different revs) on the
same machine. I said since these won't block-level de-duplicate well[1]
one way to do this is with alternates.

However, once you have an existing clone I didn't know how to get the
gains without a full re-clone, but I hadn't looked deeply into it. As it
turns out I'm wrong about that, which I found when writing the following
test-case which shows that it works:

    (
        cd /tmp &&
        rm -rf /tmp/git-{master,pu,pu-alt}.git &&

        # Normal clones
        git clone --bare --no-tags --single-branch --branch master https://github.com/git/git.git /tmp/git-master.git &&
        git clone --bare --no-tags --single-branch --branch pu https://github.com/git/git.git /tmp/git-pu.git &&

        # An 'alternate' clone using 'master' objects from another repo
        git --bare init /tmp/git-pu-alt.git &&
        for git in git-pu.git git-pu-alt.git
        do
            echo /tmp/git-master.git/objects >/tmp/$git/objects/info/alternates
        done &&
        git -C git-pu-alt.git fetch --no-tags https://github.com/git/git.git pu:pu

        # Respective sizes, 'alternate' clone much smaller
        du -shc /tmp/git-*.git &&

        # GC them all. Compacts the git-pu.git to git-pu-alt.git's size
        for repo in git-*.git
        do
            git -C $repo gc
        done &&
        du -shc /tmp/git-*.git

        # Add another big history (GFW) to git-{pu,master}.git (in that order!)
        for repo in $(ls -d /tmp/git-*.git | sort -r)
        do
            git -C $repo fetch --no-tags https://github.com/git-for-windows/git master:master-gfw
        done &&
        du -shc /tmp/git-*.git &&

        # Another GC. The objects now in git-master.git will be de-duped by all
        for repo in git-*.git
        do
            git -C $repo gc
        done &&
        du -shc /tmp/git-*.git
    )

This shows a scenario where we clone git.git at "master" and "pu" in
different places. After clone the relevant sizes are:

    108M    /tmp/git-master.git
    3.2M    /tmp/git-pu-alt.git
    109M    /tmp/git-pu.git
    219M    total

I.e. git-pu-alt.git is much smaller since it points via alternates to
git-master.git, and the history of "pu" shares most of the objects with
"master". But then how do you get those gains for git-pu.git? Turns out
you just "git gc"

    111M    /tmp/git-master.git
    2.1M    /tmp/git-pu-alt.git
    2.1M    /tmp/git-pu.git
    115M    total

This is the thing I was wrong about, in retrospect probably because I'd
been putting PATH_TO_REPO in objects/info/alternates, but we actually
need PATH_TO_REPO/objects, and "git gc" won't warn about this (or "git
fsck"). Probably a good idea to patch that at some point, i.e. whine
about paths in alternates that don't have objects, or at the very least
those that don't exist. #leftoverbits

Then when we fetch git-for-windows:master to all the repos they all grow
by the amount git-for-windows has diverged:

    144M    /tmp/git-master.git
    36M     /tmp/git-pu-alt.git
    36M     /tmp/git-pu.git
    214M    total

Note that the "sort -r" is critical here. If we fetched git-master.git
first (at this point the alternate for git-pu*.git) we wouldn't get the
duplication in the first place, but instead:

    144M    /tmp/git-master.git
    2.1M    /tmp/git-pu-alt.git
    2.1M    /tmp/git-pu.git
    148M    total

This shows the importance of keeping such an 'alternate' repo
up-to-date, i.e. we don't get the duplication in the first place, but
regardless (this from a run with sort -r) a "git gc" will coalesce them:

    131M    /tmp/git-master.git
    2.1M    /tmp/git-pu-alt.git
    2.2M    /tmp/git-pu.git
    135M    total

If you find this interesting make sure to read my
https://public-inbox.org/git/87k1s3bomt.fsf@evledraar.gmail.com/ and
https://public-inbox.org/git/87in7nbi5b.fsf@evledraar.gmail.com/ for the
caveats, i.e. if this is something intended for users then no ref in the
alternate can ever be rewound, that'll potentially result in repository
corruption.

1. https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/
