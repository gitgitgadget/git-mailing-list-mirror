From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5813: avoid creating urls that break on cygwin
Date: Mon, 9 Nov 2015 10:45:01 -0500
Message-ID: <20151109154501.GA27224@sigill.intra.peff.net>
References: <20151108051059.GB19191@sigill.intra.peff.net>
 <20151108095400.GA9448@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, adam@dinwoodie.org,
	ramsay@ramsayjones.plus.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 16:45:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvod4-0001OM-WA
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 16:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbbKIPpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 10:45:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:54941 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751237AbbKIPpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 10:45:05 -0500
Received: (qmail 2276 invoked by uid 102); 9 Nov 2015 15:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 09:45:04 -0600
Received: (qmail 16271 invoked by uid 107); 9 Nov 2015 15:45:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 10:45:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 10:45:01 -0500
Content-Disposition: inline
In-Reply-To: <20151108095400.GA9448@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281052>

On Sun, Nov 08, 2015 at 10:54:04AM +0100, Dennis Kaarsemaker wrote:

> The fake ssh used by this test simply strips ssh://host from the url,
> leaving paths behind that start with //, which cygwin interprets as UNC
> paths, causing the test to fail.

I found the first sentence a little misleading. It is git itself that
strips the URL, isn't it? The problem is that we are feeding a URL with
a bogus path, which the fake ssh then tries to access (but in a way that
happens to work on Unix systems).

-Peff
