From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 17:06:26 -0400
Message-ID: <20130917210626.GE16860@sigill.intra.peff.net>
References: <20130917164226.GB20672@redhat.com>
 <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
 <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130917210325.GA22511@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 23:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM2Tm-0007w1-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 23:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab3IQVGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 17:06:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:47942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569Ab3IQVGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 17:06:33 -0400
Received: (qmail 24085 invoked by uid 102); 17 Sep 2013 21:06:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 16:06:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 17:06:26 -0400
Content-Disposition: inline
In-Reply-To: <20130917210325.GA22511@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234930>

On Wed, Sep 18, 2013 at 12:03:25AM +0300, Michael S. Tsirkin wrote:

> > It may be esoteric enough not to worry about, though. By far the most
> > common use of patch-ids is going to be in a single "rev-list
> > --cherry-pick" situation where you are trying to omit commits during
> > a rebase.
> > 
> > I am mostly thinking of the problems we had with the "kup" tool, which
> > expected stability across diffs that would be signed by both kernel.org.
> > But as far as I know, they do not use patch-id.
> 
> We can always do a compatibility option. --order-sensitive ?
> --ignore-order ?

That may make sense as an escape hatch in case somebody has a use we
didn't foresee.

If it is just about "consistent order" versus "whatever is in the diff",
I do not know that we need to worry as much; only the minority using
orderfile is affected, and they have _always_ been affected. IOW, we are
fixing a bug, and they should be happier.

But if it is changing the output entirely in all cases (e.g., the
1s-complement sum), I think you would want to have a "classic" mode that
tries to be compatible with the old style (with the caveat that of
course it depends on patch ordering).

-Peff
