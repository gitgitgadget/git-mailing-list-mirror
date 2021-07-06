Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B7C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C1361C3A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhGFWeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFWeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:34:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D9C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 15:31:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z3so250323oib.9
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NaL2NOdTeajEIyxWVYhzWp+Hz1Z9gq8j4KYAJjDFZcI=;
        b=VBYV+xwweWteh2DEk1Gei77c9HVYS9VmeazJYDPblPe7ZLGA7Wtmrd2yklkhcUSQXD
         O0PqB4SQrasAdXN1z7ygCcMGhacfpXMtr005v2IACYav4OVkEXPmeqvxN5z45yafInKT
         /qe5CefePb3ER8JX38aGIww72LR2P4eWuACHEUGRZKzPoLYEloPOJRm3ywlY86ARwe27
         zj2sNrVI8m5n20NNSSVQrXlnXjMMkUXh9SI1ACiw8JJxnGIlhPZdMH8maxRxJ2Sun+fa
         ZCjfr1cCboolAN4VpGM6XVvtS63Q/4XrUHZkmzPLvRLZ0TFFtdU8kmeOuKSBfrqY3Ric
         ezaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NaL2NOdTeajEIyxWVYhzWp+Hz1Z9gq8j4KYAJjDFZcI=;
        b=RU4PP/qylGSL9A9bUgxTJB2ylgAonv5TRG/DSCqu/augPQeZMmxrZ0YV7qzkVUj5m/
         mYkjzuuTHHnKofRbQQwAcnwn+sRvPAuF8etDzuhljrIBN8ovndUcwMB5kJ5cE2SBV2Jy
         ItRG3c5FJTlk05dgEV0dWOgKkmUTC7QTRemJ2Fp2zdQRkTiVkVrySQJ1XvR1MxUyGLO3
         JbEBTjvtSkvgh0kk5SmMWgaPJBwBwAGWQPI621TQ+JTAPJVy4GeIJc/Hygcb+yxPyiqy
         aL9gKIDL13PAPT4SO/RW7TDKMmnKT0JvrAHLTLZtF8XGEVgwityIv8sFz4z90uLXAY9a
         ewGg==
X-Gm-Message-State: AOAM530O9Q8dijKoBSNCXUzK/+XioVjBw2xbOgaVO7otqJ4uf3nj/oQ6
        Wway9/hcCORMYAboNPDuFXc=
X-Google-Smtp-Source: ABdhPJynSSk/zfzXB+azi3wQruehX8A0nrp4S1vo84jcywWaGha26ebz1bDElakaKFI6042wXnQN3A==
X-Received: by 2002:a05:6808:4:: with SMTP id u4mr15808055oic.50.1625610690210;
        Tue, 06 Jul 2021 15:31:30 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id f6sm3149890oop.31.2021.07.06.15.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 15:31:29 -0700 (PDT)
Date:   Tue, 06 Jul 2021 17:31:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60e4d9c07914e_1c42812081a@natae.notmuch>
In-Reply-To: <87wnq57q9n.fsf@evledraar.gmail.com>
References: <60df97ed24687_34a92088a@natae.notmuch>
 <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
 <60e0a9707e09a_2f7208f2@natae.notmuch>
 <YOEEjwbMPRmWOmrM@mit.edu>
 <60e1ee7a3cfbc_6d11d20811@natae.notmuch>
 <87wnq57q9n.fsf@evledraar.gmail.com>
Subject: Re: The git spring cleanup challenge completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sun, Jul 04 2021, Felipe Contreras wrote:

> > I think there's some value in that idea but that doesn't solve the sa=
me
> > problem my suggestion solves. Basically there's too many commands in
> > `man git`. Splitting the git binary would allow us to only put the
> > important commands in `man git`.
> >
> > I think having too many commands overwhelms many newcomers, because t=
hey
> > don't know which it's important for them to learn and which are
> > basically noise.
> =

> I'm very much for the idea of a cleanup of "man git", but I don't think=

> we need to introduce a git-tool(1) for that.

Indeed, it's not *necessary*, but it would help tremendously.

> E.g. "man perl" is a good example of where we should be
> headed. I.e. right off the bat in "man git" we have a long listing of
> command-line options to git itself, things like --exec-path and
> --no-optional-locks etc. are useful to almost no casual user.
> =

> We should really split everything except a passing mention of -p, -P, -=
c
> etc. into a "man gitrun" or something (just like perl has "man
> perlrun"), ditto the whole "ENVIRONMENT VARIABLES" section.

I like that. For the record zsh also splits man pages that way.

I would prefer `git-run` (or `git-core`) though, althought if somebody
at some point wants to create such a built-in that would be problematic.

-- =

Felipe Contreras=
