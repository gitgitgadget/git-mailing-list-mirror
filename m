From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:34:01 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-1F1799.13340029012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <op.u7a909hf4oyyg1@alvarezp-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 22:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayU6-0001qD-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0A2Vea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902Ab0A2Vea
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:34:30 -0500
Received: from lo.gmane.org ([80.91.229.12]:35375 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab0A2Ve3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:34:29 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NayTy-0001nD-TU
	for git@vger.kernel.org; Fri, 29 Jan 2010 22:34:26 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:34:26 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:34:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138368>

In article <op.u7a909hf4oyyg1@alvarezp-ws>,
 "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:

> On Fri, 29 Jan 2010 12:20:46 -0800, Ron1 <ron1@flownet.com> wrote:
> 
> > [ron@mickey]$ git checkout master
> > Already on 'master'
> > [ron@mickey]$ git checkout master^
> > Note: moving to 'master^' which isn't a local branch
> > If you want to create a new branch from this checkout, you may do so
> > (now or later) by using -b with the checkout command again. Example:
> >   git checkout -b <new_branch_name>
> > HEAD is now at 7be05e0... test
> > [ron@mickey]$ git branch
> > * (no branch)
> >   master
> > [ron@mickey]$
> >
> > Huh?!?
> >
> > This is a test repository which has never been pulled from nor pushed to
> > anywhere.  So how is it possible that I have a non-local branch?
> 
> "Is a non-local branch" is not the same as "is not a local branch".
> 
> Think "branches" as tags that advance when you commit over them.
> 
> If you do gitk --all, only those commits with a green tag are
> "branches".
> 
> It means that if you switch to master^ and commit, your commit will
> be applied but not tracked (since there is not any branch to advance).
> 
> You would need to do git checkout -b 'new_branch', and then commit.
> Now, new_branch will advance with your new commit.

OK, I think I understand that.

Here's the thing: I can do this:

git checkout commit-id filename

and restore a particular revision of a particular file to my working 
tree without affecting my HEAD pointer.  I would expect then that

git checkout commit-id

with no filename would do the same thing, except restore the entire tree 
from that commit (including deleting files that didnt' exist then).  And 
indeed it does that (or at least appears to -- I haven't explored this 
in depth), except that it DOES move my HEAD pointer to this weird 
non-branch thing.

Here's what I think would be the correct behavior:



[ron@mickey]$ git checkout master^

"WARNING: master^ is not a branch.  It is a commit on the master branch.
Since the the commit you are asking for is on the same branch as your
current HEAD pointer, here's what I'm going to do:

1.  Copy the master^ commit to your working tree
2.  Leave your HEAD pointer where is was (i.e. pointing to the head
of the master branch).

If this is not what you wanted, you can undo it by typing "git checkout 
HEAD".  Also, in the future, you can avoid this warning by typing ...
instead.



Or something like that.

rg
