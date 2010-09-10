From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: Make it possible to paginate projects
Date: Fri, 10 Sep 2010 12:10:24 -0700 (PDT)
Message-ID: <m3zkvpl8jf.fsf@localhost.localdomain>
References: <1284135442-10971-1-git-send-email-lkundrak@v3.sk>
	<1284135442-10971-2-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou8zY-0007pR-ON
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab0IJTK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 15:10:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64949 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0IJTK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:10:26 -0400
Received: by fxm16 with SMTP id 16so1991807fxm.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gBZsYmECI/xtwEL4C2LL8cDPn+f2c8T1ojUeIo2iPeQ=;
        b=VNRBk/emJ/ZoxM5k9dg49Csmak8Vh/PWstDors+v5CmloB7pEnp8uIJ1CyovkjTuby
         gOzMiRhQBtJ3s6BkHgcnzd5QEVOOWGefRTvOmUUqxOCV8NUqt2JRIsY8RiTaAo4+Bp9W
         wqOCH+dziZfEteiNIw8+yjQbVw/TgN2GQHOAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rtSFLbdnRgTGZ9htvyjP88sCwglIHH1OEMqqawB3+ECT/Fm9Rf56dgEGQGUXcmi4IY
         5xlV8ooZb7hmLWIee3mYg2foSdHVVWg7V6ap2Ft+KtA3nDBhqmIY0QV+1Lz0TmG4UfAV
         QHeiErLsRHCdwqv1TXX4otxxSVsMU514+MWFc=
Received: by 10.223.116.6 with SMTP id k6mr762394faq.49.1284145825062;
        Fri, 10 Sep 2010 12:10:25 -0700 (PDT)
Received: from localhost.localdomain (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id 10sm1529819fax.42.2010.09.10.12.10.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:10:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8AJA3rY020658;
	Fri, 10 Sep 2010 21:10:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8AJ9umB020652;
	Fri, 10 Sep 2010 21:09:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1284135442-10971-2-git-send-email-lkundrak@v3.sk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155955>

Lubomir Rintel <lkundrak@v3.sk> writes:

> This adds simple pagination (next and prev links), to project lists,
> analogous to what is done for commit history lists.

Lack signoff (see Documentation/SubmittingPatches).

> ---
>  gitweb/gitweb.perl |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a85e2f6..8dc7f29 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -255,6 +255,9 @@ our %highlight_ext = (
>  	map { $_ => 'xml' } qw(xhtml html htm),
>  );
>  
> +# Set this to non-zero to enable project list pagination
> +our $projects_per_page = 0;
> +

Good idea of being able to enable or disable pagination of projects
list.  

I am not sure though if this is the correct solution.  First,
pagination in all other places is hardcoded to 100 items per page;
IMHO for consistency it would be good to use the same page size
everywhere.

Second, perhaps instead of yet another global variable a better
solution would be non-verridable %feature, like 'pathinfo' or 'forks'
features?

>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -4613,9 +4616,19 @@ sub git_project_list_body {
>  	my @projects = fill_project_list_info($projlist, $check_forks);
>  
>  	$order ||= $default_projects_order;
> +	$page ||= 0;
> +	if ($projects_per_page) {
> +		$from = $page * $projects_per_page unless defined $from;
> +		$to = $from + $projects_per_page - 1 unless defined $to;
> +	}

Hmmm...

>  	$from = 0 unless defined $from;
>  	$to = $#projects if (!defined $to || $#projects < $to);
>  
> +	my $prev_link = $cgi->a({-href => href(-replay=>1, page=>$page-1),
> +		 -accesskey => "p", -title => "Alt-p"}, "prev") if ($page > 0);
> +	my $next_link = $cgi->a({-href => href(-replay=>1, page=>$page+1),
> +		 -accesskey => "n", -title => "Alt-n"}, "next") if ($#$projlist > $to);
> +

In other places we have 'first' &sdot; 'prev' &sdot; 'next'...

>  	my %order_info = (
>  		project => { key => 'path', type => 'str' },
>  		descr => { key => 'descr_long', type => 'str' },
> @@ -4709,6 +4722,19 @@ sub git_project_list_body {
>  		print "<td colspan=\"5\">$extra</td>\n" .
>  		      "</tr>\n";
>  	}
> +
> +	if ($prev_link or $next_link) {
> +		print "<tr>\n";
> +		if ($check_forks) {
> +			print "<td></td>\n";
> +		}
> +		print "<td colspan=\"5\">";
> +		print $prev_link if $prev_link;
> +		print " &sdot; " if $prev_link and $next_link;
> +		print $next_link if $next_link;
> +		print "</td>\n</tr>\n";
> +	}

... is there a reason to not use format_paging_nav() subroutine?

> +
>  	print "</table>\n";
>  }
>  
> -- 
> 1.7.2.1
> 

See also comments to next patch in series

-- 
Jakub Narebski
Poland
ShadeHawk on #git
