From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document escaping of special characters in gitignore
 files
Date: Wed, 05 Jan 2011 10:42:33 -0800
Message-ID: <7vwrmjchuu.fsf@alter.siamese.dyndns.org>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bruce Korb <bruce.korb@gmail.com>,
	avarab@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 19:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaYJv-0001rO-F4
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1AESmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 13:42:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1AESmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 13:42:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 614574E99;
	Wed,  5 Jan 2011 13:43:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=huZLBWU+CrJkMNqtk4c9+lRjaAo=; b=vS9fr/
	hbjxflLKjVmvXpTUyO1wYwLC9WtwOMMwEN5gkFokIk+9Cx0wFzt2WcOWtrNxwzCB
	0c8Q2aeqkE/2TJTDRrROmdg2Ni2rmWSRCcIKBGlOg1CBDR6tSvYbh32lIqA0YtJY
	vBdGyWYlY2MAvI5QDNGhZvDg05ivaS1MjkSXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DBDG3XTfPYqrAz4FPqWnCDTdzIH0+EFk
	rRsccYrR5m7GMN995iEviPTv14g3t8afYaYcUifqzlftYrJWtWakDB9/bANKrzRJ
	29rjBrPxiUpMnLfIDHhIg9cedY3usDE2tYwjHb6wa7Pdq/Ji9wGFUeO/4KNBQb7c
	v5OUZDEP34c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 208554E98;
	Wed,  5 Jan 2011 13:43:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF8204E93; Wed,  5 Jan 2011
 13:43:12 -0500 (EST)
In-Reply-To: <1294234732-20094-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed\,  5 Jan 2011 14\:38\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A98338FE-18FB-11E0-95FA-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164581>

Jakub Narebski <jnareb@gmail.com> writes:

> This patch was originally send 10 Sep 2010, but I guess it was lost
> because it appeared only deep in thread inside response, and not as
> well separated patch.  I have found about it when I got conflict
> merging current code.
>
> It applies on top of current 'master'.

Thanks.  A few questions before applying.

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 7dc2e8b..20abc20 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -68,6 +68,7 @@ Patterns have the following format:
>     for readability.
>  
>   - A line starting with # serves as a comment.
> +   Use `\#` for a literal # character starting filename.

Is a literal bs safe here?  You later use "{backslash}#" in this same
file, and it might make sense to do so here for the sake of source
readability, even if a literal bs is safe here---provided that
"{backslash}#" does not break here, of course.

> @@ -98,6 +99,12 @@ Patterns have the following format:
> ...
> + - You can escape special characters using backslash.
> +   For example, "{backslash}#*" matches files beginning in `#`
> ...

> diff --git a/templates/info--exclude b/templates/info--exclude
> index a5196d1..2ebaf0d 100644
> --- a/templates/info--exclude
> +++ b/templates/info--exclude
> @@ -4,3 +4,4 @@
>  # exclude patterns (uncomment them if you want to use them):
>  # *.[oa]
>  # *~
> +# \#*#

Do we need this?  Without explanation it is somewhat hard to realize that
this last line is also an example of a pattern that excludes any filename
that begins and ends with a pound.
