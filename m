From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 08:09:38 -0400
Message-ID: <20110328120938.GA14198@sigill.intra.peff.net>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <4D9037AA.9090601@drmicha.warpmail.net>
 <20110328115421.GA9232@sigill.intra.peff.net>
 <4D90787A.8010403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 14:09:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4BGa-00037s-Es
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab1C1MJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:09:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48205
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839Ab1C1MJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 08:09:40 -0400
Received: (qmail 9141 invoked by uid 107); 28 Mar 2011 12:10:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 08:10:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 08:09:38 -0400
Content-Disposition: inline
In-Reply-To: <4D90787A.8010403@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170118>

On Mon, Mar 28, 2011 at 02:00:58PM +0200, Michael J Gruber wrote:

> >> We could safeguard scripts from this by
> >>
> >> - checking istty and
> >> - checking env for GIT_PLUMBING
> > 
> > I'm not sure isatty is a good check. In the example above, grep's output
> > was not going to a tty, but I did want to respect the user's choice of
> > "-E".
> 
> I'm not saying it's good either, but it is something that a new git
> (i.e. between the time we introduce ui.* and GIT_PLUMBING/--no-plum and
> the time we rely on the latter) could do to make use of (and promote)
> the new ui.* options.

The example I gave was a false negative (we could have used the user's
preference but the isatty check said no). Which is OK for a transitional
period, because we err on the side of being conservative.  But I wonder
if there are false positives (i.e., cases where the isatty check says
it's OK, but we are breaking a script).  Maybe something where the
script prepares a BRE to hand to git-grep, but we want to show the user
the output in their usual way.

That seems pretty contrived, though. Maybe it is a non-issue.

-Peff
