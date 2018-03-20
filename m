Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E921F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCTQy3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:54:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46360 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeCTQyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:54:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id s10so2411501wra.13
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hWQ4RsiGsf39Jy+ea4VUoUeT/msW3JSnVqUrKCol9dw=;
        b=Ygy44mzNgakDaT6lYzdtaPn7cNhKo1MQR8Yn8bHpMKjGsWoDw1gsDOJjrH92WqcyD2
         ZxSOM4xTpxzebxKomfdWUG6w+qFN5pp6EmlznBWHveI+PnVd8nBok1wuheCzSbD4hiRf
         KT8xTmc7TrVQXlcotr6NaxSdYraDbbC92OZw96bZXnSEnFoE+Wp/DN+T8v+RYP82Gs+Z
         emqlptQ9U5GkpKHnEFr00QfXY3KCsNHLEROSIehsc6YHpLepY91kpgs5UxGAHNo7jQIh
         U1pLS1rWl2NmCanZJfEZraDshj8k2dEzEhInZRPor+kHGGhWVfhEHFOLHuetqtdHvr2R
         YMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hWQ4RsiGsf39Jy+ea4VUoUeT/msW3JSnVqUrKCol9dw=;
        b=srAX8hewuOz6sBty/TaeOzuyW72SpNYo1qF8FpNH07IokoepBU+ctWcLlP/69iv4YY
         WIbWfca/YU6/PT7BbyvJCjnaDPbmsMArDHeTdZGpj+3rlksF7xhYwkGyP2ip0ntUyEPI
         XV2yXfPAwoXkvy63OwS9m3Xhegrf2gUxw1Boitd6ipTowbu/tzTypidbVZ6HRW8kHxI8
         lHwzzpx/lP1+Fc746qM7w2yzTkVzBnjU/Y/FvIBFeDtqy98zQLm5C6FCBMdZKXlElNXp
         PjMi5spgC7XrDBpRodAhDkvfQBHHrkfV9ezjL0SoRC0QzC8BBVX25DtWmB7btpC8Gsum
         0MRg==
X-Gm-Message-State: AElRT7FCcCa94/JgYoTyu6BvdNNPJp5NirU8gupZt2voc5/f5miCHx2D
        TGoE25DLv1VjUws7i94Dr3g=
X-Google-Smtp-Source: AG47ELsNKTBVGA127TmTVW+ICPB1rlnZaAFIWyATZ1ayVH3keEWOusvFuA8zTUjmfcIat23P1PpMyA==
X-Received: by 10.223.209.194 with SMTP id m2mr489426wri.214.1521564862569;
        Tue, 20 Mar 2018 09:54:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w6sm1987798wre.25.2018.03.20.09.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 09:54:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v5 2/3] stash push: avoid printing errors
References: <20180316223715.108044-1-gitster@pobox.com>
        <20180319232156.30916-1-t.gummerer@gmail.com>
        <20180319232156.30916-3-t.gummerer@gmail.com>
Date:   Tue, 20 Mar 2018 09:54:21 -0700
In-Reply-To: <20180319232156.30916-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Mon, 19 Mar 2018 23:21:55 +0000")
Message-ID: <xmqqzi32sn5u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> ...
> Fix this by avoiding the 'git clean' if a pathspec is given, and use the
> pipeline that's used for pathspec mode to get rid of the untracked files
> as well.

That made me wonder if we can get rid of 'git clean' altogether by
pretending that we saw a pathspec '.' that match everything when no
pathspec is given---that way we only have to worry about a single
codepath.

But I guess doing it this way can minimize potential damage.  Those
who do not use pathspec when running "git stash" won't be affected
even if this change had some bugs ;-)

> diff --git a/git-stash.sh b/git-stash.sh
> index 4c92ec931f..5e06f96da5 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -308,14 +308,16 @@ push_stash () {
>  	if test -z "$patch_mode"
>  	then
>  		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
> -		if test -n "$untracked"
> +		if test -n "$untracked" && test $# = 0
>  		then
>  			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
>  		fi
>  
>  		if test $# != 0
>  		then
> -			git add -u -- "$@"
> +			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
> +			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
> +			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
>  			git diff-index -p --cached --binary HEAD -- "$@" |
>  			git apply --index -R
>  		else

Thanks, I'll take the change as-is.

I however wonder if we restructure the code to

	if test $# = 0
	then
		# no pathspec
		if test -n "$untracked"
		then
			git clean --force --quiet -d $CLEAN_OPTION -- "$@"
		fi
		git reset --hard -q
	else
		test -z "$untracked" && UPDATE=-u || UPDATE=
		test "$untracked" = all && FORCE=--force || FORCE=
		git add $UPDATE $FORCE-- "$@"
		git diff-index -p --cached --binary HEAD -- "$@" |
		git apply --index -R
	fi

it becomes easier to understand what is going on.

That way, once we have a plumbing command to help the else clause of
the above, i.e. "git checkout --index <tree-ish> -- <pathspec>"
[*1*], then we can lose the if/then/else and rewrite the whole "we
have created stash, so it's time to get rid of local modifications
to the paths that match the pathspec" code to:

	if test "$untracked"
	then
		git clean --force --quiet -d $CLEAN_OPTION -- "$@"
	fi
	git checkout --index HEAD -- "$@"

[Footnote]
cf. https://public-inbox.org/git/xmqq4loqplou.fsf@gitster.mtv.corp.google.com/

What we want in the case in the code in question when there is
pathspec is "match the index entries and the working tree files to
those that appear in a given tree for paths that match the given
pathspec".  This is close to "git checkout <tree-ish> -- <pathspec>"
but not quite.  Current "git checkout <tree-ish> -- <pathspec>" is
an overlay operation in that paths that match <pathspec> but do not
exist in <tree-ish> are *NOT* removed from the working tree.  We
obviously cannot change the behaviour of the command.

But we can add an option to ask for the new behaviour.  In general,
for an operation that affects the index and the working tree, we can
have "--cached" mode that affects only the index without touching
the working tree, and "--index" mode that affects both.

"git reset <tree-ish> -- <pathspec>", which is a UI mistake, is
better spelled "git checkout --cached <tree-ish> -- <pathspec>".  We
take paths that match <pathspec> from <tree-ish> and stuff into the
index, and remove entries from the index for paths that do not exist
in <tree-ish>.  And if we extend that to "--index" mode, that is
exactly what we want to happen.
