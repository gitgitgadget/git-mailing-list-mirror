From: Jeff King <peff@peff.net>
Subject: Re: How can I append authentication with "git push" ?
Date: Thu, 12 Jul 2012 05:40:40 -0400
Message-ID: <20120712094040.GA5268@sigill.intra.peff.net>
References: <20120712134844.2d1c4378@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 12 11:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpFtA-0005nC-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 11:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043Ab2GLJko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 05:40:44 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57877
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932978Ab2GLJkn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 05:40:43 -0400
Received: (qmail 19616 invoked by uid 107); 12 Jul 2012 09:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jul 2012 05:40:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 05:40:40 -0400
Content-Disposition: inline
In-Reply-To: <20120712134844.2d1c4378@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201354>

On Thu, Jul 12, 2012 at 01:48:44PM +0530, J. Bakshi wrote:

> Is there any option to add user-name and password with git push ?

The username can go in the URL. For example:

  git push user@host:repo.git

for ssh, or:

  git push https://user@host/repo.git

for http.

For ssh, you can't specify a password automatically, but you should look
into using key authentication (which can then be cached by ssh-agent).
For http, you can put the password in the URL, but there are some
security implications (like the fact that your password will be
cleartext on disk, and visible in the process list to other users on the
system).

What protocol are you using to push?

> Or any repo wise configuration file where I can save the info, so that
> it doesn't ask the credential before every push ?

Older versions of git can read from .netrc, but I would not recommend
that, as it involves storing the password in plaintext on disk.

Newer versions of git (v1.7.9 and up) support "credential helpers" which
will read from a password wallet or other secure storage provided by the
OS. There is a helper for OS X Keychain in contrib/, and somebody has
been working on one for Windows.  What platform are you using?

-Peff
