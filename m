Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499D01F85A
	for <e@80x24.org>; Mon,  9 Jul 2018 20:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbeGIUUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:20:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54707 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeGIUUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:20:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so22250806wmf.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4Qy4f9lMDT5/GEI9JMwoZw1jC9QGrqK1mD1xDbJpBXY=;
        b=Y5zSs5NQSUgUnpUmElpbIMGZL+MeEHwwu5+X0OjGXpPzt/FHSLsgGqHbcSuwryen9t
         m6qXpaoN3AUgsfpvz35n7evU+qsxG2+dkgga23N2cLgQAumTsujDdKyx4t8yH5qSbQ6s
         fmgUiwoLRXzmODbaNSsC5H0WsFGXks9AGN28wwXC1Ka15FN2OOZ9pj6SQSFvcQzexQdt
         UNeUp5aHd5aRfYMAFuZXmfB2OLNxmS6dprbUH+4YQS4rx7NZ/KO5ScG5OZw/G8Ycz8DX
         urmzc3rhmDoX3kJXbb5tTXITqtuU/hsW6Nmu+AIM3EjGO1LvfRo4MsEsjekHWb5BnWTI
         nvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4Qy4f9lMDT5/GEI9JMwoZw1jC9QGrqK1mD1xDbJpBXY=;
        b=CQN0myki7rNDvzlJQIM0u2bOroKoYV6yim+q/Qwd27rfT0LBKEUCVJskUuxKozv6Kt
         v1vXrBAcLRzk/nsY4U5/G2jNW8n88lEmxa5H6ynStA8CEyGV5lylM8IYx+VCHdbuq7ZS
         br62RuNXdnYy6qKO+ZYsacSjXhAp3wTlVw3a+6njKd7eSEjQnd+r2y5a9QeNAHD2v5KW
         1yfYvkEH12RTTkXN1qyG8gfUDnCu2zv45qKopHnfC3p5eyTrKZojF8UpKBGfmfhVZnCb
         zDfnVjg0819ifelxL4IpXJYBgmpuiASXShqH16Yu4j3n5vVIGK5q+NeEo/qkPoiTIoT5
         1Uyw==
X-Gm-Message-State: APt69E0OP7IFYysFmAFY3z18oKh7j4iOtEIx06XRCZF246+ia+k6slhZ
        Iji3VQV1NU4AI/ZjRRnch+4=
X-Google-Smtp-Source: AAOMgpdGb3z6k+Fp+bpTuiWJLOK1LGAeiGNAj4L0+eu60znsyET/klDE6NQn2hyiOzDw5NuYkhz0kQ==
X-Received: by 2002:a1c:f46:: with SMTP id 67-v6mr12099043wmp.122.1531167634197;
        Mon, 09 Jul 2018 13:20:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20771871wri.72.2018.07.09.13.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:20:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: handle empty-set cases consistently
References: <20180709194636.GB9852@sigill.intra.peff.net>
        <20180709194819.GA7980@sigill.intra.peff.net>
Date:   Mon, 09 Jul 2018 13:20:33 -0700
In-Reply-To: <20180709194819.GA7980@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 9 Jul 2018 15:48:19 -0400")
Message-ID: <xmqqlgakcga6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If the user gives us a set that prepare_revision_walk()
> takes to be empty, like:
>
>   git cherry-pick base..base
>
> then we report an error. It's nonsense, and there's nothing
> to pick.
>
> But if they use revision options that later cull the list,
> like:
>
>   git cherry-pick --author=nobody base~2..base
>
> then we quietly create an empty todo list and return
> success.
>
> Arguably either behavior is acceptable, but we should
> definitely be consistent about it. Reporting an error
> seems to match the original intent, which dates all the way
> back to 7e2bfd3f99 (revert: allow cherry-picking more than
> one commit, 2010-06-02). That in turn was trying to match
> the single-commit case that exited before then (and which
> continues to issue an error).

Other than s/exited/existed/, the above looks perfect ;-)  I wish
all analysis part of proposed log messages were written like this.



>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sequencer.c                     | 6 ++++--
>  t/t3510-cherry-pick-sequence.sh | 7 ++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..f692b2ef44 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1863,8 +1863,6 @@ static int prepare_revs(struct replay_opts *opts)
>  	if (prepare_revision_walk(opts->revs))
>  		return error(_("revision walk setup failed"));
>  
> -	if (!opts->revs->commits)
> -		return error(_("empty commit set passed"));
>  	return 0;
>  }
>  
> @@ -2317,6 +2315,10 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>  			short_commit_name(commit), subject_len, subject);
>  		unuse_commit_buffer(commit, commit_buffer);
>  	}
> +
> +	if (!todo_list->nr)
> +		return error(_("empty commit set passed"));
> +
>  	return 0;
>  }
>  
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index b42cd66d3a..3505b6aa14 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -480,11 +480,16 @@ test_expect_success 'malformed instruction sheet 2' '
>  	test_expect_code 128 git cherry-pick --continue
>  '
>  
> -test_expect_success 'empty commit set' '
> +test_expect_success 'empty commit set (no commits to walk)' '
>  	pristine_detach initial &&
>  	test_expect_code 128 git cherry-pick base..base
>  '
>  
> +test_expect_success 'empty commit set (culled during walk)' '
> +	pristine_detach initial &&
> +	test_expect_code 128 git cherry-pick -2 --author=no.such.author base
> +'
> +
>  test_expect_success 'malformed instruction sheet 3' '
>  	pristine_detach initial &&
>  	test_expect_code 1 git cherry-pick base..anotherpick &&
