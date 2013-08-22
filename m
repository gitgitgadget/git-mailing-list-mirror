From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-diff: Clarify operation when not inside a repository.
Date: Thu, 22 Aug 2013 13:54:40 -0700
Message-ID: <xmqqioyxqwdr.fsf@gitster.dls.corp.google.com>
References: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com>
	<xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
	<201308222031.r7MKVL6O028293@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Thu Aug 22 22:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCbu4-0005IB-1g
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 22:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab3HVUyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 16:54:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab3HVUyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 16:54:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10DA3BB8F;
	Thu, 22 Aug 2013 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oeh3pb8O/G3RCrEzHM56ZMu5fJg=; b=pYzzRf
	0yP7GPAsUFBnwM2k1aHeaBY6vYevqDYnCS+sVu7NJmIrA8G0VFfRIvmYXZED588x
	iQid7bW8zfxpQQJa8CXdpwroZrPPgA2TiYGzniCR1uTfqweIPSYRMkeGCD1Vr9Xa
	kNCtr1JsEOsgn5q5mFTETSceUwf59xt3lhVjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C7PjRGd4WtsYnyaOI5Np2G4xUr2qtEve
	WbSga3NsvBpO7jZFXxIlg7vnf/2lkO40yADo9SvlLFQ50X1pEcNRloZybJ0B2TPR
	tkn9WVofQ/DCZf4DQBlLZVfsDUUgUdMcranU9oawVn4SFK49hvWcxea+3y0HxsW/
	8i2sJ4pL8Vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A44593BB8E;
	Thu, 22 Aug 2013 20:54:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2D253BB8D;
	Thu, 22 Aug 2013 20:54:41 +0000 (UTC)
In-Reply-To: <201308222031.r7MKVL6O028293@freeze.ariadne.com> (Dale
	R. Worley's message of "Thu, 22 Aug 2013 16:31:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1122A4AC-0B6D-11E3-808B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232776>

worley@alum.mit.edu (Dale R. Worley) writes:

> The error message has been updated from [PATCH].  "git diff" outside a
> repository now produces:
>
>     Not a git repository
>     To compare two paths outside a working tree:
>     usage: git diff [--no-index] <path> <path>
>
> This should inform the user of his error regardless of whether he
> intended to perform a within-repository "git diff" or an
> out-of-repository "git diff".
>
> This message is closer to the message that other Git commands produce:
>
>     fatal: Not a git repository (or any parent up to mount parent )
>     Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
>
> "git diff --no-index" produces the same message as before (since the
> user is clearly invoking the non-repository behavior):
>
>     usage: git diff --no-index <path> <path>

The above result looks good and I find the reasoning stated here
very sound.

> Regarding the change to git-diff.txt, perhaps "forced ... by executing
> 'git diff' outside of a working tree" is not the best wording, but it
> should be clear to the reader that (1) it is possible to execute 'git
> diff' outside of a working tree, and (2) when doing so, the behavior
> will be as if '--no-index' was specified.

Then perhaps we can avoid the confusing "forced" by phrasing it like
so?

    This behaviour can be forced by --no-index.  Also 'git diff
    <path> <path>' outside of a working tree can be used to compare
    two named paths.

Let's step back a bit, though.  The original text is:

    'git diff' [--options] [--] [<path>...]::

            This form is to view the changes you made relative to
            the index (staging area for the next commit).  In other
            words, the differences are what you _could_ tell Git to
            further add to the index but you still haven't.  You can
            stage these changes by using linkgit:git-add[1].
    +
    If exactly two paths are given and at least one points outside
    the current repository, 'git diff' will compare the two files /
    directories. This behavior can be forced by --no-index.

which _primarily_ explains how the index and the working tree
contents are compared, but also mixes the description of the
"--no-index" hack, which is quite different.  As its name suggests,
it is not about comparing with the index---in fact, it is not even
about Git at all.  Just a pair of random paths that do not have
anything to do with Git are compared.

I suspect that it may be a good idea to split the section altogether
to reduce confusion like what triggered this thread, e.g.

    'git diff' [--options] [--] [<path>...]::

            This form is to view the changes you made relative to
            the index (staging area for the next commit).  In other
            words, the differences are what you _could_ tell Git to
            further add to the index but you still haven't.  You can
            stage these changes by using linkgit:git-add[1].

    'git diff' --no-index [--options] [--] <path> <path>::

	    This form is to compare the given two paths on the
	    filesystem.  When run in a working tree controlled by
	    Git, if at least one of the paths points outside the
	    working tree, or when run outside a working tree
	    controlled by Git, you can omit the `--no-index` option.

For now, I'll queue your version as-is modulo style fixes, while
waiting for others to help polishing the documentation better.

> I've also added some comments for the new code.

Thanks.

>  Documentation/git-diff.txt |    3 ++-
>  diff-no-index.c            |   12 +++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 78d6d50..9f74989 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -31,7 +31,8 @@ two blob objects, or changes between two files on disk.
>  +
>  If exactly two paths are given and at least one points outside
>  the current repository, 'git diff' will compare the two files /
> -directories. This behavior can be forced by --no-index.
> +directories. This behavior can be forced by --no-index or by 
> +executing 'git diff' outside of a working tree.
>  
>  'git diff' [--options] --cached [<commit>] [--] [<path>...]::
>  
> diff --git a/diff-no-index.c b/diff-no-index.c
> index e66fdf3..9734ec3 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -215,9 +215,19 @@ void diff_no_index(struct rev_info *revs,
>  		     path_inside_repo(prefix, argv[i+1])))
>  			return;
>  	}
> -	if (argc != i + 2)
> +	if (argc != i + 2) {
> +	        if (!no_index) {
> +		        /* There was no --no-index and there were not two
> +			 * paths.  It is possible that the user intended
> +			 * to do an inside-repository operation. */
> +		        fprintf(stderr, "Not a git repository\n");
> +		        fprintf(stderr,
> +				"To compare two paths outside a working tree:\n");
> +		}
> +		/* Give the usage message for non-repository usage and exit. */
>  		usagef("git diff %s <path> <path>",
>  		       no_index ? "--no-index" : "[--no-index]");
> +	}
>  
>  	diff_setup(&revs->diffopt);
>  	for (i = 1; i < argc - 2; ) {
