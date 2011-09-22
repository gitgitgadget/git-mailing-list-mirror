From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 17:04:21 -0400
Message-ID: <20110922210421.GB8563@sigill.intra.peff.net>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
 <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 23:04:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6qRY-0000NJ-Mi
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 23:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab1IVVEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 17:04:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40993
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab1IVVEX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 17:04:23 -0400
Received: (qmail 11149 invoked by uid 107); 22 Sep 2011 21:09:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Sep 2011 17:09:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2011 17:04:21 -0400
Content-Disposition: inline
In-Reply-To: <20110922205856.GA8563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181919>

On Thu, Sep 22, 2011 at 04:58:56PM -0400, Jeff King wrote:

> That makes some sense to me. As Junio pointed out, there is a catch with
> "diff -R". In that case, I would still think you would use the "second"
> commit, even though we're reversing the diff. So:
> 
>   git diff A B
> 
> would not be exactly equivalent to:
> 
>   git diff -R B A
> 
> in that the second would use attributes from "A" instead of "B".

I misread Junio's comment a bit. Re-reading it, this is exactly the
inconsistency he complained about. However, I consider it somewhat of a
feature. We currently have two ways to express the same thing, and you
arrive at one or the other based on the way you are thinking of the
problem. But we can use that to disambiguate between the two cases; one
is about going from A to B, and one is about inverting the operation of
going from B to A. Right now they're equivalent, but they don't have to
be.

If you read the rest of my message, you will see that I think picking
"first" or "second" arbitrarily like this might be barking up the wrong
tree.  But I just wanted to clarify that point.

-Peff
