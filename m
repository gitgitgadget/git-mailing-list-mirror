From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Thu, 17 Feb 2011 13:49:35 -0800
Message-ID: <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
References: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 22:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqBjU-0002D2-On
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab1BQVts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:49:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1BQVtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:49:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A1BD407F;
	Thu, 17 Feb 2011 16:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3pwdAfRTbKBGgYpq4jGkGH5in+Q=; b=ChUQyebTjNVbZ9pXaklqx6D
	CtAqre+ddEFXOlYxgtuMjQQg4pySEAgcyJxerGBxYjYLtZwDLM2GBw73kC4ztqO5
	HPhaNAeNytRCAFG2d6PtGqP7LRDfqKVt0opwKDqpbE2l0sRsW3inPb3ODnLGl3bj
	nyBSl+n6nnitnvJD6P4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SVpFVAC/fq5Id2JUEzV+KgSKrCk9hYVvDasl+yrWu3a8kk/n1
	k598N9wt+ivCf+iSBguZ7iHWb8qBU+O/XOaUirDDECj5rQ6AX8mcLBZ3ucDgsGzy
	gswy7UtlXgCMPBk+Y5gI0iJ5ssNFdgkNnNM9oY+cGtICwOMcjinWPRxRFM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBE1F407C;
	Thu, 17 Feb 2011 16:50:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EDC904079; Thu, 17 Feb 2011
 16:50:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB1322AA-3ADF-11E0-9ECD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167126>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 880763d..21abd2a 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -206,40 +206,102 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
>  
>  Detached HEAD
>  -------------
> +HEAD normally refers to a named branch (e.g. "master"). Meanwhile, each
> +branch refers to a specific commit-id. Let's look at a repo with three

s/commit-id/commit/; we don't say "commit-id" anywhere else in this
document.  Also, it is Ok to be loose and colloquial in the manual and it
is fine to say "commit ID" from time to time, but not in this section, one
of the primary purpose of which is to illustrate distinction between
pointing at something that points at a commit (i.e. branch) and pointing
directly at a commit (i.e. detached).

> +commits and with "master" checked out:
>  
> +------------
> +           HEAD (refers to master)
> +            v
> +a---b---c  master (refers to c)
> +------------
> +
> +When a commit is created in this state, the branch is updated to the new
> +commit-id. Let's add a commit:

	... updated to point the new commit. 'git commit' creates a new
        commit 'd', makes it a child of 'c' and moves 'master' branch to
        point at 'd'.  HEAD also points at 'd' as the result of 'master'
        moving to the new commit.

I'd also suggest avoiding "Let's add" and instead be more specific (see
the above example).

>  ------------
> +               HEAD (refers to master)
> +                v
> +a---b---c---d  master (refers to d)
>  ------------
>  
> +It is sometimes useful to be able to checkout a commit that is not at
> +the tip of any named branch, or even to create a new commit that is not
> +referenced by a named branch. Let's look at what happens when we
> +checkout commit b:

I think it is a regression from the original text to omit mention of tags
and replace the first example of the section with a more advanced use case
of jumping to the middle of a branch; it is far more likely that a user
would want to detach at a specific release point.

You can rectify it by tagging 'c' as a release point and detaching the
HEAD at that tag without losing the clarity of the following description.
While doing so, it would be better to update the labels in the
illustration with s/master/master branch/ and s/[abcde]/commit &/ as well,
e.g.


                   HEAD (refers to branch 'master')
                    |
                    V
  a---b---c---d  branch 'master' (refers to commit 'd')
          ^
          |
     tag 'v2.0' (refers to commit 'c')

> +------------
> +$ git checkout master^^
>  
> +   HEAD (refers to b)

Perhaps s/refers/& directly/ to emphasize the difference in the
illustration.

> +    v
> +a---b---c---d  master (refers to d)
> +------------
> +
> +Notice that HEAD now refers directly to commit b. In git terminology,
> +this is known as having a detached HEAD. It means simply that HEAD
> +refers to a specific commit-id, as opposed to referring to a named
> +branch. Let's add a commit while HEAD is detached:

I'd suggest dropping "In git terminology,"; the reader knows that is what
is being explained when he opened the documentation.

We often say "detach the HEAD from a branch", "detach the HEAD at commit
'b'", but I don't think we say "we have a detached HEAD".  Same comments
from a few section before apply to "commit-id" and "Let's add".

    We often say "we detach HEAD at commit 'b'" and/or "we detach HEAD
    from the 'master' branch", to describe this state.  The HEAD directly
    points at the commit 'b', as opposed to referring to it indirectly
    through the "current" branch it points at.  From this state, 'git
    commit' will create a new commit 'e', makes it a child of 'b', and
    moves HEAD to directly point at it.

> +$ git checkout master
>  
> +      e---f    HEAD (refers to master)
> +     /          v
> +a---b---c---d  master (refers to d)
> +------------
> +
> +It is important to realize that at this point nothing refers to commits
> +e and f. Eventually these commits will be deleted by the routine git
> +garbage collection process, unless we create a reference before that
> +happens. If we have not yet moved away from commit f, any of these will
> +create a reference to it:
> +
> +------------
> +$ git checkout -b foo # (1)
> +$ git branch foo      # (2)
> +$ git tag foo         # (3)
> +------------
> +
> +(1) creates a new branch "foo", which refers to f, and then updates HEAD
> +to refer to "foo". In other words, we'll no longer be in detached HEAD
> +state after (1).

Somehow it feels funny to say "after (1)" in the section marked as such.
"after doing so", perhaps?

Also mimick the way how git-reset.txt, everyday.txt etc. tell AsciiDoc to
produce pretty labels that refer to parts in an illustration, with <1>,
<2>, etc.

> +If we have moved away from commit f, then we must first recover its id

s/id/object name/;

Other than these three points, the description from "It is important" up
to this point looks good.

> +(typically by using git reflog), and then we can create a reference to
> +it. For example, to see the last two commits to which HEAD referred, we
> +can use:
> +
> +------------
> +$ git log -g -2 HEAD
> +------------

A documentation written for people who do not know how to extract commit
object names out of reflog, it is insufficient to give the command line
example without giving a few lines of example output.  Instead of "log -g",
it probably is easier to use "git reflog -2" for this purpose.

Thanks.
