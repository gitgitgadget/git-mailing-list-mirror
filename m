Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC11C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 10:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJEKF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJEKF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 06:05:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59AB1C939
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 03:05:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b4so18239670wrs.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=JMHgTlYXvehNrq9ynbSHie0b0cDUr3OpNLAINEj0X1Y=;
        b=UVSZuuGaeRB2QB7+4TpKVm2ep29VAztP8uUMZQYtNjxqYvz72wbH+My0MQtb588irp
         CjHA/4xXxgrERfONQJsQK021zPT/y6l68cSiEb16X3uvCcl/htBSBsuoxp6yH0f8v6aa
         lkfkYjbprHfNB2A23sOl1ailYxkP0vYWaT/VbJu71OeSUUmCiaD4uMfIFuncnj/7+4nt
         5gbvL1POPNuPNW/vYYrl9ZnOyCHFsbsx19YpfyPJ8fwANR3IIwIi0qeMT2oDLinAhjS/
         LTEi8WF0y7UUSVO7fvx5dxk0l+QI03UsWcf0kYdTm4lu4Z/3Y3N8W9tBc3tQPmm/MPDn
         hiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JMHgTlYXvehNrq9ynbSHie0b0cDUr3OpNLAINEj0X1Y=;
        b=3z+QniopyDuH3Zd259K3k45HOJXC/lqPrY5U1Pm3387TCe+oorZmCn0ksF4ViN7fS5
         494SIFS3n+VlI9dgcvu8F9KdKuC2pxSYdpmNMSWk0G7iujr1JDYwSOP+RUijomVCGifQ
         rnvxrP4WE/2/NTktaqZ03d5R+ZRhOVR/x7vnZxxKahP2By/cUMV3LZXQHJgHsoKi6irt
         7fFO45KN1iBpxZUajv1gOQx/f1VK/MO3nT5/V0ZbG2/PrNIZYAtNXW6sGk9d1nHtZZUq
         FV4ZVcWd3MNB/3Ls/02KL68MwSGg1u+1z/iNEOr/BwMGQVRtux6hRbbNynMym3fRy78h
         FE0Q==
X-Gm-Message-State: ACrzQf0L0tAOQ7+rVb8/V/Y8pRaUqWm+CCb8OrRp4lYiYYYl3wX5s/5p
        vUYjIRcm3uvpQsGGwPOD5PM=
X-Google-Smtp-Source: AMsMyM424VxfiNPKBGzSu1nZ2hUj3JtpF3j63AoVM6orvfoPUUeB1din5XWLl1K2hOWdjPo68iqlDA==
X-Received: by 2002:a5d:64a8:0:b0:22e:409f:a3cb with SMTP id m8-20020a5d64a8000000b0022e409fa3cbmr7963842wrp.168.1664964320021;
        Wed, 05 Oct 2022 03:05:20 -0700 (PDT)
Received: from localhost (78-131-14-129.pool.digikabel.hu. [78.131.14.129])
        by smtp.gmail.com with ESMTPSA id n3-20020a1ca403000000b003b49bd61b19sm1464825wme.15.2022.10.05.03.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:05:19 -0700 (PDT)
Date:   Wed, 5 Oct 2022 12:05:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Tim Jaacks <timjaacks@posteo.de>, git@vger.kernel.org
Subject: Re: Bash completion for git aliases containing nested subcommands
Message-ID: <20221005100518.GA1718@szeder.dev>
References: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
 <20221003142437.GB7659@szeder.dev>
 <YzthDLdqeQx6bEcj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzthDLdqeQx6bEcj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 06:24:12PM -0400, Jeff King wrote:
> On Mon, Oct 03, 2022 at 04:24:37PM +0200, SZEDER Gábor wrote:
> 
> > > Is there a way to get the completion on the alias behave like on the
> > > original command?
> > 
> > In general: no.  Our Bash completion script is organized as one
> > _git_cmd() function for each git supported command.  If a command has
> > subcommands, then its completion function looks for any of its
> > subcommands amond the words on the command line, and takes the
> > appropriate action, which is usually executing a particular arm of a
> > case statement.  The two main issues are that in case of such an alias
> > there is no subcommand ("show") on the command line, and there is no
> > dedicated function to handle only the completion for 'git stash show'.
> 
> It feels like this ought to be able to work, for the same reason that
> "git stash show <TAB>" works. In the non-aliased case, we call into
> _git_stash(), and it sees that "show" is already there on the command
> line. But in the aliased case, we know "show" is part of the alias but
> throw away that information completely, and never feed it to
> _git_stash() at all.
> 
> I think we could do something like the patch below, though I suspect
> there are some dragons with more complicated aliases. I wonder if
> __git_aliased_command() needs to be more careful with distinguishing
> pure-git-command aliases from the complexity of "!" aliases. Or maybe
> the alias stuff is all best-effort enough that this doesn't make
> anything worse.
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ba5c395d2d..f68bfcbf05 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1148,10 +1148,13 @@ __git_aliased_command ()
>  		cur=
>  
>  		for word in $cmdline; do
> +			if test -n "$cur"; then
> +				expansion_words+=("$word")
> +				continue
> +			fi
>  			case "$word" in
>  			\!gitk|gitk)
>  				cur="gitk"
> -				break
>  				;;
>  			\!*)	: shell command alias ;;
>  			-*)	: option ;;
> @@ -1163,14 +1166,13 @@ __git_aliased_command ()
>  			\'*)	: skip opening quote after sh -c ;;
>  			*)
>  				cur="$word"
> -				break
>  			esac
>  		done
>  	done
>  
>  	cur=$last
>  	if [[ "$cur" != "$1" ]]; then
> -		echo "$cur"
> +		expansion=$cur
>  	fi
>  }
>  
> @@ -3507,9 +3509,13 @@ __git_main ()
>  
>  	__git_complete_command "$command" && return
>  
> -	local expansion=$(__git_aliased_command "$command")
> +	# __git_aliased_command now writes to these
> +	local expansion
> +	local expansion_words
> +	__git_aliased_command "$command"
>  	if [ -n "$expansion" ]; then
> -		words[1]=$expansion
> +		words=("${words[0]}" "$expansion" "${expansion_words[@]}" "${words[@]:2}")
> +		cword=$((cword + ${#expansion_words[@]}))
>  		__git_complete_command "$expansion"
>  	fi
>  }

Oh, that's an interesting idea.  I think it could help other cases as
well, e.g. in case of an alias like 'pg = push github', after 'git pg
<TAB>' the completion script would list remotes, but we'd actually
need refspecs.

I like the idea of inserting the expansion of git aliases into the
words array, as if they were present on the command line, and as far
as I can tell it's safe to do so, after all it's pretty much matches
what git itself does when expanding such an alias.  However, I'm
worried about doing the same for shell aliases, because those can
expand to just about anything, including e.g. some filtering pipe
stages after the aliased git command, that will be added to
$expanded_words, and could cause all kinds of confusion in various
completion functions.

> By the way, you'll notice that the splice into "words" happens right
> at words[1]. That matches the earlier code that just touches words[1].
> But I suspect that isn't right. If we're completing "git -p foo", for
> example, then the command is at word[2]. I don't know if this causes any
> bugs, since we get to the right completion function based on $expansion,
> not any value in $words. But presumably it should be __git_cmd_idx?

Yeah, that should definitely be words[__git_cmd_idx]=...

As far as dispatching to the right _git_cmd() function, it doesn't
matter whether we overwrite the $words at index 1 or $__git_cmd_idx;
but for that we wouldn't have to overwrite words[1] at all.

However, there is (AFAIK only) one completion helper function
__git_complete_remote_or_refspec() which does what its name suggests,
but behaves slightly differently whether it's invoked for 'git push',
'pull', 'fetch', or 'remote'.  Alas, this function doesn't have a
parameter that its caller could use to tell how to behave, but it
decides what to do by looking at the word on the command line
containing the git command, i.e. ${words[__git_cmd_idx]}.  So I guess
with a simple alias like 'p = push' completing 'git -c var=val p
origin <TAB>' would misbehave, because that 'words[1]=...' would
overwrite '-c', so the completion function would see the words 'git
push var=val p origin', but inside __git_complete_remote_or_refspec()
that ${words[__git_cmd_idx]} would be 'p', and without seeing one of
the supported commands that function won't list refspecs.


One "dragon with more complicated aliases" might be that
__git_aliased_command() doesn't know about git's --options, in
particular which --options take a mandatory argument.  Yesterday I
learned that, quoting the description of 'alias.*' from git-config
manpage, "the first word of an alias does not necessarily have to be a
command.  It can be a command-line option that will be passed into the
invocation of git."  Now, if I understand you patch correctly, then it
would only add those words to $expansion_words that follow the aliased
command, e.g. with an alias like 'pg = -c var=val push github' when
completing 'git pg <TAB>', then $words would contain 'git push
github'.  On one hand this is good, because $__git_cmd_idx would index
the right element of the $words array even after inserting the
expansion of the alias.  OTOH, it can be bad, because with an alias
like 'pg = -C path push github' __git_aliased_command() would believe
that the command is "path", not "push".

Another dragon might be the support for recursive aliases: will the
order of words in $expansion_words match the order that git uses when
expanding aliases recursively?

