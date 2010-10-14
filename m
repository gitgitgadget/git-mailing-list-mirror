From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Wed, 13 Oct 2010 18:55:48 -0700
Message-ID: <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
References: <201010061823.47475.agruen@suse.de>
 <7vk4lv44os.fsf@alter.siamese.dyndns.org> <201010070103.17689.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Oct 14 03:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6D3E-0007Cs-Do
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 03:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab0JNBzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 21:55:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab0JNBzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 21:55:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72CAADE6B7;
	Wed, 13 Oct 2010 21:55:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=69yi9HjBmUtKBFidKgvIyZOrAD0=; b=ZU8c5cxsZEtvU/GFESSBjxP
	0KNbXCkG7tT4FOL1PQCxYTQQ36qGMNti4s0MzkRRwlXTpSvZFWLTE9yiuvbVpInP
	ClIY/YOi0hoiz8HhMYmhF2z6/EVxxp4kbi8vMIKHlYfLZ2217BTUbULJaIIX6Zu8
	6Xam3Q5ACh9PGHF2dVR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Z22KygUgBVHrJdWC8c/g41j3F4MAp18QA/im2JYM9lIqYGRNo
	jGJZdouQap3amonq3ApJA8oyw56URiPYrk3D5sHgXnkDCWzpM+6qi7M/QLufKVvu
	JgANEjcgjZYP2Omx4lsgMr2r+Efy1umAfDjwdVrutMLnr+rCpntIQh8BFg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43876DE6B5;
	Wed, 13 Oct 2010 21:55:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67D2FDE6B4; Wed, 13 Oct
 2010 21:55:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CB11848-D736-11DF-84A1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159014>

Andreas Gruenbacher <agruen@suse.de> writes:

>  The `a/` and `b/` filenames are the same unless rename/copy is
>  involved.  Especially, even for a creation or a deletion,
> -`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
> +`/dev/null` is _not_ used in place of the `a/` or `b/` filenames
> +for nonexisting files (unlike in the unified diff headers).

The description in the parentheses is wrong, unless you qualify whose
"unified diff headers" you are talking about.  For example:

 http://www.opengroup.org/onlinepubs/9699919799/utilities/diff.html#tag_20_34_10_07

does not mention anything about file creation/deletion events.  Perhaps
you are referring to cvs or svn output, but I think we can safely drop the
parenthesized part without losing clarity.

> @@ -37,18 +37,42 @@ the file that rename/copy produces, respectively.
>         similarity index <number>
>         dissimilarity index <number>
>         index <hash>..<hash> <mode>
> -
> -3.  TAB, LF, double quote and backslash characters in pathnames
> -    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
> -    If there is need for such substitution then the whole
> -    pathname is put in double quotes.
> -
> ++
> +File modes are printed as 6-digit octal numbers including the file type
> +and file permission bits.
> ++
> +Path names in extended headers do not include the `a/` and `b/` prefixes.
> ++
>  The similarity index is the percentage of unchanged lines, and
>  the dissimilarity index is the percentage of changed lines.  It
>  is a rounded down integer, followed by a percent sign.  The
>  similarity index value of 100% is thus reserved for two equal
>  files, while 100% dissimilarity means that no line from the old
>  file made it into the new one.
> ++
> +The index line includes the SHA-1 checksum before and after the change.
> +The <mode> is included if the file mode does not change; otherwise,
> +separate lines indicate the old and the new mode.
> +
> +3.  TAB, LF, double quote and backslash characters in pathnames
> +    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
> +    If there is need for such substitution then the whole
> +    pathname is put in double quotes.
> ++
> +Space characters in pathnames are _not_ quoted, neither in the "git
> +diff" header nor in extended header lines.

I am not sure if there is a particular need to spend an extra paragraph to
special case the SP [*1*].  On the other hand, we quote bytes with
high-bit set in \octal [*2*], unless core.quotepath is set to false, too,
which should probably be described here.


[References]

*1* 28fba29 (Do not quote SP., 2005-10-17)
*2* http://marc.info/?l=git&m=112927316408690&w=2
