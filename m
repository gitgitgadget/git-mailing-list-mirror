From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: linkify author/committer names with search
Date: Wed, 14 Oct 2009 02:13:36 -0700
Message-ID: <7v7huyfidb.fsf@alter.siamese.dyndns.org>
References: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxzwU-0004qZ-9j
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbZJNJOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757936AbZJNJOb
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:14:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757930AbZJNJOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:14:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A0077714F;
	Wed, 14 Oct 2009 05:13:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PVVptz0opjK/QhkrZheOw4bBdEE=; b=Sziy6KnMT7+BPhaiF/z9hsc
	9Vw27QjAgsFvSCrMiL192ryo3Uj3Ooqs0mkpiLoGruyTzkQPxbieg5FFQgwe3O91
	H4xDjLFuEU98Ezky+lE+ouNBst/p0pPVdmbOX6kcaf2JnO/+MOApqzReaT/x6qEM
	kJCmvBj73JBWxXO7EMME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uTD+QGj1kR0FsWh3HdWxVatf7rPWijLOpTMf8XCalhcpMY6gC
	wk1I8IL9IxVrcRcIdkoofXI9zPks7dhCOQzq54cZnQt5B1cgEvDuG8N4miH4ve+v
	8EdRjNtK0x8gXVTbOpsfQzawBK2Pq6budk3knAmKnrJpExZWs7uhDyspcg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25C3B77148;
	Wed, 14 Oct 2009 05:13:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5CCFF77141; Wed, 14 Oct 2009
 05:13:38 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFC444BE-B8A1-11DE-A537-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130268>

Stephen Boyd <bebarino@gmail.com> writes:

> It's nice to search for an author by merely clicking on their name in
> gitweb. This is usually faster than selecting the name, copying the
> selection, pasting it into the search box, selecting between
> author/committer and then hitting enter.
>
> Linkify the avatar icon in log/shortlog view because the icon is directly
> adjacent to the name and thus more related. The same is not true
> when in commit/tag view where the icon is farther away.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> This is on top of Giuseppe's fix esc_param patch.
>
>  gitweb/gitweb.css  |    1 +
>  gitweb/gitweb.perl |   21 ++++++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 8f68fe3..e2cd9d7 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -30,6 +30,7 @@ img.logo {
>  
>  img.avatar {
>  	vertical-align: middle;
> +	border-width: 0px;
>  }

Even though it _might_ be a good thing to do, this looks an unrelated
change,

>  div.page_header {
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4b21ad2..bdf1037 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1602,8 +1602,12 @@ sub format_author_html {
>  	my $co = shift;
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
>  	return "<$tag class=\"author\">" .
> -	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
> -	       $author . "</$tag>";
> +	       $cgi->a({-href => href(action=>"search", hash=>$hash,
> +			searchtext=>$co->{'author_name'},
> +			searchtype=>"author"), class=>"list"},
> +			git_get_avatar($co->{'author_email'}, -pad_after => 1) .
> +			$author) .
> +	       "</$tag>";
>  }
>  
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
> @@ -3372,10 +3376,13 @@ sub git_print_authorship {
>  	my $co = shift;
>  	my %opts = @_;
>  	my $tag = $opts{-tag} || 'div';
> +	my $author = $co->{'author_name'};
>  
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
>  	print "<$tag class=\"author_date\">" .
> -	      esc_html($co->{'author_name'}) .
> +	      $cgi->a({-href => href(action=>"search", searchtext=>$author,
> +		      searchtype=>"author"), class=>"list"},
> +		      esc_html($author)) .
>  	      " [$ad{'rfc2822'}";
>  	print_local_time(%ad) if ($opts{-localtime});
>  	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
> @@ -3394,8 +3401,12 @@ sub git_print_authorship_rows {
>  	@people = ('author', 'committer') unless @people;
>  	foreach my $who (@people) {
>  		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
> -		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
> -		      "<td rowspan=\"2\">" .
> +		print "<tr><td>$who</td><td>" .
> +		      $cgi->a({-href => href(action=>"search",
> +			       searchtext=>$co->{"${who}_name"},
> +			       searchtype=>$who), class=>"list"},
> +			       esc_html($co->{$who})) .
> +		      "</td><td rowspan=\"2\">" .
>  		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
>  		      "</td></tr>\n" .
>  		      "<tr>" .
> -- 
> 1.6.5.1.g75846.dirty
