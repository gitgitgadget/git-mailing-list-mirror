From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Mon, 28 Nov 2011 03:01:45 -0500
Message-ID: <20111128080145.GB16901@sigill.intra.peff.net>
References: <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
 <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
 <20111126235135.GA7606@sigill.intra.peff.net>
 <CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
 <20111127000603.GA7687@sigill.intra.peff.net>
 <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com>
 <7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 09:02:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUwA1-0007vf-FA
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 09:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1K1IBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 03:01:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53940
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab1K1IBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 03:01:47 -0500
Received: (qmail 22294 invoked by uid 107); 28 Nov 2011 08:08:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Nov 2011 03:08:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Nov 2011 03:01:45 -0500
Content-Disposition: inline
In-Reply-To: <7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186002>

On Sun, Nov 27, 2011 at 10:41:39PM -0800, Junio C Hamano wrote:

> >> I actually like the idea of allowing pre-upload-pack hook on git:// and
> >> possibly http:// only....
> >>
> >> One scenario I do not want to see is this. Suppose ...
> >
> > I'm sorry I started this discussion.  I worked around it, though it's
> > a bit kludgy, so maybe time to drop the debate.
> 
> I do not want you to feel sorry, and I do not understand why you feel that
> way.

Agreed. This is a topic that has come up several times before for other
users (GitHub and Gentoo come to mind), and which I've given some
thought to, which is why I'm writing so many words on the subject.

As for your kludge, I took a peek at gitpod. I actually think
intercepting the call to upload-pack is a reasonably sane approach,
since you really don't care what the client says, and just want to run
before anything else (including ref advertisement) happens. It would be
much nicer if git-daemon could take a parameter[1] to an alternate
upload-pack path so you didn't have to play PATH games. That would be a
simple patch with no security ramifications, I think.

-Peff

[1] I mean a command-line parameter or environment varable. Reading it
    from the repo config _does_ have security implications.
