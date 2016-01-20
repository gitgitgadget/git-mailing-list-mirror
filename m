From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 20:34:36 -0500
Message-ID: <20160120013436.GA24541@sigill.intra.peff.net>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
 <20160119215928.GA6556@sigill.intra.peff.net>
 <20160119222802.GC6556@sigill.intra.peff.net>
 <20160120012253.GD16090@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:35:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhgC-0007K3-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934003AbcATBfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:35:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:56621 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934135AbcATBej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:34:39 -0500
Received: (qmail 26964 invoked by uid 102); 20 Jan 2016 01:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 20:34:38 -0500
Received: (qmail 28711 invoked by uid 107); 20 Jan 2016 01:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 20:34:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 20:34:36 -0500
Content-Disposition: inline
In-Reply-To: <20160120012253.GD16090@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284406>

On Tue, Jan 19, 2016 at 05:22:53PM -0800, Jonathan Nieder wrote:

> > I'm actually a little iffy on it because it switches to "diff-tree" from
> > a raw-sha1 comparison. For a well-formed repo, that shouldn't matter.
> > But what if you had a commit that was replacing a malformed tree object,
> > but not otherwise changing the diff?  We might drop it as "empty", even
> > though you'd prefer to keep it.
> 
> Mph.  We could get the best of both worlds by introducing a "git
> rev-parse --compare <a> <b>" that compares object ids.  Actually...
> 
> How about something like this?

Thanks. I had in my head that we could do something like that, but
hadn't quite worked it out. I think what you wrote works.

If you want to wrap it up into a patch, I'd be OK with it, but note that
it still falls afoul of changing $tree in a user-visible way (so you
should note that in the commit message).

-Peff
