Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38531F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeGLQOz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:14:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41111 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeGLQOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:14:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so15730139wrr.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0M8WMSNMJ6VkQ26TRjI7U9jGVEBRZwVmqyKJ09aJTsQ=;
        b=tm+AaMOQyiy51WP/UgPMKZ51b/OrW+2nOqcuMyFLb13u8QVOUtoPlGV7MeY19Eibux
         h5dLRv9PA98i4vYDbfCyA1JlIMEMpswU0UCkOiPpFg5YFcfufuDH+NgDow6z6tdSlIB7
         7L9+4Q3Ay3alpl/LNXTiYUJQe37K+elgJS/+T0rOTpDnBfRR2EL9qm8o/cmfb5R1+l3w
         ny0kkA8lbAb+oLI5V59eGoNX3tEmHrUzOLn9mPSL6/Gi2e73jQKDS2aPzRhkbHP/ndgm
         XBxwXiQTlIokCWj1cBM9b0qc5GO4kwfRLEBT9AUWa3auWqwkpTbirxdzGYWt32GSxlzz
         pDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0M8WMSNMJ6VkQ26TRjI7U9jGVEBRZwVmqyKJ09aJTsQ=;
        b=n8FkaSPyi0LZZto8MmK5l115UcEnAClJF4FzsN+VypezROu+QKIyxuj7mPfnGO1Rzj
         s277Y667RM4AqwgctMVRVwU+rNo/NYYsMSic6SE7q0B3vDCaJastvBS29uRSImIYYvqI
         1dh4BTek2MiaStL55O8esmrvdeVKazeg1A4hFTAQeVW/11MCll0+8kWhR5i1YwzE5DHm
         oDQVQWCmioNYZzaslnAzEKFr/o5R8SVUae6P7ErQKnMtEqrTjpaFMmYYkL7ikbZYPv9R
         XldcMnd1GaSv0jY/hQpq/NB1C2n3iGwhSJIM7p2hKCGr01BzZ0RJ6nB7AyvXnKKrQ2iR
         aQ7g==
X-Gm-Message-State: AOUpUlEv3dS3XM5Bka9nMLIHrSGEZxfd7g3Brzahxoa+AurkH6IGGiU+
        8qhaimTkTFx9fOu1TTPPUSQ=
X-Google-Smtp-Source: AAOMgpeIjISMs4RKGRrZnEVvqammO5zDVJ1jdBAGrMFKEz6LGcXvN9x5EzcBl0MeyZdao9u3K+RzmA==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr2345584wrj.118.1531411481930;
        Thu, 12 Jul 2018 09:04:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u25-v6sm2942340wrd.61.2018.07.12.09.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 09:04:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
        <20180712054909.29077-1-wchargin@gmail.com>
Date:   Thu, 12 Jul 2018 09:04:41 -0700
In-Reply-To: <20180712054909.29077-1-wchargin@gmail.com> (William Chargin's
        message of "Wed, 11 Jul 2018 22:49:09 -0700")
Message-ID: <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Chargin <wchargin@gmail.com> writes:

> This patch broadens the set of commits matched by ":/" pathspecs to

As we discussed during the review on v1, ":/<substring in commit>"
is *NOT* pathspec (that is why having these tests in t4208 is wrong
but we are following existing mistakes).  It is a way to specify a
commit object name (unfortunately "extended SHA-1" is the phrase we
often call the various ways to name an object that are implemented
in sha1-name.c).

> include commits reachable from HEAD but not any named ref. This avoids
> surprising behavior when working with a detached HEAD and trying to
> refer to a commit that was recently created and only exists within the
> detached state.
>
> If multiple worktrees exist, only the current worktree's HEAD is
> considered reachable. This is consistent with the existing behavior for
> other per-worktree refs: e.g., bisect refs are considered reachable, but
> only within the relevant worktree.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: William Chargin <wchargin@gmail.com>
> Based-on-patch-by: Jeff King <peff@peff.net>

Now you have Peff's sign-off for the one-liner code change, the last
one is redundant.

> ---

Other than the above two nits, the patch looks good.  I would have
broken the line after "including HEAD.", but the slightly-long line
is also OK.

>  Documentation/revisions.txt   |  2 +-
>  sha1-name.c                   |  1 +
>  t/t4208-log-magic-pathspec.sh | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 7d1bd4409..aa9579eba 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -184,7 +184,7 @@ existing tag object.
>    A colon, followed by a slash, followed by a text, names
>    a commit whose commit message matches the specified regular expression.
>    This name returns the youngest matching commit which is
> -  reachable from any ref. The regular expression can match any part of the
> +  reachable from any ref, including HEAD. The regular expression can match any part of the
>    commit message. To match messages starting with a string, one can use
>    e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
>    is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
> diff --git a/sha1-name.c b/sha1-name.c
> index 60d9ef3c7..641ca12f9 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
>  			struct commit_list *list = NULL;
>  
>  			for_each_ref(handle_one_ref, &list);
> +			head_ref(handle_one_ref, &list);
>  			commit_list_sort_by_date(&list);
>  			return get_oid_oneline(name + 2, oid, list);
>  		}
> diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
> index 62f335b2d..4c8f3b8e1 100755
> --- a/t/t4208-log-magic-pathspec.sh
> +++ b/t/t4208-log-magic-pathspec.sh
> @@ -25,6 +25,32 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
>  	git log :/a --
>  '
>  
> +test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --detach &&
> +	# Must manually call `test_tick` instead of using `test_commit`,
> +	# because the latter additionally creates a tag, which would make
> +	# the commit reachable not only via HEAD.
> +	test_tick &&
> +	git commit --allow-empty -m detached &&
> +	test_tick &&
> +	git commit --allow-empty -m something-else &&
> +	git log :/detached --
> +'
> +
> +test_expect_success '"git log :/detached -- " should not find an orphaned commit' '
> +	test_must_fail git log :/detached --
> +'
> +
> +test_expect_success '"git log :/detached -- " should find HEAD only of own worktree' '
> +	git worktree add other-tree HEAD &&
> +	git -C other-tree checkout --detach &&
> +	test_tick &&
> +	git -C other-tree commit --allow-empty -m other-detached &&
> +	git -C other-tree log :/other-detached -- &&
> +	test_must_fail git log :/other-detached --
> +'
> +
>  test_expect_success '"git log -- :/a" should not be ambiguous' '
>  	git log -- :/a
>  '
