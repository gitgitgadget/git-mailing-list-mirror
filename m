From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Tue, 3 Mar 2009 03:34:36 -0500
Message-ID: <20090303083436.GD3158@coredump.intra.peff.net>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQ6h-0001ZM-2U
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbZCCIek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbZCCIej
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:34:39 -0500
Received: from peff.net ([208.65.91.99]:33314 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbZCCIej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:34:39 -0500
Received: (qmail 13905 invoked by uid 107); 3 Mar 2009 08:34:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 03:34:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 03:34:36 -0500
Content-Disposition: inline
In-Reply-To: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112031>

On Tue, Mar 03, 2009 at 05:18:56PM +0900, Miles Bader wrote:

> I can use "git log --date=iso" to get YYYY-MM-DD format for dates, or
> "git log --date=local" to force the dates to use my local time zone, but
> if I use _both_ of these options together, it uses only the last one,
> and ignores any preceding --date (even those in this case, the two
> --date options affect orthogonal properties of dates).

Yuck. It sounds like --date=local is really the wrong way to have
implemented it. It really should be:

  git log --date=iso --local-dates

I don't think there is currently a way to do what you want, but it is
not too late to add an option (and keep --date=local as a synonym for
--date=default --local-dates for compatibility).

> Is there a way to get YYYY-MM-DD format dates, but in my local
> time-zone?

Short of using --date=raw and munging the output with perl, I don't
think so.

-Peff
