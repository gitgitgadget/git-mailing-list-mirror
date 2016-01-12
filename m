From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Tue, 12 Jan 2016 16:49:09 -0500
Message-ID: <20160112214909.GD2841@sigill.intra.peff.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601120939270.2964@virtualbox>
 <xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 22:49:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ6oW-0002IZ-ID
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 22:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbcALVtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 16:49:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:52588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751302AbcALVtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 16:49:12 -0500
Received: (qmail 19849 invoked by uid 102); 12 Jan 2016 21:49:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:49:11 -0500
Received: (qmail 18950 invoked by uid 107); 12 Jan 2016 21:49:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:49:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 16:49:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283849>

On Tue, Jan 12, 2016 at 10:47:25AM -0800, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  Rerolled.
> >>  Needs review.
> >
> > Actually, it waits for a re-roll ;-)
> 
> True.
> 
> I think strbuf_getline() that handles the payload as "text" without
> having _crlf() suffix is an ideal endgame in the longer term, but I
> do not think it is a good idea to do that as a flag-day change.  So
> I am inclined not to change the function names around that feature
> in this series.  Others can do the wholesale rename as a separate
> follow-up topic when the tree is quiescent.

Yeah, I think we would want to catch topics in flight. Should the end of
this series then be to _remove_ strbuf_getline()? Callers should be
using strbuf_getline_crlf() if they want text lines, and
strbuf_getdelim() if they do not.

Topics in flight will need fixed up, but that's OK; the breakage (and
the fix) will be obvious.

And then after a quiet period we can drop the "_crlf()" and have
strbuf_getline() back.

-Peff
