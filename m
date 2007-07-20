From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 15:33:47 +0200
Message-ID: <86fy3jurlw.fsf@lola.quinscape.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <200707201418.26534.johan@herland.net> <86odi7utdj.fsf@lola.quinscape.zz> <200707201520.55911.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 15:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBsey-0008Ve-Ec
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 15:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657AbXGTNgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 09:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbXGTNgl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 09:36:41 -0400
Received: from main.gmane.org ([80.91.229.2]:55665 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbXGTNgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 09:36:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBseN-0006Kq-CP
	for git@vger.kernel.org; Fri, 20 Jul 2007 15:36:07 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 15:36:07 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 15:36:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:pko2g9shvBP/gCvULtqD8hVQTO4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53094>

Johan Herland <johan@herland.net> writes:

> On Friday 20 July 2007, David Kastrup wrote:
>> Johan Herland <johan@herland.net> writes:
>
>> > 4. Whether or not git should track directories by default. You
>> > say yes, I say no.
>> 
>> Element of least surprise.  But since my proposal allows easy and
>> intuitive declaration of the preference at user, project, and
>> directory level without one choice messing with the choice of other
>> projects and contributors with mixed preferences, this is quite
>> unimportant.
>> 
>> We are in agreement that adding or removing the tracking explicitly
>> for a single directory might be useful to have.  But it can't be
>> the only way.
>
> As long as you can add/remove tracking recursively for a whole
> (sub)tree, I don't see what's the problem.

Neither do I.  But a --directory option never is recursive.  That is
the whole point.

Probably we are in violent agreement again.

> Of course, if you want to change the default behaviour, you should
> be able either set a config variable somewhere, or - as a last
> resort - alias git-add and git-rm to always supply the appropriate
> command-line option.

Or declare diverging behaviors using a !. or . entry in the gitignore
mechanisms.  Which work everywhere where we need them.

>> > 5. How the tracking of directories should be implemented in git's
>> > object database. I want to keep the index/tree as-is except for
>> > adding directory entries (w/mode 040000) for the tracked
>> > directories only. You seem to want to add directory entries for
>> > _all_ directories and then additional "." entries for directories
>> > you don't want deleted if/when empty.
>> 
>> No.  I don't want to change _anything_ for untracked directories.
>> They are, as previously, implied by the contents and have a "tree"
>> entry for efficiency reasons.  Nothing new here.
>> 
>> The directory mode entries are named "." and are for tracked
>> directories only.
>
> Ok. So our difference in opinion on implementation is even smaller
> than I imagined; basically only whether the directory is tracked by
> a mode "040000" entry, or by a "." entry.

Actually, even smaller: I'd track them by a "." entry with mode
1777755755 or whatever is the natural expression for "this is a
directory".  The mode would be different from the existing "this is a
tree".

_If_ one wants at one time track permissions of files apart from "x",
the "." entry would be natural for carrying directory permissions.
Without ".", you basically tell git "I don't care about the existence
of this directory.  Just do what is necessary for checking out my
files".

>> > Am I making sense, or have I misunderstood our misunderstandings?
>> 
>> The latter.  You are violently arguing for what I outlined.  Which
>> probably shows that I am not the best at explaining my ideas, and
>> that it reflects badly upon them.
>
> That probably goes for both of us :)
>
> Well, as long as we have this clarified, I don't see much point in
> continuing this part of the thread. I feel confident that the git
> community as a whole will converge on the best technical solution,
> once it surfaces.

I'll probably crank out some insolently primitive proof of concept
eventually.

-- 
David Kastrup
