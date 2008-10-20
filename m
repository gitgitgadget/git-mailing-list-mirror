From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 5/5] gitweb: generate parent..current URLs
Date: Mon, 20 Oct 2008 12:49:13 +0200
Message-ID: <200810201249.14426.jnareb@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:52:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrsLV-0004CU-Hk
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 12:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYJTKtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 06:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYJTKtf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 06:49:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46213 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbYJTKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 06:49:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so876496nfc.21
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RkwQHslRPBq0d33OC/jwzUMX+EGbwvEYJVYNJyJ6oSc=;
        b=Ng/Z4N3+tvxmseyv28B2SW73GyBViCJP62zo4qQ/NB6/0KLKlKk8dZTm+9+6o71p77
         rT9RTAw3uOPKAg6JMvhitoJ0i+tOlFGX6FHVog9y1s+FjLVqixHqhJERVU+dqKcB3OPO
         0hAZo+8eybJAm0/4S3cG90zQehGcm2xdbiS60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hbTjhgpfyiaUogZ6rztXNntir1tkdhYOmQIW/ninpnzTFpmfFz230OEavPJ41APvIN
         zKGP17yGKpTHsmxUWPQLqW1jiqQF4hC+hS9DaDNI+Ydps08DZ/rrcGgxS/V/VCfPUiAe
         N4Nb2GNYgp3hjwpz2yMSAFwpObbmK9bgxJmIM=
Received: by 10.210.56.7 with SMTP id e7mr8607359eba.14.1224499771103;
        Mon, 20 Oct 2008 03:49:31 -0700 (PDT)
Received: from ?192.168.1.11? (abwi157.neoplus.adsl.tpnet.pl [83.8.232.157])
        by mx.google.com with ESMTPS id h1sm5843060nfh.19.2008.10.20.03.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 03:49:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98676>

On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:

> If use_pathinfo is enabled, href now creates links that contain paths in
> the form $project/$action/oldhash:/oldname..newhash:/newname for actions
> that use hash_parent etc.
> 
> If any of the filename contains two consecutive dots, it's kept as a CGI
> parameter since the resulting path would otherwise be ambiguous.

Note that this part is _required_ after previous patch, because
otherwise gitweb could generate path_info links which point to
different view than intended, when filename contains '..' in it,
like for example some test vectors in git test suite, for example
files in t/t5515

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

For what is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>


BTW. I wanted to test this using gitweb-Mechanize test from Lea Wiemann
GSoC 2008 work on gitweb caching, but I couldn't make it run as single
individual test (cd t && ./t9503-gitweb-Mechanize.sh); it requires to
run as "make test" and I didn't want that.  I could have resurrected my
initial version of Test::WWW::Mechanize::CGI test...

> ---
>  gitweb/gitweb.perl |   30 +++++++++++++++++++++++++-----
>  1 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1a7b0b9..f4642e7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -759,7 +759,8 @@ sub href (%) {
>  		# try to put as many parameters as possible in PATH_INFO:
>  		#   - project name
>  		#   - action
> -		#   - hash or hash_base:/filename
> +		#   - hash_parent or hash_parent_base:/file_parent
> +		#   - hash or hash_base:/file_name

Minor nit: this contain independent change 'filename' -> 'file_name',
but I think it is not worth separating...

>  
>  		# When the script is the root DirectoryIndex for the domain,
>  		# $href here would be something like http://gitweb.example.com/
> @@ -778,17 +779,36 @@ sub href (%) {
>  			delete $params{'action'};
>  		}
>  
> -		# Finally, we put either hash_base:/file_name or hash
> +		# Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
> +		# stripping nonexistent or useless pieces
> +		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
> +			|| $params{'hash_parent'} || $params{'hash'});

Nice trick (and required change).

>  		if (defined $params{'hash_base'}) {
> -			$href .= "/".esc_url($params{'hash_base'});
> -			if (defined $params{'file_name'}) {
> +			if (defined $params{'hash_parent_base'}) {
> +				$href .= esc_url($params{'hash_parent_base'});
> +				# skip the file_parent if it's the same as the file_name
> +				delete $params{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
> +				if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
> +					$href .= ":/".esc_url($params{'file_parent'});
> +					delete $params{'file_parent'};
> +				}

Side note: I wonder if we should use esc_url or esc_param here...

> +				$href .= "..";
> +				delete $params{'hash_parent'};
> +				delete $params{'hash_parent_base'};
> +			} elsif (defined $params{'hash_parent'}) {
> +				$href .= esc_url($params{'hash_parent'}). "..";
> +				delete $params{'hash_parent'};
> +			}
> +
> +			$href .= esc_url($params{'hash_base'});
> +			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
>  				$href .= ":/".esc_url($params{'file_name'});
>  				delete $params{'file_name'};
>  			}
>  			delete $params{'hash'};
>  			delete $params{'hash_base'};
>  		} elsif (defined $params{'hash'}) {
> -			$href .= "/".esc_url($params{'hash'});
> +			$href .= esc_url($params{'hash'});
>  			delete $params{'hash'};
>  		}
>  	}
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
