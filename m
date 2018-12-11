Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF41220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeLKCch (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:32:37 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42046 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:32:37 -0500
Received: by mail-ed1-f49.google.com with SMTP id j6so11213645edp.9
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBG01uK8iihKXEspwJIKuEFDAIYzwAkNuZIzLKb7uyE=;
        b=vallbPjpNYpXutR/MqETb23hXsftULdstLqHlkkip4dlpyyJMbxV+z5SdCbEzWNI7M
         fS8aSx89BMjZ5R+wYYxqDnSrVxoml0TVyNA1ads39oRqt/CdXD4El7x99Od0xG+0N4Lr
         D9r6H3KSHJwG3O5dneumn8KjUkYKMczRmwqCye6W1MAbyuAsFaRbZUVQ3LsNiR80ipLS
         Bz8Uh3pkP6T9wjdfja3yo7EqzoFbOPW+f7UBleW+SvomNqDOqfkub5JMAr0jDSEokQtQ
         Pg2X3uzjfikUDhlcC0v7DbG4DNpt1/Q7BH5S9fSDHPtNnnvLnetPn04zh6yVj5FL51yW
         +7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBG01uK8iihKXEspwJIKuEFDAIYzwAkNuZIzLKb7uyE=;
        b=M9/rcESM+zZaeRH/XF3uvv68WN2tf3XDR1wlxeV0IZUNw+EQmogIcsWUr9T0PQc2ga
         VVLFbHoC4v1IvtyzjbUqWayz3nHTnZe1HduzOqypvTWVyZ05ecgNzSDWJskQk2UAIdoA
         9ebKkLtZQDOi7z0KPQsgenCwm9C4lMgZLcxM+rVJ2Td72eUvMOXpw5LQafglnh+vLG0z
         Ogfc3Dum0ufrFTTSfprpnEOAsREtSisuovLAfxWccGFsEMdT+6S4bZ/ZKE2ABJRcxSFN
         Kv2/WurU9KvNyFXBdaNONyEADyATZNEweVjc3SeNbl0L7Q6aYQZVEUMmq4msuc2f3ELt
         XZdg==
X-Gm-Message-State: AA+aEWYx9hY0cIv/s6rgx/5iIiQ7BuSz0kwLZa3XpN2jseeE8nl65rZG
        omn9HcY32jxeXPUdvwdox79PpRrjxJPa9aig8QHWrg==
X-Google-Smtp-Source: AFSGD/VI/P/D7hDM/Nfk0cB44OQHCwn2vXiOLYqwmcD12sOVBu4+Jcy7j8LNY+tDhVxIdwlUhkDQzpj3R0Ddr9anlZA=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr11287992eji.106.1544495554330;
 Mon, 10 Dec 2018 18:32:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.92.git.gitgitgadget@gmail.com> <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 18:32:23 -0800
Message-ID: <CAGZ79kbPcy2U9XJA+Je0zRxFsQJGA9u8nfYZe_s75V8c97+dNw@mail.gmail.com>
Subject: Re: [PATCH 5/5] midx: implement midx_repack()
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> To repack using a multi-pack-index, first sort all pack-files by
> their modified time. Second, walk those pack-files from oldest
> to newest, adding the packs to a list if they are smaller than the
> given pack-size. Finally, collect the objects from the multi-pack-
> index that are in those packs and send them to 'git pack-objects'.

Makes sense.

With this operation we only coalesce some packfiles into a new
pack file. So to perform the "complete" repack this command
has to be run repeatedly until there is at most one packfile
left that is smaller than batch size.

Imagine the following scenario:

  There are 5 packfiles A, B, C, D, E,
  created last Monday thru Friday (A is oldest, E youngest).
  The sizes are [A=4, B=6, C=5, D=5, E=4]

  You'd issue a repack with batch size=10, such that
  A and B would be repacked into F, which is
  created today, size is less or equal than 10.

  You issue another repack tomorrow, which then would
  coalesce C and D to G, which is
  dated tomorrow, size is less or equal to 10 as well.

  You issue a third repack, which then takes E
  (as it is the oldest) and would probably find F as the
  next oldest (assuming it is less than 10), to repack
  into H.

  H is then compromised of A, B and E, and G is C+D.

In a way these repacks, always picking up the oldest,
sound like you "roll forward" objects into new packs.
As the new packs are newest (we have no packs from
the future), we'd cycle through different packs to look at
for packing on each repacking.

It is however more likely that content is more similar
on a temporal basis. (e.g. I am boldly claiming that
[ABC, DE] would take less space than [ABE, CD]
as produced above).

(The obvious solution to this hypothetical would be
to backdate the resulting pack to the youngest pack
that is input to the new pack, but I dislike fudging with
the time a file is created/touched, so let's not go there)

Would the object count make sense as input instead of
the pack date?


> While first designing a 'git multi-pack-index repack' operation, I
> started by collecting the batches based on the size of the objects
> instead of the size of the pack-files. This allows repacking a
> large pack-file that has very few referencd objects. However, this

referenced

> came at a significant cost of parsing pack-files instead of simply
> reading the multi-pack-index and getting the file information for
> the pack-files. This object-size idea could be a direction for
> future expansion in this area.

Ah, that also explains why the above idea is toast.

Would it make sense to extend or annotate the midx file
to give hints at which packs are easy to combine?

I guess such an "annotation worker" could run in a separate
thread / pool with the lowest priority as this seems like a
decent fallback for the lack of any better information how
to pick the packfiles.

Thanks,
Stefan
