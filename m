Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A381F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeBHPhj (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:37:39 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37368 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeBHPhi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:37:38 -0500
Received: by mail-wm0-f53.google.com with SMTP id v71so10768160wmv.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=xFca/rZ4NYwZ24D/8XgrCVdiPEQlFpOt7vCJm/qddNM=;
        b=H8ax/bDklxZPTzAxmVybVCpW3eqxoYfjsmB+QLV69LGYTVV3toxwfvbQ6anSr/LBIg
         OrSnZJir4JOcS116eKFrI1/X8BljMKrHe2lQJ4Bc9vU1B1LExKQA5A979Bj13hhJ5J1V
         g9uaE/nlPQCV6LZ3UP0hMpNUhc4n+KKUDoP+9R35YhVLMSgPsYGYrL00xrBk9EG6bmOe
         /3XwXxr0cZ3ZnPe3/5pMe2/VEZQYaG9JUg4C3SiStwtX6udGIUIJzt2OL4n3IK5lxFi+
         ZjM441x1ceH8RMYnwFzVdVo7X4ISj5/0mKgaWEbzcDlPm2VzI/wrGYpTmIHWW2NPXo9e
         JNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=xFca/rZ4NYwZ24D/8XgrCVdiPEQlFpOt7vCJm/qddNM=;
        b=qyUfKZlekwLaU0mrf9s5jyNMQuU3trOvfq1XCL/KdXGyeN1YGZnE/i/rGo0bVpxtD8
         fszdGX9zFk/oTGLOhnHVDqA4MuTDPXdGqsex4WS1LHLvhY94OZWU1nShCVpdWtPKFEdu
         eAJyJo1U0QJh+B/YwKx2MRrMMS7v7SbSoRYOwEyTCz0BzoWWmGr9EOJDH3GHDK0L9IqT
         wLN4ME2maPArFxBpvicOavcICK5eIz0B58kLLkdtLsn3zfdDwqkLGi3bYsXn2GowVIkD
         SFk2TakhAE/2CI00S/JMl2C0NSiPES40xOUEvn3iG6/yy8wLArBhRB47XFF0JPq5AVeO
         0J0w==
X-Gm-Message-State: APf1xPCn5JIEt6+Kq0dRBfGXhjyQoQ4bLgOoEmGpBYUdS8DSHZdjKZA7
        Rt4OjsNBp8I06aAsglrQl8yBaQCE
X-Google-Smtp-Source: AH8x225byO+eOBS6FwGNETQHkNwP50o070XQjGmBIaZZiBvolGdT4S5tZZhivM0pYfjVK/V87EuLjQ==
X-Received: by 10.80.165.201 with SMTP id b9mr2095733edc.211.1518104256924;
        Thu, 08 Feb 2018 07:37:36 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id x7sm94469edi.27.2018.02.08.07.37.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 07:37:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: How to produce a loose ref+size explosion via pruning + git-gc
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
Date:   Thu, 08 Feb 2018 16:37:32 +0100
Message-ID: <87fu6bmr0j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll probably submit docs for this eventually, but the docs in my
--prune-tags series were already hard enough to review. Try running this

    (
        rm -rf /tmp/git &&
        git clone https://github.com/git/git /tmp/git &&
        cd /tmp/git >/dev/null &&
        du -sh .git &&
        git rev-list --all origin/master.. | wc -l &&
        for clone in gitster peff avar chriscool mhagger pclouds Microsoft
        do
            git remote add $clone https://github.com/$clone/git &&
            git fetch -q $clone
        done &&
        git gc &&
        du -sh .git &&
        git rev-list --all origin/master.. | wc -l &&
        git fetch -q origin --prune 'refs/tags/*:refs/tags/*' &&
        for remote in $(git remote | grep -v origin)
        do
            git remote rm $remote
        done &&
        git gc &&
        du -sh .git &&
        git rev-list --all origin/master.. | wc -l
    )

The output is:

    108M    .git
    2222
    160M    .git
    62220
    1.9G    .git
    2222

I.e. a fresh clone of git.git is 108MB, add a few more repos that have
diverged quite a bit in its network ad it's 160MB repacked.

Now remove those remotes and "git gc" and it's 1.9GB, even though it's
divergent by the same 2222 commits from master as the 108MB, but after
running:

    git prune --expire=now

It becomes ~108MB again.

Now this is all expected behavior, we've made a bunch of objects
unreferenced, so they all get exploded into loose objects, which takes a
lot of space.

It's an interesting caveat when setting fetch.prune=true on checkouts
that didn't previously have it and might have lots of brances to be
pruned.

For reasons I won't go into I'd had that disabled for a while here at
work, and after re-enabling it we had some repos whose .git is usually
2.5G explode to 30G once git-gc ran.

The workaround is to set gc.pruneExpire low enough that when the gc hits
all those objects get deleted, I set it to 1 day (from the default of 2
weeks).

But it doesn't help with repos that have already run git-gc and exploded
in size, much to the confusion of users on those systems, those need a
manual git-prune.

Potential solutions to this have been discussed ad-nauseam here on
list. Let's not go into that (unless someone feels like it).

I mainly wanted to send this for later reference, and have some
searchable record in case someone's confused when they turn on prune and
their repo increases to 10x the previous size.
