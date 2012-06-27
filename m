From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 22:12:20 +0100
Message-ID: <20120627211219.GD11498@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzXG-0007Te-0I
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676Ab2F0VMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:12:22 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:44434 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab2F0VMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:12:21 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjzXA-0005rz-JV; Wed, 27 Jun 2012 22:12:21 +0100
Content-Disposition: inline
In-Reply-To: <20120627210502.GB2292@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200755>

Jeff King <peff@peff.net> writes:

> >  	/* Check that we have a git documentation directory. */
> > -	if (stat(mkpath("%s/git.html", html_path), &st)
> > -	    || !S_ISREG(st.st_mode))
> > -		die(_("'%s': not a documentation directory."), html_path);
> > +	if (prefixcmp(html_path, "http:")) {
> > +		if (stat(mkpath("%s/git.html", html_path), &st)
> > +				|| !S_ISREG(st.st_mode))
> > +			die("'%s': not a documentation directory.", html_path);
> > +	}
> 
> I'd rather not tie this directly to http. Is there any reason not to
> allow https, for example? Can we maybe just look for strstr("://")
> instead? That's the same magic we use to differentiate URLs from paths
> when looking for repositories.

Thanks, that's a much better heuristic! I'll use !strstr(html_path, "://")
in a re-roll. You're quite right, this ought to also allow https://, ftp://,
etc.

Best wishes,

Chris.
