From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Use "git pull --ff-only" by default?
Date: Mon, 24 May 2010 10:22:45 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483234FAA@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
 <4BF68F5F.9010309@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
 <4BF6A445.1030105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 24 10:23:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGSw8-0001Eq-JH
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab0EXIWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 04:22:53 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:51374 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab0EXIWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 04:22:52 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o4O8Mk6s019559;
	Mon, 24 May 2010 10:22:46 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 24 May 2010 10:22:46 +0200
Thread-Topic: Use "git pull --ff-only" by default?
Thread-Index: Acr4+QCBnFUwc60ISdSTZnJuchHYugCHVWyw
In-Reply-To: <4BF6A445.1030105@drmicha.warpmail.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147608>

> -----Original Message-----
> From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
> Sent: den 21 maj 2010 17:18
> To: Peter Kjellerstedt
> Cc: git@vger.kernel.org
> Subject: Re: Use "git pull --ff-only" by default?
> 
> Peter Kjellerstedt venit, vidit, dixit 21.05.2010 16:47:
> >> -----Original Message-----
> >> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org]
> >> On Behalf Of Michael J Gruber
> >> Sent: den 21 maj 2010 15:49
> >> To: Peter Kjellerstedt
> >> Cc: git@vger.kernel.org
> >> Subject: Re: Use "git pull --ff-only" by default?
> >>
> >> Peter Kjellerstedt venit, vidit, dixit 21.05.2010 14:59:
> >>> Is there some way to make "git pull --ff-only" be the default?
> >>> I could not find anything about this in "git config --help" and
> >>> also the lack of a --no-ff-only option for git pull (it exists
> >>> for git merge) indicates that there is no such support.
> >>>
> >>> I did considered the branch.<name>.mergeoptions configuration
> >>> option, but it does not seem appropriate as it only applies to
> >>> a specific branch, whereas I want it to apply to all branches
> >>> by default.
> >>>
> >>> Yes, I know I could do "git config alias.pl 'pull --ff-only'",
> >>> but since my intensions are for this to be the default for all
> >>> developers in our organization (most of whom have no git knowledge
> >>> at all yet) to avoid unnecessary branches caused by the developers
> >>> hacking directly on master rather than a topic branch, I would
> >>> very much prefer a configuration option rather than an alias (as
> >>> I am unlikely to get the developers to remember to do "git pl"
> >>> instead of "git pull").
> >>
> >> Problem is they have to remember to set your new config, or, if you
> >> are able to set all developers system config, they have to refrain 
> >> from overriding it.
> >
> > They would get it by default from our setup scripts. If they then
> > choose to turn it off, so be it.
> 
> If you're relying on setup scripts, you can
> 
> git config alias.pull 'pull --ff-only'

I forgot to mention that I had tried that. It does not work as git 
explicitly does not allow one to use a git command name as an alias 
name. And I think this is a good policy since it prevents people 
from aliasing plumbing commands to do weird things. However, I would
like to see some way to affect the defaults of porcelain commands.

> >>> My idea was to add something like merge.options and pull.options
> >>> as configuration options (I want to be able to specify the options
> >>> separately for pull and merge). However, I wanted throw this out
> >>> here first before starting to hack away at the code, in case I
> >>> missed something obvious, or if others find this to be an
> >>> incredibly stupid idea...
> >>
> >> In general, you can't control reliably what people do in their
> >> repos.
> >
> > I sure wish I had more control over it, but that is a separate
> > discussion. ;)
> >
> >> But you can control what kind of pushes into a central repo you
> >> allow. That is the usual approach: Let them mess up their repos, 
> >> they'll learn their lesson when they can't push ;)
> >
> > Can you differentiate between an automatic merge which happened
> > because the user had made some local changes before pulling (which
> > I do not want to appear in the central repo), and a real merge of
> > a topic branch (which I do want)?
> 
> I can't, and neither can Git. Who can?

Exactly. Which is why I would like for --ff-only to be the default
as I think that is more sane in an environment where most of the
users are git newbies.

> I think this boils down to having a few people who are allowed to push
> merges because they can make these decisions. Even if people don't
> merge "origin" but their own branches they can create a mess, so you 
> cannot differentiate based on that.

In a larger organization this does not work. Most of our developers
are responsible for at least one subsystem and expected to be the one 
responsible for its master branch. We cannot rely on a few git veterans 
to be the only ones with merging rights; it would never be accepted by 
the management...

> Michael

//Peter
