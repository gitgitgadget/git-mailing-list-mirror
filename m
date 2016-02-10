From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 11:24:08 -0500
Message-ID: <20160210162408.GD19867@sigill.intra.peff.net>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
 <20160210125429.GA8078@sigill.intra.peff.net>
 <CAHGBnuMMN_xEVDJ_dqWgL6QCGK08hy=ggg=6PzkSCinHr=QeFg@mail.gmail.com>
 <20160210154006.GA19867@sigill.intra.peff.net>
 <CAHGBnuMDCYePJyEU4yHjGjEzyZn8mRBE73WC3qsRqbb6Amhyog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:24:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXYu-0001dj-QO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcBJQYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 11:24:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:39820 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752487AbcBJQYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:24:11 -0500
Received: (qmail 2783 invoked by uid 102); 10 Feb 2016 16:24:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 11:24:10 -0500
Received: (qmail 29238 invoked by uid 107); 10 Feb 2016 16:24:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 11:24:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 11:24:08 -0500
Content-Disposition: inline
In-Reply-To: <CAHGBnuMDCYePJyEU4yHjGjEzyZn8mRBE73WC3qsRqbb6Amhyog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285915>

On Wed, Feb 10, 2016 at 04:57:00PM +0100, Sebastian Schuberth wrote:

> >> I also would have expected sopme like the latter, except that I'd also
> >> expect a colon after "stdin" and "cmd" (or "cmdline", as said above).
> >> I.e. the colon should be part of the prefix to mark it as such.
> >
> > Yeah, I waffled on that. Having a colon means you can definitely parse
> > to the first ":" without looking at what the prefix is. But if you don't
> > know what the prefix is, I don't know what good that does you. IOW, I'd
> 
> IMO that's asking the wrong question. The question should not be "what
> good does it do if we add the colons also there", but "what
> justification do we have to introduce an inconsistency by not adding
> them".

But I think it is only an inconsistency if your mental model of the
format is "the source field is a prefix, a colon, and then an argument;
sometimes we omit the colon if there is no argument". If your mental
model is "the source field contains a type, followed by type-specific
data", then it is not an inconsistency. It is simply context-sensitive.

Now you can argue that context-sensitive things are bad, and I might
agree with that. :)

> I agree the option wording mostly is personal preference. On the other
> hand, I find discussions like these often prematurely waved aside as
> bikeshedding, just because e.g. Perl can parse the one as good as the
> other. But it's not about Perl, it's about humans. IMO Git has
> historically made many mistakes by not caring enough about consistency
> in docs, command and command line option naming, so I don't see it as
> wasted time to discuss about things like this.

Oh, I agree that formats are worth discussing. It's just that I do not
think either of the mental models above is better than the other.

My point in mentioning perl is not that perl can do it, but rather the
opposite: that _any_ language can do it. And I would even go so far as
to say that humans parse context-sensitive things better than machines,
because we simultaneously apply the semantic and syntactic parsing (so
you see "stdin" and know because of its meaning that there is nothing
left to parse; you don't need a trailing colon to tell you that). Or
perhaps you mean "humans write the programs that machines use to parse,
and we must make things regular and easy for them". I can somewhat buy
that argument, though again, I think either is easy; it is mostly a
matter of documenting the format's mental model.

-Peff
