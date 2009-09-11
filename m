From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add documentation for mailinfo.scissors and
 '--no-scissors'
Date: Fri, 11 Sep 2009 00:19:06 -0700
Message-ID: <7veiqe0x05.fsf@alter.siamese.dyndns.org>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr> <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Sep 11 09:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm0Pn-0006xC-Dn
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 09:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbZIKHTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 03:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZIKHTR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 03:19:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbZIKHTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 03:19:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E21812E006;
	Fri, 11 Sep 2009 03:19:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eJv04v+rtT2yQkhQYj2xolaWLGo=; b=TYmmqG
	p4qCtVrNDTub3QUwgXI8JCau/7LBiE0wkYHpfu80TveRhRLRB/+owv/xNWTsmgS3
	6gAiwg6AkhsE5eZfdm+mUSvEQJ3Jy32G5oV6G+JwQ9l3lwwDalIJYXeGpMYp4RO3
	o2G5FwKDDw2Oz4krpyQ/GhYKCPzfV79acFO4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZAHlanEcnNUk+4KRoMQQrGiT4wZzBTnn
	Wl6o6aA1SdLphWIek5YqnDBYHQaXZULDPDv5x7A/KiQm1CYkRVrsgqllEIIOZM6L
	qnpfIhZJyioALxkGw0imys6DN2gOA6TJfp4Zet1vLCgfpZQ1rVPRnAD26I+UJLIn
	+zvIKnm3mas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B99592E005;
	Fri, 11 Sep 2009 03:19:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E05C2E004; Fri, 11 Sep
 2009 03:19:08 -0400 (EDT)
In-Reply-To: <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr> (Nicolas Sebrecht's message of "Fri\, 11 Sep 2009 02\:29\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6911EF50-9EA3-11DE-895B-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128180>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> +---no-scissors::
> +	Do not obey to a scissors line (see linkgit:git-mailinfo[1]).
> +

obey is v.t. so "do not obey a scissors line" would be grammatical; I
think "ignore scissors lines" would be better.

> +--no-scissors::
> +	Do not obey to a scissors line. This is only useful if mailinfo.scissors is
> +	enabled (see --scissors).

Ditto; also it is useful in general if you do not know which way it is
configured.  Saying "_only_" is misleading.

	Ignore scissors lines; useful for overriding mailinfo.scissors
	settings.

> diff --git a/git-am.sh b/git-am.sh
> index 26ffe70..f242d1a 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
>  u,utf8          recode into utf8 (default)
>  k,keep          pass -k flag to git-mailinfo
>  c,scissors      strip everything before a scissors line
> +no-scissors     don't obey to a scissors line (default)
>  whitespace=     pass it through git-apply
>  ignore-space-change pass it through git-apply
>  ignore-whitespace pass it through git-apply

Do we want it to allow --no-no-scissors?  I do not think this hunk is
necessary at all.
