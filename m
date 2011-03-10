From: Jeff King <peff@peff.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 18:09:58 -0500
Message-ID: <20110310230958.GI15828@sigill.intra.peff.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
 <20110310184653.GA17832@sigill.intra.peff.net>
 <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
 <20110310192851.GB19257@sigill.intra.peff.net>
 <7vtyfa3ddm.fsf@alter.siamese.dyndns.org>
 <20110310214206.GA15828@sigill.intra.peff.net>
 <7v8vwm37nk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxozk-0006eO-Az
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 00:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab1CJXKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 18:10:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60507
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146Ab1CJXJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 18:09:59 -0500
Received: (qmail 32487 invoked by uid 107); 10 Mar 2011 23:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 18:10:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 18:09:58 -0500
Content-Disposition: inline
In-Reply-To: <7v8vwm37nk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168868>

On Thu, Mar 10, 2011 at 02:58:07PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, I don't want to see cleanly merged parts. And "--cc" already does
> > what I want by not showing them.
> 
> Are you sure about that?

Well, no. But my experience has been that its output is useful.

> What "--cc" would show largely depends on what you have in your working
> tree. If your two branches fixed the same bug with very different
> approaches, you may resolve the conflict favouring what one side did while
> discarding everything the other side did. The file in your work tree might
> be the same as "git checkout --ours $that_path" after a mergy operation.
> "diff --cc" won't show anything to you in such a case.

Actually, I think diff --cc is doing what I want there. If I take one
side's content completely, then it is not interesting to me anymore.
What I am really concerned about is doing a tricky content-level merge
in my editor and then screwing up the result. Or _trying_ to take one
side of the merge, and then screwing it up. So the "diff --cc" output
after I have mucked is useful for both those cases.

> And as I repeatedly said, grabbing "--cc file" must be done before the
> user starts mucking with the file in the working tree for the approach to
> be any useful.

I'm not sure I agree. The output after I have mucked is useful to me,
and that is what this use-case is based on. So I think we are talking
about related but slightly different use cases.

> > Which really I could do with:
> >
> >   for i in `git diff-files --name-only --diff-filter=U`; do
> >     git diff --cc $i
> >     echo 'OK?'
> 
> As you already know, I disagree the usefulness of this approach (see the
> "Are you sure about that?" discussion), hence I doubt the usefulness of
> "have it integrated into the "git add -p" loop".

OK, let me put it this way. I am not volunteering to work on the
approach you outlined. If you are, great. But if not, then what should
be done? The current behavior to show the diff and then exit is quite
confusing. At the very least, we should say something to the user about
what happened (or even suppress the diff and just say "these paths are
unmerged, and we can't handle them in add -p").

-Peff
