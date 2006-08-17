From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 10:07:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org> <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 10:07:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDcua-0000FG-5A
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 10:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWHQIH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 04:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHQIH1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 04:07:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:37078 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932163AbWHQIH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 04:07:26 -0400
Received: (qmail invoked by alias); 17 Aug 2006 08:07:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 17 Aug 2006 10:07:24 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25556>

Hi,

On Thu, 17 Aug 2006, Johannes Schindelin wrote:

> However, I see some real problems when a public repository has a pack like 
> this: if the client is older, the server has to do some real work, 
> especially in the case of a fresh clone. It gets even worse with a public 
> HTTP repo.
> 
> The obvious short-time solution would be to make this opt-in, and use it 
> only on private repositories.
> 
> Then, one could think about how to handle the delta-chains in the pack 
> protocol (it should be easy, since you just have to store one object 
> instead of a few), and make this a "supports" option.

Oh, and I completely forgot: IIUC you have to unpack the (possibly big) 
delta-chain until you have the delta you really want, right? So, you might 
want to have a clever mechanism to keep the delta-chains short for recent 
objects (i.e. objects you are likely to need more often).

At least, the delta-chains should be limited by size (_not_ by number of 
deltas: you can have huge deltas, and if you have to unpack 5 huge deltas 
before getting to the huge delta you really need, it takes really long).

Ciao,
Dscho
