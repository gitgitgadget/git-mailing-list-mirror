From: Jeff King <peff@peff.net>
Subject: Re: git config --get-urlmatch does not set exit code 1 when no match
 is found
Date: Mon, 29 Feb 2016 06:53:55 -0500
Message-ID: <20160229115355.GA31273@sigill.intra.peff.net>
References: <CAMDzUtzNKAYSKYkt3WagkUrA2mKaoDu1rT6Nhf89pXSMg0wZwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 12:54:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaMOq-0001lg-HY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbcB2Lx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 06:53:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:51338 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754142AbcB2Lx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:53:58 -0500
Received: (qmail 15604 invoked by uid 102); 29 Feb 2016 11:53:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:53:58 -0500
Received: (qmail 25329 invoked by uid 107); 29 Feb 2016 11:54:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:54:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 06:53:55 -0500
Content-Disposition: inline
In-Reply-To: <CAMDzUtzNKAYSKYkt3WagkUrA2mKaoDu1rT6Nhf89pXSMg0wZwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287829>

On Sun, Feb 28, 2016 at 10:09:12AM +0530, Guilherme wrote:

> My current woes are with multi-valued configuration values. More
> specifically credential.helper
> 
> The documentation of git config says that when a value is not matched
> it should return 1.
> 
> To reproduce make sure that credential.helper is not set.
> 
> git config --get-urlmatch credential.helper http://somedomain:1234/
> echo %ERRORLEVEL%
> 0

This isn't really addressing your question, but I should warn you that
internally, the credential code _doesn't_ use the urlmatch
infrastructure. It predates the urlmatch code, and was never converted
(so basically only http.* uses urlmatch).  I think there are some corner
cases where the two behave differently.

I'm not sure what you're using this for, but you may get surprising
results.

-Peff
