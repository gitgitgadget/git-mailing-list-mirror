From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] status: respect "-b" for porcelain format
Date: Tue, 8 May 2012 05:04:07 -0400
Message-ID: <20120508090407.GA31286@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
 <20120507212504.GE19567@sigill.intra.peff.net>
 <20120507212836.GA19753@sigill.intra.peff.net>
 <7vtxzrz2za.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 11:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRgLD-00054U-CE
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 11:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab2EHJEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 05:04:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33789
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab2EHJEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 05:04:14 -0400
Received: (qmail 32079 invoked by uid 107); 8 May 2012 09:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 05:04:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 05:04:07 -0400
Content-Disposition: inline
In-Reply-To: <7vtxzrz2za.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197348>

On Mon, May 07, 2012 at 09:55:05PM -0700, Junio C Hamano wrote:

> All patches looked good.  I thought that this deserved to eventually land
> on 'maint', so I did my usual "am first to master primarily to populate
> the object database with exact blob objects, then rebase the result to
> 'maint' while resolving conflicts both textual and semantic, and finally
> attempt to merge it back to 'master'" dance to come up with a two topic
> branches.  The result is queued in 'pu'.

I eyeballed the result. It all looks good except for patch 2 (refactor
colopts handling), which now has a totally bogus commit message. Since
colopts came much later, the only thing left in the patch is the
movement of the local "struct wt_status s" in cmd_{commit,status} to a
static at the top of each function (so that it can be referenced
directly by the options list).

Probably that patch (94f98829) should just be squashed into its parent.
And then the colopts bits can be moved to the very end, after the rest
of it, and be a part of only the non-maint topic.

I've pushed that result out to the jk/{maint-,}status-porcelain-z-b
branches at git://github.com/peff/git.git if that helps.

-Peff
