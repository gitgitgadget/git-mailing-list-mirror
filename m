From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Sun, 8 Feb 2009 03:59:33 -0500
Message-ID: <20090208085933.GB4392@coredump.intra.peff.net>
References: <20090207064221.GA14856@coredump.intra.peff.net> <20090207064454.GB14906@coredump.intra.peff.net> <7vljsizog1.fsf@gitster.siamese.dyndns.org> <20090207114444.GB18079@coredump.intra.peff.net> <7viqnludiv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW5XE-0003DO-2f
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZBHI7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 03:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZBHI7g
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 03:59:36 -0500
Received: from peff.net ([208.65.91.99]:53543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbZBHI7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 03:59:36 -0500
Received: (qmail 25935 invoked by uid 107); 8 Feb 2009 08:59:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 03:59:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 03:59:33 -0500
Content-Disposition: inline
In-Reply-To: <7viqnludiv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108933>

On Sat, Feb 07, 2009 at 01:45:44PM -0800, Junio C Hamano wrote:

> > Because I would expect "git check-ignore foo/bar | grep ^foo/bar:" to
> > tell me if and how foo/bar is being excluded. But I have to instead
> > check for ^foo and ^foo/bar.
> 
> Sorry, I do not understand why you need the downstream pipe that filters
> using grep to begin with.

Sorry, I should have been more clear. The grep was meant to simulate
what my eyes and brain are doing. That is, if I ask "what are patterns
affecting foo/bar?", I expect to see "foo/bar" in the output.

For asking about one path, it may not be that big a deal to see that the
output matches to the input. But if I feed a hundred paths to
check-ignore, I expect to be able to scan the output for the input I put
in.

> Shouldn't "git check-ignore dir/path" talk about the exclude entries that
> caused dir/path to be excluded and no other patterns?  And if the reason

Yes, I would think so. Which maybe means using the current "exclude"
code is not appropriate. Because it is really about traversing the
directory structure, excluding as we go. I don't know that you can
directly ask it about a particular path.

-Peff
