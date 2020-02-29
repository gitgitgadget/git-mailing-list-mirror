Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98853C3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 21:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3BC21775
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 21:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPx6TiWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgB2VVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 16:21:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33975 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2VVd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 16:21:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so7367199ljc.1
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwDW4Ah+ypHDXrtGlfop7UDxHfp0Jh0mBaBq7NtTQzs=;
        b=VPx6TiWzk05Bpse4BWRBnFcLXgzw+fPDN+ZjsobYKdfquDAw36I72xJmh/L3YuxABl
         IhTHD3g0IqS2/pQRna6NvaakELT1l7yBqnnFvP0liXl06VOehS6GZAJUBCXLc/6NDvnM
         zBAyAHtnuHKVjv50elPcK2Db0ljhQq3RErkgt09iXznuVFwSfCYS3hYrFylZf6DQTmSE
         rZOa33F/SzN0JIaOLMfIXB890jNpUvMaWXcz2IRXymtliA1BW4ubEC8FmTcDie+gml05
         o5xyT3flAxIje4/M71bWeo6ctffSB8G9IfmdTh8H6MN31+o42Vh8AVTapWZNujO/2eNz
         s5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwDW4Ah+ypHDXrtGlfop7UDxHfp0Jh0mBaBq7NtTQzs=;
        b=tIHoxqnyDWKRaOlVz6uFXf06lBrWVh5VJcsQfVqdYQ5NlJGwzf4gxM9cJwac6UYvyO
         dqiX3AdP0wN1VsvVXoZVORKg3LX13s6HFb9JCSLpeNJ/YPaUtk99H1FRESAqObSMSf9R
         hk2EzKobsfb6dTjc8gCtfw5NNveok6QWM9AmhjGTxudUWkKwgFZtaru3VfwzMoHZJd8w
         ZBCEAhngkAzpPD+tgY1JlG2aA5c9GiGooRrPeqlH8CC5j49mNh3p4xiv6zgCSEBALY9V
         I/OCNWVpUya+XvZoqjlsZs1cYwu4Q4SaTNd2H5CUDRQsbSyDNf9d7wFNFfvHYF9rwrB9
         4/Eg==
X-Gm-Message-State: ANhLgQ1PqPvsmmtZBZf/M6ig8anSqi6WCPZJbr8SeKCrEIWQu6v0ytmZ
        bbHr3Zvi348IYqeKwJJiiyY7rSBJnBNJZmK27HR+hQ==
X-Google-Smtp-Source: ADFU+vsbSHrvvjZgr38jnPLKf9MQCfEovH2/wPeiSorbJdPkRfdL1BRSBcVPKqxpWL+LAfzT7e8iPy0l4+u5aFcVTlo=
X-Received: by 2002:a2e:8797:: with SMTP id n23mr6530127lji.176.1583011290493;
 Sat, 29 Feb 2020 13:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20200229010927.335119-1-alexhenrie24@gmail.com> <xmqqzhd1balh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhd1balh.fsf@gitster-ct.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 29 Feb 2020 14:21:18 -0700
Message-ID: <CAMMLpeSSET8F+BTooDhBTBGkh2JjvLWOPwA-ibspoDO0NqGy7A@mail.gmail.com>
Subject: Re: [PATCH v2] pull: warn if the user didn't say whether to rebase or
 to merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        Konstantin Tokarev <annulen@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 29, 2020 at 9:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > +             warning(_("Pulling without specifying whether to rebase or to merge is discouraged\n"
> > +                     "and will be disallowed in a future Git release.\n"
>
> Sorry for not catching this in the earlier round, but I do not think
> anybody argued, let alone the community came to a concensus on
> doing, such a strong move.  Am I mistaken?
>
> I certainly did not intend to, at least when I commented on the
> earlier round and proposed an updated log message, I wasn't even
> aware of the possibility that we may want to turn this into die()
> after a transition period.
>
> Not that I'd object strongly to the idea, but it was somewhat
> unexpected.
>
> If we are proposing to make it a long-term plan, that should
> certainly be written down in the proposed log message.

I really don't think it's a good idea to start making a merge commit
without confirming that that's what the user wants. Elijah and Robert
seemed to agree. However, we can start by just putting in a friendly
educational message and then continue the discussion about whether or
not to make a future version of Git abort upon printing the warning.

> > +                     "Next time, run `git config pull.rebase (true|false)` first\n"
> > +                     "or pass --rebase, --no-rebase, or --ff-only on the command line.\n
>
> I am somewhat puzzled by "first, or".  You certainly mean the config
> to be "set and forget", and you do not want to say "before you pull,
> do this first, always", but somehow the latter is the impression I
> got.
>
> But it does not sound to me like "Next time, and only next time, do
> this configuration.  You can countermand the choice you make from
> the command line later if needed", which I think is what you meant
> to convey to your readers.

I'll send a new version that has a longer and more clear warning message.

-Alex
