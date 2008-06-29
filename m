From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Documentation: Don't assume git-sh-setup and
	git-parse-remote are in the PATH
Date: Sun, 29 Jun 2008 01:38:23 -0400
Message-ID: <20080629053823.GA8262@sigill.intra.peff.net>
References: <20080627151001.BIA19424@m4500-01.uchicago.edu> <20080628205817.GB3172@steel.home> <7vvdztmfrk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 07:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCpdD-0000H6-Kw
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 07:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbYF2Fi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 01:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbYF2Fi0
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 01:38:26 -0400
Received: from peff.net ([208.65.91.99]:1635 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbYF2Fi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 01:38:26 -0400
Received: (qmail 15285 invoked by uid 111); 29 Jun 2008 05:38:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 29 Jun 2008 01:38:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jun 2008 01:38:23 -0400
Content-Disposition: inline
In-Reply-To: <7vvdztmfrk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86760>

On Sat, Jun 28, 2008 at 02:05:51PM -0700, Junio C Hamano wrote:

> > What do you need exec-path in PATH for?
> 
> When git-parse-remote is not installed in $(bindir) anymore, the shell
> script library won't be found on user's $PATH in general.

I think the right question is:

  PATH=$PATH:$(git --exec-path)
  . git-sh-setup

or

  . "$(git --exec-path)/git-sh-setup"

?

Generally, I would prefer the latter because it has no side effects. For
now at least, though, shell scripts probably want git's exec-path in
their PATH so "git-foo" invocations don't break.

-Peff
