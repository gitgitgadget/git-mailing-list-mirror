From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 01:58:00 -0400
Message-ID: <20080613055800.GA26768@sigill.intra.peff.net>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 07:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72JQ-0008Ux-RE
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 07:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbYFMF6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 01:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYFMF6G
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 01:58:06 -0400
Received: from peff.net ([208.65.91.99]:3621 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbYFMF6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 01:58:04 -0400
Received: (qmail 28143 invoked by uid 111); 13 Jun 2008 05:58:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 01:58:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 01:58:00 -0400
Content-Disposition: inline
In-Reply-To: <4851F6F4.8000503@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84836>

On Fri, Jun 13, 2008 at 06:26:28AM +0200, Andreas Ericsson wrote:

> Why are branches better and more appropriate?
> Is it because the developer who first thought of stashes didn't think they'd
> be used for any halflong period of time?
> Is it because there are actions you can do on a branch that you can't do on
> a stash?
>
> Who's to say what's appropriate and not? If I explicitly tell a system to
> save something for me I damn well expect it to be around when I ask that
> same system to load it for me too.

I think we are getting into circular reasoning here (on both sides):

Branches are better, because they don't expire. Stashes expire, because
branches are a better way to do what you want.

Stashes shouldn't expire, because the user told the stash to save
information. The user considers it a "save" because stashes hold things
forever. Stashes hold things forever because they shouldn't expire.

In other words, yes, the developer who thought of stashes didn't think
they'd be used for a long period of time. That's _why_ they were
designed as they were. The status quo argument says "this is what a
stash is, because that is how it is implemented."

So I would expect people in favor of the change to say "here is why
long-term stashes are useful." And I would expect such an argument to
address the fact that we don't simply want to recreate branches (badly).
In other words, what is the compelling use case that makes people want
to stash for months at a time?

-Peff
