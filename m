From: Jeff King <peff@peff.net>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Sun, 7 Sep 2008 11:50:33 -0400
Message-ID: <20080907155033.GA25031@coredump.intra.peff.net>
References: <48C1D2AE.3010001@feds.uwaterloo.ca> <20080906012941.GA2009@coredump.intra.peff.net> <48C3E35C.2050903@feds.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Gerlach <egerlach@feds.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Sep 07 17:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcMYC-0005Bc-Ka
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 17:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYIGPuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 11:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYIGPuh
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 11:50:37 -0400
Received: from peff.net ([208.65.91.99]:1443 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbYIGPuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 11:50:37 -0400
Received: (qmail 10796 invoked by uid 111); 7 Sep 2008 15:50:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Sep 2008 11:50:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Sep 2008 11:50:33 -0400
Content-Disposition: inline
In-Reply-To: <48C3E35C.2050903@feds.uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95145>

On Sun, Sep 07, 2008 at 10:21:16AM -0400, Eric Gerlach wrote:

>>> I'm trying to test to see if "git diff --cached" will fail because 
>>> there  are no existing commits.  I've come up with running "git 
>>> show-ref -h -q"  and testing its return value.  My hypothesis is: If 
>>
>> Maybe "git rev-parse --verify HEAD"?
>
> That seems like it would work too... any reason one would be better than  
> the other?

My thinking was:

  1. It's a plumbing command, and so less likely to change its behavior
     versus "git diff".

  2. The seems more obvious to me. rev-parse --verify is meant to ask
     "is this a valid object name?"

It is slightly different from your show-ref. Yours asks "is there
anything in refs/heads in this repository?" Mine asks "does the current
HEAD exist?" In practice, they are both reasonable tests, since once you
have a branch, it is very difficult to get HEAD to point to something
invalid short of editing manually to some bogus value. But you might
prefer one over the other depending on what you are trying to say.

-Peff
