From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 11:31:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271127440.27959@racer.site>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071127020842.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwyfi-0000aX-RV
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXK0Lbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbXK0Lbw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:31:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:46630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751020AbXK0Lbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:31:51 -0500
Received: (qmail invoked by alias); 27 Nov 2007 11:31:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 27 Nov 2007 12:31:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sIV5QCG7scYIEHRrS0WlI0Sl7EKoo6vlj6dqeQ9
	nZYLEh/Rbfhrpl
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127020842.GN14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66191>

Hi,

On Mon, 26 Nov 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > This program dumps (parts of) a git repository in the format that
> > fast-import understands.
> ...
> > +-------------------------------------------------------------------
> > +$ git fast-export --all | (cd /empty/repository && git fast-import)
> > +-------------------------------------------------------------------
> > +
> > +This will export the whole repository and import it into the existing
> > +empty repository.  Except for reencoding commits that are not in
> > +UTF-8, it would be a one-to-one mirror.
> 
> WTF?
> 
> Why are you reencoding the commits on output in fast-export? Why aren't 
> you dumping them raw to the stream?  fast-import takes them raw.  Oh, it 
> doesn't have a way to set the encoding header. DOH.

Not only that... FTFD:

~ Commit messages are free-form and are not interpreted by Git.  
~ Currently they must be encoded in UTF-8, as fast-import does not permit 
~ other encodings to be specified.

So the documentation stated very much that I _had_ to do it that way.

> I think this should be prefixed by fast-import patch to teach it 
> something like "encoding N" as a subcommand of commit, so that you can 
> feed data in a non UTF-8 encoding and get it to include the proper 
> encoding header in the commit object it creates.  That way a pipeline 
> like the above really does create a duplicate repository, with the same 
> commit SHA-1s, even if the commits weren't in UTF-8.

IMHO it's not worth that hassle.  People who want to use fast-import 
usually want something fast which works, and not bother with specifying 
encodings.

Further, if you go down that road, some people will want to be able to say 
"that commit is KOI-8, this one is UTF-8, and the third is encoded in 
pre-Christian Tibetan runes."

But maybe I am wrong.

Ciao,
Dscho
