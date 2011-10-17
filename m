From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] daemon: report permission denied error to clients
Date: Mon, 17 Oct 2011 15:51:54 -0400
Message-ID: <20111017195154.GA23242@sigill.intra.peff.net>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
 <20111017020912.GB18536@sigill.intra.peff.net>
 <20111017194821.GA29479@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:52:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtE8-0003QF-Vg
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab1JQTv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:51:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34023
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab1JQTv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:51:56 -0400
Received: (qmail 10431 invoked by uid 107); 17 Oct 2011 19:52:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Oct 2011 15:52:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2011 15:51:54 -0400
Content-Disposition: inline
In-Reply-To: <20111017194821.GA29479@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183814>

On Mon, Oct 17, 2011 at 09:48:21PM +0200, Clemens Buchacher wrote:

> > I like the intent. This actually does leak a little more information
> > than the existing --informative-errors, as before you couldn't tell the
> > difference between "not found" and "not exported".
> 
> I think you mean that before, you couldn't tell the difference
> between "not found" and "permission denied".

Ah, right. Sorry, I was thinking path_ok handled the export-ok flag, but
I already handled it in my patch to run_service. So it is leaking a
little more, but even less than I indicated. And at any rate, I think it
is consistent with what --informative-errors is meant to do, so it's a
good change.

> > The new calling conventions for this function seem a little weird.  I
> > would expect either "return negative, and set errno" for usual library
> > code, or possibly "return negative error value". But "return -1, or a
> > positive error code" seems unusual to me.
> 
> Yes indeed, will fix.

Thanks.

-Peff
