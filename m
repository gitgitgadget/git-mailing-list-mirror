From: Jeff King <peff@peff.net>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 5 May 2011 01:46:11 -0400
Message-ID: <20110505054611.GA29033@sigill.intra.peff.net>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 <7voc3hbtgu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 07:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHrOE-0006Ae-Gk
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 07:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab1EEFqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 01:46:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49609
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1EEFqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 01:46:13 -0400
Received: (qmail 27370 invoked by uid 107); 5 May 2011 05:48:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 01:48:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 01:46:11 -0400
Content-Disposition: inline
In-Reply-To: <7voc3hbtgu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172798>

On Wed, May 04, 2011 at 10:35:13PM -0700, Junio C Hamano wrote:

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
> > I haven't had a lot of time to track down it down until today, but I've
> > been getting failures in t5541-http-push-.sh.  Several tests fail with
> > the error "fatal: write error: Bad file descriptor".
> 
> A wild guess.
> 
> Does it help if you cherry-picked 1e41827 (http: clear POSTFIELDS when
> initializing a slot, 2011-04-26) on top of the faulty commit?

I think that 09c9957 (send-pack: avoid deadlock when pack-object dies
early, 2011-04-25) is totally broken.

Looking back at my tests, I only tested the case where pack-objects
fails. And it seems we totally broke the case where the push is supposed
to succeed.

Still investigating...

-Peff
