From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 21:57:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902112152270.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de> <20090210165610.GP30949@spearce.org> <7vocxam96s.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
 <20090211200227.GA27961@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXM9s-0000mI-W0
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbZBKU4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZBKU4n
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:56:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:56405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755085AbZBKU4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:56:42 -0500
Received: (qmail invoked by alias); 11 Feb 2009 20:56:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 11 Feb 2009 21:56:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GU6I+MyxG28llvGziPAU8EYzitccuDVj54/xADz
	whUMfgOUXepu/2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090211200227.GA27961@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109526>

Hi,

On Wed, 11 Feb 2009, Jeff King wrote:

> On Tue, Feb 10, 2009 at 10:10:43PM +0100, Johannes Schindelin wrote:
> 
> > > I wonder if we can solve this by introducing a local cache that is a flat
> > > file that looks like:
> > [...]
> > Or we could use an on-disk hashmap.  Oh, wait...
> 
> That was my first thought, as well. Maybe your original implementation
> wasn't so bad, after all. :)
> 
> I searched through the archive to find a list of criticisms, but I
> didn't see any. So I guess the problem was just a concern that it might
> end up too complex.

Nope, the issue was that it would take too long to recreate IIRC.

BTW I am no longer a fan of the on-disk cache; I think it is an ugly 
solution to a problem that should be solved without ugliness using a 
flexible directory layout in the note ref' tree.

I mean, we really can allow different directory layouts as Sam described, 
with a few benefits, and only slight downsides.  If we support multiple 
levels anyway, the code to allow arbitrary splits is not complicated (see 
Sam's patch).

Even the merging should not pose any problem at all; we need a custom 
merge driver anyway, and there is no reason whatsoever why we should not 
just teach the merge driver to remove the slashes before comparing the 
filie names.

At edit time, we can afford to perform a check that is a little more 
expensive than it would have been otherwise.

Ciao,
Dscho
