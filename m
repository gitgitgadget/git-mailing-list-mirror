Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC3E20373
	for <e@80x24.org>; Sun,  8 Oct 2017 12:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbdJHMpT (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 08:45:19 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:51724 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdJHMpS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 08:45:18 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38658 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e1AxJ-0007CE-HF; Sun, 08 Oct 2017 08:45:17 -0400
Date:   Sun, 8 Oct 2017 08:45:15 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <05775b3d-2e88-9ceb-e8d2-8ff2373cfdb5@web.de>
Message-ID: <alpine.LFD.2.21.1710080843320.22844@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain> <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain> <05775b3d-2e88-9ceb-e8d2-8ff2373cfdb5@web.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-935756256-1507466717=:22844"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-935756256-1507466717=:22844
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 8 Oct 2017, René Scharfe wrote:

> [My SMTP server still refuses to accept emails to rpjday@crashcourse.ca
>  and reports "mailbox unavailable" and "invalid DNS MX or A/AAAA resource
>  record."  So just replying to the list.]
>
> Am 08.10.2017 um 13:56 schrieb Robert P. J. Day:
> >    but as i asked in my earlier post, if i wanted to remove *all* files
> > with names of "Makefile*", why can't i use:
> >
> >    $ git rm 'Makefile*'
> >
> > just as i used:
> >
> >    $ git rm '*.c'
> >
> > are those not both acceptable fileglobs? why does the former clearly
> > only match the top-level Makefile, and refuse to cross directory
> > boundaries?
> >
> >    $ git rm -n 'Makefile*'
> >    rm 'Makefile'
> >    $
>
> Try:
>
> 	$ git rm -n '*Makefile'
>
> The whole path is considered.  The asterisk there matches any
> directory part -- but also any file name prefix.  Check the entry
> for "pathspec" in gitglossary(7) for more details.

  but "*Makefile" is not the wildcard pattern i'm interested in.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-935756256-1507466717=:22844--
