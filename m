Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF2BC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EE122201
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoXt5500"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKMRmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMRmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 12:42:35 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D44C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 09:42:35 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so10828136wrt.4
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4U2YnyEIEza+Tus4PqcISkMQNJVDju2zlWY9OC9Xf2g=;
        b=WoXt5500sp6ZFX6IGAL/MeJ4r9XT+IlfNwpJeYP1BrVLtCTGjISt2qNh4iVB5yEK0i
         D5sLgHONgWRx5FUDdmNvboaY7rrI/f6BjlVb/OpmnuYplwE7wSHccGkm130CKW5zdAyO
         KVvoo3Vg2OLvr2AfqPrMXg1y5/qSu3EALcXiiRwBiDap2ZkHLNZh0MzBS2H6XlRDbUP0
         gny2YR+EYn2R6bF+d26t9sWu+aXAJ649ot1WQfKDloM5yE/uQhhJRu/gV56ZPleN8NT6
         fln4tf0RWjBFgoSQIw5mMEqpX1IoCUDdmKG/BjYX5Fxvz6ZZjNkJvt6S6+/sbjeuew5W
         NrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4U2YnyEIEza+Tus4PqcISkMQNJVDju2zlWY9OC9Xf2g=;
        b=GEVGzea9LObwztM8vqJfz7w//L++M2N5eovm9+mTeHG7lit3FkeRF0McUTh+Zm0wGP
         ykKStWEyekG01HViIqxPjyv0n4HyFI4aQ7+AAwAwjuALlkPjS3W1Kz0HWKaFxQMdwRXW
         32jiMu+EXMOYxKBIVtCZcTpbINPrOfQR1kQFaJdGPucHGDiBpH7VH8C5Y+2qHuWQfU5r
         rPwnEmVn0gB/ftfZ04rCouSnPRdH2j+lO25Qg1w3NP2yafl9o/9DE1nirenHK/PI8CGp
         gi7p+wcqir/yf5hNrEoNcZCCpchXycFqmEA3QK3bTEh0DTHhrufmlTtqb/HMJ+159Eyw
         BzKw==
X-Gm-Message-State: AOAM5327H6fF0hzJluqEALBABQKPc9fMcWFH0odkDkk5gQ0y5aWLGbU2
        XdC1bnTOPbc5bPGO3UKNfdeWsRwJ8zyWiATRn2o=
X-Google-Smtp-Source: ABdhPJy46QBBCSNexQfriY0DAhSWe9FmBcpyrc+ZC5dLb2TzOm+/aTf2H61rIp16XgpYG+wMiOhiz4ITImyBoFHBJTU=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr5075028wrv.255.1605289351819;
 Fri, 13 Nov 2020 09:42:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <87pn4hfmc4.fsf@evledraar.gmail.com>
In-Reply-To: <87pn4hfmc4.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 13 Nov 2020 11:42:20 -0600
Message-ID: <CAMP44s20UBE0w8CYmw_m3vs_e=S32Kzxq-f-SAMDPm7Pz1zHzg@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 7:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 12 2020, Johannes Schindelin via GitGitGadget wrote:

> After this series as it stands lands what's a rather big UI change in
> git isn't discussed *anywhere* in the docs.
>
> I'm not saying we need some similar s/master/main/g in Documentation/ as
> what's being done here in t/, but I think a bare minimum for a rather
> big UI change like this is:

Why not?

Isn't this change being championed on behalf of users who find the
word offensive?

Why would it be offensive to see the word on the commands you type on
the command line, but not offensive if the documentation tells you to
type those commands? This does not compute.

And worse; for the rest of the users that don't find the word
offensive (99.9% of them?), the documentation is left in an
inconsistent state, where some commands would not work as they are
stated.

If a word is so offensive it has to be erased from the Git lexicon,
then it has to be erased *everywhere*, or at least everywhere a user
might look.

Cheers.

--=20
Felipe Contreras
