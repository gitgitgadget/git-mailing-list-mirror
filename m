From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 08:43:13 +0300
Message-ID: <20080624054313.GB3125@mithlond.arda.local>
References: <20080624045937.GA3125@mithlond.arda.local> <e80d075a0806232201o3933d154he2b570986604c30a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:44:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB1KA-00043N-1X
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYFXFnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYFXFnS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:43:18 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:53079 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751245AbYFXFnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:43:17 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F012D9B16; Tue, 24 Jun 2008 08:43:13 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KB1JB-0001xx-4B; Tue, 24 Jun 2008 08:43:13 +0300
Content-Disposition: inline
In-Reply-To: <e80d075a0806232201o3933d154he2b570986604c30a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85995>

David Jeske wrote (2008-06-23 22:01 -0700):

> On Mon, Jun 23, 2008 at 9:59 PM, Teemu Likonen <tlikonen@iki.fi>
> wrote:
> 
> > I'm also quite new and I actually feel safe using git, and it's
> > because of reflog. No matter what I do (except manual reflog expire)
> > I can see where I was before with command
> >
> >  git log --walk-reflogs
> 
> 
> Perhaps I'm misunderstanding how to read it, but how do you tell where
> a branch was from the reflog if you inadvertantly moved it?

Perhaps I'm misunderstanding what you mean but I try to explain. In git
branches are nothing but named pointers to certain commit. If you "move
a branch" you actually rename the pointer, nothing more. With command

  git log --walk-reflogs --all

you can see everything in your reflog. When branches are moved (i.e.,
renamed) in "git log --walk-reflogs" output it shows like this:

  commit 269f10bca2273c1cf77831d5e23c6e0361217697
  Reflog: refs/heads/master@{2008-06-24 08:15:56 +0300} (Teemu Likonen <tlikonen@iki.fi>)
  Reflog message: Branch: renamed refs/heads/master to refs/heads/testbranch
  Author: Teemu Likonen <tlikonen@iki.fi>
  Date:   2008-03-25 19:10:40 +0200
  
  [commit message]

See the "Reflog message" field above. It tells what happened. The
"Reflog" field tells when it happened. If I later remove this
"testbranch" I can browse the reflog and create this branch (i.e.
a pointer) again with command "git branch testbranch 269f10bca". The
269f10bca comes from the commit ID of the above log item.
