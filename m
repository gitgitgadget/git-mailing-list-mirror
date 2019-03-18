Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A5120248
	for <e@80x24.org>; Mon, 18 Mar 2019 04:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCRD6R (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 23:58:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRD6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 23:58:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so15389757wrm.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 20:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=tczNUwbO6ndQBTR7zrIw5oi5lKADdDBGjL3ZvQ/Ymhc=;
        b=CairQ07uy0Xtk4+x2x1X5HJEoz04rUas2EZnkELgwvAKN1vyL0MkkhArajYtMGDtMH
         3rdYNzqjxIV8Un3wPxPQy8PLaE1ahu9GwkDClrsKx6Hw4QGp6qpOXGImkxPGuYguxPMg
         JP0t+DfY4Rd4YZEOfjJd/1NWycBmFs/iaHjTJLaSLrQNR+PpQk2m7nDVtpvg4pqpgKBc
         dnplidVEC16zHVIMjWJyd4BFYCbqr4yba65UnBxttQQhxpHa5cV4n+JwjTkwQN7Pham3
         LJBFJLsBpPz44lXZPrc0RqLJaguM7I6+w2e7Kqm1ZzTvCKt+JO5YD/A/guFDL9oDrxa7
         lHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=tczNUwbO6ndQBTR7zrIw5oi5lKADdDBGjL3ZvQ/Ymhc=;
        b=irfc1itPDDsJFiOrsIpNphx2v0jrgZNq7G6R+TWapohppWHcykQuh0g1NNqTsfzyXI
         RpOVmoLQF5Fh4NYVTKQFmmxIHFGP7guwyWQoU5Cinb4qfxt+Itqch8ZpHGt4sdncr01R
         X9Ykszs2YTogtoA3qiZHaHUgOHDDHaJ3YCkiqg6XtFIXlb27YrVoEAG8EGHAM/SqBP4A
         3bRAqkUrW8ZSaHNj2zJvvMaKD6hXr/4I5REG3Uiz5akVColy19mFYJ8GlY9v0tr0aAcG
         ZZfFpschL3KS6vlkOqKFhqKdlnL543Z13o2dJLRfv4eEs4uujAAL7sEOIHQlJOyXDun6
         H35Q==
X-Gm-Message-State: APjAAAUIC1r1BXNyKwvlypNG0IokthiWjMzjfeS5YbvD7bJytKhuAPS+
        g+sVy2Jol2g2na64DgF2z6g=
X-Google-Smtp-Source: APXvYqwm7NLIWAyw8nrSVRzfhbb5nXYDolSL3mjbKt6dGcnz5ZN/2n2vfWwbaHKlviK/n7zqBjfdZw==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr9348988wrx.32.1552881494618;
        Sun, 17 Mar 2019 20:58:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 132sm21488963wmd.27.2019.03.17.20.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 20:58:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     phillip.wood123@gmail.com, git@vger.kernel.org,
        martin.agren@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] unpack-trees: fix oneway_merge accidentally carry over stage index
References: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
        <20190317060023.3651-1-pclouds@gmail.com>
Date:   Mon, 18 Mar 2019 12:58:13 +0900
Message-ID: <xmqqh8c06dgq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> One-way merge is supposed to take stat info from the index and
> everything else from the given tree. This implies stage 0 because trees
> can't have non-zero stages. The add_entry(.., old, ...) call however
> will keep stage index from the index.
>
> This is normally not a problem if the entry from the index is
> normal (stage #0). But if there is a conflict, we'll get stage #1 entry
> as "old" and it gets recorded in the final index. Fix it by clearing
> stage mask.
>
> This bug probably comes from b5b425074e (git-read-tree: make one-way
> merge also honor the "update" flag, 2005-06-07). Before this commit, we
> may create the final ("dst") index entry from the one in index, but we
> do clear CE_STAGEMASK.

Wow, good find.  That's an old one.

> I briefly checked two- and three-way merge functions. I think we don't
> have the same problem in those.
>
> Reported-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  This is one of the two bugs reported by Phillip. It's not tangled with
>  nd/switch-and-restore code changes and I'm sending it separately.

Thanks.

>
>  t/t2026-checkout-force.sh (new +x) | 26 ++++++++++++++++++++++++++

This makes it cumbersome to have the same fix in the maintenance track
as t2026 is already in use over there.  Do we need an entirely new test
just to house this new single test?

By the way, I am beginning to like these "in-line" summaries (as
opposed to the --summary at the end), although I admit that it has
been quite a while since its introduction.  Good job, again.

>  unpack-trees.c                     |  2 +-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2026-checkout-force.sh b/t/t2026-checkout-force.sh
> new file mode 100755
> index 0000000000..272ccf533a
> --- /dev/null
> +++ b/t/t2026-checkout-force.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +test_description='checkout --force'
> +. ./test-lib.sh
> +
> +test_expect_success 'force checking out a conflict' '
> +	echo a >a &&
> +	git add a &&
> +	git commit -ama &&
> +	A_OBJ=$(git rev-parse :a) &&
> +	git branch topic &&
> +	echo b >a &&
> +	git commit -amb &&
> +	B_OBJ=$(git rev-parse :a) &&
> +	git checkout topic &&
> +	echo c >a &&
> +	C_OBJ=$(git hash-object a) &&
> +	git checkout -m master &&
> +	test_cmp_rev :1:a $A_OBJ &&
> +	test_cmp_rev :2:a $B_OBJ &&
> +	test_cmp_rev :3:a $C_OBJ &&
> +	git checkout -f topic &&
> +	test_cmp_rev :a $A_OBJ

So in short, "checkout -f" should have given us an entry for path
"a", taken from the tip of the 'topic' branch, at stage #0 while
switching to that branch, but it didn't?  That would be a nice
summary to have at the beginning of the log message before going
into the implementation detail of how that happens.

> +'
> +
> +test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 22c41a3ba8..1ccd343cad 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2386,7 +2386,7 @@ int oneway_merge(const struct cache_entry * const *src,
>  		if (o->update && S_ISGITLINK(old->ce_mode) &&
>  		    should_update_submodules() && !verify_uptodate(old, o))
>  			update |= CE_UPDATE;
> -		add_entry(o, old, update, 0);
> +		add_entry(o, old, update, CE_STAGEMASK);

And the fix is obvious, makes sense and is in line with the
observation you made in the proposed log message.  

Nicely done.

Thanks.

>  		return 0;
>  	}
>  	return merged_entry(a, old, o);
