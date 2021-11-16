Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1DCC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1443361BF6
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhKPJKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhKPJKC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:10:02 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B2C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:07:05 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id b17so40991540uas.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpCpfNAu4uvs+uqsE9ZA+5hcQzKnrywRgshkQDNo5cQ=;
        b=AxRaTLgqTxZ6LiBXNK05RipMd8tlj5X+Nv4sy4hMxtMxhZ30caqgBmOQk+MW5CxmCV
         t9E97Tv+PzEQfyuB/H8+ttUpa4eTv/P6cL6IYp7gmy2V+PEWYGBRLD3opRn0Cvg3u2pZ
         +b0fRA0lZV5rQoDVdF0L7rH9mbCzVSsjjtcMHo7HMdSUrDdGqnY4nbV5c5bdQ5Y0cA9r
         otQezbiIkxMw1uee7l7ZzOCi/4co4vmCg1iWA0aywlMXVY5cCOuy9Ea0jfjeRddvBGyl
         FK95EKdwOC/AjxfVLy7iTruHAgOYEjomflChO4hwFnEbhM1ttDivkFUNFJCzdsysZnmY
         xNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpCpfNAu4uvs+uqsE9ZA+5hcQzKnrywRgshkQDNo5cQ=;
        b=zsGpJnZVLSLYfqMyInryXoahvRWQbJ/vDdYdQCOpsZ3aQGPABK7a4V4TFB0a3VFJfC
         fdstwW8fPu3x4iTTBuq54B2Ty5V7II72clB+/PdrNJ1QmaS0gE9zHvbFMtb8X4arXXG3
         11pdAAwWa1Voc8tBC+Vjytr/IrV1PjkFPtblvFU0srW/wbSpfFVyrmjuoYz+Q+B4NRfc
         1Np95AIwUpElKgq9GTXh3kl/R7bO13DX8381URfoIgosOWh5n9RviRXrV7lIvH5nyUlD
         eOqOUJJ0aluWdy5exDnf0ZWCJ0ZqTWKYXn8ZfFJz5r5OGchISJKxEr+PQH0kdO6wxGlh
         rAeA==
X-Gm-Message-State: AOAM530YB7BhmxJR4v2AuJPZWHLP16Ekm1v3dk5Y1uSHqgg6h+cH3RL0
        FI4sfuIvpA5v0c3T5dEx42ZXIVBzrmbIeyUmHfZmxCcV
X-Google-Smtp-Source: ABdhPJzMIscmwQ0fUJGaXAA1WAT3aMwgWsOhpJowe8LGtRuJH3hAwqawi8tXktVCNCryRI8jNlEOlrAnVegnWyI64XM=
X-Received: by 2002:ab0:5928:: with SMTP id n37mr8670728uad.15.1637053624414;
 Tue, 16 Nov 2021 01:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com> <877dd9i1zj.fsf@igel.home>
 <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com> <87o86kv6fh.fsf@igel.home>
In-Reply-To: <87o86kv6fh.fsf@igel.home>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Nov 2021 01:06:51 -0800
Message-ID: <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 12:42 AM Andreas Schwab <schwab@linux-m68k.org> wro=
te:
>
> On Nov 15 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > What PCREv2 version are you using?
>
> 10.31
>
> https://build.opensuse.org/package/show/openSUSE:Leap:15.3:Update/pcre2

interesting; that version doesn't need the workaround because it
doesn't have MATCH_INVALID_UTF that was released with 10.34, but it
has a recently backported fix for a similar issue that might be
confusing git and it is somehow related to it.

a full log (run it with -x -i, and get the last lines) would be useful.

curious also if you see other problems using `git log --grep` and
which locale do you have configured?

Carlo
