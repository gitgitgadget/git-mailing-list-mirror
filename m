From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] test-lib: tests can have multiple prerequisites
Date: Mon, 26 Apr 2010 21:25:11 -0400
Message-ID: <20100427012511.GA1844@coredump.intra.peff.net>
References: <20100421131255.GA2750@progeny.tock>
 <20100421133806.GA5595@progeny.tock>
 <20100426191703.GC10772@coredump.intra.peff.net>
 <7vpr1liwrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 03:25:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6ZYF-0000zt-Lk
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 03:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab0D0BZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 21:25:16 -0400
Received: from peff.net ([208.65.91.99]:60329 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab0D0BZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 21:25:14 -0400
Received: (qmail 20663 invoked by uid 107); 27 Apr 2010 01:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 21:25:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 21:25:11 -0400
Content-Disposition: inline
In-Reply-To: <7vpr1liwrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145868>

On Mon, Apr 26, 2010 at 05:06:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do wonder if it might be less error-prone to have:
> >
> >   test_expect_success PREREQ1 PREREQ2 'desc' 'test'
> >
> > instead of
> >
> >   test_expect_success 'PREREQ1 PREREQ2' 'desc' 'test'
> 
> Spot what is wrong with this:
> 
>         test_expect_success make sure we have the repo '
>                 test -d .git
>         '

To me it's easy to spot, but there is nothing wrong with it that the
shell will spot, so that is a downside. Whatever we go with, it would
perhaps be less error prone to set "NOPREREQ1" when we don't have
PREREQ1, and check that either $1 or NO$1 is set when checking
prerequisites. But that is probably just over-engineering. This is not
an error we have seen a lot of, and it is not that hard to spot with
code review.

-Peff
