From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv4 3/3] gitweb: link to patch(es) view from commit and log views
Date: Tue, 16 Dec 2008 02:03:28 +0100
Message-ID: <200812160203.29425.jnareb@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com> <1228575755-13432-3-git-send-email-giuseppe.bilotta@gmail.com> <1228575755-13432-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 02:05:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOMm-0001Ev-DB
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYLPBDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbYLPBDd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:03:33 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:47055 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYLPBDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 20:03:32 -0500
Received: by ey-out-2122.google.com with SMTP id 6so419956eyi.37
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LquPPT2ZUEPz4OyM5R5mYvkAiGVMampoWOLSbtO9LZM=;
        b=xdw9baadlvxAjNoIzq6qlcp9zNCDXkRlOgpQqWsymRV1xl/2STMn5Z2E6w+0+z7bFo
         T8py2SKqSsLfoMkXkpvgwsL0vMMiPuv98PAOLcNxtc7LNxS4wQuiHvMzbSjPZBE+29J1
         oiZhpzHDwSN3CwqKgDVdyZk7eD/numHIHGT/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QqVEQQSAKeOSPd9Kukmx5Kwtlqky98RmLj6NXhPXHCCSnJwcNApXlDnPMBIT6/FRw3
         OCJAqkf/ghq2Zt+/ZOrhXTLLQxtEK9MsgmhAdt40oAgQUo/UGwIJZviuJNlFB7LIIQCB
         JcyHO+RKbzPpPxezXF4ZuLnu7TXzJIX376kWk=
Received: by 10.210.87.14 with SMTP id k14mr3932257ebb.159.1229389410460;
        Mon, 15 Dec 2008 17:03:30 -0800 (PST)
Received: from ?192.168.1.11? (abve222.neoplus.adsl.tpnet.pl [83.8.202.222])
        by mx.google.com with ESMTPS id 7sm625129eyg.52.2008.12.15.17.03.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 17:03:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1228575755-13432-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103225>

On Sat, 6 Dec 2008, Giuseppe Bilotta wrote:

> We link to patch view in commit and commitdiff view, and to patches view
> in log and shortlog view.
> 
> In (short)log view, the link is only offered when the number of commits
> shown is no more than the allowed maximum number of patches.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

A few remarks, but otherwise:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index dfc7128..8198875 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5019,6 +5019,15 @@ sub git_log {
>  
>  	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
>  
> +	my $patch_max = gitweb_check_feature('patches');

If you change other places to use git_get_feature, then you should
change it too. I'm not sure if it is worth it...

> +	if ($patch_max) {
> +		if ($patch_max < 0 || @commitlist <= $patch_max) {
> +			$paging_nav .= " &sdot; " .
> +				$cgi->a({-href => href(action=>"patches", -replay=>1)},
> +					@commitlist > 1 ? "patchset" : "patch");

I think it would be better to always use "patches" here, as it is
series of patches by design, only by accident it is one commit long.

I wonder if it would make sense to pass

   href(..., hash_parent => $commitlist[-1]{'id'}, ...)

here. But I think having separate "patches" action, with intent being
displaying series of patches, is a better solution. This way you can
see in URL and in the page title (thus also in window title, or in
bookmark name) if it is single patch or patch series (perhaps consisting
of single patch).

> +		}
> +	}
> +
>  	git_header_html();
>  	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
>  
> @@ -5098,6 +5107,11 @@ sub git_commit {
>  			} @$parents ) .
>  			')';
>  	}
> +	if (gitweb_check_feature('patches')) {
> +		$formats_nav .= " | " .
> +			$cgi->a({-href => href(action=>"patch", -replay=>1)},
> +				"patch");
> +	}

Here using gitweb_check_feature makes perfect sense.

>  
>  	if (!defined $parent) {
>  		$parent = "--root";
> @@ -5413,9 +5427,8 @@ sub git_commitdiff {
>  	# if only a single commit is passed?
>  	my $single_patch = shift && 1;
>  
> -	my $patch_max;
> +	my $patch_max = gitweb_check_feature('patches');

gitweb_check_feature or gitweb_get_feature?...

>  	if ($format eq 'patch') {
> -		$patch_max = gitweb_check_feature('patches');
>  		die_error(403, "Patch view not allowed") unless $patch_max;
>  	}
>  
> @@ -5433,6 +5446,11 @@ sub git_commitdiff {
>  		$formats_nav =
>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>  			        "raw");
> +		if ($patch_max) {
> +			$formats_nav .= " | " .
> +				$cgi->a({-href => href(action=>"patch", -replay=>1)},
> +					"patch");
> +		}

Nice reusing $patch_max in different way, as $have_patch if $format is
'html', and as limiter ($patch_max) if $format is 'patch'/'patches'

>  
>  		if (defined $hash_parent &&
>  		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
> @@ -5989,6 +6007,14 @@ sub git_shortlog {
>  			$cgi->a({-href => href(-replay=>1, page=>$page+1),
>  			         -accesskey => "n", -title => "Alt-n"}, "next");
>  	}
> +	my $patch_max = gitweb_check_feature('patches');
> +	if ($patch_max) {
> +		if ($patch_max < 0 || @commitlist <= $patch_max) {
> +			$paging_nav .= " &sdot; " .
> +				$cgi->a({-href => href(action=>"patches", -replay=>1)},
> +					@commitlist > 1 ? "patchset" : "patch");
> +		}
> +	}

Same comment as for git_log...

>  
>  	git_header_html();
>  	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
