From: Jeff King <peff@peff.net>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Fri, 29 Apr 2011 18:34:33 -0400
Message-ID: <20110429223433.GA3434@sigill.intra.peff.net>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:34:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwGo-00005a-Dy
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab1D2Weh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:34:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52333
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab1D2Weh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:34:37 -0400
Received: (qmail 16963 invoked by uid 107); 29 Apr 2011 22:36:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 18:36:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 18:34:33 -0400
Content-Disposition: inline
In-Reply-To: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172500>

On Fri, Apr 29, 2011 at 05:53:15PM +0200, Michael J Gruber wrote:

> HEAD~n is often used for rebase invocations etc. Make it use the same
> default we use in other places, i.e. ~n == HEAD~n.

Hmm. It certainly makes sense in that we often default emptiness to
HEAD, but I don't think we can extend this syntax to other things. For
example, seeing ~n makes me think that ^n or ^{tree} would work. But of
course "^" at the beginning of a ref means something completely
different. So it's not completely consistent.

Consistency-wise, I'm not sure if it makes things better or worse.
Obviously we have "foo.." with an implicit HEAD. You could argue that
".." is a different operator altogether, and that any operator that is a
"ref modifier" like "~" or "^" needs to have a non-implicit ref. But
that gets muddier with "@{4.hours.ago}", which also takes an implicit
value, except that it isn't exactly HEAD. It's the branch pointed to by
HEAD.

So there really isn't a lot of consistency, I guess.  It also conflicts
a little with the shell's "~user" syntax, though presumably you don't
have users named "1" and "2".

-Peff
