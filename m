From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: place links to parent directories in page header
Date: Sun, 29 Jan 2012 17:46:09 +0100
Message-ID: <201201291746.09967.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120129160615.GA13937@server.brlink.eu> <20120129161316.GD13937@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sun Jan 29 17:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrXsx-0002o1-IF
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 17:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab2A2Qpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 11:45:43 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50716 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2A2Qpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 11:45:42 -0500
Received: by eaal13 with SMTP id l13so844526eaa.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=qZZdAyr5hjOez6Rwu10QlYqBixbBpgN3+HOZ3zmfNWU=;
        b=bFFoAmwxHJGVQOjKlrTDw63UJVPYKZvyDVYnbgMIOX+1XvVz7xuo2KSi9P7HWjuHOk
         MCdILFD8n5T9ICF5tBqMaLnIEAzp3d0Zx9WUMwykVaoWlgRRVS5VYE3fUw9UcutJ/NFU
         NDlrFyENJnTQMR19Kmwop8Ka40X+sNK6veU1Y=
Received: by 10.213.15.15 with SMTP id i15mr13337eba.77.1327855541677;
        Sun, 29 Jan 2012 08:45:41 -0800 (PST)
Received: from [192.168.1.13] (abwg78.neoplus.adsl.tpnet.pl. [83.8.230.78])
        by mx.google.com with ESMTPS id n56sm60581500eeh.6.2012.01.29.08.45.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 08:45:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120129161316.GD13937@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189295>

On Sun, 29 Jan 2012, Bernhard R. Link wrote:

> Change html page headers to not only link the project root and the
> currently selected project but also the directories in between using
> project_filter.

Nice interface to the new feature... though it doesn't really address
the problem that gitweb homepage is slow to generate with large number
of projects.  Still, it is IMVHO a good improvement.
 
> Signed-off-by: Bernhard R. Link <brlink@debian.org>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f0e03d8..e2a9146 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3853,7 +3853,10 @@ sub print_nav_breadcrumbs {
>  
>  	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
>  	if (defined $project) {
> -		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
> +		my @dirname = split '/', $project;
> +		my $projectbasename = pop @dirname;
> +		print_nav_breadcrumbs_path(@dirname);
> +		print $cgi->a({-href => href(action=>"summary")}, esc_html($projectbasename));
>  		if (defined $action) {
>  			my $action_print = $action ;
>  			if (defined $opts{-action_extra}) {
> -- 

Nicely short with refactoring of print_nav_breadcrumbs_path() in 1/2!

-- 
Jakub Narebski
Poland
