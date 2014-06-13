From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] test: turn USR_BIN_TIME into a lazy prerequisite
Date: Fri, 13 Jun 2014 03:45:12 -0400
Message-ID: <20140613074512.GG7908@sigill.intra.peff.net>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
 <1402356175-7249-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvMBD-0007jT-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbaFMHpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:45:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:43252 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752879AbaFMHpO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:45:14 -0400
Received: (qmail 10227 invoked by uid 102); 13 Jun 2014 07:45:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:45:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:45:12 -0400
Content-Disposition: inline
In-Reply-To: <1402356175-7249-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251528>

On Mon, Jun 09, 2014 at 04:22:50PM -0700, Junio C Hamano wrote:

> Two test scripts (t3302 and t3419) had copy & paste code to set
> USR_BIN_TIME prerequisite.  Use the test_lazy_prereq helper to define
> them in the common t/test-lib.sh.

I have to wonder why we even have such a prereq in the first place.

Many tests which use EXPENSIVE are sensible; we used to do something bad
with large values, we fixed it, and want to be able to test the
correctness of the fix. The use in t0021 looks like that.

However, the tests in t3302 and t3419, which use both EXPENSIVE and
USR_BIN_TIME, seem like they are really interested in performance
testing. I think they probably should be in t/perf in the first place
(the reason they are not is presumably because they predate it).

Other than that, your series looks fine.

-Peff

PS s/expesive/expensive/ in the commit message of 7/7
