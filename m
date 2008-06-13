From: Jeff King <peff@peff.net>
Subject: Re: Dubious format-patch options
Date: Fri, 13 Jun 2008 02:33:37 -0400
Message-ID: <20080613063337.GE26768@sigill.intra.peff.net>
References: <E1K6xrt-00033S-2J@jdl.com> <alpine.LFD.1.10.0806121923400.2949@woody.linux-foundation.org> <7vtzfyxckm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72yK-0003mQ-QX
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 08:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbYFMGkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 02:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbYFMGkW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 02:40:22 -0400
Received: from peff.net ([208.65.91.99]:2320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbYFMGkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 02:40:22 -0400
Received: (qmail 30447 invoked by uid 111); 13 Jun 2008 06:33:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 02:33:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 02:33:37 -0400
Content-Disposition: inline
In-Reply-To: <7vtzfyxckm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84842>

On Thu, Jun 12, 2008 at 08:01:45PM -0700, Junio C Hamano wrote:

> makes some sense.  Being able to produce an unusable patch by saying
> 
>     $ git format-patch --stat old..
> 
> at the first glance is of quite dubious value, but even that would make
> sense as a good input source for "commit log automailer".
> 
> I think I know where Jon is coming from and where he wants to go.  While I
> am somewhat sympathetic to the cause of adding some warning or safety
> valve to prevent nonsense option combinations from being given, I am not
> sure we can draw a line to classify options into black and white.

I am against a safety valve here. For example, I have the following
alias:

  format-patch --pretty=format:%s%n%n%b

which obviously does not generate a valid email, but which I use for
pulling "how about this?" patches directly into existing emails
(otherwise, I have to delete the header cruft myself). Yes, I _could_ do
this with git-log, but format-patch has slightly different command line
semantics. And it most clearly expresses what I want: the patch
submission format, but with the header bits pretty-printed differently.

My point being that this flexibility _is_ useful, and I am not sure it
is worth removing it in favor of people who get confused about why

  git format-patch --pretty=format:%s%n%n%b origin | git send-email

doesn't work.

-Peff
