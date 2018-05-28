Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE681F42D
	for <e@80x24.org>; Mon, 28 May 2018 16:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940397AbeE1QuP (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 12:50:15 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45099 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933396AbeE1Qt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 12:49:59 -0400
Received: by mail-qk0-f195.google.com with SMTP id c198-v6so9537311qkg.12
        for <git@vger.kernel.org>; Mon, 28 May 2018 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R0RN9eQXywR6vx+j5wuy09CCPyxFKjxWNUE0VZ+75Q=;
        b=odqBRvpZgpGglkuXf/716re8YrqHk29N1FWtscOW84+iMqyCkVuO/S4UUVNinUPdR2
         i7beZhS7YzEqZIic/IbTHPPveb7QK1G5a/gebR8BD6eh1Zr6biNpCSj0xlrE0g+7LNBh
         ZSVnIXzBj1jlyNeMMqWzmgPaEpN29RWCsyuoTviMLkDdZbUPIEvuLqN5DEmXF2kZ+P4v
         w9/akbo/IRAcG4IIc6pRE5myPRKPl960XbK4aY8qi/MGvIkShTMiL993NufSRWn141Du
         V/ruOW5RnFVhHPP3xK7/Fn6GsYn3Iccltb1sDd0CeK9h9UpanJlX7iaImUk2BwyW+8i/
         oTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R0RN9eQXywR6vx+j5wuy09CCPyxFKjxWNUE0VZ+75Q=;
        b=nhy5X1XjzA7KvBXpvJUHTZk6WcDeng+TDtA8eP8VfpG6ZIEhRW7oK6/6fGPzaB1erz
         86P2ODCVLwCbgh76sKrWqnO7JhIor8AdkD37H5mxsLv7rtt0lX19iRIzjEhMn3+9TdU5
         bGOWVW2bJJFQGk0N5JjwbgrlyTnhl/JeCwGKmjB4QcrK715zmt28nUTFwsid5hZTeBti
         2yxSWI9xAodcINq9kpYJ1W1s+NvwFtSna6eJX5kg9Tx1BTwos1xeSHwe23zQXsvIUtcx
         Xqmh8ZQO8y/eMAtzUonaCGjn6CBnbbWUfGr3PtVnmvgNmpDKX2rOGovqHMwQv7AGr6ZA
         JM9w==
X-Gm-Message-State: ALKqPwdOCoMsw3m1NK1o26n7zztlJjqfHPrwpXsiynLYIfZ5mIZzwfdf
        LddPrQWMnMrhGBOqPM+7Z9QFcVB3k6X1U9O5ays=
X-Google-Smtp-Source: ADUXVKI8gbOyycIQr2o6Wl9dOaCuIbdk8wRWrwYny11PUkXLgbDpjf1IIWqgTEbq0ZnBwuMd4sZp/jisrDFGpg1V3rU=
X-Received: by 2002:a37:24d3:: with SMTP id k80-v6mr1786652qkk.109.1527526198905;
 Mon, 28 May 2018 09:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180528092017.19022-1-tiagonbotelho@hotmail.com> <xmqqpo1fj1qv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpo1fj1qv.fsf@gitster-ct.c.googlers.com>
From:   Tiago Botelho <tiagonbotelho@gmail.com>
Date:   Mon, 28 May 2018 17:49:47 +0100
Message-ID: <CAADF+x2q6HwW3BaLt76ZVikyu8Rz0Ykbf7iD=dBORigaONmtDA@mail.gmail.com>
Subject: Re: [RFC PATCH v4] Implement --first-parent for git rev-list --bisect
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        tiagonbotelho@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 May 2018 at 15:25, Junio C Hamano <gitster@pobox.com> wrote:

> Tiago Botelho <tiagonbotelho@gmail.com> writes:

> > This will enable users to implement bisecting on first parents
> > which can be useful for when the commits from a feature branch
> > that we want to merge are not always tested.
> >
> > Signed-off-by: Tiago Botelho <tiagonbotelho@hotmail.com>
> > ---
> >
> > This patch adds all Junio's suggestions, namely do_find_bisection()
being
> > broken when assigning q's weight to p if in first parent mode and q
being
> > not UNINTERESTING and its weight still not being known.
> >
> > The graph displayed in the unit tests was also changed from being
top-bottom
> > to be left-right in order to keep it consistent with graphs in other
tests.
> >
> >  bisect.c                   | 45
++++++++++++++++++++++++++++++---------------
> >  bisect.h                   |  3 ++-
> >  builtin/rev-list.c         |  3 +++
> >  revision.c                 |  3 ---
> >  t/t6002-rev-list-bisect.sh | 37 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 72 insertions(+), 19 deletions(-)

> > diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> > index a66140803..774d9a4fd 100755
> > --- a/t/t6002-rev-list-bisect.sh
> > +++ b/t/t6002-rev-list-bisect.sh
> > @@ -263,4 +263,41 @@ test_expect_success 'rev-parse --bisect can
default to good/bad refs' '
> > ...
> > +test_output_expect_success "--bisect-all --first-parent" 'git rev-list
--bisect-all --first-parent FX ^A' <<EOF
> > +$(git rev-parse EX) (dist=1)
> > +$(git rev-parse D) (dist=1)
> > +$(git rev-parse FX) (dist=0)
> > +EOF
> > +
> >  test_done

> Running this test number of times gives me spurious errors.  Is the
> order of these output lines unstable?  How do we "sort" these
> bisect-all results?  If we are not sorting and the output depends on
> happenstance, then probably we would need to compare the expected
> and actual output after sorting.  Or if the output depends on
> something under our control (e.g. they are related to topology and
> relative commit timestamp), we probably should try to control that
> "something" tighter so that we can rely on the order of the lines in
> the "expect" file.

The reason why the tests were failing was because the above "old" tests
did not make use of test_commit which in turn would make the sha of each
commit be different and as a result give unexpected outputs at times.
If I move them to the top of that file the tests will pass every time,
would that
be ok?

> It also appears that we have "--bisect and --first-parent do not
> work well together" in t6000, which also needs to be updated.  I
> needed the following squashed into this patch to make "make test"
> pass.

> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index 969e4e9e52..981198ae6e 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -96,8 +96,8 @@ test_expect_success 'rev-list can show index objects' '
>          test_cmp expect actual
>   '

> -test_expect_success '--bisect and --first-parent can not be combined' '
> -       test_must_fail git rev-list --bisect --first-parent HEAD
> +test_expect_success '--bisect and --first-parent can now be combined' '
> +       git rev-list --bisect --first-parent HEAD
>   '

>   test_expect_success '--header shows a NUL after each commit' '
