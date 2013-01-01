From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Tue, 01 Jan 2013 13:25:30 -0800
Message-ID: <7va9ssa94l.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:25:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9LN-0001dH-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab3AAVZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:25:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42784 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab3AAVZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:25:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBF7D94D2;
	Tue,  1 Jan 2013 16:25:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j4nuLH+0SgYbeRloEqxAbOoOyCw=; b=j7sI7I
	xfjU7E6+QTriNNFE7C3bRqfDksHkiRbAMiwQ/KV5cicK63v1gCDfZF7MVcaTNaLO
	ieuYgEJfW6oavOxy3dDQktMpoGYML0WE9R3u9hTRoh0E6V88Uk7+8MwJK6lPMcyl
	PRhD5DsmEwc3lo2kjeIt9MoFDHRMXs3JW6UyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GE2dxzc6CKmNYFUbqg9sagu2fAiLfnV3
	WJHaz6cRYaP7o18l7ZADP3BEqw4hllg0stYgTqfJCTfYgnlupVtKdzchSuv/3beq
	XZwRQEjH7HNrgerr1JLwfFbeGqCTnLhFzzE51jIEWFk5heD7ScLhHoyEPFR9DhOd
	X3/nzn86EBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD15594D1;
	Tue,  1 Jan 2013 16:25:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2408C94CF; Tue,  1 Jan 2013
 16:25:32 -0500 (EST)
In-Reply-To: <1357012655-24974-2-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5C79AAA-5459-11E2-80F4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212443>

"David A. Greene" <greened@obbligato.org> writes:

> Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body

This needs to say "contrib/subtree" somewhere (applies to all
patches in this series).

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Use %B to format the commit message and body to avoid an extra newline
> if a commit only has a subject line.
>
> Author:    Techlive Zheng <techlivezheng@gmail.com>

This needs to be a S-o-b instead; is it a real name, by the way?

> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh     |    5 +++
>  contrib/subtree/t/t7900-subtree.sh |   73 ++++++++++++++++++++++--------------
>  2 files changed, 49 insertions(+), 29 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 920c664..f2b6d4a 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -296,7 +296,12 @@ copy_commit()
>  	# We're going to set some environment vars here, so
>  	# do it in a subshell to get rid of them safely later
>  	debug copy_commit "{$1}" "{$2}" "{$3}"
> +	# Use %B rather than %s%n%n%b to handle the special case of a
> +	# commit that only has a subject line.  We don't want to
> +	# introduce a newline after the subject, causing generation of
> +	# a new hash.
>  	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
> +#	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |

Is it really replacing %s%n%n%b with %B, or is it still an
experiment that is disabled?

>  	(
>  		read GIT_AUTHOR_NAME
>  		read GIT_AUTHOR_EMAIL
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index bc2eeb0..93eeb09 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -76,6 +76,10 @@ test_expect_success 'add sub1' '
>          git branch -m master subproj
>  '
>  
> +# Save this hash for testing later.
> +
> +subdir_hash=`git rev-parse HEAD`
> +

We prefer $() over ``; much more readable.

>  # 3
>  test_expect_success 'add sub2' '
>          create sub2 &&
> @@ -155,7 +159,6 @@ test_expect_success 'add main-sub5' '
>          create subdir/main-sub5 &&
>          git commit -m "main-sub5"
>  '
> -
>  # 15
>  test_expect_success 'add main6' '
>          create main6 &&

Why?

> @@ -235,7 +238,19 @@ test_expect_success 'check split with --branch' '
>          check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"

Is quoting screwed up around here (and in many other places in this
patch)?  What are these no-op '' doing?

>  '
>  
> -# 25
> +#25

Why the lossage of a SP?

It may make sense to lose these "# num" that will have to be touched
every time somebody inserts new test pieces in the middle, as a
preparatory step before any of these patches, by the way.  That will
reduce noise in the patches for real changes.
