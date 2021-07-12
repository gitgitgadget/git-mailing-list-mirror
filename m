Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC2C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3503660230
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhGLSWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:22:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA8C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:20:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w127so25546790oig.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MBJkglGdrVliiSwjb/f+3kdjBvdzrqneE1TdJkVmcOY=;
        b=kSe4QrVPvxVRfRT8tTYyGHAxxATzMy1we/WlgGcqLyf/qgRU7mzwgTzG82ijFkDI9B
         vxfo7HwiNQmRBZxFp0SWo0hv+C60+m4JYHcdHi0QFTF6o8nCe9HT6tRJoIqBOhE3MWlG
         RH0jMycFCxHKAn8Nn5N2J3/UBKI33KAWxBawnAr9vvo8bntn7J3eOqOehfHHQT08QkMa
         hkvPYXpvkILGQuhL65h4TRcLg0++sP/njc3XmALdfcVWEfO4DITRd3RVO5BFyJsA3934
         kYcwq3FE0VCNsbg8ivhXSCm5MQch4W1uIeOduoVG8nCnef/RziXfnZsltxWpKuumvtdg
         TI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MBJkglGdrVliiSwjb/f+3kdjBvdzrqneE1TdJkVmcOY=;
        b=BoccuNuc81NJHTABwt5mOIQUxDF3KEEy+adcLibgEcQGO6Qr0EgH+51Uwp+GYNCe5N
         n224lhtldRuUBySjwB2YGvDs49qJQjbcQhgmxaXvsuOC3Y+mYHMKgR8kL+a3B0QCRy5N
         tTZoA6V88fcCibngV/vFMi3GVRj9KV3ntqAmTK+I6tzYXe7WAfsNuCfA78b1HUku+eu6
         V0VTGunXQ5rwmz6Oqt0K4A5EBWf6nZYYIr4HHmvN7FyCUzXIA9ZCoN9JSmO6PdhObERY
         2BCvgdwhfEEovamQQdQM3CMXZWeGJP1Tlh/EuRDsR9tudOOpaFH0876+v4s5vGpdBhjk
         AMaQ==
X-Gm-Message-State: AOAM5306NFUG0gYGYEVGC+LB8evFXVe69J1mKVZGnQE/sRZC0Xb4prvO
        MrpPjP5K7WHHpbwEgeow+/8=
X-Google-Smtp-Source: ABdhPJymGEbx2m2Eb23q5KLZw1RT77oCPYQAp3ir5gxmBl+ifKHTuHtEari0iVsEGjvAMg1D0g64xA==
X-Received: by 2002:a54:4109:: with SMTP id l9mr73421oic.3.1626114001681;
        Mon, 12 Jul 2021 11:20:01 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id q23sm3288418oij.41.2021.07.12.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:20:01 -0700 (PDT)
Date:   Mon, 12 Jul 2021 13:20:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60ec87d03f7c5_a231f20826@natae.notmuch>
In-Reply-To: <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
 <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Mon, Jul 12, 2021 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > Thanks for revising this patch, I like this approach much better. I do
> > > however have some concerns about the interaction of pull.ff with the
> > > rebase config and command line options. I'd naively expect the
> > > following behavior (where rebase can fast-forward if possible)
> > >
> > >   pull.ff  pull.rebase  commandline  action
> > >    only     not false                rebase
> > >    only     not false   --no-rebase  fast-forward only
> > >     *       not false    --ff-only   fast-forward only
> > >    only     not false    --ff        merge --ff
> > >    only     not false    --no-ff     merge --no-ff
> > >    only       false                  fast-forward only
> > >    only       false      --rebase    rebase
> > >    only       false      --ff        merge --ff
> > >    only       false      --no-ff     merge --no-ff
> >
> > Do you mean by "not false" something other than "true"?  Are you
> > trying to capture what should happen when these configuration
> > options are unspecified as well (and your "not false" is "either set
> > to true or unspecified")?  I ask because the first row does not make
> > any sense to me.  It seems to say
> >
> >     "If pull.ff is set to 'only', pull.rebase is not set to 'false',
> >     and the command line does not say anything, we will rebase".
> 
> I think Phillip is trying to answer what to do when pull.ff and
> pull.rebase conflict.  If I read his "not false" means "is set to
> something other than false", then I agree with his table, but I think
> he missed covering some cases.
> 
> I think his table says that pull.rebase=false cannot conflict with
> pull.ff settings, but any other value for pull.rebase can.  That makes
> sense to me.
> 
> I'd similarly say that pull.ff=true cannot conflict with any
> pull.rebase settings...but that both pull.ff=only AND pull.ff=false
> conflict with pull.rebase={true,merges}.
> 
> My opinion would be:
>   * conflicting command line flags results in the last one winning.
>   * --no-rebase makes pull.ff determine the action.
>   * --ff makes pull.rebase determine the action.
>   * any other command line flag (-r|--rebase|--no-ff|--ff-only)
> overrides both pull.ff and pull.rebase
>   * If no command line option is given, and pull.ff and pull.rebase
> conflict, then error out.
> 
> I believe my recommendation above is consistent with every entry in
> Phillip's table except the first line (where I suggest erroring out
> instead).

No:

  git -c pull.ff=only -c pull.rebase=true pull --ff

In Phillip's table that does a merge, in your rules that's a rebase.


Moreover, since when does git do something different depending if the
action was configured or specified in the command line? They are
supposed to be two ways of doing th same thing:

  git -c pull.ff=only -c pull.rebase=true pull
  git -c pull.ff=only pull --rebase

Why would those do different things?

The documentation is pretty clear:

  See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
  linkgit:git-config[1] if you want to make `git pull` always use
  `--rebase` instead of merging.

If you start adding exceptions on top of exceptions the documentation
will become a mess.

-- 
Felipe Contreras
