From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 07:57:26 -0400
Message-ID: <20160519115725.GB3050@sigill.intra.peff.net>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
 <20160518180800.GC5796@sigill.intra.peff.net>
 <721240639.4127450.1463652631815.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Queru <antoine.queru@grenoble-inp.fr>
To: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 19 13:57:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Ma8-0002YR-OI
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 13:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbcESL5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 07:57:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:41739 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbcESL5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 07:57:32 -0400
Received: (qmail 11418 invoked by uid 102); 19 May 2016 11:57:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 May 2016 07:57:31 -0400
Received: (qmail 31449 invoked by uid 107); 19 May 2016 11:57:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 May 2016 07:57:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2016 07:57:26 -0400
Content-Disposition: inline
In-Reply-To: <721240639.4127450.1463652631815.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295056>

On Thu, May 19, 2016 at 12:10:31PM +0200, Antoine Queru wrote:

> > I'm not sure whether it is worth hiding the first two options. We
> > typically hide "internal" options like this for user-facing programs, so
> > as not to clutter the "-h" output. But upload-pack isn't a user-facing
> > program. Anybody who is calling it directly with "-h" may be interested
> > in even its more esoteric options.
> 
> In fact, to do this, I looked at builtin/receive-pack.c, where the parser API
> was already implemented, and these first two options were hidden. There were 
> also no description for any options, so I thought it was not needed. Maybe we 
> could update this file too ?

Yeah, I don't think it's that bad to hide them, and perhaps consistency
with receive-pack is better. AFAICT, descriptions for hidden options are
pointless; they are never shown (in fact, it seems like OPT_HIDDEN_BOOL
probably shouldn't even take such an option?).

But the non-hidden options _do_ need non-NULL descriptions.

-Peff
