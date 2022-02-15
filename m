Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9CC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 06:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiBOGTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:19:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBOGTp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 01:19:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC71109A66
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 22:19:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p9so19126975ejd.6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 22:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlyvvNjLr0KguvayQx5ovFvMRUkUrfa/YnBD8RNtYEo=;
        b=RQAgUsn5nWeET5AhGafymnh7J4o8pE1pygX7kUZPhs8dic18sFEFqva/xnxum4Al0o
         4qVb3RWdP3DfD6x5ONx0xrICi3d+7/QdMquDVyrn2DzHtL3b3IfC+E7KCmSWyP11lmBY
         G0fXvz4zZaBrazxtWb4L/qqxBnQdXSM2tFGQmYbyUp3JstUtWOu/q7wJLy0lemfKc68+
         I6F6qpR+Zxvb/kOGP3htnfEflg8tR1Sh5B1F8Kt9CaFLEXS0ctLdTslNiyb/7Hot5EOF
         M8n8B5T0HbeGI4Wi9/wT+Gj+IGRhS7/6KBTVYs+H6V9GYEz6mOKLaoXMNiWyo65oB1u9
         ZJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlyvvNjLr0KguvayQx5ovFvMRUkUrfa/YnBD8RNtYEo=;
        b=dV3tRddwIVQaTy14fX68QIxF8h/Amcn9jawTWXWc5ZDKXabZYddeU3LO7lGRxmm5zw
         FLnatyX1ObFVF0aspmuar1B07+C2Bf42dJijKyhhL5gzhrz6uNQ7El4sV0qA9xSrjM7G
         ldXlMxheFOGpnbPf+ungzYnDsdYVLa8xfl+P1/Cxhr9w1TCG1AVOqGKt/ObGVpAqbGVQ
         PzNVMR+TZv516a9nEhf7fqr+eJ1qLwvWTHFu4Cw50Aw4CDV9M5hg9854u1Yvgi7djbZe
         qIyXe/AsyjfdzsZqPrPztIfNk0boUk/JIsEy7owwTOH7hbespaSUoQlHQYIctPqXWsMC
         jAGQ==
X-Gm-Message-State: AOAM531BAZrwZVsRdIHdZzaBVkRF18qebK6bS4EXL2ZGb/eYqsffsmCV
        Blj3ZZJ190hWDNIQip4Ba1spUG3Ugd0ZVx2nygzJhlDDRmA=
X-Google-Smtp-Source: ABdhPJydUT+YJBsHXNW9ojHbX6J4WP4qcRDW6snUh1879SVaCQKHRdW6A0+jqLdG/LxyD/zKLOhANdseDaduXkYZIhI=
X-Received: by 2002:a17:906:4fc5:: with SMTP id i5mr1678897ejw.729.1644905970335;
 Mon, 14 Feb 2022 22:19:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <e133c14f569116156bbd3e0ca4874e8eb54b76b8.1644565025.git.ps@pks.im>
In-Reply-To: <e133c14f569116156bbd3e0ca4874e8eb54b76b8.1644565025.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Feb 2022 07:19:19 +0100
Message-ID: <CAP8UFD2HswmXhqYTAMxQ0iYFtsErMS=DB18iv52Ujs=cAW9ytw@mail.gmail.com>
Subject: Re: [PATCH 1/6] fetch: increase test coverage of fetches
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 8:38 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> The `--atomic` flag is missing test coverage for pruning of deleted
> references and backfilling of tags, and of course both aren't covered
> correctly by this flag.

It's not clear to me what "both aren't covered correctly by this flag"
actually means here. If it means that pruning of deleted references
and backfilling of tags don't work correctly when --atomic is used,
then it could be stated more clearly. Otherwise this seems to just be
repeating the first part of the sentence.

> Furthermore, we don't have tests demonstrating
> error cases for backfilling tags.
>
> Add tests to cover those testing gaps.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

> +test_expect_success 'atomic fetch with failing backfill' '
> +       git init clone3 &&
> +
> +       # We want to test whether a failure when backfilling tags correctly
> +       # aborts the complete transaction when `--atomic` is passed: we should
> +       # neither create the branch nor should we create the tag when either
> +       # one of both fails to update correctly.
> +       #
> +       # To trigger failure we simply abort when backfilling a tag.
> +       write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> +               #!/bin/sh
> +
> +               while read oldrev newrev reference
> +               do
> +                       if test "$reference" = refs/tags/tag1
> +                       then
> +                               exit 1
> +                       fi
> +               done
> +       EOF
> +
> +       test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/something &&
> +
> +       # Creation of the tag has failed, so ideally refs/heads/something
> +       # should not exist. The fact that it does is demonstrates that there is

s/The fact that it does is demonstrates/The fact that it does demonstrates/

> +       # missing coverage in the `--atomic` flag.

Maybe s/missing coverage/a bug/ would make things clearer.

> +       test $B = "$(git -C clone3 rev-parse --verify refs/heads/something)"
> +'

As this patch series is about fixing buggy parts of the behavior with
--atomic, I think it would make more sense to use test_expect_failure,
instead of test_expect_success, in this test, and to check that we
have the correct behavior, instead of checking that we have the buggy
behavior.

Of course when later in this patch series the buggy behavior is fixed,
then test_expect_failure should be replaced with test_expect_success.

> +test_expect_success 'atomic fetch with backfill should use single transaction' '
> +       git init clone4 &&
> +
> +       # Fetching with the `--atomic` flag should update all references in a
> +       # single transaction, including backfilled tags. We thus expect to see
> +       # a single reference transaction for the created branch and tags.
> +       cat >expected <<-EOF &&
> +               prepared
> +               $ZERO_OID $B refs/heads/something
> +               $ZERO_OID $S refs/tags/tag2
> +               committed
> +               $ZERO_OID $B refs/heads/something
> +               $ZERO_OID $S refs/tags/tag2
> +               prepared
> +               $ZERO_OID $T refs/tags/tag1
> +               committed
> +               $ZERO_OID $T refs/tags/tag1
> +       EOF

The comment says that we expect to see a single reference transaction,
but the expected file we create seems to show 2 transactions. So I
think here too, we should use test_expect_failure, instead of
test_expect_success, and check that we have the correct behavior
instead of a buggy one.

> +       write_script clone4/.git/hooks/reference-transaction <<-\EOF &&

Here there is no #!/bin/sh while other uses of write_script in your
patch have it. If it's not necessary, it could be removed in the other
uses.

> +               ( echo "$*" && cat ) >>actual
> +       EOF
> +
> +       git -C clone4 fetch --atomic .. $B:refs/heads/something &&
> +       test_cmp expected clone4/actual
> +'

I took a quick look at the 2 other tests after this one, and I think
test_expect_failure should be used there too, instead of
test_expect_success.
