From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Thu, 12 Feb 2009 23:03:36 +0100
Message-ID: <200902122303.37499.jnareb@gmail.com>
References: <1234473072-9901-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <oblomov@rbot.ratry.ru>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjgI-0005Nz-13
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 23:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbZBLWDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 17:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbZBLWDq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 17:03:46 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:62402 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZBLWDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 17:03:45 -0500
Received: by fxm13 with SMTP id 13so2768924fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 14:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5u2RWZTqxilq2JxtS+EoSKXwnl72uWvDsGOMlANlYes=;
        b=axxqS+4wUnhEc0pVzBwE0RGiMNejo5cVNg9Hldxser/aSQc7UoJ+wplJbPj5UhlztN
         8EKctA/jj0uIt1hyDBvjIS8dL7GeKP5eHz7VM5VF51ilqbnuuhJiEFTWpIvnaamp+kKU
         wBk2aJGtc0l0ptS1m1QC2uZ/A31JIXzqO/rcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ioYcYV+IVdtmikpvLwNZs5h2Sv8wglhMxQn7LWhkfjeuNLQnEYhfsa+zzC9J0F6nCJ
         eQMPAplGeUhxlKjDlkrEITtZ72jJor07XPB1UolhWvTrup9d5GvLImO6o2pHXo6vhJdO
         eMZR46n/7wRglyXD4xcULPbTXjlp4Bfs3maU8=
Received: by 10.103.239.10 with SMTP id q10mr13036mur.67.1234476223382;
        Thu, 12 Feb 2009 14:03:43 -0800 (PST)
Received: from ?192.168.1.13? (abxc167.neoplus.adsl.tpnet.pl [83.8.252.167])
        by mx.google.com with ESMTPS id b9sm894532mug.2.2009.02.12.14.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 14:03:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1234473072-9901-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109671>

On Thu, 12 Feb 2009, Giuseppe Bilotta wrote:

> From: Giuseppe Bilotta <oblomov@rbot.ratry.ru>

Why different email? Was it intended, or was it an accident, and
authorship of this patch should be to

        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

> 
> CGI::url() has some issues when rebuilding the script URL if the script
> is a DirectoryIndex.
> 
> One of these issue is the inability to strip PATH_INFO, which is why we
> had to do it ourselves.
> 
> Another issue is that the resulting URL cannot be used for the <base>
> tag: it works if we're the DirectoryIndex at the root level, but not
> otherwise.
> 
> We fix this by building the proper base URL ourselves, and improve the
> documentation about the need to strip PATH_INFO manually while we're at
> it.

Very good. The only thing I wonder about is if we should add this info
also to gitweb/README, or if it is good as it is now.

Signoff?

I do not use gitweb as DirectoryIndex, but it looks sane, so:
Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c2c8080..48cfd5f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -27,15 +27,23 @@ our $version = "++GIT_VERSION++";
>  our $my_url = $cgi->url();
>  our $my_uri = $cgi->url(-absolute => 1);
>  
> -# if we're called with PATH_INFO, we have to strip that
> -# from the URL to find our real URL
> -# we make $path_info global because it's also used later on
> +# When the script is used as DirectoryIndex, the URL does not contain the name
> +# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
> +# have to do it ourselves. We make $path_info global because it's also used
> +# later on
>  our $path_info = $ENV{"PATH_INFO"};
>  if ($path_info) {
>  	$my_url =~ s,\Q$path_info\E$,,;
>  	$my_uri =~ s,\Q$path_info\E$,,;
>  }
>  
> +# Another issue with the script being the DirectoryIndex is that the resulting
> +# $my_url data is not the full script URL: this is good, because we want
> +# generated links to keep implying the script name if it wasn't explicitly
> +# indicated in the URL we're handling, but it means that $my_url cannot be used
> +# as base URL. Therefore, we have to build the base URL ourselves:
> +our $base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
> +
>  # core git executable to use
>  # this can just be "git" if your webserver has a sensible PATH
>  our $GIT = "++GIT_BINDIR++/git";
> @@ -2908,7 +2916,7 @@ EOF
>  	# the stylesheet, favicon etc urls won't work correctly with path_info
>  	# unless we set the appropriate base URL
>  	if ($ENV{'PATH_INFO'}) {
> -		print "<base href=\"".esc_url($my_url)."\" />\n";
> +		print "<base href=\"".esc_url($base_url)."\" />\n";
>  	}
>  	# print out each stylesheet that exist, providing backwards capability
>  	# for those people who defined $stylesheet in a config file
> -- 
> 1.5.6.4
> 
> 

-- 
Jakub Narebski
Poland
