From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: avoid mentioning that the start point is a
 single commit
Date: Thu, 28 Jan 2010 23:33:13 -0800
Message-ID: <7vfx5pjrgm.fsf@alter.siamese.dyndns.org>
References: <20100129011817.GT12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 08:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NalQp-0005YN-0q
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 08:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab0A2HdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 02:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214Ab0A2HdW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 02:33:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0A2HdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 02:33:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8964A95098;
	Fri, 29 Jan 2010 02:33:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7QoJcgviGD/9wvHRR2FjolKI8tY=; b=dQzk1O
	wNmDTtEUYN45Hxj8/R9QWFWHTHOQ9vuht8sF9JPTZ4kIXB/+dnGHgE7adnNqWeKS
	pLaGxID2E/LVXd5Mz+iYdL0yYOnpM6ZI6RolkvFlNr5QMGJqfKaTt6grn2LYrxLn
	ziTYANvrwDptrhuAtTCIG2aVXeZaZuA2oTuYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qy0X3frXidiCeaA12VgMW4ThENapW5Ye
	hWfN1pRwCUHJ5HMnUb/StjwOETuzrOKOLWQd1v4cLWpWYvp+RC9BBbggBJP2L98q
	x42yp2CkJsjHMx13P9ag/wtgzNj1RUYZP3660UUIC3R21+t7LozEsKmIfsMI+K2C
	hA0WHxSGJso=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67D2895095;
	Fri, 29 Jan 2010 02:33:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AADD95094; Fri, 29 Jan
 2010 02:33:14 -0500 (EST)
In-Reply-To: <20100129011817.GT12429@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri\, 29 Jan 2010 02\:18\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 912AC318-0CA8-11DF-85E8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138301>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Previously we ran shortlog on the start commit which always printed
> "(1)" after the start commit, which gives no information, but makes the
> output less easy to read. Avoid doing so.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> So for example the 'git request-pull master~2 . master' output diff is
> the following here:
>
> 	 The following changes since commit 68186857a9bb0a71e9456155623e02d398a5b817:
> 	-  Junio C Hamano (1):
> 	-        Merge branch 'il/maint-colon-address'
> 	+  Junio C Hamano: Merge branch 'il/maint-colon-address'
>
> 	 are available in the git repository at:
>
>  git-request-pull.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 630cedd..8475919 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -66,7 +66,7 @@ if [ -z "$branch" ]; then
>  fi
>  
>  echo "The following changes since commit $baserev:"
> -git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
> +git log --max-count=1 --pretty=format:"  %an: %s%n%n" $baserev

A few comments:

 - Modernising implementation by using tools different from what the
   original used (i.e. shortlog -> log) is fine, but I'd recommend doing
   so even more thoroughly.  Use "show -s" instead of "log -1" and
   "--format=" instead of "--pretty=format:", for example.

 - If the stated goal of the change is to remove " (1)" which is
   distracting with no useful information, remove that and only that,
   without changing anything else in the output.

 - On the other hand, if you find that "AuthorName: " part is less useful
   in identifying the commit than its title to help the requestee, change
   the whole thing to make it even more useful.

So I'd suggest either:

	git show -s --format="  %an:%n        %s" $baserev

to be conservative, or

	git show -s --format="  %s (%an)" $baserev

or even to this:

	git show -s --format="  %s (%ci)" $baserev

I suspect that the last one would be the easiest for the requestee to
judge the freshness of the branch.

Why isn't the "The following changes..." line not part of the --format
thing, by the way?  From the POV of readability of the code (not
necessarily the output), doing it this way might be the cleanest:

-- >8 --
git show -s --format='The following changes since %H

    %s (%ci)

are available in the git repository at:' $baserev
echo "  $url $branch"
-- 8< --
