From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 17:45:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com> 
 <20060817040719.GC18500@spearce.org>  <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 17:45:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDk3d-00052h-Ma
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 17:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWHQPpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 11:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWHQPpQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 11:45:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:26320 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965044AbWHQPpO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 11:45:14 -0400
Received: (qmail invoked by alias); 17 Aug 2006 15:45:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 17 Aug 2006 17:45:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25590>

Hi,

On Thu, 17 Aug 2006, Jon Smirl wrote:

> On 8/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > At least, the delta-chains should be limited by size (_not_ by number of
> > deltas: you can have huge deltas, and if you have to unpack 5 huge deltas
> > before getting to the huge delta you really need, it takes really long).
> 
> This is not an obvious conclusion.

The big win is bought by having _one_ zlib stream for multiple deltas, 
right?

So, everytime you want to access the _last_ delta in the chain, you unpack 
_all_ of them. This quite obvious conclusion is obviously your reason to 
propose two packs, one for the archive of "old" objects, and one for the 
"new" objects.

> As for public servers there is an immediate win in shifting to the new
> pack format.  Three hour downloads vs one hour, plus the bandwidth
> bills. Are the tools smart enough to say this is a newer pack format,
> upgrade? It takes far less than two hours to upgrade your git install.

Have you thought about a non-upgraded client? The server has to repack in 
that case, and if the client wants a clone, you might not even have the 
time to kiss your server good-bye before it goes belly up.

There is an obvious choice here as to how fast people would upgrade their 
servers.

Ciao,
Dscho
