From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] replace: add a --raw mode for --edit
Date: Wed, 25 Jun 2014 06:24:54 -0400
Message-ID: <20140625102454.GA5130@sigill.intra.peff.net>
References: <20140624094217.GA14216@sigill.intra.peff.net>
 <20140624094631.GD14514@sigill.intra.peff.net>
 <CAPig+cRKxwJ64=qFAtefonutmZuURpTRZyjyjSaxcpuinRGL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:25:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzkO1-0003U5-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 12:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbaFYKY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 06:24:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:50799 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753703AbaFYKY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 06:24:58 -0400
Received: (qmail 26911 invoked by uid 102); 25 Jun 2014 10:24:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 05:24:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 06:24:54 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRKxwJ64=qFAtefonutmZuURpTRZyjyjSaxcpuinRGL4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252440>

On Tue, Jun 24, 2014 at 09:40:09PM -0400, Eric Sunshine wrote:

> On Tue, Jun 24, 2014 at 5:46 AM, Jeff King <peff@peff.net> wrote:
> > One of the purposes of "git replace --edit" is to help a
> > user repair objects which are malformed or corrupted.
> > Usually we pretty-print trees with "ls-tree", which is much
> > easier to work with than the raw binary data.  However, some
> > forms of corruption break the tree-walker, in which case our
> > pretty-printing fails, rendering "--edit" useless for the
> > user.
> >
> > This patch introduces a "--raw" option, which lets you edit
> > the binary data in these instances.
> 
> Is there a possibility that any of the other git-replace modes will
> grow a need for "raw"? If not, would it make sense to make this
> specific to "edit" as --edit=raw?

I doubt that any other modes will want it, as it is about the
pretty-printing step which is pretty specific to --edit. However, making
it "--edit=raw" also precludes adding other "modes" to --edit. I do
not have any in mind, but I do not see it as impossible.

Preclude is maybe a strong word. You could have "--edit=raw,flag1,flag2",
but then we are essentially reinventing an option parser inside --edit's
value. Not to mention that you cannot do "--no-raw", even without other
flags being added.

-Peff
