Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6F81F462
	for <e@80x24.org>; Mon, 20 May 2019 20:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfETUch (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 16:32:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42332 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfETUcg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 16:32:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id j53so17871638qta.9
        for <git@vger.kernel.org>; Mon, 20 May 2019 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBLeSHHkMKR1/pkN8aSf8Mq36yqkWnOFUqk000lL7Bo=;
        b=acLMzEkRGFwXRRpWmvRlcgudKkSh4SiuvsDMzQXSvp4jGV5no7dpLNkkrd6hEBEl00
         CoOxfrkqXOraxWAtZO/aBHk2hCtlwiw3/rIVH4i4fUhVB4jYkztvB3DkVLHV1TbV67Qp
         yP6FfPAesYszCoyFrvlLTkz2/gF7MRBOdwMC8fyTKBhoOU4lvWEFEoaSYSdNxyhTGCV3
         fvKDe4zXatOGOQ8gd1ZnVwD+il1elqczwg7Jh2TD04n97eWURDOjmbx9Z9J0MDb6YWb4
         DsRrWtRKkqrmx5JLClhLfQb4Iomrq6jX9of9Mf3bmAcZ7rshLPCA8mINUlX2c60aLBl2
         7RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBLeSHHkMKR1/pkN8aSf8Mq36yqkWnOFUqk000lL7Bo=;
        b=NtpxiE9eol2GNPO17pm0sCrYHfqUx888erAYczwG+gf9rc6Wj6SjXVLjew7CayyURB
         HBKRusHT4dF9Z/itKQQevEHwd3WQnv1BmjCvindBRYk42gFdxVVsuGhuVSYCSQ3VaNap
         ZMKM2U0inHYQq9CAWq1uuW8cX40LXhAiSwYx5NAO5Yf6sjqqE1hi3vN6MnAogcRfEqpw
         sJBnGOFkyf5sy52BUKiCvcqs2Z7wT3dCa60GwM4nU70z/7dcz0VhB0nsaPtoxcyP9JqO
         cDpFtLJBV8JoML2vU9YqYVr6+Gxw0io9sNN9HCzZiTexXAqjhFi6iBBvmbBVT3rGK1pV
         GWjQ==
X-Gm-Message-State: APjAAAXzcvc5JnPV8wTjf+qdr1JbR1DBnF+vedfOeRPzKcmm4edTtQBt
        nwgzo/g0uwdw+BnBKbaCwmzZWy1cQf0RMzA7e14=
X-Google-Smtp-Source: APXvYqySabZZMi8JUzos8SrZsnsetdXHDr67Lpb4pbfUA+Tp5Rzxdbj9YVfU4JXAa31ANYVnh8OozVTDgVdNaAIfCrI=
X-Received: by 2002:ac8:7606:: with SMTP id t6mr35784457qtq.227.1558384355894;
 Mon, 20 May 2019 13:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190515214503.77162-8-brho@google.com> <20190516215713.100523-1-brho@google.com>
 <xmqqftpd3br1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftpd3br1.fsf@gitster-ct.c.googlers.com>
From:   Michael Platings <michael@platin.gs>
Date:   Mon, 20 May 2019 21:32:24 +0100
Message-ID: <CAJDYR9Qm+oQ=Lv53v_zrYaG2pW_TggD4q2ENEa7bR4z900fXyw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8 (edit)] blame: add a fingerprint heuristic to match
 ignored lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
The SQUASH??? patches look good to me. Please squash away!
Thanks,
-Michael

On Fri, 17 May 2019 at 06:12, Junio C Hamano <gitster@pobox.com> wrote:
>
> Barret Rhoden <brho@google.com> writes:
>
> > From: Michael Platings <michael@platin.gs>
> >
> > ...
> > Michael removed the bashisms from the tests.
>
> Will replace what's queued.
>
> Note that I have two extra SQUASH??? patches on top of the branch to
> make 'pu' build and test, which you may want to take a look at.
>
> Thanks.
>
>
>
>
> From 82e68b47261ae57e7b368b9eed3450dbbf76e3c1 Mon Sep 17 00:00:00 2001
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 16 May 2019 12:43:27 +0900
> Subject: [PATCH 1/2] SQUASH??? error: decl-after-stmt
>
> ---
>  blame.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/blame.c b/blame.c
> index d55e458770..287841364b 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -925,9 +925,6 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
>         struct fingerprint *fingerprints_a = parent->fingerprints;
>         struct fingerprint *fingerprints_b = target->fingerprints;
>
> -       if (length_a <= 0)
> -               return NULL;
> -
>         int i, *result, *second_best_result,
>                 *certainties, *similarities, similarity_count;
>
> @@ -943,6 +940,9 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
>          */
>         int max_search_distance_a = 10, max_search_distance_b;
>
> +       if (length_a <= 0)
> +               return NULL;
> +
>         if (max_search_distance_a >= length_a)
>                 max_search_distance_a = length_a ? length_a - 1 : 0;
>
> --
> 2.22.0-rc0
>
>
> From 634f3cecaaba9174e81629f8df5942c261e8310b Mon Sep 17 00:00:00 2001
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 17 May 2019 13:45:42 +0900
> Subject: [PATCH 2/2] SQUASH??? test-lint -- seq not portable
>
> ---
>  t/t8014-blame-ignore-fuzzy.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> index bbf70b0f56..1ff59624e9 100755
> --- a/t/t8014-blame-ignore-fuzzy.sh
> +++ b/t/t8014-blame-ignore-fuzzy.sh
> @@ -298,7 +298,7 @@ EOF
>  last_test=13
>
>  test_expect_success setup '
> -       { for i in $(seq 2 $last_test)
> +       { for i in $(test_seq 2 $last_test)
>         do
>                 # Append each line in a separate commit to make it easy to
>                 # check which original line the blame output relates to.
> @@ -314,7 +314,7 @@ test_expect_success setup '
>                 done } <"a$i"
>         done } &&
>
> -       { for i in $(seq 2 $last_test)
> +       { for i in $(test_seq 2 $last_test)
>         do
>                 # Overwrite the files with the final content.
>                 cp b$i $i &&
> @@ -329,7 +329,7 @@ test_expect_success setup '
>         IGNOREME=$(git rev-parse HEAD)
>  '
>
> -for i in $(seq 2 $last_test); do
> +for i in $(test_seq 2 $last_test); do
>         eval title="\$title$i"
>         test_expect_success "$title" \
>         "git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
> --
> 2.22.0-rc0
>
