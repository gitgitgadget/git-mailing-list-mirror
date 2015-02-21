From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Sat, 21 Feb 2015 02:35:09 -0500
Message-ID: <20150221073509.GA32548@peff.net>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
 <1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
 <20150221062754.GC29665@peff.net>
 <xmqqzj87wxck.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Matt Whiteley <mattwhiteley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 08:35:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP4ay-0002zR-HZ
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 08:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbbBUHfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 02:35:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:51934 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbbBUHfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 02:35:12 -0500
Received: (qmail 11768 invoked by uid 102); 21 Feb 2015 07:35:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Feb 2015 01:35:12 -0600
Received: (qmail 11239 invoked by uid 107); 21 Feb 2015 07:35:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Feb 2015 02:35:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Feb 2015 02:35:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzj87wxck.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264214>

On Fri, Feb 20, 2015 at 11:13:47PM -0800, Junio C Hamano wrote:

> >>  	OPT_BOOL(0, "dissociate", &option_dissociate,
> >>  		 N_("use --reference only while cloning")),
> >> +	OPT_BOOL(0, "disassociate", &option_dissociate,
> >> +		 N_("use --reference only while cloning")),
> >
> > Should this second one be marked as OPT_HIDDEN? I do not think we need
> > to show both in "git clone --help".
> 
> For that matter, I am not sure why we want to add this synonym in
> the first place.
> 
> http://www.merriam-webster.com/dictionary/dissociate
> 
>     : to end your relationship with or connection to someone or
>     something : to separate (yourself) from someone or something
> 
> which is exactly what I wanted the option to achieve.

That is also the definition of disassociate. :) They are both equally
correct here, and some people tend to use one over the other:

  http://grammarist.com/usage/dissociate-disassociate/

So I don't think the spirit of the patch is wrong, in that sense. I am
open to the argument that we do not want to get in the habit of
providing every possible synonym, as it would clutter the interface.
This case is a bit more extreme; given the similarity of the two words,
it is easy to use the wrong one. But I do not personally care much
either way.

As a side note, while writing out an explanation of "--reference
--dissociate" recently, Michael (cc'd) and I noticed that it seems quite
verbose to have to specify both options.

By itself, --dissociate does nothing. It _could_ imply --reference (but
right now complains that --reference was not provided and turns itself
off). But if we were to have a single-option version of "reference and
dissociate", I do not think "--dissociate" is the best choice. By itself
it does not mean much (dissociate from _what_?).

I wonder if there is some better word that could become a synonym for
"--reference --dissociate". Maybe "--borrow", but that does not
necessarily carry the implication that the relationship ends as soon as
the clone is done. What is really happening is that we are reusing
objects in order to save bandwidth. Maybe "--reuse-from" would work?

I dunno. I am not extremely happy with any of the suggestions I made,
nor is any of this of extreme importance to me. But I thought I would
mention it while we are on the subject.

-Peff
