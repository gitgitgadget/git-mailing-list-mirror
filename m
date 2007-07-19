From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: Re: git svn dcommit seg fault
Date: Thu, 19 Jul 2007 15:16:39 -0700 (PDT)
Message-ID: <300238.5150.qm@web52802.mail.re2.yahoo.com>
References: <20070718073450.GA30559@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Eric Wong <eric@petta-tech.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 00:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBeIf-0007VQ-Qt
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 00:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762905AbXGSWQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 18:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761985AbXGSWQl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 18:16:41 -0400
Received: from web52802.mail.re2.yahoo.com ([206.190.48.245]:37812 "HELO
	web52802.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760009AbXGSWQk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 18:16:40 -0400
Received: (qmail 6187 invoked by uid 60001); 19 Jul 2007 22:16:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GStzfqQVicOywkTmSXoxjPGgOVTo58nePCV3bJpEOgnR5Qontoa1jQ+BQOJ+yM01H+E2hlaSoUhwkCO+mkRuNrV0PiZ7j0wLlZ8v/5by23ebiRItWXhynJ//WMDNflcFRaWynhckw4x+jr8rSSdRIkYof8CRGZLjJFKS1vVrToE=;
X-YMail-OSG: lTV4N8IVM1klAFK9b8vZkhCkCYwjIZspDKI.xd23A_S2ntYJxjA4jweVVR6hLXprlySfFt0zEG40naXIOxpkOnv9w8n7twfrEJeF9T8DfHJ7q2WBKQo-
Received: from [216.52.12.233] by web52802.mail.re2.yahoo.com via HTTP; Thu, 19 Jul 2007 15:16:39 PDT
In-Reply-To: <20070718073450.GA30559@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53034>


I did some more investigating on why git svn dcommit was seg faulting
for me, and I noticed that when I do my initial git svn clone 

$ git svn clone https://svn.eng.msli.com/perrin/trunk/TESTGIT/
TESTGIT_GIT/   

I always get an error
W: Ignoring error from SVN, path probably does not exist: (175007):
HTTP Path Not Found: REPORT request failed on
'/perrin/!svn/bc/100/trunk/TESTGIT':
'/perrin/!svn/bc/100/trunk/TESTGIT' path not found

This makes sense, since I did move my repo around a while back. Could
this be causing the seg fault problem I'm having with git svn
dcommit?

Just to be sure, I created a directory on our svn server's TEST2
repo, and I was able to use git svn to commit to it with git svn
dcommit just fine, so I think my git and svn setup is correct.

[perrin@whisper perrintest2_GIT]$ git svn dcommit
        M       testgit.c
Committed r130
        M       testgit.c
r130 = 01985d82b738b79bb479ef8817200ebe7c79eb94 (git-svn)
No changes between current HEAD and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn

Thanks,

Perrin




--- Eric Wong <eric@petta-tech.com> wrote:

> Perrin Meyer <perrinmeyer@yahoo.com> wrote:
> > 
> > I'm able to clone svn repo's fine with
> > 
> > $ git svn clone https://svn.eng.msli.com/perrin/trunk/TESTGIT/ .
> > 
> > and I'm then able to use git commit to commit local changes, but 
> > when I try 
> > 
> > $ git svn dcommit
> > 
> > I get
> > 
> > [perrin@whisper TESTGIT]$ git svn dcommit
> >         M       test.c
> > Committed r717
> > Segmentation fault
> 
> 
> > As far as I can tell, the commit worked fine (verified by trying
> 'svn
> > update' on another box).
> > 
> > I've tried git version 1.5.2.3, 1.5.3-rc2, and the latest build,
> and
> > all give the seg fault.
> > 
> > I'm guessing it has something to do with using the https
> connection to
> > svn?
> 
> I primarily work with https repositories using git-svn and I
> haven't
> seen any segfaults in a while.  Which version of the SVN libraries
> do
> you have?  (git-svn --version will tell you).
> 
> -- 
> Eric Wong
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
