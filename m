From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support (was Re: limiting
   relationship of git dir and worktree)
Date: Tue, 26 Aug 2008 09:35:50 +0200
Message-ID: <48B3B256.6010609@fastmail.fm>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu> <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <20080824235124.GA28248@coredump.intra.peff.net> <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Karl Chen <quarl@cs.berkeley.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 09:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXt79-0002gS-GF
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 09:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYHZHgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 03:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYHZHgL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 03:36:11 -0400
Received: from main.gmane.org ([80.91.229.2]:56213 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbYHZHgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 03:36:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXt5v-0002YC-Ew
	for git@vger.kernel.org; Tue, 26 Aug 2008 07:36:03 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 07:36:03 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 07:36:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93721>

Junio C Hamano venit, vidit, dixit 25.08.2008 02:30:
> Jeff King <peff@peff.net> writes:
> 

>> Well, as a non-user of this feature, I certainly have no argument
>> against taking it out. Maybe the subject line will pull some other
>> people into the discussion.
> 
> Heh, if we are to do the attention-getter, let's do so more strongly ;-)

Sorry for being late to the discussion.

I think there are many use cases or environments which differ
substantially from those of the "typical" developer; this implies that
they differ from those of the typical git contributor, which naturally
leads to a certain bias in discussions like this one.

"Typical" developers track source code in the proper sense (somewhere in
$HOME); on local file systems; mostly on machines where they have root
access, or least can get extra accounts (for gitosis) or a port for "git
daemon" etc; they collaborate with peers for whom basically the same
assumptions apply.

Now think of a user say in academics, who tracks "source code" for
scientific papers (somewhere in $HOME) but also needs to track, e.g.,
central web pages or other "sources" where he has partial write access
but can't have ".git" in place (and shouldn't change ownership &
permissions), but needs to be aware of changes and log own changes; on
NFS; no extra accounts but in need of an authenticated protocol (papers
in progress are private, public only when published); who collaborates
with peers for whom the same assumptions apply, except most certainly
for git usage...

Yes, that's me, but also many others, I would think and hope, at least
increasingly so. That second scenario is one where I have to cope with
how things are set up centrally, making the best possible use of git.

I would imagine that many corporate environments are basically similar,
if individual employees want to use git without central support.

These remarks apply to the discussion about an authenticated protocol
(some way for secure, private pull&push for users with access to $HOME
and maybe cgi-bins), but also here:

I need to keep .git away from the work tree for several projects. Using
--git-dir etc. leads to problems with some commands, especially
git{k,-gui,-citool}. I found the most robust solution to be an alias
(shell) which guesses the work tree (from core.worktree etc.) and cd's
there before doing anything. This also solves the problems with diff.

I would strongly advocate for keeping the possibility of separating
git-dir and work-tree, and possibly dropping the assumption that
everything "foo.git" is a bare repo. There are config variables for
this. The Tcl/Tk family I mentioned makes even stronger assumptions. I
promise to have a look at these when I find time (oh yeah...).

Michael
