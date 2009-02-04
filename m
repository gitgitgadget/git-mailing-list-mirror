From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 1/6] gitweb: channel image in rss feed
Date: Wed, 4 Feb 2009 23:56:31 +0100
Message-ID: <200902042356.34407.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 23:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqhA-0005Vd-LN
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbZBDW4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZBDW4i
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:56:38 -0500
Received: from qb-out-0506.google.com ([72.14.204.226]:8877 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZBDW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:56:37 -0500
Received: by qb-out-0506.google.com with SMTP id q18so516114qba.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 14:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AYvSPTtRklM+rZRjS7xmZJtG2aLrjQXTCMXi2lttwO0=;
        b=KWr4prixIKtRkx9HoUsaZIBZjG8WgQkrI2Z/gAkCxKzNKYrhsdeIA23T1sCO0pqMzG
         v7Yqxozu4Q4wcAptLG87qGZrkmrGb0D66hilZ0l4zWVFdgHMU0Y1NC/sVJej6ul5ZAmu
         gouVXGER4ulwuq1/75k/kohvSVGLtg4ltOM6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NsygTqBjzhxKJ0sa2MaJ2oYv+vLQYOa4Rb4Pmekqosf0U+/CAVVhGWlKHc6fZiwBZZ
         eeyvXNVFsKi5X3t+Lv5780efWAyToNzxiXWlgwS1j6lA3FOpJFCsj2gvdlQT8jm1Wf8e
         Cz2BfmbIiPrL2F1zQ9oudgbk1m4SNnmBsI3Vc=
Received: by 10.86.89.20 with SMTP id m20mr2140894fgb.71.1233788195405;
        Wed, 04 Feb 2009 14:56:35 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id l19sm8116473fgb.47.2009.02.04.14.56.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 14:56:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108452>

I'm sorry for the delay reviewing this series.

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> Define the channel image for the rss feed when the logo or favicon are
> defined, preferring the former to the latter. As suggested in the RSS
> 2.0 specifications, the image's title and link as set to the same as the
> channel's.

I think it is a very good idea.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I don't personally use either RSS feeds, or Atom feeds from gitweb,
therefore I don't feel like I am able to ack this changes... but I do
like them.

> ---
>  gitweb/gitweb.perl |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 931db4f..f8a5d2e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6075,6 +6075,16 @@ XML
>  		      "<link>$alt_url</link>\n" .
>  		      "<description>$descr</description>\n" .
>  		      "<language>en</language>\n";
> +		if (defined $logo || defined $favicon) {
> +			# prefer the logo to the favicon, since RSS
> +			# doesn't allow both
> +			my $img = esc_url($logo || $favicon);
> +			print "<image>\n" .
> +			      "<url>$img</url>\n" .
> +			      "<title>$title</title>\n" .
> +			      "<link>$alt_url</link>\n" .
> +			      "</image>\n";
> +		}

A question: how should URL, which is _contents_ of a tag (instead of
as _attribute_ value), quoted (escaped)? I don't think it is specified
in RSS. I guess that using esc_url() is a safe solution.

>  	} elsif ($format eq 'atom') {
>  		print <<XML;
>  <feed xmlns="http://www.w3.org/2005/Atom">
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
