Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431861F954
	for <e@80x24.org>; Wed, 22 Aug 2018 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeHWAIy (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 20:08:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51965 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeHWAIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 20:08:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so3172036wma.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=31mFI7DokuBoGxYkPL88fvHRm03KBuitUut05jNaUj0=;
        b=rFZAgskn3FVyBNpAYLS1BK4CxflkxZpgp2z7AqgL9zJjIO/m3sJy3QTAa2DX3UFw6r
         6cmU6PHZmHQqp2lGUvJn6esPSJ6SlBCB/KTq61A1tC3T9Lv1JaGjth4erebcN6RB6EWO
         2t4vCuKIqLkPeQpekLv4C79d4No0aVMms4WKUC5wfxUW3nP6C0U36FEgO3Y5X1GqwvCh
         aN9Qs8xKIEBJxqVIzzf1EG1utV5/SrkkpbYj100rzetbN7htEMxf1YVFYx+No0mVljmS
         C6IhP3csEqzdDW/c0ccf4MXksFRIicscCB/k71T7EH5ZUS+LQ5pj+7BkWFOm5f5nb670
         gnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=31mFI7DokuBoGxYkPL88fvHRm03KBuitUut05jNaUj0=;
        b=HIQmN4Cl3eC8zImLiS3M7D32SRlFNBBPHZVd9JAmoZGzamErRlvFf893hzou49rODq
         fGhX42w7wsXIfK+2ExpYk2dP+/XOkT3AK0JM+ELS54MBQBIdEZC1sXBFJb1u81do7ZIN
         RhFMXaB4lk0H4+ZLpaerM237GvNSYIe4JT5hxZR0UwXIY8/VZSnO8d4gC+PpYBZnGQj7
         O1h9O3qzHC5kV7T99XiyfFQON2adXrUmnAWU4RwXpbtdFcb8xeQRRtSUf+HI9uFlA2Nb
         Mt6GUHh3DdKnhJtRCgu1/5ehjYKstOhRsKvVfZnMFnE5P6B8I69XCVPsjS0gvQL0g8xH
         Ry8A==
X-Gm-Message-State: APzg51DgsPluR+d6zyFRSqadh/SWTvZ82u1M7gM+vLTQAPVe0lo1wQJe
        dgkEs1mj5AY/NE2QLiQpFlg=
X-Google-Smtp-Source: ANB0VdYqWigMH1933yfrxOQGVehvJCKyzBTVecfaJVepXliv492Y0/UsA/+uXfG4Qemtb4WoT7qUxg==
X-Received: by 2002:a1c:5bc7:: with SMTP id p190-v6mr3273066wmb.101.1534970547320;
        Wed, 22 Aug 2018 13:42:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t6-v6sm2993276wmf.8.2018.08.22.13.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 13:42:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-list: make empty --stdin not an error
References: <20180727174811.27360-1-avarab@gmail.com>
        <20180822174820.12909-1-szeder.dev@gmail.com>
        <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
        <20180822192308.GB19730@sigill.intra.peff.net>
        <20180822195045.GC19730@sigill.intra.peff.net>
Date:   Wed, 22 Aug 2018 13:42:26 -0700
In-Reply-To: <20180822195045.GC19730@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 22 Aug 2018 15:50:46 -0400")
Message-ID: <xmqqa7pem8ul.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Instead, let's keep two flags: one to denote when we got
> actual input (which triggers both roles) and one for when we
> read stdin (which triggers only the first).
>
> This does mean a caller interested in the first role has to
> check both flags, but there's only one such caller. And any
> future callers might want to make the distinction anyway
> (e.g., if they care less about erroring out, and more about
> whether revision.c soaked up our stdin).
>
> [1] https://public-inbox.org/git/20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net/
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/rev-list.c       | 2 +-
>  revision.c               | 1 +
>  revision.h               | 5 +++++
>  t/t6018-rev-list-glob.sh | 2 +-
>  4 files changed, 8 insertions(+), 2 deletions(-)

I think this makes sense, but if we were to give a dedicated field
in the revs structure, can we lose the local variable at the same
time, I wonder?

Thanks.

> diff --git a/revision.c b/revision.c
> index de4dce600d..4d53102cf4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2369,6 +2369,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  				}
>  				if (read_from_stdin++)
>  					die("--stdin given twice?");
> +				revs->read_from_stdin = 1;
>  				read_revisions_from_stdin(revs, &prune_data);
>  				continue;
>  			}
> diff --git a/revision.h b/revision.h
> index 007278cc11..1225957927 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -82,6 +82,11 @@ struct rev_info {
>  	 */
>  	int rev_input_given;
>  
> +	/*
> +	 * Whether we read from stdin due to the --stdin option.
> +	 */
> +	int read_from_stdin;
> +
>  	/* topo-sort */
>  	enum rev_sort_order sort_order;
>  
> diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
> index 0bf10d0686..db8a7834d8 100755
> --- a/t/t6018-rev-list-glob.sh
> +++ b/t/t6018-rev-list-glob.sh
> @@ -255,7 +255,7 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
>  	compare rev-list "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
>  '
>  
> -test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
> +test_expect_success 'rev-list should succeed with empty output on empty stdin' '
>  	git rev-list --stdin </dev/null >actual &&
>  	test_must_be_empty actual
>  '
