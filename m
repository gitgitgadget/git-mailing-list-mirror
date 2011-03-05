From: Jeff King <peff@peff.net>
Subject: Re: frustrated forensics: hard to find diff that undid a fix
Date: Sat, 5 Mar 2011 08:48:47 -0500
Message-ID: <20110305134846.GA2221@sigill.intra.peff.net>
References: <4D71D63E.3030907@gmail.com>
 <m37hcd7qfv.fsf@localhost.localdomain>
 <20110305125100.GA14547@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, Adam Monsen <haircut@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 14:49:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvrqy-0007zx-8L
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 14:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab1CENst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 08:48:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45508 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab1CENst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 08:48:49 -0500
Received: (qmail 11241 invoked by uid 111); 5 Mar 2011 13:48:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Mar 2011 13:48:48 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2011 08:48:47 -0500
Content-Disposition: inline
In-Reply-To: <20110305125100.GA14547@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168494>

On Sat, Mar 05, 2011 at 06:51:00AM -0600, Jonathan Nieder wrote:

> | $ git log --oneline -m -S "$(cat contrib/fast-import/git-p4)" maint..master
> | 07873dc (from 964498e) Merge branch 'maint'
> | 6d74e5c (from 08fd871) Merge branch 'mh/p4'
> | 6d74e5c (from c9dbab0) Merge branch 'mh/p4'
> | $
> 
> Too many hits (it includes every merge in which one side contains
> the string and the other does not).  How about -c, which seemed to
> produce such nice output with --raw?

Yeah, I think the problem is that the diffcore chain doesn't know enough
about the merge. It just sees the filepairs between the commit and each
parent separately. I looked into this recently as part of this thread:

  http://article.gmane.org/gmane.comp.version-control.git/165743

I described some reasonable semantics there, but implementing them
looked non-trivial. I'd be very happy to be proven wrong. Patches
welcome. :)

-Peff
