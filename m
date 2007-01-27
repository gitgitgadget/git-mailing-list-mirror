From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 17:30:59 +0100
Organization: At home
Message-ID: <epfulr$787$1@sea.gmane.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BB5888.9020608@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 17:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAqRG-0002QH-VD
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 17:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbXA0QaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 11:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXA0QaA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 11:30:00 -0500
Received: from main.gmane.org ([80.91.229.2]:54910 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbXA0Q37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 11:29:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAqRA-00044d-Mw
	for git@vger.kernel.org; Sat, 27 Jan 2007 17:29:56 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 17:29:56 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 17:29:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37959>

Simon 'corecode' Schubert wrote:
> Johannes Schindelin wrote:

>> It is slower than Subversion's counterpart, just because SVN's blame 
>> sucks. You cannot find out the _relevant_ information easily, i.e. once 
>> you merged something, the _merge_ gets attributed for the change (at
>> least the last time I tried it).
>> 
>> So, don't blame blame for being useful in git.
> 
> Your reasoning is backwards.  Git's blame (or fwiw, rev-list path.name)
> is not slower because it is doing a better job (I can't tell, I don't
> use svn), but because it uses an algorithm which doesn't scale.
> rev-list and blame are O(number of commits between HEAD and root) and not
> O(number of commits affecting path).  It might be sufficient for git.git,
> but certainly not for projects with a long history.  we are talking KDE,
> FreeBSD, OOo, something like this.  They each got about 400k commits.
> It takes literally *minutes* to get a rev-list or a blame for a certain
> path.  The algorithm simply does not scale.  And this has nothing to do
> with superior output, because hg does it in O(num_of_file_revs), so it
> *can* be done.          

Mercurial (hg) has different repository structure, with changesets in
per filename "buckets", tied together with mainfest file and changelog
file. So it is easy to get per file history in hg, while it is harder
to get per commit (general) history; contrary to git where it is easy
to get per commit (general) history, and it is harder to get per file
history.

On the other hand IIRC Mercurial, due to its repository structure, has some
problems with file copying and renames, not to mention more complicated 
contents movement (of which git-blame is aware of). Perhaps this structure
is/was also the cause that Mercurial is geared towards one branch per
repository workflow.
 
>> Of course, you could introduce a cache, but then, I don't run blame
>> _that_ often.
> 
> I don't think a cache is the right way.  I'd call the right idea
> "auxillary information". 

If the information can be regenerated, this is cache. (Well, this is
one point of view).

P.S. In git we can use so called pickaxe (options to git-diff/git-log)
besides using annotate/blame.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
