From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: resolve svn remote upstream refs
Date: Fri, 03 Aug 2012 13:40:28 -0700
Message-ID: <7v7gtfbtfn.fsf@alter.siamese.dyndns.org>
References: <501B9FD1.8090204@zetam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Wong <normalperson@yhbt.net>,
	"Michael G. Schwern" <schwern@pobox.com>
To: Yves Blusseau <blusseau@zetam.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:40:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxOfl-0000Pj-LG
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab2HCUkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 16:40:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab2HCUkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 16:40:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ACCE7EFA;
	Fri,  3 Aug 2012 16:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PT7OegNbMt25jWikPkI3o/6SQVE=; b=i1BvMW
	qBgZGN39LZIWW38wcl5VdgEVyyrQDT+Aut10KVrIUUuuMNJdk3A/1SMq1E+rAFPh
	U+KLnhL/gKFvvGbKzTiu9Tt/4BgjG24LKgU6p+AT1ezZ4ITlM6CFxSrdm0ItooS0
	g7YRCAIqF5azX/dlrvweum13vgrvRp+DEKAgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xmDgOTPFbC3p4SjmHr4fFtXyM/yYYrcB
	YjNuOCPrCYLNu4CpZgJ5Vi/wlsU2Woulogg+X/McvkyGcdW77Xyyzi0DSTd0fcHt
	vBrjkZ0QNvEYQCzotDWgpOsp0uoZyCPdMdbdbzLAeujBmYZ7O/ObtA52/O71l/a8
	ukil8q3yL0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 171407EF9;
	Fri,  3 Aug 2012 16:40:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18FCB7EF8; Fri,  3 Aug 2012
 16:40:30 -0400 (EDT)
In-Reply-To: <501B9FD1.8090204@zetam.org> (Yves Blusseau's message of "Fri,
 03 Aug 2012 11:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76DC1F4E-DDAB-11E1-B645-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202861>

Administrivia: 

 - "Content-Type: text/plain; charset=ISO-8859-1; format=flowed" in
   the header tells us that the patch is corrupted and will not
   apply cleanly, but we still can discuss the contents of the
   patch.

 - "git shortlog --since=6.months -n --no-merges contrib/completion"
   tells us who the area experts who may be able to help you move
   this patch forward.  Also people who are involved in git-svn may
   be able to help with the configurations you are reading from.  By
   Cc'ing them, your patch may have a better chance of getting
   polished more quickly (I added Cc to relevant people).

Yves Blusseau <blusseau@zetam.org> writes:

> Updated version of my previous patch

Everything before the "---" line we see below will be for people who
read "git log" history 6 months down the road, when they have to
understand what you did and why (perhaps because they found bugs or
they want to further enhance what your patch did).

Because your previous patch will not appear in that "git log"
output, the above is not an appropriate thing to say here.

> This fix is used to return the svn reference of the remote svn upstream
> branch when the git repository is a clone of a svn repository that was
> created with the --stdlayout and --prefix options of git svn command.

Before using the word "fix", please describe what the current
(i.e. without the "fix") behaviour visible to the users, why it is
bad, and what behaviour you want to give your users instead.  And
then describe what change you made to give that desired behaviour.

> * completion/git-prompt.sh: add function to resolve svn branches into
>   git remote refs using paths declared in svn-remote.*.fetch and
>   svn-remote.*.branches configurations
>
> Signed-off-by: Yves Blusseau <blusseau@zetam.org>
> ---

Here, immediately after "---", is where you would say "Updated
version of my patch.  The difference from the previous round are
1. fixed foo, 2. fixed bar, 3. reworded baz...." if you want to.

>  contrib/completion/git-prompt.sh | 56
> +++++++++++++++++++++++++++++++++++++++-

Line-wrapped (comes from "format=flawed" we saw in the Content-Type
header).

>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh
> b/contrib/completion/git-prompt.sh
> index 29b1ec9..f9a3421 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -73,17 +73,65 @@ __gitdir ()
>  	fi
>  }
>  +# resolve svn refs
> +# The function accepts 2 arguments:
> +# 1: An array containing the translation ref(s) (ie
> branches/*:refs/remotes/svn/*)
> +# 2: the ref to be translated (ie. branches/prod)
> +# returns the remote refs or original ref if it could not be translated

We see "translation ref(s)", which is an unheard-of term, and it is
unclear what is translated and into what other thing.  Is this the
moral equivalent of the ref mapping that maps refs at the remote
repository to remote tracking refs we have at our local repository?

If the first item of above were written like this:

    # 1: An array containing the mapping from branches in the subversion
    #  repository to remote tracking branches in this repository (e.g
    #  "branches/*:refs/remotes/svn/*").

I wouldn't have had to ask the above question, but it is unclear if
that is what you meant, hence this question.

> +__git_resolve_svn_refs ()
> +{
> +	local idx ref_globs left_part_ref_glob right_part_ref_glob
> left right value
> +
> +	local all_ref_globs=("${!1}")
> +	local ref="$2"

Bash/Zsh reusability czars might want to comment on the way
all_ref_globs is declared and initialized.

> +	for (( idx=0 ; idx < ${#all_ref_globs[@]}; idx++ ));do
> +		ref_globs="${all_ref_globs[$idx]}"
> +		# get the left part ref glob (before the :refs/)
> +		left_part_ref_glob="${ref_globs%%:refs/*}"

Is doubling of %% significant here?  I am assuming there isn't, as
there would be no colon in $ref_globs other than the boundary
between LHS and RHS.

> +		# If the ref match the left part we can resolve the ref directly
> +		if [[ "$ref" == "$left_part_ref_glob" ]];then

The coding standard used in this file is kept deliberately lax
compared to the remainder of the codebase, but I think the lack of
SP between ";" and "then" goes a bit too far.

> +			# resolve the ref into the right part (after the :)
> +			ref="${ref_globs/${left_part_ref_glob}:/}"
> +			break
> +		else
> +			case $ref in
> +				# check if the ref match the glob
> +				$left_part_ref_glob)

case/esac and case arms should align at the same column (otherwise
the body will be indented unreadably too deep to the right, like
this code).

>  # stores the divergence from upstream in $p
>  # used by GIT_PS1_SHOWUPSTREAM
>  __git_ps1_show_upstream ()
>  {
>  	local key value
>  	local svn_remote svn_url_pattern count n
> +	local svn_refs_globs=()
>  	local upstream=git legacy="" verbose=""
>   	svn_remote=()

Doesn't this have the same problem as the one fixed by 471dcfd
(contrib/completion: "local var=()" is misinterpreted as func-decl
by zsh, 2011-09-01)?

Thanks.
