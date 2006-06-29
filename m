From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:07:19 -0400
Message-ID: <20060629180719.GB4392@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <20060629035849.GA30749@coredump.intra.peff.net> <Pine.LNX.4.64.0606291154510.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw0vF-0005JY-DK
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWF2SHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWF2SHW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:07:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:50857 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751228AbWF2SHV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:07:21 -0400
Received: (qmail 2889 invoked from network); 29 Jun 2006 14:06:59 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 14:06:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 14:07:19 -0400
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291154510.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22878>

On Thu, Jun 29, 2006 at 12:39:31PM -0400, Nicolas Pitre wrote:

> You do that lookup for every delta match attempt.  Instead it could be 
> done once for the whole window attempt, potentially reducing the cache 
> size by a factor of 20, and it might be faster too.

I'm not convinced this will provide good cache hit characteristics, and
I'm not convinced it's semantically correct (see my other mail).

> You could simply recreate the cache on each run.  Or just keep a bitmap 

Yes, that would probably work and would be quite easy to do with the
existing code.

> First, I think it should be ignored (but still created) when 
> --no-reuse-delta is passed.  Then, it should not be created (but still 
> looked up if it exists and --no-reuse-delta is not provided) when the 
> pack index file is also not created.  I don't think it is worth making 
> this further configurable, and given the suggested strategy above the 
> cache should remain fairly small.

Those suggestions make sense to me.

-Peff
