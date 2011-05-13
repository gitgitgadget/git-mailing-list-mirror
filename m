From: Jeff King <peff@peff.net>
Subject: Re: merging bare repository
Date: Fri, 13 May 2011 09:54:12 -0400
Message-ID: <20110513135412.GA6920@sigill.intra.peff.net>
References: <533718318.20110513145132@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 15:54:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsov-0007nb-EN
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879Ab1EMNyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 09:54:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53139
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab1EMNyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:54:15 -0400
Received: (qmail 23288 invoked by uid 107); 13 May 2011 13:56:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 May 2011 09:56:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2011 09:54:12 -0400
Content-Disposition: inline
In-Reply-To: <533718318.20110513145132@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173539>

On Fri, May 13, 2011 at 02:51:32PM +0400, Ilya Basin wrote:

> on server:
>     [git@server]$ git clone --bare ssh://git@some.org/git/project.git /git/project.git
> 
> on workstation:
>     [me@client]$ git clone ssh://git@server/git/project.git
>     [me@client]$ cd project
>     [me@client]$ touch aaa
>     [me@client]$ git add aaa
>     [me@client]$ git commit aaa -m abracadabra
>     [me@client]$ git push
> 
> back on server:
>     [git@server]$ git log
>     commit e5c871122cadfa4ed4d2ab488852ecdb803b4bd8
>     Author: Ilya Basin <>
>     Date:   Fri May 13 13:39:39 2011 +0400
> 
>         abracadabra
> 
> I want to merge with upstream
>     [git@server]$ git fetch
>     [git@server]$ git merge origin
>     fatal: This operation must be run in a work tree

Yeah, you need a work tree to do a merge, as there may be conflicts.
Moreover, you can't just do the merge via something like cron, as you
may need user intervention to resolve the conflicts.

So from your workstation, you'll want to do:

  git remote add upstream ssh://git@some.org/git/project.git
  git pull upstream

whenever you feel like merging with upstream.

-Peff
