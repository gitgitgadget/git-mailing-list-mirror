Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D7C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741136135D
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhGEM1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhGEM1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:27:39 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F405C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:25:02 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j8so10054009vsd.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IxY6etMCCKqT6cWhkUscX/6fNvlH9H4opnhV0dg+3Zo=;
        b=QY39to7i7eOdBPuPUa82r2vbHr5NmwoxcyOwEDlELZqnWFuUytYvDSi5rm67vVivI3
         3HAvGEBY72p9d8Nbfs4hJ976B14nOg1QYduKzEhlDN1Vt/MInJnmdPQzjBsR+xbLDLXK
         5TfLlwQXeIaybkDZJ0k78U8AADkN9rZTD5kF8JrIaOJDRU6zVSqyq1BDpf/kF1MXn5Tq
         LCe9o8/+++H+sM1soVu6mRL9+8DXX5LtsLzdQnoxA98aZbF65aFLEm1FAx82v9sBj+ME
         85m7Uf1biJiAjshLbAiFTnJbfv067rF1kqTk0MacNCfgyXWrclBO9IKyu5gas1gbLl0E
         YY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IxY6etMCCKqT6cWhkUscX/6fNvlH9H4opnhV0dg+3Zo=;
        b=AZvqP6keiFhYXtC0k9f8tO3+1wac5pAZqTygl/USlsIu1qdZx6QqAcgfVozdvS7aiq
         cEEP/T0B3yzJ5lZ15z7YL1q3w7wYtVpMyFmn44fdxWxkWNJ3KCWHEkBSD7yXowQ7DEnQ
         eaaTLuGCQ0TH2vAYNPAtLLo+pJrG9A81fX+Uork0+0cle7EsFcSnvmmjo8IRhoHtyUUA
         FvqBXFpf5+xyhW3ApgAPqHF5yOI2f9a0Tox2B0mR6gfnNNXQ1FuQxD3WwFq+PYXdqBZ3
         GFosEW4+Kw633EXX2k6UKBJg/qljQvSy8wgzjWJOTWQp9esKZmaiPGSGazF9Ra+FVnXm
         GJeA==
X-Gm-Message-State: AOAM530epx+JyhO5ocfu++fOwOT1sAKjl3/bpr4YvmCbKb6JRL3GWhmu
        j7kB2Zjwb65yuuh5zyyO98sEmPxYuTbOxqZGfs19SQ==
X-Google-Smtp-Source: ABdhPJwrNYTlJ6pNnrpkrkMKmSb1PivtwsYqxXIZJtHSCMx5Mt9ICAfVrvLaGXgst9SdI6Oe4cMR/uxMQRMlrTczpFI=
X-Received: by 2002:a05:6102:949:: with SMTP id a9mr8603595vsi.54.1625487901570;
 Mon, 05 Jul 2021 05:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <patch-6.8-baeee6539ad-20210628T191634Z-avarab@gmail.com>
In-Reply-To: <patch-6.8-baeee6539ad-20210628T191634Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 14:24:50 +0200
Message-ID: <CAFQ2z_McVjV+DVMZJq21tBsxj2T3EZ5eFJuRWs8ozpNbJWzS1g@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] serve.c: add trace2 regions for advertise & command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 9:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Now that we've factored out "call_{advertise,command}()" in a
> preceding commit it becomes easy to trace all these callbacks with
> trace2. Let's do that. As the tests demonstrate there's no v2 push
> protocol, which the tests assert.

code looks good, but confused about the objective. This isn't
necessary for the rest of the series, is it?

cleanup changes leading up to here LGTM.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
