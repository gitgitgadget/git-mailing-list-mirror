Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4956C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877726105A
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 07:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhJGHvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbhJGHvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 03:51:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE00C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 00:49:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l7so19879449edq.3
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=a1gjxL+3MXCe7EAGakkHdYxhCCC3GL06ittcHg3XGu8=;
        b=QbuOqC08jiIOcLT61KijDvi0NtTKjw1gJSA5k69ato3dR6vHAm7uNLFc+Rbn8TSkKU
         METZc81A61XJ/o3nQrzTjgxyQNAkxpbtWOgmr9vQ2Qsy2lcZU+LqHmMb8RWAncSlc1rc
         4xmFdN+CKf3edTc9QZF6/l5Nzh3QZKlbDaM6QS3zEccb+8Mh1u2zoy16mHK2W8EN+KtV
         6nFnF0BBrRrdhHFXIDWRhdd8cgFLGyZQJG+QFAuV2dD1dewo+Ps4L+aDAaMCq0ToEJmW
         nZhSxo6yDx9geNFi7BFtKAdaYsy1ij+Mh7I4btCE/YMwZiT7HOzmexYD/2W6zZkEFLSl
         /QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=a1gjxL+3MXCe7EAGakkHdYxhCCC3GL06ittcHg3XGu8=;
        b=B9puJFrHjnNXkzBHpBwps1FCW9lUKne3WBzhPMf6hU6CQEVZCptThNiAli4Z/ZPtib
         Pj/11OB5ClVWyAUKF6HQ6nOh2k6aMm3Q8S/PN7A9kYDBmgNtEfFdIthMDVcKB2882fjc
         LkN0c2twT0647riV7sfgaZ/SG0YqMEc+OJxVEJl+rh8BqdC9A0Gbc/v4zU4TCUoRWL0i
         LfZkvkD3SvI7oq7MlL424LTi6UmoYFMN20rObHnAU0Qqyb6VrOTVnp8/szjwK6/7BLSD
         YoXVgYOrNyb3TqhjK31w81cAVAbXmtrz3fyDGsEbZGU3SfuCbMIVd27dASPahnSLz1vv
         GNpA==
X-Gm-Message-State: AOAM533d1M6ns7jraT6jdKyoVZEhH0QDdIozwzf0LG3HSiMPUz5YDQvZ
        mew5oMJ9QwTcyWHgL/FpI8U=
X-Google-Smtp-Source: ABdhPJy50KWUmJlt6qj7Kys0iA+UtozuQu7iHdarYvWNzNXYsK9l24pOpHO0QZbL9mhCiLHSb6HHYA==
X-Received: by 2002:a17:906:c249:: with SMTP id bl9mr3566337ejb.225.1633592975260;
        Thu, 07 Oct 2021 00:49:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx22sm4586668edb.0.2021.10.07.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 00:49:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Date:   Thu, 07 Oct 2021 09:42:11 +0200
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
Message-ID: <87sfxdgtpu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, Jeff King wrote:

> On Wed, Oct 06, 2021 at 10:24:40PM -0400, Jeff King wrote:
>
>> On Wed, Oct 06, 2021 at 05:24:14PM -0700, Junio C Hamano wrote:
>> 
>> > * tb/repack-write-midx (2021-10-01) 9 commits
>> >   (merged to 'next' on 2021-10-06 at ccdd5aaf2a)
>> >  + builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
>> >  + builtin/repack.c: make largest pack preferred
>> >  + builtin/repack.c: support writing a MIDX while repacking
>> >  + builtin/repack.c: extract showing progress to a variable
>> >  + builtin/repack.c: rename variables that deal with non-kept packs
>> >  + builtin/repack.c: keep track of existing packs unconditionally
>> >  + midx: preliminary support for `--refs-snapshot`
>> >  + builtin/multi-pack-index.c: support `--stdin-packs` mode
>> >  + midx: expose `write_midx_file_only()` publicly
>> > 
>> >  "git repack" has been taught to generate multi-pack reachability
>> >  bitmaps.
>> > 
>> >  Will merge to 'master'.
>> 
>> Sorry not to catch this before it hit 'next', but there's a small leak
>> in the test helper. This patch can go on top to fix it.
>
> The reason for that is that I didn't find it by inspection; I've started
> running my personal builds through coverity. It wasn't too bad to set up
> with a GitHub Action, like so:
>
> ---
>  .github/workflows/coverity.yml | 35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 .github/workflows/coverity.yml
>
> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> new file mode 100644
> index 0000000000..bfd4dff275
> --- /dev/null
> +++ b/.github/workflows/coverity.yml
> @@ -0,0 +1,35 @@
> +name: coverity-scan
> +on: push
> +
> +jobs:
> +  latest:
> +    runs-on: ubuntu-latest
> +    steps:
> +      - uses: actions/checkout@v2
> +      - run: ci/install-dependencies.sh
> +      - name: Download Coverity Build Tool
> +        run: |
> +          wget -q https://scan.coverity.com/download/linux64 --post-data "token=$TOKEN&project=peff/git" -O cov-analysis-linux64.tar.gz

Interesting mix...

> +          mkdir cov-analysis-linux64
> +          tar xzf cov-analysis-linux64.tar.gz --strip 1 -C cov-analysis-linux64
> +        env:
> +          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
> +
> +      - name: Build with cov-build
> +        run: |
> +          export PATH=$(pwd)/cov-analysis-linux64/bin:$PATH
> +          cov-build --dir cov-int make
> +
> +      - name: Submit the result to Coverity Scan
> +        run: |
> +          tar czvf git.tgz cov-int
> +          curl \

...of curl & wget :)

> +            --form project=peff/git \
> +            --form token=$TOKEN \
> +            --form email=peff@peff.net \
> +            --form file=@git.tgz \
> +            --form version=$(git rev-parse HEAD) \
> +            --form description="$(./git version)" \
> +            https://scan.coverity.com/builds?project=peff/git
> +        env:
> +          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
>
> Is there interest in having something like this in the main repo? We'd
> need to tweak some values:

I'm very interested in it, it would be great to have more CI targets,
even if optional.

>   - we have to send the project name (here peff/git); we can presumably
>     get this on the fly from the Actions envir

Our $CI_REPO_SLUG I believe. See
https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
& a grep for CI_REPO_SLUG in git.git.

>   - any repo which wants to use this has to set up the secret token
>     (COVERITY_SCAN_TOKEN here). That involves creating a coverity
>     account, and then setting the token in the GitHub web interface.
>     Presumably we'd just bail immediately if that token isn't set, so
>     forks aside from git/git would have to enable it independently.

I tried creating one of these now, requested access at
https://scan.coverity.com/projects/git & it's pending.

Maybe I should have clicked the "connect with GitHub" at the beginning,
but it wanted (ro) ACL access to all organizations I was in, including
private boards or something. So I went for the generic sign-up.

>   - likewise it needs the email address for the coverity account. That
>     could probably be set in the environment, too.
>
>   - we'd probably want to only run it for integration branches, since
>     coverity sets some limits on how often it runs. This could probably
>     be set in another environment variable, so people could tweak it for
>     their forks if they wanted to (or we could use the ci-config hacks,
>     but I put those together mostly because these environment variables
>     didn't exist back then; I suspect we could switch off of them now).
>
> There are tons of existing warnings, many of which are false positives.
> But it keeps track of which problems are new, and emails out a summary
> of only the new ones (which is how I saw the leak here, which just hit
> next). I don't care all that much about leaks here (we have other
> techniques for finding them), but when Stefan used to do regular
> coverity builds in the past, it routinely found useful errors.
>
> If we had it running on git/git, it's possible for people to subscribe
> to those notifications (or view them on the site; both require the
> people to have coverity accounts, but they're free).
>
> Thoughts?

Sounds good, I wonder if they (if contacted) provide upon request some
community-wide keys for projects such as git, so it would Just Work for
forks without their owners needing to sign up themselves...
