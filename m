Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF4C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C1020659
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNZe230U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgBVWyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:54:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35210 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgBVWyg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 17:54:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so5464747otd.2
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNrFm3hJuc67xCJlUpEpNbbGEa32jDGxk4qEN3rrKRs=;
        b=fNZe230U9jW4RIedfIPD5tnplMtNYT+reBsRvwiwTFihUfisDRVXjlaz83Bjc0P713
         n+K6fuAkWEDZMpd9Q+iCuGUve59mOh6Ga6G2pMb3BsyDPtWDBZ7mknf3f+0fKLW8StTB
         3tedtHBMF99Xz36KlOOh9TMm5KjceN1yy4U6K5jt9bErLWlE5lSetNYgaQR51zR9HoGR
         Q5wXeb+tGQ/ZuLxXtX8R22JZSl7pJWC8FeK12k2mfrugz3Am/hd51/R+djwF6TrfGKxs
         lcEsAdgfJSdtuqJxzVqbCDrFWfv0clcUUjk+zUrH0Yxxttu+xhJkO8YmdB38AEVZ+3Pg
         YW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNrFm3hJuc67xCJlUpEpNbbGEa32jDGxk4qEN3rrKRs=;
        b=pXGo28Oj4PhcsG0RANYjU9pna0lZ/eOFhrw56jRBLmK1ss6JmFU4+OuNNyuCPNgKUm
         u9U9Iu4ITSWKq/lRDX3viW+bZgBTrE+y4bEOcAltEJiKJksrB6Ldpp84Lg4VlfYfsfLb
         DTSek9/WUuCAMWGafpz5XjOiGK1Tn7yv89iiHlMNv/+jnpH423zfI8uwp9sHRhVw0/zy
         QyHUt3mxnjQjhQ4nXA+ZStXXujWDoAbugQZQv3f78S8PXMFtIG3k+h89UfxlKRnbegkS
         zzcso0E/GhR8LRaGII2TxICdmZGar5cR7uyUKlY/njgMEQz4xBiIxu0iGDUGqLw3VaPL
         7WzA==
X-Gm-Message-State: APjAAAVHlJedg1TAL9aoxLgfXKYNAj+Mi8KVJN7/B2OensTiJ3vjFLwr
        bFT6Zur2CA3T8iBeoubKaB8u68HxS0LgtKO1gu8=
X-Google-Smtp-Source: APXvYqyImDliM6RGBxda4SuFQY9JlWm/CTKNYy6KH401F7WAIeXSOvOQ0GBYo829NOMWjgd1SQGcS3lnMiiSSnw282Y=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr36655275otq.281.1582412074183;
 Sat, 22 Feb 2020 14:54:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
 <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
 <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2002141252050.46@tvgsbejvaqbjf.bet>
 <xmqqpnehp5x4.fsf@gitster-ct.c.googlers.com> <CA+CkUQ-PERGy8xJ-a=5kzbN+N9f4uVQ35Hc4Aob70gJGz++fKQ@mail.gmail.com>
 <xmqqo8tym6sr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8tym6sr.fsf@gitster-ct.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 23 Feb 2020 04:24:23 +0530
Message-ID: <CA+CkUQ8SrmvFJF_Wn-E-49W2Gi8p0qxVr99SgTWyFfA0t6iJaA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 5:19 AM Junio C Hamano <gitster@pobox.com> wrote:
> What I suggested was somewhat different, though.
>
>   1) get_main_worktree() fix you have as [1/3] in the current round.
>
>   2) fix `.denyCurrentBranch` for unborn branches in the primary
>      worktree, new tests for the cases I outlined in the message you
>      are responding to, and adjusting the test (i.e. what you have
>      as [2/3] in the current round).
>
>   3) fix `.denyCurrentBranch` to pay attention to HEAD of not just
>      the primary worktree but of all the worktrees, and add tests.

I doubt that it's possible to solve these 2 issues separately.
As dscho said: "a fix for one bug would be a fix for the other, and
(probably) vice versa."

As I discussed with dscho, the best possible solution for this
situation is to demonstrate the bug and fix it in succeeding commit.

I have sent this v2[1] for this patch.

Thanks,
Hariom

[1]: https://lore.kernel.org/git/pull.535.v2.git.1582410908.gitgitgadget@gmail.com/
