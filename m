From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 19:06:03 -0500
Message-ID: <20111127000603.GA7687@sigill.intra.peff.net>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
 <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
 <20111126235135.GA7606@sigill.intra.peff.net>
 <CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>, Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 01:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUSG6-00047V-L5
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 01:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab1K0AGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 19:06:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53552
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152Ab1K0AGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 19:06:05 -0500
Received: (qmail 9035 invoked by uid 107); 27 Nov 2011 00:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Nov 2011 19:12:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2011 19:06:03 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185963>

On Sat, Nov 26, 2011 at 03:57:40PM -0800, Junio C Hamano wrote:

> Did I say anything about saNe?. I was talking about saFe.

Fine. But that doesn't change my point: the purpose of such a feature is
to tell git "do _not_ be safe; I have decided already for you whether it
is OK to do this".

> > By turning it on, you
> > are saying "it's OK to run arbitrary code from the repo as the current
> > user".
> 
> The problem I have with it is that you are saying much more than that.
> ... as the current user ANYWHERE on the machine.

Just because it is passed through the environment does not mean you need
to have it set all the time. There is nothing wrong with:

  GIT_ALLOW_UNTRUSTED_HOOKS=true git fetch ~bob/repo.git

We can even spell it:

  git --allow-untrusted-hooks fetch ~bob/repo.git

but it should probably still end up as an environment variable to make
it through to the remote side (you could also tack it on to the
upload-pack command line; that wouldn't make it across git:// or http://
connections, but those are irrelevant here anyway).

-Peff
