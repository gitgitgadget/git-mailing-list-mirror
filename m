From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 16:52:09 -0400
Message-ID: <20120723205209.GA6745@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
 <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPc2-0004zA-FH
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab2GWUwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:52:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59198 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab2GWUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:52:12 -0400
Received: (qmail 7677 invoked by uid 107); 23 Jul 2012 20:52:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 16:52:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 16:52:09 -0400
Content-Disposition: inline
In-Reply-To: <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201980>

On Mon, Jul 23, 2012 at 01:49:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we launch an editor for the user to create a commit
> > message, they may put significant work into doing so.
> > Typically we try to check common mistakes that could cause
> > the commit to fail early, so that we die before the user
> > goes to the trouble.
> >
> > We may still experience some errors afterwards, though; in
> > this case, the user is given no hint that their commit
> > message has been saved. Let's tell them where it is.
> 
> Liberal use of atexit() for something like this makes me cringe
> somewhat.

I don't like it either, but there's not really a better way. The die()
that Ramana triggered in the initial report is deep inside the ident
code. The only other option would be to hook into die_routine, which I
think is even uglier.

-Peff
