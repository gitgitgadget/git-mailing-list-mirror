From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 5/5] gitweb: place links to parent directories in page header
Date: Mon, 30 Jan 2012 18:10:08 +0100
Message-ID: <201201301810.10072.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120130095252.GA6183@server.brlink.eu> <20120130115046.GE9267@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 18:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrujf-0006Wr-IM
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab2A3RJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:09:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37531 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2A3RJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:09:38 -0500
Received: by eaal13 with SMTP id l13so1187437eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0owkCZi9k82MAUelbHYL8vwiQmXgZgf7ClADPEDn4Aw=;
        b=O7+lKSXvAFIQvxRAgrMegR4DW9BTwrkAWf1z4iuVrZxglMnMATP7/sc6T4jcq/f75q
         bUS3SCR8fT/B4WE9JLf6ofnndB5o3M05ivskR4lMNblq+O0n2BSk+eNn39pRITUFHCtW
         8S3iPYOxD73yWaqEzk6RWuOrIqNqKL2dXEhAU=
Received: by 10.213.3.5 with SMTP id 5mr1722132ebl.91.1327943377374;
        Mon, 30 Jan 2012 09:09:37 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id o49sm20656018eei.0.2012.01.30.09.09.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 09:09:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120130115046.GE9267@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189377>

On Mon, 30 Jan 2012, Bernhard R. Link wrote:

> Change html page headers to not only link the project root and the
> currently selected project but also the directories in between using
> project_filter. (Allowing to jump to a list of all projects within
> that intermediate directory directly and making the project_filter
> feature visible to users).

Nice idea, nice description.
 
> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> ---
>  gitweb/gitweb.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index dfc79df..b54ddb9 100755
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

Nice code.

-- 
Jakub Narebski
Poland
