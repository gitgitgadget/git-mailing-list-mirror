From: Jeff King <peff@peff.net>
Subject: Re: Make "git status" show if on tag
Date: Wed, 9 Oct 2013 15:01:39 -0400
Message-ID: <20131009190139.GB2823@sigill.intra.peff.net>
References: <6d645eb.6b85c8d7.52559ec7.8a3b0@o2.pl>
 <387b8c28.601abe13.5255a661.c2c2f@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: bpuzon <bpuzon@o2.pl>
X-From: git-owner@vger.kernel.org Wed Oct 09 21:01:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTz10-0001xJ-ML
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 21:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab3JITBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 15:01:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:46441 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144Ab3JITBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 15:01:41 -0400
Received: (qmail 3745 invoked by uid 102); 9 Oct 2013 19:01:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 14:01:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 15:01:39 -0400
Content-Disposition: inline
In-Reply-To: <387b8c28.601abe13.5255a661.c2c2f@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235835>

On Wed, Oct 09, 2013 at 08:54:25PM +0200, bpuzon wrote:

> I was wondering if a patch that adds the tag information (something
> like what "git log --decorate" produces) to the "git status" would be
> welcome?

Do you mean when you are on a branch that also happens to point at the
same commit found at a tag? Or do you mean when you have detached your
HEAD at a tag (e.g., by doing "git checkout v1.0").

In the latter case, git v1.8.3 and later will print the tag name
already.

If the former, I don't have a strong opinion (it is not something I
would find useful, but I can see how others might). If it were not
intrusive, like:

  # On branch master (v1.0)

I don't think anybody would complain. It does involve enumerating all of
the refs to calculate it, which might be noticeable. OTOH, "status" is
not exactly a lightweight operation already, since it has to refresh the
whole index.

You might also consider just showing "git describe" output, which will
show a tag if you are on it, but also show your distance to the nearest
tag otherwise.  It is more expensive to calculate, though.

-Peff
