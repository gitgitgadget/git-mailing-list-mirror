From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] diff_filespec: reorder dirty_submodule macro
 definitions
Date: Fri, 17 Jan 2014 14:47:25 -0500
Message-ID: <20140117194724.GA775@sigill.intra.peff.net>
References: <20140117011844.GA6870@sigill.intra.peff.net>
 <20140117011945.GA7249@sigill.intra.peff.net>
 <xmqqha92xx7g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FO7-0006wx-IO
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbaAQTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:47:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:34341 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752689AbaAQTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:47:27 -0500
Received: (qmail 27780 invoked by uid 102); 17 Jan 2014 19:47:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jan 2014 13:47:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jan 2014 14:47:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqqha92xx7g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240617>

On Fri, Jan 17, 2014 at 10:46:59AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff_filespec has a 2-bit "dirty_submodule" field and
> > defines two flags as macros. Originally these were right
> > next to each other, but a new field was accidentally added
> > in between in commit 4682d85.
> 
> Interesting.
> 
>  - 4682d852 (diff-index.c: "git diff" has no need to read blob from
>    the standard input, 2012-06-27) wants to use this rule: all the
>    bitfield definitions first, and then whatever macro constants
>    next.
> 
>  - 25e5e2bf (combine-diff: support format_callback, 2011-08-19),
>    wants to use a different rule: a run of (one bitfield definition
>    and zero-or-more macro constants to be used in that bitfield).
> 
> When they were merged together at d7afe648 (Merge branch
> 'jc/refactor-diff-stdin', 2012-07-13), these two conflicting
> philosophies crashed.
> 
> That is the commit to be blamed for this mess ;-)

That makes sense. I had assumed it was a mis-merge initially, so was
surprised to find 4682d85. It just looked like an error to me, but the
rule you gave above does at least make sense.

I'm happy with it either way. I almost just pulled the macro
definitions, including DIFF_FILE_VALID, out of the struct definition
completely. I see the value in having the flags near their bitfield, but
it makes the definition a bit harder to read.

> I am of course fine with the end result this patch gives us.

Me too, though if you feel like doing it the other way, I'm fine with
that, too.

-Peff
