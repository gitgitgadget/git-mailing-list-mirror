From: Jeff King <peff@peff.net>
Subject: Re: bug with .git file and aliases
Date: Mon, 20 Jul 2009 11:21:17 -0400
Message-ID: <20090720152117.GB5347@coredump.intra.peff.net>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSug4-0000Wp-L1
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbZGTPVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbZGTPVP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:21:15 -0400
Received: from peff.net ([208.65.91.99]:43321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbZGTPVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:21:12 -0400
Received: (qmail 26633 invoked by uid 107); 20 Jul 2009 15:23:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Jul 2009 11:23:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 11:21:17 -0400
Content-Disposition: inline
In-Reply-To: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123610>

On Mon, Jul 20, 2009 at 09:54:12AM -0400, Geoffrey Irving wrote:

> git 1.6.3.3 has a bug related to .git file support and aliases.
> Specifically, if you make an alias for status and call it from a
> subdirectory, git status chdirs into the true .git dir but then
> chdir's back to the wrong place in order to run the lstats for status.
>  The result is that git status thinks all files have disappeared.

Yeah, this is a known problem. The problem is that the 'git' wrapper
sets up the environment only partially when running aliases, and then
the resulting command ends up confused about where the worktree is. I
really don't remember the specifics, but you can probably find some
discussion in the list archives.  Fixing it, IIRC, required some
refactoring of the setup code (which I had hoped to get to at some
point, but I am way behind on my git todo list).

Hmm. Poking around a bit, this seems related, but I don't know why I
never followed up:

  http://article.gmane.org/gmane.comp.version-control.git/72792

-Peff
