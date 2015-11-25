From: Jeff King <peff@peff.net>
Subject: Re: Suspected bug on `git -C <rp> rev-list --all` where <rp> has 0
 commits
Date: Wed, 25 Nov 2015 04:07:47 -0500
Message-ID: <20151125090746.GC4696@sigill.intra.peff.net>
References: <20151111192634.629102e6@linux-apw9.site>
 <CA+izobv6OuAAjnKH5A=vcmJh3yDhWi41WAD-OmVSN2d7P_5SGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: yac <yac@blesmrt.net>, git@vger.kernel.org
To: Atousa Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 10:07:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1W3Q-0005Pe-3y
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbbKYJHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 04:07:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:33753 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754850AbbKYJHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:07:49 -0500
Received: (qmail 28125 invoked by uid 102); 25 Nov 2015 09:07:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 03:07:49 -0600
Received: (qmail 24316 invoked by uid 107); 25 Nov 2015 09:07:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 04:07:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 04:07:47 -0500
Content-Disposition: inline
In-Reply-To: <CA+izobv6OuAAjnKH5A=vcmJh3yDhWi41WAD-OmVSN2d7P_5SGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281688>

On Tue, Nov 24, 2015 at 10:56:50PM -0800, Atousa Duprat wrote:

> I agree with Yac that this error is unwarranted, though it's been like
> that since forever.
> If a repo is empty, git rev-list should probably just return without
> erroring out.
> The fix is trivial, if the list agrees that this is in fact legit.

I think we had a similar discussion for "git log" with an empty HEAD,
and decided that it was better to keep the behavior the same for
compatibility reasons. I think that would apply doubly for rev-list,
which is used by scripts.

In the "log" case, we did improve the error message:

  $ git init
  $ git.v2.5.0 log
  fatal: bad default revision 'HEAD'
  $ git.v2.6.3 log
  fatal: your current branch 'master' does not have any commits yet

Maybe a good first step would be improving the error message?

-Peff
