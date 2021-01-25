Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99BCC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628D2224DF
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbhAYTUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbhAYTTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:19:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07651C061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:19:01 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e22so28849686iog.6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lsFAE2NS3Q20nvpD1M19Z0cdNaC7YFm/eSBOq7TYL5k=;
        b=bWeILPRDwJBUJ8IQF7S8tq6Nn/6WzTqXF8UXLnG45g19YGX0qWpo85iSLi4cP6Gja0
         1hITwb7CZU2JOu8weI7MBEYZYd6bZK91LZrQFQ4ZsJ8u9oxsgT/PvpOgtjV7v7/E0lFa
         O+Uf42JNxO6ARQGGpKNWtUgyUYklsdzYahLnZEWUn9Sa2GZW6bQGKJzCJp/hRqcnGBGm
         6HivO0FOJNYRHYXIfzD7ML4X08RIUHpKtTcXKtvNGBxKIZLXA5Lsbg4d2AFOsmtFuKbZ
         7sCyLFtMPimGESWK6AYviU0vqCmvQNZ/Wr7NBHCgXHmuuuI0Mk5jymMt0O1nofks8ryr
         pA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lsFAE2NS3Q20nvpD1M19Z0cdNaC7YFm/eSBOq7TYL5k=;
        b=h+xmE0dzpVFXUKCi19L1Y1UU/EW94uHSZ4pwBspOvgdhTQ8XghGqcooFn7KgwV+jMb
         fQqPNgX+dWQ2gYh75ZLIuaETdqpoIQVLb7E8gBgP8s/hq9JckpE4igVHLnb0Bj3aQg37
         fFDbi7q9zHsIBrKe8c5wCb9eKLlVFYI7eM/wCBWfQt07fTdVXa+s5GaG10Aj/Oprqe0D
         opqoAfzcBQ66cTTwp7efuNHEHtVGT134bWCrQf5tg151WM7e5nxknl0C0JCWbHyFZagB
         eKBucW3zpEJr/n0M9Vq652TVU705GsSkRGNgzgljVlF1qk0uvZXMtVq37xgDFrKprWq/
         2uIw==
X-Gm-Message-State: AOAM532YzTJ3GjAUq3aBgsfIdKUia7n8bpkQQGyMOVGEFvsP5qjdJHHo
        FEfAha20MRkAL+UPCUnTApqir3hHUGYGWd6l/zBZGVTx
X-Google-Smtp-Source: ABdhPJxfqqfSZ/EkYPNIIvtQc6HpjZ0YtA2IiAC1pAXR9FMJbXW4ymfOWxLCFbaLf41lZ++n77OqBNYA4d7HxVIFLW0=
X-Received: by 2002:a05:6e02:1d02:: with SMTP id i2mr1745957ila.30.1611602340430;
 Mon, 25 Jan 2021 11:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20210123154056.48234-1-mirucam@gmail.com> <20210123154056.48234-3-mirucam@gmail.com>
 <xmqq35yr2nh0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq35yr2nh0.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 25 Jan 2021 20:18:49 +0100
Message-ID: <CAN7CjDC-GdA00jWJn=cKiu-Y1AXKSOJ-Uav7ZMyeGHVSBV5HqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] bisect--helper: reimplement `bisect_replay` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El dom, 24 ene 2021 a las 1:22, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > From: Pranit Bauva <pranit.bauva@gmail.com>
> >
> > Reimplement the `bisect_replay` shell function in C and also add
> > `--bisect-replay` subcommand to `git bisect--helper` to call it from
> > git-bisect.sh
> > ...
> > +static int process_replay_line(struct bisect_terms *terms, struct strb=
uf *line)
> > +{
> > +     const char *p =3D line->buf + strspn(line->buf, " \t");
> > +
> > +     if ((!skip_prefix(p, "git bisect", &p) &&
> > +     !skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
> > +             return 0;
> > +     p +=3D strspn(p, " \t");
> > +
> > +     char *word_end =3D (char*)p + strcspn(p, " \t");
> > +     char *rev =3D word_end + strspn(word_end, " \t");
>
> Are these lines new in this round?
>
Yes, they are a reviewer's suggestion.

> These break builds with -Werror=3Ddeclaration-after-statement.
>
Sorry about this, my compiler sometimes does not alert with some -Werror.
I have just sent a new version.
Best,
Miriam
