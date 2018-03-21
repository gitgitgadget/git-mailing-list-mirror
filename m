Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF171F404
	for <e@80x24.org>; Wed, 21 Mar 2018 17:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCURVw (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 13:21:52 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33617 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCURVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 13:21:51 -0400
Received: by mail-wr0-f169.google.com with SMTP id z73so5995763wrb.0
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X2baUVmwh649SeK8nW9e8gDGhMflyw26gMdrX+xdhEA=;
        b=al2D9K/Q4MGVUslKoMhXbOBXm8l1aiHuwEdTl3l6m42XdcPwgQYZZ8jZB/LX+Xz9zm
         TNOOdbq3T+ul1uBzxaoA2GbJCXE3+1pkbI91DVzDmIBLXCiYCFCdJGce5p9QjFwmBA8F
         MCRFf/24HiVkZSvUCEsTt9srPyzGSRCPYNjNfXUlIySuWjMB8Z9E1QGp/kIlRORRiQ0D
         /0CmcvZvuCHbvJKdWXH8xjlUCHfaYLvYbaO52MPEgaAOLZeuKF1ugyDDisy2fiaMYsqb
         FQraHsGYofinkXuaGtH0DcLybipn3QCtUsPt3dhDVDAqx/YOUIwoGFQuFRHSESww5aA2
         BdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X2baUVmwh649SeK8nW9e8gDGhMflyw26gMdrX+xdhEA=;
        b=R3uHYJF+7MZI7qt+yBI91TewUqnPu6Am9MetViT4TmvkJcQXtJvmV8NdILIEJ3SNlZ
         Zp3mJ4pIrQZyS6o4qbn1SBG2wMO6n7qzCIjYEXqBVSv1rscuzxkldvdIGraA+GLeViou
         KbPiv/EQQV4RvA2R89BpoBknwKeb6d4qvrC07nTqAkfntYD1spnEKC8DK0DxmI2Tkk40
         +T0XgjqI8BwUdcbn2RMgeGR0Fb3Te11nIXTJyPie3X4/Wg0tCztJpK/XND8HmHh0TgR+
         7BVW1XJSMLZsqPPC/xXrRD/7qIyox9xqwqQN6x2kjShoGYJeG4iFBbE0COLwvwbul8eR
         SxrQ==
X-Gm-Message-State: AElRT7HpVtGbgkLbmChBigwhAIH8zMF3VRoFqcj6eZfhUz37HgjgL1pK
        a9kGgrTSWDOkT1AapXjd1X4=
X-Google-Smtp-Source: AG47ELuY42TPQBKcGJFRJbg7yLncXR3YQNvW/2wA4TqEj1crLwly0RRMhYn7TLulAvkRM3yIULb3eg==
X-Received: by 10.223.196.82 with SMTP id a18mr17749501wrg.164.1521652909757;
        Wed, 21 Mar 2018 10:21:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j126sm4287457wmb.33.2018.03.21.10.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 10:21:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <20180321103504.9483-1-orga.chem.job@gmail.com>
        <20180321103504.9483-1-orga.chem.job@gmail.com>
        <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
Date:   Wed, 21 Mar 2018 10:21:47 -0700
In-Reply-To: <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com> (Yuki
        Kokubun's message of "Wed, 21 Mar 2018 15:31:39 +0000")
Message-ID: <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

> "git filter-branch -- --all" can be confused when refs that refer to objects
> other than commits or tags exists.
> Because "git rev-parse --all" that is internally used can return refs that
> refer to an object other than commit or tag. But it is not considered in the
> phase of updating refs.

Could you describe what the consequence of that is?  We have a ref
that points directly at a blob object, or a ref that points at a tag
object that points at a blob object.  The current code leaves both of
these refs in "$tempdir/heads".  Then...?

	... goes and looks ...

There is a loop that looks like this:

	while read ref
	do
		sha1=$(git rev-parse "$ref^0")
		...
	done <"$tempdir/heads"

which would break on anything but a commit-ish.

>  # The refs should be updated if their heads were rewritten
>  git rev-parse --no-flags --revs-only --symbolic-full-name \
> -	--default HEAD "$@" > "$tempdir"/raw-heads || exit
> +	--default HEAD "$@" > "$tempdir"/raw-objects || exit
> +# refs/replace can refer to an object other than commit or tag

Mention of replace refs in the proposed log message gives an easy to
understand example and is a good idea, but this in code comment does
not have to single out the replace refs.  A tag can also point at an
object with any type, e.g. "git tag v2.6.11-tree v2.6.11^{tree}"
would make "refs/tags/v2.6.11-tree" point at the tree at the top
level of the tree-ish "v2.6.11".  It probably is OK to drop this
comment altogether.

> +while read ref
> +do
> +	type=$(git cat-file -t "$ref")
> +	if test $type = commit || test $type = tag
> +	then
> +		echo "$ref"
> +	fi
> +done >"$tempdir"/raw-heads <"$tempdir"/raw-objects
>  sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads

So... is the idea to limit the set of refs to be rewritten to those
that point at commits and tags?  As I already alluded to, I do not
think you want to accept a ref that points at any tag object---only
the ones that point at a tag that points at a commit-ish, so that
the code will not barf when doing "$ref^0".

So perhaps

	git rev-parse --no-flags ... >"$tempdir/raw-heads" || exit

	while read ref
	do
		case "$ref" in ^?*) continue ;; esac
		if git rev-parse --verify "$ref^0" 2>/dev/null
                then
			echo "$ref"
		fi
	done >"$tempdir/heads" <"$tempdir/raw-heads"

or something?  Note that you do not need the "sed" as the loop
already excludes the negative revs.

>  test -s "$tempdir"/heads ||
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 7cb60799b..efeaf5887 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -470,4 +470,17 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
>  	git show HEAD:$ambiguous
>  '
>  
> +test_expect_success 'rewrite repository including refs/replace that point to non commit object' '
> +	test_when_finished "git reset --hard original" &&
> +	tree=$(git rev-parse HEAD^{tree}) &&
> +	test_when_finished "git replace -d $tree" &&
> +	echo A >new &&
> +	git add new &&
> +	new_tree=$(git write-tree) &&
> +	git replace $tree $new_tree &&

Perhaps something like this here:

	git tag -a "tag to a tree" treetag $new_tree &&

can tell su how well it works with a tag that points at a tree?

> +	git reset --hard HEAD &&
> +	git filter-branch -f -- --all >filter-output 2>&1 &&
> +	! fgrep fatal filter-output
> +'
> +
>  test_done
