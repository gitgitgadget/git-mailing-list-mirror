Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA1C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AEC610FB
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhIMV7E convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Sep 2021 17:59:04 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40823 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhIMV7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 17:59:03 -0400
Received: by mail-ej1-f53.google.com with SMTP id o20so13534050ejd.7
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 14:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xh3uCGErhfeyw0aXfYTzPoitKfF3lGL0RJzYAzJ+RW8=;
        b=cHSO6FN2ORKTjWw3a29lIRB54msilo0hH2toRPo+dgsHbcCape7/6vlJ2KZjwzHlKW
         Awiu2/vwtF3IqZVuKcE3/uxjeeBs6PQ1s3QBWEl0oih75KzHY2aATqEhjHDsuV5sC7EB
         S9HXhamcZrcH6hLssqpeG4SjScY/Y9qavDd+Me2eY8kEaYSXYubKYqom3Alftx37+uIy
         eP7e1RogoN8cg4Z8JpJLwOIRCaWacZyH/PMHNUfkaQdDk3EScexiVXyNd3luQF5F0vBy
         7+4oozlyWdHxhovk6qvjt6hUTlmpUxUqeGw3Qo1S5BmSsGIATDVl1u77WYdFtxbnDzqn
         gghg==
X-Gm-Message-State: AOAM530nO8mO+na5I9kr9bMY1pxVHu27Nr5Tlv5/8KFArhZgOwMz1G/h
        /u5uhxQpxBn/5GfLAS9UEvYxETb+RMDJMRt43cw2aNM7rjU=
X-Google-Smtp-Source: ABdhPJzFddMA0Rl5PA9C16NxI3+p2pbDIMRNtkZZ+x9OUFb0LpuHfP4toGoIRC+lgvSFLVcKEI+JsG+UtLqdeFUOACk=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr14719159ejr.36.1631570265994;
 Mon, 13 Sep 2021 14:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210913185941.6247-1-alban.gruin@gmail.com> <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
 <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
In-Reply-To: <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 17:57:35 -0400
Message-ID: <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 4:42 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> Le 13/09/2021 à 21:26, Eric Sunshine a écrit :
> > On Mon, Sep 13, 2021 at 3:14 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> >> This adds the --recursive option, an alias of --recurse-submodule, to
> >> git-clone's manual page.
> >
> > Considering that the `--recursive` option was intentionally removed
> > from `git-clone.txt` by bb62e0a99f (clone: teach --recurse-submodules
> > to optionally take a pathspec, 2017-03-17), it's not clear that this
> > change helps the situation.
>
> The patch you mention also hides --recursive from the option array, but
> that was reverted with 5c387428f1 (parse-options: don't emit "ambiguous
> option" for aliases, 2019-04-29).  The option should be re-hidden, or
> even removed.

I don't quite follow. As far as I understand both by reading
5c387428f1 and by testing, 5c387428f1 fixed tab-completion so it would
_not_ show `--recursive`.

Anyhow, another approach which we've used elsewhere is to mention the
option in the documentation but indicate clearly that it's deprecated.
That way, people who run across the option in existing scripts or old
blogs can at least find out what it means. Something like:

    --recurse-submodules[=<pathspec>]::
        After the clone is created, initialize and clone submodules
        within based on the provided pathspec.  If no pathspec is
        provided, all submodules are initialized and cloned.
        (`--recursive` is a deprecated synonym.)

I don't have an opinion as to whether or not we'd want to do that in this case.
