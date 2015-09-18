From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 57/67] receive-pack: simplify keep_arg computation
Date: Fri, 18 Sep 2015 14:49:55 -0400
Message-ID: <20150918184954.GA1589@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915161050.GE29753@sigill.intra.peff.net>
 <CAPig+cQbVhksrS1T3tep570Rxj9KxX3HmWAYY2SzqoAg35w-EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 20:50:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd0jT-0005mP-CN
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 20:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbbIRSt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 14:49:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:33288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752633AbbIRSt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 14:49:58 -0400
Received: (qmail 18276 invoked by uid 102); 18 Sep 2015 18:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 13:49:58 -0500
Received: (qmail 10503 invoked by uid 107); 18 Sep 2015 18:50:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 14:50:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Sep 2015 14:49:55 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQbVhksrS1T3tep570Rxj9KxX3HmWAYY2SzqoAg35w-EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278213>

On Fri, Sep 18, 2015 at 02:43:56PM -0400, Eric Sunshine wrote:

> On Tue, Sep 15, 2015 at 12:10 PM, Jeff King <peff@peff.net> wrote:
> > To generate "--keep=receive-pack $pid on $host", we write
> > progressively into a single buffer, which requires keeping
> > track of how much we've written so far. But since the result
> > is destined to go into our argv array, we can simply use
> > argv_array_pushf.
> >
> > Unfortunately we still have to have a static buffer for the
> 
> s/static/fixed-size/ maybe?

Thanks, will change.

The term "static buffer overflow" seems stuck in my head (and you can
find references via google), even though it does not make sense at all.
In C terms, a stack buffer is really an "auto", but I guess "auto buffer
overflow" does not have as nice a ring to it.

I agree that "fixed-size" is a lot less confusing, and corrected several
such cases before sent out the series. I guess I missed one (I'll grep
for others).

-Peff
