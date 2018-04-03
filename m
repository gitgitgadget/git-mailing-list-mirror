Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DBF1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754924AbeDCIAk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:00:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43346 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeDCIAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:00:37 -0400
Received: by mail-qt0-f195.google.com with SMTP id s48so18218245qtb.10
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6XyJUCee5bMmiD5THn3ImpjMDquIAwI7IlFo4yX4bI4=;
        b=ddHPK5+bwvEABrm7g4PXnjXUL+H/H8ZNW8mbCrYohmgCmaZ932oS3qR/TBC7qelots
         v83oyqwOlngWXDsKYTU2/GSm60gQcFTRYt4g2PeYDipuUeadCFMdgHduQGmblWIayOYL
         zweDu2nITZmVsC2qLVZVW/cBz28xPeaPFxzAnghITs9Jyl4IsaPUx37NjbWUZm2zZfz2
         GEhFcgnosqxsLGV0JAX8RoFCwLO8UT9+pMnQ1gZxohKztKlI68Ykr9PVoQLoKn4c8epm
         NPF+s+vfORlWiRtEq37EXyas+4gE8/Uwl0Q6Zx75UIaEhgPahldXjUCQmND6o7Hu3xnL
         AJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6XyJUCee5bMmiD5THn3ImpjMDquIAwI7IlFo4yX4bI4=;
        b=eizeSIfnuN4DeGmv0Q3B8uSVQEQkH1aH9lBC+SBkyi9ENFj7TUwbKGC803s+E8xbEk
         9OUkUS/FIRAoAJT8rDacupVsiQJcdYg7r7eqC0dDk5CkqsRmVYE9ihPWUrdlXRcwVM5/
         m2u93nkc3iNgjM1Ym3ItKzLSI1Z7PSDgCKH5Rn6sVbzJtgH0qkhts8lc6JwfFMk8p7G3
         nPchIRLFFjE5v4JQ925+kRyLteMYzBo44Rm0/gzkeGpSOq+nYkP1KNLLMdwRqhOWEdeg
         WzrOvoeslJ+fJs0Igk12NLLuxflRkK3B4F9lcWPah3OTqe7vVssbW61nTQ7KAw5GdEFW
         8XjA==
X-Gm-Message-State: ALQs6tA7OIDcNC0rCCNHEiV9oBoqSHC7PVvuQu6MKRM5vFBbTyOweFrm
        gC98rwNDWCQVicBvJvoX8HAwzxUKzf2t8ob+XWU=
X-Google-Smtp-Source: AIpwx49c7JadzGfE3rZMKQoxk8c56ni6ROSATFjpOyOEl7DKjUQr9t4k4t4X3KpzINDzu9vsgqGxJZEJ/U9kS/44Nb4=
X-Received: by 10.200.42.37 with SMTP id k34mr19219595qtk.101.1522742437025;
 Tue, 03 Apr 2018 01:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 3 Apr 2018 01:00:36 -0700 (PDT)
In-Reply-To: <20180403043101.4072-2-kaartic.sivaraam@gmail.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-1-kaartic.sivaraam@gmail.com> <20180403043101.4072-2-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Apr 2018 04:00:36 -0400
X-Google-Sender-Auth: hMuJVfUW__MSYaFjiG33h0DiLr8
Message-ID: <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t3200: verify "branch --list" sanity when rebasing
 from detached HEAD
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 12:31 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> "git branch --list" shows an in-progress rebase as:
>
>   * (no branch, rebasing <branch>)
>     master
>     ...
>
> However, if the rebase is started from a detached HEAD, then there is no
> <branch>, and it would attempt to print a NULL pointer. The previous
> commit fixed this problem, so add a test to verify that the output is
> sane in this situation.
>
> Note that the "detached HEAD" test case might actually fail in some cases
> as the actual output of "git branch --list" might contain remote branch
> names which is not considered by the test case as it is rare to happen
> in the test environment.

This paragraph was not in the original patch[1]. I _think_ what you
are saying (which took a while to decipher) is that if a command such
as "git checkout origin/next" ever gets inserted into the script
before the test, the test will be fooled since "git branch --list"
will show "detached HEAD origin/next" rather than "detached HEAD
d3adb33f", the latter of which is what the test is expecting.

Unfortunately, this paragraph makes it sound as if the test can fail
randomly (which, I believe, is not the case), and nobody would want a
test added which is unreliable, thus this paragraph is not helping to
sell this patch (in fact, it's actively hurting it). Ideally, the test
should be entirely deterministic so that it can't be fooled like this.
Rather than including this (harmful) paragraph in the commit message,
let's ensure that the test is deterministic (see below).

[1]: https://public-inbox.org/git/20180325054824.GA56795@flurp.local/

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible with --no-merged' '
> +test_expect_success '--list during rebase from detached HEAD' '
> +       test_when_finished "reset_rebase && git checkout master" &&
> +       git checkout HEAD^0 &&

This is the line which I think is causing concern for you. If someone
inserted a new test before this one which invoked "git checkout
origin/next" (or something), then even after "git checkout HEAD^0",
"git branch --list" would still report the unexpected "detached HEAD
origin/next". Let's fix this, and make the test deterministic, by
doing this instead:

    git checkout master^0 &&

Thanks.

> +       oid=$(git rev-parse --short HEAD) &&
> +       FAKE_LINES="1 edit 2" &&
> +       export FAKE_LINES &&
> +       set_fake_editor &&
> +       git rebase -i HEAD~2 &&
> +       git branch --list >actual &&
> +       test_i18ngrep "rebasing detached HEAD $oid" actual
> +'
