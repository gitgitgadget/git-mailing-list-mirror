Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9434C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B91613EE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhDTUuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:50:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64492 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTUux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 16:50:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B1CD095D;
        Tue, 20 Apr 2021 16:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuMhemJ1iZuExsbUpPnD226XjWk=; b=lXa0lZ
        CWiCTXFZP6/I3ZHuYOWT/8Ox9FWn6cYE8b7h3A2ZCLNcNNbyhowlHz8XgdHHwOJe
        +qWxl8gBeCAqetg2u+y3lMmlDLinK1Zv5BZHKoSRyiYqKCV2/vVUJ/or5dEo2ay1
        UI0qezY8o8AB7A4wOQwtyx+jb0LnpYv/oP9/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LFpXesFVvsjrY0v3llUl6TpOM6ddF6Cj
        6uJhSrxI3RtyGp6GwgEzpMSJuIvK6/MSXWLx4JzgssexY5h6RRJ56igrfIiYm7aZ
        drKIws5wNQo7kwDg5iDuZj71Ixx4bYQNURrkFFzfj0MOqhSLuGM4ATtbxzX5b5FW
        zvkH74mam1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1A24D095C;
        Tue, 20 Apr 2021 16:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 487AED095B;
        Tue, 20 Apr 2021 16:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/5] git-completion.bash: rename to $__git_cmd_idx
References: <cover.1618910364.git.liu.denton@gmail.com>
        <7c7d6de380d1aaa860e86627778bef6c0c78ca08.1618910364.git.liu.denton@gmail.com>
Date:   Tue, 20 Apr 2021 13:50:19 -0700
In-Reply-To: <7c7d6de380d1aaa860e86627778bef6c0c78ca08.1618910364.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 20 Apr 2021 02:19:48 -0700")
Message-ID: <xmqqr1j44r5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0515F62C-A21A-11EB-A8A5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In e94fb44042 (git-completion.bash: pass $__git_subcommand_idx from
> __git_main(), 2021-03-24), the $__git_subcommand_idx variable was
> introduced. Naming it after the index of the subcommand is flat-out
> wrong as this variable really holds the index of the git comand (e.g.

comand -> command

> "stash").
>
> Rename this variable so that it's obvious it's about git commands. While
> we're at it, shorten up its name so that it's still readable without
> being a handful to type.

As the patch has already written, I won't complain too much, but to
many people "git" is a command and "add", "commit" etc. are
subcommands of "git", so I do not see git_subcommand_idx so wrong
that it needs to be renamed.  I do understand that it is a bit too
long and it may be easier to type if renamed to say git_cmd_idx,
though ;-)

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1dedb14b47..c29c129f87 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1474,12 +1474,12 @@ _git_branch ()
>  
>  _git_bundle ()
>  {
> -	local cmd="${words[__git_subcommand_idx+1]}"
> +	local cmd="${words[__git_cmd_idx+1]}"
>  	case "$cword" in
> -	$((__git_subcommand_idx+1)))
> +	$((__git_cmd_idx+1)))
>  		__gitcomp "create list-heads verify unbundle"
>  		;;
> -	$((__git_subcommand_idx+2)))
> +	$((__git_cmd_idx+2)))
>  		# looking for a file
>  		;;
>  	*)
> @@ -1894,7 +1894,7 @@ _git_grep ()
>  	esac
>  
>  	case "$cword,$prev" in
> -	$((__git_subcommand_idx+1)),*|*,-*)
> +	$((__git_cmd_idx+1)),*|*,-*)
>  		__git_complete_symbol && return
>  		;;
>  	esac
> @@ -3017,7 +3017,7 @@ _git_stash ()
>  	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
>  
>  	if [ -z "$subcommand" ]; then
> -		case "$((cword - __git_subcommand_idx)),$cur" in
> +		case "$((cword - __git_cmd_idx)),$cur" in
>  		*,--*)
>  			__gitcomp_builtin stash_push
>  			;;
> @@ -3058,7 +3058,7 @@ _git_stash ()
>  		__gitcomp_builtin stash_branch
>  		;;
>  	branch,*)
> -		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
> +		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
>  			__git_complete_refs
>  		else
>  			__gitcomp_nl "$(__git stash list \
> @@ -3303,7 +3303,7 @@ _git_worktree ()
>  			# be either the 'add' subcommand, the unstuck
>  			# argument of an option (e.g. branch for -b|-B), or
>  			# the path for the new worktree.
> -			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
> +			if [ $cword -eq $((__git_cmd_idx+2)) ]; then
>  				# Right after the 'add' subcommand: have to
>  				# complete the path, so fall back to Bash
>  				# filename completion.
> @@ -3327,7 +3327,7 @@ _git_worktree ()
>  		__git_complete_worktree_paths
>  		;;
>  	move,*)
> -		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
> +		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
>  			# The first parameter must be an existing working
>  			# tree to be moved.
>  			__git_complete_worktree_paths
> @@ -3395,7 +3395,7 @@ __git_main ()
>  {
>  	local i c=1 command __git_dir __git_repo_path
>  	local __git_C_args C_args_count=0
> -	local __git_subcommand_idx
> +	local __git_cmd_idx
>  
>  	while [ $c -lt $cword ]; do
>  		i="${words[c]}"
> @@ -3426,7 +3426,7 @@ __git_main ()
>  			;;
>  		*)
>  			command="$i"
> -			__git_subcommand_idx="$c"
> +			__git_cmd_idx="$c"
>  			break
>  			;;
>  		esac
