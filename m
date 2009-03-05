From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add an (optional, since expensive) test for >2g
 clones
Date: Thu, 5 Mar 2009 17:58:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051754260.6524@intel-tinevez-2-302>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de> <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de> <20090305164153.GD4213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 18:00:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGvb-000308-Rb
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 18:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbZCEQ63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbZCEQ63
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:58:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:58231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754180AbZCEQ62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:58:28 -0500
Received: (qmail invoked by alias); 05 Mar 2009 16:58:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 05 Mar 2009 17:58:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Wimc0BHVWzksTqXxpi93CI+kR1+H1Eat8aMMdYG
	F0ek2GU5D8aSXj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090305164153.GD4213@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112320>

Hi,

On Thu, 5 Mar 2009, Jeff King wrote:

> On Thu, Mar 05, 2009 at 05:05:09PM +0100, Johannes Schindelin wrote:
> 
> > +	(while test $i -le $blobcount
> > +	 do
> > +		printf "Generating blob $i/$blobcount\r" >&2 &&
> > +		printf "blob\nmark :$i\ndata $blobsize\n" &&
> > +		#test-genrandom $i $blobsize &&
> > +		printf "%-${blobsize}s" $i &&
> 
> Leftover cruft using genrandom? (I'm guessing you tried random at first
> to avoid compression, but I think your pack.compression=0 technique is
> more sensible).

Actually, I left it in on purpose.  Yes, it happens to work right now, as 
the packs are built with 0 compression and with 0 deltification.

However, there might be a day when we cannot guarantee anymore that a 
single number padded with spaces to a certain width really makes the pack 
grow by that many bytes.  Then we would need something like test-genrandom 
(which is substantially slower, though).

Interesting random note: it took me quite a while to figure out that both 
pack.compression and pack.depth need to be set to 0.  In hindsight, it is 
obvious, but that does not really help the time I lost due to Windows' 
slowness.

Ciao,
Dscho
