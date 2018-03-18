Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9449D1F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 08:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCRIXi (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 04:23:38 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:37766 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeCRIXg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 04:23:36 -0400
Received: by mail-ot0-f174.google.com with SMTP id t2-v6so5179686otj.4
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gUfmZw2i41jFVAmOTivLV2Ah+TMogKGiGtcgG6T/Ync=;
        b=QQDpg+R9FSNNBMrbWC/hxdJ1BfqWSw6ziQ0F26sxI6tPn1VOPQeaLgyh4blWG4gt81
         p7wYBYqXuwVXelqbnA/9q8KEOiqJISBxjBEw36W1QZRa89qRDHAZAVm9HPQduk/mLpWM
         UL5dgs5Xff48ifUFMvfvas7Y78DqYGpFlgZO5R96GKfZTHBDymw6bboqhmlVdvy+8hhI
         l2wHVqXa7zxMAmgjMLFNjBAvm/vqvHVyBrG3vIrquJXKiBr4G1JNAYPMniKPVSkOCAFB
         jBVWN3xLojCcIPN8bF9rVCz9qRaqkFC/frNb0TRlRFRaY6+wb48rql902AD4IjdKe06M
         G/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gUfmZw2i41jFVAmOTivLV2Ah+TMogKGiGtcgG6T/Ync=;
        b=aPj5a8SBgyP11z5rnLbSgUTqoo5HmMyTmzJH5t7wohRQDuIOhW3iCAt9f1PPX80fAS
         k3Cck9hWWvqMZgatRwusCqI3puNwtE+lisK8ozk0t+AFxOVpHE/D4JBO0SvkR+BaakkL
         iWfzFxunDIRMfMbievTd1vvoQwT4GPlX4+cbSVF+X05AX6MalgEpaKuVZ47VVlCnlUif
         P8fRHcdXI2RJDoNwuSC5jWpsDIygr8w6Zs04QCoL1hpDdyE7NO+D/fU9XsCEXmXHRN98
         Xt+cJIi3m3Cc2BsGVHM6dEaZzoYG+ZxuR2NsCTZ7UQEKbSD1O1sxQ2j0YB+IKH4h5i5G
         QKwQ==
X-Gm-Message-State: AElRT7F+8OsvIuWlenfgWqDRKuq71amVHlPHxVpDDJAfBqpIb6vUhceu
        KYOXGltvZZQK5mwJASe4kMoqC+nA3mznDPCURH0=
X-Google-Smtp-Source: AG47ELvu9nTAPL4Vxfy5IfOJQIxNhI3H3bZ+wOtNkAEyydZF6dPD2Am+AKbQJg3ltmnVItVPMFfcxdQwWbIk+RPSdFQ=
X-Received: by 2002:a9d:3698:: with SMTP id h24-v6mr5430847otc.173.1521361416366;
 Sun, 18 Mar 2018 01:23:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 01:23:05 -0700 (PDT)
In-Reply-To: <xmqq8taqx949.fsf@gitster-ct.c.googlers.com>
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com>
 <20180317141033.21545-10-pclouds@gmail.com> <xmqq8taqx949.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 09:23:05 +0100
Message-ID: <CACsJy8AXSCw1b0FpsUv85kZ_HYhHy9OHeDZGGFFg9pOno8GfNw@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] pack-objects: shrink size field in struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     uint32_t truncated_limit = (uint32_t)limit;
>> +
>> +     return limit == truncated_limit;
>> +}
>
> I am guessing that a compiler that is clever enough will make this
> function a no-op on a 32-bit arch and that is why it is a static
> inline function?

It's a separate function because I don't want to duplicate this ==
logic twice. Even if the compiler does not optimize this, it's still
much cheaper than oe_sze() which involves disk access.

>> +static inline int oe_size_less_than(const struct object_entry *e,
>> +                                 unsigned long limit)
>> +{
>> +     if (e->size_valid)
>> +             return e->size_ < limit;
>
> e->size_ is the true size so we can compare it to see if it is smaller
> than limit.
>
>> +     if (contains_in_32bits(limit))
>> +             return 1;
>
> If limit is small enough, and because e->size_valid means e->size_
> does not fit in 32-bit, we know size is larger than limit.
> Shouldn't we be returning 0 that means "no, the size is not less
> than limit" from here?

Argh!!! This logic keeps messing with my brain.
-- 
Duy
