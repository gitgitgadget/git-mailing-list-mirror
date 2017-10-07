Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D502036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdJGTMG (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:12:06 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:33847 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdJGTMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:12:05 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:33442 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e0uW4-00058h-Bd; Sat, 07 Oct 2017 15:12:04 -0400
Date:   Sat, 7 Oct 2017 15:12:01 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Todd Zullinger <tmz@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <20171007190402.GH3382@zaya.teonanacatl.net>
Message-ID: <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 7 Oct 2017, Todd Zullinger wrote:

> Robert P. J. Day wrote:
> >
> >  was just testing variations of "git rm", and man page claims:
> >
> >  -r     Allow recursive removal when a leading directory name is given.
> >
> > i tested this on the "pro git" book repo, which contains a top-level "book/"
> > directory, and quite a number of "*.asc" files in various subdirectories one
> > or more levels down. i ran:
> >
> >  $ git rm book/\*.asc
> >
> > and it certainly seemed to delete *all* "*.asc" files no matter where they
> > were under book/, even without the "-r" option.
> >
> >  am i misunderstanding something?
>
> By shell-escaping the *, you're letting git perform the file glob.  The
> DISCUSSION section of git-rm(1) says "File globbing matches across directory
> boundaries."
>
> # With bash performing file globbing
> $ git rm -n Documentation/*.txt | wc -l
> 199
>
> # With git performing file globbing
> $ git rm -n Documentation/\*.txt | wc -l
> 578

  ok, in that case, can you give me an example where "-r" makes a
difference, given that the man page refers to "a leading directory
name being given"? let's use as an example the linux kernel source,
where there are a *ton* of files named "Makefile" under the drivers/
directory.

  should there be a difference between:

  $ git rm drivers/Makefile
  $ git rm -r drivers/Makefile

clearly, i have a "leading directory name" in both examples above ...
what should happen differently?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
