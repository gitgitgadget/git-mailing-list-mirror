From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 02:01:11 -0500
Message-ID: <20071211070111.GA25955@coredump.intra.peff.net>
References: <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z7X-0006ZN-QH
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbXLKHBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXLKHBP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:01:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1542 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbXLKHBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:01:13 -0500
Received: (qmail 6936 invoked by uid 111); 11 Dec 2007 07:01:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 02:01:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 02:01:11 -0500
Content-Disposition: inline
In-Reply-To: <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67812>

On Mon, Dec 10, 2007 at 05:27:17PM -0800, Junio C Hamano wrote:

> >    I suspect there are still some bugs lurking in there, but it's hard
> >    to say because I don't know what the behavior _should_ be (there are
> >    some test cases in that email).
> 
> The last time I looked at the "directory" side of builtin-clean.c, I had
> to quickly reach for my barf bag.  I never use "git clean" without "-n"
> and I never ever use "git clean" with "-d"; I do not have any idea what
> behaviour when given "-d" would be useful.  AFAIU, the scripted version
> did not have clear semantics either.

I had the same feeling. I am tempted to leave it, then. The
non-intuitive behavior I managed to trigger was:

  - _only_ when using git pathspec matching like "git clean -n '*.ext'"
  - confusing in a safe way (trying to remove 'dir.ext' with '*.ext'
    will accidentally not happen, rather than accidentally happening)

So unless somebody complains, it is probably not a big problem,
and I think fixing it will require mucking with pathspec and dir
matching internals, which would be nice not to do right before v1.5.4.

OTOH, leaving something that is broken and just hoping nobody will
complain feels kind of wrong. :)

-Peff
