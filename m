From: Jeff King <peff@peff.net>
Subject: Re: rebase hint unmerged file removed
Date: Mon, 24 Aug 2009 10:36:57 -0400
Message-ID: <20090824143657.GA12809@coredump.intra.peff.net>
References: <20090824140549.GA3973@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfafk-00048G-1d
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbZHXOhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZHXOhD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:37:03 -0400
Received: from peff.net ([208.65.91.99]:49981 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbZHXOg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:36:59 -0400
Received: (qmail 8786 invoked by uid 107); 24 Aug 2009 14:37:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 Aug 2009 10:37:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2009 10:36:57 -0400
Content-Disposition: inline
In-Reply-To: <20090824140549.GA3973@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126933>

On Mon, Aug 24, 2009 at 10:05:49PM +0800, bill lam wrote:

> Sometimes during rebase -i, it stopped with an unmerged file but that
> file did not have any sections of conflict marked.  ls-files showed it
> had :1: and :2: but no :3:  I suspected that file was git-rm in that
> commit.  Will it be possible for git status or rebase to give hint
> that unmerged file was actually removed?

The version of "git status" in next (and presumably what will be in
v1.6.5) shows unmerged paths with more information. In this case,
you would see something like:

  $ echo content >foo && git add foo && git commit -m 'base foo'
  $ echo changes >>foo && git add foo && git commit -m 'change foo'
  $ git checkout -b other HEAD^
  $ git rm foo && git commit -m 'remove foo'
  $ git rebase master
  $ git status
  # Unmerged paths:
  #   (use "git reset HEAD <file>..." to unstage)
  #   (use "git add <file>..." to mark resolution)
  #
  #       deleted by them:    foo
  #

-Peff
