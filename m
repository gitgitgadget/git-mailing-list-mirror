Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915F11F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 19:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeGCTUY (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 15:20:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34599 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 15:20:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so11201560wmc.1
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FvCk7nAzrqSywL0nBgE0B2ew19dTwkaoCkGlPdxAOKk=;
        b=Xtqlo+3MC3P0w2t3R2142WEMftag2Y6Q0l3guUfDwlqWz0fUghZgrNAChl/ODo0DCs
         VtJj/bMYt6liB5/ofhQmGpvebn+8dirYkhC2EdgdpxHAK0AqHEr4vgLMYAC1TqAwW4Gt
         mhvZEy7OvE4QcJxbDTTUn5wyatsA7wys3Mj/fXvOMIogeJo2WjVwDZPxIwIxy/2HzS/H
         antguQ3k2YVmU7ZWXyUKiD/0wrLnJj3MJ7pVyvC0nV9rEOD6p0xEtz/4EiQugPwN2Nbl
         H5bN75c38xnu5J3X/3Z4meN3sLGsgHfUdhwBenH7trSuNYKKca8rejfEbOOQL8YMrWhN
         OQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FvCk7nAzrqSywL0nBgE0B2ew19dTwkaoCkGlPdxAOKk=;
        b=a/yIFWZRk+D1jEaTMbbALafXAqG/zG0SyzVlwU8fuwOcqQDGP0keD9glzOJ9t8/Ki5
         83f1jpQzZK08vCWubFYjmYR2paulWvt3jkPOxYl0VVsZ0kOuM4YX0QwoKJUig72HYCMe
         F+kIwii1ldH2OZePuelxBNmoVD9f5fDljJDj2B5IyR65Z8iaViYohj1y19V/N/hSzVlv
         0WNlOhFmquiuyJRwtwlklX4SbS/2ZliqaJ/OYhqNtd9touW0BJokrQ/RlNxVbPrKtq+a
         ve1ismbN+1t7l0D2zzQJinVm0HN+KxHeGbR6lJVy8GimjQim96Ia33hLedpMEJciLt4x
         hSPA==
X-Gm-Message-State: APt69E1tX1iu4Q+68JFJ2hoyEMAGYFdapdbcDIHn6Yad9oAuSV/JvE/x
        1puwr4z5uEZMM9ncQnMGoe0=
X-Google-Smtp-Source: AAOMgpcV2Ztwj/5JVUy7PyFY2HES9yftWZnsvOTAT04FI1/1d+SHQeX3dBVrv1v0YT2I8n4kkcB86w==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr5360221wmd.6.1530645622460;
        Tue, 03 Jul 2018 12:20:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f133-v6sm2978449wme.42.2018.07.03.12.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:20:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/25] t: use test_might_fail() instead of manipulating exit code manually
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-2-sunshine@sunshineco.com>
Date:   Tue, 03 Jul 2018 12:20:21 -0700
In-Reply-To: <20180702002405.3042-2-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sun, 1 Jul 2018 20:23:41 -0400")
Message-ID: <xmqqin5wqg7e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>  test_expect_success 'merge my-side@{u} records the correct name' '
>  (
> -	cd clone || exit
> -	git checkout master || exit
> -	git branch -D new ;# can fail but is ok
> +	cd clone &&
> +	git checkout master &&
> +	test_might_fail git branch -D new &&

I wonder why we had these "|| exit" in the first place, but these
are obviously good changes.

> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 1e81b33b2e..39133bcbc8 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -435,7 +435,7 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
>  	commit=$(git commit-tree $tree -p HEAD <msg) &&
>  	git update-ref HEAD "$commit" &&
>  	GIT_ALLOW_NULL_SHA1=1 git reset --hard &&
> -	(test-tool dump-cache-tree >cache-tree.out || true) &&
> +	test_might_fail test-tool dump-cache-tree >cache-tree.out &&
>  	test_line_count = 0 cache-tree.out
>  '

I wonder where the unstable expectation for the exit status comes
from.  4bddd983 ("split-index: don't write cache tree with null oid
entries", 2018-01-07) is not exactly illuminating, either X-<.

> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 0a8af76aab..6579c81216 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -102,10 +102,8 @@ test_expect_success 'apply binary patch' '
>  
>  test_expect_success 'diff --no-index with binary creation' '
>  	echo Q | q_to_nul >binary &&
> -	(: hide error code from diff, which just indicates differences
> -	 git diff --binary --no-index /dev/null binary >current ||
> -	 true
> -	) &&
> +	# hide error code from diff, which just indicates differences
> +	test_might_fail git diff --binary --no-index /dev/null binary >current &&

As you said in downthread, we only care about the correct output in
the "current" file, which is verified by using it as input to the
"apply --binary", so might-fail is fine here.  But we probably want
to make sure "diff --binary --no-index" to *notice* that there is a
difference and report that with its exit status.  I wouldn't say so
if this was about testing "git apply", but the test title tells us
that it is about "diff --no-index", so...

