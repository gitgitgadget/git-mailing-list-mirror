From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Possible bug report: `git commit -ammend`
Date: Fri, 15 Nov 2013 23:02:14 -0500
Message-ID: <20131116040214.GA24804@sigill.intra.peff.net>
References: <CAMyx446B1U30RL9X7vOrY-u7fQ_cEqRJxn_M8Wn8PuOJhdO-1Q@mail.gmail.com>
 <CAMyx444wJeQUpxZmXmYx-mKE0kniO=ELo5HgzQ1unV4O15oxWw@mail.gmail.com>
 <vpqsiux1wz3.fsf@anie.imag.fr>
 <CACsJy8Ckb+qdQFcTHPcAiRy_08Nxtz5Uh_9R+NXz4yixWR9DUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	rhys evans <rhys.evans@ft.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 05:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhX5R-0007is-Fq
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 05:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab3KPECS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 23:02:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:40128 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752244Ab3KPECR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 23:02:17 -0500
Received: (qmail 29129 invoked by uid 102); 16 Nov 2013 04:02:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Nov 2013 22:02:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Nov 2013 23:02:14 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Ckb+qdQFcTHPcAiRy_08Nxtz5Uh_9R+NXz4yixWR9DUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237924>

On Sat, Nov 16, 2013 at 10:28:36AM +0700, Duy Nguyen wrote:

> > Yes. This is a rather widespread convention (e.g. rm -fr == rm -r -f).
> > Git does a special-case for -amend to avoid confusion:
> >
> >   $ git commit -amend
> >   error: did you mean `--amend` (with two dashes ?)
> >
> > But it did not special-case the double-typo.
> 
> "-m" taking a string without a space or '=' increases the risk of this
> typo. If it does require '=' or ' ' after -m then -ammend is more
> likely to be rejected. Anybody know why we should support -mabc,
> besides convenient?

For flags with optional arguments, "-m abc" would not work (we do not
know if "abc" is the argument or the next flag). An example of such a
flag is "git status -uall".

We could disallow it for mandatory options, but that would create an
inconsistency in the option parsing.

Other than that, I think it is mostly convenience and compatibility with
other option-parsing systems.

-Peff
