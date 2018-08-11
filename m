Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64F81F404
	for <e@80x24.org>; Sat, 11 Aug 2018 12:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHKOrW (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 10:47:22 -0400
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:56639 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727289AbeHKOrV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 10:47:21 -0400
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 8073914041D
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 06:13:19 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id oSljfGDIwak7toSljfOYiO; Sat, 11 Aug 2018 06:13:19 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PxqX7yuyTI/ncgctVCEqLm+0gp/BG1otzaPT9B/sjYk=; b=3FX/d6H+1P8M9elP+U4KgWEQkg
        IJ3I8T7WNoml5ULxsC4hznPOySL2DwE8Q0jiOYJ+KGKTuzApOSXH6PkEf2traYeIeh3C+/11Yu2PY
        WcqEg0oxhou3iIeO2MEl/SzGo;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:41836 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1foSli-003tof-Sk; Sat, 11 Aug 2018 06:13:19 -0600
Message-ID: <be46349efde84f158b80e96f2fbbcf4304a71208.camel@mad-scientist.net>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Sat, 11 Aug 2018 08:13:17 -0400
In-Reply-To: <20180808182436.GA19096@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
         <20180808160612.GC1607@sigill.intra.peff.net>
         <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
         <20180808182436.GA19096@sigill.intra.peff.net>
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
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1foSli-003tof-Sk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:41836
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-08-08 at 14:24 -0400, Jeff King wrote:
> If so, can you try running it under gdb and getting a stack trace?
> Something like:
> 
>   gdb git
>   [and then inside gdb...]
>   set args pack-objects --all --reflog --indexed-objects foo </dev/null
>   break die
>   run
>   bt
> 
> That might give us a clue where the broken object reference is coming
> from.

Oh no.  I messed up :(.

I rebuilt Git 2.18.0 without optimization to try to get more debug
information.  Unfortunately I didn't think to create a backup of my
problematic .git directory.

When I ran the above command under the debugger using the non-optimized 
version of Git... it worked!  That fixed the problem so that now when I
run "git gc" using the original optimized version I no longer see the
issue there either.

So... clearly something is wrong but because I was dumb and didn't make
a backup I can no longer reproduce the problem :(.  On the other hand,
my repository is no longer throwing errors so that's good.

I do still have these warnings and no amount of git gc/git fsck/etc.
has reduced them in any way:

$ git gc
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
Enumerating objects: 506556, done.
Counting objects: 100% (506556/506556), done.
Delta compression using up to 8 threads.
Compressing objects: 100% (101199/101199), done.
Writing objects: 100% (506556/506556), done.
Total 506556 (delta 358957), reused 506556 (delta 358957)
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
Checking connectivity: 506556, done.

I've run git gc --prune=all then git fsck reports only these dangling
commits:

dangling commit cef0678a5e0765506e3fac41286696fd37a9b1e9
dangling commit 1729195f021a1b95ea8ca10b9c32e76bf2257e67
dangling commit 08385b9731291607a8c6d4bf10272002d8f31e1f
dangling commit c4ddfb2139eeb5a3c132dbfc84cc6e27fdeb46d1
dangling commit 1df8ebcc1cd5f59dd224ce1f3ba39f24370cf4e7

(this is down from probably 50 or so "dangling ..." commits, blobs, and
trees before).
