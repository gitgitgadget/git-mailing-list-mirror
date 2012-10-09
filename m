From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision
 <tree-ish> option
Date: Mon, 08 Oct 2012 22:55:48 -0700
Message-ID: <7v8vbgi3yz.fsf@alter.siamese.dyndns.org>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 07:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLSnX-00022A-H0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 07:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab2JIFzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 01:55:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab2JIFzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 01:55:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36FFC4DF4;
	Tue,  9 Oct 2012 01:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WU+lipb8AdFEdvlBP8fqjQ27cL8=; b=qlM5yZ
	1V0ZiEV8SQy/SZBLjSlNmZQ29gjjxFwmGixV2w9pTOY8xbfL5DEuuo3fmJcD7Twn
	8QThKa9D7VMvFwqoAM+95yzsqij7Yp18fsn6vcT12uj0xUnwnEAi0e6wraDv45HK
	6CtCYMq923nvJG27C2Stz+xRIDdlTRosJJR2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaHOMAOgDMPwmM3lHOg7wgNjLwUkM/5e
	/szszqWvdc8Wxo0Y2A+TUDskx1Bo2kLFanvekj/B9utZOoCR83VXRl0ywC2XDLj4
	w1rTcjtbydgqWBNw1Ef9yqsFAwCKR5Dk4v3d/VFKoN5XDhxrp6J03ir5tAqmI3bp
	CNxdnA5ZA18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A264DF3;
	Tue,  9 Oct 2012 01:55:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CDBC4DF1; Tue,  9 Oct 2012
 01:55:50 -0400 (EDT)
In-Reply-To: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 8 Oct 2012 20:50:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA7A8472-11D5-11E2-96C5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207299>

Jay Soffian <jaysoffian@gmail.com> writes:

> Teach "git submodule foreach" a --revision <tree-ish> option. This
> is useful in combination with $sha1 to perform git commands that
> take a revision argument.

The above says:

 - "--revision T" is added.

   OK.  There is no information whatsoever what it does to convince
   us why it is useful.

 - This is useful.

   Huh?  How can anybody supposed to agree or disagree with that
   claim, when nothing is said about what it does in the first
   place?

> For example:
>
>   $ git submodule foreach --revision v1.0 'git tag v1.0 $sha1'

Whose "v1.0" does this example refer to?

The first line of the proposed log message says it is <tree-ish>,
which means that you can safely substitute "--revision T" with
"--revision $(git rev-parse T^{tree}), so it must name a concrete
single object that is a tree (not a tree-ish).  In which repository
is that object found?  The top-level superproject?  All submodule
repositories share the same object store with the superproject?

The description doesn't make _any_ sense to me. The feature might be
something worth considering about with a better description, but
with the above, I can't tell if it is.

> +	If `--revision <tree-ish>` is given, submodules are traversed starting
> +	at the given <tree-ish>.

What does "are traversed starting at the given <tree-ish>"?  The
desired or expected state of each submodule is recorded as a commit
object name (not even commit-ish) in its superproject.  Did you mean
"commit-ish"?

> + Though this does not alter the submodule check
> +	outs, it may be combined with $sha1 to perform git commands that can
> +	operate	on a particular commit, such as linkgit:git-tag[1].

Here is what I am guessing, partially with help from the horrible example:

>   $ git submodule foreach --revision v1.0 'git tag v1.0 $sha1'
>
> Previously, this would have required multiple steps:
>
>   $ git checkout v1.0
>   $ git submodule update
>   $ git submodule foreach 'git tag v1.0'

where there appears two v1.0 that are used for totally different
purposes which does not help guessing.  Perhaps "--revision" names a
tree-ish taken from the top-level superproject, and for each
submodule that appear in the tree in the superproject, the command
specified by foreach is run with the usual $sha1, $name, $path set
to the state in the submodules that top-level tree wants to have,
and this is done without actually checking anything out.  So the
first v1.0 in that confusing example is about specifying a tree in
the superproject repository, and the second v1.0 does not have any
relationship with that first v1.0 (the first one could have been HEAD~2
when you have committed twice in the superproject since you tagged v1.0
and remembered that you forgot to tag its submodules).

Assuming that the above guess is correct (which is a huge
assumption, given the lack of clarity in the description), I think
the feature might make sense.  The example would have been a lot
easier to follow if it were something like this:

    $ git submodule foreach --revision v1.0 'git grep -e frotz $sha1'

> @@ -379,6 +379,7 @@ Use -f if you really want to add it." >&2
>  cmd_foreach()
>  {
>  	# parse $args after "submodule ... foreach".
> +	revision=
>  	while test $# -ne 0
>  	do
>  		case "$1" in
> @@ -388,6 +389,11 @@ cmd_foreach()
>  		--recursive)
>  			recursive=1
>  			;;
> +		--revision)
> +			git rev-parse --quiet --verify "$2" >/dev/null || usage
> +			revision=$2

Shouldn't this part of the code verify $2^{tree} instead to ensure
that "$2" is a tree-ish?

> +			shift
> +			;;
>  		-*)
>  			usage
>  			;;
> @@ -404,7 +410,17 @@ cmd_foreach()
>  	# command in the subshell (and a recursive call to this function)
>  	exec 3<&0
>  
> -	module_list |
> +	if test -n "$revision"
> +	then
> +		# make ls-tree output look like ls-files output
> +		git ls-tree -r $revision | grep '^160000 ' |
> +		while read mode unused sha1 sm_path
> +		do
> +			echo "$mode $sha1 0 $sm_path"
> +		done
> +	else
> +		module_list
> +	fi |

Hrm, it is somewhat unfortunate that you cannot limit the set of
submodules to apply foreach to, like other commands like init,
update, status, etc.  (not a new problem).
