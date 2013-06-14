From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] recover from "failed to apply delta"
Date: Fri, 14 Jun 2013 17:49:44 -0400
Message-ID: <20130614214943.GA29138@sigill.intra.peff.net>
References: <20130613232608.GA9844@sigill.intra.peff.net>
 <alpine.LFD.2.03.1306132004090.18597@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnbsX-0006hj-T7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab3FNVtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:49:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:59394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000Ab3FNVtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:49:49 -0400
Received: (qmail 22569 invoked by uid 102); 14 Jun 2013 21:50:43 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Jun 2013 16:50:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2013 17:49:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1306132004090.18597@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227919>

On Thu, Jun 13, 2013 at 08:05:21PM -0400, Nicolas Pitre wrote:

> > We already handle the case where we were not able to read
> > the delta from disk. However, when we find that the delta we
> > read does not apply, we simply die.  This case is harder to
> > trigger, as corruption in the delta data itself would
> > trigger a crc error from zlib.  However, a corruption that
> > pointed us at the wrong delta base might cause it.
>
> That makes sense.
> 
> Could you produce a test case to go along with this change?

Yes. I was a little worried I would have trouble doing it without
relying on a lot of pack internals, but the infrastructure you set up in
t5303 makes it relatively easy (and we do not have to make any
assumptions that t5303 does not already make).

Here is a re-roll; the first patch is a small cleanup in t5303 that is
required for the new tests to work.

  [1/2]: t5303: drop "count=1" from corruption dd
  [2/2]: unpack_entry: do not die when we fail to apply a delta

-Peff
