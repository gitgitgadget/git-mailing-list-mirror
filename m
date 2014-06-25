From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of
 xmalloc + sprintf
Date: Wed, 25 Jun 2014 13:22:38 -0400
Message-ID: <20140625172237.GA15294@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
 <20140619212800.GF28474@sigill.intra.peff.net>
 <CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com>
 <20140624205815.GA28724@sigill.intra.peff.net>
 <xmqqmwd0aotu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzquC-0004Xc-2q
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 19:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536AbaFYRWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 13:22:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:51005 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757311AbaFYRWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 13:22:40 -0400
Received: (qmail 16240 invoked by uid 102); 25 Jun 2014 17:22:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 12:22:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 13:22:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwd0aotu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252450>

On Wed, Jun 25, 2014 at 10:20:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a replacement patch that handles this (and just drops the ugly
> > mallocs as a side effect).
> >
> > -- >8 --
> > Subject: [PATCH] setup_git_env: copy getenv return value
> >
> > The return value of getenv is not guaranteed to survive
> > across further invocations of setenv or even getenv. When we
> > are assigning it to globals that last the lifetime of the
> > program, we should make our own copy.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Sigh. This mail unfortunately crossed with 64f25581 (Merge branch 'jk/xstrfmt'
> into next, 2014-06-23) with about 20 hours of lag.

Ah, sorry. I had checked yesterday that jk/xstrfmt hadn't been merged
yet, but I didn't check when responding to Duy.

> I'd make it relative like the attached on top of the series.  Note
> that I tweaked the args to git_pathdup() to avoid the "are you sure
> you want to give a variable format string to git_pathdup() which you
> said is like printf(3)?" warning from the compiler.

Both changes look good to me. Thanks for taking care of it.

-Peff
