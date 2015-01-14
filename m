From: Jeff King <peff@peff.net>
Subject: Re: git ignores /~/.config/git/
Date: Wed, 14 Jan 2015 16:07:52 -0500
Message-ID: <20150114210751.GD1155@peff.net>
References: <20150114193307.GA2592@lejenome.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Moez Bouhlel <bmoez.j@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBVAW-0002JD-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbbANVHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:07:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:34603 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752140AbbANVHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:07:54 -0500
Received: (qmail 15036 invoked by uid 102); 14 Jan 2015 21:07:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 15:07:54 -0600
Received: (qmail 6687 invoked by uid 107); 14 Jan 2015 21:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 16:08:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 16:07:52 -0500
Content-Disposition: inline
In-Reply-To: <20150114193307.GA2592@lejenome.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262430>

On Wed, Jan 14, 2015 at 07:33:07PM +0000, Moez Bouhlel wrote:

> git exludes /~/.config/git/ from the matching list.
> 
> ~ is the name of a dir on the root of git working tree and not my user home dir.

I'm not quite sure what you mean by "matching list". Do you mean that
the path is not listed as untracked in "git status"?

Are there any files inside the directory? Git will not mention empty
directories, as tracks only file content, not directories.

Beyond that, I cannot reproduce:

  $ git init
  $ mkdir -p '~/.config/git'
  $ git status -s

Lack of output is expected, since there are no files. Now:

  $ echo content >'~/.config/git/foo'
  $ git status -s
  ?? ~/
  $ git status -s -uall
  ?? ~/.config/git/foo

This is on Linux. Are you by any chance using Git for Windows? I wonder
if the recent chances to short-names like "foo~1" could have affected
this.

-Peff
