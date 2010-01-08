From: Jeff King <peff@peff.net>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 8 Jan 2010 12:21:34 -0500
Message-ID: <20100108172134.GA6344@coredump.intra.peff.net>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 18:21:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTIX3-0005J4-42
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 18:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab0AHRVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 12:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214Ab0AHRVr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 12:21:47 -0500
Received: from peff.net ([208.65.91.99]:33415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab0AHRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 12:21:46 -0500
Received: (qmail 18927 invoked by uid 107); 8 Jan 2010 17:26:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 Jan 2010 12:26:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jan 2010 12:21:34 -0500
Content-Disposition: inline
In-Reply-To: <7vskag1r5o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136460>

On Fri, Jan 08, 2010 at 08:45:55AM -0800, Junio C Hamano wrote:

> > But just looking at the ls-files output, do you not agree that there is
> > a bug?
> 
> If I agreed, I wouldn't have suggested _you_ to cd up and use pathspec,
> but instead would have suggested to patch ls-files to make it do so for
> you.

Ah, I missed the subtlety there.

> You can see it as a feature that you can use to check what would happen
> if you stopped ignoring the directory from the higher level.  With a patch
> to always cd-up and use pathspec, that will become impossible.
> 
> Maybe nobody needs such a feature (I don't), in which case we can declare
> it as a bug.  But I wasn't ready to do so myself when I wrote the message
> you are responding to, and I still am not.

That feature seems somewhat insane to me. If I wanted to know how things
would look without gitignore, I would not have said --exclude-standard.

However, I was wrong before that it ignores .gitignore. It doesn't. If
you put "cruft" instead of "subdir" into gitignore in my previous
example, it is correctly ignored. So it is sort of a "half-use
gitignore", which you cannot accomplish any other way.

I still think it's a bit crazy to have as the default behavior. But at
least it's constrained to a plumbing command, which scripts can work
around to get what they want. With the current behavior, that means the
bash prompt code should be doing "git rev-parse --show-cdup --show-prefix"
and moving to the toplevel.

-Peff
