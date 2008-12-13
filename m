From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on pathinfo-style project URLs
Date: Sat, 13 Dec 2008 13:47:46 -0800 (PST)
Message-ID: <m3tz97g329.fsf@localhost.localdomain>
References: <1229195421.3943.8.camel@mattlaptop2.local>
	<1229202689.31181.1.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 22:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBcMI-0005qn-Am
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 22:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbYLMVrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYLMVrv
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 16:47:51 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:41028 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYLMVru (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 16:47:50 -0500
Received: by ewy10 with SMTP id 10so2357111ewy.13
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ojmjL+OxY6mpfiUfirU0kSbhflEfE78fO7P7TJKlZaU=;
        b=ssKXuKC41L6l4Q6zWQU3Y79C8lJrSH/MaWq59NfFdY/D/j3RkcciBNAPZA2PDVCHBk
         /WiU41xBnZ+JSRqvCzj8ATH8senYF2fCVo3hwPyA9BofuBoG5IH5G6b+gCFAh/jJB60X
         wrx5veAcBv9cT8FOnnMjmZJ4JUqJWXNafo6AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fUOXCD28Gh1g4pOuXhUr5QZy1YroFS1K157xnf/Mpzz0ji6GU/RU9nnc94GXZezax0
         KmnsFREv5PPaQKiTTHimDPcXqg9xp1T6FMuJhCbB8Zbn1sFE1hDl30d8eTv9rzD41ShS
         d7Ssrr6GtE2u+SjrOTGZbqbKuBchtSwIy1Zaw=
Received: by 10.210.52.15 with SMTP id z15mr2950573ebz.128.1229204867355;
        Sat, 13 Dec 2008 13:47:47 -0800 (PST)
Received: from localhost.localdomain (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id 5sm661186eyh.47.2008.12.13.13.47.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 13:47:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBDLliHR011526;
	Sat, 13 Dec 2008 22:47:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBDLlgof011523;
	Sat, 13 Dec 2008 22:47:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1229202689.31181.1.camel@mattlaptop2.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103023>

Matt McCutchen <matt@mattmccutchen.net> writes:

> My Web site uses pathinfo mode and some rewrite magic to show the gitweb
> interface at the URL of the real repository directory (which users also
> pull from).  In this case, it's desirable to end generated links to the
> project in a trailing slash so the Web server doesn't have to redirect
> the client to add the slash.  This patch adds a second element to the
> "pathinfo" feature configuration to control the trailing slash.
> 
> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>

Did you check that it does not confuse gitweb if filename parameter is
passed using pathinfo?  Gitweb used to rely on final '/' to
distinguish directory pathnames from ordinary pathnames, but I think
currently thanks to the fact that gitweb now embeds action in pathinfo
URL, and does not need to guess type, it is not an issue.

Or only project URLs (i.e. only with project parameter, i.e. only
"http://git.example.com/project.git/" but not other path_info links)
have trailing slash added?

Errr... I see that it adds trailing slash only for project-only
path_info links, but the commit message was not entirely clear for me.

(CC-ed author of path_info enhancements, Giuseppe Bilotta)

> ---
> Resending with a sign-off.

Thanks.

>  gitweb/gitweb.perl |   28 ++++++++++++++++++++++------
>  1 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6eb370d..86511cf 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -270,6 +270,11 @@ our %feature = (
>  	# $feature{'pathinfo'}{'default'} = [1];
>  	# Project specific override is not supported.
>  
> +	# If you want a trailing slash on the project path (because, for
> +	# example, you have a real directory at that URL and are using
> +	# some rewrite magic to invoke gitweb), then set:
> +	# $feature{'pathinfo'}{'default'} = [1, 1];
> +

Are any disadvantages to having it always enabled?

BTW. encoding data in position in array feels a bit hacky to me, but
I guess that is the limitation of current %feature design, with
'default' having to be array (reference).

>  	# Note that you will need to change the default location of CSS,
>  	# favicon, logo and possibly other files to an absolute URL. Also,
>  	# if gitweb.cgi serves as your indexfile, you will need to force
> @@ -829,8 +834,8 @@ sub href (%) {
>  		}
>  	}
>  
> -	my $use_pathinfo = gitweb_check_feature('pathinfo');
> -	if ($use_pathinfo) {
> +	my @use_pathinfo = gitweb_get_feature('pathinfo');

Why not name those variables for better readability?

+       my ($use_pathinfo, $trailing_slash) = gitweb_get_feature('pathinfo');

> +	if ($use_pathinfo[0]) {
>  		# try to put as many parameters as possible in PATH_INFO:
>  		#   - project name
>  		#   - action
> @@ -845,7 +850,12 @@ sub href (%) {
>  		$href =~ s,/$,,;
>  
>  		# Then add the project name, if present
> -		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
> +		my $proj_href = undef;
> +		if (defined $params{'project'}) {
> +			$href .= "/".esc_url($params{'project'});
> +			# Save for trailing-slash check below.
> +			$proj_href = $href;
> +		}
>  		delete $params{'project'};
>  
>  		# since we destructively absorb parameters, we keep this
> @@ -903,6 +913,10 @@ sub href (%) {
>  			$href .= $known_snapshot_formats{$fmt}{'suffix'};
>  			delete $params{'snapshot_format'};
>  		}
> +
> +		# If requested in the configuration, add a trailing slash to a URL that
> +		# has nothing appended after the project path.
> +		$href .= '/' if ($use_pathinfo[1] && defined $proj_href && $href eq $proj_href);
>  	}

The check _feels_ inefficient.  I think (but feel free to disagree) that
it would be better to use something like $project_pathinfo, set it
when adding project as pathinfo, and unset if we add anything else as
pathinfo.

>  
>  	# now encode the parameters explicitly
> @@ -2987,13 +3001,15 @@ EOF
>  			$search_hash = "HEAD";
>  		}
>  		my $action = $my_uri;
> -		my $use_pathinfo = gitweb_check_feature('pathinfo');
> -		if ($use_pathinfo) {
> +		my @use_pathinfo = gitweb_get_feature('pathinfo');

Same comment as above: better named variable instead of relying on
position in array.

> +		if ($use_pathinfo[0]) {
>  			$action .= "/".esc_url($project);
> +			# Add a trailing slash if requested in the configuration.
> +			$action .= '/' if ($use_pathinfo[1]);

Hmmm... let me check something... you rely on the fact that $project
doesn't end with slash, while I think (but please check it) that it
can end with slash if it is provided by CGI query.

>  		}
>  		print $cgi->startform(-method => "get", -action => $action) .
>  		      "<div class=\"search\">\n" .
> -		      (!$use_pathinfo &&
> +		      (!$use_pathinfo[0] &&
>  		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
>  		      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
>  		      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
> -- 
> 1.6.1.rc2.27.gc7114
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
