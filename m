From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch doc: escape asterisk in --tags paragraph
Date: Fri, 07 Jun 2013 07:47:19 -0700
Message-ID: <7vppvyugeg.fsf@alter.siamese.dyndns.org>
References: <1370604694-2438-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 16:47:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukxws-000206-Op
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 16:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab3FGOrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 10:47:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab3FGOrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 10:47:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BBBC25D91;
	Fri,  7 Jun 2013 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L6cWidRu1oC4hFEp7aux3o1Vb1Q=; b=syCsqJ
	1qpRybfJWxpvijOgyGNCVvIYwOcVLWXbk1QYOfFbbgj2sey0RhH3xpnm6k8ezJsY
	cJ/lKtBu0HPVHZXj1O+c/gzIabU+dhIMR7R8cL5+OB53NmSeB6lsIzgBtNd189jY
	vQaupVB37tIfQXM+U7zPfo/SsFYnaLMPVVL2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NswyEpgqy8CR+OiKLyKn0+edZEjj/P0T
	citGAIks2bittHeJXx5Z1rCcMOP4ngsg6FWEypWrBCGdRTP5z+5QJIB2IbdZQ2rl
	h/0ZCuha2Ftus7G+5Q6uPQNvUGpK9k/rp3no2h/TaS4gJqlCC1mfeQObT9osEfZ7
	ncGnBIju/AY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40ACD25D8C;
	Fri,  7 Jun 2013 14:47:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B27825D8B;
	Fri,  7 Jun 2013 14:47:20 +0000 (UTC)
In-Reply-To: <1370604694-2438-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 7 Jun 2013 17:01:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 282F3B2E-CF81-11E2-BE91-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226634>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, the paragraph corresponding to the --tags option in
> git-fetch(1) looks like:
>
>   -t, --tags
>       This is a short-hand for giving "refs/tags/:refs/tags/" refspec
>                                                  ^^^^^^^^^^^
> 						 this is in bold
>
> This happens because the corresponding text in fetch-options.txt is
> "refs/tags/*:refs/tags/*"; asciidoc renders the text between the two
> asterisks in bold.  Escape the first asterisk, correcting the text.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Candidate for maint?

The issue certainly is real and needs a fix for maint.  Your
solution I am not sure about.

  $ git grep '\\\*' -- Documentation/\*.txt

shows only two meaningful hits (git-rm.txt and git-svn.txt);
everybody else uses

$ git grep '{asterisk}' -- Documentation/\*.txt

and the one you spotted in fetch-options.txt is very similar to the
one appears in git-pull.txt, I think.


>  Documentation/fetch-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 9cb6496..5f68149 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -61,7 +61,7 @@ endif::git-pull[]
>  ifndef::git-pull[]
>  -t::
>  --tags::
> -	This is a short-hand for giving "refs/tags/*:refs/tags/*"
> +	This is a short-hand for giving "refs/tags/\*:refs/tags/*"
>  	refspec from the command line, to ask all tags to be fetched
>  	and stored locally.  Because this acts as an explicit
>  	refspec, the default refspecs (configured with the
