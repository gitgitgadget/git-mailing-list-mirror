From: Jeff King <peff@peff.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 14:28:51 -0500
Message-ID: <20110310192851.GB19257@sigill.intra.peff.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
 <20110310184653.GA17832@sigill.intra.peff.net>
 <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 20:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxlXd-0001xo-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab1CJT2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 14:28:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39847
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab1CJT2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 14:28:52 -0500
Received: (qmail 30152 invoked by uid 107); 10 Mar 2011 19:29:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 14:29:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 14:28:51 -0500
Content-Disposition: inline
In-Reply-To: <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168846>

On Thu, Mar 10, 2011 at 11:21:47AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One more wishlist item for this. I use "add -p" for almost all of my
> > adds these days, because I like the final review check. So after a
> > conflicted merge, I find myself doing "add -p" to stage my resolution.
> > The current behavior is that it shows the --cc diff and exits. It would
> > be cool to handle staging the resolution, which would involve converting
> > the combined diff into something that can be applied.
> 
> I think the end-result would be a nice feature. I suspect that it would
> not involve conversion from --cc, but more like using the difference
> between the HEAD and the working tree, generated as if there is no
> multi-stage index.

The trouble is that I would like to see the combined diff, then say "OK"
and have it apply the result to the index. But because we work on a
per-hunk basis, you need to match the combined diff hunks to the regular
diff hunks, taking into account that hunks could be split.  Which maybe
is straightforward, but I haven't convinced myself yet that there are no
corner cases where they don't line up.

I guess one could argue that I should be using mergetool, and making a
mergetool helper that is more like "add -p" (show hunks, say "choose
left, choose right, choose none"). But I generally fix up the conflict
using an editor and just want "add -p" as a final check.

I'll probably look into it more eventually, but it's not a high priority
at this point.

-Peff
