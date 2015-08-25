From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 15:03:30 -0400
Message-ID: <20150825190329.GA11271@sigill.intra.peff.net>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
 <1440523706-23041-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJVX-000579-GF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 21:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbbHYTDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 15:03:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:49952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751042AbbHYTDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 15:03:32 -0400
Received: (qmail 15923 invoked by uid 102); 25 Aug 2015 19:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 14:03:32 -0500
Received: (qmail 6667 invoked by uid 107); 25 Aug 2015 19:03:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 15:03:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 15:03:30 -0400
Content-Disposition: inline
In-Reply-To: <1440523706-23041-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276561>

On Tue, Aug 25, 2015 at 10:28:25AM -0700, Stefan Beller wrote:

> By treating each object as its own task the workflow is easier to follow
> as the function used in the worker threads doesn't need any control logic
> any more.

Have you tried running t/perf/p5302 on this?

I seem to get a pretty consistent 2%-ish slowdown, both against git.git
and linux.git. That's not a lot, but I'm wondering if there is some
low-hanging fruit in the locking, or in the pattern of work being
dispatched. Or it may just be noise, but it seems fairly consistent.

-Peff
