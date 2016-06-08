From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 8 Jun 2016 12:19:58 -0400
Message-ID: <20160608161958.GA30876@sigill.intra.peff.net>
References: <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
 <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
 <20160607202351.GA5726@sigill.intra.peff.net>
 <CACsJy8CtsFFJPssDDBuL8TLoxi1f=734mjAjCUOr8Y63aD3xUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAgDA-00048N-Md
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 18:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbcFHQUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 12:20:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:51261 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756915AbcFHQUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 12:20:02 -0400
Received: (qmail 24570 invoked by uid 102); 8 Jun 2016 16:20:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 12:20:00 -0400
Received: (qmail 8534 invoked by uid 107); 8 Jun 2016 16:20:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 12:20:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2016 12:19:58 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CtsFFJPssDDBuL8TLoxi1f=734mjAjCUOr8Y63aD3xUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296808>

On Wed, Jun 08, 2016 at 05:44:06PM +0700, Duy Nguyen wrote:

> On Wed, Jun 8, 2016 at 3:23 AM, Jeff King <peff@peff.net> wrote:
> > Because this "external odb" essentially acts as a git alternate, we
> > would hit it only when we couldn't find an object through regular means.
> > Git would then make the object available in the usual on-disk format
> > (probably as a loose object).
> 
> This means git-gc (and all things that do rev-list --objects --all)
> would download at least all trees and commits? Or will we have special
> treatment for those commands?

Yes. To me, this was always about punting large blobs from the clones.
Basically the way git-lfs and other tools work, but without munging your
history permanently.

I don't know if Christian had other cases in mind (like the many-files
case, which I think is better served by something like narrow clones).

-Peff
