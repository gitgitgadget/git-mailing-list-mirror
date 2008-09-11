From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 17:01:18 -0400
Message-ID: <20080911210118.GO5082@mit.edu>
References: <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org> <20080911192356.GC1451@cuci.nl> <alpine.LFD.1.10.0809111534300.23787@xanadu.home> <20080911195516.GE1451@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdtJQ-0005hc-UJ
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYIKVBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbYIKVBl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:01:41 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:62173 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960AbYIKVBk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 17:01:40 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8BL1KG7024737;
	Thu, 11 Sep 2008 17:01:20 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8BL1Ihx025949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Sep 2008 17:01:18 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KdtHy-0002Jp-AJ; Thu, 11 Sep 2008 17:01:18 -0400
Content-Disposition: inline
In-Reply-To: <20080911195516.GE1451@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95645>

On Thu, Sep 11, 2008 at 09:55:16PM +0200, Stephen R. van den Berg wrote:
> >  Having it versionned also 
> >means that older git versions will be able to carry that information 
> >even if they won't make any use of it, and that also solves the 
> >cryptographic issue since that data is part of the top commit SHA1.
> 
> It would allow the data to be faked, that is undesirable for "git blame".

Why would this matter?  The information is largely
self-authenticating.  If a commit claims to have come from some other
cherry-pick, a human taking a quick look at it would know instantly
that this wasn't true.  So what's the harm done if some incorrect
information gets introduced?  "git blame" is something which is
generally used by humans, not by automated programs.

Also, what's the attack scenario?  The person who originally makes the
commit can easily fake the origin link information.  They can hack git
to fill on some other commit ID, for example.  So what you are
protecting against is someone after the fact adding the annotation
that this commit was related to this other commit.  When would this be
a bad thing to do?  If they are adding correct information, it's a
good thing.  If they add incorrect information, what's the harm they
can as a result of being able to add the incorrect information.
(Noting that if this annotation file is kept under git control, you
can use what ever access controls and/or process controls that verify
that a new cherry-pick --- or a commit claiming to be a cherry-pick
--- is valid and should be accepted into the master git repository for
that project.

						- Ted
