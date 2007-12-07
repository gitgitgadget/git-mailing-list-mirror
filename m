From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 19:31:21 -0800 (PST)
Message-ID: <20071206.193121.40404287.davem@davemloft.net>
References: <20071206071503.GA19504@coredump.intra.peff.net>
	<alpine.LFD.0.99999.0712060915590.555@xanadu.home>
	<20071206173946.GA10845@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: nico@cam.org, jonsmirl@gmail.com, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Dec 07 04:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0TwF-00016p-65
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 04:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbXLGDbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 22:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbXLGDbW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 22:31:22 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34692
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753023AbXLGDbW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 22:31:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 807FFC8C17F;
	Thu,  6 Dec 2007 19:31:21 -0800 (PST)
In-Reply-To: <20071206173946.GA10845@sigill.intra.peff.net>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67372>

From: Jeff King <peff@peff.net>
Date: Thu, 6 Dec 2007 12:39:47 -0500

> I tried the threaded repack with pack.threads = 3 on a dual-processor
> machine, and got:
> 
>   time git repack -a -d -f --window=250 --depth=250
> 
>   real    309m59.849s
>   user    377m43.948s
>   sys     8m23.319s
> 
>   -r--r--r-- 1 peff peff  28570088 2007-12-06 10:11 pack-1fa336f33126d762988ed6fc3f44ecbe0209da3c.idx
>   -r--r--r-- 1 peff peff 339922573 2007-12-06 10:11 pack-1fa336f33126d762988ed6fc3f44ecbe0209da3c.pack
> 
> So it is about 5% bigger. What is really disappointing is that we saved
> only about 20% of the time. I didn't sit around watching the stages, but
> my guess is that we spent a long time in the single threaded "writing
> objects" stage with a thrashing delta cache.

If someone can give me a good way to run this test case I can
have my 64-cpu Niagara-2 box crunch on this and see how fast
it goes and how much larger the resulting pack file is.
