Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FC120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 13:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeLKNAT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 08:00:19 -0500
Received: from mail-yw1-f41.google.com ([209.85.161.41]:42933 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 08:00:18 -0500
Received: by mail-yw1-f41.google.com with SMTP id x2so5375770ywc.9
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7rRmeBlwMb2TATpFE7v8xYa6wftFhaw/uzE6KXB2tn0=;
        b=cF5AgtGpvDfKu9sOeKuVwmKs8nGQdyC9LqJ9CZ8VnBsrNpvt/d+jzvhcpVtBFCIDsb
         a+eJynyb8Hy8ukT4Zd6GijKnj6aySDruLxQ+WQZr5eSAyKd33AuVuYHFMqtqzHoRqOub
         pTQD19IPj2PlfGKUrMPZCiMo2jkdEagbl5qbHgJjQPVWvy5VWJpVjAc2x26oa3tMXTgi
         T4Kb+jWjvu9YAoS+x9UERI8aVe3iygSbOQRYvLSuz4uDuEAz74IjVqbQ7ZGt6/LEXDmT
         5QlqNPlyxmRcGokScYOmBKEIh1mkzOt2ge2cYYZBc09w/QZBbz5CsgBQK9jNK8zCYXEO
         eLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7rRmeBlwMb2TATpFE7v8xYa6wftFhaw/uzE6KXB2tn0=;
        b=Jp7IhVpfUwHhsMSlJfRWP6NgtpONlD3bqNXiAOt2Wq6wO4V1QrXmac5gAQJbjyuXy+
         ZNq9SsLzZYuVLre5ahX12iSf2MjKFzS35eSIfPR+6ynqrd5oc+4XEIqJP/RpTTgX8vwY
         ZrMqC3rXfWzwPV7823J0XeZJjogsnKt98JMkLqCa9w5k9OmEnBoU8mLIuxdeqcoXQ9wS
         tIRieis/PoEZH3sT3m/ZmgSQkdtJ9DwZ/dvSdzs3dY9RvER41GDpaRmb81jIg7YLKobB
         q5iMuUATi/4jqGiq7xvKWM+Ok3vca3ILj+/2x9CGLppCbhTYKGWw1PI/B9T19klIADcw
         iyZg==
X-Gm-Message-State: AA+aEWZH4qA1e/t164c4rXwiNw6MfZBP9eTo247bHWr7U2Yqt58JB62c
        VfPY5ulLDJBLlRgE1ZFTw1NESPsJ
X-Google-Smtp-Source: AFSGD/WmqsRvaeITuIZLuZNSz1VwDoCcE1KWadv9rfRvINBZiHGmG+gvLjFcf4nMnI+HwL3yPPatfQ==
X-Received: by 2002:a81:794e:: with SMTP id u75mr15945539ywc.133.1544533217245;
        Tue, 11 Dec 2018 05:00:17 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v191sm4731373ywc.102.2018.12.11.05.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:00:16 -0800 (PST)
Subject: Re: [PATCH 5/5] midx: implement midx_repack()
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.92.git.gitgitgadget@gmail.com>
 <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
 <CAGZ79kbPcy2U9XJA+Je0zRxFsQJGA9u8nfYZe_s75V8c97+dNw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <113b5ed8-9b25-650b-7f35-6f35bc69075b@gmail.com>
Date:   Tue, 11 Dec 2018 08:00:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbPcy2U9XJA+Je0zRxFsQJGA9u8nfYZe_s75V8c97+dNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2018 9:32 PM, Stefan Beller wrote:
> On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> To repack using a multi-pack-index, first sort all pack-files by
>> their modified time. Second, walk those pack-files from oldest
>> to newest, adding the packs to a list if they are smaller than the
>> given pack-size. Finally, collect the objects from the multi-pack-
>> index that are in those packs and send them to 'git pack-objects'.
> Makes sense.
>
> With this operation we only coalesce some packfiles into a new
> pack file. So to perform the "complete" repack this command
> has to be run repeatedly until there is at most one packfile
> left that is smaller than batch size.

Well, the batch size essentially means "If a pack-file is larger than 
<size>, then leave it be. I'm happy with packs that large." This assumes 
that the reason the pack is that large is because it was already 
combined with other packs or contains a lot of objects.

>
> Imagine the following scenario:
>
>    There are 5 packfiles A, B, C, D, E,
>    created last Monday thru Friday (A is oldest, E youngest).
>    The sizes are [A=4, B=6, C=5, D=5, E=4]
>
>    You'd issue a repack with batch size=10, such that
>    A and B would be repacked into F, which is
>    created today, size is less or equal than 10.
>
>    You issue another repack tomorrow, which then would
>    coalesce C and D to G, which is
>    dated tomorrow, size is less or equal to 10 as well.
>
>    You issue a third repack, which then takes E
>    (as it is the oldest) and would probably find F as the
>    next oldest (assuming it is less than 10), to repack
>    into H.
>
>    H is then compromised of A, B and E, and G is C+D.
>
> In a way these repacks, always picking up the oldest,
> sound like you "roll forward" objects into new packs.
> As the new packs are newest (we have no packs from
> the future), we'd cycle through different packs to look at
> for packing on each repacking.
>
> It is however more likely that content is more similar
> on a temporal basis. (e.g. I am boldly claiming that
> [ABC, DE] would take less space than [ABE, CD]
> as produced above).
>
> (The obvious solution to this hypothetical would be
> to backdate the resulting pack to the youngest pack
> that is input to the new pack, but I dislike fudging with
> the time a file is created/touched, so let's not go there)

This raises a good point about what happens when we "roll over" into the 
"repacked" packs.

I'm not claiming that this is an optimal way to save space, but is a way 
to incrementally collect small packs into slightly larger packs, all 
while not interrupting concurrent Git commands. Reducing pack count 
improves data locality, which is my goal here. In our environment, we do 
see reduced space as a benefit, even if it is not optimal.

>
> Would the object count make sense as input instead of
> the pack date?
>
>
>> While first designing a 'git multi-pack-index repack' operation, I
>> started by collecting the batches based on the size of the objects
>> instead of the size of the pack-files. This allows repacking a
>> large pack-file that has very few referencd objects. However, this
> referenced
>
>> came at a significant cost of parsing pack-files instead of simply
>> reading the multi-pack-index and getting the file information for
>> the pack-files. This object-size idea could be a direction for
>> future expansion in this area.
> Ah, that also explains why the above idea is toast.
>
> Would it make sense to extend or annotate the midx file
> to give hints at which packs are easy to combine?
>
> I guess such an "annotation worker" could run in a separate
> thread / pool with the lowest priority as this seems like a
> decent fallback for the lack of any better information how
> to pick the packfiles.

One idea I had earlier (and is in 
Documentation/technical/multi-pack-index.txt) is to have the midx track 
metadata about pack-files. We could avoid this "rollover" problem by 
tracking which packs were repacked using this mechanism. This could 
create a "pack generation" value, and we could collect a batch of packs 
that have the same generation. This does seem a bit overcomplicated for 
the potential benefit, and could waste better use of that metadata 
concept. For instance, we could use the metadata to track the 
information given by ".keep" and ".promisor" files.

Thanks,

-Stolee

