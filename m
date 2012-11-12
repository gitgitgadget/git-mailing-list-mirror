From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re:gitweb: add readme to overview page
Date: Mon, 12 Nov 2012 09:44:18 -0800
Message-ID: <7vip9ak971.fsf@alter.siamese.dyndns.org>
References: <1352652039-31453-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy3m-0005r0-Jn
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab2KLRoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:44:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:44:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D89194BC;
	Mon, 12 Nov 2012 12:44:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=78Ax0aNnNNfaV0j06ZA8sqe4Tao=; b=vfGeBxpN8+kwo/28dzxT
	CQhOAUDkMEDzuKv1pMOHrNLh31xZQc4B8ndNetiIONJVCHrrLQGQRBSROYPPBGak
	mihnHLwgs7sWvGXY2vptPtkJC7e+5q06y09mfbYkEk+hl3+dSjULScoP6AJZNyBd
	pMJlo1mkKvAf2N9Ye3klkKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cjzfwXL7DC9QCuSG46PvC1hrmyjPvPAw+1Qm9NhnTF/N/B
	Twd7zHjCA0wHVInyzd2DkuAp2ZMueju9Q3F8VeeJnDeDFy0d30fBXE1XvYSWgN+r
	1arhaJvvDhvwauTkoCZO+5dZJ2RL7twFnO67p9bZfli5ftMeOu37WFgGLbZw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64BDB94BB;
	Mon, 12 Nov 2012 12:44:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB10B94B6; Mon, 12 Nov 2012
 12:44:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 962B69D8-2CF0-11E2-A7A3-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209498>

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> In this version of the patch the formatting has been corrected.
>
> Warnings for double / in filenames are avoided.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> ---

The above is *not* a proper log message.

Those of us who are reading the messages on the list would know that
this is a replacement for your earlier

    Message-ID: <1352647962-21910-1-git-send-email-xypron.glpk@gmx.de>

where it has more proper description of the change, but because
nobody will be applying that earlier one to the history (instead,
you would want this version to be applied), the description is lost
in the history.

>  gitweb/gitweb.perl |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 10ed9e5..699ffac 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6369,6 +6369,18 @@ sub git_project_list {
>  	}
>  
>  	git_project_search_form($searchtext, $search_use_regexp);
> +	# If XSS prevention is on, we don't include README.html.
> +	# TODO: Allow a readme in some safe format.
> +	my $path = "";
> +	if (defined $project_filter) {
> +		$path = "/$project_filter";
> +	}
> +	if (!$prevent_xss && -s "$projectroot$path/README.html") {
> +		print "<div class=\"title\">readme</div>\n" .
> +			"<div class=\"readme\">\n";
> +		insert_file("$projectroot$path/README.html");
> +		print "\n</div>\n"; # class="readme"
> +	}
>  	git_project_list_body(\@list, $order);
>  	git_footer_html();
>  }
