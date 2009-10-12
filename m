From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 18:05:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910121803360.4985@pacific.mpi-cbg.de>
References: <loom.20091012T152113-874@post.gmane.org> <20091012142032.GG9261@spearce.org> <loom.20091012T171550-239@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sal Mangano <smangano@into-technology.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 18:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxNRn-0000ex-UY
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbZJLQDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 12:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbZJLQDR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 12:03:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:40021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932733AbZJLQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 12:03:17 -0400
Received: (qmail invoked by alias); 12 Oct 2009 16:02:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 12 Oct 2009 18:02:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yNIdouFGy0FyAX9OjxLAluMgeFA7XOoXFGnlNJF
	Ub+IcaXs7REVTV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20091012T171550-239@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130030>

Hi,

On Mon, 12 Oct 2009, Sal Mangano wrote:

> Shawn O. Pearce <spearce <at> spearce.org> writes:
> 
> > 
> > Sal Mangano <smangano <at> into-technology.com> wrote:
> > > I am using Git in a non-standard way and need to make a few twaeks 
> > > in my custom build. I have added a --nosort option to git mktree 
> > > which will suppress the qsort of the tree.
> > > 
> > > Will this break any other git functions? Are there any commands that 
> > > assume trees are always sorted?
> > 
> > _YES IT BREAKS GIT_.
> > 
> > You cannot do this.
> > 
> > A Git repository whose trees are not sorted according to the Git 
> > specific sort ordering is severly broken and most tools will fail 
> > horribly on it.
> > 
> > Almost all code which reads trees assumes the names are sorted in a 
> > specific order.  These tools perform sorted merges against other tree 
> > like structures.  If the names are out of order the merge will fail. 
> > `git fsck` will complain that the tree is not sorted properly. Tools 
> > like `git log -- foo.c` will fail randomly because they break out of 
> > the entry lookup as soon as they find a name that is after foo.c, as 
> > they assume the tree is sorted.
> > 
> > I could go on.  But there is no point.
> > 
> > Oh, and trust me when I say this, the tree sorting matters.  Long ago 
> > JGit had a bug where it didn't sort trees correctly all of the time 
> > and we had a devil of a time tracking down that corruption.
> > 
> 
> Thanks Shawn. I get the picture. 
> 
> Now, let's assume I am stubborn, crazy or both :-)
> 
> I can modify fsck to ignore unsorted and at the moment I don't care 
> about merging trees. If I hunt down all usage of base_name_compare will 
> that identify all code with the sort assumption or is there other places 
> as well? I can go > through the entire source to figure this out myself 
> but I need to get something hacked up very quickly and would appreciate 
> help even if you think I am nuts!

Look, one of the most trusted Git contributors just told you that you are 
asking for trouble.

It has nothing to do with being stubborn if you insist on doing it now.

But I smell an XY problem.  Why don't you just reveil _what_ you want to 
do (as opposed to _how_ you think you should do it)?

Ciao,
Dscho
