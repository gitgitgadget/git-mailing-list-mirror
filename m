From: Stefan Sperling <stsp@stsp.name>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Tue, 19 Apr 2011 14:00:31 +0200
Message-ID: <20110419120031.GE4134@ted.stsp.name>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
 <vpqhb9vplu4.fsf@bauges.imag.fr>
 <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
 <20110419093108.GA7440@ted.stsp.name>
 <4DAD6FC4.6060004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 14:01:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC9cx-0005II-Kc
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 14:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab1DSMBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 08:01:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47714 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1DSMBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 08:01:49 -0400
X-Envelope-From: stsp@stsp.name
Received: from ted.stsp.name (ted.stsp.name [217.197.84.34])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p3JC0XrF008386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Apr 2011 14:00:33 +0200
Received: from ted.stsp.name (stsp@localhost [127.0.0.1])
	by ted.stsp.name (8.14.3/8.14.3) with ESMTP id p3JC0XRG023902;
	Tue, 19 Apr 2011 14:00:33 +0200 (CEST)
Received: (from stsp@localhost)
	by ted.stsp.name (8.14.3/8.14.3/Submit) id p3JC0V1c003950;
	Tue, 19 Apr 2011 14:00:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DAD6FC4.6060004@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171793>

On Tue, Apr 19, 2011 at 01:19:32PM +0200, Michael J Gruber wrote:
> Stefan Sperling venit, vidit, dixit 19.04.2011 11:31:
> > On Mon, Apr 18, 2011 at 10:55:18AM -0700, Junio C Hamano wrote:
> >> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> >>
> >>> Stefan Sperling <stsp@stsp.name> writes:
> >>>
> >>>> -DESIGN PHILOSOPHY
> >>>> ------------------
> >>>> -Merge tracking in Subversion is lacking and doing branched development
> >>>> -with Subversion can be cumbersome as a result.  While 'git svn' can
> >>>> track
> >>>
> >>> Agreed (this and the rest of the patch). Users reading git-svn's doc
> >>> don't want a dissertation about how bad SVN is, and if they do, they can
> >>> read whygitisbetterthanx ;-)
> > 
> > Exactly :)
> > 
> > And they might rather want to learn more about how Subversion has improved
> > since version 1.4. It seems that these parts of the text were written
> > before Subversion's 1.5 release. SVN is a lot more capable now than the
> > git-svn docs suggest and I'm surprised that git-svn's development seems
> > to have gotten stuck at the 1.4 level of functionality. Not even CentOS
> > ships with 1.4 anymore these days.
> > 
> > E.g. git-svn could be taught to generate svn mergeinfo compatible with other
> > Subversion clients. It's not easy to come up with a generic mapping between
> > the two systems but for some use cases it should be reasonably straightforward.
> > This would be a nice improvement towards making git-svn a proper drop-in
> > replacement for the standard svn client. Currently, git-svn cannot be
> > used without disturbing other users doing merges with Subversion itself
> > which is a pity.
> 
> 6abd933 (git-svn: allow the mergeinfo property to be set, 2010-09-24)
> 
> made a first step in that direction so that you can at least add
> mergeinfo manually.

Interesting. I didn't see this since I'm using the released version.

But I've been reading the most recent documentation file.
How come the documentation wasn't updated?
Is it intentionally not documented yet?

> But, git-svn.perl is basically in maintenance mode
> it seems, and more work is being done to implement a new svn remote helper.

Is there already code for this new helper I can look at?
 
> Also, I think merge tracking wasn't that reliable in svn 1.5 before svn
> 1.6, and we try to support older versions. In particular, we want to
> support the versions on typical svn hosting sites which are not always
> that recent.

"Not that reliable" is a pretty fuzzy statement that I cannot really
provide a specific answer to.

There were various implementation bugs in early 1.5 releases causing
miscalculations of mergeinfo. Those were client-side problems.
The client calculates mergeinfo and uses it to determine which revisions
to request during a merge. The server only stores mergeinfo and does not
evaluate it, expect in case of the -g option for "svn log" which makes
revisions from merged branches show up in the log output (analogous to
how individual branch commits are shown in gitk).

So it shouldn't matter much which version of the server a hosting site
is running. As long as the server is running some 1.5 release git-svn should,
in general, be able to cope just fine. Even with a 1.4 server git-svn could
commit svn:mergeinfo properties, though other svn clients won't bother using
them until the server and repository format is upgraded.

Maybe there was some server-side problem that prevented you from doing
something specific? In general it really shouldn't matter.
