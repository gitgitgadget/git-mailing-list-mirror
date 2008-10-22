From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 15:14:16 -0400
Message-ID: <20081022191415.GA31568@coredump.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <7vd4hsv46z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:15:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsjB8-000081-Bu
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 21:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbYJVTOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYJVTOT
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 15:14:19 -0400
Received: from peff.net ([208.65.91.99]:1519 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbYJVTOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 15:14:18 -0400
Received: (qmail 3129 invoked by uid 111); 22 Oct 2008 19:14:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 15:14:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 15:14:16 -0400
Content-Disposition: inline
In-Reply-To: <7vd4hsv46z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98891>

On Wed, Oct 22, 2008 at 12:07:48PM -0700, Junio C Hamano wrote:

> Yuck.  Solaris 8 /usr/bin/grep does not even grok "-e", so we cannot do a
> more obvious:
> 
> 	grep -e "^author " -e "^summary "

Yep. I already introduced one use of egrep for a similar case in
8753941 (tests: grep portability fixes).

> Do people build with NO_EXTERNAL_GREP on older Solaris?

Yep. See:

  http://repo.or.cz/w/git/gitbuild.git?a=blob;f=jk/solaris/config.mak;hb=platform

for the gory details (boy, I wish we had nice PATH_INFO-based gitweb
URLs...).

> git-submodule.sh uses grep "-e" to look for two patterns and I suspect
> older Solaris would have the same issue.

Yes, that code will break on Solaris. Most of my portability fixes have
been in direct response to tests, so I guess we are not testing
git-submodule very well.

-Peff
