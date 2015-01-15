From: Jeff King <peff@peff.net>
Subject: Re: Unused #include statements
Date: Thu, 15 Jan 2015 01:33:07 -0500
Message-ID: <20150115063307.GA11028@peff.net>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
 <CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:33:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBdzY-0006Am-4P
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 07:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbbAOGdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 01:33:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:34797 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751094AbbAOGdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 01:33:10 -0500
Received: (qmail 19115 invoked by uid 102); 15 Jan 2015 06:33:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 00:33:10 -0600
Received: (qmail 10288 invoked by uid 107); 15 Jan 2015 06:33:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:33:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 01:33:07 -0500
Content-Disposition: inline
In-Reply-To: <CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262457>

On Thu, Jan 15, 2015 at 05:14:39AM +0100, Robert Schiele wrote:

> Thus doing those kind of brute-force removals generally makes the
> include structure in a project very fragile. The analysis itself you
> did is still useful to identify header files that can potentially be
> removed but removing them without further analysis I would consider
> problematic.

I would second that. Besides leading to a potentially fragile result,
this analysis was done only for a particular platform with a particular
set of config knobs.

One of our rules is that git-compat-util.h (or one of the well-known
headers which includes, cache.h or builtin.h) is included first in any
translation unit. This gives git-compat-util the cleanest environment
possible for making decisions, and lets macros it defines effect the
rest of the code consistently. I suspect on modern platforms like
Linux/glibc that it is not a huge deal to include git-compat-util a
little late, simply because it does not have all that much to do. But
on Solaris 8? Who knows.

-Peff
