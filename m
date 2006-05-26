From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] t6000lib: workaround a possible dash bug
Date: Fri, 26 May 2006 22:33:42 +1000
Message-ID: <20060526123342.GD5372@gondor.apana.org.au>
References: <11486091793385-git-send-email-normalperson@yhbt.net> <11486091792604-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 14:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjboa-0006z9-LR
	for gcvg-git@gmane.org; Fri, 26 May 2006 14:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEZMxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEZMxM
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 08:53:12 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:42245 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750707AbWEZMxL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 08:53:11 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1FjboM-0002pD-21; Fri, 26 May 2006 22:53:02 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1FjbVe-000192-00; Fri, 26 May 2006 22:33:42 +1000
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <11486091792604-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20810>

On Thu, May 25, 2006 at 07:06:18PM -0700, Eric Wong wrote:
>
>  t/t6000lib.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> cba907ce0b1c0927fb15cbb5dd91a4129ff9a950
> diff --git a/t/t6000lib.sh b/t/t6000lib.sh
> index c6752af..d402621 100755
> --- a/t/t6000lib.sh
> +++ b/t/t6000lib.sh
> @@ -69,7 +69,9 @@ on_committer_date()
>  {
>      _date=$1
>      shift 1
> -    GIT_COMMITTER_DATE=$_date "$@"
> +    export GIT_COMMITTER_DATE="$_date"
> +    "$@"
> +    unset GIT_COMMITTER_DATE

The original code looks correct to me.  So I think this too should
be fixed in dash instead.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
