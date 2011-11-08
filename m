From: Jeff King <peff@peff.net>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Tue, 8 Nov 2011 00:46:43 -0500
Message-ID: <20111108054643.GC29643@sigill.intra.peff.net>
References: <4EB85768.1060508@avtalion.name>
 <20111107225508.GB28188@sigill.intra.peff.net>
 <7v4nyf1opf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ori Avtalion <ori@avtalion.name>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeWJ-0002xa-Kp
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab1KHFqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:46:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36079
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab1KHFqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:46:45 -0500
Received: (qmail 1143 invoked by uid 107); 8 Nov 2011 05:46:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 00:46:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 00:46:43 -0500
Content-Disposition: inline
In-Reply-To: <7v4nyf1opf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185073>

On Mon, Nov 07, 2011 at 03:45:48PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In the general case, you can't represent all failed hunks with conflict
> > markers, can you?
> 
> Conflict markers come from the use of a 3-way merge, and if you were to do
> a 3-way merge, by definition, you would need some way to tell where the
> preimage of the patch and the target tree you are attempting to apply the
> patch forked from. That's done by fall-back-3way in "am -3".
> 
> You _could_ lift that logic out of "am -3", but I do not think it is worth
> the effort to do so (IOW, I do not see a reason to avoid "am -3").

I think it would purely be "I have a patch produced by git diff, not by
git format-patch". If you want to use "am -3", you would have to dress
up your patch with mail headers.

In practice, this doesn't come up much for me. I think I was using "git
diff >patch" as a poor-man's stash (and I did just stick some fake
headers in, and "git reset HEAD^" afterwards). But maybe other workflows
deal with this more.

But I think there are two questions:

  1. Should am's 3-way fallback be made more easily available to users
     of regular "apply"?

  2. Short of doing a 3-way merge, are there better ways to represent
     failed hunks in the patch target itself, rather than saving ".rej"
     files?

I'm actually not sure which one Ori was asking about.

-Peff
