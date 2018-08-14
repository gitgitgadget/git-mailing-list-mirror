Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AF2D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeHNXCv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:02:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:18332 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeHNXCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:02:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0DE363F4089;
        Tue, 14 Aug 2018 16:14:01 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A5FAA3F40B7;
        Tue, 14 Aug 2018 16:14:00 -0400 (EDT)
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>, git <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
 <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
 <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
 <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
 <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <603037bc-57a4-92a6-9c13-ae5b253d3ba3@jeffhostetler.com>
Date:   Tue, 14 Aug 2018 16:14:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/14/2018 2:44 PM, Stefan Beller wrote:
> On Tue, Aug 14, 2018 at 11:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Tue, Aug 14, 2018 at 8:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>> I'm looking at adding code to my SLOG (better name suggestions welcome)
>>> patch series to eventually replace the existing git_trace facility.
>>
>> Complement maybe. Replace, please no. I'd rather not stare at json messages.
> 
>  From the sidelines: We'd only need one logging infrastructure in place, as the
> formatting would be done as a later step? For local operations we'd certainly
> find better formatting than json, and we figured that we might end up desiring
> ProtocolBuffers[1] instead of JSon, so if it would be easy to change
> the output of
> the structured logging easily that would be great.
> 
> But AFAICT these series are all about putting the sampling points into the
> code base, so formatting would be orthogonal to it?
> 
> Stefan
> 
> [1] https://developers.google.com/protocol-buffers/
> 

Last time I checked, protocol-buffers has a C++ binding but not
a C binding.

I've not had a chance to use pbuffers, so I have to ask what advantages
would they have over JSON or some other similar self-describing format?
And/or would it be possible for you to tail the json log file and
convert it to whatever format you preferred?

It seems like the important thing is to capture structured data
(whatever the format) to disk first.

Jeff
