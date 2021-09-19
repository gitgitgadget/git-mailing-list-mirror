Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74AC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04056104F
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhISTaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhISTaV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 15:30:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C2C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 12:28:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t6so52157111edi.9
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoQJcV2JBC3XTIIjFG8TMSSkIcWd9g/hz/EW+8ABjdQ=;
        b=HvUTU5t6K6Ac8Ny88WNMYnr7Hp3LbGP8fJQ5jy2MCzMwNU12FT7porxpN4n4t6ZMYt
         p4qlTBSZdHsuCPsmlkPg0kDsp5cOiGtcN8lFRuaiZtswb4SBQtM+vX7upEzc1DQqI2ru
         KO2nn8kd7jr//ASw0920G6Tl7iaKUcTx74QX55CnL/adhl7seVn8rpujprYHu0EXkND+
         E5xdnbmKS7au+biP9BopuSR1K3K0doHDevb6emC4lWOWb1d5tCjwrHC6o2+uXi0FLCmI
         ktEwNkSbXr8A1m81c6qQMu9tkHr3X37nJ1cVy+ZFnD/wP7stCc7f/BEM73q+xz0pSqoZ
         f9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoQJcV2JBC3XTIIjFG8TMSSkIcWd9g/hz/EW+8ABjdQ=;
        b=o/PDE3fXSpxQ2v8jfcLqLC95sOXB8UOjVXhEr4GNZey+0lNu8U6bJYoa1HXZmclc/O
         +8eiemfE07QG+KEZcnK3Bx10RJPEdSlk9IshPYoUUx5n2TzWNNZL6TdnoavJkwFDJuE8
         u04M8pQ9P4Tt8Ho7o0hszRqHkrYusOdw7H1VvKFwlIQrwiJdijvTaNZ13wN3wSoc8Ajs
         Rd5Vng3WYABE4/TcVdrPGqivreIP/2X0q3icLarqgJZcz/cgdlJQmERnYS9wlunfX62n
         tabLtAMd3xpaeBPCt69r+CVJ3PhoosdUwPF2P13k0E96p4BpAwND8ets0YMuxh3GMZXX
         VnTQ==
X-Gm-Message-State: AOAM533XBgTJ7HPpz88JwKgK5szinvme33YBcS0NUo8PnYVQ55/vQvyf
        zxQw3ct+m+cafb1iksxUDrho28sdUZQIo8AOJ/M=
X-Google-Smtp-Source: ABdhPJxSIZaLeZBHSpRzm0YerIwk3owuQ77hJ/zTovXHZiLiSCu9n4tfIqEagENJZp4F8D4oF7ZaXUt2JmLCn4qbV+Q=
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr25903753edy.349.1632079733932;
 Sun, 19 Sep 2021 12:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210919015729.98323-1-davvid@gmail.com> <20210919015729.98323-3-davvid@gmail.com>
 <8dfd0683-e019-a45c-30a4-d49ea627e36d@kdbg.org> <CAJDDKr6AM0YZ-5GmXHz=2VbRKOusjQ-OAP2ng8GpBDb0x1pPRg@mail.gmail.com>
 <d882e3a7-d459-5063-eca7-e77e1addfed5@kdbg.org>
In-Reply-To: <d882e3a7-d459-5063-eca7-e77e1addfed5@kdbg.org>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 19 Sep 2021 12:28:17 -0700
Message-ID: <CAJDDKr7+GnXX=sPfUvyxZhWOXCe8P_aOYtY_XdGS6t=cRNm8wA@mail.gmail.com>
Subject: Re: [PATCH 3/4] difftool: use a strbuf to create the tmpdir path
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 11:46 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 19.09.21 um 20:13 schrieb David Aguilar:
> > A better title might be:
> >
> >     difftool: use a strbuf to generate a tmpdir path without double-slashes
> >
> > The double-slashes are the point. This patch is a minor cleanup that I
> > found on the path towards fixing the data loss bug in patch 4.
> >
> > Thanks for the heads-up about the confusion ~ I'll reword in the next
> > submission to make this point clearer.
>
> Thanks. My primary concern with the patch was actually that it looks
> like mere code churn that introduces an error by not using is_dir_sep().
> This is now settled.
>
> But still, without a justification why the slashes should be cleaned up,
> the patch looks like code churn. You can ignore me if it is obvious for
> others why we need the patch.

Nah, that's a good point. Thanks for clarifying. I'll hold off on
resending until we've reached consensus on this patch.

The final bugfix patch is the most important one in the series so
perhaps I should reorder the series so that the bugfix comes first,
and these cosmetic improvements and typo fixes are the later ones in
the series? That'll make it so that the bugfix is easier to backport
and not entangled with these prep fixups.

I see double-slashes when using the dir-diff feature and they just
look wrong to me, but "striving for perfection" is a mere subjective
justification.

The double-slashes fixup is cosmetic from a technical perspective, but
since the paths are exposed to the diff tools it's a cosmetic blemish
that users will see front and center.

The test environment where I observed TMPDIR containing a trailing
slash is macOS, so it's a fairly common setup. One justification is
that we should not expose such blemishes to users -- that's what I've
written below but perhaps there's a better way to express it?

What do you and others think about the proposed message below and
whether or not this patch is worth applying?

"""
difftool: use a strbuf to create a tmpdir path without repeated slashes

The paths generated by difftool are passed to user-facing diff tools.
Using paths with repeated slashes in them is a cosmetic blemish that
is exposed to users and can be avoided.

Use a strbuf to create the buffer used for the dir-diff tmpdir.
Strip trailing slashes "/" from the value read from TMPDIR to avoid
repeated slashes in the generated paths.

Add a unit test to ensure that repeated slashes are not present.

"""
-- 
David
