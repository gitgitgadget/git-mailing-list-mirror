From: Jeff King <peff@peff.net>
Subject: Re: t0005-signals.sh fails with ksh
Date: Fri, 8 May 2015 17:21:47 -0400
Message-ID: <20150508212146.GA16614@peff.net>
References: <31108626.20150508231514@gmail.com>
 <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
 <20150508205548.GB13457@peff.net>
 <xmqqwq0iixcs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:21:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpiU-0005zK-Ix
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbbEHVVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:21:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:55894 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbbEHVVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:21:49 -0400
Received: (qmail 26436 invoked by uid 102); 8 May 2015 21:21:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 16:21:49 -0500
Received: (qmail 23839 invoked by uid 107); 8 May 2015 21:22:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 17:22:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2015 17:21:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq0iixcs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268674>

On Fri, May 08, 2015 at 02:16:19PM -0700, Junio C Hamano wrote:

> Yeah, ksh has gone too far and now is on the other side, I would
> have to say.  Introducing new keywords and semantics to let its
> users use new features (e.g. "let") is one thing, but breaking a
> valid POSIX shell construct and interpreting it in an incompatible
> way is going just too far for it to be treated as a Bourne variant.

Yeah, especially after my followup email, I think I'm not on the fence
anymore.

> I wonder if zsh is in the same league.  Do we support people who do
> SHELL_PATH=/bin/zsh and bend over backwards when it breaks?

I tried "make SHELL_PATH=zsh test", but had trouble seeing the test
output for all of the errors being spewed to stderr. ;)

Certainly this:

  $ zsh ./t0000-basic.sh -v -i
  > [...]
  test_cmp:1: command not found: diff -u
  not ok 4 - pretend we have a fully passing test suite

is not especially encouraging (it looks like running "$FOO bar" does not
word-split $FOO). I am not a zsh user, though, so there may be ways to
convince it to be more POSIX-y (e.g., just calling it as "sh").

-Peff
