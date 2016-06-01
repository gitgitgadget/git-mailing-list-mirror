From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] completion: add git status
Date: Wed, 1 Jun 2016 00:07:23 -0400
Message-ID: <20160601040722.GB18978@sigill.intra.peff.net>
References: <b881e8b7-8364-f78b-d7ac-817850783c6e@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 06:07:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7xRK-0001tG-W4
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 06:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbcFAEH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 00:07:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:46946 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752370AbcFAEH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 00:07:26 -0400
Received: (qmail 15591 invoked by uid 102); 1 Jun 2016 04:07:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 00:07:26 -0400
Received: (qmail 29645 invoked by uid 107); 1 Jun 2016 04:07:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 00:07:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 00:07:23 -0400
Content-Disposition: inline
In-Reply-To: <b881e8b7-8364-f78b-d7ac-817850783c6e@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296050>

On Wed, Jun 01, 2016 at 01:42:18AM +0200, Thomas Braun wrote:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 57a0acc..96b7d86 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1782,6 +1782,35 @@ _git_stage ()
>  	_git_add
>  }
>  +_git_status ()

This patch has the same funniness as the other. Weird.

> +{
> +	case "$cur" in
> +	--ignore-submodules=*)
> +		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
> +		return
> +		;;
> +	--untracked-files=*)
> +		__gitcomp "$(__git_untracked_file_modes)" "" "${cur##--untracked-files=}"

Same comment on $() here.

> +		return
> +		;;
> +	--column=*)
> +		__gitcomp "
> +			always never auto column row plain dense nodense
> +			" "" "${cur##--column=}"
> +		return
> +		;;
> +	--*)
> +		__gitcomp "
> +			--short --branch --porcelain --long --verbose
> +			--untracked-files= --ignore-submodules= --ignored
> +			--column= --no-column
> +			"
> +		return
> +		;;
> +	esac
> +	__git_complete_file
> +}

The rest of it (both the overall goal, and the patch itself) look OK to
me.

-Peff
