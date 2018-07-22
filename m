Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A001F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGVKTx (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:19:53 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:39653 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeGVKTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:19:53 -0400
Received: by mail-it0-f48.google.com with SMTP id g141-v6so17508195ita.4
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKiYBY0+dA6s5yKk0tHllvL5oI3Jvq8WjldaXrysKmo=;
        b=B0cu+jHwyRWvYm9AgdKBcpcyaQGSJqaRLg9e6Xfso6BijTw1KjRviokSRveMCi5CZR
         crNIOGHJCmzeHw9uo3/3q7ak69XisGlLf23O16t/wXGAty89cN/05YoqKQcyhYudBdc6
         Y+1+DtBQYK4wo5QlRNYD2rdl0IXQ8C2IHltxS8HduzyZgCAe/4TM/XURmdFdf1Yy/8LK
         HycYKevFUR6EiZkAlILJSyGyPvCm1TgmIc7KfcjfouvQTVJA289DGOduWN+7iSSqxV9A
         i0HpVlwX7+t6i5H6hJhS6fUfz49i5yCrDpH/Il9RQpIENDJeKLrhdyxYKXOA7PChdlmN
         mV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKiYBY0+dA6s5yKk0tHllvL5oI3Jvq8WjldaXrysKmo=;
        b=RzRofi2thajU8XxRRZL6eruH8PyPm5wCk1Y46gRaq54PhCBQuhgoDmB+m0+LosHxu3
         Ynjf9jeSIzck1zAAvPTH+37AeqvzLgLegxiTBu3TbKO2SHL+a6vifO04nID8ZOVLV/4s
         p2ThnTGKt7oB4HB0MXF6N6InD4EKgTjc/JM+4ISvAfuJiYL1dj8UFNulN+pZoqNIW2B/
         k/FrcTKcGh1TI8MBl40oPfndV1D8Iy8+TcenJ+sDZFl9IUDWRqwRnX177GoiIIeKAGY1
         OFY7XOQQCj4zQDt+XFn1LEGCLtP9fzzkRNiQrbpz4eET2n9ICkLb3bvXQZw0ZNyrWjfC
         1kbQ==
X-Gm-Message-State: AOUpUlGP7tl3UWC4X7HnpR7S6EWqkVfGgfQVxw+Z/5XWazkVadmZyhhp
        o5yZCUEqcUn7rjg+xWfiJ9zuRQGDrHm3a0nsWQ8=
X-Google-Smtp-Source: AAOMgpcaw8c52n9d0uz9EU2BUZnfAXLPbd1PuI5rcYvoqQiytFdd2NGxWVsYoX9Bt2U91NtmnOzpEEV1apWa+D1D3o4=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr7776599jam.61.1532251429336;
 Sun, 22 Jul 2018 02:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180628135932.225288-1-jamill@microsoft.com> <20180702193745.8940-1-jamill@microsoft.com>
 <20180702193745.8940-4-jamill@microsoft.com>
In-Reply-To: <20180702193745.8940-4-jamill@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 11:23:23 +0200
Message-ID: <CACsJy8DfK=QaNsYRNBH8r0JJERAK0ppn4v6jZK03T22VfZA9Aw@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] block alloc: add lifecycle APIs for cache_entry structs
To:     Jameson Miller <jamill@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 9:49 PM Jameson Miller <jamill@microsoft.com> wrote:
> +struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
> +                                              const char *path, int stage)
> +{
> +       struct cache_entry *ce;
> +       int len;
> +
> +       if (!verify_path(path, mode)) {
> +               error("Invalid path '%s'", path);

Please wrap all new user-visible strings in _().

> +               return NULL;
> +       }
-- 
Duy
