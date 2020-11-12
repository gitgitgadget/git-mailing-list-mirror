Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9372C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840C720A8B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvsbY15a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKLT0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKLT0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 14:26:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DCBC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 11:26:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p1so7197826wrf.12
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAY3oswwY2s2F6sqRhgOFOgFmWuaXJprqH/hqItEHBE=;
        b=HvsbY15aYPiTw/1UFs9JQCdCzBSezxq5yVpf3G/pWxItXp8fHsc+1psjUrrGhoiv+x
         YeEeU3ggs5sgb0awMtDH8IB1IrwP7xHVupawubBA9l/ij7LL1Tyl0vf1E4gLDS9D0E2W
         WiQeEfJ7NFArBUp1asgdQf4CtMIRBTIFy/XSrU1M6VGeudW0bnJITDkGT0nyHJn6qCV5
         AOQ69iXjxROpdWKVsDcvJlIhGhIo0E4g+3Cx8KnjSi2xflB6dCvZjggzKI8/u3iZdVzE
         0pPR8rTu2L3SqzD3Si9XdXCsS9afOLsu1AQ5ot72fc193rrsEuWaVQWmUFyjFkV9YhBx
         wj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAY3oswwY2s2F6sqRhgOFOgFmWuaXJprqH/hqItEHBE=;
        b=PHLAOGOCuwOIMnWIw/hdjrUxz/BXSB7bSr9mzk31gOZxxqotpG79acBsEqfFrma6vj
         R1C9acmIU7idqF/YTPIBNku+qunFL2fUskKI23mSsRnhZqtP9njo1ozxVopT18G1K47w
         AIw/mjYVWvYamhaDXdMq/X2ogTLRBrP9nxZaXAznWwL7gmhWrfDxfLo+554MFDIJa2Ii
         fTUdTtvpapEVCeanbcVqALm/uHbkacqbsRqNJ/9k/A330SrEXRB2WzSp/S45Nf7ILQpi
         sFJ2Qs5dRXo7Vz9DTRX4BepLfVDLguLQPjM06gYF9cxsts0JRQcBXDKsqZBpSlUXo34g
         4XhQ==
X-Gm-Message-State: AOAM532fxWwUMRxDExk2DFItA6hamtld+iFqRqckoNbb9tDa01rAEQBJ
        toNKgLBVCSxJHK0JvYfpMkcpl/wxasOLpM5g/Ms=
X-Google-Smtp-Source: ABdhPJzHIY8S2rG6zgmvskRKlvo0+4A7MZr+IIn8EyHF7abLC07m8RiYitL1loO/yLIw8bZjddjGBvLFxVMptzcv3wI=
X-Received: by 2002:adf:8465:: with SMTP id 92mr1205710wrf.50.1605209196610;
 Thu, 12 Nov 2020 11:26:36 -0800 (PST)
MIME-Version: 1.0
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
 <20201111151754.31527-1-avarab@gmail.com> <877dqqhd3s.fsf@evledraar.gmail.com>
 <20201112185146.GD701197@coredump.intra.peff.net>
In-Reply-To: <20201112185146.GD701197@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 12 Nov 2020 11:26:25 -0800
Message-ID: <CAPx1Gvckixj2hj5wL8EPpJbnp4rsV7-qnVUCG1d-UAqVtp-H-Q@mail.gmail.com>
Subject: Re: How do I "git fetch" with a custom <refspec> but a default remote?
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 10:52 AM Jeff King <peff@peff.net> wrote:
> If we were starting from scratch, then I think that might have been
> nicer, because --default-remote would be implied if there is no
> "--remote" option. And then my lazy-to-type:
>
>   git fetch topic
>
> would just work. But given that we have the positional <remote>
> parameter already, I don't think adding --remote gives much value. And
> it raises the question of what "git fetch --remote=foo --remote=bar"
> means (I think the answer is last-one-wins).

Since `git fetch` can fetch from more than one remote, it seems to me
to make more sense to mean "fetch from each".

(This isn't necessarily an argument in favor of adding these options,
just my suggestion for what multiple `--remote=` settings would mean.)

Chris
