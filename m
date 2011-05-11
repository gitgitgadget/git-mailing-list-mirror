From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git revert option parsing too lenient?
Date: Wed, 11 May 2011 16:48:51 -0400
Message-ID: <20110511204851.GA29146@sigill.intra.peff.net>
References: <BANLkTi=dPzu0wrDr3aycEv68M2tw7k5m8A@mail.gmail.com>
 <20110511203645.GB28742@sigill.intra.peff.net>
 <BANLkTin5FMYJkeLTNeZ47jsXtVxvrLRL+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 22:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKGL5-0007lH-9z
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab1EKUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 16:48:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57976
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755293Ab1EKUsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 16:48:53 -0400
Received: (qmail 5919 invoked by uid 107); 11 May 2011 20:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 May 2011 16:50:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2011 16:48:51 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin5FMYJkeLTNeZ47jsXtVxvrLRL+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173426>

On Wed, May 11, 2011 at 10:44:48PM +0200, Sverre Rabbelier wrote:

> On Wed, May 11, 2011 at 22:36, Jeff King <peff@peff.net> wrote:
> > So yeah, it's a bug, but it is a known one. The trouble is that fixing
> > it means splitting the revision options into a set of "these are OK for
> > picking a revision or range of revisions" and "other options", and
> > letting commands like revert use one set but not the other.
> 
> Doing the splitting doesn't sound that hard, I assume the real problem
> is getting the option parser to look through both tables?

No, it wouldn't be that hard. You'd split handle_revision_opt into two
functions, and then probably callers of setup_revisions would pass in a
flag to say whether which subset they were interested in.

Maybe the splitting isn't hard. But I suspect it is one of those "the
devil is in the details" tasks where you will find that the options do
not fit as plainly into categories as you want. But I might be wrong.
And I don't want to discourage you from trying to work on it. :)

-Peff
