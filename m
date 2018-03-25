Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FAD1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeCYQZG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:25:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55982 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeCYQZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:25:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id t7so11238116wmh.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nwAK8eqoXTTh6uoO2YGijFWmt1Kyrw+e7XbvyqgXPEE=;
        b=ma8E9U61tbVXgyaSmm07F4i9fXO0PRgVfcS3DmAKqljRJDD6Wc0dYexOgs+DSshV2C
         vHeGMqMDAutczTOK1JlbPMBBWviJzmLzEqCkVZCDh3GToCchtWm8HDl4uub0wZFbNkrk
         KEYN++RvJJCAC9AE6P6PcAjOigDH9JiIegb3XlUfEB6DxmvEA6pu7ZGxYer9434ErdBo
         0QY8YBQArdff9g2amTjS9TdBCUUekT8TfWmVAZu7JpQI4eT/bqfumkJ8ef4dXDyPiwuG
         Am3GXVTzWMbgQZwXEk27AY8AuUpj2aXL4TC/F3bMbMqcbCpTjG7cO6wNxfrJO3DmUnkG
         4xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nwAK8eqoXTTh6uoO2YGijFWmt1Kyrw+e7XbvyqgXPEE=;
        b=Lj3qSM25seVh+d9QH7Lk1oKZbLuNAbxF2ehMm8B8jkl9o/y0/RndOeDlZKsat6P44c
         lTNgLYMGbU21mFqEKv9pHlk8f/AFBEmcUHvEt+xxfWqKu0/FSPT5J0vkulbxhPV+GqFg
         VIBu2NCN/uTohgHEK3imq/BkbfbZyNlj2a2jzpIounj5XZ9bi/6TL23JfxtRTUmmiX0E
         aS7F29e4vbuYFPEwrP6txakwsb+jyIEHChbGgEaJUfMjp4LQzPMH+5QJ0243F+b9aVRV
         YfAeB1X/BAnI041Vkqj5hQHDIYz/X1xSsrWWIZBy5Ix6d93moOsfQXPlyN+73z22tOaU
         UONA==
X-Gm-Message-State: AElRT7E44n0lLyL3r1TPyRYrX3TQWTvZX1H4oQUMdAJIfuGp9C0rXME5
        +lwJYuWDvR0aFohjVM+GrcQ=
X-Google-Smtp-Source: AIpwx48f/U2uSIsnkPX7GfynwUH7fHOW4Lffs9sc7KvesfkUcuF1E0X9pztsQlsgKvVtRwQykQldaQ==
X-Received: by 10.28.174.67 with SMTP id x64mr3956342wme.104.1521995103542;
        Sun, 25 Mar 2018 09:25:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f10sm8796191wrg.67.2018.03.25.09.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:25:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] filter-branch: fix errors caused by refs that point at non-committish
References: <xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
        <1521920467-6091-1-git-send-email-orga.chem.job@gmail.com>
Date:   Sun, 25 Mar 2018 09:25:02 -0700
In-Reply-To: <1521920467-6091-1-git-send-email-orga.chem.job@gmail.com> (Yuki
        Kokubun's message of "Sat, 24 Mar 2018 19:41:07 +0000")
Message-ID: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

> "git filter-branch -- --all" print error messages when refs that point at
> objects that are not committish.

Grammo (third-person singular 'prints' misspelt without 's'; the
"when" clause has a complex subject but no verb).

Perhaps this will salvage what you meant:

	"git filter-branch -- --all" prints error messages when
	processing refs that point at objects that are not
	committish.

> Such refs can be created by "git replace" with
> trees or blobs. And also "git tag" with trees or blobs can create such refs.
>
> Filter these problematic refs out early, before they are seen by the logic to
> see which refs have been modified and which have been left intact (which is
> where the unwanted error messages come from), and warn that these refs are left
> unwritten while doing so.
> ---

Please sign-off your patch (cf. Documentation/SubmittingPatches).

Otherwise this round looks good.

Thanks.

>  git-filter-branch.sh     | 14 ++++++++++++--
>  t/t7003-filter-branch.sh | 14 ++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 1b7e4b2..41efecb 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -251,8 +251,18 @@ done < "$tempdir"/backup-refs
>  
>  # The refs should be updated if their heads were rewritten
>  git rev-parse --no-flags --revs-only --symbolic-full-name \
> -	--default HEAD "$@" > "$tempdir"/raw-heads || exit
> -sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
> +	--default HEAD "$@" > "$tempdir"/raw-refs || exit
> +while read ref
> +do
> +	case "$ref" in ^?*) continue ;; esac
> +
> +	if git rev-parse --verify "$ref"^0 >/dev/null 2>&1
> +	then
> +		echo "$ref"
> +	else
> +		warn "WARNING: not rewriting '$ref' (not a committish)"
> +	fi
> +done >"$tempdir"/heads <"$tempdir"/raw-refs
>  
>  test -s "$tempdir"/heads ||
>  	die "You must specify a ref to rewrite."
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 7cb6079..04f79f3 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -470,4 +470,18 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
>  	git show HEAD:$ambiguous
>  '
>  
> +test_expect_success 'rewrite repository including refs that point at non-commit object' '
> +	test_when_finished "git reset --hard original" &&
> +	tree=$(git rev-parse HEAD^{tree}) &&
> +	test_when_finished "git replace -d $tree" &&
> +	echo A >new &&
> +	git add new &&
> +	new_tree=$(git write-tree) &&
> +	git replace $tree $new_tree &&
> +	git tag -a -m "tag to a tree" treetag $new_tree &&
> +	git reset --hard HEAD &&
> +	git filter-branch -f -- --all >filter-output 2>&1 &&
> +	! fgrep fatal filter-output
> +'
> +
>  test_done
