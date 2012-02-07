From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 7 Feb 2012 13:29:53 -0500
Message-ID: <20120207182953.GA32367@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
 <20120207051719.GA11598@sigill.intra.peff.net>
 <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
 <20120207173025.GA22225@sigill.intra.peff.net>
 <7vpqdq1pxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:30:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rupnn-0006HJ-5C
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab2BGS35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:29:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59348
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354Ab2BGS3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:29:55 -0500
Received: (qmail 9850 invoked by uid 107); 7 Feb 2012 18:37:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 13:37:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 13:29:53 -0500
Content-Disposition: inline
In-Reply-To: <7vpqdq1pxt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190195>

On Tue, Feb 07, 2012 at 10:03:26AM -0800, Junio C Hamano wrote:

> > But isn't "git cola" a git-config editing program?
> 
> Yes, that is really the right "rhetorical" question to ask.  It needs to
> know what it is editing, so it at least needs to be _aware_ of the
> inclusion, where each item comes from, and how to edit contents of _one_
> particular file.
> 
> And that issue is not something new that was introduced by include.path.

True, but it was made more complex. David has already dealt with the 3
sources in his code. Adding includes expands this to N sources, and his
code needs to adapt. It would be nice if we could at least make the
adaptation backwards-compatible and as painless as possible.

But I just see the "right" answer in a complex case needing user input
that a simple call to "git config" can't provide. That is, pretending
that "git config --global" is still a single file for reading and
writing can get you something that _works_, but it will make a mess of
the user's config. The most elegant thing to me is to expand git-cola's
config editor into an N-pane editor instead of a 2-pane editor (not 3,
because it doesn't make sense to edit /etc/gitconfig with it, and nor
does the current version support it). People without includes wouldn't
notice the difference, and people with includes might appreciate the
power and flexibility.

-Peff
