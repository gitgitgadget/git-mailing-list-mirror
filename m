From: Jeff King <peff@peff.net>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 11:50:31 -0400
Message-ID: <20110617155031.GA24009@sigill.intra.peff.net>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
 <20110617141450.GA12114@sigill.intra.peff.net>
 <BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com>
 <Svak9atXpisIKwqaYKGMzry3LEHEDPnWLLqFpfgP7IOuAVUdRy8brA@cipher.nrlssc.navy.mil>
 <Oe8m5NtYZicsi6Z4FtNIXAfsB9Q9XcHSsoAYmKdxQkoDVJOKykQTEg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Mc Donnell <michael@mcdonnell.dk>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 17 17:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXbJg-0005yh-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 17:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660Ab1FQPug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 11:50:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51285
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759217Ab1FQPue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 11:50:34 -0400
Received: (qmail 26894 invoked by uid 107); 17 Jun 2011 15:50:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jun 2011 11:50:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2011 11:50:31 -0400
Content-Disposition: inline
In-Reply-To: <Oe8m5NtYZicsi6Z4FtNIXAfsB9Q9XcHSsoAYmKdxQkoDVJOKykQTEg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175955>

On Fri, Jun 17, 2011 at 10:37:54AM -0500, Brandon Casey wrote:

> >> $ git format-patch --stdout --keep-subject --attach origin | git imap-send
> 
> Wait a second.  You used --attach.
> 
> >> 2. Open Gmail in Chrome.
> >> 3. Open email in drafts folder.
> >> 4. Click attachment download link
> 
> Then you downloaded the attachment, which should be a _patch_.

Yeah, but if it is text/*, then according to rfc2046, it must be
represented with CRLF as the line break. And especially if we are
including it unencoded in a message, it is going to need CR's added.

> >> 5. Apply patch on a fresh branch with git apply.
> 
> Well, scratch what I said before, you were correct in using
> git apply.
>
> Shouldn't the attachment have it's content preserved exactly?  Maybe
> the fault does belong to gmail.

Is it gmail's fault, or the browser's?  If gmail is handing back a
text/* content-type, then my reading of rfc2046 is that it should have
CRLF line breaks.  And it would be the browser's responsibility to
convert to native line endings.  But that's the MIME spec, and was
written with mail in mind; I don't know what's normal for HTTP in these
situations. But if the problem is not "strip CR" but "convert to native
line endings" (which I think it is), then how could gmail know the
user's native line ending preference, anyway?

-Peff
