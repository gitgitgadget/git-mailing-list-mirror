From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/5] tag --exclude option
Date: Tue, 21 Feb 2012 22:33:29 -0800
Message-ID: <7vhayjbcna.fsf@alter.siamese.dyndns.org>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-4-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 07:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S05lo-0007b0-DI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 07:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab2BVGdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 01:33:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab2BVGdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 01:33:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A3B4DCE;
	Wed, 22 Feb 2012 01:33:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=iiIqY3DPAq6s/MB9F1eoGlJbzOI=; b=mFsDT15RECbKt1MEQhIE
	2LapT0usJnsKga+zHW5b/M6JjuWuy8q1nPzqKq6Yr+VF+wz+qoisSjZJIUqILeCU
	pHVSqKHsCJAJwNnKLfKBqxRV8aqgoN6vsaIowf+DeBIm6Lc11apnVcxsmTKQ0WB+
	+r/OpreGg7O0sDa865XGNu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SMTNSeaxR92WL4oqRn+r4mrvEO+zunSquDbxenhkthQ4Xh
	EJmrCcgQcOzfiE7F8+kKhJzy6xu/Li/S9W54CjFfIOOCz3eRbwXmKDIxJGAuR9cK
	3DcfaqIfe/BBw2/RDB0An7KxzPsJt7R1lnFNiWeB9AR4LvIxkDccpDGlG1b2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D31B4DCD;
	Wed, 22 Feb 2012 01:33:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96BCC4DCC; Wed, 22 Feb 2012
 01:33:30 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22C16DE0-5D1F-11E1-82B9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191230>

Tom Grennan <tmgrennan@gmail.com> writes:

> Example,
>   $ git tag -l --exclude "*-rc?" "v1.7.8*"
>   v1.7.8
>   v1.7.8.1
>   v1.7.8.2
>   v1.7.8.3
>   v1.7.8.4
>
> Which is equivalent to,
>   $ git tag -l "v1.7.8*" | grep -v \\-rc.
>   v1.7.8
>   v1.7.8.1
>   v1.7.8.2
>   v1.7.8.3
>   v1.7.8.4
>
> Signed-off-by: Tom Grennan <tmgrennan@gmail.com>

Having an example is a good way to illustrate your explanation, but it is
not a substitution.  Could we have at least one real sentence to describe
what the added option *does*?

This comment applies to all the patches in this series except for the
second patch.

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 8d32b9a..470bd80 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> -	[<pattern>...]
> +	[--exclude <pattern>] [<pattern>...]
>  'git tag' -v <tagname>...
>  
>  DESCRIPTION
> @@ -90,6 +90,10 @@ OPTIONS
>  --points-at <object>::
>  	Only list tags of the given object.
>  
> +--exclude <pattern>::
> +	Don't list tags matching the given pattern.  This has precedence
> +	over any other match pattern arguments.

As you do not specify what kind of pattern matching is done to this
exclude pattern, it is important to use the same logic between positive
and negative ones to give users a consistent UI.  Unfortunately we use
fnmatch without FNM_PATHNAME for positive ones, so this exclude pattern
needs to follow the same semantics to reduce confusion.

This comment applies to all the patches in this series to add this option
to existing commands that take the positive pattern.

> @@ -202,6 +206,15 @@ test_expect_success \
>  '
>  
>  cat >expect <<EOF
> +v0.2.1
> +EOF
> +test_expect_success \
> +	'listing tags with a suffix as pattern and prefix exclusion' '
> +	git tag -l --exclude "v1.*" "*.1" > actual &&
> +	test_cmp expect actual
> +'

I know you are imitating the style of surrounding tests that is an older
parts of this script, but it is an eyesore.  More modern tests are written
like this:

	test_expect_success 'label for the test' '
		cat >expect <<-EOF &&
                v0.2.1
		EOF
	        git tag -l ... >actual &&
		test_cmp expect actual
	'

to avoid unnecessary backslash on the first line, and have the preparation
of test vectore _inside_ test_expect_success.  We would eventually want to
update the older part to the newer style for consistency.

Two possible ways to go about this are (1) have a "pure style" patch at
the beginning to update older tests to a new style and then add new code
and new test as a follow-up patch written in modern, or (2) add new code
and new test in modern, and make a mental note to update the older ones
after the dust settles.  Adding new tests written in older style to a file
that already has mixed styles is the worst thing you can do.

This comment applies to all the patches in this series with tests.

Thanks.
