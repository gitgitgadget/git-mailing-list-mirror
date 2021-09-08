Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D7C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADE761139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbhIHBgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbhIHBgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:36:32 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C9C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:35:25 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id a25so640583vso.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xAXeHT3wg+4WTExk7yXoT0XmwWi0VG/AOWCLilw+GTo=;
        b=nD6EzgDwub+pjtexsakzyxdk6drBowqByTAt6oLoTwRv767bq/oXw7mfLkqi4kvD7M
         lvYlqj0lkfG9CqJ5cIS59pWoK/qbL3P1fHYRS+rUO1oZv7KN7HgmfJ9SmUWK1NP7qkOH
         jQuJFiB3Ya1m1sTBBFyLrPwJxJheHGBI6OP042zn4EJAPkmLkfZiDqTLR0I3Wu64vKl/
         1zERVQnA5HRbLl06Atx810oQK5TZlgLo37aMuyde/S7sshXXTsqLuW1fREXqYmakPkxw
         u1HvdMeeiKpS6qgz4bN1uF7EDbqO3ARpsHiq1Z6vI75mHFSEOU2FNh+xNFhjzvO+XX/s
         fAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xAXeHT3wg+4WTExk7yXoT0XmwWi0VG/AOWCLilw+GTo=;
        b=gKkCZYnUixINWDfeNrZgRm2EqQ4736On1/Nlp7U2KslyGeG2CcEjaoZnB0FR+6m1DL
         kgtn7+ubjW/WObEFx00psMDP7EbR2uT1YsDsLWJiiGZZbYQMg85n55R2FgfCMIJqkV8b
         fDupWLkX72BI6bjAjXzc5BSufB/iWxi5ncgfCsUy5Vejk6ls1zEkPEaCLOYlEd2uNRmQ
         Vbz+oBB+RAvMxuM1n9KKERqacKBZaX2AzoXu/eDA0T3HTgitmn1IUdmAIjdL5XferQma
         TmiRz7j6CEXtLoytyyMQno4nzWfQg98D0O6b+mcWtznTkzu0izWG6hbTwAq8509Z0Wcc
         8C5Q==
X-Gm-Message-State: AOAM533Tq20SvC2RbLKfcnYqbFevjoNmq8m6btl0/ohCxaJDbEav9JXO
        3UX5WKnjELAOrR0Yyi6aSXkAtR+M9JZ9xaxRmGI=
X-Google-Smtp-Source: ABdhPJzH0m18ZUtfiizljToLJamjdAvIVCgRA40Hob73F4O75fcuDozLKLfR2nayqZWt1oJ+480gUFQFLZVCaqqnT9c=
X-Received: by 2002:a05:6102:1012:: with SMTP id q18mr815841vsp.3.1631064923606;
 Tue, 07 Sep 2021 18:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
 <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 7 Sep 2021 18:35:10 -0700
Message-ID: <CAPUEspgh0kbm-ro13Xt2-g-hPoBMK2-34iP2GvK_gaa2bGC+GQ@mail.gmail.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 6:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> +       if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
> +               return NULL;

I see this expression matches exactly the logic from 8ef50d9958 which
is why I presume
you used it, but the simpler (and logically equivalent[1]) :

  if !((flags & WRITE_REV) || (flags & WRITE_REV_VERIFY))

is easier to read IMHO

Carlo

[1] https://en.wikipedia.org/wiki/De_Morgan%27s_laws
