From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Escape Git's exec path in contrib/rerere-train.sh script
Date: Fri, 20 Nov 2015 06:44:38 -0500
Message-ID: <20151120114438.GH11198@sigill.intra.peff.net>
References: <1446982075-26161-1-git-send-email-knittl89+git@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Daniel Knittl-Frank <knittl89+git@googlemail.com>
To: Daniel Knittl-Frank <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzk7S-0008EB-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161907AbbKTLol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:44:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:60086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161383AbbKTLol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:44:41 -0500
Received: (qmail 20062 invoked by uid 102); 20 Nov 2015 11:44:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:44:41 -0600
Received: (qmail 26824 invoked by uid 107); 20 Nov 2015 11:45:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:45:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:44:38 -0500
Content-Disposition: inline
In-Reply-To: <1446982075-26161-1-git-send-email-knittl89+git@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281511>

On Sun, Nov 08, 2015 at 12:27:55PM +0100, Daniel Knittl-Frank wrote:

> Whitespace can cause the source command to fail. This is usually not a
> problem on Unix systems, but on Windows Git is likely to be installed
> under "C:/Program Files/", thus rendering the script broken.
> 
> Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> ---
>  contrib/rerere-train.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 36b6fee..52ad9e4 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -7,7 +7,7 @@ USAGE="$me rev-list-args"
>  
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
> -. $(git --exec-path)/git-sh-setup
> +. "$(git --exec-path)/git-sh-setup"

Thanks, this makes sense.

The "normal" scripts just use ". git-sh-setup", but they have the
benefit of being run under the "git" wrapper, so the exec-path is
already in their PATH. This one is meant to be used directly, so it
needs this.

-Peff
