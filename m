From: Jeff King <peff@peff.net>
Subject: Re: Re* [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 16:30:26 -0400
Message-ID: <20160610203026.GA21464@sigill.intra.peff.net>
References: <20160610075043.GA13411@sigill.intra.peff.net>
 <20160610083102.GA14192@sigill.intra.peff.net>
 <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
 <CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
 <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:30:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBT4b-00087v-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbcFJUaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:30:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:52963 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751440AbcFJUa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:30:29 -0400
Received: (qmail 29232 invoked by uid 102); 10 Jun 2016 20:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 16:30:29 -0400
Received: (qmail 8405 invoked by uid 107); 10 Jun 2016 20:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 16:30:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2016 16:30:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297068>

On Fri, Jun 10, 2016 at 11:13:10AM -0700, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > I think we could use the indentation trick and it might help in this
> > case. I agree, let's disable this for this cycle and experiment in the
> > next one. Good catch, Peff.
> >
> > As others have said you will always be able to produce counter
> > examples, that's the nature of heuristics. The idea is to see if we
> > can come up with something simple that mostly improves the output,
> > even if sometimes it might have a negative impact on the outputs. But
> > I think we should avoid changing behavior unless it's mostly an
> > improvement.
> 
> OK, let's do this then for the upcoming release for now.  I am
> tempted to flip it back on after the release in 'next', so that
> developers would be exposed to the heuristic by default, though.

Thanks for the patch, and I agree flipping it back on in "next" is a
good idea.

It may be that I am making a fuss over nothing. As you say, we always
knew that it might have false positives. Mostly I was just surprised how
frequent they were in this example (I also wondered why the same pattern
did not trigger in the C code we looked at).

> -- >8 --
> Subject: [PATCH] diff: disable compaction heuristic for now

Looks good.

We probably want a patch to the release notes to note that it's not on
by default. And we may want to advertise the experimental knob so
that people actually try it (otherwise we won't get feedback from the
masses).

-Peff
