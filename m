From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 3/6] gitweb: rss feed managingEditor
Date: Thu, 5 Feb 2009 00:19:43 +0100
Message-ID: <200902050019.44016.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUr3Y-0004wX-Oi
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbZBDXTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbZBDXTw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:19:52 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:35439 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbZBDXTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:19:51 -0500
Received: by mu-out-0910.google.com with SMTP id i10so562319mue.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ngxKeqMS98Q5b9m9fJK/lSX8S8eIzPN15bsqROUrKQs=;
        b=dn2n0mYFgS5JhPWMlM/9/VOUvn/YsCVuBVWQ3+I+WOafQM4n9/kdX3XaIgBkq6Nnqu
         ESdou99CTq7bmD+pr4Kz1lk/K29cAhI+aOP0TZGLLax8XPgZN9vyp0U1k95xQ4frMwAB
         CAm78c7kLCs7SUXT7EEYjtYUxQdL7+jXZQgHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Sx44YP0O18KU6WdNoG+dWj78ch/nh/l397eV7VbqAAC5y4HxeSYU6npHnvuT4DxoY6
         bnhPLtrtywJ6NRCaod5vpczIPAK3a+8jcN6+lo+QrSoITzjPdljvbjMi0Jf+uVU+qE0V
         RqTof5WAFx0gOdkZgHqO4AkQpO+7quQd4kKAk=
Received: by 10.103.244.4 with SMTP id w4mr71831mur.90.1233789588717;
        Wed, 04 Feb 2009 15:19:48 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id i7sm1351934mue.14.2009.02.04.15.19.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 15:19:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108461>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> The RSS 2.0 specification allows an optional managingEditor tag for the
> channel, containing the "email address for person responsible for editorial
> content", which is basically the project owner.

Hmmm... does it make sense with gitweb? Perhaps it does...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3d94f50..cc6d0fb 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6074,7 +6074,9 @@ XML
>  		print "<title>$title</title>\n" .
>  		      "<link>$alt_url</link>\n" .
>  		      "<description>$descr</description>\n" .
> -		      "<language>en</language>\n";
> +		      "<language>en</language>\n" .
> +		      # project owner is responsible for 'editorial' content
> +		      "<managingEditor>$owner</managingEditor>\n";

Shouldn't we esc_html($owner), just in case it is for example
"O Wner <owner@example.com>" (either via gitweb.owner or via
projects_index being text file listing projects, because I don't
see GECOS having email in it...)?

>  		if (defined $logo || defined $favicon) {
>  			# prefer the logo to the favicon, since RSS
>  			# doesn't allow both
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
