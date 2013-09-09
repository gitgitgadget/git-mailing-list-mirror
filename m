From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 16:53:49 -0400
Message-ID: <20130909205349.GA15506@sigill.intra.peff.net>
References: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <vpqr4cy4g5q.fsf@anie.imag.fr>
 <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
 <20130909195231.GA14021@sigill.intra.peff.net>
 <20130909202435.GJ2582@serenity.lan>
 <vpq38pdlnxk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 09 22:53:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8T6-0006X3-Nz
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 22:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab3IIUxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 16:53:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:57926 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab3IIUxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 16:53:52 -0400
Received: (qmail 26022 invoked by uid 102); 9 Sep 2013 20:53:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 15:53:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 16:53:49 -0400
Content-Disposition: inline
In-Reply-To: <vpq38pdlnxk.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234375>

On Mon, Sep 09, 2013 at 10:50:31PM +0200, Matthieu Moy wrote:

> John Keeping <john@keeping.me.uk> writes:
> 
> > I think we need to make sure that we give instructions for how to go
> > back if the default hasn't done what you wanted.  Something like this:
> >
> >     Your pull did not fast-forward, so Git has merged '$upstream' into
> >     your branch, which may not be correct for your project.  If you
> >     would rather rebase your changes, run
> >
> >         git rebase
> >
> >     See "pull.mode" in git-config(1) to suppress this message in the
> >     future.
> 
> Sounds good to me. One option is to display the warning on the
> command-line, and another option is to show it in COMMIT_EDITMSG (since
> we now default to showing it even for non-conflicted merges).

I hadn't though of that, but showing it in COMMIT_EDITMSG is a great
moment, because you are notifying the user _before_ they create a merge
commit. So the backout/switch procedure is "cancel this by giving an
empty message, then re-run git pull --rebase".

On the other hand, if we run into conflicts, you'd probably want to let
them know before asking them to resolve them all. So perhaps a separate
message would be needed for that case (to suggest "reset --merge && git
pull --rebase").

-Peff
