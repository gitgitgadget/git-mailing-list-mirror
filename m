From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Wed, 20 Jun 2012 14:52:37 -0400
Message-ID: <20120620185237.GA31520@sigill.intra.peff.net>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
 <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
 <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
 <20120619135814.GA3210@sigill.intra.peff.net>
 <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
 <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
 <20120620160607.GA12856@sigill.intra.peff.net>
 <7vpq8tvn5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQ1J-00005j-3f
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab2FTSwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:52:42 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39091
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252Ab2FTSwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:52:40 -0400
Received: (qmail 27514 invoked by uid 107); 20 Jun 2012 18:52:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:52:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:52:37 -0400
Content-Disposition: inline
In-Reply-To: <7vpq8tvn5i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200331>

On Wed, Jun 20, 2012 at 11:44:25AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Fine by me. I think "xdiff_found_changes" is not quite accurate; it is
> > really "did builtin_diff find any changes?" since we might never call
> > into xdiff (e.g., for binary files). I'm not sure what the best name is.
> 
> "diffopt.found_changes" is clear enough for me.

I thought this bug would be enough to show that diffopt.found_changes is
not clear enough. It is the source of the original bug (the code should
have been using HAS_CHANGES instead of found_changes), and it gave at
least one of the bug investigators (i.e., me) quite a bit of confusion
to understand why found_changes was not being set when diff_flush found
changes.

IOW, as a naive reader of the "struct diff_options", how do I understand
the difference between HAS_CHANGES and found_changes?

-Peff
