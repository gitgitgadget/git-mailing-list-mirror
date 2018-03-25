Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DDB1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeCYRN1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:13:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39232 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeCYRN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:13:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id f125so11346994wme.4
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CZePaXUIRWIFfwjxpUC3khayR1XVaV7x5oqmYWEOCUk=;
        b=pE2SOCI/AfbP0R2NyakswvbklzY07fqusTlzxk98YzdutcMhBYrw/3wOV3GJYXZFtw
         h9rV/2l5dru0pysYldq0okIDO3c9fDCohF11p9I0dngPHJ3eMh0lvRArXG8R1P8yCeaa
         8B2PnlWUDjd4cCblX8XnwEz6StNas+I2Y6UOSTLdaDtcSeb1+jj2Sln87WksJtqRN7kZ
         u2ghZYVTBgZcB9VvDS4sX+F1zJ64eOvs/Drm0/qpk76a3Ix+xQR9fJFOQ4rV+JrPRzdt
         gYxzXJ7QgDbAREYG4EITVOPvcO5sEnoP5Wh3wCnlaXTLPjk06fz0+J9TemQ147RLMCgL
         jI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CZePaXUIRWIFfwjxpUC3khayR1XVaV7x5oqmYWEOCUk=;
        b=ca9sw05hOp8Zr4h1t/hDRCZC2K7xgrPuzDubj5XQzZyrXaXT2slV2YpAoJCWnLALBo
         R2+YlA62b4tg+CZ9GOcjh3yVtee56JSWCSN9nz8LPrBITU0+GCnYAJgSednTKz1E56+E
         TZQVn8jHJWxGdVyFZ9tvrACRutQ7TLeGqo0f4a5M1CW9hOAxiLqv692wWdRXmSEstUNN
         g3SnZOhqV2/ybwwzeNMXVva9218TOpBkqmTGVefFkiU08kupYLfT2cQT841O6Q/bj8HA
         Hk8mvava+4YbezbLkMPegUJCQXWewlUM7RNnkDuNuavrHj+EWPVg9+SIoWPZUUX21xfg
         STFQ==
X-Gm-Message-State: AElRT7H93Ffij/8jmbUUfRohOWYyjLVq8VA6E/rp3nk9qb/XN26Ta1i2
        aanhVhE+sSs6SagI0fh336o=
X-Google-Smtp-Source: AIpwx4/AG6GJIhhNcWJ7VPXteeL1YzcQXQJ4rNQgE+vMPT7exMcq3BJKy0x4HbyRYnDbsiVmR5tbEQ==
X-Received: by 10.28.21.77 with SMTP id 74mr9306751wmv.76.1521998005104;
        Sun, 25 Mar 2018 10:13:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l11sm12590327wrg.71.2018.03.25.10.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 10:13:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] filter-branch: fix errors caused by refs that point at non-committish
References: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
        <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
Date:   Sun, 25 Mar 2018 10:13:24 -0700
In-Reply-To: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com> (Yuki
        Kokubun's message of "Sun, 25 Mar 2018 16:54:58 +0000")
Message-ID: <xmqqy3igdqob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

> "git filter-branch -- --all" prints error messages when processing refs that
> point at objects that are not committish. Such refs can be created by
> "git replace" with trees or blobs. And also "git tag" with trees or blobs can
> create such refs.
>
> Filter these problematic refs out early, before they are seen by the logic to
> see which refs have been modified and which have been left intact (which is
> where the unwanted error messages come from), and warn that these refs are left
> unwritten while doing so.
>
> Signed-off-by: Yuki Kokubun <orga.chem.job@gmail.com>
> ---
>  git-filter-branch.sh     | 14 ++++++++++++--
>  t/t7003-filter-branch.sh | 14 ++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

Good.  Will queue.  Thanks.

>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 1b7e4b2cd..41efecb28 100755
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
> index 7cb60799b..04f79f32b 100755
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
