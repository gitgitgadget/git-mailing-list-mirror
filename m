From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 09:00:22 -0400
Message-ID: <20120713130021.GA2553@sigill.intra.peff.net>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
 <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vtxxcc36v.fsf@alter.siamese.dyndns.org>
 <vpq1ukgai4e.fsf@bauges.imag.fr>
 <7vwr28agcq.fsf@alter.siamese.dyndns.org>
 <vpq1ukg82st.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 13 15:00:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpfU3-0003gd-2J
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 15:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162569Ab2GMNAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 09:00:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:58806
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161529Ab2GMNA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 09:00:29 -0400
Received: (qmail 1979 invoked by uid 107); 13 Jul 2012 13:00:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jul 2012 09:00:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 09:00:22 -0400
Content-Disposition: inline
In-Reply-To: <vpq1ukg82st.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201399>

On Fri, Jul 13, 2012 at 10:48:18AM +0200, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But is it really true that we want to error out on missing HOME if
> > we have usable XDG stuff?
> 
> Anyone else have an opinion on this?
> 
> In short, the question is whether
> 
>   export XDG_CONFIG_HOME=some-existing-dir
>   unset HOME
>   git config foo.baz boz
> 
> should die("$HOME is unset") or use the XDG config file.

What did previous versions of git do? From my reading of 21cf32279, the
previous behavior was that if $HOME was not set, git would silently
avoid reading from $HOME/.gitconfig entirely. Wouldn't dying be a huge
regression?

-Peff
