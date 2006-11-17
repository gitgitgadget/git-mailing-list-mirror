X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-checkout: allow pathspec to recover lost working tree directory
Date: Fri, 17 Nov 2006 16:44:59 +0100
Message-ID: <20061117154459.GF7201@pasky.or.cz>
References: <7vbqn8msuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 15:46:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vbqn8msuw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31700>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl5u3-0007xX-0R for gcvg-git@gmane.org; Fri, 17 Nov
 2006 16:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933670AbWKQPpE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 10:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933676AbWKQPpE
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 10:45:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53406 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S933673AbWKQPpB (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 10:45:01 -0500
Received: (qmail 8316 invoked by uid 2001); 17 Nov 2006 16:44:59 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 08:07:19PM CET, Junio C Hamano wrote:
> diff --git a/git-checkout.sh b/git-checkout.sh
> index eb28b29..737abd0 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -112,7 +112,11 @@ Did you intend to checkout '$@' which ca
>  		git-ls-tree --full-name -r "$new" "$@" |
>  		git-update-index --index-info || exit $?
>  	fi
> -	git-checkout-index -f -u -- "$@"
> +
> +	# Make sure the request is about existing paths.
> +	git-ls-files --error-unmatch -- "$@" >/dev/null || exit
> +	git-ls-files -- "$@" |
> +	git-checkout-index -f -u --stdin
>  	exit $?
>  else
>  	# Make sure we did not fall back on $arg^{tree} codepath

Wouldn't it be better to fix git-checkout-index to checkout a whole
directory if specified?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
