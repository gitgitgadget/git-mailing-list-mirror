From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] submodule--helper: move config-sanitizing to
 submodule.c
Date: Thu, 28 Apr 2016 11:37:52 -0400
Message-ID: <20160428153751.GE31063@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
 <20160428133819.GD25319@sigill.intra.peff.net>
 <CAGZ79kbJvgseY6aBV6vh0aEFNmHDtSvQuM8xHvp7_pYZSXCq+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:38:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avo10-0001gi-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbcD1PiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:38:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:58498 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753163AbcD1Ph7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:37:59 -0400
Received: (qmail 31542 invoked by uid 102); 28 Apr 2016 15:37:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:37:54 -0400
Received: (qmail 11282 invoked by uid 107); 28 Apr 2016 15:37:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:37:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 11:37:52 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbJvgseY6aBV6vh0aEFNmHDtSvQuM8xHvp7_pYZSXCq+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292907>

On Thu, Apr 28, 2016 at 08:30:45AM -0700, Stefan Beller wrote:

> > +/*
> > + * This function is intended as a callback for use with
> > + * git_config_from_parameters(). It ignores any config options which
> > + * are not suitable for passing along to a submodule, and accumulates the rest
> > + * in "data", which must be a pointer to a strbuf.
> 
> So why is it a void* then? You could make it a strbuf* here, so you
> would not have to document it?
> Oh right, because of git_config_from_parameters(sanitize_submodule_config, ...

Exactly (and why it is all the more important do document it!).

> > The end result can
> > + * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
> 
> s/sub-process/process operating on submodules/, maybe ?
> 
> While it is technically a sub-process, I started to have an aversion
> against "sub"-things
> unless strictly required. :)

Technically it can be any process which then spawns a process operating
on a submodule. Maybe "another process" would be enough?

-Peff
