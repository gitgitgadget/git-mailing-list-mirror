From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] contrib/subtree: Add --unannotate
Date: Tue, 08 Jan 2013 10:45:17 -0800
Message-ID: <7vehhvecoy.fsf@alter.siamese.dyndns.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
 <1357646997-28675-4-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TseBC-000060-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab3AHSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:45:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756752Ab3AHSpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:45:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27BCCAA25;
	Tue,  8 Jan 2013 13:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4z82y8j+x5DLGsmzvx0Yushiha0=; b=fkqqgI
	1Za2mnczo+y5gBa6p/9LtHgx+MrAmIVJlLOiF9BedAlKELHRSltzdzGvvGZPeVw9
	BHxQpRjYLy+ZJlKu1PbtLPEZaGqTKztgKCveek21Rk0X5J8hJyAGpuen2FO0C9KD
	7d7eMEsIG3JB4AHI1Fn/C4P1MAT+FjpGrzzZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofX6Fm/9os1LPnQdzK3uoJYtNN0ZZ4lN
	glR+IxgtwfnF3fOOG6eHXyoC9ZRNEEPjPFIGA3olRr4UsceNDU2D+QoeQFnJ5YTC
	JNrFbx6M15/JddfVH/YPsImzAp5d4y9DR4aC6l3f95LAZZZbdSo4nkDfQKxMSx9Q
	YMNQznrYd/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C856AA23;
	Tue,  8 Jan 2013 13:45:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8033AAA22; Tue,  8 Jan 2013
 13:45:18 -0500 (EST)
In-Reply-To: <1357646997-28675-4-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Tue, 8 Jan 2013 06:09:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C8199AC-59C3-11E2-8F86-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212994>

"David A. Greene" <greened@obbligato.org> writes:

> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index c5bce41..75aa690 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -198,6 +198,21 @@ OPTIONS FOR split
>  	git subtree tries to make it work anyway, particularly
>  	if you use --rejoin, but it may not always be effective.
>  
> +--unannotate=<annotation>::
> +	This option is only valid for the split command.
> +
> +	When generating synthetic history, try to remove the prefix
> +	<annotation> from each commit message (using bash's "strip
> +	shortest match from beginning" command, which supports
> +	globbing).  This makes sense if you format library commits
> +	like "library: Change something or other" when you're working
> +	in your project's repository, but you want to remove this
> +	prefix when pushing back to the library's upstream repository.
> +	(In this case --unannotate='*: ' would work well.)
> +	
> +	Like --annotate,  you need to use the same <annotation>
> +	whenever you split, or you may run into problems.

I think this paragraph inherits existing breakage from the beginning
of time, but I do not think the above will format the second and
subsequent paragraphs correctly.

I've applied all seven patches in the series with minor fix-ups, and
will merge it to 'pu'.

Thanks.
