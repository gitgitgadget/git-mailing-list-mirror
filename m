From: Jeff King <peff@peff.net>
Subject: Re: automatically removing missing files beneath a directory
Date: Thu, 8 May 2008 12:44:56 -0400
Message-ID: <20080508164456.GA29103@sigill.intra.peff.net>
References: <7f9d599f0805080939j3ef5e145w9bc2ac94f559b036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu May 08 18:45:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9Fb-0006dp-F1
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 18:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbYEHQo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 12:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYEHQoz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 12:44:55 -0400
Received: from peff.net ([208.65.91.99]:4127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbYEHQoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 12:44:54 -0400
Received: (qmail 6219 invoked by uid 111); 8 May 2008 16:44:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 12:44:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 12:44:57 -0400
Content-Disposition: inline
In-Reply-To: <7f9d599f0805080939j3ef5e145w9bc2ac94f559b036@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81537>

On Thu, May 08, 2008 at 09:39:22AM -0700, Geoffrey Irving wrote:

> If I have a subdirectory in a git repository, and I remove some files
> without telling git, is there is a simple way to automatically run the
> equivalent of 'git rm' for all the missing files?  git commit -a would
> work, except that I only want to remove files beneath a particular
> subdirectory.  git add <directory> does the equivalent operation for
> adding files, but I don't see a way to automatically remove them
> without parsing the output of git status.

See "git add -u", which will update the status of all already-tracked
files in paths you specify. Note that this will also stage changes in
modified files. If you truly want to just mark all removed files, you
can do something like:

  git ls-files --deleted -z | xargs -0 git rm

-Peff
