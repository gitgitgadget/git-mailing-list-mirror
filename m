Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0401420323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965080AbdCVRwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:52:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:63802 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935675AbdCVRvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:51:19 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 09F3584651;
        Wed, 22 Mar 2017 13:51:16 -0400 (EDT)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ankostis <ankostis@gmail.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <CA+dhYEWo3v+ns0zt_hWu-7i-=E0g_tFaXYcv7Q0j2ozx1SCVmQ@mail.gmail.com>
 <alpine.DEB.2.20.1703221711180.3767@virtualbox>
Cc:     Git Mailing List <git@vger.kernel.org>, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        markbt@efaref.net, benpeart@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <024c6643-89d7-ea89-3190-003223bb3227@jeffhostetler.com>
Date:   Wed, 22 Mar 2017 13:51:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703221711180.3767@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/2017 12:21 PM, Johannes Schindelin wrote:
> Hi Kostis,
>
> On Wed, 22 Mar 2017, ankostis wrote:
>
>> On 8 March 2017 at 19:50,  <git@jeffhostetler.com> wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> [RFC] Partial Clone and Fetch
>>> =============================
>>>
>>> This is a WIP RFC for a partial clone and fetch feature wherein the
>>> client can request that the server omit various blobs from the
>>> packfile during clone and fetch.  Clients can later request omitted
>>> blobs (either from a modified upload-pack-like request to the server
>>> or via a completely independent mechanism).
>>
>> Is it foreseen the server to *decide* with partial objects to serve
>> And the cloning-client still to work ok?
>
> The foreseeable use case will be to speed up clones of insanely large
> repositories by omitting blobs that are not immediately required, and let
> the client fetch them later on demand.
>
> That is all, no additional permission model or anything. In fact, we do
> not even need to ensure that blobs are reachable in our use case, as only
> trusted parties are allowed to access the server to begin with.
>
> That does not mean, of course, that there should not be an option to limit
> access to objects that are reachable.
>
>> My case in mind is storing confidential files in Git (server)
>> that I want to publicize them to partial-cloning clients,
>> for non-repudiation, by sending out trees and commits alone
>> (or any non-sensitive blobs).
>>
>> A possible UI would be to rely on a `.gitattributes` to specify
>> which objects are to be upheld.
>>
>>
>> Apologies if I'm intruding with an unrelated feature requests.
>
> I think this is a valid use case, and Jeff's design certainly does not
> prevent future patches to that end.
>
> However, given that Jeff's use case does not require any such feature, I
> would expect the people who want those features to do the heavy lifting on
> top of his work. It is too different from the intended use case to
> reasonably ask of Jeff.

As Johannes said, all I'm proposing is a way to limit the amount of
data the client receives to help git scale to extremely large
repositories.  For example, I probably don't need 20 years of history
or the entire source tree if I'm only working in a narrow subset of
the tree.

I'm not sure how you would achieve the confidential file scenario
that you describe, but you might try to build on it and see if you
can make it work.

Jeff



