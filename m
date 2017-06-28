Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC582023D
	for <e@80x24.org>; Wed, 28 Jun 2017 21:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdF1Vjp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:39:45 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36059 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdF1Vjn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:39:43 -0400
Received: by mail-wm0-f49.google.com with SMTP id 62so65452953wmw.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Rtg6Do41FAeLc0fFkiPPcOsxPTL+Ul5B3XjG7nAFn+4=;
        b=qTbjAV6Mlb3qb8fTADXjP77tghKpEbek2tp8mJLeXnRnC0FCPFr7obQK+fwEUvVwHN
         nwCfEjcyZCsf3JKfTIlYEHxk1Y5YN4/hPCE5X/6Uwv0qwIYmNXqHnTeCQFbNbqfyxELa
         WLkIgdF0m2X6XP/gKO5NbXqwMgdEQKWcQd5G6M02wsnNpDuhrmik7uuso7IBYDei6TH1
         TbxFW/VOVtZy3kkfAHhNOPMFkxxP3/WD4Gx2IU1ICRewBFAqEXY/+eOTKJXpj20whxJN
         9WEIHpN1fO/JEIQbGNjh+aqYnMDxSag0qObgbgkjaO2hkfIVsUk6UUn/+IrQNL1P9RoS
         z5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Rtg6Do41FAeLc0fFkiPPcOsxPTL+Ul5B3XjG7nAFn+4=;
        b=lk23Ea6gGZdFghmpPQuUpIgnFbW6fm9tBsfQEUPQiYrpN5CHTO2d4WzTpUWESHcyNu
         cj5wBXb0CKfAwhtgyWgnFPKT41/7g7pSJ/GPvKoI4SXM5ooEyLFxvqGQJEGnvJkpD7ST
         W9cRALz/I8loGM7Zy3+4Jl0DhvvlRFrR8g/Il+RcdxIofZux+dUF+utRfFOCUPL/evxg
         QWBCOn1w+hQw9rLVSAJiH2KPc7mAAybyzOzvM8MAyV4/gv5h7Yo6nlfhkyb8u9wQcnw5
         RErNoF78E51Iz0plQr09r8+vdpx1gqPivTuKKN5Gje8jjVuB/X654hlTx4YQ6LPRIYfL
         4m/A==
X-Gm-Message-State: AKS2vOzLJMyd3hTHwuLQRDEnzqxCkp4h9qSC0z6ClfXG8kiMF/qf3k/7
        opGFSMt3Ssyalg==
X-Received: by 10.80.183.146 with SMTP id h18mr9345874ede.39.1498685982353;
        Wed, 28 Jun 2017 14:39:42 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id 2sm1557127edz.40.2017.06.28.14.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:39:40 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dQKgW-0003ga-5y; Wed, 28 Jun 2017 23:39:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
References: <20170615231549.20085-1-avarab@gmail.com> <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com> <20170615231549.20085-5-avarab@gmail.com> <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com> <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de>
Date:   Wed, 28 Jun 2017 23:39:40 +0200
Message-ID: <87injfkd0j.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 25 2017, René Scharfe jotted:

> Am 16.06.2017 um 21:43 schrieb Junio C Hamano:
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> A follow-up to the existing "type" rule added in an earlier
>>> change. This catches some occurrences that are missed by the previous
>>> rule.
>>>
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>
>> Hmph, I wonder if the "type" thing is really needed.  Over there,
>> "ptr" is an expression and we can find "free(ptr); ptr = NULL" with
>> the rule in this patch already, no?
>
> Indeed.  How about this on top of master?
>
> -- >8 --
> Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules
>
> There are two rules for using FREE_AND_NULL in free.cocci, one for
> pointer types and one for expressions.  Both cause coccinelle to remove
> empty lines and even newline characters between replacements for some
> reason; consecutive "free(x);/x=NULL;" sequences end up as multiple
> FREE_AND_NULL calls on the same time.
>
> Remove the type rule, as the expression rule already covers it, and
> rearrange the lines of the latter to place the addition of FREE_AND_NULL
> between the removals, which causes coccinelle to leave surrounding
> whitespace untouched.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  contrib/coccinelle/free.cocci | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
> index f2d97e755b..4490069df9 100644
> --- a/contrib/coccinelle/free.cocci
> +++ b/contrib/coccinelle/free.cocci
> @@ -11,16 +11,8 @@ expression E;
>    free(E);
>
>  @@
> -type T;
> -T *ptr;
> -@@
> -- free(ptr);
> -- ptr = NULL;
> -+ FREE_AND_NULL(ptr);
> -
> -@@
>  expression E;
>  @@
>  - free(E);
> -- E = NULL;
>  + FREE_AND_NULL(E);
> +- E = NULL;

Late reply, sorry. What version of coccinelle are you running? I have
1.0.4 (from Debian) and can't get this to produce the same results as
what I have.

On top of next, I did:

        Revert "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
        Revert "coccinelle: make use of the "expression" FREE_AND_NULL() rule"
        Revert "coccinelle: make use of the "type" FREE_AND_NULL() rule"

And then generated the patch as usual with `make coccicheck`, and
applied it. This has your change.

I then re-applied the manual "*.[ch] refactoring" changes

This results in this diff with next:

    $ git diff --stat origin/next.. -- '*.[ch]'
     builtin/am.c             |  3 ++-
     builtin/clean.c          |  6 ++++--
     builtin/config.c         |  6 ++++--
     builtin/index-pack.c     |  6 ++++--
     builtin/pack-objects.c   | 12 ++++++++----
     builtin/unpack-objects.c |  3 ++-
     fast-import.c            |  6 ++++--
     http-push.c              | 24 ++++++++++++++++--------
     http.c                   | 15 ++++++++++-----
     imap-send.c              |  3 ++-
     ref-filter.c             |  3 ++-
     refs/files-backend.c     |  3 ++-
     remote-testsvn.c         |  3 ++-
     sequencer.c              |  3 ++-
     sha1-array.c             |  3 ++-
     sha1_file.c              |  3 ++-
     transport-helper.c       | 27 ++++++++++++++++++---------
     transport.c              |  3 ++-
     tree-diff.c              |  6 ++++--
     tree.c                   |  3 ++-
     20 files changed, 94 insertions(+), 47 deletions(-)

These are all cases where we now miss things that should use
FREE_AND_NULL(), e.g.:

    diff --git a/builtin/am.c b/builtin/am.c
    index c973bd96dc..2f89338ed7 100644
    --- a/builtin/am.c
    +++ b/builtin/am.c
    @@ -484,7 +484,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
            ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);

            if (!ret) {
    -               FREE_AND_NULL(state->msg);
    +               free(state->msg);
    +               state->msg = NULL;
                    if (read_commit_msg(state) < 0)
                            die(_("'%s' was deleted by the applypatch-msg hook"),
                                    am_path(state, "final-commit"));

So it looks to me like removing the "type T" rule breaks a lot of
things, but that the change you made to the expression rule is good, and
we should do that for the "type" rule as well. Your commit says the
"expression rule already covers it", but this doesn't seem to be the
case at all.

As an aside: Junio, did you mean to apply f8bb4631fb to next this way?
Looks like a mis-applied scissor commit.
