From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/16] rev-list: add bitmap mode to speed up lists
Date: Wed, 26 Jun 2013 01:22:26 -0400
Message-ID: <20130626052226.GC26755@sigill.intra.peff.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-12-git-send-email-tanoku@gmail.com>
 <87mwqdlvsq.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 26 07:22:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UriBq-0000sw-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 07:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab3FZFW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 01:22:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:54437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729Ab3FZFW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 01:22:29 -0400
Received: (qmail 6136 invoked by uid 102); 26 Jun 2013 05:23:33 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Jun 2013 00:23:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 01:22:26 -0400
Content-Disposition: inline
In-Reply-To: <87mwqdlvsq.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229029>

On Tue, Jun 25, 2013 at 09:22:28AM -0700, Thomas Rast wrote:

> Vicent Marti <tanoku@gmail.com> writes:
> 
> > Calling `git rev-list --use-bitmaps [committish]` is the equivalent
> > of `git rev-list --objects`, but the rev list is performed based on
> > a bitmap result instead of using a manual counting objects phase.
> 
> Why would we ever want to not --use-bitmaps, once it actually works?
> I.e., shouldn't this be the default if pack.usebitmaps is set (or
> possibly even core.usebitmaps for these things)?

If you are using bitmaps, you cannot produce the same output as
"--objects"; the latter prints the path at which each object is found.
In the JGit bitmap format, we have no information at all; in Vicent's
"v2", we have only a hash of that pathname.

-Peff
