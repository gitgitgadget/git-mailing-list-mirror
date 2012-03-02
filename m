From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (bugfix)] gitweb: Fix passing parameters to
 git_project_search_form
Date: Fri, 02 Mar 2012 15:55:22 -0800
Message-ID: <7v1upablsl.fsf@alter.siamese.dyndns.org>
References: <1330728601-27124-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 00:56:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3cKL-0004zM-0L
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 00:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965604Ab2CBXz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 18:55:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107Ab2CBXzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 18:55:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8162763E1;
	Fri,  2 Mar 2012 18:55:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8Jxit2AbiSltM7wcuETFqTuj1w=; b=sysDWY
	vESZ0lGtiVUWSWzACzk+7Wt1zAjZNOY9yBGiCufUMalDBnOzOYNY3C2fhy8sNaVK
	ZK3nac8Yfh8DBb7e+0KhRvC1qqzjMsZE+f/P4iOMY2oYCHd3ENoN9sWbE6tVnlcX
	J48CaWkI2kGtenZWetvZHHH1XJwuKFUFk4j9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=We+0ZxvsQATk00mZSoqx//irEDP5YnPp
	AuK/JTp+fFn6KmkFSrH6l7gZw7KKYqDRLO/u0+CQobjeoNG/cvLpmgLX0G1jhdwF
	NCSAj8YBWsSRwbdxBkX+3DrVoCHNPjjlwU4y8yCM2SIqAIuLcIZ/cp12vZjliiJG
	1bkXpMNHwck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 784C463E0;
	Fri,  2 Mar 2012 18:55:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D3E163DF; Fri,  2 Mar 2012
 18:55:23 -0500 (EST)
In-Reply-To: <1330728601-27124-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Fri, 2 Mar 2012 23:50:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D627072-64C3-11E1-87D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192073>

Jakub Narebski <jnareb@gmail.com> writes:

> The git_project_search_form() subroutine, introduced in a1e1b2d
> (gitweb: improve usability of projects search form, 2012-01-31) didn't
> get its arguments from caller correctly.  Gitweb worked correctly
> thanks to sticky-ness of form fields in CGI.pm... but it make UTF-8
> fix for project search not working.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Brown paper bug (a1e1b2d is in master).  I am extremly sorry about that.

Heh, mistakes happen.  Thanks for taking care of this.

>
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7398be1..e2e6a73 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5263,7 +5263,7 @@ sub git_patchset_body {
>  # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
>  
>  sub git_project_search_form {
> -	my ($searchtext, $search_use_regexp);
> +	my ($searchtext, $search_use_regexp) = @_;
>  
>  	my $limit = '';
>  	if ($project_filter) {
