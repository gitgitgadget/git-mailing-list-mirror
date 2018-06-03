Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8860F1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 09:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeFCJz2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 05:55:28 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:55296 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeFCJz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 05:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MLmgvTDzaBFT9jmtSCYaltJYq/OEyWgMcB+a3+o25lA=; b=fohZergN7ijyqRPPKjA6OY31k
        9CH6Pzn0salfvxScif+zpFJIcqWfYijW4tyrDc8ELZ4fYcw55jsZhkS+6zJ+OV8o/UTyIaquvTq6Z
        pjOnxeXh5dqRhz0nt3WDZixPPeS6zivYzP/+b+Qay3P4/ZHnMhLyXQfD0PojeO+dxX+uVml++9hQa
        HjKmRnNhovaVSuG3lf5Uy8a6/1YurpcDSkAqGEbszWdJi4dm3Gz/LwShIxpEcuxq+x0zi0a7q81hl
        XdCqIz87uVsIrgEbMjAhlp+HCmivhfsAFTVsBqns3hf5n4H3MUVjwAU+QTQjC/hxX8qAoBBA6dx0I
        0o7RhNjqQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:57374 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPPjP-003v7j-Qe; Sun, 03 Jun 2018 05:55:25 -0400
Date:   Sun, 3 Jun 2018 05:53:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
In-Reply-To: <20180601210731.GA20974@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain> <20180601210731.GA20974@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
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

On Fri, 1 Jun 2018, Jeff King wrote:

> On Fri, Jun 01, 2018 at 04:14:12PM -0400, Robert P. J. Day wrote:

... snip ...

> >   ok, so how on earth would i use "git config" at the command line
> > to set a config variable with some arbitrary level of subsections?
> > let's try this:
>
> You don't. There are only three levels: section, (optional)
> subsection, and key. If there is a subsection, it consists of
> _everything_ between the two outer periods.
>
> >   $ git config --global a.b.c.d.e rday
> >
> > huh ... seemed to work fine, and added this to my ~/.gitconfig:
> >
> >   [a "b.c.d"]
> >           e = rday
> >
> > as i see it, the first component is intgerpreted as the section name,
> > the last component is the variable/key(?) name, and everything in
> > between is treated as subsection(s), which is not at all obvious from
> > that Doc file, or from "man git-config".
>
> Yep, your understanding is correct.
>
> >   and if a section name can contain periods, how would you specify
> > that at the command line?
>
> You can't, because section names cannot contain periods. ;)

  if (for some weird reason) i wanted to define a multi-level
subsection, is there any benefit to using periods as i did above, as
opposed to any other delimiting character? apparently, running this:

  $ git config --global a.b_c_d.e rday

dumps this into my ~/.gitconfig:

  [a "b_c_d"]
	e = rday

if i wanted to do something this admittedly awkward, would using
periods give me some benefit related to, i don't know, regex matching,
as compared to using a different character? or am i just way
overthinking this? is anyone out there actually taking advantage of
multi-level subsections?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
