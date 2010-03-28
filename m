From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Sun, 28 Mar 2010 08:05:32 -0400
Message-ID: <20100328120532.GA6131@coredump.intra.peff.net>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 14:05:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvrFU-0007aS-Gb
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 14:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0C1MFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 08:05:43 -0400
Received: from peff.net ([208.65.91.99]:55213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab0C1MFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 08:05:42 -0400
Received: (qmail 22673 invoked by uid 107); 28 Mar 2010 12:06:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 08:06:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 08:05:32 -0400
Content-Disposition: inline
In-Reply-To: <20100328092253.GA17563@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143386>

On Sun, Mar 28, 2010 at 05:22:54AM -0400, Jeff King wrote:

> > --- a/setup.c
> > +++ b/setup.c
> > @@ -390,6 +392,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  	 *   etc.
> >  	 */
> >  	offset = len = strlen(cwd);
> > +	if ((one_filesystem = git_env_bool("GIT_ONE_FILESYSTEM", 0))) {
> > +		if (stat(".", &buf))
> > +			die_errno("failed to stat '.'");
> > +		current_device = buf.st_dev;
> > +	}
> 
> Style nit. I know you did the proper () to silence the compiler warning,
> but we usually avoid assignment-inside-conditional altogether.
> Personally I don't really care either way.

Actually I take this back. It is in our CodingStyle guide, but we
violate it all over the place (my grep counted 522). Perhaps it should
be removed from CodingStyle.

-Peff
