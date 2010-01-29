From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 14:47:49 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-0EE62E.14474929012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org> <op.u7bfjni44oyyg1@alvarezp-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 23:48:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazdY-0006c9-7T
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab0A2WsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755955Ab0A2WsS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:48:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:46268 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755953Ab0A2WsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:48:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NazdM-0006Tc-VY
	for git@vger.kernel.org; Fri, 29 Jan 2010 23:48:12 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:48:12 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:48:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138395>

In article <op.u7bfjni44oyyg1@alvarezp-ws>,
 "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:

> On Fri, 29 Jan 2010 13:34:01 -0800, Ron Garret <ron1@flownet.com> wrote:
> 
> > In article <op.u7a909hf4oyyg1@alvarezp-ws>,
> >  "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:
> >
> >> On Fri, 29 Jan 2010 12:20:46 -0800, Ron1 <ron1@flownet.com> wrote:
> >>
> >> It means that if you switch to master^ and commit, your commit will
> >> be applied but not tracked (since there is not any branch to advance).
> >>
> >> You would need to do git checkout -b 'new_branch', and then commit.
> >> Now, new_branch will advance with your new commit.
> >
> > OK, I think I understand that.
> >
> > Here's the thing: I can do this:
> >
> > git checkout commit-id filename
> >
> > and restore a particular revision of a particular file to my working
> > tree without affecting my HEAD pointer.  I would expect then that
> >
> > git checkout commit-id
> >
> > with no filename would do the same thing, except restore the entire tree
> > from that commit (including deleting files that didnt' exist then).  And
> > indeed it does that (or at least appears to -- I haven't explored this
> > in depth), except that it DOES move my HEAD pointer to this weird
> > non-branch thing.
> 
> I see. You somehow imply that "git checkout commit-id" overlaps with
> "git reset --hard commit-id".

I'm not intentionally implying that.  I don't think git reset --hard 
does what I want either (but I could be wrong about that).

> Even assuming the behavior was not documented in man git-checkout, the
> second example looks useless. What is your use case? What would you do
> after having all the files in the tree switched to another commit,
> without actually updating HEAD to the commit, other than git reset --hard
> again or git revert?

My actual use case is very complicated, but here's a simplified version:

Suppose I'm using git as a back-end for a wiki.  I want to look at the 
state of the entire wiki as it was in some point in the past, and I also 
want to be able to look at the diffs between individual pages as they 
were then and as they are now.  The most straightforward way I can think 
of to do that is to simply copy an old commit into my working tree 
without changing anything else.  Then I can look at the old version by 
simply looking at the files, and I can get the diffs by simply doing a 
git diff.

If I do a git reset --hard then I get the old version, but I lose my 
HEAD pointer so that git diff doesn't give me what I want any more.

BTW, it turns out that git checkout [commit] . doesn't do the right 
thing either.  Apparently, it still updates my index, so git diff still 
doesn't do the right thing.

rg
