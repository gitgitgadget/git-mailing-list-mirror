From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve "move the whole tree into a subdirectory"
 example.
Date: Tue, 20 Jul 2010 22:28:35 -0700
Message-ID: <7vk4opjtdo.fsf@alter.siamese.dyndns.org>
References: <1279574238-16649-1-git-send-email-ville.skytta@iki.fi>
 <1279574238-16649-2-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jul 21 07:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObRrQ-00026S-Vh
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 07:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0GUF2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 01:28:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0GUF2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 01:28:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A96B3C4292;
	Wed, 21 Jul 2010 01:28:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JcL5IGZcp6oz
	n7VE+hLL0IVB3Og=; b=vHfBwyw9zaK+0Hzmxq0BPHxQi7U8IssfMfrIRyOEDFe4
	9FMGuhW+H2xaBXAwBm5xsNddnkfpo2xqR0EbtH7KbtULWQf67Afs0JZ5tVK5YwhW
	mpZlUigI7UgkcI7Wps0TAIwFDvNb2s1FQkWiVR9Y9w2Do2fwnkt5j+F9gASQInU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iLDTf7
	VnlhhaJpqOd1tS7YN8f9ULEbBv3GIkbdkcYFWxuKDkPyt75pMIa+r0PG5IcikpAB
	hFn7VCai0nrekCD5omwLX8TBf3/xRKfKpasj0eoR+pmxI6+XuMEWBHSvUgwSfiVf
	aF5xNmVnXfaJ8v0X1xsshEFhITMXvHig+5tzE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D6AC428F;
	Wed, 21 Jul 2010 01:28:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE19EC428D; Wed, 21 Jul
 2010 01:28:37 -0400 (EDT)
In-Reply-To: <1279574238-16649-2-git-send-email-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?= message of "Tue\, 20 Jul 2010 00\:17\:18 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2108652-9488-11DF-B1FF-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151389>

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> Using "/" as the sed substitution delimiter is less likely to clash
> with desired subdirectory names than "-".

Sign-off?

The standard substitution in a case like this where you want to avoid
using "/" is "|", not "-".

> ---
>  Documentation/git-filter-branch.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-=
filter-branch.txt
> index 020028c..a90e2dd 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -354,11 +354,12 @@ git filter-branch ... C..H --not D
>  git filter-branch ... D..H --not C
>  ----------------------------------------
> =20
> -To move the whole tree into a subdirectory, or remove it from there:
> +To move the whole tree into a subdirectory named newsubdir, or remov=
e
> +it from there:
> =20
>  ---------------------------------------------------------------
>  git filter-branch --index-filter \
> -	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
> +	'git ls-files -s | sed "s/\t\"*/&newsubdir\//" |
>  		GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
>  			git update-index --index-info &&
>  	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
> --=20
> 1.7.1.1
