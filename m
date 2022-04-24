Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88823C433EF
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 01:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiDXCAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiDXCAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 22:00:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9736E00
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 18:57:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u7so3984568plg.13
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfGSIUviAxb4QuihZrNgsxbBcXkbpAuWPZT7a6K1eRM=;
        b=LRwmBTt9sewjsOJTZy7JRg2yTUzmHuw63RAD3uYzT+zm7Q+FsIO8esL8Db6BTsps84
         OfqGOD7VdThJv49cCTdcfuOVUipglpTgeKnah/zRThBfciv5CkJ16kANjI/HJoVJEskw
         cYx275BAcmnqhQfX4/h/ty2XGWuwFMjbqUlmwxf8QjfxCeqV970Wb6sw7IKKtEn1XDum
         zzAg69xfOObPHBQgk1QNYl8DYyruEf+eojs6wlNEbcnjajXp1cCfvjew+/BTME7JIGPx
         Qr1WdnqMWLgyZyChSs3pKfTWjt5R7PSDN8RDmGx1T1St3W2qrXC2vgh4rQuKaipAiDGH
         Tzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfGSIUviAxb4QuihZrNgsxbBcXkbpAuWPZT7a6K1eRM=;
        b=xzZ/XCXsbdhQ9KkDsW3ipWZ66nOM+ZxnPUL9i5MpxFFOl6XWpxHlup7iWy0xmiYjH8
         VZ9izmB0AS011NS1RS6zFYjHuhplwe9D8lnMoJUPMzRQLbX9hJArNlMaN67BM9Ru7bo4
         jD+0fzBpgfSzsRYHhw6OB6m+tGckFJopgVXl7leXcTUk3D0j+L+3JvUevIJ8I6QQstO+
         wvExQybo9EAPrn2aWkpzL6kAlMTm5aCNgMho7oxF6RTsfSx5IbFiPRhnPVd7fofL5aES
         Mo5VhU6DxyRaesyqn9+q1Sm+75j9IXJv0eA7FFJXjIRLi/NGgQuhYyUmO9a7MZoaCXsM
         Y52w==
X-Gm-Message-State: AOAM531hYVzs6z9/sJZphFjyqkrAW/qBTHkN+fDnpSPJfrhUTDJYKLKj
        AC/dA1TADyyrLzLbxFaOR0rfwypaGeQvEnLsKCs=
X-Google-Smtp-Source: ABdhPJwU35rT/zgYnZAgPhxnGfU9+HSNZ1+I2xk3p4hDYpJDRwgX+OVWnL8rhwuPOYzlgKUgNXjHxs9zTiW3pQNizwM=
X-Received: by 2002:a17:90b:350d:b0:1d2:69f4:b626 with SMTP id
 ls13-20020a17090b350d00b001d269f4b626mr24026837pjb.175.1650765469024; Sat, 23
 Apr 2022 18:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
 <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com> <xmqq8rrzr6dp.fsf@gitster.g>
In-Reply-To: <xmqq8rrzr6dp.fsf@gitster.g>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 23 Apr 2022 18:57:37 -0700
Message-ID: <CAPx1GvdhWR2ZxcN1xsJSoX0BOqs0yp_+QXJ8+Y4asFY+2jrakw@mail.gmail.com>
Subject: Re: help request: unable to merge UTF-16-LE "text" file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Kevin Long <kevinlong206@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 10:27 AM Junio C Hamano <gitster@pobox.com> wrote:
> For that to work, it is likely that you'd need to convert not just
> the tips of two branches getting merged, but also the merge base
> commit, so that all three trees involved in the 3-way merge are in
> the same text encoding.

The old merge-recursive has `-X renormalize` that I believe would
do this for you. (I see code in merge-ort for this as well, but have no
handy means to test it myself.)

Chris
