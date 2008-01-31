From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match
	directory "foo"
Date: Thu, 31 Jan 2008 05:42:56 -0500
Message-ID: <20080131104256.GF25546@coredump.intra.peff.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com> <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com> <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org> <47A06EF9.60704@users.sourceforge.net> <7vprvjgi9v.fsf@gitster.siamese.dyndns.org> <47A1733E.9040103@users.sourceforge.net> <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org> <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org> <20080131094124.GA25546@coredump.intra.peff.net> <7vfxwecmfe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Piatyszek <ediap@users.sourceforge.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWtI-00086a-Iy
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762976AbYAaKnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYAaKnA
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:43:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4728 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756448AbYAaKm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:42:59 -0500
Received: (qmail 28272 invoked by uid 111); 31 Jan 2008 10:42:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 31 Jan 2008 05:42:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2008 05:42:56 -0500
Content-Disposition: inline
In-Reply-To: <7vfxwecmfe.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72125>

On Thu, Jan 31, 2008 at 02:35:33AM -0800, Junio C Hamano wrote:

> Without "foo/", you do not have to pay the price, so I think
> that is a sane optimization, but at the same time it would make
> it worse if "foo/" is actually used.  excluded_1() is called for
> the same pathname from a loop to check for a match and you would
> end up running lstat(2) three times (once each for EXC_CMDL,
> EXC_DIRS and EXC_FILE).
> 
> But maybe people who want "foo/" deserve it.  I dunno.

Ah, I didn't look at it that closely.

To do the laziness right, I think you would need to pass a pointer to
the dtype around, and just fill it in the first time it is needed.

-Peff
