Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F494C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiBVNFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBVNFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:05:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A512D0A2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:04:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a8so42824411ejc.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qZUuns63YIz464Cm4KcSSF5Se7KIXvC8sP3+UCixHwQ=;
        b=SNWGq+/Ez5vGsRaWaJSSV9Fri7xIns4ffddCFilLIQWhrCJw0OcW9i5D16DHAmw11K
         IxWGD0O2kF2vM+MrVYcpiA/7Ur4/pXoYQ0l2/1wobtfD3HcQ7R22xjcnUSMCgUsgtqEB
         iTL8LExW0QqCGwZfDeIvnCWzmcc5EBLzKP6Z22ynPHEpQSWoJRpueWsRTaGGtcbgZnNb
         d2sS5Zf3vQINQp6niOHPUvcHAwgABGSpB5SrNOvk/iIc3x8/jYkJN1i4d9YXiMDCjnfP
         TFHgyhs3OzWpJ7GpBkoSm1zguk56lhBk9fYYt+UAGs4+OmhgC3Fk+6awaG5FsVwL78mC
         mBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qZUuns63YIz464Cm4KcSSF5Se7KIXvC8sP3+UCixHwQ=;
        b=5CTP+cqVF1dBRxpdmZYu2PO4yfIZrg6iDb/AuXCqb2J4kJAQxb78ok1Zpn/kfHF8Mu
         v1AKBgOIH1LQrGbQPjolfUHCKMeqI1+ry0TnueRA2XAso3h/49hf8+82vOagzkcki8Hp
         BcIwjxLHN/nhreE5TD59B9TNPhwwlNViuDvOx79BYBEdpMlgNbmIMct3ESOQ38j6akPe
         WewLcLkpFePBDRpGx6QG1iIUHjQEcKX4B4Z7CmonHlTDbPFS3uxnsthTh/mb25vQ65ch
         Tfv4vek853d9E1sNQsWxJHY0TSnd6Pb/N4Aw+AC2t2d5EjjBxgNUjUs5bjmnv1gVeMbr
         F9HA==
X-Gm-Message-State: AOAM53326co14a/NuYMReR5PQ59iPckOFCaHGB/ZgbQd+sWZHNJuuYz6
        otkiNyaXDAd81dDaXHFWELQ=
X-Google-Smtp-Source: ABdhPJyhik6qhVUx+dJHuaIsPNHxOXA5o6eytJFsF4GeB3pXfZunEd3t8TbVBxtDSsKckDJD5FUDAw==
X-Received: by 2002:a17:906:f996:b0:6ce:e515:6064 with SMTP id li22-20020a170906f99600b006cee5156064mr19213409ejb.764.1645535080489;
        Tue, 22 Feb 2022 05:04:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bt6sm6306004ejb.222.2022.02.22.05.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:04:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMUqN-0063y7-6N;
        Tue, 22 Feb 2022 14:04:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Date:   Tue, 22 Feb 2022 13:57:00 +0100
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
 <220221.86a6ejakun.gmgdl@evledraar.gmail.com>
 <CABPp-BHmU8-a+McANE2bdAndGEtVudr74FHEEj6K6NwYECEZ6Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202221311480.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202221311480.11118@tvgsbejvaqbjf.bet>
Message-ID: <220222.8635kb832w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Johannes Schindelin wrote:

> Hi Elijah,
>
> On Mon, 21 Feb 2022, Elijah Newren wrote:
>
>> On Mon, Feb 21, 2022 at 2:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>
>> > There's also no law that says we can't have a three-level variable as
>> > core.sparse.*, perhaps that would be the start of a good trend, and it
>> > would sort adjacent to core.sparse[A-Z].* ...
>>
>> Interesting thought.  I'm curious what others think of this.
>
> What would make it `core`?
>
> In other words, while it is valuable to consider this option, I don't
> think that it solves anything, for the price of additional complexity.

To a first approximation what makes it core.* is that we have a
core.sparseCheckout.

It's hard come up with some definition of config namespacing where it
belongs there, but not a setting that tweaks it further, no?

I.e. we could quibble with the benefit of hindsight whether
core.sshCommand was the best idea at the time, or if it should be
remote.sshCommand or whatever.

But if we introduced a more specific sshCommandSomething having it there
instead of ... well, damn, I forgot that we have ssh.variant :)

Anyway, as noted (and I feel I have to comment as the originator of this
thread) I think the bikeshedding about namespacing is less important
than making sure from a user perspective that these are discoverable.

E.g. core.sshCommand doesn't reference ssh.variant or the other way
around, and in my "man git-config" they're at ~25% and ~90% in to what's
now a *huge* document. You need to read the whole thing or have the
foresight to search through it to discover both.

So for core.sshCommand and ssh.variant, and core.sparse* and sparse.*
cross-linking etc. would go a long way...

Aside: I do have some local patches (waiting on a couple of other things
I have outstanding) to add a "CONFIGURATION" section to all of the
built-in commands with some including/splitting up of
Documentation/config**.txt, so "man git-sparse-checkout" would have a
section listing the subset of "git-config" applicable to the command.
