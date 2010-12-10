From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/18] gitweb: Add show_warning() to display an immediate warning, with refresh
Date: Thu, 09 Dec 2010 17:01:05 -0800 (PST)
Message-ID: <m3zksezbkm.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-16-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQrMK-0006zG-Bt
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab0LJBBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:01:10 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:46717 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343Ab0LJBBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 20:01:09 -0500
Received: by fxm18 with SMTP id 18so3161656fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=52FiaGUIKMlXt9ZXbgyMqs4lMi1kYdbTFo3j/Pszew8=;
        b=chq1ZgFh5l/GmO0xMRo4u7hAUH9yAI097IqDngAujhxbnGzngw6DnZRHQV+jkN2PVZ
         koe4ej5wNKcGWnLJq2wn9PZ/9DvpMY3P5kAEsC/xAG2LLWsjeAvcpm/FyYaTCZklf4EL
         jncucNmuEfCufVuEM9tbvhDkCn8BPiBsLyMp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=aF4XlVMznjCNHcmBdAQWNRBETHQ4CsTq9k/6mZofjYUoyxrOebPgYBCqJ2sNoO+3JO
         51Rnt4Jk6tfAvuwJu5BumfM2lcQrdSnxawrIMTZVXD82q3NvPTI3W/W9vp9L7W9xpG+K
         QnziSQbtRbQX9snVeg9u/ZCm4SG5hGG65+dqY=
Received: by 10.223.118.132 with SMTP id v4mr135178faq.87.1291942866421;
        Thu, 09 Dec 2010 17:01:06 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id y3sm738680fai.38.2010.12.09.17.01.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 17:01:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA10fO0020914;
	Fri, 10 Dec 2010 02:00:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA10PRp020904;
	Fri, 10 Dec 2010 02:00:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-16-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163373>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> die_error() is an immediate and abrupt action.  show_warning() more or less
> functions identically, except that the page generated doesn't use the
> gitweb header or footer (in case they are broken) and has an auto-refresh
> (10 seconds) built into it.

Why not use gitweb header/footer?  If they are broken, it should be
caught in git development.  If we don't se them, the show_warning()
output would look out of place.

> 
> This makes use of print_transient_header() which is also used in the
> 'Generating...' page.  Currently the only warning it throws is about
> the cache needing to be created.  If that fails it's a fatal error
> and we call die_error()

Why do you feel the need to single out this case giving it warning,
and single out this warning by showing warning page?

Nevertheless show_warning() _might_ be a good idea.

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/lib/cache.pl |   36 +++++++++++++++++++++++++++++++++---
>  1 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index 723ae9b..28e4240 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -25,9 +25,13 @@ sub cache_fetch {
>  	my $cacheTime = 0;
>  
>  	if(! -d $cachedir){
> -		print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";
> -		mkdir ("cache", 0755) || die "Cannot create cache dir - you will need to manually create";
> -		print "Cache directory created successfully\n";
> +		mkdir ("cache", 0755) || die_error(500, "Internal Server Error", "Cannot create cache dir () - you will need to manually create");
> +		show_warning(
> +				"<p>".
> +				"<strong>*** Warning ***:</strong> Caching enabled but cache directory did not exsist.  ($cachedir)<br/>/\n".

Minor nit: s/exsist/exist/

Don't you need to use esc_path() on $cachedir, 
using either

  ...did not exist.  (".esc_path($cachedir).")<br/>\n";

or using this trick

  ...did not exist.  (@{[esc_path($cachedir)]})<br/>\n";

> +				"Cache directory created successfully\n".
> +				"<p>"
> +				);
>  	}
>  
>  	$full_url = "$my_url?". $ENV{'QUERY_STRING'};
> @@ -119,6 +123,32 @@ sub print_transient_header {
>  	return;
>  }
>  
> +sub show_warning {
> +	$| = 1;

  +	local $| = 1;

$| is global variable, and otherwise you would turn autoflush for all
code, which would matter e.g. for FastCGI.

> +
> +	my $warning = esc_html(shift) || "Unknown Warning";
> +
> +	print_transient_header();
> +
> +	print <<EOF;
> +<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
> +<!-- git web w/caching interface version $version, (C) 2006-2010, John 'Warthog9' Hawley <warthog9\@kernel.org> -->
> +<!-- git core binaries version $git_version -->
> +<head>
> +<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>

$content_type is not defined here.

> +<meta name="generator" content="gitweb/$version git/$git_version"/>
> +<meta name="robots" content="index, nofollow"/>

It is "noindex, nofollow", isn't it?

> +<meta http-equiv="refresh" content="10"/>

Why 10 seconds?

> +<title>$title</title>

$title is not defined here.

> +</head>
> +<body>
> +$warning
> +</body>
> +</html>
> +EOF
> +	exit(0);

"exit(0)" and not "goto DONE_GITWEB", or "goto DONE_REQUEST"?

> +}
> +
>  sub isBinaryAction {
>  	my ($action) = @_;

Didn't you ran gitweb tests?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
