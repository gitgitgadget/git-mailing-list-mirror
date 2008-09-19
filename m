From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] extend meaning of "--root" option to index
	comparisons
Date: Fri, 19 Sep 2008 10:25:38 -0400
Message-ID: <20080919142537.GA1287@coredump.intra.peff.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <48CECA42.1050209@drmicha.warpmail.net> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net> <20080918092152.GA18732@coredump.intra.peff.net> <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 16:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kggwb-0003by-GL
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 16:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbYISOZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYISOZl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 10:25:41 -0400
Received: from peff.net ([208.65.91.99]:2563 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbYISOZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 10:25:40 -0400
Received: (qmail 17124 invoked by uid 111); 19 Sep 2008 14:25:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Sep 2008 10:25:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Sep 2008 10:25:38 -0400
Content-Disposition: inline
In-Reply-To: <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96290>

On Thu, Sep 18, 2008 at 09:31:24AM -0700, Anatol Pomozov wrote:

> > Can you think of any other cases?
> 
> git log??
> 
> git log --root for empty repo should not print anything (instead of
> error message that we have now).

I'm not sure that's the same as "--root", though. In existing --root
cases, we are saying "pretend that beyond the initial commit, there is a
commit that contains the empty tree". The logical extension of git-log
here would be to print out that commit.

Not to mention that "git log --root" _already_ has defined semantics
(you just don't really need it since log.showroot defaults to true).

I wonder if my patch is actually confusing things more, and the right
solution is an option that says "pretend that a non-existant HEAD is a
commit with no log and the empty tree." But I think that may just be
confusing things more, because the semantics of such a null commit
wouldn't be clear (e.g., git log would actually produce a little bit of
output).

Maybe it really is better to just force the caller to check the initial
commit condition. It's more work for them, but the semantics are simple
and unambiguous.

> Should documentation (man-pages) reflect your changes as well?

Yes, definitely. However, I'm not sure yet what the changes should _be_
(if any).

-Peff
