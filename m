From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 03/13] introduce credentials API
Date: Sat, 10 Dec 2011 14:48:01 -0500
Message-ID: <20111210194801.GA17999@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103111.GC16529@sigill.intra.peff.net>
 <m3r50chcvm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:48:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZSu1-00065e-Fe
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 20:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab1LJTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 14:48:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47220
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165Ab1LJTsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 14:48:04 -0500
Received: (qmail 17777 invoked by uid 107); 10 Dec 2011 19:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 14:54:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 14:48:01 -0500
Content-Disposition: inline
In-Reply-To: <m3r50chcvm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186789>

On Sat, Dec 10, 2011 at 03:43:01AM -0800, Jakub Narebski wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There are a few places in git that need to get a username
> > and password credential from the user; the most notable one
> > is HTTP authentication for smart-http pushing.
> 
> A question: does it work also for access via SSH, either without
> public key set up (i.e. 'keyboard-interactive'), or with encrypted
> private key without ssh-agent set up?

No. ssh handles its own password querying, and contacts the user
directly via the terminal. And there's not much point in using a
password helper with ssh; if you don't want to type your password, set
up a key and use ssh-agent.

> It would probably require URL i.e. ssh://git.example.com/srv/scm/repo.git
> or git+ssh://git.example.com/srv/scm/repo.git and not scp-like
> address i.e. user@git.example.com:/srv/scm/repo.git, isn't it?

It's not a matter of recognizing the URL; it's that we hand off the
authentication problem to ssh, which takes care of it entirely itself.

-Peff
