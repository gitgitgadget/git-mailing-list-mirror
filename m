From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: try internal cache before reading object db
Date: Fri, 6 Jan 2012 17:33:24 -0500
Message-ID: <20120106223324.GB13106@sigill.intra.peff.net>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191654.GA11022@sigill.intra.peff.net>
 <7v8vlkjzcj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:33:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjILs-0006cA-7m
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 23:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222Ab2AFWd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 17:33:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59710
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab2AFWd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 17:33:26 -0500
Received: (qmail 9486 invoked by uid 107); 6 Jan 2012 22:40:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 17:40:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 17:33:24 -0500
Content-Disposition: inline
In-Reply-To: <7v8vlkjzcj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188051>

On Fri, Jan 06, 2012 at 01:27:40PM -0800, Junio C Hamano wrote:

> > I don't know if it is really that worth it on top of the parse_object
> > optimization. It's almost negligible for the normal case...
> > ... OTOH, if you had some totally insane ref
> > structure, like 120K _unique_ refs (which would probably imply that
> > you're making one ref per commit or something silly like that. But hey,
> > people have suggested it in the past), then it could be a big
> > improvement.
> 
> Even though it is a bit scary kind of loosening of sanity checks that I
> hesitate to take at this late in the cycle, I think it makes sense. Let's
> queue them on 'pu' and aim for the next cycle.

Did you want to leave the parse_object optimization until next cycle,
too? It's not loosening checks, but it's such a core piece of code that
it makes me nervous somebody somewhere is abusing "struct object" in a
way that will break it.

-Peff
