From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 13 Dec 2008 13:53:26 -0800 (PST)
Message-ID: <m3prjvg2st.fsf@localhost.localdomain>
References: <1229203014.31181.7.camel@mattlaptop2.local>
Mime-Version: 1.0
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 22:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBcRj-0007VR-QL
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 22:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYLMVxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 16:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbYLMVxa
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 16:53:30 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:53231 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYLMVx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 16:53:29 -0500
Received: by ewy10 with SMTP id 10so2358489ewy.13
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version;
        bh=+gqCOHnklqrjo7Gn2EQY5U2Pm87IMdUU3Meezb9XBx4=;
        b=pXWHZizpJflMj0xju/MR+w9zEbZY6qpS6Yrs09stzmQI1875AaHJSWfg7GWMSkOSvn
         YTB+XxI8qLyA+tRSUJYFykbItqCf3Ovg6e42KXO/NtUUhJSJ4XLxtNGLtTnsZGeHL73p
         Kgchjh+HINR9L6J0mQuNIhV3muhX0MtR7zYKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version;
        b=Y4r/cxTp1Qxf0PDsq6d3PRWtrDk9PYcwNrdYG1bRtuncMdqG7fK8qhRyAJwgZwtrTu
         7thrWtWsGC4a3Y0LWnP3mAJ+e8RDn9bzV5aIOc7GZufIlRL9Brjv4JIiCoinf51XwM7s
         h88C7I+Lx4zbJYZLXwcLX2rEyrCOhq4HHsxu8=
Received: by 10.67.116.7 with SMTP id t7mr777886ugm.63.1229205207348;
        Sat, 13 Dec 2008 13:53:27 -0800 (PST)
Received: from localhost.localdomain (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id 19sm2311800ugl.12.2008.12.13.13.53.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 13:53:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBDLrONd011603;
	Sat, 13 Dec 2008 22:53:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBDLrMK7011600;
	Sat, 13 Dec 2008 22:53:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1229203014.31181.7.camel@mattlaptop2.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103025>

Matt McCutchen <matt@mattmccutchen.net> writes:

CC-ed Petr Baudis, author of forks support in gitweb.

> git_get_projects_list excludes forks in order to unclutter the main
> project list, but this caused the strict_export check, which also relies
> on git_get_project_list, to incorrectly fail for forks.  This patch adds
> an argument so git_get_projects_list knows when it is being called for a
> strict_export check (as opposed to a user-visible project list) and
> doesn't exclude the forks.
> 
> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>

Looks good for me.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 86511cf..5357bcc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1144,7 +1144,8 @@ sub untabify {
>  
>  sub project_in_list {
>  	my $project = shift;
> -	my @list = git_get_projects_list();
> +	# Tell git_get_projects_list to include forks.
> +	my @list = git_get_projects_list(undef, 1);
>  	return @list && scalar(grep { $_->{'path'} eq $project } @list);
>  }
>  
> @@ -2128,13 +2129,13 @@ sub git_get_project_url_list {
>  }
>  
>  sub git_get_projects_list {
> -	my ($filter) = @_;
> +	my ($filter, $for_strict_export) = @_;
>  	my @list;
>  
>  	$filter ||= '';
>  	$filter =~ s/\.git$//;
>  
> -	my $check_forks = gitweb_check_feature('forks');
> +	my $check_forks = !$for_strict_export && gitweb_check_feature('forks');
>  
>  	if (-d $projects_list) {
>  		# search in directory
> -- 
> 1.6.1.rc2.27.gc7114
> 
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
