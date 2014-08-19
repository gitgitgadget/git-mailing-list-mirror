From: Jeff King <peff@peff.net>
Subject: Re: Issuing warning when hook does not have execution permission
Date: Tue, 19 Aug 2014 04:00:02 -0400
Message-ID: <20140819080002.GB7712@peff.net>
References: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Babak M <babak@melon.com.au>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:00:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJeKy-0001FL-7T
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 10:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbaHSIAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 04:00:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:54731 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbaHSIAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 04:00:05 -0400
Received: (qmail 20740 invoked by uid 102); 19 Aug 2014 08:00:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 03:00:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 04:00:02 -0400
Content-Disposition: inline
In-Reply-To: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255447>

On Tue, Aug 19, 2014 at 04:05:21PM +1000, Babak M wrote:

> I saw that if a hook file is present in .git/hooks and it does not
> have execution permissions it is silently ignored.
> 
> I thought it might be worthwhile issuing a warning such as "Warning:
> pre-commit hook exists but it cannot be executed due to insufficient
> permissions".
> 
> Not sure if this has been discussed before. I searched the archive but
> didn't see anything.
> 
> Thoughts, suggestions? Is there anything like that already?

Once upon a time we shipped sample hooks with their execute bits turned
off, and such a warning would have been very bad.

These days we give them a ".sample" extension (because Windows installs
had trouble with the execute bit :) ), so I think it should be OK in
theory. Installing a new version of git on top of an old one with "make
install" does not clean up old files. So somebody who has continuously
upgraded their git via "make install" to the same directory would have
the old-style sample files. Under your proposal, they would get a lot of
warnings.

However, that change came in v1.6.0, just over 6 years ago. We can
probably discount that (and if it does happen, maybe it is time for that
someone to clean up the other leftover cruft from past git installs).

-Peff
