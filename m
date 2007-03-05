From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 23:56:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703052339050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305072323.GA31169@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.30394.172067.743310@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.36569.805689.922989@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
 <17900.39124.763603.695942@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:56:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOM6I-00083Q-OS
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 23:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXCEW4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbXCEW4K
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 17:56:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:38014 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751783AbXCEW4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 17:56:08 -0500
Received: (qmail invoked by alias); 05 Mar 2007 22:56:06 -0000
X-Provags-ID: V01U2FsdGVkX1/D52cSHbTD/0cEpP+yX/Q+UfT4pfEZx1Vi1p80gZ
	ptPwzPw8MsNd5o
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17900.39124.763603.695942@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41499>

Hi,

On Mon, 5 Mar 2007, Bill Lear wrote:

> On Monday, March 5, 2007 at 13:50:45 (-0800) Linus Torvalds writes:
> >On Mon, 5 Mar 2007, Bill Lear wrote:
> >> 
> >> Not because git wrote the file, but because git notices that content
> >> changes, and writes the file (and timestamps it) "smartly".  If
> >> someone writes into the repo, the timestamp stored becomes invalidated
> >> and the write of the file just creates the timestamp at the time of
> >> the checkout.  If no write into the repo index occurs, the stored
> >> timestamp is applied after the file is checked out.
> >
> >But Bill, don't you realize that restoring the timestamp is *WRONG*?
> 
> Maybe, maybe not.  Each argument I've seen doesn't convince me.  Sure,
> it may be MESSY.  It may be UGLY, and therefore undesirable, but I
> don't think any of the arguments have conclusively shown that it
> is WRONG or INFEASIBLE in any way.

It may not be infeasible.

But it is wrong. It "fixes" a totallc clear idiom, namely that every time 
a file is written into, the timestamp changes. And guess what, "touch 
<file>" is the best proof that sometimes, you want that this happens, even 
if the content stays the same.

> If someone pushes into my repo, as Johannes suggested (how that would 
> work, being a non-bare repo, is beyond me, but whatever),

Of course this works. That is a fundamental feature of Git: if you strip a 
non-bare repo of its working directory, then it becomes a bare repo.

> the timestamp for that file on that branch would be invalidated, and the 
> file would get whatever timestamp it got when it was written to disk.

This approach is so fragile! It is invasive, easy to get wrong (count the 
ways how to invalidate the timestamp), and serves only an obscure use 
case, which is better solved otherwise to begin with.

> >So stop even asking for this. We'd have to be totally and utterly 
> >incompetent to do what you ask for. We're simply not that stupid. 

FWIW I have to agree here. I saw quite a few projects go wrong, because 
management insisted on abolishing a perfectly good design, just because 
they had this pet idea.

> >We already pointed out how you can do what you want to do *other* ways 
> >that are *not* idiotic and incompetent. I don't think you even 
> >answered.
> 
> I am not asking for this, I'm just arguing the point, waiting for a
> convincing argument rather than having someone call me "idiotic and
> incompetent" and "stupid" for asking for it in the first place and
> carrying on in the spirit of discovery and open learning.
> 
> For your information, I did in fact answer, politely, thanking the
> poster for pointing our hash-based "stamps" that could do this sort of
> thing.

No. This is not what Linus was referring to (unless I am really wrong 
here, which I refuse to believe).

We pointed out, in several ways, how much easier it is to create a 
throw-away working directory.

It is easy, robust, and can be done _right now_ with Git.

Ciao,
Dscho
