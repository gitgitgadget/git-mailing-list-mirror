Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C0C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8328661106
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347722AbhIMUBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:01:33 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:45673 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347711AbhIMUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 16:01:33 -0400
Received: by mail-ej1-f42.google.com with SMTP id e21so23522746ejz.12
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 13:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APQFvfHN6YLPpVy9FdeyssgEVH+y8D7tV/Y8hDZLLRk=;
        b=eqdZK5HwWavjzORtlj64HxsGuj5psIKFdsxsZhChWc7LAZ6wb0B2/4Rw9kzVv0Osxy
         DCNG5xgLvxH2rELZ15UvQHKPWzOjSQCKzXpCWVhOP0XjuV1nJB/MvFwRUCl9PekswHFW
         5P22HjR/wm+lZMgKLuZba+pWW2n+qqlB85O47j0AsaXuNxWv51wgyhQIJgpcG4NFtdau
         ZUPuGQHtqYahlSvzNygBUnMzirycQGqTOiDgOgqT1xGvOyJ1+wJR/lRDcrLowd7ZIKnO
         PvlzVy1Yuy8Da9xuLbVGJA95nQhATwzy+3iHWSgHapY5l2D17UoWmIxQZboMZHk0WA1D
         frOA==
X-Gm-Message-State: AOAM531xuLQAyX4bvS9SMOnv2AZWim5u1RVtLzKcfgQ8kiF7YlvfJ9Gx
        6atvBM9LsGEjfsEkIwgcqOvkIzrIfrqpW6BeIHMpGOtZqFU=
X-Google-Smtp-Source: ABdhPJygZI4B5wUJfcn7rOfwGGwJVDHNk2EyX+sHSrjy+Ho2eBLVjao1hngaz/PqnjZZaf/EwG7o9LDyJuTnZVfVf2Y=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr14468252ejd.568.1631563215770;
 Mon, 13 Sep 2021 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com>
In-Reply-To: <20210913194816.51182-1-chooglen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 16:00:04 -0400
Message-ID: <CAPig+cRZaonjCKt-rKcU0y-xNX1OQyftuEkuB4Rzhc5jCwVgMQ@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 3:48 PM Glen Choo <chooglen@google.com> wrote:
> In the "Sending V2" section, readers are directed to create v2 patches
> without using --range-diff. However, it is custom to include a range
> diff against the v1 patches as a reviewer aid.
>
> Update the "Sending V2" section to include the --range-diff option. Also
> include some explanation for -v2 and --range-diff to help the reader
> understand the importance.

Makes sense. A few minor comments below...

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> @@ -1033,18 +1033,33 @@ Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
> -When you're ready with the next iteration of your patch, the process is fairly
> -similar.
> +Let's write v2 as its own topic branch, because this will make some things more
> +convenient later on. Create the `psuh-v2` branch like so:
>
> -First, generate your v2 patches again:
> +----
> +$ git checkout -b psuh-v2 psuh
> +----

These days, we're generally promote `git switch -c psuh-v2 psuh`
rather than `git branch -b`. However, since the document already uses
`git branch -b` elsewhere, the use here is probably acceptable. (An
alternative would be to make this a two-patch series in which the
first patch changes `git branch -b` over to `git switch -c`.)

> +When you're ready with the next iteration of your patch, the process is fairly
> +similar to before. Generate your patches again, but with some new flags:
>
>  ----
> -$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
> +$ git format-patch -v2 --range-diff psuh..psuh-v2 --cover-letter -o psuh/ master..psuh
>  ----

As long as both versions have the same base, it's generally easier to
say merely `--range-diff=psuh` -- that is, you want a range-diff
against `psuh` -- than to spell out the range explicitly. However,
perhaps spelling out the range here has some pedagogical value, so
maybe this is okay as-is.

> +The `--range-diff psuh..psuh-v2` parameter tells `format-patch` to include a
> +range diff between `psuh` and `psuh-v2`. This helps tell reviewers about the
> +differences between your v1 and v2 patches.

I think we usually spell it as "range-diff", not "range diff". Also,
it might be a good idea to give some hint as to what a range-diff is,
even if that hint is just a link to the `git range-diff` manual page.
Maybe:

    ...to include a range-diff (see linkgit:range-diff[1]) between...
