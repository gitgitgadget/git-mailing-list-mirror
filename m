From: Jeff King <peff@peff.net>
Subject: Re: Q about git rev-parse {--is-inside-work-tree, --show-cdup}
Date: Fri, 3 Dec 2010 16:50:32 -0500
Message-ID: <20101203215032.GB3972@sigill.intra.peff.net>
References: <4CF95BDC.60506@dirk.my1.cc>
 <7v4oauo8fj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdWa-0006nU-L8
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0LCVuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:50:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55839 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659Ab0LCVue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:50:34 -0500
Received: (qmail 26655 invoked by uid 111); 3 Dec 2010 21:50:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.205)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 03 Dec 2010 21:50:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Dec 2010 16:50:32 -0500
Content-Disposition: inline
In-Reply-To: <7v4oauo8fj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162862>

On Fri, Dec 03, 2010 at 01:25:36PM -0800, Junio C Hamano wrote:

> > 1. Wouldn't it be useful, if "git rev-parse" (1) had an option "-q" that
> > simply indicates whether "--is-inside-work-tree" is true by means of the
> > return code? Actually it has an option "-q" but that doesn't work with
> > "--is-inside-work-tree".
> 
> That would break existing scripts that expect "-q" to squelch only the
> error output, no?  I think the risk of breaking existing scripts that
> other people wrote over time that you (and I) haven't seen outweighs any
> benefit (i.e. "if test $(rev-parse...) = true" vs "if rev-parse...") you
> are seeing here.

Right now "-q" doesn't do _anything_ for --is-inside-work-tree, AFAICT.
It is a useless no-op. So I don't know if we are breaking anybody. What
does somebody doing "git rev-parse -q --is-inside-work-tree" expect to
happen?

I don't see why they would expect it to suppress error output. Usually
"-q" is about "suppress non-essential output, but keep errors coming".
If you wanted to suppress errors, you would use "2>/dev/null".

That being said, in my original reply I only half-thought about Dirk's
problem, and considered more the number of times "git rev-parse -q" has
annoyed me in the past by doing nothing[1], and just assumed this was
another such case. It really isn't that hard to just check $(git
rev-parse) in this instance.

-Peff

[1] I wish I could remember my exact case. It's something that I
remember coming up no more than once every month or two, but that annoys
me every time, because it doesn't do what I expect.

-Peff
