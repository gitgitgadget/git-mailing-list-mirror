Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56FF1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 10:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeHENCE (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 09:02:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38730 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHENCE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 09:02:04 -0400
Received: by mail-yb0-f193.google.com with SMTP id d18-v6so342050ybq.5
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 03:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAv2IDpf80mfe+HQJfWsJSIuga422Qd2Iu2lU16ukJM=;
        b=eM0yPQtIuMSi0zrpY/IsZkgi3SR79evYdxGjUE6adpFaopt94jhCWBdxVjf3cPv/11
         kDnHE+5qNiJbT1jEa6spWn7mtuXrFZWe6620VFLokG0ctyl4OWBnYVe2liWGk8YeCRCE
         tgCg51RXFMNfRKztQDxJCRmKk8R3aeE2KyRvQYKbcS/Rcd4iikFNKoyyPv8MWOMYwrYN
         PQya+tiRKy8OrA9h7xjE5HqG4zsaMCgkF0LZdOo5zuFW2wic3Y0MgfMaJslx6r3dUwHe
         HiDdHqqrxcWtcTxgt2aTa2Q2aHPlmL9pxFYURpa0b5zBz32acoirLfWXpRl6IMdEZiS4
         WfiQ==
X-Gm-Message-State: AOUpUlF0FsxHvoit1UbQ/aoVnJCE6PiRoI9hpy/Hd180H+wtsDKNWgqX
        VgNAIhy4E7g3hmfW1PfiE7iSIoBsD/zaX1ZHB6IvxBLf
X-Google-Smtp-Source: AAOMgpfRmC2LYDwXcW023CMn0DFAjizCZ/wXK3Mv2tQzp8f9RCdEAllcENzvNigw8M2rQwP8GBLPU/GtQ7M6FHrk234=
X-Received: by 2002:a25:2d28:: with SMTP id t40-v6mr4465244ybt.497.1533466673720;
 Sun, 05 Aug 2018 03:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com> <7f92d92154143127734a638e41e064adce46a2e2.1533421100.git.gitgitgadget@gmail.com>
 <CAPig+cRWcFVbA76_HT2iVD16bsUmbWdCgk_07rmiGneM5czdOQ@mail.gmail.com>
In-Reply-To: <CAPig+cRWcFVbA76_HT2iVD16bsUmbWdCgk_07rmiGneM5czdOQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 06:57:42 -0400
Message-ID: <CAPig+cSon7opZ-pOZT-6O31upD5pRGhaz7-1xDuT6R5VrL54ng@mail.gmail.com>
Subject: Re: [PATCH 2/4] line-log: adjust start/end of ranges individually
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 5, 2018 at 6:14 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Having said that, a much easier fix is to use
> range_set_append_unsafe() here, and then at the bottom of the loop,
> invoke 'sort_and_merge_range_set(out)' to restore range-set invariants

By "bottom", I meant "outside" or "after":

    ...and then invoke sort_and_merge_range_set()
    after the loop to restore range-set invariants.
