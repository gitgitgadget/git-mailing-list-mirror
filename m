From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 4/6] gitweb: rss channel date
Date: Thu, 5 Feb 2009 00:24:43 +0100
Message-ID: <200902050024.43634.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUr8M-0006mF-HQ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZBDXYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181AbZBDXYv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:24:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:2284 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbZBDXYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:24:50 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1383943fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CBRTAyMvTw07rhNgtz/cFrCR4NY80N7EnJtSFo0/q44=;
        b=mEOeVSmxZVIYmdRCECp54qXdTCs1aMECms4Z3BQKgOygV6sgrSvKwy43bVfmkM6mEX
         4LoBD5g+FDU7w5lR0lpvOfUxStQVRYEpT93rXZRth29/DTugMhehAELJ2NPGNYQCZWxG
         TJmcIa22CLnWw/iP5+nrqm4jRWHi69V6kK7nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Sc1sgbGBUs/1PgkHUGnSiDMBq4t0vgx+iGlKHm6i6QBQ7DzbuAohsiy60f0ijJNhH9
         SU3qTNsvTBR+K6JgsC77Bwi31Jqt0BLenci4ulbhB9xVNrnhdIJIJVEiSW7DefidSXAU
         PBlGKC1inN735ia64XPCdYceJ2ZuGregLDxoc=
Received: by 10.86.3.4 with SMTP id 4mr2509655fgc.66.1233789888632;
        Wed, 04 Feb 2009 15:24:48 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id 4sm1937431fgg.15.2009.02.04.15.24.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 15:24:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108463>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> The RSS 2.0 specifications defines not one but _two_ dates for its
> channel element! Woohoo! Luckily, it seems that consensus seems to be
> that if both are present they should be equal, except for some very
> obscure and discouraged cases. Since lastBuildDate would make more sense
> for us and pubDate seems to be the most commonly used, we defined both
> and make them equal.

Perhaps it would make sense to quote RSS 2.0 standard format here
in the commit message, e.g.:

  pubDate	 The publication date for the content in the channel.
  lastBuildDate	 The last time the content of the channel changed.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cc6d0fb..756868a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6087,6 +6087,10 @@ XML
>  			      "<link>$alt_url</link>\n" .
>  			      "</image>\n";
>  		}
> +		if (%latest_date) {
> +			print "<pubDate>$latest_date{'rfc2822'}</pubDate>\n";
> +			print "<lastBuildDate>$latest_date{'rfc2822'}</lastBuildDate>\n";
> +		}

I think it is good approximation of intended meaning of those two
elements.

>  		print "<generator>gitweb v.$version/$git_version</generator>\n";
>  	} elsif ($format eq 'atom') {
>  		print <<XML;
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
