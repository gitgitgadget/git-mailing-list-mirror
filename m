Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADEF208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeHHRmx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:42:53 -0400
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:40610 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727412AbeHHRmv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 13:42:51 -0400
X-Greylist: delayed 2412 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 13:42:50 EDT
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id B127F42DA8
        for <git@vger.kernel.org>; Wed,  8 Aug 2018 08:30:21 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id nPTcfuKLHuL2QnPTffJuv7; Wed, 08 Aug 2018 08:30:20 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CAnAavYUMFCxUlmzjweY7xGYtaBOjQvL6/k093k4AwY=; b=Wryal5YWbi8Tdr/Iowf8UVcEZg
        wOhK2oJjIYIKZlDTTpSH9HqeudCxdnviUf90ZimElc3YdedIWB3wb4g/p+2hsOT1pPCWLE9p3m344
        pnsW2ao9McbX/rgL8iE3kONwB;
Received: from [50.226.24.42] (port=47118 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fnPTY-0046K6-QT
        for git@vger.kernel.org; Wed, 08 Aug 2018 08:30:12 -0600
Message-ID: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
Subject: Help with "fatal: unable to read ...." error during GC?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Wed, 08 Aug 2018 10:30:11 -0400
Organization: I may be mad, but I'm a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Source-L: No
X-Exim-ID: 1fnPTY-0046K6-QT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:47118
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Org:  HG=bhcustomer;ORG=bluehost;
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently upgraded from Git 2.9.2 to 2.18.0 (note, I have no
particular reason to believe this is related just passing info).  I'm
running on Linux (64bit Ubuntu 18.04.1 but I've compiled Git myself
from source, I'm not using the distro version).

I have a local repository I've been using for about two years (the
.git/description file, which I don't use, has a TLM of July 31, 2016),
with lots of worktrees being created/pruned/etc. during that time.

Note I'm doing all these operations in the 'main' repository, not in
any of the worktrees.

Yesterday, when I tried to fetch from my upstream I got a notification
about GC needed.  Then GC failed with these errors (HEAD is set to
master which is the same as origin/master):

  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'HEAD' references pruned commits
  fatal: unable to read c104b8fb3631b5c54695206b2f73310c023c9963
  error: failed to run repack

I ran a git fsck --full which showed me a lot of dangling commits and
blobs, but no errors, no broken link messages, etc.

I ran git reflog expire --all --stale-fix but no change.

I can't find that SHA anywhere: I looked in .git/objects, etc.  I also
can't find any problems with my repo; obviously I haven't checked
everything but I can show the git log back to the initial commit, all
my stashes look fine, all my worktrees seem to be OK (git status etc.
work fine in all of them).

But whenever I pull etc. Git wants to run gc and I get this set of
errors again.  FWIW other repos created from the same remote don't show
any issues so it appears to be just this local copy of the repo.

I've seen many SO and blog posts about issues like this but all were
concentrating on recovering things and I don't even know if I've lost
anything... and anyway the operations they suggest don't work for me
because nothing can access that SHA; I just get "bad object".

Any ideas on what to look at next?

I would hate to have to throw this setup away since it has 23 stashes
and 25 worktrees in various states that would be annoying to have to
recreate... 
