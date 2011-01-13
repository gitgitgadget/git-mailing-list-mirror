From: Jeff King <peff@peff.net>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Thu, 13 Jan 2011 13:47:39 -0500
Message-ID: <20110113184739.GA7785@sigill.intra.peff.net>
References: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: JT Olds <jtolds@xnet5.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 19:47:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdSD7-0002D8-LW
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 19:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690Ab1AMSro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 13:47:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43123 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab1AMSrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 13:47:43 -0500
Received: (qmail 32333 invoked by uid 111); 13 Jan 2011 18:47:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 13 Jan 2011 18:47:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jan 2011 13:47:39 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165062>

On Thu, Jan 13, 2011 at 10:00:45AM -0700, JT Olds wrote:

> I don't have git-sh-setup, which seems like it should be included in
> the git-core package, but it's not. I have git-core
> 1:1.7.1-1.1ubuntu0.1 installed. Obviously this precludes
> get_author_ident_from_commit from working.

Oops, sorry about that. It ships in the /usr/lib/git-core directory
these days (it _used_ to ship in /usr/bin, so "." would find it
automatically). And when I did my test, I was using the git repository
itself, so of course it was in my current directory then. :)

But it looks like you found it.

> Author: jt@instructure.com
> Email: jt@instructure.com
> Subject: removing nondeterminism from test
> Date: Tue, 11 Jan 2011 07:42:30 -0700
> 
> Should "Author" be my name? Could that be what's going on? I don't
> even know where that gets set. The ones that I failed to notice that
> they broke before I pushed them look like this:

Yep, it should be your name. So my next to suspect would be the
git-mailinfo parser, and indeed, that's the thing that has the
3-character limit that Erik mentioned.

So that's definitely the problem.

-Peff
