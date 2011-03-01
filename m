From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Tue, 1 Mar 2011 17:23:51 -0500
Message-ID: <20110301222350.GA24215@sigill.intra.peff.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <1298665854.27129.25.camel@drew-northup.unet.maine.edu>
 <20110301220053.GB23945@sigill.intra.peff.net>
 <1299017913.14490.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:23:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXyr-0007nH-Tc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab1CAWXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:23:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36615 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1CAWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:23:40 -0500
Received: (qmail 11195 invoked by uid 111); 1 Mar 2011 22:23:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 22:23:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 17:23:51 -0500
Content-Disposition: inline
In-Reply-To: <1299017913.14490.10.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168267>

On Tue, Mar 01, 2011 at 05:18:33PM -0500, Drew Northup wrote:

> A notes message which contains "the usual template stuff" as means of
> describing a change to it, for starters...

But we strip that from the notes, unless you use --cleanup. But in that
case, you would have deleted the template cruft, since it pollutes your
message.

> There is likely good reason why the commit message already has an end
> mark, I suspect that also applies here.

It doesn't have an end mark. The "usual template stuff" just happens to
be at the end. But any line starting with "#" will be removed unless you
use --cleanup, whether you use --notes or no. Similarly, unadorned lines
after the "#" lines will be counted as part of the message.

> (Unless you count "---" between the commit message and the patch as
> "the usual template stuff"--which wasn't clear at this keyboard
> anyway.)

No, I meant the "#" lines. The "---" of format-patch isn't relevant
here, since we're just talking about commit messages inside the editor
during git-commit.

The really evil bit is "-v" which appends a giant diff with no real
indication that it isn't part of the commit message. We already get rid
of it with some heuristics (which I remember improving a while back).
I don't think my RFC patch handles it very well, but that is something I
will be looking at for the next revision.

-Peff
