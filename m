From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: Fix renaming a directory in the
 tree-filter
Date: Mon, 31 Mar 2008 14:15:51 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0803311412090.18259@racer.site>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca> <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at> <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at> <7v3aq7mgly.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	=?ISO-8859-15?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 14:16:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgIwJ-0007PZ-PD
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 14:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbYCaMPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbYCaMPy
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 08:15:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:34383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753493AbYCaMPx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 08:15:53 -0400
Received: (qmail invoked by alias); 31 Mar 2008 12:15:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 31 Mar 2008 14:15:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ho2psgtMHW9+GhbsI5KzB0GL0MdmvHReE7aS8RJ
	GemtV8iIhgyuss
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3aq7mgly.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78583>

Hi,

On Mon, 31 Mar 2008, Junio C Hamano wrote:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > 2. Then filter-branch checks out the files for the next commit. This 
> >    leaves the new directory behind because there is no real "branch 
> >    switching" involved that would notice that the directory can be 
> >    removed.
> 
> Thanks.
> 
> It obviously is a correct fix to use "clean -d" here, but I strongly 
> suspect this awkwardness comes from the fact that there is no clear 
> invariant in this loop.
> 
> For example, if you make it the invariant that $T contains the tree that 
> matches the contents of the "$tempdir/t" work tree left in the previous 
> round of filter-tree (and obviously you would want to do this only 
> filter_tree is in effect), the "checkout-index + clean" would become a 
> proper "branch switching".
>
> This is obviously untested, and you would need to prime $T with an empty 
> tree before entering the loop (but you could cheat by initializing T 
> with an empty string), but it might make the code a bit more readable 
> than the current mess.  I dunno.

Yes, I'd prefer this.

Originally, I wanted to clean up filter-branch a little, but then somebody 
worked on a builtin version of it, which unfortunately came in after the 
code freeze, and I always waited for that thing to be picked up and 
enhanced.  (AFAIR there were quite a few issues which made rewrite-commits 
much less useful than it should be.)

Ciao,
Dscho
