Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278A41F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971170AbeCSULA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:11:00 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50568 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966634AbeCSUKw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:10:52 -0400
Received: by mail-wm0-f49.google.com with SMTP id f19so4871459wmc.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ip2hGYcQbI7b4qYHlYeJ+63vFEs+0uRHxh5yOoRXwzM=;
        b=dYmpihJikkbmuXfPrMwbDpJZdu0PYDVRY5TGtYb0Jnp5XaTbsuVUrjGQxuu45SZgru
         Pk3GMkuPWAAWYBISxkjWVHrUP0G+eg41YJ/IkNjJ12oCq0vpnvAkHqkRDRgvoGOQJwPl
         F17gFhwxKMnUwuYan/QmttdOh0zy/DtOBH3OYYfJGBoT8UYH1Iy/oqL50uo6HVT9Dmht
         i17ujeZEGUJomS1MYbvxE724vUO+xd/YTF5XUM6ih7hEwwxYMEkAT6DXUH8NLEhzh9Zk
         rc1aD6Y9NWe6Kbc2i6Cj6XDDjeZ4GqvpzDRkccR40xGEInHU2bOtXUOXS22VJMWJuUqV
         UlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ip2hGYcQbI7b4qYHlYeJ+63vFEs+0uRHxh5yOoRXwzM=;
        b=ZZFy9bvR1hDfo/9LFnN2cGAMDTdbaCINbkxcKk7K2tmSAdsY1RxSNhaZ1Ku7agr5r4
         bSgV+Vd7umWLzHoVldla7QWBRLUsXihUQJzaZmgW4N09WonB+8YyGMDNx136iEOtw/x1
         af3o7/JpYrnB8nUm0Y/ZP0bn3jOvI4S6lJ5lzHIVOQXQaSF1g93X2cjpkryGJ8sg/4mq
         B7+uGO3jK422wiQYd2dvJhX/ffz2Cs6MV52O5EIUSyRylpEDnebP6bdmzLGSwbTpfVkz
         e/MnmM43V1BPxRPn9rsiM1FSsfv8WgH3J1QdTGYYHR/zBfGyk0H8vWaubpoX888HNdyi
         i7QQ==
X-Gm-Message-State: AElRT7Ekb9PR0Kkvu1hL1VJ4fBr0Bq4IHoyxhVA2YcJNytegp6/KnI8N
        3xtqhJ+5DOMAfqTVHZVmNA8=
X-Google-Smtp-Source: AG47ELvIL4Fd+dwapCk+ltUtRtchuh9kOLMpJ6v/46TTEJd338wYxVSFVKA3ZPsSXiQpct++/W+Z/w==
X-Received: by 10.28.10.210 with SMTP id 201mr30434wmk.115.1521490250444;
        Mon, 19 Mar 2018 13:10:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m191sm11112wma.21.2018.03.19.13.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 13:10:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180318142526.9378-10-pclouds@gmail.com>
        <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
        <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
Date:   Mon, 19 Mar 2018 13:10:49 -0700
In-Reply-To: <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 19 Mar 2018 19:45:04 +0100")
Message-ID: <xmqqy3inu8qe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> There is a difference. For sizes smaller than 2^32, whatever you
> pass to oe_set_size() will be returned by oe_size(),
> consistently. It does not matter if this size is "good" .... If
> it's different, oe_size() will return something else other than
> oe_set_size() is given.

OK, fair enough.

> ... I was trying to exercise this
> code the other day by reducing size_ field down to 4 bits, and a
> couple tests broke but I still don't understand how.

Off by one?  Two or more copies of the same objects available whose
oe_size() are different?

