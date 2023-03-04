Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF5C64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 11:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCDLrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 06:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDLrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 06:47:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578F31C7F8
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 03:47:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i10so5359145plr.9
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 03:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2S+denS+oSE2qrobX+zhb4KrhMCe/ze6Akjg+BgcEw=;
        b=N9QuapvknUN8SgzipoQSCJkaYAy73Im1wr5TvPHE84sZzPuD/FfWZLFKtVyOztgZ4p
         Nq3pehjVSFk3kT0JpRLCC5YCXknlshqVQ5Aqx6olXCRzH19KRXpCKLsxL5Cc5Ogiv34H
         kn8vV/cZgIq89hm8DSOs61NUCkp62m3xN65mNgg63sMJ2EFi81mgw1tNo2aDmhh76pbY
         rme7uhyoFgXsh6rI8VGIKmbw3x4dDrRUgDLvvT3ZU3zZpvlvqm+MTPzzgcpvzEhgPmux
         ZWpjNggKFaH+xOfjVHsyS/nWIdGcpFmWoXPT/QxMG4dOKsY3AaBJ9AlDww2FN9QKx+Jj
         Cf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2S+denS+oSE2qrobX+zhb4KrhMCe/ze6Akjg+BgcEw=;
        b=ZktbO94DsZydufbUFh7Tt+/TLokP0+OEWY9KOzLoR5m38BrOYGuYsdnu0NuBU457rW
         LJhoZ7lm68BJAxHieISxIZwR9LNIgadnqf9W2QyPKKlmtb+68Do/Nm7DQtKJADNndYGu
         bxLuroUhJs32pv1m/s8xpMuhIChp3X3iLlAQKCR/2kaJmUnXpDTcy/sOhtH2JvrRrR5Z
         BG+dl25PGc0KAuCMJA1Vyv3nMA4Cyg7V7Mxiv3PFEy+JBM5Rk9V6jWcJ3gRu4rjRVc4O
         TfK4k11to3umbO8HxGHKFI8YPH56KM7+SCc7RdHOF3FWQFgfXpVJfomgt1aytojiYR11
         wXQQ==
X-Gm-Message-State: AO0yUKWqLlJZgGtKUIcPcMm4VT4uLW5DuqlsjXIPtIHHNknf7sljG2Aa
        pJQOWtd8JGJO/CrD7no9bzGcKyUNKgn3xYzz+1cDNuEk
X-Google-Smtp-Source: AK7set/IrzfvJRfvqnyMC1XPXdQhg+L6c5uo0kYE+8k/pumbKhJddBiA3Djr60CsQVTEzlHEZSrFk7jZG6p8UUPdoGs=
X-Received: by 2002:a17:90a:4f4c:b0:237:203f:1b76 with SMTP id
 w12-20020a17090a4f4c00b00237203f1b76mr1698796pjl.2.1677930436783; Sat, 04 Mar
 2023 03:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20230303145311.513960-1-eantoranz@gmail.com> <xmqqcz5phjgz.fsf@gitster.g>
 <CAOc6etb9pCXx9S5jxk8Yex++_iai21THU74qdXmOm1XxjHx8Lw@mail.gmail.com>
In-Reply-To: <CAOc6etb9pCXx9S5jxk8Yex++_iai21THU74qdXmOm1XxjHx8Lw@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 4 Mar 2023 12:47:04 +0100
Message-ID: <CAOc6etaCz=JWPnk2Jv8KYG02xBN+jZG1EfbnwtKnq_A0UBUpEg@mail.gmail.com>
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 12:45=E2=80=AFPM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> Usercase can be at the moment trying to rebase (with merges) on top of
> an exact base copy. In cases like this, git just crashes on merge
> commits. An easy example:

I should have said _crashes on merge commits where there was a conflict_.
