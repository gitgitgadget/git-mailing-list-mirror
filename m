From: Jeff King <peff@peff.net>
Subject: Re: Unused #include statements
Date: Thu, 15 Jan 2015 17:38:37 -0500
Message-ID: <20150115223836.GC19021@peff.net>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
 <CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
 <20150115063307.GA11028@peff.net>
 <xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Schiele <rschiele@gmail.com>,
	Zoltan Klinger <zoltan.klinger@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:38:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBt3s-0008JF-MR
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbbAOWik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:38:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:35202 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752264AbbAOWij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:38:39 -0500
Received: (qmail 5921 invoked by uid 102); 15 Jan 2015 22:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 16:38:39 -0600
Received: (qmail 17182 invoked by uid 107); 15 Jan 2015 22:39:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 17:39:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 17:38:37 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262516>

On Thu, Jan 15, 2015 at 10:50:45AM -0800, Junio C Hamano wrote:

> So the rule might be:
> 
>  - The first #include in C files, except in platform specific
>    compat/ implementations, must be either git-compat-util.h,
>    cache.h or builtin.h.
> 
>  - A C file must directly include the header files that declare the
>    functions and the types it uses, except for the functions and
>    types that are made available to it by including one of the
>    header files it must include by the previous rule.

Yeah, that makes sense (and is what I took away from the existing rule
in CodingGuidelines, but I agree what is there is not very rigorous).

> Optionally, 
> 
>  - A C file must include only one of "git-compat-util.h", "cache.h"
>    or "builtin.h"; e.g. if you include "builtin.h", do not include
>    the other two, but it can consider what is availble in "cache.h"
>    available to it.
> 
> Thoughts?  I am not looking forward to a torrent of patches whose
> sole purpose is to make the existing C files conform to any such
> rule, though.  Clean-up patches that trickle in at a low rate is
> tolerable, but a torrent is too distracting.

I don't think the "optionally" one above is that necessary. Not because
I don't agree with it, but because I do not know that we want to get
into the business of laying out every minute detail and implication.
The CodingGuidelines document is meant to be guidelines, and I do not
want to see arguments like "well, the guidelines do not explicitly
_disallow_ this, so you must accept it or add something to the
guideline". That is a waste of everybody's time.

A general philosophy + good taste (from the submitter and the
maintainer) should ideally be enough. And hopefully would stop a torrent
of "but this file doesn't conform to the letter of CodingGuidelines!".
Maybe it does not, but if there is no tangible benefit besides blindly
following some rules, it is not worth the precious time of developers.

Which isn't to say we shouldn't clarify the document when need be. But I
think what I quoted at the top already is probably a good improvement
over what is there.

-Peff
