From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cat-file: Fix an gcc -Wuninitialized warning
Date: Thu, 28 Mar 2013 15:02:26 -0400
Message-ID: <20130328190226.GB17178@sigill.intra.peff.net>
References: <5151F4EB.80909@ramsay1.demon.co.uk>
 <20130326193539.GB28244@sigill.intra.peff.net>
 <5154908B.1040801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:03:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULI6J-0001Qf-LI
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab3C1TCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 15:02:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098Ab3C1TCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 15:02:33 -0400
Received: (qmail 27953 invoked by uid 107); 28 Mar 2013 19:04:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 15:04:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 15:02:26 -0400
Content-Disposition: inline
In-Reply-To: <5154908B.1040801@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219447>

On Thu, Mar 28, 2013 at 06:48:43PM +0000, Ramsay Jones wrote:

> > I'm OK with this, if it's the direction we want to go. But I thought the
> > discussion kind of ended as "we do not care about these warnings on
> > ancient versions of gcc; those people should use -Wno-error=uninitialized".
> 
> Hmm, I don't recall any agreement or conclusions being reached.
> I guess I missed that!

I think Jonathan said that and nobody disagreed, and I took it as a
conclusion.

> Hmm, so are you saying that this patch is not acceptable because
> I used a compiler that is no longer supported?

No, I just think we should come to a decision on how unreadable to make
the code in order to suppress incorrect warnings on old compilers. I can
see the point in either of the following arguments:

  1. These compilers are old, and we do not need to cater to them in the
     code because people can just _not_ set -Werror=uninitialized (or
     its equivalent). It is still worth catering to bugs in modern
     compilers that most devs use, because being able to set -Werror is
     helpful.

  2. The code is not made significantly less readable, especially if you
     put in a comment, so why not help these compilers.

When we can make the code more readable _and_ help the compiler, I think
it is a no-brainer. I am on the fence otherwise and don't care that
much. I just think we should apply the rule consistently.

-Peff
