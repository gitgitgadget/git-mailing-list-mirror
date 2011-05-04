From: Jeff King <peff@peff.net>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 4 May 2011 04:50:14 -0400
Message-ID: <20110504085014.GA9739@sigill.intra.peff.net>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <4DC112A1.5090805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 04 10:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHXmu-0002C4-Mn
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 10:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab1EDIuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 04:50:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54915
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1EDIuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 04:50:17 -0400
Received: (qmail 16366 invoked by uid 107); 4 May 2011 08:52:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 May 2011 04:52:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2011 04:50:14 -0400
Content-Disposition: inline
In-Reply-To: <4DC112A1.5090805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172727>

On Wed, May 04, 2011 at 10:47:29AM +0200, Michael J Gruber wrote:

> The only thing I can imagine doing right now is changing
> require_work_tree() to actually cd to toplevel when possible, so that
> (like before) on success we're really within. But that changes cwd, of
> course. In summary, a require_work_tree() now can have three assumptions
> when it returns with success:
> 
> - we have a worktree
> - we are within worktree
> - cwd has not changed
> 
> I'd rather break the last one than the second one, but breaking any may
> be a problem, depending on the caller.

Check out some of the older scripts in contrib/examples. Several of them
require_work_tree, but do not cd_to_toplevel immediately; instead, they
do it much later for some specific bits.

I didn't go through and analyze what would happen in each case if we did
the cd_to_toplevel first. I suspect some of it would be pretty mild
breakage (like "git commit -F foo" not finding "foo"). But it would be
breakage nonetheless.

-Peff
