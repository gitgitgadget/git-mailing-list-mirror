From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: disconnect transport after fetching
Date: Wed, 2 Sep 2009 03:26:38 -0400
Message-ID: <20090902072638.GC31528@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org>
 <20090902063647.GA29559@coredump.intra.peff.net>
 <fabb9a1e0909020009r3ee28b1fo3cba095abafec9d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MikEz-0005VS-Kk
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 09:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbZIBH0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 03:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbZIBH0j
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 03:26:39 -0400
Received: from peff.net ([208.65.91.99]:54872 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbZIBH0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 03:26:39 -0400
Received: (qmail 5467 invoked by uid 107); 2 Sep 2009 07:26:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 03:26:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 03:26:38 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909020009r3ee28b1fo3cba095abafec9d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127590>

On Wed, Sep 02, 2009 at 09:09:19AM +0200, Sverre Rabbelier wrote:

> On Wed, Sep 2, 2009 at 08:36, Jeff King<peff@peff.net> wrote:
> > As you can see from the commit message, I did a little extra hunting to
> > make sure we are not going to impact any other code paths, and I am
> > pretty sure we are fine.
> 
> Thank you for fixing my mistake :).

You're welcome, though I am not sure it is your mistake. Arguably this
is something we should have been doing all along. The point of
abstracting transports was that we didn't need to know their details at
the outer layer, but in this case we were relying on the fact that no
transports (until empty-clone-over-git) needed an explicit
transport_disconnect to cleanly hang up on the other end.

So think of it as you exposing a long-standing bug. ;)

-Peff
