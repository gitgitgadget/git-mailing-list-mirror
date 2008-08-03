From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Sun, 3 Aug 2008 22:48:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808032238170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080723145518.GA29035@laptop> <alpine.DEB.1.00.0807231713280.8986@racer> <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com> <alpine.DEB.1.00.0807231753240.8986@racer> <20080803183749.GA3482@efreet.light.src>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1867500090-1217796527=:9611"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkSC-00017m-Q5
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbYHCUoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756174AbYHCUoX
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:44:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:37061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755831AbYHCUoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:44:21 -0400
Received: (qmail invoked by alias); 03 Aug 2008 20:44:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 03 Aug 2008 22:44:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QGyBk0wNQOzCGfPAaxlhb5erK9Qe6OeAv1Fi8FU
	yVcw3RVYOx5ekY
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080803183749.GA3482@efreet.light.src>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91266>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1867500090-1217796527=:9611
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 3 Aug 2008, Jan Hudec wrote:

> On Wed, Jul 23, 2008 at 17:55:14 +0100, Johannes Schindelin wrote:
> > On Wed, 23 Jul 2008, Nguyen Thai Ngoc Duy wrote:
> > > On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >  On Wed, 23 Jul 2008, Nguyễn Thái Ngọc Duy wrote:
> > > >
> > > >  > So in short, sparse prefix will be stored in config, 
> > > >  > core.sparsecheckout.
> > > >
> > > > Do you really think the prefix should be stored anywhere else than 
> > > > the index?
> > > >
> > > > With core.sparseCheckout you have to introduce a _sh*tload_ of 
> > > > config loaders.
> > > >
> > > > And with core.sparseCheckout you are at the whim of the user, 
> > > > since .git/config is _supposed_ to be user-editable.
> > > >
> > > > From a logical point of view, I'd say that the sparse prefix has 
> > > > nothing to do with the "configuration" of the local repository.
> > > 
> > > Well, whatever place. I chose .git/config because I did not want to 
> > > introduce a new config place. But then how about 
> > > .git/sparsecheckout?
> > 
> > No, I did mean the index.  This is an attribute of the index: either 
> > it is sparsely checked out or not.  You can even have multiple indices 
> > (switching between them by setting GIT_INDEX_FILE) which have 
> > different prefixes.
> 
> Um, but does the prefix we want to use depend on what files are 
> physically present in the tree?

The thing is: in a checkout, the flow of data is

	HEAD -> index -> worktree

To check in, the flow is exactly opposite.

There are also legal workflows where you do not work on the worktree at 
all.

And there are legal workflows where you work with multiple 
indices/worktrees.

Now, it appears pretty obvious to me that the logical thing is to tell the 
(current) index what is supposed to be checked out and what not.

After all, a merge is done inside the index.  And if the merge touches 
parts outside of the sparse checkout, it is natural to have the index know 
about it.

Because the merge _has_ to complain then.

In any case, isn't it clearly the more elegant solution to just put the 
information into the index when you touch it _anyway_?

I am really puzzled why people think it is a good idea to separate the 
file metadata from the information what files were checked out to begin 
with, as if they were totally independent.

Because they are not.

Ciao,
Dscho
--8323329-1867500090-1217796527=:9611--
