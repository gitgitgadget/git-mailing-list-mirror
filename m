From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] tag: support --sort=<spec>
Date: Wed, 26 Feb 2014 06:08:04 -0500
Message-ID: <20140226110803.GG25711@sigill.intra.peff.net>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
 <1393330935-22229-1-git-send-email-pclouds@gmail.com>
 <20140226090511.GA32537@sigill.intra.peff.net>
 <CACsJy8CW9p-PDJC9zXBwXrxOk9GhBFk1nVtG1Xn76g3FN+KgaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcLZ-0004W1-Sy
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaBZLIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:08:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:57284 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751635AbaBZLIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:08:09 -0500
Received: (qmail 10637 invoked by uid 102); 26 Feb 2014 11:08:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 05:08:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 06:08:04 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CW9p-PDJC9zXBwXrxOk9GhBFk1nVtG1Xn76g3FN+KgaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242718>

On Wed, Feb 26, 2014 at 06:03:40PM +0700, Duy Nguyen wrote:

> > Cool. I think doing this makes the most sense, as we do not have to
> > worry about build-time config (and I do not see any particular reason
> > why we would want to use the system strverscmp on glibc systems).
> 
> Another reason I want to stay away from glibc is I want to fix the
> algorithm to sort YY-preXX and YY-rcXX before YY. There could be
> reasons that glibc might reject such a change even if it makes sense
> in our context. Even if we make it to newer glibc and fix compat
> version, people on older glibc will not receive the fix while people
> on compat do. Not so good.

Yeah, the handling of -rc has bugged me, too (in my personal alias, I
just grep out the -rc before feeding the list to "sort -V" :) ).

I'd worry slightly, though, that there are other schemes where that
behaves poorly. Should we optimize for git's version numbering, or for
what most other projects want? There could even be room for two types of
version-compare. But before thinking about that, I'd want to know why
glibc behaves as it does.

-Peff
