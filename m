Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C3C433E6
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEFF64E31
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBGTFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:05:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGTFe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:05:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D6C6113544;
        Sun,  7 Feb 2021 14:04:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VMMBLJ2WHJ+2amtOonDGmC6iTaQ=; b=SV0BJh
        iCLGfppw8G/WU4+8yOsWUuOBYEwePcCYACfUb5nFBW4SSMWzVVOM1p16LkheC19A
        EsNBUzAydim9Xu71kLN6EKh1BpKNaLBRDxNKVmkJrJmPjxeuADW4rAhE/+VFpjAd
        m1RNbtLo8nigNZ6muXJR8XONa7eYz0qy8nJMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=psQqzo2QSwjiTBmVeHfLeLky85/N5c2E
        hfyGrIrnirs/keodfCRChWURdFrVYBjGRak49Gm828051RQklEyTltFIbJQiTT/b
        fkrviC5yglb7tZEbwH3TDW5QBRYdd+HsAs8PWwitd0tLf9bi5FFMeolvio31nwz/
        Nnjqd5yYd90=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45415113543;
        Sun,  7 Feb 2021 14:04:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81224113541;
        Sun,  7 Feb 2021 14:04:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Subject: Re: [PATCH] git-difftool-helper.sh: learn a new way skip to save point
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
Date:   Sun, 07 Feb 2021 11:04:47 -0800
In-Reply-To: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
 (=?utf-8?B?IumYv+W+t+eDiA==?= via
        GitGitGadget"'s message of "Sun, 07 Feb 2021 15:19:13 +0000")
Message-ID: <xmqq8s7z8zsg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59E9C862-6977-11EB-9241-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, but a not-yet-written reply went out by accident; please
discard it.

> `git difftool` only allow us to select file to view In turn.

Funny capitalization "In"?

> If there is a commit with many files and we exit in search,
> We will have to traverse list again to get the file diff which
> we want to see.Therefore,here is a new method:every time before

It makes it hard to lack SP after punctuation like '.', ',', and
':'.

> we view the file diff,the current coordinates will be stored in
> `GIT_DIR/difftool_skip_to`,this file will be deleted after
> successful traversing.But if an unexpected exit occurred midway,
> git will view the coordinates in the save point,ask user if they
> want continue from the last saved point.This will improve the
> user experience.

I think the idea sounds good.  Admittedly I do not use difftool
myself, so I do not even know if and how the current end user
experience is so bad to require a patch like this (e.g. I do not
know how "unexpected exit" is "unexpected"---isn't it the end user
initiated action to "quit", or does the tool crash or something?).

So I won't be the best qualified person to judge if the solution
presented is the best one for the problem.  

    $ git shortlog --no-merges git-diff-helper.sh

might be a good way to find whom to ask for review and help.

Having said that, I do have one opinion on the "skip-to" filename.
I do not think it is wise to call it after the purpose you want to
use it for (i.e. "I want to use it to skip to the recorded
position").  Instead, if the file records "the last visited
position", it is better to name it after that
(e.g. "difftool-last-position".  If it records "the next file to be
visited", then "difftool-next-file" may be a good name).

The reason is because your first design may be to visit the file the
user was visiting before the "crash" happened, but you may later
want to revise the design to allow the user to say "start at one
file before the file I was visiting" etc.  The location recorded in
the file may still be used to decide where the code skips to when
restarting, but no longer exactly where the code "skips to".  If you
name it after what it is, not what it is (currently) used for, the
design would become clearer.


> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 46af3e60b718..56ec1d38a7a1 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -6,6 +6,7 @@
>  # Copyright (c) 2009, 2010 David Aguilar
>  
>  TOOL_MODE=diff
> +GIT_DIFFTOOL_SKIP_TO_FILE="$GIT_DIR/difftool-skip-to"
>  . git-mergetool--lib
>  
>  # difftool.prompt controls the default prompt/no-prompt behavior
> @@ -40,6 +41,31 @@ launch_merge_tool () {
>  	# the user with the real $MERGED name before launching $merge_tool.
>  	if should_prompt
>  	then
> +		if test -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
> +		then
> +			SAVE_POINT_NUM=$(cat "$GIT_DIFFTOOL_SKIP_TO_FILE")

You can avoid the TOCTTOU race by

		if SAVE_POINT=$(cat 2>/dev/null "$GIT_DIFFTOOL_SKIP_TO_FILE")
		then

but that wouldn't probably matter in this application.

> +			if test $SAVE_POINT_NUM -le $GIT_DIFF_PATH_TOTAL &&
> +				test $SAVE_POINT_NUM -gt $GIT_DIFF_PATH_COUNTER

Think what happens if the file is corrupt and SAVE_POINT_NUM has (1)
an empty string, (2) garbage that has $IFS whitespace, (3) non
number, in it.  At least, quoting the variable inside double-quotes,
i.e. "$SAVE_POINT_NUM", would help an error condition reported
correctly at the runtime.

> +			then
> +				# choice skip or not skip when check first file.

A bit funny language.  Isn't the code clear enough without this comment?

> +				if test $GIT_DIFF_PATH_COUNTER -eq "1"

No need to quote the constant "1"; quoting the variable side may be
a good practice, even though I think in this codepath we know
GIT_DIFF_PATH_COUNTER is a well-formatted number.

> +				then
> +					printf "do you want to skip to last time difftool save point($SAVE_POINT_NUM) [Y/n]?"

"Skip" is probably an implementation detail that the user does not
have to know.  "Do you want to start from the last file you were
viewing?", perhaps?

> +					read skip_ans || return
> +					if test "$skip_ans" = y
> +					then
> +						return
> +					fi
> +				else
> +					return
> +				fi
> +			fi
> +		fi
> +		# write the current coordinates to .git/difftool-skip-to
> +		if test !$SAVE_POINT_NUM || $SAVE_POINT_NUM -ne $GIT_DIFF_PATH_COUNTER

Have this code been tested?  I think "test" is missing after the
"||", and I am not quite sure what you are trying to check with
"test !$SAVE_POINT_NUM", either.  The "test" utility, when given a
non-operator string (like "!23" this one is checking when the last
visited path was the 23rd one), returns true if the string is not an
empty string, and by definition a string made by appending anything
after "!" would not be empty, so the entire "|| $SAVE_POINT_NUM ..."
have been skipped in your test, I think.

Is writing the current position to the file unconditionally good
enough?  After all, we are about to go interactive with the user, so
the body of this "if" statement won't be performance critical in any
sense, no?  Or is there something more subtle going on and
correctness of the code depends on this condition?  I cannot quite
tell.

> +		then
> +			echo $GIT_DIFF_PATH_COUNTER > $GIT_DIFFTOOL_SKIP_TO_FILE

		echo "$GIT_DIFF_PATH_COUNTER" >"$GIT_DIFFTOOL_SKIP_TO_FILE"

cf. Documentation/CodingGuidelines

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.  Note that
   even though it is not required by POSIX to double-quote the
   redirection target in a variable (as shown above), our code does so
   because some versions of bash issue a warning without the quotes.

	(incorrect)
	cat hello > world < universe
	echo hello >$world

	(correct)
	cat hello >world <universe
	echo hello >"$world"




> +		fi
>  		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
>  			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
>  		if use_ext_cmd
> @@ -102,4 +128,10 @@ else
>  	done
>  fi
>  
> +if test -f $GIT_DIFFTOOL_SKIP_TO_FILE &&
> +	test $GIT_DIFF_PATH_COUNTER -eq $GIT_DIFF_PATH_TOTAL
> +then
> +	rm $GIT_DIFFTOOL_SKIP_TO_FILE
> +
> +fi
>  exit 0

Wouldn't it be simpler to clear when we have reached at the end, i.e.

	if test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL"
	then
		rm -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
	fi

Thanks.
