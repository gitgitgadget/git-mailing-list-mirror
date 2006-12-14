X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 13:14:07 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141311310.18171@xanadu.home>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 18:14:44 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <4581573E.40803@op5.se>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34380>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guv6O-0007pw-M5 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 19:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751961AbWLNSOK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 13:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWLNSOJ
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 13:14:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34241 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751961AbWLNSOI (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 13:14:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA9006KIZZJGY60@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 13:14:07 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Andreas Ericsson wrote:

> Andy Parkins wrote:
> > Hello,
> > 
> > I've got a big repository.  I've got two computers.  One has the repository
> > up-to-date (164M after repack); one is behind (30M ish).
> > 
> > I used git-fetch to try and update; and the sync took HOURS.  I zipped the
> > .git directory and transferred that and it took about 15 minutes to
> > transfer.
> > 
> > Am I doing something wrong?  The git-fetch was done with a git+ssh:// URL.
> > The zip transfer with scp (so ssh shouldn't be a factor).
> > 
> 
> This seems to happen if your repository consists of many large binary files,
> especially many large binary files of several versions that do not deltify
> well against each other. Perhaps it's worth adding gzip compression detecion
> to git? I imagine more people than me are tracking gzipped/bzip2'ed content
> that pretty much never deltifies well against anything else.

If your remote repository is fully packed in a single pack that should 
not have any impact on the transfer latency since no attempt to 
redeltify objects against each other is attempted by default when those 
objects are in the same pack.


