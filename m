From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 03:45:22 -0400
Message-ID: <20091021074522.GA13531@coredump.intra.peff.net>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021063008.GA3349@glandium.org>
 <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
 <7v63a99pok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Vt0-0004a1-4w
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZJUHpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 03:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbZJUHpX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:45:23 -0400
Received: from peff.net ([208.65.91.99]:59751 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbZJUHpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 03:45:22 -0400
Received: (qmail 31755 invoked by uid 107); 21 Oct 2009 07:49:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Oct 2009 03:49:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Oct 2009 03:45:22 -0400
Content-Disposition: inline
In-Reply-To: <7v63a99pok.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130894>

On Wed, Oct 21, 2009 at 12:22:35AM -0700, Junio C Hamano wrote:

> Some people thought that throwing everything that does something to remote
> under "git remote" was a good idea, and "git remote update" was invented.
> It is a thin wrapper around "fetch" and does what "fetch" does.  You need
> to understand "fetch" (i.e. downloads the history and necessary objects,
> and updates the remote tracking branches, without ever touching the work
> tree) to understand "git remote update" anyway, and more importantly, you
> need to understand what they do not do.
> 
> It is not even a typesaver.  "git fetch" updates from the default remote,
> so does "git remote update".  Personally I think the people who invented
> "git remote update" were misguided, and that is why I say it was a failed
> UI experiment that failed, but that is hindsight talking [*1*].

Declaring it a failure depends on what you consider the goal of "git
remote update" to be. I find it very useful as a shorthand for "fetch
from _all_ remotes"[1]. Which does save typing over

  $ for i in `git remote`; do git fetch $i; done

And of course, there is "git remote" again, saving us a few keystrokes
over:

  $ git config --get-regexp 'remote..*.url' | cut -d. -f2

[1]: And I think this is a useful operation. When collaborating with
developers in multiple repositories, it is nice to see an overview of
what all other people are working on. We have other tools to actually
compare the refs, but the first step is obviously getting those refs up
to date locally.

-Peff
