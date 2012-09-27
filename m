From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision: add --reflog-message to grep reflog messages
Date: Thu, 27 Sep 2012 13:28:44 -0400
Message-ID: <20120927172844.GC1547@sigill.intra.peff.net>
References: <7va9wctwg4.fsf@alter.siamese.dyndns.org>
 <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 <7v4nmjs88n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHtP-00063Y-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab2I0R2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:28:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32908 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2I0R2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:28:46 -0400
Received: (qmail 3359 invoked by uid 107); 27 Sep 2012 17:29:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 13:29:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 13:28:44 -0400
Content-Disposition: inline
In-Reply-To: <7v4nmjs88n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206493>

On Thu, Sep 27, 2012 at 10:09:28AM -0700, Junio C Hamano wrote:

> > +--reflog-message=<pattern>::
> > +	Limit the commits output to ones with reflog entries that
> > +	match the specified pattern (regular expression). Ignored unless
> > +	--walk-reflogs is given.
> > +
> 
> I am debating myself if it is sane for this option to have no hint
> that it is about "limiting" in its name.  "--author/--committer"
> don't and it is clear from the context of the command that they are
> not about setting author/committer, so "--reflog-message" may be
> interpreted the same, perhaps.

I also found the name confusing on first-read. While "--author" is an
example in one direction, the fact that "--grep" is not called "--body"
is a counter-example.

I'd much rather see it as "--grep-reflog" or something. You could also
do "--grep-reflog-message", which would match a later
"--grep-reflog-author", but I am not sure anybody would want the latter,
and it makes the current name a lot longer.

I actually think just checking the reflog when we call "--grep" would
the most common workflow, and requires no extra work from the user.  My
only hesitation is that if somebody _does_ want to distinguish, there's
no escape hatch. Of course, the reflog walker is already full of such
weird conflations (e.g., the rewriting of parent and date information).

-Peff
