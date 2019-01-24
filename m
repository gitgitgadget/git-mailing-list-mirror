Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106941F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXIdg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:33:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55877 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfAXIdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:33:36 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so3633305ith.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GT+0W29JRwxRRjVujKx2gl+YoTtMjQCQV2GBtFkwu/w=;
        b=DVLVfp0fxfo3Vs6PDNNsbcjtBUp9ZDuTz5+zaYlfgh8XLgwgzsTNKX3lLvUI88bDmD
         tFy9Cdv1TcRNPBLWl/8cnR3ZIVgVsiYSN763dGK66sUvfgXsiSkzRwuFSPglgSbiPPWY
         3omYUYVfZiCp8KyLv6b+dE+7CaYM0iZ8d+4XFVcNUJhlXFKgmou7t72UB9VNTvRBN4eK
         2Rx5qwxrTMzhJ+m3vzbfm7I6MH2uOJOQNuYxVIrfE1UcXrPr2wZq/GEv8gmnMQBppTGZ
         NLyHhrwh3qlL4b6YCZAnwO94GQYx14aevAYZYsEHhha/nDzvC8Asvo8FGyLTsePWdsQn
         sgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GT+0W29JRwxRRjVujKx2gl+YoTtMjQCQV2GBtFkwu/w=;
        b=nRNoGzQ5GOefxIMnYODPx+qGC12wRnjJ0oU6qa0TYXs7p31mBR1vTY7Jwid1uoAmuM
         NpXHs+nL1bTACUOFNdiRViwVz4YmfT1hzK6/OdBidPv+UooZD+0NA44XCS0xbMyaZ2um
         d3P+XJ3Bo/PmcGfPAuT9sUp64qegr1xxJJ+CY5XuSd56zM/3zmEDFl0WeDVqkjiPNQ75
         zjZl3vdKO28nI139C6V/b+H2J5ERveVWOWaIIvj2JNSLNh5e1JSkvkmPgs4mw1xMCmNU
         r4U9su/YQze4WvbM0T8G5fd1txrDxvBIsraRz7Ohfvn/ZtUio9pp9SkBc/ilZfUnehcq
         YiOA==
X-Gm-Message-State: AJcUukcBUX2sNxtAwO1UIdaO5k93axRkh1MmSjt9pPoT/7FIIGxCjAtc
        Rh1fosWasHRwnl4buSBpcJweS5+uFVV3R6DscCn5Vx3U
X-Google-Smtp-Source: ALg8bN7YtbwfGeBJt4aNfG9MgJy32emssaMdXrQft4QIkmOHUe/ff0J2wzP7dsd2MNS5h09hNvP0scOKTqVLmJwtu2k=
X-Received: by 2002:a24:4606:: with SMTP id j6mr725710itb.10.1548318815991;
 Thu, 24 Jan 2019 00:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20190124010521.28452-1-phogg@novamoon.net> <20190124010521.28452-2-phogg@novamoon.net>
In-Reply-To: <20190124010521.28452-2-phogg@novamoon.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 24 Jan 2019 15:33:09 +0700
Message-ID: <CACsJy8BDn-WBci72-DaAmc=SJsDnaiiN_rW+Yjb-1G1KFH7eCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pack-objects: merge read_lock and lock in
 packing_data struct
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 8:06 AM Patrick Hogg <phogg@novamoon.net> wrote:
> diff --git a/pack-objects.h b/pack-objects.h
> index 0a038e3bc..dc869f26c 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -146,7 +146,6 @@ struct packing_data {
>         struct packed_git **in_pack;
>
>         pthread_mutex_t lock;
> -       pthread_mutex_t read_lock;

"lock" without any comments in this struct, to me, implies that it
protects access to this struct alone. But since you're using it as
"read lock" (aka access to object database), I think you should add a
comment here clarify the new role of "lock" variable.
-- 
Duy
