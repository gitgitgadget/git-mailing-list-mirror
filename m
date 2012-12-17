From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black
 only on terminals
Date: Mon, 17 Dec 2012 07:13:54 -0500
Message-ID: <20121217121354.GB21858@sigill.intra.peff.net>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:14:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkZaK-0004Y0-V5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 13:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab2LQMN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 07:13:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab2LQMN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 07:13:58 -0500
Received: (qmail 5760 invoked by uid 107); 17 Dec 2012 12:15:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 07:15:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 07:13:54 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211681>

On Mon, Dec 17, 2012 at 06:44:10PM +0700, Nguyen Thai Ngoc Duy wrote:

> >                         if (!end)
> >                                 return 0;
> > -                       color_parse_mem(placeholder + 2,
> > -                                       end - (placeholder + 2),
> > +                       if (!memcmp(begin, "auto,", 5)) {
> > +                               if (!want_color(-1))
> > +                                       return end - placeholder + 1;
> 
> This want_color() checks color.ui and only when color.ui = auto, it
> bothers to check if the output is tty. I think the document should say
> that "auto," (or maybe another name because it's not really auto)
> respects color.ui.

Yeah, that should definitely be documented. I wonder if it should
actually respect color.diff, which is what "log" usually uses (albeit
mostly for the diff itself, we have always used it for the graph and for
the "commit" header of each entry).

-Peff
