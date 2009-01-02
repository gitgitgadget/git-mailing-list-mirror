From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use href() when generating URLs in OPML
Date: Fri, 2 Jan 2009 14:09:06 +0100
Message-ID: <200901021409.07695.jnareb@gmail.com>
References: <1230898528-24187-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 14:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIjnR-0007Ru-0D
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 14:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbZABNJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 08:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbZABNJO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 08:09:14 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:55411 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957AbZABNJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 08:09:13 -0500
Received: by ewy10 with SMTP id 10so6746233ewy.13
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 05:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=F9OFTSpJA3y7OJO0XYnWpQa06InTV16ZY9Hyzlh7SD4=;
        b=WFWqYiOJvd+avs6A8ZHtAwi1pVBkAmIk2IkBo9hrSSrSW9bWoHAHaC4KvNFkFoe/mG
         Ge98OScAMoEvZF3TNOTFmifDjk2cjMmQFUdfVb9zWVID5569DbhU2S2nrEEgSKfibmWg
         8rTQYvIbYpe8wwKhevkrFsrbgffkUcDXJqjDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Sp0K2bStzKEEafyTF96/MlYclCx2QNEverbQ9qeta9OlU+tKhu1qQYFXgE0sc9s3E5
         CJkNFVVBnQDoaShBApEo3b3x6kfsmlJc+/k2nBrkQKoh3UznLrjLs0NA1mJd8oE8/1Aq
         TvhX5L+7rS6Y70JSNqybCRCBQArcHrNNvH4Us=
Received: by 10.210.23.18 with SMTP id 18mr2950256ebw.90.1230901750579;
        Fri, 02 Jan 2009 05:09:10 -0800 (PST)
Received: from ?192.168.1.11? (abvd167.neoplus.adsl.tpnet.pl [83.8.201.167])
        by mx.google.com with ESMTPS id 23sm3432479eya.53.2009.01.02.05.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 05:09:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1230898528-24187-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104379>

Giuseppe Bilotta wrote:
> Since the OPML project list view was hand-coding the RSS and HTML URLs,
> it didn't respect global options such as use_pathinfo. Make it use
> href() to ensure consistency with the rest of the gitweb setup.

Good catch. I guess it was before href(..., -full=>1)...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index fa7d8ad..b164001 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6146,8 +6146,8 @@ XML
>  		}
>  
>  		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
> -		my $rss  = "$my_url?p=$proj{'path'};a=rss";
> -		my $html = "$my_url?p=$proj{'path'};a=summary";
> +		my $rss  = href('project' => $proj{'path'}, 'action' => 'rss', -full => 1);
> +		my $html = href('project' => $proj{'path'}, 'action' => 'summary', -full => 1);
>  		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
>  	}
>  	print <<XML;
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
