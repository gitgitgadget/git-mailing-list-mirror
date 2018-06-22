Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65C01F516
	for <e@80x24.org>; Fri, 22 Jun 2018 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933895AbeFVSZb (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 14:25:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46928 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933691AbeFVSZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 14:25:29 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so6726134qtm.13
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GXHhUBgY2hPc/CAMOzprW4p4MpoDN+kI4INA+ilRA+U=;
        b=aSJCRBzo0XMC6dHKp8fFrfkV/NAmSs+5hB7RWjKdhoy+hSa2eqUnTlyABGkorIf2z5
         48rbHTxKbrT7jKm5Xxb4w3ZrLyHAYuluACGWuJabbxOxBkwC9Kdx4ulzYnSTADCGLGyg
         Z4aAqY9foyxBYuG6Vwq3m0/4Vilza540VF7nAAFxfiFgKYnahvTom0OHZkzKnbI5gCkn
         HMXrJxTFBVOgsmsO5LyzfNr52/ZP1FKbXWNWvyqhqElhf0Fy7dP2mo4URvkdIGzSudBV
         hWsKYU7Ofi39DXbmaRVGMKLGsJMp0WTaF2kN+FsePOTBfnhllBAbM4x8MjtCV4AOM4Ke
         HM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GXHhUBgY2hPc/CAMOzprW4p4MpoDN+kI4INA+ilRA+U=;
        b=h/xnf9hF6XmPbOMtgiZ/mmNK0uLqTNBq6kwieO6BB+x4QI5cla5z08B4nfAm68ngGv
         7KVnsAuH6zmkrilSESa75Fn29YQM7NxpgnJqT+TgDmvBnJzXdYT/Ie1H8UExkwA0JXNf
         3vugYv/Ks5SiMzH98w8bCtK3KFRVcTbgb/2OTPehV4Clt6hj1yFxdawstGpv8/CMRwCU
         cOmm7MvJ5W+MCUHKQHbP65pRHU3/EGrf/sK2eteZGdTqS5SPQ/f7bUFbMdX/3Dgh3giL
         t8lAALPU9TV+7OXDLH+TcQr02A/PSR9y2/agtGhZ2i3eauPNz8NWBfI3/JpA2/y6hqFa
         FaIw==
X-Gm-Message-State: APt69E1sqZDEKWjr6s1SQIsThVeHs2oBKjzH/Q/JxzqkFfsyWG5CulQ0
        YnsTh/ujHlPM0XQ/GqdgTOs=
X-Google-Smtp-Source: AAOMgpcqdmRBL0RBc7Eo27Rm6O8DiwNmmMpfeNGIWVukbbOljCGu4kdkc4ZAZsBqQkVSAx/NRDx9Qg==
X-Received: by 2002:ac8:30c9:: with SMTP id w9-v6mr2314151qta.160.1529691928868;
        Fri, 22 Jun 2018 11:25:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id c62-v6sm5531840qke.64.2018.06.22.11.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:25:27 -0700 (PDT)
Subject: Re: [PATCH 09/23] midx: write pack names in chunk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-10-dstolee@microsoft.com>
 <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
 <4082c785-9fb2-7b15-b646-3c658b54abbe@gmail.com>
 <xmqqfu1gt4ye.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08667213-02fa-6104-d8de-20ee92b6bdce@gmail.com>
Date:   Fri, 22 Jun 2018 14:25:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu1gt4ye.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2018 1:38 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 6/7/2018 2:26 PM, Duy Nguyen wrote:
>>> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>>>> @@ -74,6 +80,31 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>>>           m->num_chunks = *(m->data + 6);
>>>>           m->num_packs = get_be32(m->data + 8);
>>>>
>>>> +       for (i = 0; i < m->num_chunks; i++) {
>>>> +               uint32_t chunk_id = get_be32(m->data + 12 + MIDX_CHUNKLOOKUP_WIDTH * i);
>>>> +               uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);
>>> Would be good to reduce magic numbers like 12 and 16, I think you have
>>> some header length constants for those already.
>>>
>>>> +               switch (chunk_id) {
>>>> +                       case MIDX_CHUNKID_PACKNAMES:
>>>> +                               m->chunk_pack_names = m->data + chunk_offset;
>>>> +                               break;
> (style: aren't these case arms indented one level too deep)?
>
>>>> +                       case 0:
>>>> +                               die("terminating MIDX chunk id appears earlier than expected");
>>> _()
>> This die() and others like it are not marked for translation on
>> purpose, as they should never be seen by an end-user.
> Should never be seen because it indicates a software bug, in which
> case this should be BUG() instead of die()?
>
> Or did we just find a file corruption on the filesystem?  If so,
> then the error is end-user facing and should tell the user something
> that hints what is going on in the language the user understands, I
> would guess.
>
>>>> +                       default:
>>>> +                               /*
>>>> +                                * Do nothing on unrecognized chunks, allowing future
>>>> +                                * extensions to add optional chunks.
>>>> +                                */
>>> I wrote about the chunk term reminding me of PNG format then deleted
>>> it. But it may help to do similar to PNG here. The first letter can
>>> let us know if the chunk is optional and can be safely ignored. E.g.
>>> uppercase first letter cannot be ignored, lowercase go wild.
>> That's an interesting way to think about it. That way you could add a
>> new "required" chunk and earlier versions could die() realizing they
>> don't know how to parse that required chunk.
> That is how the index extension sections work and may be a good
> example to follow.

The index extension documentation doesn't appear to be clear about which 
extensions are optional or required, but it seems the split-index is the 
only "required" one and uses lowercase for its extension id.

Since the multi-pack-index has similar structure to the commit-graph 
file, and that file includes an optional chunk with no special casing of 
the chunk id, I think we should stick with the existing model: chunks 
that are added later are optional and if Git _must_ understand it, then 
we increment the version number. Hence, for each version number there is 
a fixed list of required chunks, but an extendible list of optional chunks.

Thanks,
-Stolee
