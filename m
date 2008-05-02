From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 08:55:54 -0400
Message-ID: <20080502125553.GB2923@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jruod-0004CQ-CM
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbYEBMzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765105AbYEBMzz
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:55:55 -0400
Received: from peff.net ([208.65.91.99]:1424 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764557AbYEBMzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:55:54 -0400
Received: (qmail 1744 invoked by uid 111); 2 May 2008 12:55:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 08:55:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 08:55:54 -0400
Content-Disposition: inline
In-Reply-To: <7vd4o5xm62.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80985>

On Thu, May 01, 2008 at 11:19:49PM -0700, Junio C Hamano wrote:

> Heh, I like it.  I briefly thought that pager.cat-file may wreak havoc on
> scripts, but our pager machanism should be clever enough not to, and
> cat-file is a valid variable name in the configuration file format ;-).

Yes, I sort of assumed that the pager "auto" setting would take care of
most things. I guess somebody could be crazy enough to set pager to
"always" and pager.mailinfo to "true", but I'm not sure that's worth
avoiding.

My bigger worry is that this affects only builtins. Which makes it
sufficient for turning off the pager for anything that does USE_PAGER.
But you can't turn _on_ the pager for arbitrary commands (e.g.,
pager.pull would be ignored). And some commands use pagers from
sub-commands; e.g., git-stash calls git-diff to show a stash; so turning
off the pager entails setting pager.diff, with no way to differentiate
between stash and regular diff.

So it would be inconsistent and expose implementation details. But maybe
that is OK for now, and we just say "well, everything will become a
builtin eventually." ;)

-Peff
