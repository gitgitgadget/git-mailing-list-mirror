From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Mon, 18 Aug 2008 21:40:21 +0200
Message-ID: <20080818194021.GA3262@steel.home>
References: <19035412.post@talk.nabble.com> <20080818173511.GC6014@blimp.local> <d3d284ca0808181115j2c9ab5ecufb66780f45d28207@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Waller <peter.waller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 21:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAbt-0000ee-68
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 21:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168AbYHRTk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 15:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762755AbYHRTk1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 15:40:27 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:59482 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762700AbYHRTkY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 15:40:24 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44hO88yw==
Received: from tigra.home (Fa968.f.strato-dslnet.de [195.4.169.104])
	by post.webmailer.de (klopstock mo33) (RZmta 16.47)
	with ESMTP id c00472k7IGwN8d ; Mon, 18 Aug 2008 21:40:22 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E59F4277AE;
	Mon, 18 Aug 2008 21:40:21 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B8DCE56D2A; Mon, 18 Aug 2008 21:40:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d3d284ca0808181115j2c9ab5ecufb66780f45d28207@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92727>

Peter Waller, Mon, Aug 18, 2008 20:15:52 +0200:
> 2008/8/18 Alex Riesen <raa.lkml@gmail.com>
> 
> > Peter Waller, Mon, Aug 18, 2008 18:46:14 +0200:
> > >
> > > I have three repositories, A, B and C. I wish to bring them
> > > together to only one repository (.), where they are in a
> > > directory called ./Archive, so..  ./Archive/{A,B,C}. Then I plan
> > > at a later date to move files arbitrarily from
> > > ./Archive/{A/B/C}/Something and into ./Something{A/B/C}. (A lame
> > > example, but illustrates what I want to do).
> >
> > If this transition is meant to be persistent (IOW, the A, B and C stop
> > existing as repos on their own) you can rewrite their histories to be
> > in the directories (with git filter-branch) and just merge them in
> > one. Then the histories will look like as if they have never grown
> > separately.
> >
> I don't quite understand what you are suggesting I do.
> 
> I have looked over the filter-branch manpage.
> 
> What would I first do? Copy all three repositories to ./Archive/{A,B,C}?

Fetch, actually.

    $ mkdir combined && cd combined
    $ git init
    $ git fetch ../A master:A
    $ git fetch ../B master:B
    $ git fetch ../C master:C

> Then rewrite their histories?

There is an example at the end of git-filter-branch manpage. Search
for "To move the whole tree into a subdirectory". Just use A, B and C
instead of HEAD as last argument.

Then checkout one of the new, the rewritten, branches, and merge the
two others into it:

    $ git checkout A
    $ git merge B
    $ git merge C

That's it.
