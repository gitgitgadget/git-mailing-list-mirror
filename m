From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv3 2/2] gitweb: links to patch action in commitdiff and shortlog view
Date: Sat, 6 Dec 2008 01:53:52 +0100
Message-ID: <200812060153.52947.jnareb@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com> <1228345188-15125-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 01:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8lS3-0008Rg-I9
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 01:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbYLFAyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 19:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbYLFAyB
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 19:54:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29028 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbYLFAyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 19:54:00 -0500
Received: by nf-out-0910.google.com with SMTP id d3so144184nfc.21
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+z41lrb1Gjc7rcLi7dkNMbLCZvLkUW8YG9iR/IxOjKU=;
        b=smrEifSXyK7DXfLwfBZ6h8+nWxcLEeHnMKEcHwgGWOoB6G6z15TvdwkXAjKWM3fzGb
         TFQajsxdup/xvNY7zMY6qvCqvx3xS32gsrDFsIuW5iALT7cEWk5vCeIesCxxPqPsoime
         uoWLOmEkv375uAWtqW+g4YABsY+gQR/5iJXa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VZ8cE/GB3Y6lnEtm/gMikQhbJXH88hwZeOk4PCUjWOgD+0cYq8xOHbp1gNU27eZCZ7
         O95uKFT1OFokVpdy9s0dSJr1BZ9duUBHiayGWE2SFq5nqPWTkAARdACu0jZGRWdZy8VU
         GFqKsj0+EmQsUbsQL9sIbvdZ/T9u5A6p4YG40=
Received: by 10.210.61.19 with SMTP id j19mr592316eba.41.1228524838354;
        Fri, 05 Dec 2008 16:53:58 -0800 (PST)
Received: from ?192.168.1.11? (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id 7sm209421eyb.54.2008.12.05.16.53.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 16:53:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1228345188-15125-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102427>

On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:

> In shortlog view, a link to the patchset is only offered when the number
> of commits shown is less than the allowed maximum number of patches.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c9abfcf..ec8fc7d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5083,6 +5083,11 @@ sub git_commit {
>  			} @$parents ) .
>  			')';
>  	}
> +	if (gitweb_check_feature('patches')) {
> +		$formats_nav .= " | " .
> +			$cgi->a({-href => href(action=>"patch", -replay=>1)},
> +				"patch");
> +	}
>  
>  	if (!defined $parent) {
>  		$parent = "--root";
> @@ -5415,6 +5420,11 @@ sub git_commitdiff {
>  		$formats_nav =
>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>  			        "raw");
> +		if ($patch_max) {
> +			$formats_nav .= " | " .
> +				$cgi->a({-href => href(action=>"patch", -replay=>1)},
> +					"patch");
> +		}
>  
>  		if (defined $hash_parent &&
>  		    $hash_parent ne '-c' && $hash_parent ne '--cc') {

In the above two hunks 'patch' view functions as "git show --pretty=email"
text/plain equivalent, but this duplicates a bit 'commitdiff_plain'
functionality.  Well, 'commitdiff_plain' has currently some errors,
but...

> @@ -5949,6 +5959,14 @@ sub git_shortlog {
>  			$cgi->a({-href => href(-replay=>1, page=>$page+1),
>  			         -accesskey => "n", -title => "Alt-n"}, "next");
>  	}
> +	my $patch_max = gitweb_check_feature('patches');
> +	if ($patch_max) {
> +		if ($patch_max < 0 || @commitlist <= $patch_max) {
> +			$paging_nav .= " &sdot; " .
> +				$cgi->a({-href => href(action=>"patch", -replay=>1)},
> +					@commitlist > 1 ? "patchset" : "patch");
> +		}
> +	}

Here 'patch' view functions as "git format-patch", able to be downloaded
and fed to git-am.  Perhaps the action should also be named 'patches'
here?; it could lead to the same function.

By the way, there is subtle bug in above link. If shortlog view is less
than $patch_max commits long, but it is because the history for a given
branch (or starting from given commit) is so short, and not because
there is cutoff $hash_parent set, the 'patchset' view wouldn't display
plain text equivalent view, but only patch for top commit.

I assume that the link is only for 'shortlog' view, and not also for
'log' and 'history' views because 'shortlog' is the only log-like view
which support $hash_parent?

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
