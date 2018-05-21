Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9991F51C
	for <e@80x24.org>; Mon, 21 May 2018 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeEUPz3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 11:55:29 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:56428 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeEUPz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 11:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7qM0D6NovjkwXS3wGxRRUXgxRRGZeTq/8GCpImU9aBo=; b=qQmhTCvynEB+9NlcsLsbGrhOZ
        yn8MLsl7j/wjT7YY9mhl43olBVYvIBLLBI1hQvI8ambcX0tMGlMIf7APdn3qMh9tuKTLlVxceZP/J
        xDNOfWAb09OH6N8xFzAtOLprrt57TNlNmnjTbUEYCtII6MFDQDRj/umdOGJHhD5m6vxpI0OV989sy
        VhCstWP0JxCAH/tutmdw1M4RicqagwsS6AbGf+WDhaI1nTuQSxHOje0wPHRYE1ld5FZS9p6u2DdSg
        3bD0c1AsGK2o7AJcIS03aaepRTa6+ZY2RpXJM1XbY3gxzSGb0mrVHlbf+V8Fodss1LRW2GK/irITQ
        kS82eN5ZA==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:51984 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKn9i-00GGXm-3W; Mon, 21 May 2018 11:55:26 -0400
Date:   Mon, 21 May 2018 11:53:56 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
In-Reply-To: <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805211151360.17797@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 May 2018, Elijah Newren wrote:

> Hi Robert,

> I had always assumed prior to your email that 'known to Git' meant
> 'tracked' or 'recorded in the index'.  However, a quick `git grep -i
> known.to.git` shows that we're actually not consistent by what we
> mean with this phrase.  A little test setup:
>
>   $ echo ignoreme >>.gitignore
>   $ git add .gitignore
>   $ git commit -m ignoreme
>   $ touch ignoreme
>   $ git ls-files -o
>   ignoreme
>   $ git ls-files -o --exclude-standard
>   $
>
> >From Documentation/git-clean.txt:
>
>     Normally, only files unknown to Git are removed, but if the `-x`
>     option is specified, ignored files are also removed.
>
>   This implies that ignored files are not 'unknown to Git', or fixing the
>   double negative, that ignored files are 'known to Git':
>   $ git clean -n
>   $ git clean -nx
>   Would remove ignoreme
>   $

  uh oh ... i'm just now remembering a discussion once upon a time
where this wasn't simply a double negative. IIRC (and someone else
help me out here), "known to git" also meant known *not* to be tracked
or something like that (as in, ignored files).

  anyone remember that conversation?

rday
