From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: fix date parsing
Date: Tue, 21 May 2013 23:39:21 -0400
Message-ID: <20130522033921.GB101217@meili.valhalla.31bits.net>
References: <1369192411-8842-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 05:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueztg-0001vd-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 05:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab3EVDjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 23:39:24 -0400
Received: from josefsipek.net ([64.9.206.49]:1610 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695Ab3EVDjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 23:39:23 -0400
Received: from meili.valhalla.31bits.net (c-68-62-19-111.hsd1.mi.comcast.net [68.62.19.111])
	by josefsipek.net (Postfix) with ESMTPSA id 5B192185C;
	Tue, 21 May 2013 23:39:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1369192411-8842-1-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225127>

I applied this one and the "guilt: skip empty line after..." patch.

Jeff.

On Tue, May 21, 2013 at 11:13:31PM -0400, Theodore Ts'o wrote:
> If the date field has a space in it, such as:
> 
>    Date: Tue, 14 May 2013 18:37:15 +0200
> 
> previously guilt would go belly up:
> 
>    + export GIT_AUTHOR_DATE=Tue, 14 May 2013 18:37:15 +0200
>    /usr/local/bin/guilt: 571: export: 14: bad variable name
> 
> Fix this.
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> ---
>  guilt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt b/guilt
> index 9953bdf..6e8d542 100755
> --- a/guilt
> +++ b/guilt
> @@ -568,7 +568,7 @@ commit()
>  				author_date_str=`sed -n -e '/^Date:/ { s/^Date: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
>  			fi
>  			if [ ! -z "$author_date_str" ]; then
> -				export GIT_AUTHOR_DATE=`echo $author_date_str`
> +				export GIT_AUTHOR_DATE="$author_date_str"
>  			fi
>  		fi
>  
> -- 
> 1.7.12.rc0.22.gcdd159b
> 

-- 
The obvious mathematical breakthrough would be development of an easy way to
factor large prime numbers.
		- Bill Gates, The Road Ahead, pg. 265
