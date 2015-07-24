From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with
 --quiet
Date: Thu, 23 Jul 2015 23:56:01 -0700
Message-ID: <20150724065601.GA2111@peff.net>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
 <xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
 <CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
 <20150723180846.GB18686@peff.net>
 <CAHGBnuMmOiYUtrOZzA9AV0qTV3_8BT5fgo=5gJ4FYYWV9dEKaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 08:56:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIWtx-00046P-St
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 08:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbbGXG4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 02:56:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:34388 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050AbbGXG4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 02:56:07 -0400
Received: (qmail 3805 invoked by uid 102); 24 Jul 2015 06:56:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 01:56:06 -0500
Received: (qmail 17758 invoked by uid 107); 24 Jul 2015 06:56:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 02:56:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2015 23:56:01 -0700
Content-Disposition: inline
In-Reply-To: <CAHGBnuMmOiYUtrOZzA9AV0qTV3_8BT5fgo=5gJ4FYYWV9dEKaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274555>

On Thu, Jul 23, 2015 at 10:02:27PM +0200, Sebastian Schuberth wrote:

> On Thu, Jul 23, 2015 at 8:08 PM, Jeff King <peff@peff.net> wrote:
> 
> > mode. Actually asking for a two-endpoint tree diff:
> >
> >   git diff-tree --quiet --ignore-space-change $commit^ $commit
> >
> > will do what you want.
> 
> Yes, I know, thanks. But I deliberately wanted to specify only a
> single commit as an optimization, hoping that it would be slightly
> faster than computing a commit range.

Ah, I see. It should not be any faster, as git has to internally find
the first-parent of $commit either way. The big thing you lose with the
above syntax is that you are specifying two endpoints, so you cannot do
anything clever with merge commits (e.g., if you gave "--cc").

-Peff
