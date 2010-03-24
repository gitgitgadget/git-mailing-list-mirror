From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 12:58:27 -0700
Message-ID: <7vljdhh4po.fsf@alter.siamese.dyndns.org>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
 <20100323024223.GA12257@progeny.tock>
 <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 20:58:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuWiy-0004F7-6N
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 20:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab0CXT6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 15:58:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab0CXT6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 15:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2AF7A4FA2;
	Wed, 24 Mar 2010 15:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fOJjAgc/R+62RWX0bqEIZMeJdLI=; b=LWgo8P
	koFufwx6qACxngYY4BLegoE9xgHvzsHFtRNdFR+/p/HimXx4nQ4UNDDjfUCv0mAg
	q1JY8lmllPZ9aFhuiz42e8fhzNnk39MQw5ZuPJLYeFoh7iPJIjnyYyAKg4h74qMW
	NdE9Bheo7w12KlMp2lyGftj+jeKm9tE2arxw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdwYqqx3AhGYq3lTl3tBSLCyj9JZEeQZ
	kdZjFRLMry2atKaYvC9PnZe3MPtoygVkAzx/Aik1rcV4hfy1HC/m2J2Xj9w+eyza
	HOFrHoqvKaumSp+/lhTyUCBav4YnMUfhRezY9UJAFa/71tdaCsVQ8xtxkyq7eeFl
	c1ZCGJM/rAw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29B09A4F9E;
	Wed, 24 Mar 2010 15:58:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B56F5A4F95; Wed, 24 Mar
 2010 15:58:28 -0400 (EDT)
In-Reply-To: <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
 (Chris Packham's message of "Wed\, 24 Mar 2010 11\:53\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0169EFE-377F-11DF-90D1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143111>

Chris Packham <judge.packham@gmail.com> writes:

> git repack -a did the correct thing.
>
> It occurs to me that the UI around alternates is a bit lacking i.e.
> there isn't a git command to display the alternates in use or to add
> them to an existing repository (or at least I couldn't find one
> skimming the docs or googling).

That's an understatement.  Thanks for starting the effort.

I will likely to have quite a few style issues with the script
implementation, and am undecided if this should be a new command
or an option to some existing command, but it's time we have a
management facility for alternates.

> diff --git a/Makefile b/Makefile
> index 3a6c6ea..1a7b084 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -334,6 +334,7 @@ TEST_PROGRAMS_NEED_X =
>  unexport CDPATH
>
>  SCRIPT_SH += git-am.sh
> +SCRIPT_SH += git-alternates.sh
>  SCRIPT_SH += git-bisect.sh
>  SCRIPT_SH += git-difftool--helper.sh
>  SCRIPT_SH += git-filter-branch.sh

You probably need one entry in the command-list.txt to classify where in
the main manual page git(1) for this command to appear.  I would suggest
imitating "git config".

> diff --git a/git-alternates.sh b/git-alternates.sh
> new file mode 100755
> index 0000000..74ec707
> --- /dev/null
> +++ b/git-alternates.sh
> @@ -0,0 +1,159 @@
> +#!/bin/sh
> ...
> +#
> +# Runs through the alternates file calling the callback function $1
> +# with the name of the alternate as the first argument to the callback
> +# any additional arguments are passed to the callback function.
> +#
> +walk_alternates()
> +{
> +    local alternates=$GIT_DIR/objects/info/alternates
> +    local callback=$1

We want to use this on platforms with ksh and dash, so please refrain from
bash-ism features.  "local" does not mix well with "#!/bin/sh".

> +    shift
> +
> +    if [ -e $alternates ]; then

We tend to avoid '[' and write it like this:

	if test -f "$alternates"
        then
        	...

Also notice that an indent is one tab and one tabstop is 8 places, and
alternates need to be quoted in case $GIT_DIR has IFS whitespace in it.

> +        while read line
> +        do
> +            $callback $line $*

As the path to an alternate object store can contain IFS whitespace, line
needs to be quoted.  Also you call walk_alternates with things like "$dir" 
that could also be a path with IFS whitespace, it needs to be quoted
properly.  I suspect callback is only your own shell function, so it does
not have to be quoted, but it is Ok to quote it for consistency.  I.e.

	"$callback" "$line" "$@"

You are loooooose in quoting throughout your script, so I won't bother to
point all of them out in the rest of the message.  You also are loose in
checking error returns (what you failed to write $newalternates file, for
example), which needs to be fixed before the final version.

> +        done < $alternates

This is correct per POSIX even if $alternates itself has IFS whitespace in
it, but newer bash on some platforms have an obnoxious "safety feature"
(see 3fa7c3d work around an obnoxious bash "safety feature" on OpenBSD,
2010-01-26) that can cause it to barf on this.  It is unfortunate but we
need to quote it like this:

	done <"$alternates"

Also notice that there is no SP after < or > redirection (it is just a
style thing).

> +# Walk function to display one alternate object store and, if the user
> +# has specified -r, recursively call show_alternates on the git
> +# repository that the object store belongs to.
> +#
> +show_alternates_walk()
> +{
> +    say "Object store $1"
> +    say "    referenced via $GIT_DIR"
> +
> +    local new_git_dir=${line%%/objects}
> +    if [ "$recursive" == "true" -a "$GIT_DIR" != "$new_git_dir" ]
> +    then

	if test "$recursive" = true && test "$GIT_DIR" != "$new_git_dir"
        then
        	...

> +        GIT_DIR=$new_git_dir show_alternates

This is probably depending on a bug in bash and is not portable.  See
76c9c0d (rebase -i: Export GIT_AUTHOR_* variables explicitly, 2010-01-22)

> +add_alternate()
> +{
> +    if test ! -d $dir; then
> +        die "fatal: $dir is not a directory"
> +    fi

This will not work with relative alternates.  In two repositories A and B,
where B borrows from A:

	A/.git/objects/
        B/.git/objects/info/alternates

the alternates file in B can point at A's .git/objects, relative to its
own .git/objects/.

> +    walk_alternates check_current_alternate_walk $dir
> +
> +    # At this point we know that $dir is a directory that exists
> +    # and that its not already being used as an alternate. We could
> +    # go further and verify that $dir has valid objects.
> +
> +    # if we're still going we can safely add the alternate
> +    touch $GIT_DIR/objects/info/alternates
> +    echo "$(readlink -f $dir)" >> $GIT_DIR/objects/info/alternates

What is this touch for?

Is readlink(1) portable enough across platforms?  A more fundamental
question is if resolving symbolic link like this behind user is a sensible
thing to do, especially as you are ...

> +    say "$dir added as an alternate"

... lying to the user here, if $dir indeed is a symbolic link.

> +rewrite_alternates()
> +{
> +    if test "$1" != "$2"; then
> +        echo $2 >> $3
> +    fi
> +}

That's a misleading name for this helper function.

> +del_alternate()
> +{
> +    if test ! $force = "true"; then
> +        say "Not forced, use"
> +        say "   'git repack -a' to fetch missing objects, then "
> +        say "   '$dashless -f -d $dir' to remove the alternate"
> +        die
> +    fi
> +
> +    local alternates=$GIT_DIR/objects/info/alternates
> +
> +    new_alts_file=$(mktemp $alternates-XXXXXX)
> +    touch $new_alts_file
> +
> +    walk_alternates rewrite_alternates $dir $new_alts_file

I think this is a more expensive way to say:

	grep -v -F "$dir" <"$alternates" >"$new_alternates"

> +    mv $new_alts_file $alternates
> +
> +    # save the git from repeatedly reading a 0 length file
> +    if test $(stat -c "%s" $alternates) -eq 0; then
> +        rm $alternates
> +    fi

Good point, but it would be better to do something like this:

	grep -v -F "$dir" <"$alternates" >"$new_alternates"
	if test -s "$new_alternates"
        then
        	mv "$new_alternates" "$alternates"
	else
        	rm -f "$alternates"
	fi

without making it less portable by using "stat".
