From: Johan Herland <johan@herland.net>
Subject: Re: cvs revision number -> git commit name?
Date: Wed, 27 Jan 2010 00:43:44 +0100
Message-ID: <201001270043.44614.johan@herland.net>
References: <hbf.20100126bda0@bombur.uio.no>
 <bc341e101001261453u16124186i298a53ead0b4eee2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Aaron Crane <git@aaroncrane.co.uk>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 00:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZvBi-0007mZ-AA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 00:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab0AZXoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 18:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762Ab0AZXoA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 18:44:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:53535 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754711Ab0AZXn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 18:43:58 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWV00G24OL9JR60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 00:43:57 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWV00M3MOL2OZ40@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 00:43:57 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.26.233333
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <bc341e101001261453u16124186i298a53ead0b4eee2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138089>

On Tuesday 26 January 2010, Aaron Crane wrote:
> Hallvard B Furuseth <h.b.furuseth@usit.uio.no> wrote:
> > When moving from CVS to Git, what's a good way to help Git users
> > find an old commit given the original CVS revision number?  Are
> > there tools available to help?
> >
> > One could commit a table with a (file,revision)->commit mapping,
> > I suppose something can generate it when importing from cvs?
> 
> That's what we decided to do on a recent CVS-to-Git conversion, though
> like you, we also considered munging the log messages instead.  Our
> jury's still out on whether it was the right decision; we haven't had
> much cause to use the result yet.
> 
> One thing to be aware of (beyond the need to run grep to convert old
> CVS revision numbers to Git commit IDs) is that there's a good chance
> the mapping file will pollute the results of `git grep` for some
> tasks.  (We've put the mapping file into our repo, where it's easy to
> find.)  I'm considering gzipping the mapping file as a workaround;
> that would mean our users will need to use zgrep (or equivalent) to
> look up CVS revision numbers, which may or may not be a problem in
> your situation.
> 
> I have an initial patch to git-cvsimport that adds a switch to
> generate the mapping as it goes.  I'm currently trying to find time to
> clean it up and submit it.

You could consider adding the CVS revision numbers as notes (see "git help 
notes" in >= v1.6.6) to the corresponding commits. Then they don't pollute 
the commit messages, but instead live in a separate, but parallel hierarchy 
that can be easily pulled in when you need to reference them (e.g. 
GIT_NOTES_REF="refs/" git log).

The notes feature is still very new, and there are still outstanding patches 
to be merged, but the basics are there in v1.6.6.

FWIW, I was also working on a CVS-to-Git importer (based on what has later 
become the transport-helper infrastructure), that used notes to store 
exactly the metadata you mention above. However, I haven't worked on it for 
a while, and I probably won't have time to pick it up in the immediate 
future.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
