From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 13:52:48 -0400
Message-ID: <20120726175248.GA15928@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu>
 <20120720154403.GB2862@sigill.intra.peff.net>
 <5009892E.9010808@kdbg.org>
 <20120720170913.GA14057@sigill.intra.peff.net>
 <7vehny8lgm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Alexey Muranov <alexey.muranov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuSF6-00006b-U8
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab2GZRwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:52:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37430 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab2GZRwu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:52:50 -0400
Received: (qmail 11618 invoked by uid 107); 26 Jul 2012 17:52:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 13:52:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 13:52:48 -0400
Content-Disposition: inline
In-Reply-To: <7vehny8lgm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202286>

On Thu, Jul 26, 2012 at 10:46:01AM -0700, Junio C Hamano wrote:

> > Bleh. It seems that we did too good a job in coming up with a list of
> > disallowed ref characters; they really are things you don't want in your
> > filenames at all. :)
> 
> Why do no need to even worry about ~ vs : vs whatever in the first
> place?
> 
> With a flag-day per repository "core.repositoryformatversion = 1",
> you do not have to worry about mixture of old-style refs and new
> ones, so refs/heads/next-d/log could be a topic branch 'next/log'
> that is based on an integration branch 'next' branch that physically
> resides at refs/heads/next-f or an entry refs/heads/next in packed
> refs.  Only the API functions in refs.c should care, no?

I think the point was that Michael wanted to select a standard that
could be used for graveyard reflogs _now_, but which would eventually
match the format we use for active refs. And that requires a character
that is not valid in a refname.

Given that the change of format for actives refs would require a flag
day, keeping the graveyard scheme mixable with the current ref rules may
not be worth caring about, though.

-Peff
