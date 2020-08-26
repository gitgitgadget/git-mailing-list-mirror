Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3956C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 06:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEAE2078D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 06:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sftkj1s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgHZGWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgHZGWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 02:22:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB694C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 23:22:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so1228561ejb.11
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bH9EW9ZkjTtV6dNyQ8QSYwdDXGnNU3l5jVNUiOhEMk=;
        b=Sftkj1s8uLCS3RdZMiY2kbTESIGj2YHwZ4d+7rlHG8zKPwr24DmGi27TcrKNMaPnzT
         PkIn+lsnOsFCq46gjFaE2MmBIgaTvaVTPocOi7Gu3V9c7zB26SLdtHZWawk6KLBsgwDP
         MgNbyagijv8X8TlsqyK1sMvFDq9xIxH/9LuBU5NqYuWu7koeEeWmox9d0T0r/Fru5A1H
         ulqaq2nHJCijdZCZHqaUvkfawGC/kIfHgnevrbwSZVM7LkQGiDgA396BcfaAyrZsDsdy
         n9Zn/NAH4Zf5cuFVgyyFa42Xpbz6IvEw5q+geJnrNgoawJB7BbPk5wtTXrB8OrcYOrbp
         T8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bH9EW9ZkjTtV6dNyQ8QSYwdDXGnNU3l5jVNUiOhEMk=;
        b=Kz7re6VYEY+vegxfMFUB9f5GnbT22Oq50okfDoqQtZLqAwWW2MzofxZItz4LXHOIsv
         fxYTAR2q+WWfQTN0LCWeVRA4Vaf+lVXOkNiQO7mTpvh/dQ8IN+uPvBWn+TTNfXZYCbki
         UsKj/I8g0HgwftGA/+QKvylGDue1zsQge13wjfQ5+DcnV3aCY7ycLHFnO7wNnyWZ5k8B
         E9hYvvg7sleZZ9fk3Qr59IdYQHbfsS53kpnFTOPGV3UCUHSBQD/zH8VddvA5gBr9KTx7
         YgCRInnGLSnbWz9DO74lYik4xDbPeRYsGbXO9PLedsrZx+TYhzzfSahGmmDwjjN7lJaV
         2GAA==
X-Gm-Message-State: AOAM5331Clg1BK2hkkbY94zFsu3mLkqsOC8/naAlMySjsbH8/Jod8kwH
        uZyFrsniryDghHKZ0U6qg4ZGzoqK9HzlAU3UXV+3d2kSz2s=
X-Google-Smtp-Source: ABdhPJz1udoKg1m30Vbp/e4SIzcXCtL55vkWmEUrphjxdeN6Vni3ip0QKjKHViu3iYRQDZHF/vQTZKSvMi77VhJAR1Q=
X-Received: by 2002:a17:906:a40d:: with SMTP id l13mr14952329ejz.283.1598422950469;
 Tue, 25 Aug 2020 23:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
 <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
 <xmqqeenz95bj.fsf@gitster.c.googlers.com> <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
 <CAPig+cScdV1ORSbqDuUiOEvCd6TYgkR=3GK8OCUu4yuoKVy5Pg@mail.gmail.com>
 <CA+CkUQ_eRqOB8Ushg-BcEmjRxEZSs7tmPnZcb8GUTwz3R55Xhg@mail.gmail.com> <CAP8UFD03Am94_84FvRPxEdt_AG74864eQ4TimggKtUYWjJYqCg@mail.gmail.com>
In-Reply-To: <CAP8UFD03Am94_84FvRPxEdt_AG74864eQ4TimggKtUYWjJYqCg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Aug 2020 08:22:19 +0200
Message-ID: <CAP8UFD0Ds816PfQFwX+1wQhpjaCHZFOF3dK76SRUzt23uS9jPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 8:18 AM Christian Couder
<christian.couder@gmail.com> wrote:

> I think we could also get rid of the "match_and_" part of the
> suggestion, in the same way as skip_prefix() is not called
> match_and_skip_prefix(). Readers can just expect that if there is no
> match the function will return 0.
>
> So maybe "extract_field_option()".

If we want to hint more that it works in the way as skip_prefix(), we
could call it "skip_field()".
