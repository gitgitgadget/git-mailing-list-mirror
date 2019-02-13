Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECA41F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbfBMKIH (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:08:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51407 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBMKIH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:08:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so1783685wmj.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yBiKzc7Vnlz1fwKZjnjDTr5KX/6er3q/hvsf4EYYtvk=;
        b=hj0mCOPNunarqVgI6fWrIQNF0HnGRiueEVsD0bCMkqiWmFYFwgX2+uVdeS4WMbaMSj
         HfhH0G4q2kq1FmvyZxzOKY60SHkMXHs2kAJ044imvm6b4IuLftdfOwND/Y9xEUaQ+zFl
         kE64b5ECoYPh718duNqCMlkLIxn1eCbIB0r8xhtgY/3y1zPnzp9exr0b62F4FgaPIccs
         xu8pjHimvxsW87I48tA1VpbisQ7yw48aSj9QLWeIDdXjBG6owy4JlwHYnregZQ+bhmff
         PrLhbR4b30tnR3bX8q3OWxfznJJkEScPVY7yuhrQj4MYUrcBIEiD9x9wsWlZ+m7++U0+
         7xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yBiKzc7Vnlz1fwKZjnjDTr5KX/6er3q/hvsf4EYYtvk=;
        b=pfs7hZxxLmn0RTn3JjfnNTSc72ABunzC1BPwZxpwXpBGjJDkFX5ThtBVRCEnCQVz0q
         BvfXf8yEQytH1MG5LrCyIFHsT10yK6flGdkLZ0YsdR12CIb73vSBrPfFOJLf5WRWKixw
         kVjAa6QNJNEnkguMpXA7ipkqvREhoD2zZlrCShzoe679QPsNXR1Xr33FWjTvj/xV71A/
         1m67FiXF35ToqA9PMN46UO6KeVkln/8+WXWw9fT7CR3HA7J0YojSxKp/cQZGtgOxca8+
         Nr9WZMsI1fH7CVUAiFZ9R5ZjZzMj3AhKqtSkCDoBAoYZxG2v01pCnoUC2ERcEQmol5ec
         rK/Q==
X-Gm-Message-State: AHQUAubtWSesETnuJZ9PE0EnFLW10R09vMMKPl8AH4iUBEo2zJwcAgzM
        NZGSWU+rVJ4RCYyW4cbz548=
X-Google-Smtp-Source: AHgI3IZdw2TaK6pOXRTZ2EImwJqS7jyiRagrQXVrbduETOApcsGDIaqOQzEfbLeDMs5W1ahiK1yFTg==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr2744218wmi.28.1550052484393;
        Wed, 13 Feb 2019 02:08:04 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id e17sm9826872wrs.79.2019.02.13.02.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 02:08:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
References: <20190130231359.23978-1-max@max630.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190130231359.23978-1-max@max630.net>
Date:   Wed, 13 Feb 2019 11:08:01 +0100
Message-ID: <87lg2kj91a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 31 2019, Max Kirillov wrote:

> If packed-refs is marked as sorted but not really sorted it causes
> very hard to comprehend misbehavior of reference resolving - a reference
> is reported as not found.
>
> As the scope of the issue is not clear, make it visible by failing
> pack-refs command - the one which would not suffer performance penalty
> to verify the sortedness - when it encounters not really sorted existing
> data.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> I happened to have a not really sorted packed-refs file. As you might guess,
> it was quite wtf-ing experience. It worked, mostly, but there was one branch
> which just did not resolve, regardless of existing and being presented in
> for-each-refs output.
>
> I don't know where the corruption came from. I should admit it could even be a manual
> editing but last time I did it (in that reporitory) was several years ago so it is unlikely.
>
> I am not sure what should be the proper fix. I did a minimal detection, so that
> it does not go unnoticed. Probably next step would be either fixing in `git fsck` call.
>
>  refs/packed-backend.c               | 15 +++++++++++++++
>  t/t3212-pack-refs-broken-sorting.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100755 t/t3212-pack-refs-broken-sorting.sh

This is not an area I'm very familiar with. So mostly commeting on
cosmetic issues with the patch. FWIW the "years back" issue you had
could be that an issue didn't manifest until now, i.e. in a sorted file
format you can get lucky and not see corruption for a while with a
random insert.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index c01c7f5901..505f4535b5 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1088,6 +1088,7 @@ static int write_with_updates(struct packed_ref_store *refs,
>  	FILE *out;
>  	struct strbuf sb = STRBUF_INIT;
>  	char *packed_refs_path;
> +	struct strbuf prev_ref = STRBUF_INIT;
>
>  	if (!is_lock_file_locked(&refs->lock))
>  		BUG("write_with_updates() called while unlocked");
> @@ -1137,6 +1138,20 @@ static int write_with_updates(struct packed_ref_store *refs,
>  		struct ref_update *update = NULL;
>  		int cmp;
>
> +		if (iter)
> +		{
> +			if (prev_ref.len &&  strcmp(prev_ref.buf, iter->refname) > 0)

You have an extra two whitespaces after "&&" there.

> +			{
> +				strbuf_addf(err, "broken sorting in packed-refs: '%s' > '%s'",
> +					    prev_ref.buf,
> +					    iter->refname);
> +				goto error;
> +			}
> +
> +			strbuf_init(&prev_ref, 0);
> +			strbuf_addstr(&prev_ref, iter->refname);
> +		}
> +
>  		if (i >= updates->nr) {
>  			cmp = -1;
>  		} else {
> diff --git a/t/t3212-pack-refs-broken-sorting.sh b/t/t3212-pack-refs-broken-sorting.sh
> new file mode 100755
> index 0000000000..37a98a6fb1
> --- /dev/null
> +++ b/t/t3212-pack-refs-broken-sorting.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +test_description='tests for the falsely sorted refs'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git commit --allow-empty -m commit &&

Looks like just "test_commit A" would do here.

> +	for num in $(test_seq 10)
> +	do
> +		git branch b$(printf "%02d" $num) || break
> +	done &&

We can fail in these sorts of loops. There's a few ways to deal with
that. Doing it like this with "break" will still silently hide errors:

    $ for i in $(seq 1 3); do if test $i = 2; then false || break; else echo $i; fi; done && echo success
    1
    success

One way to deal with that is to e.g. before the loop say "had_fail=",
then set "had_fail=t" in that "||" case, and test for it after the loop.

But perhaps in this case we're better off e.g. running for-each-ref
after and either using test_cmp or test_line_count to see that we
created the refs successfully?

> +	git pack-refs --all &&
> +	head_object=$(git rev-parse HEAD) &&
> +	printf "$head_object refs/heads/b00\\n" >>.git/packed-refs &&

Looks like just "echo" here would be simpler since we only use printf to
add a newline.

> +	git branch b11
> +'
> +
> +test_expect_success 'off-order branch not found' '
> +	! git show-ref --verify --quiet refs/heads/b00
> +'
> +
> +test_expect_success 'subsequent pack-refs fails' '
> +	! git pack-refs --all
> +'

Instead of "! git ..." use "test_must_fail git ...". See t/README. This
will hide e.g. segfaults.

Also, perhaps:

    test_must_fail git ... 2>stderr &&
    grep "broken sorting in packed-refs" stderr

Would make this more obvious/self-documenting so we know we failed due
to that issue in particular.
