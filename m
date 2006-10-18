From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 11:07:34 +0200
Message-ID: <200610181107.35173.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45359B2A.1070102@utoronto.ca> <4535E844.8010604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 11:07:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7Oa-0004AJ-IU
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWJRJHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJRJHE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:07:04 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:10985 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751056AbWJRJHC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 05:07:02 -0400
Received: by qb-out-0506.google.com with SMTP id p36so662669qba
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 02:07:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZKQcAbS4MxByM+AopQJ6ihZuU+QtF0n0KbDdnsxIrIA3lG25njbTKxOq+0CpzO2w/o9AR3Dma1XVy48fZNo0tgjoQAHMhCGxdMMpQS0i8I3JvD7SIEaX/qevjOVqb/UdVDlVg7Um7pXDIqcBlIQCrskfIPJsHY4AocFR+8e317o=
Received: by 10.66.244.10 with SMTP id r10mr11404524ugh;
        Wed, 18 Oct 2006 02:07:00 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 27sm761017ugp.2006.10.18.02.06.59;
        Wed, 18 Oct 2006 02:07:00 -0700 (PDT)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.9.3
In-Reply-To: <4535E844.8010604@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29209>

Andreas Ericsson wrote:
> Aaron Bentley wrote:
>> Well, there's distributed, and then there's *DISTRIBUTED*.  We don't
>> quasi-randomly merge each others' branches.  We have a star topology
>> around bzr.dev.  So when we refer to revnos, they're usually in bzr.dev.
>> 
> 
> So in essence, the revnos work wonderfully so long as there is a central 
> server to make them immutable?
> 
> Doesn't this mean that one of your key features doesn't actually work in 
> a completely distributed setup (i.e., each dev has his own repo, there 
> is no mother-ship, everyone pulls from each other)?
> 
> I can see the six-line hook that lays the groundwork for this in git 
> before me right now. I'll happily refuse to write it down anywhere. I 
> get the feeling that sha's are easier to handle in the long run, while 
> revno's might be good to use in development work. In git, we have 
> <branch/tag/"committish">~<number> syntax for this.
> 
> In my experience, finding the revision sha of an old bug is what takes 
> time. Copy-paste is just as fast with 20 bytes as with 4 bytes. Honestly 
> now, do you actually remember the revno for a bug that you stopped 
> working on three weeks ago, or do you have to go look it up? If someone 
> wants to notify you about the revision a bug was introduced, do they not 
> communicate the revno to you by email/irc/somesuch?

Revnos were supposed to be superior to using sha1 (or shortened sha1)
as commit identifiers because of two key features:
 1. They were simplier than sha1, therefore easier to use
 2. Given two revisions related by lineage (i.e. one is ancestor of
    the other) you can from a glance know which revision was earlier

But the details invalidated 1.: for complicated history, for a large
project, with many contributors and nonlinear development we have 
www.repository.com:127.2.31.57 vs 988859a (7 chars shortcut of sha1)
to have immutable revno. And we have to use _immutable_ (up to few
years) revison identifiers, unless we want our "simple ids" scheme
to make a mess...

And I'm not sure if 2. is true, if even for revisions with direct
lineage we don't have to compare 127.15.2.16 with 210.2.20.3 for
example. Having generation number would solve 2.; as of now git
check for fast-forward case by checking if merge-base of two
revisions is one of the revisions.
-- 
Jakub Narebski
Poland
