From: Ron Garret <ron1@flownet.com>
Subject: Re: My use case
Date: Sat, 30 Jan 2010 00:54:13 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-CC0A6E.00541330012010@news.gmane.org>
References: <ron1-09825C.00261930012010@news.gmane.org> <1264840729-sup-5264@ezyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 09:54:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb96Q-0007hC-SQ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 09:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab0A3Iyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 03:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298Ab0A3Iyh
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 03:54:37 -0500
Received: from lo.gmane.org ([80.91.229.12]:56079 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270Ab0A3Iyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 03:54:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb96B-0007by-IQ
	for git@vger.kernel.org; Sat, 30 Jan 2010 09:54:35 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 09:54:35 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 09:54:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138466>

In article <1264840729-sup-5264@ezyang>,
 "Edward Z. Yang" <ezyang@MIT.EDU> wrote:

> Excerpts from Ron Garret's message of Sat Jan 30 03:26:19 -0500 2010:
> > In other words, it is not uncommon to want to roll back an individual 
> > file or set of files to an earlier version and leave the rest of the 
> > tree alone.  git can do this, but it's not straightforward.  Simply 
> > rolling back through the history of the current branch doesn't work 
> > because you might want to roll back file A, but the last dozen revisions 
> > or so have been changes to file B.  You might also want to roll both A 
> > and B back to states which never co-existed in the original history.
> > 
> > One approach is to use git rev-list to find those commits where 
> > particular files changed, but this is sub-optimal for several reasons.  
> > First, a naive approach calls rev-list for every rollback, and rev-list 
> > has to traverse the entire history, so it's very inefficient.  Second, 
> > if you roll back a single file, git doesn't keep track of that file's 
> > provenance, so you have to manually track which files and have been 
> > rolled back and which revisions they have been rolled back to.  (There 
> > was a third problem but I can't think what it was right now.)
> 
> My approach, in this case, would be to use git log, possibly git log -p,
> in order to view the changes in each file you were interested in rolling
> back.  If the rollback falls on a commit boundary, great; you can use
> `git checkout rev -- path`.  If not, you can perform that, and then
> use git checkout -p to selectively revert hunks in the patch (fundamentally,
> you can't really get better than that).

Don't forget, I'm integrating this *into* the IDE, not just using it 
*for* the IDE.  So I want to just have a context menu on each code 
window with "SNAPSHOT" and "ROLLBACK" items that Just Work.  The casual 
user won't even know that there's git behind the scenes.

> > I have this intuition that git can be made to really do this right by 
> > keeping a separate history of every individual file in addition to a 
> > history of the entire source tree.  Git can't do this directly as far as 
> > I know.  I'd be writing additional code to generate extra tree and 
> > commit objects every time a file was saved from the IDE.  But turning 
> > this intuition into reality is turning out to be quite challenging.  So 
> > I'm going with the rev-list approach for the first version despite its 
> > shortcomings.
> 
> While Git's ability to look at individual file's history is "slower", it's 
> still
> quite excellent, and you are encouraged to use it as necessary.

Good to know.

> Slightly relatedly, I'd recommend flushing to disk and committing more
> often.  It's great that the LISP REPL allows for more daring changes,
> but having a history either way is very helpful!

Yep!  Save early, save often.  I'm actually considering an auto-save 
option where it takes a snapshot every time you evaluate a form after 
making a change.

rg
