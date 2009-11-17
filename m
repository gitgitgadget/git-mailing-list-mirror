From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Tue, 17 Nov 2009 02:34:26 -0500
Message-ID: <20091117073426.GB4007@coredump.intra.peff.net>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAIa9-0003CU-9d
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbZKQHeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbZKQHeV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:34:21 -0500
Received: from peff.net ([208.65.91.99]:40089 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755471AbZKQHeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 02:34:21 -0500
Received: (qmail 21780 invoked by uid 107); 17 Nov 2009 07:38:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Nov 2009 02:38:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2009 02:34:26 -0500
Content-Disposition: inline
In-Reply-To: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133070>

On Mon, Nov 16, 2009 at 11:07:40AM +0100, Matthieu Moy wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d1e2120..c37b51d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -380,7 +380,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
>  core.excludesfile::
>  	In addition to '.gitignore' (per-directory) and
>  	'.git/info/exclude', git looks into this file for patterns
> -	of files which are not meant to be tracked.  See
> +	of files which are not meant to be tracked.  "~" and "~user"
> +	are expanded to the user's home directory.  See
>  	linkgit:gitignore[5].

Reading this, it is not clear to me if:

  1. "~" and "~user" are expanded to the home directory of "user", where
     "user" is the user running git

or

  2. "~" is expanded to the home directory of the user running git, and
     an arbitrary "~user" is expanded to that user's home directory.

I would expect (2), since that is how everything else works. And it
seems from the code that is what you do. But something about the way it
is written makes me think of (1). I also recall having this same
question during the last round, so at the very least it is not me just
mis-reading it once. ;)

Maybe:

  A leading path component of "~user" is expanded to the home directory
  of "user"; "~" is expanded to the home directory of the user running
  git.

would be more clear?

-Peff
