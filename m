From: Jeff King <peff@peff.net>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 6 May 2010 03:49:43 -0400
Message-ID: <20100506074943.GA24399@coredump.intra.peff.net>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
 <20100506064428.GA29360@progeny.tock>
 <4BE26A83.4010708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 06 09:49:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9vqE-0004kh-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 09:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0EFHtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 03:49:49 -0400
Received: from peff.net ([208.65.91.99]:38919 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915Ab0EFHts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 03:49:48 -0400
Received: (qmail 4618 invoked by uid 107); 6 May 2010 07:50:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 03:50:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 03:49:43 -0400
Content-Disposition: inline
In-Reply-To: <4BE26A83.4010708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146455>

On Thu, May 06, 2010 at 09:06:43AM +0200, Johannes Sixt wrote:

> Am 5/6/2010 8:44, schrieb Jonathan Nieder:
> >  test_when_finished () {
> > 	test_cleanup="$* && $test_cleanup"
> >  }
> 
> I'm wondering why you want this test_cleanup at all?
> 
> Is it so that subsequent tests can succeed even if an earlier test failed
> before its regular cleanup?
> 
> I don't see what this buys you. If a test case uncovers a regression, you
> got to fix it - who cares how many later tests fail or not? Once you are
> finished with your change, all tests will pass anyway (including their
> regular cleanups).

I have to agree. Yes, using test_when_finished can make _some_ tests
more robust, but there will still be many tests whose breakage will
break future tests. And many of those will never be fixed, because the
tests simply build on one another.

So I don't think we will ever "solve" this problem, which means testers
will continue to have to fix early failures before looking at later
ones, because they don't know if the later test is a false negative or
not. And as you point out, it is simply not that big a deal in the first
place.

-Peff
