Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069E720248
	for <e@80x24.org>; Thu,  7 Mar 2019 14:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGOvi (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 09:51:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32905 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGOvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 09:51:37 -0500
Received: by mail-io1-f66.google.com with SMTP id b6so200926iog.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RReVCHRevVc/FhsEGuVHx+6kSnZ69XTrJj2NUGSmaLs=;
        b=rXDEciMlgNkyQXWd8n19AfqJJMOV8xmxyQ9/VsIWiDhkZD5JsSZBR3EqKW/1SOdsaQ
         vivPxTYVmmGtxM9CDtA5lNJ7kOSuTaC1C3rSqvFEjtLc44ya+DjRF8b+WURt9MRAANRO
         89OFkL3uNVaSydfd3gt2hFSJZaxr6LCa+B2f2/BKYAS8SkXDYx7Ie+ddcQfdWRbek0ge
         Zlbu8Jmeor+/sOZ9R55ti4aaZR61d/8GhK6N8PuANZxjBvZkvM4louwFqBF1Cw3LaBLG
         4bKMbgrp0l2vWJSzIBJH/AVdDWJKq7Q8oyo7dqnWTzEKGplHN3pu7ZvKDzgGooE47QSg
         frRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RReVCHRevVc/FhsEGuVHx+6kSnZ69XTrJj2NUGSmaLs=;
        b=XHiytCNb/s+sJYnlt14+tgBilFVXK74/mp/Wyd2a16vAbza7SfAqNglOMOspveabzZ
         Hvnqadk9qyHMCFrDRwpI7y55/Q0ZjkPkh4LRRCQCKh3nhXfxGzOOBmQojNvmt9Y5mlw7
         uQZRIefrmlHfMuCkYox3i71Y5zbwMVWyU9ykXWnBd6McA3vyME8Dg4ryrRsNIE0EQiur
         Q+UoxeYk2ugiiupKEt0PsspRyFyjDA7a5LrSCx5Fd/YaLejzVjQKW97B9uuFlaahutiq
         Bq24ynURNevrwqPk4MoZ2P+HmXEcUOF1aCChXbbb3ZaXR9iKXpEHb4SBbrN69D8SskiL
         9+ZQ==
X-Gm-Message-State: APjAAAWW4HpsaY0YWN0Be14w2Xb2Ly8nRnmdUYTLqg+k+ozuQojg7rKm
        ai1iC6bjAH0wvMMIfwREFILFTen91+R9HyLMS9o=
X-Google-Smtp-Source: APXvYqz6hbkI/3M+T6WnV55RId+RvYyvgKWroYbE3vYr3eG5p1qr0RRPezZPULFyrDhtZEjOAFarbSNWcP/1f4iSP84=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr5609099ioo.236.1551970297025;
 Thu, 07 Mar 2019 06:51:37 -0800 (PST)
MIME-Version: 1.0
References: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
 <20190307122917.12811-1-pclouds@gmail.com> <20190307122917.12811-4-pclouds@gmail.com>
 <1e0fe5a0-decb-ccd3-19ee-5fe2e5148fb1@gmail.com>
In-Reply-To: <1e0fe5a0-decb-ccd3-19ee-5fe2e5148fb1@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Mar 2019 21:51:10 +0700
Message-ID: <CACsJy8CeBRbdKoHZ0z0f3pqHJpNJDHSCcwxDrM+p9jzYZSBpTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Make sure refs/rewritten/ is per-worktree
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 7, 2019 at 9:45 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > [1] note that ref listing still works sometimes. For example, if you
> >      have .git/worktrees/foo/refs/rewritten/bar AND the directory
> >      .git/worktrees/refs/rewritten,
>
> should that be .git/refs/rewritten? (and below)

Yes.
-- 
Duy
