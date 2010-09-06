From: Jeff King <peff@peff.net>
Subject: Re: Determining commit reachability
Date: Sun, 5 Sep 2010 23:17:01 -0400
Message-ID: <20100906031700.GA25012@sigill.intra.peff.net>
References: <4C83FEC3.3040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 05:16:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsSCK-00009x-Kq
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 05:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab0IFDQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 23:16:40 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755048Ab0IFDQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 23:16:39 -0400
Received: (qmail 27050 invoked by uid 111); 6 Sep 2010 03:16:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 06 Sep 2010 03:16:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Sep 2010 23:17:01 -0400
Content-Disposition: inline
In-Reply-To: <4C83FEC3.3040101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155518>

On Sun, Sep 05, 2010 at 10:34:11PM +0200, Artur Skawina wrote:

> Given commit C, refs (branches) R, S and T what would be the best way
> to test whether 'C' is reachable from any of the heads?
> 
> Checking if `git rev-list -n1 O ^R ^S ^T` produces any output is what
> i came up with; is there a better (ie faster) solution?

I think that is about as fast as you will get. You could try something
with git-merge-base, but it should be about the same speed.

Note that neither will tell you _which_ head the target was reachable
from. For that, given the current interface you have to test each head
individually. If you write some C code, you can do it all in a single
traversal. See this thread for some discussion of how "git tag
--contains" can be sped up:

  http://article.gmane.org/gmane.comp.version-control.git/150039

-Peff
