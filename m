Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4B9C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 10:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3BF61982
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 10:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhF1KNI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Jun 2021 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhF1KNH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 06:13:07 -0400
Received: from mx1.uni-regensburg.de (mx1.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:3:bdf7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92579C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 03:10:42 -0700 (PDT)
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 1DAB56000049
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:10:37 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id E60D5600004F
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:10:36 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 28 Jun 2021 12:10:36 +0200
Message-Id: <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Mon, 28 Jun 2021 12:10:36 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <peff@peff.net>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Subject: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
 <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
In-Reply-To: <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Jeff King <peff@peff.net> schrieb am 24.06.2021 um 17:41 in Nachricht
<YNSnlhbE30xDfVMY@coredump.intra.peff.net>:

[...]
> One thing you may not like, though: both the builtin version and that
> patch only put the funcname context in the _first_ hunk of the split.
> Doing it for subsequent hunks is much trickier, since there can be a
> funcname in the split context itself. E.g.:
> 
>   @@ ... @@ void foo()
>            int x;
>   -        int y = 1;
>   +        int y = 2;
>    
>   -        x = 3;
>   +        x = 4;
>    }
> 
> could split into two hunks, both annotated with "void foo()". But:
> 
>   @@ ... @@ void foo()
>            int x;
>   -        x = 3;
>   +        x = 4;
>    }
>    void bar()
>    {
>   -        int y = 1;
>   +        int y = 2;
>    }
> 
> would be wrong to say "void foo()" for the second hunk. We'd have to
> re-scan the interior context lines for a funcname to find it. That's
> all-but-impossible in the perl version, but might be do-able in the C
> version (since it has easy access to the funcname-matching patterns and
> machinery).

There always was a related bug (IMHO) that showed the context of the previous function even though the actual change was within a new function (that starts within the context lines). So if that bug were fixed, my guess is that the other would be as well.
However I don't know how easy or hard the fix will be.
Maybe the "definition" of function context is just different; I don't really know.

> 
> -Peff
> 
> [0] I'm not sure what the timetable is for switching to the C version of
>     add--interactive. If it's going to be a while, I don't mind moving
>     forward the other patch I showed. But maybe the time is here to
>     think about switching the default of add.interactive.useBuiltin, and
>     ironing out any final bugs?




