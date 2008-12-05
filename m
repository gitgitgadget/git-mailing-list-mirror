From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 2/3] gitweb: Split git_project_list_body in two functions
Date: Fri, 5 Dec 2008 02:52:03 +0100
Message-ID: <200812050252.04298.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <87k5ag22ke.wl%seb@cine7.net> <87iqq022gz.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-1?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 02:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Psx-0003gW-JQ
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 02:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbYLEBwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 20:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYLEBwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 20:52:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:18752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYLEBwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 20:52:06 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3958431ugf.37
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=V83SNCp6GbeA8Kbgn1SK8YTSBYvYW9XFPKddwcNWyHc=;
        b=tvUHYZde1dOQW4v62kSxPJ952JzKzbeODeGKqAiZbhvvwUCCJOaOuPg3c6fvOaxiYq
         J/MLujzh+qzdmDVccInuURdpycj7ggllrJ1y9Yfggf8PtPC6pIQcLrkRPa62q1wTjh+f
         rZiJWUVTvt/ub+taFQrAHqASRZTuRkIjq+U3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=E0sxZqXbb8lfGkG8TE+Ae3L71yl//9JIHhxibDW4EN7Yfpu+6WcT25gdZTZ4ZYcm/b
         IfvZNQYT2vTinofq5R6s5RGJ1zVI3xeCsrRwD76xeWZRQCGCDtjb6UKn/Rz5VYe6LnWn
         f3JeYNdTzM10NeinIt81GYVdC5dNb+tH2tRx4=
Received: by 10.67.25.9 with SMTP id c9mr136035ugj.18.1228441924432;
        Thu, 04 Dec 2008 17:52:04 -0800 (PST)
Received: from ?192.168.1.11? (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id 24sm19900041ugf.36.2008.12.04.17.52.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 17:52:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87iqq022gz.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102386>

On Tue, 4 Dec 2008 at 01:44, S=E9bastien Cevey wrote:

> Extract the printing of project rows on the project page into a
> separate print_project_rows function. This makes it easier to reuse
> the code to print different subsets of the whole project list.

Err... it was not obvious for me that 'project rows' are rows of
projects list table, i.e. currently the body of projects list table.

But I think it is a good description.

>=20
> The row printing code is merely moved into a separate function, but
> note that $projects is passed as a reference now.
>=20
> Signed-off-by: Sebastien Cevey <seb@cine7.net>

Nicely done.

=46or what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>=20
> Boo, the diff is still quite scarier than it really should be...

Well, nothing short of blame -C would make it work; the issue is that
we split subroutine into two, extracting from the middle, but with
some common/similar header

  2        1
  1        1
  2        1
  2
  2   ->   2
  1        2
  1        2
  2        2
  2        2
           2

And diff is forward preferring, i.e. it finds match then second part
of split as add, rather than first first part of split as add then
match.
>=20
>  gitweb/gitweb.perl |  103 +++++++++++++++++++++++++++++-------------=
----------
>  1 files changed, 57 insertions(+), 46 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b31274c..a6bb702 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3972,59 +3972,19 @@ sub print_sort_th {
>  	}
>  }
> =20
> -sub git_project_list_body {
> +# print a row for each project in the given list, using the given
> +# range and extra display options
> +sub print_project_rows {
>  	# actually uses global variable $project
> -	my ($projlist, $order, $from, $to, $extra, $no_header) =3D @_;
> -
> -	my ($check_forks) =3D gitweb_check_feature('forks');
> -	my @projects =3D fill_project_list_info($projlist, $check_forks);
> +	my ($projects, $from, $to, $check_forks, $show_ctags) =3D @_;

I see that print_project_rows gets @$projects list already sorted, and
it passes explicitly $check_forks and $show_ctags from caller.

> =20
> -	$order ||=3D $default_projects_order;
>  	$from =3D 0 unless defined $from;
> -	$to =3D $#projects if (!defined $to || $#projects < $to);
> -
> -	my %order_info =3D (
> -		project =3D> { key =3D> 'path', type =3D> 'str' },
> -		descr =3D> { key =3D> 'descr_long', type =3D> 'str' },
> -		owner =3D> { key =3D> 'owner', type =3D> 'str' },
> -		age =3D> { key =3D> 'age', type =3D> 'num' }
> -	);
> -	my $oi =3D $order_info{$order};
> -	if ($oi->{'type'} eq 'str') {
> -		@projects =3D sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @pr=
ojects;
> -	} else {
> -		@projects =3D sort {$a->{$oi->{'key'}} <=3D> $b->{$oi->{'key'}}} @=
projects;
> -	}
> +	$to =3D $#$projects if (!defined $to || $#$projects < $to);
> =20
> -	my $show_ctags =3D gitweb_check_feature('ctags');
> -	if ($show_ctags) {
> -		my %ctags;
> -		foreach my $p (@projects) {
> -			foreach my $ct (keys %{$p->{'ctags'}}) {
> -				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};
> -			}
> -		}
> -		my $cloud =3D git_populate_project_tagcloud(\%ctags);
> -		print git_show_project_tagcloud($cloud, 64);
> -	}
> -
> -	print "<table class=3D\"project_list\">\n";
> -	unless ($no_header) {
> -		print "<tr>\n";
> -		if ($check_forks) {
> -			print "<th></th>\n";
> -		}
> -		print_sort_th('project', $order, 'Project');
> -		print_sort_th('descr', $order, 'Description');
> -		print_sort_th('owner', $order, 'Owner');
> -		print_sort_th('age', $order, 'Last Change');
> -		print "<th></th>\n" . # for links
> -		      "</tr>\n";
> -	}
>  	my $alternate =3D 1;
>  	my $tagfilter =3D $cgi->param('by_tag');
>  	for (my $i =3D $from; $i <=3D $to; $i++) {
> -		my $pr =3D $projects[$i];
> +		my $pr =3D $projects->[$i];
> =20
>  		next if $tagfilter and $show_ctags and not grep { lc $_ eq lc $tag=
filter } keys %{$pr->{'ctags'}};
>  		next if $searchtext and not $pr->{'path'} =3D~ /$searchtext/
> @@ -4068,6 +4028,57 @@ sub git_project_list_body {
>  		      "</td>\n" .
>  		      "</tr>\n";
>  	}
> +}
> +
> +sub git_project_list_body {
> +	my ($projlist, $order, $from, $to, $extra, $no_header) =3D @_;
> +
> +	my ($check_forks) =3D gitweb_check_feature('forks');
> +	my @projects =3D fill_project_list_info($projlist, $check_forks);
> +
> +	$order ||=3D $default_projects_order;
> +
> +	my %order_info =3D (
> +		project =3D> { key =3D> 'path', type =3D> 'str' },
> +		descr =3D> { key =3D> 'descr_long', type =3D> 'str' },
> +		owner =3D> { key =3D> 'owner', type =3D> 'str' },
> +		age =3D> { key =3D> 'age', type =3D> 'num' }
> +	);
> +	my $oi =3D $order_info{$order};
> +	if ($oi->{'type'} eq 'str') {
> +		@projects =3D sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @pr=
ojects;
> +	} else {
> +		@projects =3D sort {$a->{$oi->{'key'}} <=3D> $b->{$oi->{'key'}}} @=
projects;
> +	}
> +
> +	my $show_ctags =3D gitweb_check_feature('ctags');
> +	if ($show_ctags) {
> +		my %ctags;
> +		foreach my $p (@projects) {
> +			foreach my $ct (keys %{$p->{'ctags'}}) {
> +				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};
> +			}
> +		}
> +		my $cloud =3D git_populate_project_tagcloud(\%ctags);
> +		print git_show_project_tagcloud($cloud, 64);
> +	}
> +
> +	print "<table class=3D\"project_list\">\n";
> +	unless ($no_header) {
> +		print "<tr>\n";
> +		if ($check_forks) {
> +			print "<th></th>\n";
> +		}
> +		print_sort_th('project', $order, 'Project');
> +		print_sort_th('descr', $order, 'Description');
> +		print_sort_th('owner', $order, 'Owner');
> +		print_sort_th('age', $order, 'Last Change');
> +		print "<th></th>\n" . # for links
> +		      "</tr>\n";
> +	}
> +
> +	print_project_rows(\@projects, $from, $to, $check_forks, $show_ctag=
s);
> +
>  	if (defined $extra) {
>  		print "<tr>\n";
>  		if ($check_forks) {
> --=20
> 1.5.6.5
>=20
>=20

--=20
Jakub Narebski
Poland
