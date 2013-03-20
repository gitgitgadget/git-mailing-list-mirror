From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Wed, 20 Mar 2013 12:07:35 -0700
Message-ID: <7vboadevpk.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:08:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOMn-0001Na-JE
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260Ab3CTTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:07:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757752Ab3CTTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:07:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D8D6A25B;
	Wed, 20 Mar 2013 15:07:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AqBG0qm9JsPPzwdsygK0or2qEJQ=; b=uYpT8T
	t5C8bXBBtYM7XmwOdusdq7YXw+6wJY9rR76nbCRGaYzeuCE/1ZzFYoujyHXA+AW9
	5/RuVZ53xX27dYWxOjIZjTC1m7tak6FcHm3YsHq0ben6IjBr1IJUh4XP1efadfXC
	7/wklvothXF5C+B/gc++kdpvY2wQlCgxRydWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCDX3IiEiBHjxxs79R2YTmxmB0KzxLZ1
	WdgNBTDPzXUhFlB8lT7Jj1NbBu/I+sR3y2W1ZJ3b503lZ8KmLU4WOJ2DCivdmgcD
	5QUd+5I7sweicGP9JTfcljGzDIke+y3zSyZtbibCkvxWOZFsNctOS/1cfSGo1UYa
	GTsbYTpVTgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B102A25A;
	Wed, 20 Mar 2013 15:07:37 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80E17A259; Wed, 20 Mar 2013
 15:07:36 -0400 (EDT)
In-Reply-To: <1363802033-26868-1-git-send-email-ydroneaud@opteya.com> (Yann
 Droneaud's message of "Wed, 20 Mar 2013 18:53:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D594BC8-9191-11E2-8D2C-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218659>

Yann Droneaud <ydroneaud@opteya.com> writes:

> When asking Git to merge a tag (such as a signed tag or annotated tag),
> it will always create a merge commit even if fast-forward was possible.
> It's like having --no-ff present on the command line.
>
> It's a difference from the default behavior described in git-merge.txt.
> It should be documented as an exception of "FAST-FORWARD MERGE" section
> and "--ff" option description.
>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>  Documentation/git-merge.txt     | 9 +++++++++
>  Documentation/merge-options.txt | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index c852a26..84bc873 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -170,6 +170,15 @@ happens:
>  If you tried a merge which resulted in complex conflicts and
>  want to start over, you can recover with `git merge --abort`.
>  
> +MERGING TAG
> +-----------
> +
> +When merging a tag (annotated or signed), Git will create a merge commit
> +even if a fast-forward merge is possible (see above).
> +The commit message template will be created from the tag message.
> +Additionally, the signature check will be reported as a comment
> +if the tag was signed. See also linkgit:git-tag[1].
> +

It would make it more helpful to readers to describe how _not_ to
create such a merge commit if it is unwanted, and how the request to
merge a tag interacts with --ff-only option.

>  HOW CONFLICTS ARE PRESENTED
>  ---------------------------
>  
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 0bcbe0a..70d1ec0 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -26,7 +26,7 @@ set to `no` at the beginning of them.
>  --ff::
>  	When the merge resolves as a fast-forward, only update the branch
>  	pointer, without creating a merge commit.  This is the default
> -	behavior.
> +	behavior (except when merging a tag).

With this update, the reader will be left wondering what would be
the default when she asks Git to merge a tag, no?

>  --no-ff::
>  	Create a merge commit even when the merge resolves as a
