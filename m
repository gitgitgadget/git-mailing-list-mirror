From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] completion: create variable for untracked file modes
Date: Wed, 1 Jun 2016 00:05:42 -0400
Message-ID: <20160601040542.GA18978@sigill.intra.peff.net>
References: <5a3d279f-d3cc-90ec-a0e7-90b7ef438966@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 06:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7xPp-0000q3-8S
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 06:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbcFAEFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 00:05:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:46934 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750697AbcFAEFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 00:05:46 -0400
Received: (qmail 15482 invoked by uid 102); 1 Jun 2016 04:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 00:05:46 -0400
Received: (qmail 29579 invoked by uid 107); 1 Jun 2016 04:05:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 00:05:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 00:05:42 -0400
Content-Disposition: inline
In-Reply-To: <5a3d279f-d3cc-90ec-a0e7-90b7ef438966@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296049>

On Wed, Jun 01, 2016 at 01:42:33AM +0200, Thomas Braun wrote:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3402475..57a0acc 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1098,6 +1098,8 @@ _git_clone ()
>  	esac
>  }
>  +__git_untracked_file_modes="all no normal"
> +
>  _git_commit ()
>  {
>  	case "$prev" in

There's something funny about the formatting of your patch. The first
"+" line is indented, which it shouldn't be. As it is, it looks like
context (but it's not actually part of the preimage). But if it's not
context, then you are missing a context line.

It kind of looks like you put a literal "+__git_untracked..." line in
the file and then committed, then added the next line, and committed
that. Or you edited the patch by hand.

Anyway, I couldn't actually apply it.

> @@ -1119,7 +1121,7 @@ _git_commit ()
>  		return
>  		;;
>  	--untracked-files=*)
> -		__gitcomp "all no normal" "" "${cur##--untracked-files=}"
> +		__gitcomp "$(__git_untracked_file_modes)" "" "${cur##--untracked-files=}"

Your __git_untracked_file_modes is a variable, but "$()" will run it as
a command. You want just "$__git_untracked_file_modes", or to make it
into a function.

-Peff
