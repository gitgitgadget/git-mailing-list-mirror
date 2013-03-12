From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] config: make parsing stack struct independent
 from actual data source
Date: Tue, 12 Mar 2013 15:27:37 -0400
Message-ID: <20130312192737.GF17099@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165940.GD1136@sandbox-ub.fritz.box>
 <20130312110355.GE11340@sigill.intra.peff.net>
 <20130312162734.GB4704@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUro-0005hI-0I
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361Ab3CLT1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:27:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50034 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932532Ab3CLT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:27:40 -0400
Received: (qmail 29400 invoked by uid 107); 12 Mar 2013 19:29:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 15:29:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 15:27:37 -0400
Content-Disposition: inline
In-Reply-To: <20130312162734.GB4704@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217986>

On Tue, Mar 12, 2013 at 05:27:35PM +0100, Heiko Voigt wrote:

> > Would a union be more appropriate here? We do not ever have to pass it
> > directly as a parameter, since we pass the "struct config_source" to the
> > method functions.
> > 
> > It's still possible to screw up using a union, but it's slightly harder
> > than screwing up using a void pointer. And I do not think we need the
> > run-time flexibility offered by the void pointer in this case.
> 
> No we do not need the void pointer flexibility. But that means every new
> source would need to add to this union. Junio complained about that fact
> when I first added the extra members directly to the struct. A union
> does not waste that much space and we get some seperation using the
> union members. Since this struct is local only I think that should be
> ok.

Right. I think that is not a big deal, as we are not exposing this
struct outside of the config.c; any additions would need to add a new
git_config_from_foo function, anyway.

-Peff
