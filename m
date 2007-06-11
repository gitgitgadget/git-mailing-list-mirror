From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 22:12:32 +0200
Message-ID: <20070611201232.GA4649@steel.home>
References: <20070608202236.GJ25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com> <200706112042.16331.simon@lst.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxqGI-0004ra-I6
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 22:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbXFKUMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 16:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbXFKUMg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 16:12:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45269 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbXFKUMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 16:12:35 -0400
Received: from tigra.home (Fca0c.f.strato-dslnet.de [195.4.202.12])
	by post.webmailer.de (fruni mo37) (RZmta 7.2)
	with ESMTP id G01bb6j5BK5RYN ; Mon, 11 Jun 2007 22:12:32 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A3596277BD;
	Mon, 11 Jun 2007 22:12:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 55642D261; Mon, 11 Jun 2007 22:12:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706112042.16331.simon@lst.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv0bw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49881>

Simon Hausmann, Mon, Jun 11, 2007 20:42:12 +0200:
> On Monday 11 June 2007 17:44:04 Alex Riesen wrote:
> > On 6/11/07, Simon Hausmann <simon@lst.de> wrote:
> > > *plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.git
> > > . It should be just a matter of calling
> > >
> > >         git-p4 clone //depot/path
> >
> > Can I suggest you add a target directory mapping to your tool?
> > Something like:
> >
> >   git-p4 clone //depot/project/path [libs/project/path] [rev-range]
> 
> I'm not sure I understand the libs/project/path part, ...

Your client contains the mappings. It defines how the pathnames on the
p4 server relate to that on your computer. In the example above file
from the depot path //depot/project/path can be found in the directory
of the p4 client in the subdirectories libs/project/path.

> Han-Wen implemented also support for importing multiple depot paths at the 
> same time (and tracking them in one git branch).

And where does he put the depot paths? As they are in depot? How does
this corelate to the setups done by genuine P4 users (the poor souls)
where the mappings are not always 1-to-1 right from the root? Or you
haven't got any?

> The environment I'm working in is not too big and fairly liberal and 
> reasonably disciplined.

You must be very strange environment indeed. Carefully balanced.

> > And, BTW, don't you have a small problem with filenames with
> > spaces and quoting?
> 
> I'm not aware of any problems. For example in our depot we have filenames with 
> spaces in them and they appear just fine in my git import. Did you run into 
> any specific case? It could very well be that there's a bug somewhere that 
> I'm just not hitting myself, so I'm curious :)

No, I just looking at the source. Does python have some magic for
running programs with system() when passed a format string? Like here:

        for f in filesToAdd:
            system("p4 add %s" % f)
        for f in filesToDelete:
            system("p4 revert %s" % f)
            system("p4 delete %s" % f)

BTW, sometimes you quote the names, but obviously wrong (think about
filenames containing double quotes):

                system("p4 edit \"%s\"" % path)
                editedFiles.add(path)
