From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 00:59:30 -0500
Message-ID: <20120127055930.GE23633@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <CACsJy8DPcgJtw_xxqZ2pOtpV-w=PAVQ7uHs+CJ+ynECYdL50og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:59:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqeqZ-00072U-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab2A0F7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:59:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46335
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab2A0F7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:59:34 -0500
Received: (qmail 2391 invoked by uid 107); 27 Jan 2012 06:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 01:06:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 00:59:30 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DPcgJtw_xxqZ2pOtpV-w=PAVQ7uHs+CJ+ynECYdL50og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189198>

On Fri, Jan 27, 2012 at 11:01:00AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Thu, Jan 26, 2012 at 2:42 PM, Jeff King <peff@peff.net> wrote:
> > +Security Considerations
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Because git configuration may cause git to execute arbitrary shell
> > +commands, it is important to verify any configuration you receive over
> > +the network. In particular, it is not a good idea to point `include.ref`
> > +directly at a remote tracking branch like `origin/master:shared-config`.
> > +After a fetch, you have no way of inspecting the shared-config you have
> > +just received without running git (and thus respecting the downloaded
> > +config). Instead, you can create a local tag representing the last
> > +verified version of the config, and only update the tag after inspecting
> > +any new content.
> 
> It may be a good idea to tell users the ref include.ref points to has
> been updated at the end of git-fetch. Showing a diff is even better.

I really didn't want to have to let other parts of git know or care
about this mechanism. At least not for now. In the long run, I have no
problem with some porcelain growing up around the feature to make it
simpler to use. But I'd really rather focus on the bare-bones
functionality for now, see how people use it, and then find ways to
address deficiencies in their workflows once we have data.

-Peff
