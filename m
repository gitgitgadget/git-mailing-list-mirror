From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] reduce delta head inflated size
Date: Thu, 19 Oct 2006 10:17:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610191012090.1971@xanadu.home>
References: <Pine.LNX.4.64.0610181541280.1971@xanadu.home>
 <118833cc0610190649o484afdc8lb871d4b3c5361166@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:20:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaYi6-0002K5-Mc
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934AbWJSORX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945964AbWJSORX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:17:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13953 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1945934AbWJSORW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 10:17:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7D00CP2ZOXZ230@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Oct 2006 10:17:21 -0400 (EDT)
In-reply-to: <118833cc0610190649o484afdc8lb871d4b3c5361166@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: Morten Welinder <mwelinder@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29351>

On Thu, 19 Oct 2006, Morten Welinder wrote:

> On 10/18/06, Nicolas Pitre <nico@cam.org> wrote:
> > Supposing that both the base and result sizes were both full size 64-bit
> > values, their encoding would occupy only 9.2 bytes each.  Therefore
> > inflating 64 bytes is way overkill.  Limit it to 20 bytes instead which
> > should be plenty enough for a couple years to come.
> 
> 2^63 ~ 9.2e18
> 
> Thus one signed 64-bit number can take up 1 sign + 19 digits + 1 nul.
> That's 21 bytes.

No.  In this case the value is kept binary, with bits spread over 
consecutive bytes but with the MSB indicating continuation on the next 
byte.

This means 64 bits / 7 bits per byte = 9.1 bytes, hence 10.  Then there 
are 2 of those values that makes 20 bytes.


Nicolas
