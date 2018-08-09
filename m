Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3050C1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 03:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeHIFyr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 01:54:47 -0400
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:38926 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbeHIFyr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Aug 2018 01:54:47 -0400
X-Greylist: delayed 2408 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2018 01:54:46 EDT
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 56BC12175C0
        for <git@vger.kernel.org>; Wed,  8 Aug 2018 20:45:51 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id naxSfAdKZuL2QnaxTfSCTY; Wed, 08 Aug 2018 20:45:51 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aBUahMXuWwl3aBcEI9gQo2cGtx36bH9nSV7MjS/kRrY=; b=sGZVZFHj5/DExJDautris6eLpy
        ElwTd7D0r3PHUQgfaELe5rxe3qp90gou3MAAgk8aoxgurgDjW5ALX3WAbJ4sJL++/AGGB4aQxfPPl
        QVOFaIL43OmVrr/8o56f8tWXR;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:58462 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fnaxS-0003gV-LR; Wed, 08 Aug 2018 20:45:50 -0600
Message-ID: <249be5d3dada9a4b1b5282896a9a11e12c1ffd2a.camel@mad-scientist.net>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 08 Aug 2018 22:45:49 -0400
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
X-Exim-ID: 1fnaxS-0003gV-LR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:58462
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

Here we go.  I can rebuild with -Og or -O0 if more detailed debugging
is needed; most everything appears to be optimized out:

  ...
Compressing objects: 100% (107777/107777), done.
Writing objects:  54% (274416/508176)   
Thread 1 "git" hit Breakpoint 1, die (err=err@entry=0x5a373a "unable to read %s") at usage.c:119
119     {
(gdb) bt
#0  die (err=err@entry=0x5a373a "unable to read %s") at usage.c:119
#1  0x00000000004563f3 in get_delta (entry=<optimized out>) at builtin/pack-objects.c:143
#2  write_no_reuse_object () at builtin/pack-objects.c:308
#3  0x0000000000456592 in write_reuse_object (usable_delta=<optimized out>, limit=<optimized out>, entry=<optimized out>, f=<optimized out>) at builtin/pack-objects.c:516
#4  write_object (write_offset=<optimized out>, entry=0x7fffc9a8d940, f=0x198fb70) at builtin/pack-objects.c:518
#5  write_one () at builtin/pack-objects.c:576
#6  0x00000000004592f0 in write_pack_file () at builtin/pack-objects.c:849
#7  cmd_pack_objects (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/pack-objects.c:3354
#8  0x0000000000404f06 in run_builtin (argv=<optimized out>, argc=<optimized out>, p=<optimized out>) at git.c:417
#9  handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:632
#10 0x0000000000405f21 in run_argv (argv=0x7fffffffe210, argcp=0x7fffffffe21c) at git.c:761
#11 cmd_main (argc=<optimized out>, argc@entry=6, argv=<optimized out>, argv@entry=0x7fffffffe448) at git.c:761
#12 0x0000000000404b15 in main (argc=6, argv=0x7fffffffe448) at common-main.c:45
