From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update gitweb.perl to current CGI.pm API
Date: Thu, 16 Oct 2014 12:36:54 -0700
Message-ID: <xmqqa94vu7qh.fsf@gitster.dls.corp.google.com>
References: <87lhogzeq0.fsf@placard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Roland Mas <lolando@debian.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 21:37:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeqrC-0005ng-BI
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 21:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbaJPThA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 15:37:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752939AbaJPTg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 15:36:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CAA017B91;
	Thu, 16 Oct 2014 15:36:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WTUd+C2bH42sGGOPBQm18NFa+JY=; b=lcfwsv
	clQClAIQzBx/t5CvV5ELltU1JzxZH4fflEj4LeiGzqJY6Qc9xa7NICNo09u/Q4/T
	N3tsnsLKSNCGLERhAZL/sx80LShbrxjyBjzG9AAs7+Vqisdwu+0JV5rWc5bY10+e
	jTxkBv5l9lCtjJU5EF7XSknIM0I9/eeWR8O/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bvU/Hh4sdNDSXi97iH+R/J6i0FtqAEDS
	aIbgpCOSTSqr9clUHKKIRgyQA/x0oI3zSglUm+JSM/5yPmngVXgtsLXkqQMGsVrM
	l+Sl0Bk+rLZLzToGUJOVrSxdCJhJ/O8XefDc5UF94ogBbenRT53QJ1mBKPBC4V1S
	1OVVS/SlZqI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F0BF17B90;
	Thu, 16 Oct 2014 15:36:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC22B17B8E;
	Thu, 16 Oct 2014 15:36:55 -0400 (EDT)
In-Reply-To: <87lhogzeq0.fsf@placard.fr.eu.org> (Roland Mas's message of "Thu,
	16 Oct 2014 08:54:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C981039C-556B-11E4-A98A-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks sensible to me; Jakub, ack?

Roland Mas <lolando@debian.org> writes:

> Hi all,
>
>   This simple two-line patch fixes a bug that makes gitweb unusable on
> systems where the installed CGI.pm is version 4.04 or later (such as on
> Debian unstable).  That version removed the startform method, which had
> previously been deprecated in favour of start_form since 2009.
>
>   I don't have any specific tests for that change, but it does help
> fixing the testsuite of FusionForge (which includes a test of its Git
> plugin, involving gitweb).
>
>   For reference, this is Debian bug #765525 (http://bugs.debian.org/765525).
>
>   (I'm not subscribed to the git@vger mailing-list; please Cc me on
> replies.)
>
>   Thanks,
>
> Roland.
>
> From 1b74cfb8568927a307f165e428455789398f6d61 Mon Sep 17 00:00:00 2001
> From: Roland Mas <lolando@debian.org>
> Date: Thu, 16 Oct 2014 00:05:25 +0200
> Subject: [PATCH] Update gitweb.perl to current CGI.pm API
>
> CGI.pm 4.04 removed the startform method, which had previously been
> deprecated in favour of start_form.  Updated gitweb.perl accordingly.
>
> Signed-off-by: Roland Mas <lolando@debian.org>
> ---
>  gitweb/gitweb.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a9f57d6..ccf7516 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4100,7 +4100,7 @@ sub print_search_form {
>  	if ($use_pathinfo) {
>  		$action .= "/".esc_url($project);
>  	}
> -	print $cgi->startform(-method => "get", -action => $action) .
> +	print $cgi->start_form(-method => "get", -action => $action) .
>  	      "<div class=\"search\">\n" .
>  	      (!$use_pathinfo &&
>  	      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
> @@ -5510,7 +5510,7 @@ sub git_project_search_form {
>  	}
>  
>  	print "<div class=\"projsearch\">\n";
> -	print $cgi->startform(-method => 'get', -action => $my_uri) .
> +	print $cgi->start_form(-method => 'get', -action => $my_uri) .
>  	      $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
>  	print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
>  		if (defined $project_filter);
