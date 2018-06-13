Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280AF1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935381AbeFMRmh (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 13:42:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53280 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935163AbeFMRmg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 13:42:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so6122372wmc.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qd50MJqOZDTBuJ4S6JHbZ+IpZiWjdWexqQnkrqOkrjY=;
        b=Ity/aZHLqlUAW7QodZk83IeoM/EG06SoaelZOJ8dpYe+BaLFdXs7hY+EN3Xfi0NWTZ
         3IZLwMEt7n0AiBCj4kWU/dppeN8cB3Wr2dF902eu/UOTMyA6EUCHEAJkj8Tf4rOsNswy
         QtlbAh4eWgRo8Gm2WObNPjpaH0uX090PDVaz8oJUS63XOdrfiQ3IxEjNwvS4IFnpNUOz
         Fza+P/KdHX0Pbylc/y0m8E2GQYFpRtAduPqTt4r0Rtin2q/kmjrKOSbOebmQexub8mlp
         B4zYYbocTL0mgEwkP2F3S/715B0TczqQH3HjtxJkkVrZki7AzSsdIqjCzKo94QG8y1zQ
         a88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qd50MJqOZDTBuJ4S6JHbZ+IpZiWjdWexqQnkrqOkrjY=;
        b=hDIF+NQq+cZma9ZFk07eiMadr+V6KFCNr/UXA8x7tCdYTFsmS0d1HLWHCx2bg1Y1+7
         V//R8GWZ9EgJ/2/0gwlvtvYadZ+uPzI9I5nH22d2XyTkMQu9cQK1Njp/tuXYRFnY8dcQ
         k6bFVpnd1qKiUBe4TG3q6Iui9siLFpkyZmON27OUaU4SOCczn3ftKmWrQjsz21guPfM7
         qw+xicVkz6twxaPsiVp0eXPNwP5WQ20LS9e/nXz2xHSfJ/nY803GL5ObKANDsuIarXFG
         q+1alaH+TkiXKh/Qub1K7y/B8XnpwGD1bvYkva3z89eIBPL31LAXhFK7ZvDnO7vX+AZH
         u46g==
X-Gm-Message-State: APt69E3frxdg12q14M4RgPrOAVjJKEYv0LMabwn0Un6q2RlIcWYzhSox
        J+K1SsmrpDleVwg7qO/TLFY=
X-Google-Smtp-Source: ADUXVKL/UfmLhrA7yXvrepldgFug3DW09sVlI/sdasJUtv5m1Reo9Ve/tmRQZLVUdvHR5rRfpeUzCA==
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr4405431wma.21.1528911754489;
        Wed, 13 Jun 2018 10:42:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b204-v6sm3689362wmh.22.2018.06.13.10.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 10:42:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
References: <20180612185413.GA21856@deco.navytux.spb.ru>
        <20180613111840.1427-1-kirr@nexedi.com>
Date:   Wed, 13 Jun 2018 10:42:33 -0700
In-Reply-To: <20180613111840.1427-1-kirr@nexedi.com> (Kirill Smelkov's message
        of "Wed, 13 Jun 2018 11:18:56 +0000")
Message-ID: <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Fetch-pack --all became broken with respect to unusual tags in
> 5f0fc64513 (fetch-pack: eliminate spurious error messages, 2012-09-09),
> and was fixed only recently in e9502c0a7f (fetch-pack: don't try to fetch
> peel values with --all, 2018-06-11). However the test added in
> e9502c0a7f does not explicitly cover all funky cases.

Thanks.  Very much appreciated

>
> In order to be sure fetching funky tags will never break, let's
> explicitly test all relevant cases with 4 tag objects pointing to 1) a
> blob, 2) a tree, 3) a commit, and 4) another tag objects. The referenced
> tag objects themselves are referenced from under regular refs/tags/*
> namespace. Before e9502c0a7f `fetch-pack --all` was failing e.g. this way:
>
>         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
>         440858748ae905d48259d4fb67a12a7aa1520cf7        HEAD
>         ...
>         bc4e9e1fa80662b449805b1ac29fc9b1e4c49187        refs/tags/tag-to-blob                   # <-- NOTE
>         038f48ad0beaffbea71d186a05084b79e3870cbf        refs/tags/tag-to-blob^{}
>         520db1f5e1afeaa12b1a8d73ce82db72ca036ee1        refs/tags/tag-to-tree                   # <-- NOTE
>         7395c100223b7cd760f58ccfa0d3f3d2dd539bb6        refs/tags/tag-to-tree^{}
>         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
>         fatal: A git upload-pack: not our ref 038f48ad0beaffbea71d186a05084b79e3870cbf
>         fatal: The remote end hung up unexpectedly

... except for this bit.  I am not sure readers understand what
these two overlong lines want to say.  Would it be easier to
understand if you wrote the above like this?

         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
         44085874...        HEAD
         ...
         bc4e9e1f...        refs/tags/tag-to-blob
         038f48ad...        refs/tags/tag-to-blob^{}	# peeled
         520db1f5...        refs/tags/tag-to-tree
         7395c100...        refs/tags/tag-to-tree^{}	# peeled
         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
         fatal: A git upload-pack: not our ref 038f48ad...
         fatal: The remote end hung up unexpectedly

Instead of marking the tag-to-blob and tag-to-tree entries (which
are not where the 'fatal' breakage comes from), I think it makes
more sense to mark the entries that show peeled version (which also
matches the object name in the error message), and by shortening the
line, readers can see more easily which lines are highlighted.

> +test_expect_success 'test --all wrt tag to non-commits' '
> +	blob=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
> +	git tag -a -m "tag -> blob" tag-to-blob $blob &&
> + \
> +	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git tag -a -m "tag -> tree" tag-to-tree $tree &&
> + \
> +	tree2=$(printf "100644 blob $blob\tfile2" | git mktree) &&
> +	commit=$(git commit-tree -m "hello commit" $tree) &&
> +	git tag -a -m "tag -> commit" tag-to-commit $commit &&
> + \
> +	blob2=$(echo "hello blob2" | git hash-object -t blob -w --stdin) &&
> +	tag=$(printf "object $blob2\ntype blob\ntag tag-to-blob2\n\
> +tagger author A U Thor <author@example.com> 0 +0000\n\nhello tag" | git mktag) &&
> +	git tag -a -m "tag -> tag" tag-to-tag $tag &&

All of the above, while may not be techincallly wrong per-se, look
unnecessarily complex.

I guess the reason why you do the above is because you do not want
to use any object that is reachable via other existing refs and
instead want to ensure these objects are reachable only via the tags
you are creating in this test.  Otherwise using HEAD~4:test.txt and
HEAD^{tree} instead of $blob and $tree constructed via hash-object
and mktree would be sufficient and more readable.  Oh well.


> +	mkdir fetchall &&
> +	(
> +		cd fetchall &&
> +		git init &&
> +		git fetch-pack --all .. &&
> +		git cat-file blob $blob >/dev/null &&
> +		git cat-file tree $tree >/dev/null &&
> +		git cat-file commit $commit >/dev/null &&
> +		git cat-file tag $tag >/dev/null
> +	)
> +'
> +
>  test_expect_success 'shallow fetch with tags does not break the repository' '
>  	mkdir repo1 &&
>  	(
