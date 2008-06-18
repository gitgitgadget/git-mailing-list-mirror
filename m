From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
	further processing
Date: Tue, 17 Jun 2008 23:30:10 -0400
Message-ID: <20080618033010.GA19657@sigill.intra.peff.net>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	madcoder@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 05:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8oO7-000419-9O
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbYFRDaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757107AbYFRDaP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:30:15 -0400
Received: from peff.net ([208.65.91.99]:1282 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491AbYFRDaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:30:13 -0400
Received: (qmail 3067 invoked by uid 111); 18 Jun 2008 03:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 17 Jun 2008 23:30:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2008 23:30:10 -0400
Content-Disposition: inline
In-Reply-To: <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85359>

On Tue, Jun 17, 2008 at 08:21:50PM -0700, Junio C Hamano wrote:

> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
> 
> > This adds the PARSE_OPT_NO_ERROR_ON_UNKNOWN flag which prevents
> > parse_options() from erroring out when it finds an unknown option,
> > and leaves the original command and unknown options in argv.
> 
> I have to say that this conceptually is broken.  How would you tell
> without knowing what "--flag" is if the thing in argv[] after that is a
> parameter to that option or the end of the options?

Agreed. I was just about to write the same thing. As it happens, I think
in the case of git-shortlog that there is not likely to be such a
parameter. The only three I see looking over setup_revisions are "-n"
(which is masked by shortlog anyway), "--default", and "-U" (which one
would never need with shortlog).

However I am still opposed to the concept, since its presence as a
parseopt flag implies that it isn't fundamentally broken.

I think the only right way to accomplish this is to convert the revision
and diff parameters into a parseopt-understandable format.

-Peff
