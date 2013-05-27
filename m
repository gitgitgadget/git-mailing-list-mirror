From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 12:05:11 -0400
Message-ID: <20130527160511.GA9235@sigill.intra.peff.net>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
 <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com>
 <20130527150855.GA8250@sigill.intra.peff.net>
 <CAMdq69_RarEXDdR+xzvSb9YPCR2hE=0tM3o-mF3d=cgDMWSq8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: Xidorn Quan <quanxunzhen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 18:05:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgzvG-0003lI-3l
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab3E0QFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:05:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:44842 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341Ab3E0QFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:05:14 -0400
Received: (qmail 32016 invoked by uid 102); 27 May 2013 16:05:52 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 May 2013 11:05:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 May 2013 12:05:11 -0400
Content-Disposition: inline
In-Reply-To: <CAMdq69_RarEXDdR+xzvSb9YPCR2hE=0tM3o-mF3d=cgDMWSq8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225603>

On Mon, May 27, 2013 at 11:46:24PM +0800, Xidorn Quan wrote:

> > We may also eventually want IMAP for git-imap-send, but we have not yet
> > implemented credential-helper support there. We may also want http/socks
> > proxy authentication, but we also have not implemented the git side of
> > that yet. So I think both of those can wait for now.
> 
> Hope the helpers will be implemented soon. IMO, we can add IMAP and
> SOCKS for now since the protocol names are clear, while it is unclear
> what protocol name will be used for HTTP/HTTPS proxy. I guess that
> some may prefer using http/https as protocol name instead of something
> specific. What do you think?

Yes, I think git will need to munge the protocol to indicate to the
helper that it is a proxy (or alternatively, add a new key "proxy=1" or
something). So it would make sense to wait until the git side of the
code materializes so that the helpers knows what to expect.

There was some work done in this area last May, but there are a lot of
corner cases with knowing exactly what the proxy URL is (because in some
cases, curl pulls it from the environment without git's knowledge).
There was a patch series under consideration for libcurl that would let
us supply an "authentication callback" to curl that would be called when
credentials were needed. But I have not kept track of the state of that
patch and whether it ever got merged upstream into libcurl.

-Peff
