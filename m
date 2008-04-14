From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 15:10:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804141506270.28504@racer>
References: <69a88a530804131351n7d9f8188vf2bbb0174ade3ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, joerg@alea.gnuu.de, junio@pobox.com
To: Paul Fredrickson <paul.fredrickson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 16:16:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlPOs-0005vL-2p
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 16:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbYDNOKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 10:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbYDNOKV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 10:10:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:58246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754904AbYDNOKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 10:10:20 -0400
Received: (qmail invoked by alias); 14 Apr 2008 14:10:19 -0000
Received: from unknown (EHLO racer.local) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 14 Apr 2008 16:10:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LyIMHZjRLRD8Auc7hW8frW0CPBP0LupxsT+gsjn
	V7swAiAwk0i41a
X-X-Sender: gene099@racer
In-Reply-To: <69a88a530804131351n7d9f8188vf2bbb0174ade3ca0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79504>

Hi,

On Sun, 13 Apr 2008, Paul Fredrickson wrote:

> > Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > > > Wouldn't
> > > >
> > > > pick 5cc8f37 (init: show "Reinit" message even in ...)
> > > > mark 1
> > > > pick 18d077c (quiltimport: fix misquoting of parse...)
> > > > mark 2
> > > > reset 1
> > >
> > > "reset 18d077c~2" or "reset some-tag" or "reset my-branch~12"
> > >
> > >         merge #2
> > > >
> > > > be easier for people?

Actually, I think that this whole "mark" stuff is way too complicated, as 
can be seen by the amount of patches needed to get it somewhere usable.

I would like it much better, if there was something like

pick 5cc8f37 (init: show "Reinit" message even in ...)
pick 18d077c (quiltimport: fix misquoting of parse...)
merge 9876543:5cc8f37,18d077c (Merge blub)
reset 5cc8f37
...

I.e. like with filter-branch, and like with rebase -i -p in its current 
form, we take the _original_ names as keys as to which commits to merge, 
or where to reset to.

That would be relatively easy to implement, since the whole infrastructure 
for it is already there: whenever a commit was rewritten, the new commit 
name is saved in $DOTEST/rewritten/<original-commit-name>.

I really do not like complicating things unnecessarily.

Ciao,
Dscho
