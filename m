From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Potentially dangerous behavior of git gc
Date: Tue, 20 Oct 2009 11:40:32 +0000 (UTC)
Message-ID: <loom.20091020T132839-911@post.gmane.org>
References: <loom.20091019T095725-840@post.gmane.org> <20091019112153.GX6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 13:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0D5w-0000uh-LA
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 13:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZJTLlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 07:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbZJTLla
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 07:41:30 -0400
Received: from lo.gmane.org ([80.91.229.12]:45268 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbZJTLla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 07:41:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N0D5b-0000ha-MD
	for git@vger.kernel.org; Tue, 20 Oct 2009 13:41:19 +0200
Received: from 95.75.147.1 ([95.75.147.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:41:19 +0200
Received: from sergio.callegari by 95.75.147.1 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:41:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.75.147.1 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20090910 Ubuntu/9.04 (jaunty) Shiretoko/3.5.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130786>

Miklos Vajna <vmiklos <at> frugalware.org> writes:

> 
> On Mon, Oct 19, 2009 at 08:04:58AM +0000, Sergio Callegari
<sergio.callegari <at> gmail.com> wrote:
> > With this when the alternate info of A is finally updated, A is broken, 
missing
> > many references and not having a head anymore.
> > 
> > Would it be better to have git gc not to take dangerous actions on 
potentially
> > problematic repos?
> 
> Such repos are usually created using git clone -s. See the NOTE of the
> manpage under the -s option, probably you want to use git repack -a
> after git clone.
> 

Thanks, unfortunately, that was not really my point. But I now see that I
cannot create a test case to reproduce my issue.  Briefly what happened to
me is the following

1) Create repo A
2) Clone with -s A into B
3) Do some work in B, being happy of maintaining the alternate
4) At some point, move A elsewhere
5) Do a couple of things in B, including a git gc, before realizing that
   moving A had created problems to B
6) Rush to make A reachable by B again by updating the info/alternates
   file in B
7) Realize that in spite of 6) B is gone... no more ref/heads/master, git
   thinks that this is a new empty repo.

And certainly the fault was of some of the "two things" done in 5). At the
beginning I thought that the blame was of git gc, but I see that I cannot
reproduce the situation at all with test cases.

So I will give up for now... I'll get back to it if I ever have a similar
problem.  Once more, sorry for the noise.

Sergio 
