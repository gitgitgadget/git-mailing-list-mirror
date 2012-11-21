From: Jeff King <peff@peff.net>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 15:13:48 -0500
Message-ID: <20121121201348.GG16280@sigill.intra.peff.net>
References: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us>
 <20121121092750.GA8262@shrek.podlesie.net>
 <20121121193401.GC16280@sigill.intra.peff.net>
 <7va9ua20nz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 21:14:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGgP-0003Iq-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 21:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab2KUUNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 15:13:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54500 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756190Ab2KUUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 15:13:51 -0500
Received: (qmail 9956 invoked by uid 107); 21 Nov 2012 20:14:44 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 15:14:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 15:13:48 -0500
Content-Disposition: inline
In-Reply-To: <7va9ua20nz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210174>

On Wed, Nov 21, 2012 at 11:53:04AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [1] Given the core-dumping behavior of SIGQUIT, I suspect it is not
> >     nearly as widely used as SIGINT, but it sounds more like the
> >     principle of least surprise to treat them the same.
> 
> Sounds sensible.  I wonder what happens when the editor is suspended
> ;-)

I think we would want to leave SIGTSTP alone; the editor should
typically respect it, and we would want to also pause until we get
SIGCONT (although even if we did continue, we would just be blocking on
wait() for the editor, anyway, so it is not a big deal).

Implicit in my "least surprise" comment above is that handling SIGQUIT
would match what system(3) does, so it makes sense to me to match that
(it also blocks SIGCHLD, but I do not think that really matters from a
user-visible perspective).

-Peff
