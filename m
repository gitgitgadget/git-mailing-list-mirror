From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the
 temporary buffer
Date: Wed, 18 Dec 2013 15:11:01 -0500
Message-ID: <20131218201101.GA10507@sigill.intra.peff.net>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
 <xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
 <20131217232231.GA14807@sigill.intra.peff.net>
 <xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
 <20131218200043.GA10244@sigill.intra.peff.net>
 <xmqqwqj1hqjd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNSX-0002Ze-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab3LRULF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:11:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:46864 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872Ab3LRULE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:11:04 -0500
Received: (qmail 3958 invoked by uid 102); 18 Dec 2013 20:11:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 14:11:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 15:11:01 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwqj1hqjd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239479>

On Wed, Dec 18, 2013 at 12:07:02PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > +			prune_object(path->buf, sha1);
> >> > +			path->len = baselen;
> >> 
> >> This is minor, but I prefer using strbuf_setlen() for this.
> >
> > Good catch. I do not think it is minor at all; my version is buggy.
> > After the loop ends, path->len does not match the NUL in path->buf. That
> > is OK if the next caller is strbuf-aware, but if it were to pass
> > path->buf straight to a system call, that would be rather...confusing.
> 
> Hmph, rmdir(path->buf) at the end of prune_dir() may have that exact
> issue.
> 
> Will squash in the following.

Thanks. Are you picking this up with a commit message, or did you want
me to re-send with the usual message/signoff?

-Peff
