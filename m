From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: gitk and git-gui, was Re: FFmpeg considering GIT
Date: Tue, 8 May 2007 13:16:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705081311550.4167@racer.site>
References: <57600.59393.qm@web38909.mail.mud.yahoo.com>
 <17983.63329.314321.305860@cargo.ozlabs.ibm.com> <20070508041939.GK11311@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 13:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNgC-0002vD-Jw
	for gcvg-git@gmane.org; Tue, 08 May 2007 13:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934109AbXEHLQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 07:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934120AbXEHLQY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 07:16:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:52234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934109AbXEHLQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 07:16:23 -0400
Received: (qmail invoked by alias); 08 May 2007 11:16:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 08 May 2007 13:16:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JGONkaOOJBAlWrUn0dyTsQluSJ+7DG+NmkvKlFy
	X7Cpdy2Z5AhAoL
X-X-Sender: gene099@racer.site
In-Reply-To: <20070508041939.GK11311@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46566>

Hi,

On Tue, 8 May 2007, Shawn O. Pearce wrote:

> Paul Mackerras <paulus@samba.org> wrote:
>
> > Gitk ends up handling pretty significant amounts of data.  In 
> > particular the per-commit data can get to gigabytes, and processing it 
> > is pretty cpu-intensive.  I did try using namespaces for the 
> > per-commit data but I found that the performance hit to be more than I 
> > was willing to tolerate.
> 
> If that is the case then an obvious direction is to start using C for 
> the actual Git operations/datastore and Tcl/Tk for the basic UI layout 
> and event handlers.

It might be a much better idea to write something a la git-fetch--tool, 
which is a helper in C (thus very fast and memory efficient), outputting 
easily parseable data. 

For example, when constructing the commit graph, the calculations could be 
done in C, and Tcl/Tk could do _just_ the display. AFAIK tig already has 
the algorithm implemented in C...

The big benefits would not only be that you can compile this without the 
headers/libs of Tcl/Tk (possibly avoiding the problem we experienced when 
trying to compile Git with gcc, and linking to Perl, which was compiled 
with a different compiler), but other Git viewers could take this output 
as well, avoiding reimplementing the algorithm in Ruby or Haskell.

Ciao,
Dscho
