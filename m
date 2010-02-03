From: Ron Garret <ron1@flownet.com>
Subject: Re: How to tell if a file was renamed between two commits
Date: Tue, 02 Feb 2010 18:52:02 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-5818AE.18520202022010@news.gmane.org>
References: <ron1-2EA926.18292002022010@news.gmane.org> <20100203023219.GA13092@spearce.org> <ron1-08A0F6.18483502022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 03:55:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcVOd-0006p9-Hd
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 03:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182Ab0BCCzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 21:55:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:43894 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab0BCCzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 21:55:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcVOT-0006kI-VB
	for git@vger.kernel.org; Wed, 03 Feb 2010 03:55:05 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 03:55:05 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 03:55:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138804>

In article <ron1-08A0F6.18483502022010@news.gmane.org>,
 Ron Garret <ron1@flownet.com> wrote:

> In article <20100203023219.GA13092@spearce.org>,
>  "Shawn O. Pearce" <spearce@spearce.org> wrote:
> 
> > Ron Garret <ron1@flownet.com> wrote:
> > > I'm trying to write a little utility that will extract all the revisions 
> > > of a particular file.  I start with a git rev-list HEAD -- filename, get 
> > > the tree objects with git cat-file commit, the file objects with git 
> > > ls-tree, and finally the file contents themselves with git cat-file 
> > > blob.  It works, except in the case where the file name was changed.  
> > > git rev-list is smart enough to track those name changes, but my little 
> > > revision tracker isn't.  It dies when suddenly there is no file with the 
> > > right name in the tree.
> > > 
> > > So... is there an easy way to work around this?  Is there a way to get, 
> > > say, rev-list to tell me when the file it is tracking changed names?  Or 
> > > a git-diff incantation?  I just need something that will tell me given 
> > > two commits and a file name whether the file was renamed between those 
> > > two commits and if so what its new name is.  There must be an easy way 
> > > to do this, but I can't figure out what it is.
> > 
> > Maybe use the -M flag to git log, or the --follow flag to
> > log/rev-list?
> 
> Nope.  git log --follow will follow through a name change but won't 
> actually say when the name changed happened or what the previous name of 
> the file was.
> 
> And actually playing around with it some more, it appears that git 
> rev-list doesn't actually track file renames, or at least it doesn't do 
> it all the time.  Weird.  I'm going to have to play around with this 
> some more.
> 
> rg

Ah, I think I found it:

git log --follow --raw -- [filename]

gives you e.g.:

:100644 100644 01e79c3... 01e79c3... R100       foo     baz

which seems to be what I'm looking for.

rg
