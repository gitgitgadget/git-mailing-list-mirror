From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 3/9] gitweb: use git_print_authorship_rows in 'tag' view too
Date: Sat, 27 Jun 2009 20:10:29 +0200
Message-ID: <200906272010.30754.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKcMU-0002W1-G5
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 20:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbZF0SKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbZF0SKf
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 14:10:35 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64091 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZF0SKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 14:10:34 -0400
Received: by fxm18 with SMTP id 18so260271fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=98xmWk3BCVbrn9QCteItWFvyWyorTHXCHxELheT2Xo0=;
        b=YxryuE7+3T78QNw6YjN236ydWIioZqBtfj2WpqnSZBmedZk9HAKtqkMQyw1ZYyU5jL
         7eqV77tAX6wT/hAuQZH06eQ3tARq1UMEAtzNaH7DUNeETddN4MBUM7l1fAe8xD9CcicW
         mwtYSKzhGgRmyYVop4yfF6E9esrMjhgvZwr0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QzpSUWh4RTlleK6Fo5TczPaGYe8aSnLjY11IPkQW20DAq9etdwPvo9kR4o0RTQwWsQ
         7PT60jm6XmTDyXvTs526PQGnz3q8wh7KziWq2fBMHycHiGJwG4Oaaa12S+M6iQmrHed8
         QslbN11GiBUAnTaeQPTBTlji9llj/INsw+uVw=
Received: by 10.103.189.15 with SMTP id r15mr3002863mup.126.1246126236661;
        Sat, 27 Jun 2009 11:10:36 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id j2sm22626697mue.42.2009.06.27.11.10.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 11:10:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122377>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> parse_tag has to be adapted to use the hash keys expected by
> git_print_authorship_rows, which is not a problem since git_tag
> is the only user of this sub.

Nitpick: I think that with s/has/had/ (past tense) and 
s/, which/. This/ (split paragraph into two sentences)
it would read better.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0d8005d..7183ad2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2409,8 +2409,14 @@ sub parse_tag {
>  			$tag{'name'} = $1;
>  		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
>  			$tag{'author'} = $1;
> -			$tag{'epoch'} = $2;
> -			$tag{'tz'} = $3;
> +			$tag{'author_epoch'} = $2;
> +			$tag{'author_tz'} = $3;
> +			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> +				$tag{'author_name'}  = $1;
> +				$tag{'author_email'} = $2;
> +			} else {
> +				$tag{'author_name'} = $tag{'author'};
> +			}
>  		} elsif ($line =~ m/--BEGIN/) {
>  			push @comment, $line;
>  			last;

Sidenote: I wonder if it would be worth doing to factor out code dealing
with extracting data from (parsing) author/committer/tagger object headers.
Probably not worth it...

> @@ -4623,11 +4629,7 @@ sub git_tag {
>  	                                      $tag{'type'}) . "</td>\n" .
>  	      "</tr>\n";
>  	if (defined($tag{'author'})) {
> -		my %ad = parse_date($tag{'epoch'}, $tag{'tz'});
> -		print "<tr><td>author</td><td>" . esc_html($tag{'author'}) . "</td></tr>\n";
> -		print "<tr><td></td><td>" . $ad{'rfc2822'} .
> -			sprintf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'}) .
> -			"</td></tr>\n";
> +		git_print_authorship_rows(\%tag, 'author');
>  	}
>  	print "</table>\n\n" .
>  	      "</div>\n";

I wonder why we used and use 'author' instead of 'tagger'...

-- 
Jakub Narebski
Poland
