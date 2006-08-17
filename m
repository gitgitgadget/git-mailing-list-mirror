From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 09:56:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 09:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDcjo-0006cs-W6
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 09:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWHQH4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 03:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWHQH4U
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 03:56:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:41187 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932235AbWHQH4T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 03:56:19 -0400
Received: (qmail invoked by alias); 17 Aug 2006 07:56:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 17 Aug 2006 09:56:18 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060817040719.GC18500@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25555>

Hi,

On Thu, 17 Aug 2006, Shawn Pearce wrote:

> Jon Smirl <jonsmirl@gmail.com> wrote:
> > 
> > One entry per delta -  845,42,0150
> > Packed deltas - 295,018,474
> > 65% smaller

Impressed.

> Unfortunately I can't think of a way to make this type of pack
> readable by older software.  So this could be creating a pretty
> big change in the pack format, relatively speaking.  :)

Not necessarily: the format could stay the same, where multiple object 
names point to the same entry.

It should not be a problem, as long as this change is kept local: the same 
git tools which created this kind of pack have to read it.

However, I see some real problems when a public repository has a pack like 
this: if the client is older, the server has to do some real work, 
especially in the case of a fresh clone. It gets even worse with a public 
HTTP repo.

The obvious short-time solution would be to make this opt-in, and use it 
only on private repositories.

Then, one could think about how to handle the delta-chains in the pack 
protocol (it should be easy, since you just have to store one object 
instead of a few), and make this a "supports" option.

Ciao,
Dscho
