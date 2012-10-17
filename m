From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Tue, 16 Oct 2012 22:14:36 -0700
Message-ID: <7vvce9ptmr.fsf@alter.siamese.dyndns.org>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:14:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOLy2-0004XP-BN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 07:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab2JQFOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 01:14:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab2JQFOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 01:14:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B9C0658B;
	Wed, 17 Oct 2012 01:14:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n8qLDQf8TyEQ2qBhDFwLtfCOtHY=; b=t7Ptp6
	uBQFNPjvgBv8C/s0i2vRCjsvTjBK4yj8+E8NE3x6gLpaegR7MvTTbeuui1qtD9DP
	50CPuKri6ROVwvqapT56Ef6STRF8dzq3IBs3TAfmzfMA/yXgsBgXhmnTDLApnRmI
	qLcyhPEWZE1sUIWWDCrV5LxIJg/afdeDmw++s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wt8k1CsL1EWv+l71gFcM8iGYJ0DXju9A
	Bs/3s8n0ir4inrDmIHfL//k9b4aIhYZb7WzKV4hPFKjfM0lzOuz6DGmzSzWW0PQt
	Zl1w9v+q54BtFkPBHAhJn28ZVsedKovEKvkl9pKTYaQZ1c62+KztJWRUcbJr18ZV
	+F2yc1SL15A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 292926589;
	Wed, 17 Oct 2012 01:14:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23E8D6583; Wed, 17 Oct 2012
 01:14:41 -0400 (EDT)
In-Reply-To: <1350443975-19935-1-git-send-email-eblake@redhat.com> (Eric
 Blake's message of "Tue, 16 Oct 2012 21:19:35 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E155556-1819-11E2-941B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207892>

Eric Blake <eblake@redhat.com> writes:

> * git-notes.txt: Mention that --notes option exists in many
> commands to override defaults.
> * git-format-patch.txt: Include pretty-options, for things like
> --notes.
> * git-send-email.txt: Mention that revision lists forwarded to
> format-patch can also include options.

Overall I feel fairly negative on this one, even though there are
good bits.

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  Documentation/git-format-patch.txt | 2 ++
>  Documentation/git-notes.txt        | 6 ++++--
>  Documentation/git-send-email.txt   | 3 ++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 6d43f56..a068f37 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -222,6 +222,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  	range are always formatted as creation patches, independently
>  	of this flag.
>
> +include::pretty-options.txt[]

In the context of format-patch, the inclusion of pretty-options
probably causes more harm than being helpful, I am afraid.  If you
use "--pretty=<format>", "--format=<format>", or "--oneline", the
output will no longer be a proper mbox and is not suitable for
asking somebody else to apply.

At the very least, you would need to add something like:

    ifndef::git-format-patch[]
    ... enclose everything that should not be used with format-patch
    endif::git-format-patch[]

to the included file, and then define the token before the
inclusion, like this:

    :git-format-patch: 1
    include::pretty-formats.txt[]

to limit the damage.

Even with such a change to include only --notes, I am not sure if
the result is something we would want to recommend/advertise to our
users.

The output from format-patch with --notes shows the notes, after
adding a blank line to the sign-off block, to look like this:

	From: A U Thor <author@example.com>
        Date: Tue, 16 Oct 2012 19:26:23 +0200
	Subject: [PATCH] Gostak: distim the doshes correctly

	With the current code, the Gostak cannot correctly distim
        the doshes, because ...

	Signed-off-by: Junio C Hamano <gitster@pobox.com>

	Notes:
		This patch was inspired by Eric Blake

	---
	diff --git a/gostak b/gostak
        ...

I am not sure if this is suiable for sending to somebody and asking
it to be applied.

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index b95aafa..be9e60f 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -39,8 +39,10 @@ message stored in the commit object, the notes are indented like the
>  message, after an unindented line saying "Notes (<refname>):" (or
>  "Notes:" for `refs/notes/commits`).
>
> -To change which notes are shown by 'git log', see the
> -"notes.displayRef" configuration in linkgit:git-log[1].
> +To change which notes are shown by default in 'git log', see the
> +"notes.displayRef" configuration in linkgit:git-log[1].  Also,
> +many commands understand a `--notes` option to alter the set of
> +notes displayed (see linkgit:git-rev-list[1]).
>
>  See the "notes.rewrite.<command>" configuration for a way to carry
>  notes across commands that rewrite commits.

OK.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index eeb561c..450d975 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -18,7 +18,8 @@ Takes the patches given on the command line and emails them out.
>  Patches can be specified as files, directories (which will send all
>  files in the directory), or directly as a revision list.  In the
>  last case, any format accepted by linkgit:git-format-patch[1] can
> -be passed to git send-email.
> +be passed to git send-email, including additional command line
> +options such as `--cover-letter` or `--notes`.

OK for --cover-letter, dubious on --notes.
