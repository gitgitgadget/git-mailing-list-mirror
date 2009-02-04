From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 2/6] gitweb: feed generator metadata
Date: Thu, 5 Feb 2009 00:15:19 +0100
Message-ID: <200902050015.20170.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqzJ-0003WG-OG
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbZBDXP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbZBDXP2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:15:28 -0500
Received: from qb-out-0506.google.com ([72.14.204.234]:10938 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbZBDXP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:15:28 -0500
Received: by qb-out-0506.google.com with SMTP id q18so523823qba.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lX7snLxxqsKSEZBqT8QDs9wO9YbSK/JQXNs8fOlddtA=;
        b=kJ/U3+y87NOOFI1DXVlMyBH4uZ3DdgTy1A5PgqdRa6XyLwur+V/UIuLo4T6Av9MQs8
         o/m500t1x7C8vlUGl5rbdnMXSwvT0JSKKRz/14J8IfJoXlizWsux6dEsmVjBk4rYRDbC
         7ecECX4qdfsXIDJJVuO/KA5/UyPwTN20JUl54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=p6NV2GUFJ7pP5l3Ss1c5WqmSIsdyY0pm5X9fVW/HwHBI+moEbkCmmiKbcmxSLDItTg
         ChkeD9BvGX/beFkMo66rC/WdXCCjSZowKfqyfMLfBjha5jVu8Kfw5qd/cruWd4ZKr5I1
         vjuNlVONoPkc0XYn7DISOEB9akS19uD0Dfyeg=
Received: by 10.181.60.13 with SMTP id n13mr746766bkk.39.1233789326213;
        Wed, 04 Feb 2009 15:15:26 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id b17sm8609062fka.24.2009.02.04.15.15.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 15:15:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108456>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> Add <generator> tag to RSS and Atom feed. Versioning info (gitweb/git
> core versions, separated by a literal slash) is stored in the
> appropriate attribute for the Atom feed, and in the tag content for the
> RSS feed.

Very good idea. I haven't examined either specification, so I don't
know what conventions are used, though... and what conventions _should_
be used.

By the way, gitweb uses in HTML header the following (see
git_header_html subroutine):

  <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>

which tries to follow convention how _web servers_ like Apache return
version information in the 'Server:' HTTP response header (product
tokens). Because it was used on only one place, it was not put into
separate subroutine; should it now?

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f8a5d2e..3d94f50 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6085,6 +6085,7 @@ XML
>  			      "<link>$alt_url</link>\n" .
>  			      "</image>\n";
>  		}
> +		print "<generator>gitweb v.$version/$git_version</generator>\n";
>  	} elsif ($format eq 'atom') {
>  		print <<XML;
>  <feed xmlns="http://www.w3.org/2005/Atom">
> @@ -6111,6 +6112,7 @@ XML
>  		} else {
>  			print "<updated>$latest_date{'iso-8601'}</updated>\n";
>  		}
> +		print "<generator version='$version/$git_version'>gitweb</generator>\n";

I'd rather use '"' for attributes, i.e.

+		print "<generator version=\"$version/$git_version\">gitweb</generator>\n";


>  	}
>  
>  	# contents
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
