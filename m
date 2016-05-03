From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: specify correct plural form in "commit
 diverge" message
Date: Tue, 3 May 2016 00:20:08 -0400
Message-ID: <20160503042008.GB30529@sigill.intra.peff.net>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
 <1462234350-30902-1-git-send-email-pclouds@gmail.com>
 <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
 <CACsJy8C0mFfHQ+GSdJyXLc=SArnxKfZCFV7LJkoqEPs0ekzDZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	ernesto.alfonsogonzalez@ge.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 06:20:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axRoo-0001E7-GD
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbcECEUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:20:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:60782 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750780AbcECEUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:20:11 -0400
Received: (qmail 9609 invoked by uid 102); 3 May 2016 04:20:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:20:11 -0400
Received: (qmail 22154 invoked by uid 107); 3 May 2016 04:20:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:20:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 00:20:08 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8C0mFfHQ+GSdJyXLc=SArnxKfZCFV7LJkoqEPs0ekzDZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293319>

On Tue, May 03, 2016 at 07:20:27AM +0700, Duy Nguyen wrote:

> > I think it needs to be max(ours, theirs)
> >
> >     "Your branch and '%s' have diverged,\n"
> >     "and have 1 and 1 different commit each, "
> >
> > so singular for that too, no?
> 
> I thought that would be "1 and 1 commits". English is complicated :-D
> I don't think Q_() is prepared to deal with this, other languages may
> have different interpretation of "x and y" too. But we can at least
> make the English version right.

Yes, it should still be "1 and 1 commits", I think. An actual human
would probably say something like "and each has %d commit(s)" when the
two values are the same, though.

Note that I do not think the singular case can ever trigger with your
new code. We know that both "ours" and "theirs" are non-zero to get to
this message, which means "ours + theirs" must be at least 2 (barring
negative commit counts, of course :) ).

So you could probably replace the Q_() with just a _().

-Peff
