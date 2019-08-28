Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175361F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfH1GSB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 02:18:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33421 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfH1GSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 02:18:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so939338wme.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 23:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fw7w1OytoLjGtInPjLkiBvZAxf7VFLqQy7qC5/Ih4k=;
        b=W5o1KE0G+jSHvQcyXzJKyDBl/picUeQCLO6gniMoCfLfPTmQYYxC9QYMuHa80om5LI
         eBFpOqYF1FslE5UPCNtcI8Tg2HVcfZnA7Zpjq8/urG4+lK9mCcdTFdO9u0z/yiTFSsS4
         lO2WaedkNN7qhcUBG59p1x2KghQhoIhqi14h1S4hqzxUsy6NpvX9wg8eV9y3Zb3Jtad0
         EmIM+V21HS92gGYcp8LEiWymOfyJqgg482rx9edi73fh2/fsop3Wzlu0QhkBZ/9CFBI/
         uQRyQRTw94JLmiVJO5j3B6COyXQHJlWdaLACa8IpSzB3MxkkPPOqfDFz8W+d/Vgxa/MF
         37LA==
X-Gm-Message-State: APjAAAViuP+RPEyYGqvVX7vkS1AidRCKpHd9IGAo87v2900G3bCjLmW/
        BTedy0jtFIoK1xI/IxdXDqgZc/fqKqeJ8wgMAaUbeGwi
X-Google-Smtp-Source: APXvYqz+6yDdut/vVA2a4NHUb4CGCJVF/j/lE5eHx5hD3m5IxWXojO66MXQpEP5KztMArbupfsxJ5g8oAoJqiTB5BxE=
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr2501459wmh.129.1566973078322;
 Tue, 27 Aug 2019 23:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190826235226.15386-1-newren@gmail.com> <20190828002210.8862-1-newren@gmail.com>
 <20190828002210.8862-4-newren@gmail.com>
In-Reply-To: <20190828002210.8862-4-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Aug 2019 02:17:47 -0400
Message-ID: <CAPig+cSydZnie3CSwPgfSaNcGxr1jj94YBXAL47vEXrtxaQXUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Recommend git-filter-repo instead of git-filter-branch
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 8:22 PM Elijah Newren <newren@gmail.com> wrote:
> filter-branch suffers from a deluge of disguised dangers that disfigure
> history rewrites (i.e. deviate from the deliberate changes). [...]
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> @@ -16,6 +16,20 @@ SYNOPSIS
> +WARNING
> +-------
> +'git filter-branch' has a plethora of pitfalls that can produce non-obvious
> +manglings of the intended history rewrite (and can leave you with little
> +time to investigate such problems since it has such abysmal performance).
> +These safety and performance issues cannot be backward compatibly fixed and
> +as such, its use is not recommended.  Please use an alternative history
> +filtering tool such as https://github.com/newren/git-filter-repo/[git
> +filter-repo].  If you still need to use 'git filter-branch', please
> +carefully read the "Safety" section of the message on the Git mailing list
> +https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
> +the land mines of filter-branch] and vigilantly avoid as many of the
> +hazards listed there as reasonably possible.

Is there a good reason to not simply copy the "Safety" section from
that email directly into this document so that readers don't have to
go chasing down the link (especially those who are reading
documentation offline)?

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> @@ -832,7 +832,7 @@ Hard case: The changes are not the same.::
>         This happens if the 'subsystem' rebase had conflicts, or used
>         `--interactive` to omit, edit, squash, or fixup commits; or
>         if the upstream used one of `commit --amend`, `reset`, or
> -       `filter-branch`.
> +       a full history rewriting command like `filter-repo`.

Do we want a clickable link to `filter-repo` here?

> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> @@ -123,10 +123,10 @@ The following format are available:
> +linkgit:git-hash-object[1], linkgit:git-rebase[1], and
> +linkgit:git-filter-repo[1], among other git commands, can be used to
> [...]
> @@ -148,8 +148,8 @@ pending objects.
>  linkgit:git-hash-object[1]
>  linkgit:git-rebase[1]
> +linkgit:git-filter-repo[1]

Are these 'linkgit:' references to `filter-repo` going to be
meaningful if that tool is not incorporated into the Git project
proper? Perhaps use a generic clickable link instead.

Same comment applies to other 'linkgit:' invocations in the remainder
of the patch.

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> old mode 100755
> new mode 100644

Why lose the executable bit?

> @@ -83,6 +83,19 @@ set_ident () {
> +if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
> +     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then

If this script didn't already have a mix of styles, I'd say something
about modern style being:

    if test -z "$FILTER_BRANCH_SQUELCH_WARNING" &&
        test -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
    then
        ...
    fi

> +       cat <<EOF
> +WARNING: git-filter-branch has a glut of gotchas generating mangled history
> +         rewrites.  Please use an alternative filtering tool such as 'git
> +         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
> +         See the filter-branch manual page for more details; to squelch
> +         this warning and pause, set FILTER_BRANCH_SQUELCH_WARNING=1.

The "and pause" threw me. There's more than a bit of ambiguity
surrounding it. Perhaps drop it?
