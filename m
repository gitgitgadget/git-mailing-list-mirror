From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Not going beyond symbolic links
Date: Tue, 5 Aug 2008 03:59:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBmz-0004UJ-DH
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbYHEBzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYHEBzd
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:55:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:59733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751281AbYHEBzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:55:33 -0400
Received: (qmail invoked by alias); 05 Aug 2008 01:55:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 05 Aug 2008 03:55:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OTp9NTrgOUmxbj5Am/KS0Np1f7CC4Q9EraqgUa1
	yJD6DMTJX0+g/T
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91404>

Hi,

On Mon, 4 Aug 2008, Linus Torvalds wrote:

> On Mon, 4 Aug 2008, Junio C Hamano wrote:
> > >
> > > The rewritten 'has_symlink_leading_path()' should do ok, but it 
> > > migth still be a huge performance downside to check all the paths 
> > > for things like "git add -u".
> > 
> > Not yet.
> > 
> > I think this is a necessary "correctness" thing to do regardless of 
> > the performance impact, and adding the logic to stop at submodule 
> > boundary (aka gitlinks) should come before optimization.
> 
> Well, "performance" is a feature too, and it's not correct to say that 
> "X should be fixed before optimization". If "X" slows things down, the 
> question should be whether it really needs fixing..
> 
> Yes, we find symlinks when we do _new_ files, but is it really so bad to 
> assume that existing directories that we have already added to the index 
> are stable? It can easily be seen as a feature too that you can force git 
> to ignore the symlink and see it as a real directory.

Actually, whatever you want, it needs fixing.

I vividly remember being quite pissed by Git replacing a symbolic link in 
my working directory with a directory, and instead of updating the files 
which were technically outside of the repository, Git populated that newly 
created directory.

However, please note that Junio's patch affects git-add, AFAIR, not 
git-update-index.

Ciao,
Dscho
