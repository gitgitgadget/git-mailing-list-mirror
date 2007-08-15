From: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
 scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 19:03:53 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org>
 <1187037445.6628.98.camel@heimdal.trondhjem.org> <1187054366.2757.0.camel@laptopd505.fenrus.org>
 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
 <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost>
 <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
 <20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 15:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILIoT-00044C-Tt
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 15:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbXHONV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 09:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755610AbXHONV0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 09:21:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48595 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbXHONVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 09:21:25 -0400
Received: from localhost ([127.0.0.1])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ILIoE-000649-8R; Wed, 15 Aug 2007 14:21:15 +0100
X-X-Sender: satyam@enigma.security.iitk.ac.in
In-Reply-To: <46C2548D.80605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55900>

Hi Rene,


On Wed, 15 Aug 2007, Rene Herman wrote:

> It mostly is just about that it seems. However, this would not also allow the
> other information currently in the MAINTAINERS file to be queried in similar
> ways.
> 
> Git could grow a generic file meta data implementation through the use of
> tags, sort of like tags on multimedia files although while with multimedia
> files the tags are in fact stored as a file header, here you'd keep them just
> in git. Any project using git would be free to define its own set of info tags
> and you'd supply them to git simply as a list of
> 
> <tag>=<value>
> 
> pairs:
> 
> $ git info --add drivers/ide/ide-cd.c <<EOF
> CC="Alan Cox <alan@lxorguk.ukuu.org.uk>", linux-ide@vger.kernel.org
> EOF
> 
> Or as a more expansive example, with the tags set on a directory (and the
> output shown this time):
> 
> $ git info drivers/infiniband/
> CC="Roland Dreier <rolandd@cisco.com>"
> CC="Sean Hefty <mshefty@ichips.intel.com>"
> CC="Hal Rosenstock <halr@voltaire.com>"
> CC=openib-general@openib.org

Considering some people may want to differentiate between "those who want
to be Cc'ed for patches on subsystem X" and "those who are maintainer(s)
of subsystem X", I think another "P=" kind of tag might also be useful
here.

> W=http://www.openib.org/
> T=git kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git
> 
> $ git info --type="W" drivers/infiniband/
> http://www.openib.org/
> 
> The project can link the actual tags such as CC, W and T to --options for the
> "info" command in the git configuration file for the tree (and/or just define
> a few upfront I guess) making it look nicer:
> 
> $ git info --cc drivers/infiniband/
> "Roland Dreier <rolandd@cisco.com>"
> "Sean Hefty <mshefty@ichips.intel.com>"
> "Hal Rosenstock <halr@voltaire.com>"
> openib-general@openib.org
> 
> $ git info --website drivers/infiniband/
> http://www.openib.org/
> 
> $ git info --tree drivers/infiniband/
> git kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git
> 
> Extra: when you have such an implementation, you can use it for other purposes
> as well such as the summary Documentation/ files want for the 00-INDEX files:
> 
> $ git info --summary Documentation/BUG-HUNTING
> brute force method of doing binary search of patches to find bug.
> 
> And importantly -- when queuried for a file that itself doesn't have the
> requested info tag:
> 
> $ git info --cc drivers/infiniband/core/addr.c
> 
> git looks for the tag on the drivers/infiniband/core/ directory next, and then
> on drivers/infiniband/, where it finds it. linux-kernel@vger.kernel.org would
> be the final fallback, being set on the project root.
> 
> I'd really like something like this. As long as projects are both free to use
> and not use them and free to define their own set of tags I believe this would
> work very nicely.
> 
> Once you have these tags, you can basically use them for anything.

I'd really _love_ a tool that does all that what you've proposed above!

But why does it have to be "git-info" or anything in the git(7) suite for
that matter? This sounds like a job for a different specialised tool,
along with ".metatags" kind of files dispersed in the source tree.


Satyam
