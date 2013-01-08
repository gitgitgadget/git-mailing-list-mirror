From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] contrib/subtree: Use %B for Split Subject/Body
Date: Tue, 08 Jan 2013 10:29:57 -0800
Message-ID: <7vmwwjedei.fsf@alter.siamese.dyndns.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
 <1357646997-28675-3-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:30:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdwN-0006HD-3h
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab3AHSaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:30:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756605Ab3AHSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:30:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4FF2A230;
	Tue,  8 Jan 2013 13:29:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ZVKDp2eaQYrP2ta+AVF16A5xbY=; b=n2uiNQ
	/S5YiKnzvYCJWogkYnh1Od7dosCn4OLvuA95v54DLWlebbHcop3iIGhzsPz1iVNC
	H4mExEuPQpUHGnC114IVv0REOG+0pXpbDIVww3H48H+NGzzG9M1OWfGHFkyVyb8t
	udY6pwMFBKVTjc/6IqT42x4c9wYpAIZqHmjmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CD56tLm4gBYXU8iW3fC9aJq5Wz7kBIm2
	v7GZBfzzu1yWbX4NRCzupiqbxFgRBURkVQgPqxqyF0LqdrRPbsO8C0hVdL8As9JT
	jTAGuiPDZPDf2dlyKSMGL5aU6tZnmYO/yKsWCzM6eIO2kZcjB4cSt6JSmlHRJDmC
	Ag4NLJ9U/FI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8969A22F;
	Tue,  8 Jan 2013 13:29:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 022C7A22E; Tue,  8 Jan 2013
 13:29:58 -0500 (EST)
In-Reply-To: <1357646997-28675-3-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Tue, 8 Jan 2013 06:09:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 686E7C80-59C1-11E2-829F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212992>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Use %B to format the commit message and body to avoid an extra newline
> if a commit only has a subject line.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---

This time (only), I'll try to fix them up at my end, but please
check your toolchain, find out where the extra blank line between
S-o-b: lines we see above come from, and fix that, so that I won't
have to do so again.

>  contrib/subtree/git-subtree.sh     |    6 +++++-
>  contrib/subtree/t/t7900-subtree.sh |   15 +++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 920c664..5341b36 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -296,7 +296,11 @@ copy_commit()
>  	# We're going to set some environment vars here, so
>  	# do it in a subshell to get rid of them safely later
>  	debug copy_commit "{$1}" "{$2}" "{$3}"
> -	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
> +	# Use %B rather than %s%n%n%b to handle the special case of a
> +	# commit that only has a subject line.  We don't want to
> +	# introduce a newline after the subject, causing generation of
> +	# a new hash.
> +	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |

The new format template is fine, but I do not think the comment
should be there.  It does not give any useful information to people
who are reading the end result of applying this patch and is useful
only in the context of comparing the old and new templates, iow, it
belongs to the commit log message.

>  	(
>  		read GIT_AUTHOR_NAME
>  		read GIT_AUTHOR_EMAIL
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 6cf9fb9..3f17f55 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -74,6 +74,10 @@ test_expect_success 'add sub1' '
>          git branch -m master subproj
>  '
>  
> +# Save this hash for testing later.
> +
> +subdir_hash=`git rev-parse HEAD`
> +
>  test_expect_success 'add sub2' '
>          create sub2 &&
>          git commit -m "sub2" &&
> @@ -211,6 +215,17 @@ test_expect_success 'check split with --branch' '
>          check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
>  '
>  
> +test_expect_success 'check hash of split' '
> +        spl1=$(git subtree split --prefix subdir) &&
> +        undo &&
> +        git subtree split --prefix subdir --branch splitbr1test &&
> +        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"

We'd need to clean up these no-op '' from this, but not doing so in
this patch is perfectly fine (and is even preferred).

> +        git checkout splitbr1test &&
> +        new_hash=$(git rev-parse HEAD~2) &&
> +        git checkout mainline &&
> +        check_equal ''"$new_hash"'' "$subdir_hash"
> +'
> +
>  test_expect_success 'check split with --branch for an existing branch' '
>          spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
>          undo &&

Thanks.
