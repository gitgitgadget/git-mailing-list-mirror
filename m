From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5540: skip under NO_CURL=NoThanks
Date: Wed, 6 May 2015 13:32:00 -0400
Message-ID: <20150506173200.GA7985@peff.net>
References: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:32:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3B5-0004DO-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbbEFRcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:32:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:54804 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751286AbbEFRcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:32:04 -0400
Received: (qmail 27259 invoked by uid 102); 6 May 2015 17:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 May 2015 12:32:03 -0500
Received: (qmail 18879 invoked by uid 107); 6 May 2015 17:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 May 2015 13:32:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 May 2015 13:32:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268471>

On Wed, May 06, 2015 at 09:58:06AM -0700, Junio C Hamano wrote:

> All the other tests in t5xxx series that require http support check
> NO_CURL and skip the test, but this one forgot to do so.

Makes sense, though I wonder if this check should just get pushed into
lib-httpd.sh. Surely we can't do anything useful with a web server we
started if we have no curl support? And this seems to support the case:

  $ comm -23 <(git grep -l lib-httpd.sh) <(git grep -l NO_CURL)
  lib-httpd.sh
  t5540-http-push-webdav.sh

After your patch, there is literally no script which includes
lib-httpd.sh but does not respect NO_CURL.

-Peff
