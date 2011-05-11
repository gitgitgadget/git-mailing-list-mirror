From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Wed, 11 May 2011 16:46:09 -0700
Message-ID: <7vfwoker7i.fsf@alter.siamese.dyndns.org>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIt Mailing List <git@vger.kernel.org>
To: David Pisoni <dpisoni@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 01:46:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKJ6k-0006zC-Ug
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 01:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902Ab1EKXqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 19:46:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab1EKXqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 19:46:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25F604BDD;
	Wed, 11 May 2011 19:48:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KYkIVXv3cuB6B0Ggo3avRzaaf2I=; b=QiW8lk
	NaK77d9fk13f7BMV+jLxCLYTdnaBQ/l9gQk7BG9gM40C7YAbCTFC6BOy5fSaPgwn
	zsqQwLWJ5TYwbkntKGWaohlQVrwQZ2NhNPOUYVFeLtaWo9bQkOsQm3arPnSP/XYT
	YmrqD75X/ZpQMn2cVZPJYFk1zFCF9Tx8gEryA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Et2p83+PuA8iDmNhycfSytKerIB72Q5N
	xmz1wlqF7rN2X3zuyH8kTiEU0SO4SoE8iH3sqqhO0Jw2E2Dlw3aEen0ngY5V1SkH
	iwFegHC/RrCxXe5hjbEcSLZr104FgNFQHo+upjZPm5ZCXXXOZmZpVAiOyY4ttRtr
	tjEU1kiV/BQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 021424BDC;
	Wed, 11 May 2011 19:48:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BF9244BD7; Wed, 11 May 2011
 19:48:15 -0400 (EDT)
In-Reply-To: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com> (David Pisoni's
 message of "Wed, 11 May 2011 15:57:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25B674E6-7C29-11E0-B893-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173434>

David Pisoni <dpisoni@gmail.com> writes:

> Setting 'stash.index' config option changes 'git-stash pop|apply' to
> behave
> as if '--index' switch is always supplied.
> 'git-stash pop|apply' provides a --no-index switch to circumvent
> config default.
>
> Signed-off-by: David Pisoni <dpisoni@gmail.com>

Your MUA utterly mangled your whitespaces and linebreaks.  Please be
careful when you send a re-rolled series of this patch.  The section "MUA
Specific hints" of

  http://www.kernel.org/pub/software/scm/git/docs/git-format-patch.html

may be of help.  

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 285c7f7..d794c40 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1746,6 +1746,11 @@ showbranch.default::
> 	The default set of branches for linkgit:git-show-branch[1].
> 	See linkgit:git-show-branch[1].
>
> +stash.index::
> +    A boolean to make linkgit:git-stash[1] default to the behavior of
> --index
> +	when applying a stash to the working copy.  Can be
> circumvented by using
> +	--no-index switch to linkgit:git-stash[1].  Defaults to false.

This says "boolean", so all of these should mean "I do not want the
command to default to --index":

	[stash]
                index = false
                index = 0

and all of these mean "I do want the default --index":

	[stash]
		index
                index = yes
                index = 1

I however do not think your implementation actually handle these
correctly.

See below for one possible correct implementation, also the comment on the
necessity to test both sides of the coin.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 15f051f..de086ee 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
> 'git stash' list [<options>]
> 'git stash' show [<stash>]
> 'git stash' drop [-q|--quiet] [<stash>]
> -'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
> +'git stash' ( pop | apply ) [--[no-]index] [-q|--quiet] [<stash>]

The --no-index is a very welcome addition, even if we did not have this
new configuration variable.  An alias "git pop" defined thusly:

	[alias]
        	pop = stash pop --index

can countermand it on demand with "git pop --no-index".

Please make it a separate patch, that comes before the addition of the
configuration variable.  And then another patch to add the configuration
variable on top of it.

> diff --git a/git-stash.sh b/git-stash.sh
> index 0a94036..7711bf6 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -31,6 +31,8 @@ else
>        reset_color=
> fi
>
> +CONFIG_INDEX="$(git config stash.index)"

This needs to be something like

	CONFIG_INDEX=$(git config --bool stash.index)
	
Then you would check the value against "true" later like this:

> @@ -256,7 +258,7 @@ parse_flags_and_rev()
>
> 	IS_STASH_LIKE=
> 	IS_STASH_REF=
> -	INDEX_OPTION=
> +	INDEX_OPTION=$CONFIG_INDEX

	if test "$CONFIG_INDEX" = true
	then
		INDEX_OPTION=--index
	else
        	INDEX_OPTION=
	fi

> @@ -277,6 +279,9 @@ parse_flags_and_rev()
> 			--index)
> 				INDEX_OPTION=--index
> 			;;
> +			--no-index)
> +				unset INDEX_OPTION
> +			;;

I'd rather sees this done as

			--no-index)
				INDEX_OPTION=
				;;

as a later part of the existing code says

	if test -n "$INDEX_OPTION" && ...

IOW, the code switches on the value of the variable, not on whether if it
is set or unset.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 5c72540..4999682 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -84,6 +84,34 @@ test_expect_success 'apply stashed changes
> (including index)' '
> 	test 1 = $(git show HEAD:file)
> '
>
> +test_expect_success 'apply stashed changes (including index) with
> index config set' '
> +    git config stash.index yes &&
> +	git reset --hard HEAD^ &&
> +	echo 7 > other-file &&

We write redirect from/to without an extra space, like you did
in the next test to echo 8 into the same file.

> +	git add other-file &&
> +	test_tick &&
> +	git commit -m other-file &&
> +	git stash apply &&
> +	test 3 = $(cat file) &&
> +	test 2 = $(git show :file) &&
> +	test 1 = $(git show HEAD:file) &&
> +	git config --unset stash.index
> +'

Use test_when_finished early to arrange so that this unset will happen
even when a step somewhere in the test fails.

It is a common mistake to write tests that only show off a shiny new toy,
making sure the feature kicks in when it should, and totally forget to
make sure the feature does not kick in when it should not.  Always remeber
to test both sides of the coin.

Check what should happen with at least these combinations:

        stash.index set to...           command line says...
 ----------------------------------------------------------------
        (not set at all)                (nothing)
        (not set at all)                --index
 *      (not set at all)                --no-index
 *      (not set at all)                --index --no-index
 *      (not set at all)                --no-index --index
 *      false                           --index
 *      false                           --no-index
 *      true                            --index
 *      true                            --no-index
 ----------------------------------------------------------------

The cases marked with "*" are the possibilities your patch opens and need
to have tests so that they are not broken when other people later change
the code (e.g. the command line parsing may break "later one wins" rule if
done carelessly).

Thanks.
