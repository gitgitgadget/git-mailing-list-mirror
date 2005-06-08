From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: Re: "git cvsimport"
Date: Wed, 8 Jun 2005 00:32:40 -0500
Message-ID: <20050608053240.GA28007@immutable.crsr.net>
References: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 07:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dft7a-0004ed-Ap
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 07:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVFHFcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 01:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVFHFcu
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 01:32:50 -0400
Received: from [65.98.21.155] ([65.98.21.155]:64011 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S262106AbVFHFcr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 01:32:47 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1DftBA-0007zj-00; Wed, 08 Jun 2005 00:32:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2005 at 04:03:53PM -0700, Linus Torvalds wrote:
> 
> Ok,
>  here's something for testers and/or documentation people: I wrapped a 
> little script around cvs2git (which I imported from the git tools thing), 
> and now you can do
> 
> 	git cvsimport <cvsroot> <modulename>
> 
> and it might all "just work".
> 
> Right now the little sript is actually being anal and checking that 
> CVSROOT is a directory, even though I think it all _should_ work even if 
> CVSROOT is remote too. But I don't have any remote things to test, and for 
> all I know maybe performance is horrible, so for now it artificially 
> limits it to locally accessible CVS repos.
> 
> I'd love it if somebody tested the remote case (and, if it works, sends me
> a patch that just removes the anal tests in git-cvsimport-script), and
> maybe even updated the information a bit more.. As it is, that
> Documentation/cvs-migration.txt file is a bit on the light side.
> 
> Finally, I don't know what to do about cvsps options. It seems that the 
> default time-fuzz is a bit too long for some projects, so at least that 
> one should be overridable. So my silly script is not exactly wonderful, 
> but I think it's more approachable than people doing the magic by hand 
> (and forgetting to set TZ to UTC and the "-A" flag etc etc).
> 
> 		Linus

It seems to work for me.  I'm still sanity checking the results.

Performance is indeed horrible for the remote case.  I don't know how
horrible it would be for someone in a sane environment, since I'm behind
one of SBC's DSL gateways, which thinks (emphasis on "thinks") it is a
nameserver.

The script produced by cvs2git checks out every revision of every file,
right?  Would "cvsps -g -p<dir>" improve cvs2git?  I don't think it
would help performance (it checks out the files to generate the patchset
diffs (?)), but making the ugly someone else's problem is always good.
Also, what about -x, to force cvsps to regenerate it's cached idea of
the repository's patchsets?

cvsps seems a little weak on the whole error message idea (misspelling
cvsroot leads to complaints about CVS versions).  

-- 
Tommy McGuire
