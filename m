From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] Check for help invocation before setup
Date: Wed, 19 Nov 2008 19:24:36 +0100
Message-ID: <20081119182436.GB10544@machine.or.cz>
References: <1227110623-4474-1-git-send-email-madduck@debian.org> <1227110623-4474-2-git-send-email-madduck@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2rkT-0007ic-5j
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 19:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYKSSYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYKSSYm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 13:24:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42117 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbYKSSYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 13:24:41 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 87D153939719; Wed, 19 Nov 2008 19:24:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227110623-4474-2-git-send-email-madduck@debian.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101366>

On Wed, Nov 19, 2008 at 05:03:40PM +0100, martin f. krafft wrote:
> diff --git a/tg.sh b/tg.sh
> index 2961106..40c4ab7 100644
> --- a/tg.sh
> +++ b/tg.sh
> @@ -235,6 +235,20 @@ do_help()
>  	fi
>  }
>  
> +## Startup
> +
> +args_saved="$@"
> +while [ -n "$1" ]; do
> +	case "$1" in
> +	help|--help|-h)
> +		shift
> +		do_help "$1"
> +		exit 1;;
> +	esac
> +	shift
> +done
> +set -- $args_saved
> +unset args_saved
>  
>  ## Initial setup

Huh, why do you actually need $args_saved at all? :-) This is bound to
do horrible things with space-containing arguments etc., I think. You
don't need to do the outer shift and then drop $args_saved altogether,
no?

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
