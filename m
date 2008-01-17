From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Fri, 18 Jan 2008 10:05:50 +1300
Message-ID: <46a038f90801171305t78fa1758l9ddf2d70890aea9f@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
	 <86hcheig3n.fsf@blue.stonehenge.com>
	 <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org>
	 <478E3D8E.1090300@talkingspider.com>
	 <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org>
	 <478EEAC4.2010006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 22:06:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFbwM-0002y0-Nj
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 22:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYAQVFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 16:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYAQVFx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 16:05:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:16898 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYAQVFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 16:05:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so394004ugc.16
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 13:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+OuPXVFtmcd+k2BcGlYJFu1Ib3aThgCEL1qu8RaZBzI=;
        b=V5OIOpO23K63Ba20EO4zoRGEFP3uvOLfIlYf14S0pI1vCZZ75qDSb834xhZNA2BjLivyhDsMv15GyCKvcwxBzdf2J+nXd5h0Xi8g7H+yPBfEziv2Gt/XEXBoE07ipkzp8WDrdyJjcfsG3nrxICpisSHopl6N4nBtnQIEs09Ow4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qChtMXYS38RW5+BO6za4CDI3iFpQaGDmUKbb1C85qL7yc9yXE6AICYojVDqvCYmvbQIDns/cNwCNQlReXlSXvp3xn97ThMxbsnhg1QHYx+PfYER8E0FD/y9LstlBzy4xnijwfllHh6KGg4IEtNavsMUQDViJyDvVBnAQsgGuNVk=
Received: by 10.67.23.5 with SMTP id a5mr313491ugj.8.1200603950943;
        Thu, 17 Jan 2008 13:05:50 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Thu, 17 Jan 2008 13:05:50 -0800 (PST)
In-Reply-To: <478EEAC4.2010006@talkingspider.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70926>

On Jan 17, 2008 6:42 PM, Mike <fromlists@talkingspider.com> wrote:
> With PHP, Python, and Ruby, the development is the deployment.  The

Plenty here use git for web apps.

> There's a fundamental "best practice" of web development being violated
> here- keep your docroots clean, only put stuff in them that should go
> live (or should eventually go live when ready).  Other files should not
> live under docroot.

*First* - people here have pointed out various ways of doing this with
the GIT_DIR env variable. Nothing is being violated.

In terms of the best-practice you mention of publishing only the
reachable files, your checkout is one directory higher. The top-level
dir of your checkout should look like:

  .git
  htdocs # this is published
  conf # configuration files
  lib # libraries

if you publish the top of your checkout, your libraries sit in there.
Along your .git and your config files.

> Among the reasons for that is security.  If one of those .git dirs does
> slip out and go live, it's a *huge* *gaping* *security* *hole*.  You

Well -- I routinely add .git CVS and .svn to http.conf with a
directorymatch clause to prevent access to them. Just in case,
belts-and-suspenders.

> If we end up having to write a special "publisher" app to move files
> from dev to live, then it will only be because of those damn .git
> directories.

Nah! It'll be because of a long list of things, including temp files,
backup files that developers make, all sorts of things in your *work*
dir that you really need there and you really should _not_ have in the
production checkout.

BTW, I also add common patterns for those temp files to httpd.conf to
restrict access to them.

> Maybe git just isn't intended to be used for anything besides compiled
> languages like c?  Or maybe just not for web app development?

C produces a ton of intermediary files that git never commits, and C
projects usually get an "installer" too (debian's apt/dpkg, rpm, etc).
Writing PHP/Ruby/Python produces less "intermediary" files, but it
still creates some, so there's plenty of good reasons to have an
"installer".

GIT does the SCM thing, but for handling your deployment you need
something else. I normally use scripts that use git internally,
written in make, perl or shell.

cheers,



martin
